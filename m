Return-Path: <nst@gersys.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 785E0DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 22:42:59 +1000 (EST)
Message-ID: <4A266FB2.2040902@gersys.de>
Date: Wed, 03 Jun 2009 14:42:26 +0200
From: Stefan Strobl <nst@gersys.de>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: MPC52xx simple GPIO support
References: <4A255B21.8040002@gersys.de>
	<20090602171527.GA8745@oksana.dev.rtsoft.ru>
In-Reply-To: <20090602171527.GA8745@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> Hi Stefan,
> 
> On Tue, Jun 02, 2009 at 07:02:25PM +0200, Stefan Strobl wrote:
>> Hi
>> I still don't quite understand how to use the Flattened Device Tree /
>> Open Firmware. I see there's a driver (mpc52xx_gpt.c) that supports to
>> use the Pins on the GPT as simple GPIOs.
>>
>> I can see the appropriate entries in sysfs
>> (/sys/devices/f0000000.soc5200/f0000620.timer), but how can I actually
>> use these GPIO's now?
> 
> For in-kernel usage example you can take a look at:
> arch/powerpc/boot/dts/mpc836x_rdk.dts (upm node, notice gpios = <>)
> drivers/mtd/nand/fsl_upm.c (of_get_gpio() then gpio_request()).
> 
> For userland usage you need to enable CONFIG_GPIO_SYSFS, and then
> look into /sys/class/gpio/{gpiochip,export,gpioNNN}.
> 

Thanks. With CONFIG_GPIO_SYSFS I can see the gpios as you mentioned, but
cannot change its state there.

I've now also added CONFIG_LEDS_GPIO and was able to connect the GPIOs
to LEDs like this:

gpt2: timer@620 {
	compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
	reg = <0x620 0x10>;
	interrupts = <1 11 0>;
	gpio-controller;
	#gpio-cells = <2>;
};

leds {
	compatible = "gpio-leds";
	dbg {
		label = "DbgLED";
		gpios = <&gpt2 0 1>; /* Active low */
		linux,default-trigger = "heartbeat";
	};
};

I can now manipulate the state of the LED in /sys/class/led/DbgLED/,
which is cool.

The led class provides support for setting the brightness, which
obviously the gpio driver doesn't support. The hardware (mpc52xx_gpt)
would support it in PWM mode though. I'm now wandering how this could be
best implemented.

1) - Create some PWM class similar to the GPIO class
   - Add support for PWM mode in mpc52xx_gpt.c that uses that PWM class
   - And add an interface for the LED to use the PWM class

2) - Create an LED driver that accesses the mpc52xx_gpt directly.

I think I would be overwhelmed trying to implement (1) but am confident
to do (2). What do you think is the right approach?

Cheers, Stefan.
