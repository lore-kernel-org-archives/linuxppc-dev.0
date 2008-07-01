Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-7.online-age.net (ext-nj2ut-7.online-age.net
	[64.14.54.237])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EE643DE159
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 01:18:02 +1000 (EST)
Received: from int-nj2ut-5.online-age.net (int-nj2ut-5.online-age.net
	[3.159.237.74])
	by ext-nj2ut-7.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m61F8Nj9019480
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 11:08:23 -0400
Received: from cinmlef06.e2k.ad.ge.com (int-nj2ut-5.online-age.net
	[3.159.237.74])
	by int-nj2ut-5.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m61F8Mrq013720
	for <linuxppc-dev@ozlabs.org>; Tue, 1 Jul 2008 11:08:23 -0400
Subject: Cascaded interrupt controller causing unbalanced interrupt.
Date: Tue, 1 Jul 2008 16:07:14 +0100
Message-ID: <1CADFA951940554D86FBD8B24BBFF3A0018BF553@LONMLVEM08.e2k.ad.ge.com>
From: "Welch, Martyn (GE EntSol,
	Intelligent Platforms)" <martyn.welch@gefanuc.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I'm having a spot of trouble writing a driver for a cascaded interrupt
handler used on one of our boards (8641D based board), patches to be
forth-coming as soon as I have access to this list without Outlook (I'm
working on it!).

I have attached the driver at the bottom of the email for reference
(sorry for the long email).

The driver is cascaded like this:

	static void __init
	gef_sbc610_init_irq(void)
	{
	        struct mpic *mpic1;
	        struct device_node *np, *cascade_node = NULL;
	        struct resource res;
	
	        /* Determine MPIC address. */
	        np = of_find_node_by_type(NULL, "open-pic");
	        if (np == NULL)
	                return;
	        of_address_to_resource(np, 0, &res);
	
	        mpic1 = mpic_alloc(np, res.start,
                        MPIC_PRIMARY | MPIC_WANTS_RESET |
MPIC_BIG_ENDIAN,
                        0, 256, "mpic");
	        of_node_put(np);
	        BUG_ON(mpic1 == NULL);
	
	        mpic_init(mpic1);
	
	        /* 
	         * There is a simple interrupt handler in the main FPGA,
this 
		   * needs To be cascaded into the MPIC
	         */
	        cascade_node = of_find_compatible_node(NULL, NULL, 
			    "gef,fpga-pic");
	        if(!cascade_node) {
	                printk(KERN_WARNING "SBC610: No FPGA PIC\n");
	                return;
	        }

	        gef_pic_init(cascade_node);
	        of_node_put(cascade_node);
	}

The cascaded interrupt controller is connected to the 8641D's mpic on
interrupts 8 & 9, from the DTS file:

		gef_pic: pic@4,4000 {
			#interrupt-cells = <2>;
			interrupt-controller;
			device_type = "interrupt-controller";
			compatible = "gef,fpga-pic";
			reg = <0x4 0x4000 0x20>;
			interrupts = <0x8 0x1
				      0x9 0x1>;
			interrupt-parent = <&mpic>;

		};

The interrupts from the phys are connected to the cascaded interrupt
controller:

		phy0: ethernet-phy@0 {
			#interrupt-cells = <2>;
			interrupt-parent = <&gef_pic>;
			interrupts = <0x16 0x4>;
			reg = <0x00000001>;
			device_type = "ethernet-phy";
		};
		phy2: ethernet-phy@2 {
			#interrupt-cells = <2>;
			interrupt-parent = <&gef_pic>;
			interrupts = <0x17 0x4>;
			reg = <0x00000003>;
			device_type = "ethernet-phy";
		};

When I boot (with the debugging turned on) I see the following:

mpic: Setting up MPIC "mpic" version 1.2 at fef40000, max 2 CPUs
mpic: ISU size: 88, shift: 7, mask: 7f
mpic: Initializing for 88 sources
gef_pic: gef_pic_init(/localbus@fef05000/pic@4,4000)
gef_pic: cascade mapped to irq 16
gef_pic: Setting up GEF FPGA pic at fdbf4000

...

