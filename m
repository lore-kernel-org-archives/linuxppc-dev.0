Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D0DD67A6C
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jun 2006 02:26:10 +1000 (EST)
In-Reply-To: <20060623231710.6721.8447.stgit@localhost.localdomain>
References: <20060623231648.6721.3495.stgit@localhost.localdomain>
	<20060623231710.6721.8447.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7062D82B-EEC2-49BE-8685-DCBCC02A2BCD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/6] [RFC] POWERPC: Add mpc8560 board support
Date: Sat, 24 Jun 2006 11:26:01 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2006, at 6:17 PM, Vitaly Bordug wrote:

>
> This enables the mpc8560-specific bits in powerpc. The relevant  
> cpm2 PIC
> and common utility were moved without or with minor changes, hereby  
> not all
> the stuff have OF power utilized. Current functionality depends on  
> the very
> latest fs_enet update, that will go through netdev (cc'd here as
> reference). Assuming all the preceeding stuff applied (PAL+fs_enet  
> related
> + CPM_UART update), the both TSEC eth ,FCC Eths, and both SCC UARTs  
> are
> working. The relevant drivers are still capable to drive users in ppc,
> which was verified with 8272ADS (SCC uart+FCC eth).
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

Can you break this patch up into its pieces (moving of cpm2* files),  
fsl_soc mods, 8560 additions.

> ---
>
>  arch/powerpc/lib/Makefile                 |    5 +
>  arch/powerpc/platforms/85xx/Kconfig       |   11 +
>  arch/powerpc/platforms/85xx/Makefile      |    1
>  arch/powerpc/platforms/85xx/mpc8560_ads.h |   54 +++++
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c |  107 +++++++++++
>  arch/powerpc/sysdev/Makefile              |    7 +
>  arch/powerpc/sysdev/cpm2_common.c         |  197 ++++++++++++++++++++
>  arch/powerpc/sysdev/cpm2_pic.c            |  181 ++++++++++++++++++
>  arch/powerpc/sysdev/cpm2_pic.h            |    8 +
>  arch/powerpc/sysdev/fsl_soc.c             |  290 ++++++++++++++++++ 
> +++++++++++
>  include/asm-ppc/cpm2.h                    |    2
>  11 files changed, 860 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
> index ff70964..0993b3b 100644
> --- a/arch/powerpc/lib/Makefile
> +++ b/arch/powerpc/lib/Makefile
> @@ -21,3 +21,8 @@ ifeq ($(CONFIG_PPC64),y)
>  obj-$(CONFIG_SMP)	+= locks.o
>  obj-$(CONFIG_DEBUG_KERNEL) += sstep.o
>  endif
> +
> +# Temporary hack until we have migrated to asm-powerpc
> +ifeq ($(ARCH),powerpc)
> +obj-$(CONFIG_CPM2)	+= rheap.o
> +endif

Why not just move the file and build in arch/powerpc/lib/ for both  
arch/powerpc & arch/ppc.  Same goes for cpm_* files.

> diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/ 
> platforms/85xx/Kconfig
> index 454fc53..3d440de 100644
> --- a/arch/powerpc/platforms/85xx/Kconfig
> +++ b/arch/powerpc/platforms/85xx/Kconfig
> @@ -11,6 +11,12 @@ config MPC8540_ADS
>  	help
>  	  This option enables support for the MPC 8540 ADS board
>
> +config MPC8560_ADS
> +	bool "Freescale MPC8560 ADS"
> +	select DEFAULT_UIMAGE
> +	help
> +	  This option enables support for the MPC 8560 ADS board
> +
>  config MPC85xx_CDS
>  	bool "Freescale MPC85xx CDS"
>  	select DEFAULT_UIMAGE
> @@ -25,6 +31,11 @@ config MPC8540
>  	select PPC_UDBG_16550
>  	select PPC_INDIRECT_PCI
>  	default y if MPC8540_ADS || MPC85xx_CDS
> +
> +config MPC8560
> +	bool
> +	select PPC_INDIRECT_PCI
> +	default y if MPC8560_ADS
>
>  config PPC_INDIRECT_PCI_BE
>  	bool
> diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/ 
> platforms/85xx/Makefile
> index 7615aa5..282f5d0 100644
> --- a/arch/powerpc/platforms/85xx/Makefile
> +++ b/arch/powerpc/platforms/85xx/Makefile
> @@ -3,4 +3,5 @@ # Makefile for the PowerPC 85xx linux ke
>  #
>  obj-$(CONFIG_PPC_85xx)	+= misc.o pci.o
>  obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
> +obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
>  obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
> diff --git a/arch/powerpc/platforms/85xx/mpc8560_ads.h b/arch/ 
> powerpc/platforms/85xx/mpc8560_ads.h
> new file mode 100644
> index 0000000..4ebe710
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/mpc8560_ads.h
> @@ -0,0 +1,54 @@
> +/*
> + * MPC8560ADS board definitions
> + *
> + * Maintainer: Kumar Gala <galak@kernel.crashing.org>
> + *
> + * Copyright 2004 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + *
> + */
> +
> +#ifndef __MACH_MPC8560ADS_H
> +#define __MACH_MPC8560ADS_H
> +
> +#include <linux/config.h>
> +#include <linux/initrd.h>
> +
> +#define BOARD_CCSRBAR		((uint)0xe0000000)
> +#define BCSR_ADDR		((uint)0xf8000000)
> +#define BCSR_SIZE		((uint)(32 * 1024))
> +
> +#define MPC85xx_CPM_OFFSET	(0x80000)
> +
> +/*XXX TODO: pull from OF*/
> +#define CPM_MAP_ADDR		(BOARD_CCSRBAR + MPC85xx_CPM_OFFSET)
> +
> +/* PCI interrupt controller */
> +#define PIRQA		MPC85xx_IRQ_EXT1
> +#define PIRQB		MPC85xx_IRQ_EXT2
> +#define PIRQC		MPC85xx_IRQ_EXT3
> +#define PIRQD		MPC85xx_IRQ_EXT4
> +
> +/* FCC1 Clock Source Configuration.  These can be
> + * redefined in the board specific file.
> + *    Can only choose from CLK9-12 */
> +#define F1_RXCLK       12
> +#define F1_TXCLK       11
> +
> +/* FCC2 Clock Source Configuration.  These can be
> + * redefined in the board specific file.
> + *    Can only choose from CLK13-16 */
> +#define F2_RXCLK       13
> +#define F2_TXCLK       14
> +
> +/* FCC3 Clock Source Configuration.  These can be
> + * redefined in the board specific file.
> + *    Can only choose from CLK13-16 */
> +#define F3_RXCLK       15
> +#define F3_TXCLK       16
> +
> +#endif				/* __MACH_MPC8560ADS_H */
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/ 
> powerpc/platforms/85xx/mpc85xx_ads.c
> index 5eeff37..352d0ae 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
> @@ -15,6 +15,7 @@ #include <linux/config.h>
>  #include <linux/stddef.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
> +#include <linux/interrupt.h>
>  #include <linux/kdev_t.h>
>  #include <linux/delay.h>
>  #include <linux/seq_file.h>
> @@ -30,6 +31,10 @@ #include <asm/mpic.h>
>  #include <mm/mmu_decl.h>
>  #include <asm/udbg.h>
>
> +#ifdef CONFIG_CPM2
> +#include <asm/cpm2.h>
> +#endif
> +
>  #include <sysdev/fsl_soc.h>
>  #include "mpc85xx.h"
>
> @@ -121,8 +126,25 @@ mpc85xx_exclude_device(u_char bus, u_cha
>  }
>
>  #endif /* CONFIG_PCI */
> +
> +#ifdef CONFIG_CPM2
>
> +static irqreturn_t cpm2_cascade(int irq, void *dev_id, struct  
> pt_regs *regs)
> +{
> +	while ((irq = cpm2_get_irq(regs)) >= 0)
> +		__do_IRQ(irq, regs);
> +	return IRQ_HANDLED;
> +}
>
> +static struct irqaction cpm2_irqaction = {
> +	.handler = cpm2_cascade,
> +	.flags = SA_INTERRUPT,
> +	.mask = CPU_MASK_NONE,
> +	.name = "cpm2_cascade",
> +};
> +

I'd prefer that we see Ben's new IRQ support before doing this, but  
ok for now.

