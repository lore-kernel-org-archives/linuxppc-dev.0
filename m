Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 47151DDE08
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 09:49:48 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so122579wfg.15
	for <linuxppc-dev@ozlabs.org>; Tue, 01 Jul 2008 16:49:46 -0700 (PDT)
Date: Tue, 1 Jul 2008 17:49:43 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Tim Yamin <plasm@roo.me.uk>
Subject: Re: [PATCH]: [MPC5200] (v2) Add ATA DMA support
Message-ID: <20080701234943.GA16391@secretlab.ca>
References: <792f5f410806270544p69c773b9o9df4a5618d4babe1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <792f5f410806270544p69c773b9o9df4a5618d4babe1@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 27, 2008 at 01:44:08PM +0100, Tim Yamin wrote:
> diff -Nurp linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm.c linux-2.6.26-rc6.new/arch/powerpc/sysdev/bestcomm/bestcomm.c
> --- linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm.c	2008-03-18 15:49:53.000000000 +0000
> +++ linux-2.6.26-rc6.new/arch/powerpc/sysdev/bestcomm/bestcomm.c	2008-04-15 10:42:38.000000000 +0100
> @@ -330,11 +330,10 @@
>  	/* Init 'always' initiator */
>  	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
>  
> -	/* Disable COMM Bus Prefetch on the original 5200; it's broken */
> -	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) == MPC5200_SVR) {
> -		regval = in_be16(&bcom_eng->regs->PtdCntrl);
> -		out_be16(&bcom_eng->regs->PtdCntrl,  regval | 1);
> -	}
> +	/* Disable COMM Bus Prefetch; ATA DMA does not work properly with it
> +	   enabled. */
> +	regval = in_be16(&bcom_eng->regs->PtdCntrl);
> +	out_be16(&bcom_eng->regs->PtdCntrl, regval | 1);

This could have a performance impact on existing systems that don't
use/need ATA DMA.

Please run next version through checkpatch.  There's lots of minor
cosmetic stuff, but there are also a few important errors.

> diff -Nurp linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm.h linux-2.6.26-rc6.new/arch/powerpc/sysdev/bestcomm/bestcomm.h
> --- linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm.h	2008-03-18 15:49:53.000000000 +0000
> +++ linux-2.6.26-rc6.new/arch/powerpc/sysdev/bestcomm/bestcomm.h	2008-04-15 10:42:38.000000000 +0100
> @@ -17,6 +17,7 @@
>  #define __BESTCOMM_H__
>  
>  struct bcom_bd; /* defined later on ... */
> +struct bcom_bd_2;
>  
>  
>  /* ======================================================================== */
> @@ -49,6 +50,22 @@
>  	void*		priv;
>  };
>  
> +struct bcom_task_2 {
> +	unsigned int	tasknum;
> +	unsigned int	flags;
> +	int		irq;
> +
> +	struct bcom_bd_2	*bd;
> +	phys_addr_t	bd_pa;
> +	void		**cookie;
> +	unsigned short	index;
> +	unsigned short	outdex;
> +	unsigned int	num_bd;
> +	unsigned int	bd_size;
> +
> +	void*		priv;
> +};
> +

Oh, ugly.  The only difference seems to be that bcom_bd_2 is 1 word
larger than bcom_bd.  There must be a better way to do this rather
than just duplicating all the functions and structures..  It would
probably be better to use bd_size to determine how to dereference an
index into the *bd list.  It will require a bit of refactoring, but
it will be much cleaner and more maintainable that way.

