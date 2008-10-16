Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id C43B3DE032
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Oct 2008 18:45:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: External interrupt on 460EX
Date: Thu, 16 Oct 2008 09:44:54 +0200
References: <48F60192.6050803@embedded-sol.com> <200810151700.30741.sr@denx.de>
	<48F609D2.5000301@embedded-sol.com>
In-Reply-To: <48F609D2.5000301@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810160944.54428.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Felix,

On Wednesday 15 October 2008, Felix Radensky wrote:
> >> The interrupt is connected to GPIO 45. U-Boot (1.3.4) configures this
> >> pin as external interrupt 12 (interrupt 20 in UIC 3). I've added the
> >> following
> >> entry to board device tree (in opb section)
> >>
> >> cpld@2,0 {
> >>     device_type = "cpld";
> >>     interrupts = <20 1>;
> >
> > Is this interrupt active on rising edge? This is what you have configured
> > here. When you need level, active low, then you need to write:
> >
> >      interrupts = <20 8>;
> >
> > And be careful which dts version you are using. Is this 20 decimal or
> > hex?
>
> The interrupt is indeed level, active low. Where can I find information
> on UIC
> interrupt settings for device tree ?

Not sure if this is really documented. Those values are from 
include/asm-ppc/irq.h:

#define IRQ_TYPE_NONE           0x00000000      /* Default, unspecified type 
*/
#define IRQ_TYPE_EDGE_RISING    0x00000001      /* Edge rising type */
#define IRQ_TYPE_EDGE_FALLING   0x00000002      /* Edge falling type */
#define IRQ_TYPE_EDGE_BOTH (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING)
#define IRQ_TYPE_LEVEL_HIGH     0x00000004      /* Level high type */
#define IRQ_TYPE_LEVEL_LOW      0x00000008      /* Level low type */

> I'm using dtc 1.2.0, 20 is decimal. 
> Is it ok ?

This doesn't really depend on the dtc version but on the version of the dts 
file itself. Is your dts a v1 dts file? Do you have this in your dts:

/dts-v1/;

?

If yes, then you have a v1 dts file and all number without 0x are decimal 
numbers. Then the "20" is correct for ext IRQ 12. If not then this number is 
hex and you should write "14" instead.

> >>     interrupt-parent = <&UIC3>;
> >> };
> >>
> >> In my driver I do the following:
> >>
> >>     /* Find CPLD node in device tree */
> >>     np = of_find_node_by_type(NULL, "cpld");
> >>     if (!np) {
> >>         printk(KERN_INFO "No CPLD found in device tree\n");
> >>         return -1;
> >>     }
> >>
> >>     /* Get and map irq number from device tree */
> >>     cpld_irq = irq_of_parse_and_map(np, 0);
> >>     if (cpld_irq == NO_IRQ) {
> >>         printk(KERN_ERR "irq_of_parse_and_map failed\n");
> >>         of_node_put(np);
> >>         return -ENODEV;
> >>     }
> >>
> >>     /* Register CPLD interrupt handler */
> >>     rc = request_irq(cpld_irq, cpld_interrupt,
> >>              IRQF_TRIGGER_LOW, "CPLD", NULL);
> >>
> >> And I see this interrupt in /proc/interrups after loading
> >> the driver. However interrupt handler is never invoked,
> >> although hardware guys see that GPIO line goes down
> >> when interrupt is generated.
> >>
> >> What am I doing wrong ?
> >
> > Another idea is that you didn't configure the pin multiplexing correctly.
> > Most external IRQ's are shared with other functions and/or GPIO's. You
> > need to configure the multiplexing correctly for external IRQ
> > functionality. This is usually done in U-Boot with the
> > CFG_4xx_GPIO_TABLE.
> >
> > I suggest you check here first.
>
> I've checked that, here's the relevant line from u-boot:
> {GPIO1_BASE, GPIO_IN , GPIO_ALT3, GPIO_OUT_0}, /* GPIO45 CS(5)
> EOT/TC1         IRQ(12)*/
>
> If I understand this code correctly, u-boot configures this line as ALT3
> (which is external IRQ 12)

Yes, this seems to be correct.

Best regards,
Stefan
