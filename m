Return-Path: <skaiser.uci@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.179])
	by ozlabs.org (Postfix) with ESMTP id 47265DDFB3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 09:48:44 +1100 (EST)
Received: by ik-out-1112.google.com with SMTP id c29so984236ika
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 15:48:43 -0700 (PDT)
From: "Steven Kaiser" <skaiser.uci@gmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <918EB199DDDFFA42BEA2EB3A1C6021F360C085@CORREO>
	<20070322200453.GA76755@server.idefix.lan>
Subject: RE: Howto set DIO on MPC-5200 Lite
Date: Thu, 22 Mar 2007 15:48:46 -0700
Message-ID: <000401c76cd4$40805fd0$6e4ec880@volt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20070322200453.GA76755@server.idefix.lan>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This DIO on MPC-5200 thread brings up a related question that has been
nagging me for a while.

I built a custom MPC5200B board based on the Lite5200B, and run a 2.4 kernel
using the ELDK.  My hardware does not include PCI, but instead uses the
LocalPlus as a custom 18-bit external parallel bus to drive a bunch of
custom peripherals.  I added some GPIO (PSC6_0 thru PSC6_3) to this custom
external bus to allow interrupts, signaling, and various types of control.
All's well.  Now I would like to add more control lines, and even serial
interfaces to my custom bus.

But what holds me back is I am not entirely sure what 5200B peripherals the
stock linux kernel uses, and which ones are free for users to write their
own drivers and take over.  I currently use a 2.4 kernel, but someday [soon]
will move up to a 2.6 kernel.  I just want to download the basic ELDK
kernel, insmod my custom drivers, and go.  I would hate to find out the pins
I have taken over require me to hack up and reconfigure the kernel (since
I'm not so intimate with Linux yet this scares me if something goes wrong).

For example, in another thread people here are talking about a power down
feature in 2.6 for the MPC5200B.  Does this new feature use any GPIO lines I
should leave alone as reserved for linux use?  The LITE5200B has some queer
ad-hoc network hack using PSC2_4 to power down the board's voltage
regulators, but linux 2.4 knows nothing of this and removing the zero ohm
resistor (R88) allows me to use that pin for my own purposes (At least
emperically linux 2.4 doesn't seem to mind me programming that pin).

Looks like from the DIO discussion here that PSC2_0 thru PSC2_3, and PSC6_0
thru PSC6_3 pins are clearly free.  In general it looks like PSC2 (5 lines),
PSC3 (10 lines), and PSC6 (4 lines) are free for user use.  Linux expects a
UART on PSC1, and PSC4 and PSC5 pins are taken over by Ethernet, so those
lines are off limits.  Am I correct so far?

Are the TIMER_0 thru TIMER_7 lines used at all by the linux kernel?  I
thirst after 2 timers for my custom bus.

If I don't use PCI, can I take over IRQ_0 thru IRQ_3 without disrupting the
normal operation of the 2.4 or 2.6 kernel?  Some of the GPIO lines work fine
as interrupts so this is not so critical, but it would be nice to know.

EFIKA seems to have some sort of battery backed RTC to keep date and time,
but without a schematic I can't be sure what it is.  Would be nice if the
LITE500B had something like this.  What 5200B chip pins does EFIKA use for
this?  Maybe should reserve these pins for a future RTC in the EFIKA
tradition.

So my general question is this: What pins on the 5200B are free for external
use by the user (i.e. what pins are reserved by the linux 2.4 and 2.6 stock
kernels for internal use)?

Steve Kaiser

> -----Original Message-----
> From: linuxppc-embedded-bounces+skaiser.uci=gmail.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+skaiser.uci=gmail.com@ozlabs.org] On
> Behalf Of Matthias Fechner
> Sent: Thursday, March 22, 2007 1:05 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: Howto set DIO on MPC-5200 Lite
> 
> Hello Josu,
> 
> * Josu Onandia <jonandia@aotek.es> [19-03-07 14:18]:
> > Some sample code. Hope this helps.
> 
> thx a lot for all your help I love that mailinglist :)
> 
> Here is a very small kernel module for the icecube board.
> It activates the LED 1 and 3 after module has been loaded
> and off again if module has been removed.
> Maybe that helps someone else:
> 
> #include <linux/module.h>
> #include <asm/mpc52xx.h>
> 
> #define MPC5xxx_GPIO MPC52xx_VA(MPC52xx_GPIO_OFFSET)
> 
> static void psc6_configure_pins(void)
> {
>    struct mpc52xx_gpio *config;
>    config = (struct mpc52xx_gpio*) MPC5xxx_GPIO;
> 
>    printk("Address: %X\n",(u32)&config->port_config);
>    printk("Configure port\n");
>    config->port_config &= ~(0x00700000);
> 
>    printk("Set IRDA to GPIO\n");
>    config->simple_gpioe |= 0x30000000;
> 
>    printk("Set pins to CMOS output\n");
>    config->simple_ode &= ~(0x30000000);
> 
>    printk("Set simple GPIO data direction register\n");
>    config->simple_ddr |= 0x30000000;
>  }
> 
> // the pins are active low, so we invert it
> static void psc6_pin_on(unsigned int pin)
> {
>    struct mpc52xx_gpio *config;
>    config = (struct mpc52xx_gpio*) MPC5xxx_GPIO;
>    printk("Set LEDs %i\n",pin);
>    config->simple_dvo &= ~(1 << (pin+28));
> }
> 
> // the pins are active low, so we invert it
> static void psc6_pin_off(unsigned int pin)
> {
>    struct mpc52xx_gpio *config;
>    config = (struct mpc52xx_gpio*) MPC5xxx_GPIO;
>    printk("Clear LED %i\n",pin);
>    config->simple_dvo |= (1 << (pin+28));
> }
> 
> static int icecube_led_init(void)
> {
>    printk("Module Blink LED loaded\n");
>    printk("Set LEDs on\n");
>    psc6_configure_pins();
>    psc6_pin_on(0);
>    psc6_pin_on(1);
>    return 0;
> }
> 
> static void icecube_led_cleanup(void)
> {
>    printk("Module Blink LED unloaded\n");
>    psc6_pin_off(0);
>    psc6_pin_off(1);
> }
> 
> MODULE_AUTHOR("Matthias Fechner <idefix@fechner.net>");
> MODULE_DESCRIPTION("Driver to switch LED on icecube board after driver
> loaded successfully and switch LEDs of after driver unloaded
> successfully.");
> MODULE_LICENSE("GPL");
> 
> module_init(icecube_led_init);
> module_exit(icecube_led_cleanup);
> 
> 
> 
> Best regards,
> Matthias
> 
> --
> 
> "Programming today is a race between software engineers striving to
> build bigger and better idiot-proof programs, and the universe trying to
> produce bigger and better idiots. So far, the universe is winning." --
> Rich Cook
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