> +#endif /* CONFIG_CPM2 */
> +
>  void __init mpc85xx_ads_pic_init(void)
>  {
>  	struct mpic *mpic1;
> @@ -158,15 +180,91 @@ void __init mpc85xx_ads_pic_init(void)
>  	mpic_assign_isu(mpic1, 13, OpenPIC_PAddr + 0x10080);
>  	mpic_assign_isu(mpic1, 14, OpenPIC_PAddr + 0x10100);
>  	mpic_init(mpic1);
> +
> +#ifdef CONFIG_CPM2
> +	/* Setup CPM2 PIC */
> +
> +        cpm2_init_IRQ();
> +
> +	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);
> +#endif
>  }
>
>  /*
>   * Setup the architecture
> - */
> + */
> +static void init_fcc_ioports(void)
> +{
> +	struct immap *immap;
> +	struct io_port *io;
> +	u32 tempval;
> +
> +	immap = cpm2_immr;
> +
> +	io = &immap->im_ioport;
> +	/* FCC2/3 are on the ports B/C. */
> +	tempval = in_be32(&io->iop_pdirb);
> +	tempval &= ~PB2_DIRB0;
> +	tempval |= PB2_DIRB1;
> +	out_be32(&io->iop_pdirb, tempval);
> +
> +	tempval = in_be32(&io->iop_psorb);
> +	tempval &= ~PB2_PSORB0;
> +	tempval |= PB2_PSORB1;
> +	out_be32(&io->iop_psorb, tempval);
> +
> +	tempval = in_be32(&io->iop_pparb);
> +	tempval |= (PB2_DIRB0 | PB2_DIRB1);
> +	out_be32(&io->iop_pparb, tempval);
> +
> +	tempval = in_be32(&io->iop_pdirb);
> +	tempval &= ~PB3_DIRB0;
> +	tempval |= PB3_DIRB1;
> +	out_be32(&io->iop_pdirb, tempval);
> +
> +	tempval = in_be32(&io->iop_psorb);
> +	tempval &= ~PB3_PSORB0;
> +	tempval |= PB3_PSORB1;
> +	out_be32(&io->iop_psorb, tempval);
> +
> +	tempval = in_be32(&io->iop_pparb);
> +	tempval |= (PB3_DIRB0 | PB3_DIRB1);
> +	out_be32(&io->iop_pparb, tempval);
> +
> +	tempval = in_be32(&io->iop_pdirc);
> +	tempval |= PC3_DIRC1;
> +	out_be32(&io->iop_pdirc, tempval);
> +
> +	tempval = in_be32(&io->iop_pparc);
> +	tempval |= PC3_DIRC1;
> +	out_be32(&io->iop_pparc, tempval);
> +
> +	/* Port C has clocks......  */
> +	tempval = in_be32(&io->iop_psorc);
> +	tempval &= ~(CLK_TRX);
> +	out_be32(&io->iop_psorc, tempval);
> +
> +	tempval = in_be32(&io->iop_pdirc);
> +	tempval &= ~(CLK_TRX);
> +	out_be32(&io->iop_pdirc, tempval);
> +	tempval = in_be32(&io->iop_pparc);
> +	tempval |= (CLK_TRX);
> +	out_be32(&io->iop_pparc, tempval);
> +
> +	/* Configure Serial Interface clock routing.
> +	 * First,  clear all FCC bits to zero,
> +	 * then set the ones we want.
> +	 */
> +	immap->im_cpmux.cmx_fcr &= ~(CPMUX_CLK_MASK);
> +	immap->im_cpmux.cmx_fcr |= CPMUX_CLK_ROUTE;
> +}

Can this be turned into some library function that uses some input  
that is board specific.  U-boot has a table that looked like a  
reasonable approach.

> +
>  static void __init mpc85xx_ads_setup_arch(void)
>  {
>  	struct device_node *cpu;
>  	struct device_node *np;
> +
> +	cpm2_reset();
>
>  	if (ppc_md.progress)
>  		ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
> @@ -184,8 +282,13 @@ static void __init mpc85xx_ads_setup_arc
>  	}
>
>  #ifdef CONFIG_PCI
> +
>  	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
>  		add_bridge(np);
> +
> +#ifdef CONFIG_CPM2
> +	init_fcc_ioports();
> +#endif

This appears to be inside the CONFIG_PCI #ifdef, is that really what  
you want?

>  	ppc_md.pci_swizzle = common_swizzle;
>  	ppc_md.pci_map_irq = mpc85xx_map_irq;
> @@ -240,5 +343,7 @@ define_machine(mpc85xx_ads) {
>  	.get_irq		= mpic_get_irq,
>  	.restart		= mpc85xx_restart,
>  	.calibrate_decr		= generic_calibrate_decr,
> +#ifndef CONFIG_CPM2
>  	.progress		= udbg_progress,
> +#endif
>  };
> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/ 
> Makefile
> index cef95b0..75dfe12 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -12,3 +12,10 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
>  obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
>  obj-$(CONFIG_PPC_83xx)		+= ipic.o
>  obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
> +
> +# Temporary hack until we have migrated to asm-powerpc
> +ifeq ($(ARCH),powerpc)
> +obj-$(CONFIG_CPM2)		+= cpm2_common.o cpm2_pic.o
> +endif

See earlier comments about just building in arch/powerpc