> diff -Nurp linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h linux-2.6.26-rc6.new/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h
> --- linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h	2008-03-18 15:49:53.000000000 +0000
> +++ linux-2.6.26-rc6.new/arch/powerpc/sysdev/bestcomm/bestcomm_priv.h	2008-04-15 10:42:38.000000000 +0100
> @@ -198,8 +198,8 @@ struct bcom_task_header {
>  #define BCOM_IPR_SCTMR_1	2
>  #define BCOM_IPR_FEC_RX		6
>  #define BCOM_IPR_FEC_TX		5
> -#define BCOM_IPR_ATA_RX		4
> -#define BCOM_IPR_ATA_TX		3
> +#define BCOM_IPR_ATA_RX		7
> +#define BCOM_IPR_ATA_TX		7
>  #define BCOM_IPR_SCPCI_RX	2
>  #define BCOM_IPR_SCPCI_TX	2
>  #define BCOM_IPR_PSC3_RX	2

Is this a bug fix?  If so, please put it into a separate patch.

> diff -Nurp linux-2.6.26-rc6/drivers/ata/Kconfig linux-2.6.26-rc6.new/drivers/ata/Kconfig
> --- linux-2.6.26-rc6/drivers/ata/Kconfig	2008-03-18 15:49:33.000000000 +0000
> +++ linux-2.6.26-rc6.new/drivers/ata/Kconfig	2008-04-15 10:41:51.000000000 +0100
> @@ -462,6 +462,15 @@
>  
>  	  If unsure, say N.
>  
> +config PATA_MPC52xx_DMA
> +	tristate "Freescale MPC52xx SoC internal IDE DMA"
> +	depends on PATA_MPC52xx
> +	help
> +	  This option enables support for DMA on the MPC52xx SoC PATA
> +	  controller.
> +
> +	  If unsure, say N.
> +

Good, it can be turned off.  Do you think there is any risk to existing
ATA users with this patch applied if this is turned off?

>  config PATA_MPIIX
>  	tristate "Intel PATA MPIIX support"
>  	depends on PCI
> diff -Nurp linux-2.6.26-rc6/drivers/ata/pata_mpc52xx.c linux-2.6.26-rc6.new/drivers/ata/pata_mpc52xx.c
> --- linux-2.6.26-rc6/drivers/ata/pata_mpc52xx.c	2008-03-18 15:49:33.000000000 +0000
> +++ linux-2.6.26-rc6.new/drivers/ata/pata_mpc52xx.c	2008-04-15 10:41:49.000000000 +0100
> @@ -6,6 +6,9 @@
>   * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
>   * Copyright (C) 2003 Mipsys - Benjamin Herrenschmidt
>   *
> + * UDMA support based on patches by Freescale (Bernard Kuhn, John Rigby),
> + * Domen Puncer and Tim Yamin.
> + *
>   * This file is licensed under the terms of the GNU General Public License
>   * version 2. This program is licensed "as is" without any warranty of any
>   * kind, whether express or implied.
> @@ -17,28 +20,47 @@
>  #include <linux/delay.h>
>  #include <linux/libata.h>
>  
> +#include <asm/cacheflush.h>
>  #include <asm/types.h>
>  #include <asm/prom.h>
>  #include <asm/of_platform.h>
>  #include <asm/mpc52xx.h>
>  
> +#include <sysdev/bestcomm/bestcomm.h>
> +#include <sysdev/bestcomm/bestcomm_priv.h>
> +#include <sysdev/bestcomm/ata.h>
>  
>  #define DRV_NAME	"mpc52xx_ata"
>  #define DRV_VERSION	"0.1.2"
>  
> -
>  /* Private structures used by the driver */
>  struct mpc52xx_ata_timings {
>  	u32	pio1;
>  	u32	pio2;
> +	u32	mdma1;
> +	u32	mdma2;
> +	u32	udma1;
> +	u32	udma2;
> +	u32	udma3;
> +	u32	udma4;
> +	u32	udma5;
> +	int	using_udma;
>  };
>  
>  struct mpc52xx_ata_priv {
>  	unsigned int			ipb_period;
>  	struct mpc52xx_ata __iomem *	ata_regs;
> +	struct mpc52xx_ata __iomem *	ata_regs_pa;

Why two copies of the ata_regs?  (this should be documented)

>  	int				ata_irq;
>  	struct mpc52xx_ata_timings	timings[2];
>  	int				csel;
> +
> +	/* DMA */
> +	struct bcom_task *		dmatsk;
> +	const struct udmaspec *		udmaspec;
> +	const struct mdmaspec *		mdmaspec;
> +	int 				mpc52xx_ata_dma_last_write;
> +	int				waiting_for_dma;
>  };
>  
>  
> @@ -53,6 +75,102 @@
>  
>  #define CALC_CLKCYC(c,v) ((((v)+(c)-1)/(c)))
>  
> +/* ATAPI-4 MDMA specs (in clocks) */
> +struct mdmaspec {
> +	u32 t0M[3];
> +	u32 td[3];
> +	u32 th[3];
> +	u32 tj[3];
> +	u32 tkw[3];
> +	u32 tm[3];
> +	u32 tn[3];
> +};

This gets things to be quite verbose later on and it seems to separate
related data into 7 separate arrays.  Would it make more sense to
structure it like this:

struct mdmaspec {
	u32 t0M;
	u32 td;
	u32 th;
	u32 tj;
	u32 tkw;
	u32 tm;
	u32 tn;
};
static const struct mdmaspec mdmaspec66[3] = {
	{.t0M=32, .td=15, .th=2, .tj=2, .tkw=15, .tm=4, .tn=1,},
	{.t0M=10, .td=6,  .th=1, .tj=1, .tkw=4,  .tm=2, .tn=1,},
	{.t0M=8,  .td=5,  .th=1, .tj=1, .tkw=2,  .tm=2, .tn=1,},
};

It would allow some of the calculate code lower down dereference the
array once and should be much less verbose.

> +// -----------------------------------------------------------------------------------------------

Please use /* ----- */ instead

> +static const struct mdmaspec mdmaspec66 = {
> +	{32,  10,  8},
> +	{15,  6,   5},
> +	{2,   1,   1},
> +	{2,   1,   1},
> +	{15,  4,   2},
> +	{4,   2,   2},
> +	{1,   1,   1}
> +};

This is a little fragile, please use the following form to make it more
robust against future structure changes.  (and ditto through the rest of
the file)

+static const struct mdmaspec mdmaspec66 = {
+	.t0M = {32,  10,  8},
+	.td = {15,  6,   5},
+	.th = {2,   1,   1},
+	.tj = {2,   1,   1},
+	.tkw = {15,  4,   2},
+	.tm = {4,   2,   2},
+	.tn = {1,   1,   1}
+};

>  /* ======================================================================== */
>  /* Aux fns                                                                  */
> @@ -141,6 +265,19 @@
>  
>  /* MPC52xx low level hw control */
>  
> +static inline void

Drop 'inline' and trust GCC

> +mpc52xx_ata_wait_tip_bit_clear(struct mpc52xx_ata __iomem *regs)
> +{
> +	int timeout = 1000;
> +
> +	while (in_be32(&regs->host_status) & MPC52xx_ATA_HOSTSTAT_TIP)
> +		if (timeout-- == 0) {
> +			printk(KERN_ERR "mpc52xx-ide: Timeout waiting for TIP clear\n");
> +			break;
> +		}
> +	udelay(10);     /* FIXME: Necessary ??? */

Can you find any way to avoid this?  This could be a performance drain.

> +static int
> +mpc52xx_ata_compute_mdma_timings(struct mpc52xx_ata_priv *priv, int dev, int speed)
> +{
> +	struct mpc52xx_ata_timings *timing = &priv->timings[dev];
> +	u32 t0M, td, tkw, tm, th, tj, tn;
> +
> +	if (speed < 0 || speed > 2)
> +		return -EINVAL;
> +
> +	t0M = priv->mdmaspec->t0M[speed];
> +	td = priv->mdmaspec->td[speed];
> +	tkw = priv->mdmaspec->tkw[speed];
> +	tm = priv->mdmaspec->tm[speed];
> +	th = priv->mdmaspec->th[speed];
> +	tj = priv->mdmaspec->tj[speed];
> +	tn = priv->mdmaspec->tn[speed];
> +
> +	DPRINTK ("t0M = %d\n", t0M);
> +	DPRINTK ("td  = %d\n", td);
> +	DPRINTK ("tkw = %d\n", tkw);
> +	DPRINTK ("tm  = %d\n", tm);
> +	DPRINTK ("th  = %d\n", th);
> +	DPRINTK ("tj  = %d\n", tj);
> +	DPRINTK ("tn  = %d\n", tn);
> +
> +	timing->mdma1 = (t0M << 24) | (td << 16) | (tkw << 8) | (tm);
> +	timing->mdma2 = (th << 24) | (tj << 16) | (tn << 8);

This is what I'm referring to.  You could do:

struct mdmaspec *s = &priv->mdmaspec[speed];

and then access all the data as s->(blah) directly.

> +static int
> +mpc52xx_ata_build_dmatable(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +	struct mpc52xx_ata __iomem *regs_pa = priv->ata_regs_pa;
> +	unsigned int read = !(qc->tf.flags & ATA_TFLAG_WRITE), si;
> +	struct scatterlist *sg;
> +	int count = 0;
> +
> +	if (read)
> +		bcom_ata_rx_prepare(priv->dmatsk);
> +	else
> +		bcom_ata_tx_prepare(priv->dmatsk);
> +
> +	for_each_sg(qc->sg, sg, qc->n_elem, si) {
> +		u32 cur_addr = sg_dma_address(sg);
> +		u32 cur_len = sg_dma_len(sg);
> +
> +		while (cur_len) {
> +			unsigned int tc = min(cur_len, MAX_DMA_BUFFER_SIZE);
> +			struct bcom_ata_bd *bd = (struct bcom_ata_bd *) bcom_prepare_next_buffer_2((struct bcom_task_2 *) priv->dmatsk);

Ugly casting.  Reworking the bestcomm stuff should eliminate it.

> +
> +			if (read) {
> +				bd->status = tc;
> +				bd->src_pa = (__force u32) &regs_pa->fifo_data;
> +				bd->dst_pa = cur_addr;
> +
> +				invalidate_dcache_range((__force u32) phys_to_virt(cur_addr), (__force u32) phys_to_virt(cur_addr) + (__force u32) cur_len);

Even uglier casting.  Is this the right approach?

> +static void
> +mpc52xx_bmdma_setup(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
> +
> +	unsigned int read = !(qc->tf.flags & ATA_TFLAG_WRITE);
> +	u8 dma_mode;
> +
> +	if (!mpc52xx_ata_build_dmatable(qc)) {
> +		printk(KERN_ALERT "%s: %i, return 1?\n", __func__, __LINE__);
> +	}
> +
> +	/* Check FIFO is OK... */
> +	if(in_8(&priv->ata_regs->fifo_status) & MPC52xx_ATA_FIFOSTAT_ERROR)
> +		printk("WARNING: pata_mpc52xx FIFO error detected: 0x%02x!\n", in_8(&priv->ata_regs->fifo_status));

Line too long, please split (goes for the whole file)

>  static int __devinit
> @@ -281,9 +720,14 @@
>  
>  	ap = host->ports[0];
>  	ap->flags		|= ATA_FLAG_SLAVE_POSS;
> -	ap->pio_mask		= 0x1f;	/* Up to PIO4 */
> -	ap->mwdma_mask		= 0x00;	/* No MWDMA   */
> -	ap->udma_mask		= 0x00;	/* No UDMA    */
> +	ap->pio_mask		= ATA_PIO4;	/* Up to PIO4 */
> +#ifdef CONFIG_PATA_MPC52xx_DMA
> +	ap->mwdma_mask		= 0x07;		/* Up to MWDMA2 */
> +	ap->udma_mask		= ATA_UDMA2;	/* Up to UDMA2 */
> +#else
> +	ap->mwdma_mask		= 0x00;		/* No MWDMA */
> +	ap->udma_mask		= 0x00;		/* No UDMA */
> +#endif

Is there any way to turn on/off DMA at runtime instead of CONFIG time?

>  
>  	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
>  	priv->ata_regs = ata_regs;
> +	priv->ata_regs_pa = (struct mpc52xx_ata __iomem *) res_mem.start;

I'm not fond of this.  First off, it is *not* __iomem.  It is physical
address.  It would be better to use the offset_of macro to add an offset
to the physical base address.  Doing it this way forces you to cast and
sidestep the compile time checks for incorrect dereferences.

Some big comments, but it looks like a good driver; thanks!

Cheers,
g.