gef_pic: gef_pic_host_xlate()
gef_pic: Setting flags from intspec:4
gef_pic: gef_pic_host_map(/localbus@fef05000/pic@4,4000, 22, 16)
gef_pic: map virq 22, hwirq 0x16
gef_pic: gef_pic_host_xlate()
gef_pic: Setting flags from intspec:4
gef_pic: gef_pic_host_map(/localbus@fef05000/pic@4,4000, 23, 17)
gef_pic: map virq 23, hwirq 0x17

...

gef_pic: Unmasking virtual interrupt 22, hw:22
Unbalanced enable for IRQ 22
------------[ cut here ]------------
Badness at c0055868 [verbose debug info unavailable]
NIP: c0055868 LR: c0055868 CTR: c01b3eb0
REGS: ef85be60 TRAP: 0700   Not tainted  (2.6.26-rc8-13367-g62635be)
MSR: 00021032 <ME,IR,DR>  CR: 22000022  XER: 00000000
TASK = ef859970[10] 'events/1' THREAD: ef85a000 CPU: 1
GPR00: c0055868 ef85bf10 ef859970 00000020 00000001 00000001 00000000
00004000 
GPR08: 00000001 00000000 000063f1 c03d0000 42000082 00000000 0ff4ce00
00000001 
GPR16: c03c3040 c03a97f0 c03b0000 c03a97f0 ef843f9c ef843f98 c03b0000
00000000 
GPR24: c0040000 c0330000 ef85a000 c01b1b40 c03c3a90 00009032 c03c3a60
c03c3a60 
NIP [c0055868] __enable_irq+0x50/0x84
LR [c0055868] __enable_irq+0x50/0x84
Call Trace:
[ef85bf10] [c0055868] __enable_irq+0x50/0x84 (unreliable)
[ef85bf20] [c0055cf8] enable_irq+0x50/0x70
[ef85bf40] [c01b1ba8] phy_change+0x68/0x108
[ef85bf60] [c003ade4] run_workqueue+0xac/0x15c
[ef85bf90] [c003b330] worker_thread+0x74/0xd4
[ef85bfd0] [c003f3bc] kthread+0x48/0x84
[ef85bff0] [c00115f0] kernel_thread+0x44/0x60
Instruction dump:
419e0024 419a0044 3809ffff 901f001c 80010014 83e1000c 38210010 7c0803a6 
4e800020 3c60c033 3863f3a0 4bfd28c5 <0fe00000> 80010014 83e1000c
38210010 

...

gef_pic: Unmasking virtual interrupt 23, hw:23
Unbalanced enable for IRQ 23
------------[ cut here ]------------
Badness at c0055868 [verbose debug info unavailable]
NIP: c0055868 LR: c0055868 CTR: c01b3eb0
REGS: ef857e60 TRAP: 0700   Not tainted  (2.6.26-rc8-13367-g62635be)
MSR: 00021032 <ME,IR,DR>  CR: 22000022  XER: 00000000
TASK = ef84a050[9] 'events/0' THREAD: ef856000 CPU: 0
GPR00: c0055868 ef857f10 ef84a050 00000020 00000001 00000001 00000000
00004000 
GPR08: 00000001 00000000 00006a3b c03d0000 42000082 00000000 0ff4ce00
00000001 
GPR16: c03c3040 c03a97f0 c03b0000 c03a97f0 ef843f9c ef843f98 c03b0000
00000000 
GPR24: c0040000 c0330000 ef856000 c01b1b40 c03c3af0 00009032 c03c3ac0
c03c3ac0 
NIP [c0055868] __enable_irq+0x50/0x84
LR [c0055868] __enable_irq+0x50/0x84
Call Trace:
[ef857f10] [c0055868] __enable_irq+0x50/0x84 (unreliable)
[ef857f20] [c0055cf8] enable_irq+0x50/0x70
[ef857f40] [c01b1ba8] phy_change+0x68/0x108
[ef857f60] [c003ade4] run_workqueue+0xac/0x15c
[ef857f90] [c003b330] worker_thread+0x74/0xd4
[ef857fd0] [c003f3bc] kthread+0x48/0x84
[ef857ff0] [c00115f0] kernel_thread+0x44/0x60
Instruction dump:
419e0024 419a0044 3809ffff 901f001c 80010014 83e1000c 38210010 7c0803a6 
4e800020 3c60c033 3863f3a0 4bfd28c5 <0fe00000> 80010014 83e1000c
38210010 


