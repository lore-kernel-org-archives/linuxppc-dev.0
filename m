Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 72A8A6877B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Nov 2005 06:15:42 +1100 (EST)
Date: Thu, 17 Nov 2005 11:58:10 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>
Message-ID: <20051117135810.GB9753@logos.cnet>
References: <437B2051.5030408@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437B2051.5030408@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

On Wed, Nov 16, 2005 at 03:04:33PM +0300, Vitaly Bordug wrote:
> This adds board-specific files needed to utilize fs_enet Ethernet driver
> for MPC885ADS and MPC866ADS.
> 
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> 
> +menu "Freescale Ethernet driver platform-specific options"
> +	depends on FS_ENET
> +
> +	config MPC8xx_SECOND_ETH
> +	bool "Second Ethernet channel"
> +	depends on (MPC885ADS || MPC86XADS)
> +	default y
> +	help
> +	  This enables support for second Ethernet on MPC885ADS and 
> MPC86xADS boards.

Some line breakage here?

>  choice
>  	prompt "Machine Type"
>  	depends on 6xx || POWER3 || POWER4
> diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
> index 7c5cdab..cce6487 100644
> --- a/arch/ppc/platforms/Makefile
> +++ b/arch/ppc/platforms/Makefile
> @@ -45,6 +45,8 @@ obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
>  obj-$(CONFIG_SPRUCE)		+= spruce.o
>  obj-$(CONFIG_LITE5200)		+= lite5200.o
>  obj-$(CONFIG_EV64360)		+= ev64360.o
> +obj-$(CONFIG_MPC86XADS)		+= mpc866ads_setup.o
> +obj-$(CONFIG_MPC885ADS)		+= mpc885ads_setup.o
> 
>  ifeq ($(CONFIG_SMP),y)
>  obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
> diff --git a/arch/ppc/platforms/fads.h b/arch/ppc/platforms/fads.h
> index a48fb8d..e1c0b1b 100644
> --- a/arch/ppc/platforms/fads.h
> +++ b/arch/ppc/platforms/fads.h
> @@ -112,7 +112,7 @@
> 
>  /* CPM Ethernet through SCC1 or SCC2 */
> 
> -#ifdef CONFIG_SCC1_ENET		/* Probably 860 variant */
> +#if defined(CONFIG_SCC1_ENET) || defined(CONFIG_MPC8xx_SECOND_ETH_SCC1) /* 
> Probably 860
> variant */
>  /* Bits in parallel I/O port registers that have to be set/cleared
>   * to configure the pins for SCC1 use.
>   * TCLK - CLK1, RCLK - CLK2.
> diff --git a/arch/ppc/platforms/mpc866ads_setup.c 
> b/arch/ppc/platforms/mpc866ads_setup.c
> new file mode 100644
> index 0000000..6ffdb0e
> --- /dev/null
> +++ b/arch/ppc/platforms/mpc866ads_setup.c
> @@ -0,0 +1,290 @@
> +/*arch/ppc/platforms/mpc885ads-setup.c
> + *
> + * Platform setup for the Freescale mpc885ads board
> + *
> + * Vitaly Bordug <vbordug@ru.mvista.com>
> + *
> + * Copyright 2005 MontaVista Software Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/param.h>
> +#include <linux/string.h>
> +#include <linux/ioport.h>
> +#include <linux/device.h>
> +
> +#include <linux/fs_enet_pd.h>
> +#include <linux/mii.h>
> +
> +#include <asm/delay.h>
> +#include <asm/io.h>
> +#include <asm/machdep.h>
> +#include <asm/page.h>
> +#include <asm/processor.h>
> +#include <asm/system.h>
> +#include <asm/time.h>
> +#include <asm/ppcboot.h>
> +#include <asm/8xx_immap.h>
> +#include <asm/commproc.h>
> +#include <asm/ppc_sys.h>
> +#include <asm/mpc8xx.h>
> +
> +extern unsigned char __res[];
> +
> +/* access ports */
> +#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |  (_v))
> +#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~(_v))
> +
> +#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |  (_v))
> +#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~(_v))

These definitions should go to generic header files.

