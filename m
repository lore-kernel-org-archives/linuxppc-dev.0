Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 26D67DDEDF
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 05:44:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
Date: Fri, 4 May 2007 21:44:30 +0200
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<1178302469.3026.204.camel@zod.rchland.ibm.com>
In-Reply-To: <1178302469.3026.204.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705042144.31194.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 04 May 2007, Josh Boyer wrote:
> +
> +#undef DEBUG
> +#ifdef DEBUG
> +#define DBG(fmt...) do { printk(fmt); } while(0)
> +#else
> +#define DBG(fmt...) do { } while(0)
> +#endif

Please replace this with the generic pr_debug()

> +#ifndef CONFIG_PCI
> +pci_dram_offset = PPC750GXCL_TSI_PCI_MEM_OFFSET;
> +#endif

This looks like the compile would expect a type.

> +extern int tsi108_setup_pci(struct device_node *dev);
> +extern void tsi108_pci_int_init(struct device_node *node);
> +extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);

please move any extern declarations into a header file that
is included by both the file that defines and uses them

> +static void holly_remap_bridge(void)
> +{
> +	u32 lut_val, lut_addr = 0x900, misc_cfg;
> +	int i;
> +
> +	printk(KERN_ERR "Remapping PCI bridge\n");

Is it an error to remap the bridge? If not, KERN_INFO would be more
appropriate ;-)

> +void holly_show_cpuinfo(struct seq_file *m)
> +{
> +	seq_printf(m, "vendor\t\t: IBM\n");
> +	seq_printf(m, "machine\t\t: PPC750 GX/CL\n");
> +}

If it's an IBM product, it should come with a product code like 123-4567,
which fits in here, instead of just listing the CPU.

> +static int ppc750_machine_check_exception(struct pt_regs *regs)
> +{
> +	extern void tsi108_clear_pci_cfg_error(void);

move declaration to header file.

> +	const struct exception_table_entry *entry;
> +
> +	/* Are we prepared to handle this fault */
> +	if ((entry = search_exception_tables(regs->nip)) != NULL) {
> +		tsi108_clear_pci_cfg_error();
> +		regs->msr |= MSR_RI;
> +		regs->nip = entry->fixup;
> +		return 1;
> +	}
> +	return 0;
> +}

Are you sure that you can use the generic exception table mechanism
like this? I can't see why it doesn't work, but it's something I haven't
seen anyone do like this.

> --- linux-2.6.orig/drivers/net/tsi108_eth.h
> +++ linux-2.6/drivers/net/tsi108_eth.h
> @@ -49,7 +49,11 @@
>   */
>  #define PHY_MV88E	1	/* Marvel 88Exxxx PHY */
>  #define PHY_BCM54XX	2	/* Broardcom BCM54xx PHY */
> +#if defined(CONFIG_HOLLY)
> +#define TSI108_PHY_TYPE PHY_BCM54XX
> +#else
>  #define TSI108_PHY_TYPE	PHY_MV88E
> +#endif
>  

this breaks multiplatform setups.

> --- linux-2.6.orig/include/asm-powerpc/tsi108.h
> +++ linux-2.6/include/asm-powerpc/tsi108.h
> @@ -68,7 +68,11 @@
>  #define TSI108_PB_ERRCS_ES		(1 << 1)
>  #define TSI108_PB_ISR_PBS_RD_ERR	(1 << 8)
>  
> +#ifdef CONFIG_HOLLY
> +#define TSI108_PCI_CFG_BASE_PHYS	(0x7c000000)
> +#else
>  #define TSI108_PCI_CFG_BASE_PHYS	(0xfb000000)
> +#endif
>  #define TSI108_PCI_CFG_SIZE		(0x01000000)
>  /* Global variables */
> 

Same here.

	Arnd <><