The interrupts are reported as being setup like this:

# cat /proc/interrupts 
           CPU0       CPU1       
 17:          0          0  mpic Level     ehci_hcd:usb1
 19:          0          0  mpic Level     ohci_hcd:usb2
 20:          7         18  mpic Level     sata_sil, ohci_hcd:usb3
 22:          0          0  gefp Level     phy_interrupt
 23:          0          0  gefp Level     phy_interrupt
 29:         14          8  mpic Level     enet_tx
 30:          6         70  mpic Level     enet_rx
 31:          1         22  mpic Level     enet_tx
 32:         50         17  mpic Level     enet_rx
 33:          0          0  mpic Level     enet_error
 34:          0          0  mpic Level     enet_error
 42:         79        836  mpic Level     serial
 43:          1         57  mpic Level     i2c-mpc, i2c-mpc
251:         14         70  mpic Edge      IPI0 (call function)
252:       2609       2014  mpic Edge      IPI1 (reschedule)
253:          0          0  mpic Edge      IPI2 (unused)
254:          0          0  mpic Edge      IPI3 (debugger break)
BAD:        514

I guess there is something wrong (the fact it hits a WARN_ON is a bit of
a give-away!), however I haven't been able to work out what and I've not
got a running example to compare it to.

Any suggestions would be gratefully received,

Martyn

----
Interrupt controller driver follows:
----

/*
 * Interrupt handling for GE Fanuc's FPGA based PIC
 *
 * Author: Martyn Welch <martyn.welch@gefanuc.com>
 *
 * 2008 (c) GE Fanuc Intelligent Platforms Embedded Systems, Inc.  
 *
 * This file is licensed under the terms of the GNU General Public
License 
 * version 2.  This program is licensed "as is" without any warranty of
any 
 * kind, whether express or implied.
 */

#include <linux/stddef.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/irq.h>
#include <linux/interrupt.h>
#include <linux/spinlock.h>

#include <asm/byteorder.h>
#include <asm/io.h>
#include <asm/prom.h>
#include <asm/irq.h>

#include "gef_pic.h"

#undef DEBUG
#define DEBUG

#ifdef DEBUG
#define DBG(fmt...) do { printk(KERN_DEBUG "gef_pic: " fmt); } while(0)
#else
#define DBG(fmt...) do { } while(0)
#endif

#define GEF_PIC_NUM_IRQS	32

/* Interrupt Controller Interface Registers */
#define GEF_PIC_INTR_STATUS	0x0000

#define GEF_PIC_INTR_MASK(cpu)	(0x0010 + (0x4 * cpu))
#define GEF_PIC_CPU0_INTR_MASK	GEF_PIC_INTR_MASK(0)
#define GEF_PIC_CPU1_INTR_MASK	GEF_PIC_INTR_MASK(1)

#define GEF_PIC_MCP_MASK(cpu)	(0x0018 + (0x4 * cpu))
#define GEF_PIC_CPU0_MCP_MASK	GEF_PIC_MCP_MASK(0)
#define GEF_PIC_CPU1_MCP_MASK	GEF_PIC_MCP_MASK(1)

#define gef_irq_to_hw(virq)    ((unsigned int)irq_map[virq].hwirq)


static DEFINE_SPINLOCK(gef_pic_lock);

static void __iomem *gef_pic_irq_reg_base;
static struct irq_host *gef_pic_irq_host;
static int gef_pic_cascade_irq;

