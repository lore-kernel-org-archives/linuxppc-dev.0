Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0C8A67CE5
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 13:39:17 +1000 (EST)
Subject: Re: [PATCH] powerpc: update mpc7448hpc2 board irq support using
	device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E531@zch01exm23.fsl.freescale.net>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E26E531@zch01exm23.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 13:38:58 +1000
Message-Id: <1156304338.8433.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-23 at 10:19 +0800, Zang Roy-r61911 wrote:
> The patch rewrites mpc7448hpc2 board irq support according to the new
> mpic 
> device tree interface.

Same comment as the other patch, it looks like it got wrapped by your
mailer. Also make sure you don't add trailing whitespaces (if you quilt,
the latest version detects them and has an option to fix them up for
you).

Appart from that, what the patch does looks good.

Cheers,
Ben.

> Signed-off-by: Roy Zang	<tie-fei.zang@freescale.com> 
> 
> ---
>  arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   73 ++++--------
>  arch/powerpc/sysdev/tsi108_dev.c                  |   10 +-
>  arch/powerpc/sysdev/tsi108_pci.c                  |   21 ++--
>  include/asm-powerpc/tsi108.h                      |   14 +-
>  include/asm-powerpc/tsi108_irq.h                  |  124
> +++++++++++++++++++++
>  5 files changed, 174 insertions(+), 68 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> index d7a4fc7..6a0c179 100644
> --- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> +++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
> @@ -1,7 +1,7 @@
>  /*
>   * mpc7448_hpc2.c
>   *
> - * Board setup routines for the Freescale Taiga platform
> + * Board setup routines for the Freescale mpc7448hpc2(taiga) platform
>   *
>   * Author: Jacob Pan
>   *	 jacob.pan@freescale.com
> @@ -12,10 +12,10 @@
>   *
>   * Copyright 2004-2006 Freescale Semiconductor, Inc.
>   *
> - * This file is licensed under
> - * the terms of the GNU General Public License version 2.  This program
> - * is licensed "as is" without any warranty of any kind, whether
> express
> - * or implied.
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
>   */
>  
>  #include <linux/config.h>
> @@ -62,43 +62,8 @@ #endif
>  extern int tsi108_setup_pci(struct device_node *dev);
>  extern void _nmask_and_or_msr(unsigned long nmask, unsigned long
> or_val);
>  extern void tsi108_pci_int_init(void);
> -extern int tsi108_irq_cascade(struct pt_regs *regs, void *unused);
> -
> -/*
> - * Define all of the IRQ senses and polarities.  Taken from the
> - * mpc7448hpc  manual.
> - * Note:  Likely, this table and the following function should be
> - *        obtained and derived from the OF Device Tree.
> - */
> -
> -static u_char mpc7448_hpc2_pic_initsenses[] __initdata = {
> -	/* External on-board sources */
> -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[0] XINT0
> from FPGA */
> -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[1] XINT1
> from FPGA */
> -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[2]
> PHY_INT from both GIGE */
> -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* INT[3]
> RESERVED */
> -	/* Internal Tsi108/109 interrupt sources */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ
> */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ
> */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ
> */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ
> */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA0 */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA1 */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA2 */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* DMA3 */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* UART0 */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* UART1 */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* I2C */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* GPIO */
> -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* GIGE0 */
> -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* GIGE1 */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ
> */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* HLP */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* SDC */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Processor IF
> */
> -	(IRQ_SENSE_EDGE  | IRQ_POLARITY_POSITIVE),	/* Reserved IRQ
> */
> -	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* PCI/X block
> */
> -};
> +extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc,
> +			    struct pt_regs *regs);
>  
>  int mpc7448_hpc2_exclude_device(u_char bus, u_char devfn)
>  {
> @@ -229,6 +194,8 @@ static void __init mpc7448_hpc2_init_IRQ
>  {
>  	struct mpic *mpic;
>  	phys_addr_t mpic_paddr = 0;
> +	unsigned int cascade_pci_irq;
> +	struct device_node *tsi_pci;
>  	struct device_node *tsi_pic;
>  
>  	tsi_pic = of_find_node_by_type(NULL, "open-pic");
> @@ -246,24 +213,31 @@ static void __init mpc7448_hpc2_init_IRQ
>  	DBG("%s: tsi108pic phys_addr = 0x%x\n", __FUNCTION__,
>  	    (u32) mpic_paddr);
>  
> -	mpic = mpic_alloc(mpic_paddr,
> +	mpic = mpic_alloc(tsi_pic, mpic_paddr,
>  			MPIC_PRIMARY | MPIC_BIG_ENDIAN |
> MPIC_WANTS_RESET |
>  			MPIC_SPV_EOI | MPIC_MOD_ID(MPIC_ID_TSI108),
>  			0, /* num_sources used */
> -			TSI108_IRQ_BASE,
>  			0, /* num_sources used */
> -			NR_IRQS - 4 /* XXXX */,
> -			mpc7448_hpc2_pic_initsenses,
> -			sizeof(mpc7448_hpc2_pic_initsenses),
> "Tsi108_PIC");
> +			"Tsi108_PIC");
>  
>  	BUG_ON(mpic == NULL); /* XXXX */
> -
>  	mpic_init(mpic);
> -	mpic_setup_cascade(IRQ_TSI108_PCI, tsi108_irq_cascade, mpic);
> +	
> +	tsi_pci = of_find_node_by_type(NULL, "pci");
> +	if (tsi_pci == 0) {
> +		printk("%s: No tsi108 pci node found !\n",
> __FUNCTION__);
> +		return;
> +	}
> +	
> +	cascade_pci_irq = irq_of_parse_and_map(tsi_pci, 0);
> +	set_irq_data(cascade_pci_irq, mpic);
> +	set_irq_chained_handler(cascade_pci_irq, tsi108_irq_cascade);
> +	
>  	tsi108_pci_int_init();
>  
>  	/* Configure MPIC outputs to CPU0 */
>  	tsi108_write_reg(TSI108_MPIC_OFFSET + 0x30c, 0);
> +	of_node_put(tsi_pic);
>  }
>  
>  void mpc7448_hpc2_show_cpuinfo(struct seq_file *m)
> @@ -320,6 +294,7 @@ static int mpc7448_machine_check_excepti
>  	return 0;
>  
>  }
> +
>  define_machine(mpc7448_hpc2){
>  	.name 			= "MPC7448 HPC2",
>  	.probe 			= mpc7448_hpc2_probe,
> diff --git a/arch/powerpc/sysdev/tsi108_dev.c
> b/arch/powerpc/sysdev/tsi108_dev.c
> index 26a0cc8..f303846 100644
> --- a/arch/powerpc/sysdev/tsi108_dev.c
> +++ b/arch/powerpc/sysdev/tsi108_dev.c
> @@ -93,13 +93,15 @@ static int __init tsi108_eth_of_init(voi
>  			goto err;
>  
>  		r[1].name = "tx";
> -		r[1].start = np->intrs[0].line;
> -		r[1].end = np->intrs[0].line;
> +		r[1].start = irq_of_parse_and_map(np, 0);
> +		r[1].end = irq_of_parse_and_map(np, 0);
>  		r[1].flags = IORESOURCE_IRQ;
> +		DBG("%s: name:start->end = %s:0x%lx-> 0x%lx\n",
> +			__FUNCTION__,r[1].name, r[1].start, r[1].end);
>  
>  		tsi_eth_dev =
>  		    platform_device_register_simple("tsi-ethernet", i,
> &r[0],
> -						    np->n_intrs + 1);
> +						    1);
>  
>  		if (IS_ERR(tsi_eth_dev)) {
>  			ret = PTR_ERR(tsi_eth_dev);
> @@ -127,7 +129,7 @@ static int __init tsi108_eth_of_init(voi
>  		tsi_eth_data.regs = r[0].start;
>  		tsi_eth_data.phyregs = res.start;
>  		tsi_eth_data.phy = *phy_id;
> -		tsi_eth_data.irq_num = np->intrs[0].line;
> +		tsi_eth_data.irq_num = irq_of_parse_and_map(np, 0);
>  		of_node_put(phy);
>  		ret =
>  		    platform_device_add_data(tsi_eth_dev, &tsi_eth_data,
> diff --git a/arch/powerpc/sysdev/tsi108_pci.c
> b/arch/powerpc/sysdev/tsi108_pci.c
> index 3265d54..906b204 100644
> --- a/arch/powerpc/sysdev/tsi108_pci.c
> +++ b/arch/powerpc/sysdev/tsi108_pci.c
> @@ -26,7 +26,6 @@ #include <linux/slab.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
>  
> -
>  #include <asm/byteorder.h>
>  #include <asm/io.h>
>  #include <asm/irq.h>
> @@ -228,7 +227,7 @@ int __init tsi108_setup_pci(struct devic
>  
>  	(hose)->ops = &tsi108_direct_pci_ops;
>  
> -	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08lx. "
> +	printk(KERN_INFO "Found tsi108 PCI host bridge at 0x%08x. "
>  	       "Firmware bus number: %d->%d\n",
>  	       rsrc.start, hose->first_busno, hose->last_busno);
>  
> @@ -278,7 +277,7 @@ static void init_pci_source(void)
>  	mb();
>  }
>  
> -static inline int get_pci_source(void)
> +static inline unsigned int get_pci_source(void)
>  {
>  	u_int temp = 0;
>  	int irq = -1;
> @@ -371,12 +370,12 @@ static void tsi108_pci_irq_end(u_int irq
>   * Interrupt controller descriptor for cascaded PCI interrupt
> controller.
>   */
>  
> -struct hw_interrupt_type tsi108_pci_irq = {
> +static struct irq_chip tsi108_pci_irq = {
>  	.typename = "tsi108_PCI_int",
> -	.enable = tsi108_pci_irq_enable,
> -	.disable = tsi108_pci_irq_disable,
> +	.mask = tsi108_pci_irq_disable,
>  	.ack = tsi108_pci_irq_ack,
>  	.end = tsi108_pci_irq_end,
> +	.unmask = tsi108_pci_irq_enable,
>  };
>  
>  /*
> @@ -399,14 +398,18 @@ void __init tsi108_pci_int_init(void)
>  	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
>  
>  	for (i = 0; i < NUM_PCI_IRQS; i++) {
> -		irq_desc[i + IRQ_PCI_INTAD_BASE].handler =
> &tsi108_pci_irq;
> +		irq_desc[i + IRQ_PCI_INTAD_BASE].chip = &tsi108_pci_irq;
>  		irq_desc[i + IRQ_PCI_INTAD_BASE].status |= IRQ_LEVEL;
>  	}
>  
>  	init_pci_source();
>  }
>  
> -int tsi108_irq_cascade(struct pt_regs *regs, void *unused)
> +void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc,
> +			    struct pt_regs *regs)
>  {
> -	return get_pci_source();
> +	unsigned int cascade_irq = get_pci_source();
> +	if (cascade_irq != NO_IRQ)
> +		generic_handle_irq(cascade_irq, regs);
> +	desc->chip->eoi(irq); 
>  }
> diff --git a/include/asm-powerpc/tsi108.h b/include/asm-powerpc/tsi108.h
> index c4c278d..e62250b 100644
> --- a/include/asm-powerpc/tsi108.h
> +++ b/include/asm-powerpc/tsi108.h
> @@ -1,16 +1,18 @@
>  /*
> - * include/asm-ppc/tsi108.h
> - *
>   * common routine and memory layout for Tundra TSI108(Grendel) host
> bridge
>   * memory controller.
>   *
>   * Author: Jacob Pan (jacob.pan@freescale.com)
>   *	   Alex Bounine (alexandreb@tundra.com)
> - * 2004 (c) Freescale Semiconductor Inc.  This file is licensed under
> - * the terms of the GNU General Public License version 2.  This program
> - * is licensed "as is" without any warranty of any kind, whether
> express
> - * or implied.
> + *	   
> + * Copyright 2004-2006 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
>   */
> +
>  #ifndef __PPC_KERNEL_TSI108_H
>  #define __PPC_KERNEL_TSI108_H
>  
> diff --git a/include/asm-powerpc/tsi108_irq.h
> b/include/asm-powerpc/tsi108_irq.h
> new file mode 100644
> index 0000000..8ac1389
> --- /dev/null
> +++ b/include/asm-powerpc/tsi108_irq.h
> @@ -0,0 +1,124 @@
> +/*
> + * (C) Copyright 2005 Tundra Semiconductor Corp.
> + * Alex Bounine, <alexandreb at tundra.com).
> + *
> + * See file CREDITS for list of people who contributed to this
> + * project.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +
> +/*
> + * definitions for interrupt controller initialization and external
> interrupt 
> + * demultiplexing on TSI108EMU/SVB boards.
> + */
> +
> +#ifndef _ASM_PPC_TSI108_IRQ_H
> +#define _ASM_PPC_TSI108_IRQ_H
> +
> +/*
> + * Tsi108 interrupts
> + */
> +#ifndef TSI108_IRQ_REG_BASE
> +#define TSI108_IRQ_REG_BASE		0
> +#endif
> +
> +#define TSI108_IRQ(x)		(TSI108_IRQ_REG_BASE + (x))
> +
> +#define TSI108_MAX_VECTORS	(36 + 4)	/* 36 sources + PCI INT
> demux */
> +#define MAX_TASK_PRIO	0xF
> +
> +#define TSI108_IRQ_SPURIOUS	(TSI108_MAX_VECTORS)
> +
> +#define DEFAULT_PRIO_LVL	10	/* initial priority level */
> +
> +/* Interrupt vectors assignment to external and internal 
> + * sources of requests. */
> +
> +/* EXTERNAL INTERRUPT SOURCES */
> +
> +#define IRQ_TSI108_EXT_INT0	TSI108_IRQ(0)	/* External Source at
> INT[0] */
> +#define IRQ_TSI108_EXT_INT1	TSI108_IRQ(1)	/* External Source at
> INT[1] */
> +#define IRQ_TSI108_EXT_INT2	TSI108_IRQ(2)	/* External Source at
> INT[2] */
> +#define IRQ_TSI108_EXT_INT3	TSI108_IRQ(3)	/* External Source at
> INT[3] */
> +
> +/* INTERNAL INTERRUPT SOURCES */
> +
> +#define IRQ_TSI108_RESERVED0	TSI108_IRQ(4)	/* Reserved IRQ */
> +#define IRQ_TSI108_RESERVED1	TSI108_IRQ(5)	/* Reserved IRQ */
> +#define IRQ_TSI108_RESERVED2	TSI108_IRQ(6)	/* Reserved IRQ */
> +#define IRQ_TSI108_RESERVED3	TSI108_IRQ(7)	/* Reserved IRQ */
> +#define IRQ_TSI108_DMA0		TSI108_IRQ(8)	/* DMA0 */
> +#define IRQ_TSI108_DMA1		TSI108_IRQ(9)	/* DMA1 */
> +#define IRQ_TSI108_DMA2		TSI108_IRQ(10)	/* DMA2 */
> +#define IRQ_TSI108_DMA3		TSI108_IRQ(11)	/* DMA3 */
> +#define IRQ_TSI108_UART0	TSI108_IRQ(12)	/* UART0 */
> +#define IRQ_TSI108_UART1	TSI108_IRQ(13)	/* UART1 */
> +#define IRQ_TSI108_I2C		TSI108_IRQ(14)	/* I2C */
> +#define IRQ_TSI108_GPIO		TSI108_IRQ(15)	/* GPIO */
> +#define IRQ_TSI108_GIGE0	TSI108_IRQ(16)	/* GIGE0 */
> +#define IRQ_TSI108_GIGE1	TSI108_IRQ(17)	/* GIGE1 */
> +#define IRQ_TSI108_RESERVED4	TSI108_IRQ(18)	/* Reserved IRQ */
> +#define IRQ_TSI108_HLP		TSI108_IRQ(19)	/* HLP */
> +#define IRQ_TSI108_SDRAM	TSI108_IRQ(20)	/* SDC */
> +#define IRQ_TSI108_PROC_IF	TSI108_IRQ(21)	/* Processor IF */
> +#define IRQ_TSI108_RESERVED5	TSI108_IRQ(22)	/* Reserved IRQ */
> +#define IRQ_TSI108_PCI		TSI108_IRQ(23)	/* PCI/X block */
> +
> +#define IRQ_TSI108_MBOX0	TSI108_IRQ(24)	/* Mailbox 0 register */
> +#define IRQ_TSI108_MBOX1	TSI108_IRQ(25)	/* Mailbox 1 register */
> +#define IRQ_TSI108_MBOX2	TSI108_IRQ(26)	/* Mailbox 2 register */
> +#define IRQ_TSI108_MBOX3	TSI108_IRQ(27)	/* Mailbox 3 register */
> +
> +#define IRQ_TSI108_DBELL0	TSI108_IRQ(28)	/* Doorbell 0 */
> +#define IRQ_TSI108_DBELL1	TSI108_IRQ(29)	/* Doorbell 1 */
> +#define IRQ_TSI108_DBELL2	TSI108_IRQ(30)	/* Doorbell 2 */
> +#define IRQ_TSI108_DBELL3	TSI108_IRQ(31)	/* Doorbell 3 */
> +
> +#define IRQ_TSI108_TIMER0	TSI108_IRQ(32)	/* Global Timer 0 */
> +#define IRQ_TSI108_TIMER1	TSI108_IRQ(33)	/* Global Timer 1 */
> +#define IRQ_TSI108_TIMER2	TSI108_IRQ(34)	/* Global Timer 2 */
> +#define IRQ_TSI108_TIMER3	TSI108_IRQ(35)	/* Global Timer 3 */
> +
> +/*
> + * PCI bus INTA# - INTD# lines demultiplexor
> + */
> +#define IRQ_PCI_INTAD_BASE	TSI108_IRQ(36)
> +#define IRQ_PCI_INTA		(IRQ_PCI_INTAD_BASE + 0)
> +#define IRQ_PCI_INTB		(IRQ_PCI_INTAD_BASE + 1)
> +#define IRQ_PCI_INTC		(IRQ_PCI_INTAD_BASE + 2)
> +#define IRQ_PCI_INTD		(IRQ_PCI_INTAD_BASE + 3)
> +#define NUM_PCI_IRQS		(4)
> +
> +/* number of entries in vector dispatch table */
> +#define IRQ_TSI108_TAB_SIZE	(TSI108_MAX_VECTORS + 1)
> +
> +/* Mapping of MPIC outputs to processors' interrupt pins */
> +
> +#define IDIR_INT_OUT0		0x1
> +#define IDIR_INT_OUT1		0x2
> +#define IDIR_INT_OUT2		0x4
> +#define IDIR_INT_OUT3		0x8
> +
> +/*---------------------------------------------------------------
> + * IRQ line configuration parameters */
> +
> +/* Interrupt delivery modes */
> +typedef enum {
> +	TSI108_IRQ_DIRECTED,
> +	TSI108_IRQ_DISTRIBUTED,
> +} TSI108_IRQ_MODE;
> +#endif				/*  _ASM_PPC_TSI108_IRQ_H */