> +
> +static struct fs_mii_bus_info fec_mii_bus_info = {
> +	.method = fsmii_fec,
> +	.id = 0,
> +};
> +
> +static struct fs_mii_bus_info scc_mii_bus_info = {
> +	.method = fsmii_fixed,
> +	.id = 0,
> +	.i.fixed.speed = 10,
> +	.i.fixed.duplex = 0,
> +};
> +
> +static struct fs_platform_info mpc8xx_fec_pdata[] = {
> +	{
> +	 .rx_ring = 128,
> +	 .tx_ring = 16,
> +	 .rx_copybreak = 240,
> +
> +	 .use_napi = 1,
> +	 .napi_weight = 17,
> +
> +	 .phy_addr = 15,
> +	 .phy_irq = -1,
> +
> +	 .use_rmii = 0,
> +
> +	 .bus_info = &fec_mii_bus_info,
> +	 }
> +};
> +
> +static struct fs_platform_info mpc8xx_scc_pdata = {
> +	.rx_ring = 64,
> +	.tx_ring = 8,
> +	.rx_copybreak = 240,
> +
> +	.use_napi = 1,
> +	.napi_weight = 17,
> +
> +	.phy_addr = -1,
> +	.phy_irq = -1,
> +
> +	.bus_info = &scc_mii_bus_info,
> +};
> +
> +static void mpc866_nonplatform_device_init(void)
> +{
> +	volatile cpm8xx_t *cp = cpmp;
> +	unsigned *bcsr_io;
> +
> +	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
> +
> +	if (bcsr_io == NULL) {
> +		printk(KERN_CRIT "Could not remap BCSR1\n");
> +		return;
> +	}
> +#ifdef CONFIG_SERIAL_CPM_SMC1
> +	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
> +	out_be32(bcsr_io, in_be32(bcsr_io) & ~(0x80000000 >> 7));
> +#else
> +	out_be32(bcsr_io, in_be32(bcsr_io) | (0x80000000 >> 7));
> +	cp->cp_pbpar &= ~(0x000000c0);
> +	cp->cp_pbdir |= 0x000000c0;
> +	cp->cp_smc[0].smc_smcmr = 0;
> +	cp->cp_smc[0].smc_smce = 0;
> +#endif
> +
> +#ifdef CONFIG_SERIAL_CPM_SMC2
> +	cp->cp_simode &= ~(0xe0000000 >> 1);
> +	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
> +	out_be32(bcsr_io, in_be32(bcsr_io) & ~(0x80000000 >> 13));
> +#else
> +	out_be32(bcsr_io, in_be32(bcsr_io) | (0x80000000 >> 13));

Should use the clrbit/setbit macro definitions?

> +	cp->cp_pbpar &= ~(0x00000c00);
> +	cp->cp_pbdir |= 0x00000c00;
> +	cp->cp_smc[1].smc_smcmr = 0;
> +	cp->cp_smc[1].smc_smce = 0;
> +#endif
> +	iounmap(bcsr_io);
> +}
> +
> +static void setup_fec1_ioports(void)
> +{
> +	immap_t *immap = (immap_t *) IMAP_ADDR;
> +
> +	setbits16(immap->im_ioport.iop_pdpar, 0x1fff);
> +	setbits16(immap->im_ioport.iop_pddir, 0x1fff);
> +}
> +
> +static void setup_scc1_ioports(void)
> +{
> +	immap_t *immap = (immap_t *) IMAP_ADDR;
> +	unsigned *bcsr_io;
> +
> +	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
> +
> +	if (bcsr_io == NULL) {
> +		printk(KERN_CRIT "Could not remap BCSR1\n");
> +		return;
> +	}
> +
> +	/* Enable the PHY.
> +	 */
> +	out_be32(bcsr_io, in_be32(bcsr_io) & ~BCSR1_ETHEN);
> +
> +	/* Configure port A pins for Txd and Rxd.
> +	 */
> +	/* Disable receive and transmit in case EPPC-Bug started it.
> +	 */
> +	setbits16(immap->im_ioport.iop_papar, PA_ENET_RXD | PA_ENET_TXD);
> +	clrbits16(immap->im_ioport.iop_padir, PA_ENET_RXD | PA_ENET_TXD);
> +	clrbits16(immap->im_ioport.iop_paodr, PA_ENET_TXD);
> +
> +	/* Configure port C pins to enable CLSN and RENA.
> +	 */
> +	clrbits16(immap->im_ioport.iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
> +	clrbits16(immap->im_ioport.iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
> +	setbits16(immap->im_ioport.iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
> +	/* Configure port A for TCLK and RCLK.
> +	 */
> +	setbits16(immap->im_ioport.iop_papar, PA_ENET_TCLK | PA_ENET_RCLK);
> +	clrbits16(immap->im_ioport.iop_padir, PA_ENET_TCLK | PA_ENET_RCLK);
> +	clrbits32(immap->im_cpm.cp_pbpar, PB_ENET_TENA);
> +	clrbits32(immap->im_cpm.cp_pbdir, PB_ENET_TENA);
> +
> +	/* Configure Serial Interface clock routing.
> +	 * First, clear all SCC bits to zero, then set the ones we want.
> +	 */
> +	clrbits32(immap->im_cpm.cp_sicr, SICR_ENET_MASK);
> +	setbits32(immap->im_cpm.cp_sicr, SICR_ENET_CLKRT);
> +
> +	/* In the original SCC enet driver the following code is placed at 
> the end of the
> initialization */

Strange formatting?