/*
 * Interrupt Controller Handling
 *
 * The interrupt controller handles interrupts for most on board
interrupts,
 * apart from PCI interrupts. For example on SBC610:
 *
 * 0:14 RO Reserved
 * 15   RO PCI Express Doorbell 3 Status 
 * 16   RO PCI Express Doorbell 2 Status
 * 17   RO PCI Express Doorbell 1 Status
 * 18   RO PCI Express Doorbell 0 Status
 * 19   RO Real Time Clock Interrupt Status
 * 20   RO Temperature Interrupt Status
 * 21   RO Temperature Critical Interrupt Status
 * 22   RO Ethernet PHY1 Interrupt Status
 * 23   RO Ethernet PHY3 Interrupt Status
 * 24   RO PEX8548 Interrupt Status
 * 25   RO Reserved
 * 26   RO Watchdog 0 Interrupt Status
 * 27   RO Watchdog 1 Interrupt Status
 * 28   RO AXIS Message FIFO A Interrupt Status
 * 29   RO AXIS Message FIFO B Interrupt Status
 * 30   RO AXIS Message FIFO C Interrupt Status
 * 31   RO AXIS Message FIFO D Interrupt Status
 *
 * Interrupts can be generated forwarded to one of two output lines.
Nothing 
 * clever is done, so if the masks are incorrectly set a single input
interrupt 
 * could generate interrupts on both output lines!
 *
 * The dual lines are there to allow the chained interrupts to be easily

 * passed into two different cores.
 *
 * Controller can also be configured to generate Machine checks (MCP),
again on 
 * two lines, to be attached to two different cores. It is suggested
that these
 * should be masked out.
 */




void gef_pic_cascade(unsigned int irq, struct irq_desc *desc)
{
	unsigned int cascade_irq;

	DBG("gef_pic_cascade(%u, ->0x%p)\n", irq, desc);

	/* 
	 * See if we actually have an interrupt, call generic handling
code if 
	 * we do.
	 */
	cascade_irq = gef_pic_get_irq();
	
	if (cascade_irq != NO_IRQ) {
		generic_handle_irq(cascade_irq);
	}
	desc->chip->eoi(irq);

}

static void gef_pic_mask(unsigned int virq)
{
	unsigned long flags;
	unsigned int hwirq;
	u32 mask;
	
	hwirq = gef_irq_to_hw(virq);
	DBG("Masking virtual interrupt:%u, hw:%u\n", virq, hwirq);

	spin_lock_irqsave(&gef_pic_lock, flags);
	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
	mask &= ~(1 << hwirq);
	out_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0), mask);
	spin_unlock_irqrestore(&gef_pic_lock, flags);
}

static void gef_pic_mask_ack(unsigned int virq)
{
	DBG("Masking and Acking virtual interrupt %u - just Mask\n",
virq);
	/* Don't think we actually have to do anything to ack an
interrupt,
	 * we just need to clear down the devices interrupt and it will
go away
	 */
	gef_pic_mask(virq);
}

static void gef_pic_unmask(unsigned int virq)
{
	unsigned long flags;
	unsigned int hwirq;
	u32 mask;

	hwirq = gef_irq_to_hw(virq);
	DBG("Unmasking virtual interrupt %u, hw:%u\n", virq, hwirq);

	spin_lock_irqsave(&gef_pic_lock, flags);
	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
	mask |= (1 << hwirq);
	out_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0), mask);
	spin_unlock_irqrestore(&gef_pic_lock, flags);
}

static struct irq_chip gef_pic_chip = {
	.typename	= "gefp",
	.mask		= gef_pic_mask,
	.mask_ack	= gef_pic_mask_ack,
	.unmask		= gef_pic_unmask,
};


/* When an interrupt is being configured, this call allows some
flexibilty
 * in deciding which irq_chip structure is used
 */
static int gef_pic_host_map(struct irq_host *h, unsigned int virq,
			  irq_hw_number_t hwirq)
{
	DBG("gef_pic_host_map(%s, %u, %lx)\n", h->of_node->full_name,
virq, 
		hwirq);
	DBG("map virq %d, hwirq 0x%lx\n", virq, hwirq);

	/* All interrupts are LEVEL sensitive */
	get_irq_desc(virq)->status |= IRQ_LEVEL;
	set_irq_chip_and_handler(virq, &gef_pic_chip, handle_level_irq);

	return 0;
}

static int gef_pic_host_xlate(struct irq_host *h, struct device_node
*ct,
			    u32 *intspec, unsigned int intsize,
			    irq_hw_number_t *out_hwirq, unsigned int
*out_flags)
{
	DBG("gef_pic_host_xlate()\n");

	*out_hwirq = intspec[0];
	if (intsize > 1){
		DBG("Setting flags from intspec:%u\n", intspec[1]);
		*out_flags = intspec[1];
	} else {
		DBG("Setting flags to IRQ_TYPE_LEVEL_HIGH");
		*out_flags = IRQ_TYPE_LEVEL_HIGH;
	}
	return 0;
}