> +
> +#obj-$(CONFIG_CPM2)		+= cpm2/			Yuri
> diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/ 
> sysdev/cpm2_common.c
> new file mode 100644
> index 0000000..c755f65
> --- /dev/null
> +++ b/arch/powerpc/sysdev/cpm2_common.c
> @@ -0,0 +1,197 @@
> +/*
> + * General Purpose functions for the global management of the
> + * 8260 Communication Processor Module.
> + * Copyright (c) 1999 Dan Malek (dmalek@jlc.net)
> + * Copyright (c) 2000 MontaVista Software, Inc (source@mvista.com)
> + *	2.3.99 Updates
> + *
> + * In addition to the individual control of the communication
> + * channels, there are a few functions that globally affect the
> + * communication processor.
> + *
> + * Buffer descriptors must be allocated from the dual ported memory
> + * space.  The allocator for that is here.  When the communication
> + * process is reset, we reclaim the memory available.  There is
> + * currently no deallocator for this memory.
> + */
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +#include <linux/kernel.h>
> +#include <linux/param.h>
> +#include <linux/string.h>
> +#include <linux/mm.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/mpc8260.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/cpm2.h>
> +#include <asm/rheap.h>
> +
> +static void cpm2_dpinit(void);
> +cpm_cpm2_t	*cpmp;		/* Pointer to comm processor space */
> +
> +/* We allocate this here because it is used almost exclusively for
> + * the communication processor devices.
> + */
> +cpm2_map_t *cpm2_immr;
> +
> +#define CPM_MAP_SIZE	(0x40000)	/* 256k - the PQ3 reserve this amount
> +					   of space for CPM as it is larger
> +					   than on PQ2 */
> +
> +void
> +cpm2_reset(void)
> +{
> +	cpm2_immr = (cpm2_map_t *)ioremap(CPM_MAP_ADDR, CPM_MAP_SIZE);

You dont need the cast.

> +
> +	/* Reclaim the DP memory for our use.
> +	 */
> +	cpm2_dpinit();
> +
> +	/* Tell everyone where the comm processor resides.
> +	 */
> +	cpmp = &cpm2_immr->im_cpm;
> +}
> +
> +/* Set a baud rate generator.  This needs lots of work.  There are
> + * eight BRGs, which can be connected to the CPM channels or output
> + * as clocks.  The BRGs are in two different block of internal
> + * memory mapped space.
> + * The baud rate clock is the system clock divided by something.
> + * It was set up long ago during the initial boot phase and is
> + * is given to us.
> + * Baud rate clocks are zero-based in the driver code (as that maps
> + * to port numbers).  Documentation uses 1-based numbering.
> + */
> +#define BRG_INT_CLK	(get_brgfreq())
> +#define BRG_UART_CLK	(BRG_INT_CLK/16)
> +
> +/* This function is used by UARTS, or anything else that uses a 16x
> + * oversampled clock.
> + */
> +void
> +cpm_setbrg(uint brg, uint rate)
> +{
> +	volatile uint	*bp;
> +
> +	/* This is good enough to get SMCs running.....
> +	*/
> +	if (brg < 4) {
> +		bp = (uint *)&cpm2_immr->im_brgc1;
> +	}
> +	else {
> +		bp = (uint *)&cpm2_immr->im_brgc5;
> +		brg -= 4;
> +	}
> +	bp += brg;
> +	*bp = ((BRG_UART_CLK / rate) << 1) | CPM_BRG_EN;
> +}
> +
> +/* This function is used to set high speed synchronous baud rate
> + * clocks.
> + */
> +void
> +cpm2_fastbrg(uint brg, uint rate, int div16)
> +{
> +	volatile uint	*bp;
> +
> +	if (brg < 4) {
> +		bp = (uint *)&cpm2_immr->im_brgc1;
> +	}
> +	else {
> +		bp = (uint *)&cpm2_immr->im_brgc5;
> +		brg -= 4;
> +	}
> +	bp += brg;
> +	*bp = ((BRG_INT_CLK / rate) << 1) | CPM_BRG_EN;
> +	if (div16)
> +		*bp |= CPM_BRG_DIV16;
> +}
> +
> +/*
> + * dpalloc / dpfree bits.
> + */
> +static spinlock_t cpm_dpmem_lock;
> +/* 16 blocks should be enough to satisfy all requests
> + * until the memory subsystem goes up... */
> +static rh_block_t cpm_boot_dpmem_rh_block[16];
> +static rh_info_t cpm_dpmem_info;
> +
> +static void cpm2_dpinit(void)
> +{
> +	spin_lock_init(&cpm_dpmem_lock);
> +
> +	/* initialize the info header */
> +	rh_init(&cpm_dpmem_info, 1,
> +			sizeof(cpm_boot_dpmem_rh_block) /
> +			sizeof(cpm_boot_dpmem_rh_block[0]),
> +			cpm_boot_dpmem_rh_block);
> +
> +	/* Attach the usable dpmem area */
> +	/* XXX: This is actually crap. CPM_DATAONLY_BASE and
> +	 * CPM_DATAONLY_SIZE is only a subset of the available dpram. It
> +	 * varies with the processor and the microcode patches activated.
> +	 * But the following should be at least safe.
> +	 */
> +	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE,
> +			CPM_DATAONLY_SIZE);
> +}
> +
> +/* This function returns an index into the DPRAM area.
> + */
> +uint cpm_dpalloc(uint size, uint align)
> +{
> +	void *start;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cpm_dpmem_lock, flags);
> +	cpm_dpmem_info.alignment = align;
> +	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
> +	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
> +
> +	return (uint)start;
> +}
> +EXPORT_SYMBOL(cpm_dpalloc);
> +
> +int cpm_dpfree(uint offset)
> +{
> +	int ret;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cpm_dpmem_lock, flags);
> +	ret = rh_free(&cpm_dpmem_info, (void *)offset);
> +	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(cpm_dpfree);
> +
> +/* not sure if this is ever needed */
> +uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
> +{
> +	void *start;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cpm_dpmem_lock, flags);
> +	cpm_dpmem_info.alignment = align;
> +	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size,  
> "commproc");
> +	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);
> +
> +	return (uint)start;
> +}
> +EXPORT_SYMBOL(cpm_dpalloc_fixed);
> +
> +void cpm_dpdump(void)
> +{
> +	rh_dump(&cpm_dpmem_info);
> +}
> +EXPORT_SYMBOL(cpm_dpdump);
> +
> +void *cpm_dpram_addr(uint offset)
> +{
> +	return (void *)&cpm2_immr->im_dprambase[offset];
> +}
> +EXPORT_SYMBOL(cpm_dpram_addr);
> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/ 
> cpm2_pic.c
> new file mode 100644
> index 0000000..e0db594
> --- /dev/null
> +++ b/arch/powerpc/sysdev/cpm2_pic.c
> @@ -0,0 +1,181 @@
> +/* The CPM2 internal interrupt controller.  It is usually
> + * the only interrupt controller.
> + * There are two 32-bit registers (high/low) for up to 64
> + * possible interrupts.
> + *
> + * Now, the fun starts.....Interrupt Numbers DO NOT MAP
> + * in a simple arithmetic fashion to mask or pending registers.
> + * That is, interrupt 4 does not map to bit position 4.
> + * We create two tables, indexed by vector number, to indicate
> + * which register to use and which bit in the register to use.
> + */
> +
> +#include <linux/stddef.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/signal.h>
> +#include <linux/irq.h>
> +
> +#include <asm/immap_cpm2.h>
> +#include <asm/mpc8260.h>
> +#include <asm/io.h>
> +
> +#include "cpm2_pic.h"
> +
> +static	u_char	irq_to_siureg[] = {
> +	1, 1, 1, 1, 1, 1, 1, 1,
> +	1, 1, 1, 1, 1, 1, 1, 1,
> +	0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0,
> +	1, 1, 1, 1, 1, 1, 1, 1,
> +	1, 1, 1, 1, 1, 1, 1, 1,
> +	0, 0, 0, 0, 0, 0, 0, 0,
> +	0, 0, 0, 0, 0, 0, 0, 0
> +};
> +
> +/* bit numbers do not match the docs, these are precomputed so the  
> bit for
> + * a given irq is (1 << irq_to_siubit[irq]) */
> +static	u_char	irq_to_siubit[] = {
> +	 0, 15, 14, 13, 12, 11, 10,  9,
> +	 8,  7,  6,  5,  4,  3,  2,  1,
> +	 2,  1,  0, 14, 13, 12, 11, 10,
> +	 9,  8,  7,  6,  5,  4,  3,  0,
> +	31, 30, 29, 28, 27, 26, 25, 24,
> +	23, 22, 21, 20, 19, 18, 17, 16,
> +	16, 17, 18, 19, 20, 21, 22, 23,
> +	24, 25, 26, 27, 28, 29, 30, 31,
> +};
> +
> +static void cpm2_mask_irq(unsigned int irq_nr)
> +{
> +	int	bit, word;
> +	volatile uint	*simr;
> +
> +	irq_nr -= CPM_IRQ_OFFSET;
> +
> +	bit = irq_to_siubit[irq_nr];
> +	word = irq_to_siureg[irq_nr];
> +
> +	simr = &(cpm2_immr->im_intctl.ic_simrh);
> +	ppc_cached_irq_mask[word] &= ~(1 << bit);
> +	simr[word] = ppc_cached_irq_mask[word];
> +}
> +
> +static void cpm2_unmask_irq(unsigned int irq_nr)
> +{
> +	int	bit, word;
> +	volatile uint	*simr;
> +
> +	irq_nr -= CPM_IRQ_OFFSET;
> +
> +	bit = irq_to_siubit[irq_nr];
> +	word = irq_to_siureg[irq_nr];
> +
> +	simr = &(cpm2_immr->im_intctl.ic_simrh);
> +	ppc_cached_irq_mask[word] |= 1 << bit;
> +	simr[word] = ppc_cached_irq_mask[word];
> +}
> +
> +static void cpm2_mask_and_ack(unsigned int irq_nr)
> +{
> +	int	bit, word;
> +	volatile uint	*simr, *sipnr;
> +
> +	irq_nr -= CPM_IRQ_OFFSET;
> +
> +	bit = irq_to_siubit[irq_nr];
> +	word = irq_to_siureg[irq_nr];
> +
> +	simr = &(cpm2_immr->im_intctl.ic_simrh);
> +	sipnr = &(cpm2_immr->im_intctl.ic_sipnrh);
> +	ppc_cached_irq_mask[word] &= ~(1 << bit);
> +	simr[word] = ppc_cached_irq_mask[word];
> +	sipnr[word] = 1 << bit;
> +}
> +
> +static void cpm2_end_irq(unsigned int irq_nr)
> +{
> +	int	bit, word;
> +	volatile uint	*simr;
> +
> +	if (!(irq_desc[irq_nr].status & (IRQ_DISABLED|IRQ_INPROGRESS))
> +			&& irq_desc[irq_nr].action) {
> +
> +		irq_nr -= CPM_IRQ_OFFSET;
> +		bit = irq_to_siubit[irq_nr];
> +		word = irq_to_siureg[irq_nr];
> +
> +		simr = &(cpm2_immr->im_intctl.ic_simrh);
> +		ppc_cached_irq_mask[word] |= 1 << bit;
> +		simr[word] = ppc_cached_irq_mask[word];
> +		/*
> +		 * Work around large numbers of spurious IRQs on PowerPC 82xx
> +		 * systems.
> +		 */
> +		mb();
> +	}
> +}
> +
> +static struct hw_interrupt_type cpm2_pic = {
> +	.typename = " CPM2 SIU ",
> +	.enable = cpm2_unmask_irq,
> +	.disable = cpm2_mask_irq,
> +	.ack = cpm2_mask_and_ack,
> +	.end = cpm2_end_irq,
> +};
> +
> +int cpm2_get_irq(struct pt_regs *regs)
> +{
> +	int irq;
> +        unsigned long bits;
> +
> +        /* For CPM2, read the SIVEC register and shift the bits down
> +         * to get the irq number.         */
> +        bits = cpm2_immr->im_intctl.ic_sivec;
> +        irq = bits >> 26;
> +
> +	if (irq == 0)
> +		return(-1);
> +	return irq+CPM_IRQ_OFFSET;
> +}
> +
> +void cpm2_init_IRQ(void)
> +{
> +	int i;
> +	u32 addr;
> +
> +	/* Clear the CPM IRQ controller, in case it has any bits set
> +	 * from the bootloader
> +	 */
> +
> +	/* Mask out everything */
> +
> +	cpm2_immr->im_intctl.ic_simrh = 0x00000000;
> +	cpm2_immr->im_intctl.ic_simrl = 0x00000000;
> +
> +	wmb();
> +
> +	/* Ack everything */
> +	cpm2_immr->im_intctl.ic_sipnrh = 0xffffffff;
> +	cpm2_immr->im_intctl.ic_sipnrl = 0xffffffff;
> +	wmb();
> +
> +	/* Dummy read of the vector */
> +	i = cpm2_immr->im_intctl.ic_sivec;
> +	rmb();
> +
> +	/* Initialize the default interrupt mapping priorities,
> +	 * in case the boot rom changed something on us.
> +	 */
> +	cpm2_immr->im_intctl.ic_sicr = 0;
> +	cpm2_immr->im_intctl.ic_scprrh = 0x05309770;
> +	cpm2_immr->im_intctl.ic_scprrl = 0x05309770;
> +
> +
> +	/* Enable chaining to OpenPIC, and make everything level
> +	 */
> +	for (i = 0; i < NR_CPM_INTS; i++) {
> +		irq_desc[i+CPM_IRQ_OFFSET].handler = &cpm2_pic;
> +		irq_desc[i+CPM_IRQ_OFFSET].status |= IRQ_LEVEL;
> +	}
> +}
> diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/ 
> cpm2_pic.h
> new file mode 100644
> index 0000000..97cab8f
> --- /dev/null
> +++ b/arch/powerpc/sysdev/cpm2_pic.h
> @@ -0,0 +1,8 @@
> +#ifndef _PPC_KERNEL_CPM2_H
> +#define _PPC_KERNEL_CPM2_H
> +
> +extern int cpm2_get_irq(struct pt_regs *regs);
> +
> +extern void cpm2_init_IRQ(void);
> +
> +#endif /* _PPC_KERNEL_CPM2_H */
> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/ 
> fsl_soc.c
> index ceb5846..bab202d 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -21,6 +21,8 @@ #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/platform_device.h>
>  #include <linux/fsl_devices.h>
> +#include <linux/fs_enet_pd.h>
> +#include <linux/fs_uart_pd.h>
>
>  #include <asm/system.h>
>  #include <asm/atomic.h>
> @@ -30,6 +32,10 @@ #include <asm/prom.h>
>  #include <sysdev/fsl_soc.h>
>  #include <mm/mmu_decl.h>
>
> +#ifdef CONFIG_CPM2
> +#include <asm/cpm2.h>
> +#endif
> +
>  static phys_addr_t immrbase = -1;
>
>  phys_addr_t get_immrbase(void)
> @@ -43,7 +49,9 @@ phys_addr_t get_immrbase(void)
>  	if (soc) {
>  		unsigned int size;
>  		void *prop = get_property(soc, "reg", &size);
> -		immrbase = of_translate_address(soc, prop);
> +
> +		if (prop)
> +			immrbase = of_translate_address(soc, prop);
>  		of_node_put(soc);
>  	};
>
> @@ -51,7 +59,79 @@ phys_addr_t get_immrbase(void)
>  }
>
>  EXPORT_SYMBOL(get_immrbase);
> +
> +static u32 brgfreq = -1;
> +
> +u32 get_brgfreq(void)
> +{
> +	struct device_node *node;
> +
> +	if (brgfreq != -1)
> +		return brgfreq;
> +
> +	node = of_find_node_by_type(NULL, "serial");
> +	if (node) {
> +		unsigned int size;
> +		unsigned int *prop = (unsigned int*)get_property(node, "clock- 
> frequency", &size);
> +
> +		if (prop)
> +			brgfreq = *prop;
> +		of_node_put(node);
> +	};
> +
> +	return brgfreq;
> +}

These seems broken on a system w/both CPM & 8250 style uarts.

> +
> +EXPORT_SYMBOL(get_brgfreq);
> +
> +static u32 fs_baudrate = -1;
> +
> +u32 get_baudrate(void)
> +{
> +	struct device_node *node;
>
> +	if (fs_baudrate != -1)
> +		return fs_baudrate;
> +
> +	node = of_find_node_by_type(NULL, "serial");
> +	if (node) {
> +		unsigned int size;
> +		unsigned int *prop = (unsigned int*)get_property(node, "current- 
> speed", &size);
> +
> +		if (prop)
> +			fs_baudrate = *prop;
> +		of_node_put(node);
> +	};
> +
> +	return fs_baudrate;
> +}
> +
> +EXPORT_SYMBOL(get_baudrate);
> +
> +static u32 intfreq = -1;
> +
> +u32 get_intfreq(void)
> +{
> +	struct device_node *node;
> +
> +	if (intfreq != -1)
> +		return intfreq;
> +
> +	node = of_find_node_by_type(NULL, "cpu");
> +	if (node) {
> +		unsigned int size;
> +		unsigned int *prop = (unsigned int*)get_property(node, "clock- 
> frequency", &size);
> +		if (prop)
> +			intfreq = *prop;
> +		of_node_put(node);
> +	}
> +
> +	return intfreq;
> +}
> +
> +EXPORT_SYMBOL(get_intfreq);
> +

Don't we have something that reports "clock-frequency" elsewhere?

> +
>  static int __init gfar_mdio_of_init(void)
>  {
>  	struct device_node *np;
> @@ -491,3 +571,211 @@ err:
>  }
>
>  arch_initcall(fsl_usb_dr_of_init);
> +
> +static const char *fcc_regs = "fcc_regs";
> +static const char *fcc_regs_c = "fcc_regs_c";
> +static const char *fcc_pram = "fcc_pram";
> +static char bus_id[9][BUS_ID_SIZE];
> +
> +static int __init fs_enet_of_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int i;
> +	struct platform_device *fs_enet_dev;
> +	struct resource res;
> +	int ret;
> +
> +	for (np = NULL, i = 0;
> +	     (np = of_find_compatible_node(np, "network", "fs_enet")) !=  
> NULL;
> +	     i++) {
> +		struct resource r[4];
> +		struct device_node *phy, *mdio;
> +		struct fs_platform_info fs_enet_data;
> +		unsigned int *id, *phy_addr;
> +		void *mac_addr;
> +		phandle *ph;
> +		char *model;
> +
> +		memset(r, 0, sizeof(r));
> +		memset(&fs_enet_data, 0, sizeof(fs_enet_data));
> +
> +		ret = of_address_to_resource(np, 0, &r[0]);
> +		if (ret)
> +			goto err;
> +		r[0].name = fcc_regs;
> +
> +		ret = of_address_to_resource(np, 1, &r[1]);
> +		if (ret)
> +			goto err;
> +		r[1].name = fcc_pram;
> +
> +		ret = of_address_to_resource(np, 2, &r[2]);
> +		if (ret)
> +			goto err;
> +		r[2].name = fcc_regs_c;
> +
> +		r[3].start = np->intrs[0].line;
> +		r[3].end = np->intrs[0].line;
> +		r[3].flags = IORESOURCE_IRQ;
> +
> +		fs_enet_dev =
> +		    platform_device_register_simple("fsl-cpm-fcc", i, &r[0], 4);
> +
> +		if (IS_ERR(fs_enet_dev)) {
> +			ret = PTR_ERR(fs_enet_dev);
> +			goto err;
> +		}
> +
> +		model = get_property(np, "model", NULL);
> +		if (model == NULL) {
> +			ret = -ENODEV;
> +			goto unreg;
> +		}
> +
> +		mac_addr = get_property(np, "mac-address", NULL);
> +		memcpy(fs_enet_data.macaddr, mac_addr, 6);
> +
> +		ph = (phandle *) get_property(np, "phy-handle", NULL);
> +		phy = of_find_node_by_phandle(*ph);
> +
> +		if (phy == NULL) {
> +			ret = -ENODEV;
> +			goto unreg;
> +		}
> +
> +		phy_addr = (u32 *) get_property(phy, "reg", NULL);
> +		fs_enet_data.phy_addr = *phy_addr;
> +
> +		id = (u32 *) get_property(np, "device-id", NULL);
> +		fs_enet_data.fs_no = *id;
> +
> +		mdio = of_get_parent(phy);
> +                ret = of_address_to_resource(mdio, 0, &res);
> +                if (ret) {
> +                        of_node_put(phy);
> +                        of_node_put(mdio);
> +                        goto unreg;
> +                }
> +
> +		switch (*id) {
> +		case fsid_fcc1:
> +			fs_enet_data.mem_offset = FCC1_MEM_OFFSET,
> +			snprintf((char*)&bus_id[2], BUS_ID_SIZE, "%x:%02x", (u32) 
> res.start, fs_enet_data.phy_addr);
> +			fs_enet_data.bus_id = (char*)&bus_id[2];
> +			fs_enet_data.cp_page = CPM_CR_FCC1_PAGE;
> +			fs_enet_data.cp_block = CPM_CR_FCC1_SBLOCK;
> +			break;
> +		case fsid_fcc2:
> +			fs_enet_data.mem_offset = FCC2_MEM_OFFSET,
> +			snprintf((char*)&bus_id[3], BUS_ID_SIZE, "%x:%02x", (u32) 
> res.start, fs_enet_data.phy_addr);
> +			fs_enet_data.bus_id = (char*)&bus_id[3];
> +			fs_enet_data.cp_page = CPM_CR_FCC2_PAGE;
> +			fs_enet_data.cp_block = CPM_CR_FCC2_SBLOCK;
> +			break;
> +		case fsid_fcc3:
> +			fs_enet_data.mem_offset = FCC3_MEM_OFFSET,
> +			snprintf((char*)&bus_id[4], BUS_ID_SIZE, "%x:%02x", (u32) 
> res.start, fs_enet_data.phy_addr);
> +			fs_enet_data.bus_id = (char*)&bus_id[4];
> +			fs_enet_data.cp_page = CPM_CR_FCC3_PAGE;
> +			fs_enet_data.cp_block = CPM_CR_FCC3_SBLOCK;
> +			break;
> +		}

this looks like a lot of effort to just encode a single integer (1,  
2, 3) and then lookup the other information based on it.

> +
> +		if (strstr(model, "FCC")) {
> +			fs_enet_data.dpram_offset = (u32)cpm2_immr->im_dprambase;
> +			fs_enet_data.rx_ring = 32;
> +			fs_enet_data.tx_ring = 32;
> +			fs_enet_data.rx_copybreak = 240;
> +			fs_enet_data.use_napi = 0;
> +			fs_enet_data.napi_weight = 17;
> +		}
> +
> +		of_node_put(phy);
> +		of_node_put(mdio);
> +
> +		ret = platform_device_add_data(fs_enet_dev, &fs_enet_data,
> +					     sizeof(struct
> +						    fs_platform_info));
> +		if (ret)
> +			goto unreg;
> +	}
> +	return 0;
> +
> +unreg:
> +	platform_device_unregister(fs_enet_dev);
> +err:
> +	return ret;
> +}
> +
> +arch_initcall(fs_enet_of_init);
> +
> +static const char *scc_regs = "regs";
> +static const char *scc_pram = "pram";
> +
> +static int __init cpm_uart_of_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int i;
> +	struct platform_device *cpm_uart_dev;
> +	int ret;
> +
> +
> +	for (np = NULL, i = 0;
> +	     (np = of_find_compatible_node(np, "serial", "cpm_uart")) !=  
> NULL;
> +	     i++) {
> +		struct resource r[3];
> +		struct fs_uart_platform_info cpm_uart_data;
> +		int *id;
> +
> +		memset(r, 0, sizeof(r));
> +		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
> +
> +		ret = of_address_to_resource(np, 0, &r[0]);
> +		if (ret)
> +			goto err;
> +
> +		r[0].name = scc_regs;
> +
> +		ret = of_address_to_resource(np, 1, &r[1]);
> +		if (ret)
> +			goto err;
> +		r[1].name = scc_pram;
> +
> +		r[2].start = np->intrs[0].line;
> +		r[2].end = np->intrs[0].line;
> +		r[2].flags = IORESOURCE_IRQ;
> +
> +		cpm_uart_dev =
> +		    platform_device_register_simple("fsl-cpm-scc:uart", i, &r 
> [0], 3);
> +
> +		if (IS_ERR(cpm_uart_dev)) {
> +			ret = PTR_ERR(cpm_uart_dev);
> +			goto err;
> +		}
> +
> +		id = get_property(np, "device-id", NULL);
> +		cpm_uart_data.fs_no = *id;
> +		cpm_uart_data.uart_clk = get_intfreq();
> +
> +		cpm_uart_data.tx_num_fifo = 4;
> +		cpm_uart_data.tx_buf_size = 32;
> +		cpm_uart_data.rx_num_fifo = 4;
> +		cpm_uart_data.rx_buf_size = 32;
> +
> +		ret =
> +		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
> +					     sizeof(struct
> +						    fs_uart_platform_info));
> +		if (ret)
> +			goto unreg;
> +	}
> +
> +	return 0;
> +
> +unreg:
> +	platform_device_unregister(cpm_uart_dev);
> +err:
> +	return ret;
> +}
> +
> +arch_initcall(cpm_uart_of_init);
> diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
> index f6a7ff0..8e6840b 100644
> --- a/include/asm-ppc/cpm2.h
> +++ b/include/asm-ppc/cpm2.h
> @@ -1186,7 +1186,7 @@ #define PC3_DIRC1	(PC3_TXDAT)
>  #define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
>  #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
>  #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
> -#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(2)
> +#define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
>
>  #endif /* __CPM2__ */
>  #endif /* __KERNEL__ */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
