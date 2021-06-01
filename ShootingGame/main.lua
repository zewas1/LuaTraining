function love.load()
    target =  {}
    target.x = 300
    target.y = 300
    target.radius = 50
    target.centerRadius = 25

    score = 0
    timer = 0
    gameState = 1

    gameFont = love.graphics.newFont(40)

    sprites = {}
    sprites.sky = love.graphics.newImage('sprites/sky.png')
    sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')
    sprites.target = love.graphics.newImage('sprites/target.png')

    love.mouse.setVisible(false)
end

function love.update(dt)
    if timer > 0 and gameState == 2 then
        timer = timer - dt
    end
    if timer < 0 then
        timer = 0
        gameState = 1
    end
end

function love.draw()
    love.graphics.draw(sprites.sky,0,0)

    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 5, 5)
    love.graphics.print("Timer: " .. math.ceil(timer), 300, 5)

    if gameState == 1 then
        love.graphics.printf("Click to start the game!", 0, 250, love.graphics.getWidth(), "center")
    end

    if gameState == 2 then
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
        love.graphics.draw(sprites.crosshairs, love.mouse.getX()-20, love.mouse.getY()-20)
end

function love.mousepressed(x, y, button, istouch, presses)
    local mouseToTarget = distanceBetween(x, y, target.x, target.y)
    local mouseToCenter = distanceToCenter(x, y, target.x, target.y)
    if button == 1 and mouseToTarget < target.radius and gameState == 2 then
        score = score + 1
        if mouseToCenter < target.radius then
            score = score + 1
        end
        target.x = math.random(target.radius,love.graphics.getWidth()-target.radius) 
        target.y = math.random(target.radius,love.graphics.getHeight()-target.radius)
    end
    
    if button == 1 and gameState == 1 then
        gameState = 2
        timer = 10
        score = 0
    end
end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2-x1)^2 + (y2-y1)^2)
end

function distanceToCenter(x1, y1, x2, y2)
    return math.sqrt(((x2-target.centerRadius)-x1)^2 + ((y2-target.centerRadius)-y1)^2)
end