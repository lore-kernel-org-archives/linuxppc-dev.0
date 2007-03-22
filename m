Return-Path: <idefix@fechner.net>
Received: from michelle.lostinspace.de (michelle.lostinspace.de
	[62.146.248.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "michelle.lostinspace.de",
	Issuer "michelle.lostinspace.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 40773DE001
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 07:05:06 +1100 (EST)
Received: from server.idefix.lan (cl-70.muc-02.de.sixxs.net
	[IPv6:2001:a60:f000:45::2]) (authenticated bits=0)
	by michelle.lostinspace.de (8.13.8/8.13.8) with ESMTP id l2MK4qcu046541
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 21:04:58 +0100 (CET)
	(envelope-from idefix@fechner.net)
Received: from idefix by server.idefix.lan with local (Exim 4.66 (FreeBSD))
	(envelope-from <idefix@fechner.net>) id 1HUTWn-000KH0-P9
	for linuxppc-embedded@ozlabs.org; Thu, 22 Mar 2007 21:04:53 +0100
Date: Thu, 22 Mar 2007 21:04:53 +0100
From: Matthias Fechner <idefix@fechner.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Howto set DIO on MPC-5200 Lite
Message-ID: <20070322200453.GA76755@server.idefix.lan>
References: <918EB199DDDFFA42BEA2EB3A1C6021F360C085@CORREO>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <918EB199DDDFFA42BEA2EB3A1C6021F360C085@CORREO>
Sender: Matthias Fechner <idefix@fechner.net>
Reply-To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Josu,

* Josu Onandia <jonandia@aotek.es> [19-03-07 14:18]:
> Some sample code. Hope this helps.

thx a lot for all your help I love that mailinglist :)

Here is a very small kernel module for the icecube board.
It activates the LED 1 and 3 after module has been loaded
and off again if module has been removed.
Maybe that helps someone else:

#include <linux/module.h>
#include <asm/mpc52xx.h>

#define MPC5xxx_GPIO MPC52xx_VA(MPC52xx_GPIO_OFFSET)

static void psc6_configure_pins(void)
{
   struct mpc52xx_gpio *config;
   config = (struct mpc52xx_gpio*) MPC5xxx_GPIO;
         
   printk("Address: %X\n",(u32)&config->port_config);
   printk("Configure port\n");
   config->port_config &= ~(0x00700000);
		     
   printk("Set IRDA to GPIO\n");
   config->simple_gpioe |= 0x30000000;
			      
   printk("Set pins to CMOS output\n");
   config->simple_ode &= ~(0x30000000);
				       
   printk("Set simple GPIO data direction register\n");
   config->simple_ddr |= 0x30000000;
 }
   
// the pins are active low, so we invert it
static void psc6_pin_on(unsigned int pin)
{
   struct mpc52xx_gpio *config;
   config = (struct mpc52xx_gpio*) MPC5xxx_GPIO;
   printk("Set LEDs %i\n",pin);
   config->simple_dvo &= ~(1 << (pin+28));
}
	       
// the pins are active low, so we invert it
static void psc6_pin_off(unsigned int pin)
{
   struct mpc52xx_gpio *config;
   config = (struct mpc52xx_gpio*) MPC5xxx_GPIO;
   printk("Clear LED %i\n",pin);
   config->simple_dvo |= (1 << (pin+28));
}
			   
static int icecube_led_init(void)
{
   printk("Module Blink LED loaded\n");
   printk("Set LEDs on\n");
   psc6_configure_pins();
   psc6_pin_on(0);
   psc6_pin_on(1);
   return 0;
}
						
static void icecube_led_cleanup(void)
{
   printk("Module Blink LED unloaded\n");
   psc6_pin_off(0);
   psc6_pin_off(1);
}
      
MODULE_AUTHOR("Matthias Fechner <idefix@fechner.net>");
MODULE_DESCRIPTION("Driver to switch LED on icecube board after driver loaded successfully and switch LEDs of after driver unloaded successfully.");
MODULE_LICENSE("GPL");

module_init(icecube_led_init);
module_exit(icecube_led_cleanup);



Best regards,
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