static struct irq_host_ops gef_pic_host_ops = {
	.map	= gef_pic_host_map,
	.xlate	= gef_pic_host_xlate,
};


/*
 * Initialisation of PIC, this should be called in BSP
 */
void __init gef_pic_init(struct device_node *np)
{
	unsigned long flags;

	DBG("gef_pic_init(%s)\n", np->full_name);

	/* Setup an irq_host structure */
	gef_pic_irq_host = irq_alloc_host(np, IRQ_HOST_MAP_LINEAR,
					  GEF_PIC_NUM_IRQS,
					  &gef_pic_host_ops, NO_IRQ);
	if (gef_pic_irq_host == NULL) {
		DBG("Unable to allocate host\n");
		return;
	}

	/* Map controller */
        gef_pic_cascade_irq = irq_of_parse_and_map(np, 0); 
        if (gef_pic_cascade_irq == NO_IRQ) { 
                printk(KERN_ERR "SBC610: failed to map cascade
interrupt"); 
                return; 
        } 
        DBG("cascade mapped to irq %d\n", gef_pic_cascade_irq); 
 
	/* Chain with parent controller */
        set_irq_chained_handler(gef_pic_cascade_irq, gef_pic_cascade); 

	/* Map the devices registers into memory */
	gef_pic_irq_reg_base = of_iomap(np, 0);

	DBG("Setting up GEF FPGA pic at %p\n", gef_pic_irq_reg_base);

	spin_lock_irqsave(&gef_pic_lock, flags);

	/* Initialise everything as masked. */
	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU0_INTR_MASK, 0);
	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU1_INTR_MASK, 0);

	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU0_MCP_MASK, 0);
	out_be32(gef_pic_irq_reg_base + GEF_PIC_CPU1_MCP_MASK, 0);

	spin_unlock_irqrestore(&gef_pic_lock, flags);
}

/*
 * This is called when we receive an interrupt with apparently comes
from this
 * chip - check, returning the (highest?) interrupt generated or return
NO_IRQ
 */
unsigned int gef_pic_get_irq(void)
{
	u32 cause, mask, active;
	unsigned int virq = NO_IRQ;
	int hwirq;

	DBG("gef_pic_get_irq()\n");

	cause = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_STATUS);
	DBG("cause=0x%8.8x\n", cause);

	/* XXX - We really need some way of selecting between the two
interrupt
	 * outputs (CPUs) at the momment we will only register one and
use
	 * that exclusively
	 */
	mask = in_be32(gef_pic_irq_reg_base + GEF_PIC_INTR_MASK(0));
	DBG("mask0=0x%8.8x\n", mask);
	DBG("mask1=0x%8.8x\n", in_be32(gef_pic_irq_reg_base +
GEF_PIC_INTR_MASK(1)));

	active = cause & mask;
	DBG("active=0x%8.8x\n", active);

	if (active) {
		for (hwirq = GEF_PIC_NUM_IRQS - 1; hwirq > -1; hwirq--)
{
			if (active & (0x1 << hwirq)) {
				DBG("Local interrupt: %d\n", hwirq);
				break;
			}
		}
		virq = irq_linear_revmap(gef_pic_irq_host, 
			(irq_hw_number_t)hwirq);
	}

	DBG("gef_pic_get_irq() returning %u\n", virq);
	return virq;
}

----
Martyn Welch MEng MPhil MIET
Principal Software Engineer

GE Fanuc Intelligent Platforms
Tove Valley Business Park, Towcester,
Northants, NN12 6PF, United Kingdom

Telephone: +44 (0) 1327 359444
Direct Dial: +44 (0) 1327 322748
Fax: +44 (0) 1327 322800
email: martyn.welch@gefanuc.com
web: www.gefanuc.com

GE Fanuc Intelligent Platforms Ltd, registered in England and Wales
(3828642) at 100 Barbirolli Square, Manchester, M2 3AB, VAT GB 729 849
476  

GE Fanuc Intelligent Platforms Confidential and Proprietary. If you have
received this message in error please notify us immediately and
permanently remove it from your system and destroy any printed
hardcopies.    
