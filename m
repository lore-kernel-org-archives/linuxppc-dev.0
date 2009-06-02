Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 688EFDDEF1
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 03:15:30 +1000 (EST)
Date: Tue, 2 Jun 2009 21:15:27 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stefan Strobl <nst@gersys.de>
Subject: Re: MPC52xx simple GPIO support
Message-ID: <20090602171527.GA8745@oksana.dev.rtsoft.ru>
References: <4A255B21.8040002@gersys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4A255B21.8040002@gersys.de>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stefan,

On Tue, Jun 02, 2009 at 07:02:25PM +0200, Stefan Strobl wrote:
> Hi
> I still don't quite understand how to use the Flattened Device Tree /
> Open Firmware. I see there's a driver (mpc52xx_gpt.c) that supports to
> use the Pins on the GPT as simple GPIOs. I activated it by adding these
> lines to my dts file:
> 
> gpt2: timer@620 {
> 	compatible = "fsl,mpc5200b-gpt-gpio","fsl,mpc5200-gpt-gpio";
> 	reg = <0x620 0x10>;
> 	interrupts = <1 11 0>;
> 	gpio-controller;
> 	#gpio-cells = <2>;
> };
> 
> I can see the appropriate entries in sysfs
> (/sys/devices/f0000000.soc5200/f0000620.timer), but how can I actually
> use these GPIO's now?

For in-kernel usage example you can take a look at:
arch/powerpc/boot/dts/mpc836x_rdk.dts (upm node, notice gpios = <>)
drivers/mtd/nand/fsl_upm.c (of_get_gpio() then gpio_request()).

For userland usage you need to enable CONFIG_GPIO_SYSFS, and then
look into /sys/class/gpio/{gpiochip,export,gpioNNN}.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
