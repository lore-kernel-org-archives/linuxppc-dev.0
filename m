Return-Path: <bgat@billgatliff.com>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id C2C66B6F0A
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Dec 2009 06:40:29 +1100 (EST)
Received: by gxk28 with SMTP id 28so5290359gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Dec 2009 11:40:27 -0800 (PST)
Message-ID: <4B2FCF40.3050204@billgatliff.com>
Date: Mon, 21 Dec 2009 13:40:48 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Linux/PPC Development <linuxppc-dev@ozlabs.org>
Subject: Trouble specifying dts gpio-leds with GPIO expander chip
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guys:


I'm trying to come up with the right stuff for my dts file to assign a
Linux "heartbeat" trigger to an I2C GPIO expansion device (MAX7314). 
I'm running on a platform that is very similar to the lite5200b, with
linux-2.6.32.  I'm a bit new to the device tree concept, having come
most recently from an ARM world, so please be gentle...  :)

I have this so far:

        soc5200@f0000000 {
            #address-cells = <1>;
            #size-cells = <1>;
            compatible = "fsl,mpc5200b-immr","simple-bus";
            ranges = <0 0xf0000000 0x0000c000>;
            reg = <0xf0000000 0x00000100>;
            bus-frequency = <0>;        // from bootloader
            system-frequency = <0>;        // from bootloader
    ...
            i2c@3d40 {
                #address-cells = <1>;
                #size-cells = <0>;
                compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
                reg = <0x3d40 0x40>;
                interrupts = <2 16 0>;
   
                lext20: max7314@20 {
                       #gpio-cells = <2>;
                       compatible = "maxim,max7314","phillips,pca953x";
                       reg = <0x20>;
                       linux,phandle = <0x20>;
                       gpio-controller;
                };
                ...
            };
        };
    ...
        system {
            compatible = "simple-bus";
   
            gpio-leds {
                compatible = "gpio-leds";
   
                heartbeat {
                    gpios = <&lext20 3 0>;
                    linux,default-trigger = "heartbeat";
                };
            };
        };
    ...


The MAX7314 chip is showing up under /debug/gpio:

    # cat /debug/gpio
    ...
    GPIOs 198-213, i2c/1-0020, max7314, can sleep:

And, indeed, I can twiddle the LED by hand:

    # echo 201 > /sys/class/gpio/export
    # while true; do for led in high low; \
        do echo $led > /sys/class/gpio/gpio201/direction; \
        sleep 1; done; done
       (observe blinking)

But I see this at boot:

    Skipping unavailable LED gpio -19 (heartbeat)

That error code is -ENODEV.  I double-checked that gpio-leds is showing
up on of_platform:

    # ls /sys/bus/of_platform/devices/
    ...
    gpio-leds.2
    ...


I'm stumped.  Could it be that the startup code is trying to register
the heartbeat device before it has registered the MAX7314, so it doesn't
know yet that the GPIO line exists?

Anyone have any suggestions?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
