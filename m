Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35A29DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Oct 2007 21:24:02 +1000 (EST)
Message-ID: <47037C3C.6070508@genesi-usa.com>
Date: Wed, 03 Oct 2007 12:25:48 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: pata_mpc52xx - no interrupts when using bestcomm/dma?
References: <20070827094454.GQ13994@moe.telargo.com>
In-Reply-To: <20070827094454.GQ13994@moe.telargo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi guys,

I'm not sure if this is a particularly PowerPC problem - more ATA -
but I am curious if we just got rid of the MWDMA and UDMA stuff from
this patch, would it still work in a sort of PIO mode with the
BestComm task being invoked at the right times?

All BestComm needs to do is marshall the data back and forth, since
the ATA portion is covered by errata and 'hidden' bugs you can't rely
on FIFO errors or the automatic handling anyway..

On that note, seeing as it seems to be easily possible to invoke
a BestComm task on something other than a FIFO (just needs two
physical address pointers), does anyone feel motivated to try and
make some kind of memory copy handler/task which can be invoked
in the case of some memory activity required? Or, perhaps, work
out the PCI DMA TX/RX stuff and what it could be used for (I
personally don't understand how PCI DMA isn't handled by the
PCI arbiter anyway.. doesn't this mean no PCI DMA is ever done on
MPC5200 platforms right now??)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Domen Puncer wrote:
> Hi!
> 
> I'm taking a stab at adding DMA support to pata_mpc52xx driver.
> 
> It's based on patches from Freescale's ltib (old ide driver).
> 
> 
> The problem is that I can't seem to get any interrupts
> (not ata, not bestcomm task), when setting up MWDMA/UDMA mode.
> 
> Ideas?
> 
> 
> My current patch:
> 
> ---
>  drivers/ata/pata_mpc52xx.c |  491 +++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/libata.h     |    2 
>  2 files changed, 477 insertions(+), 16 deletions(-)
> 
> Index: work-powerpc.git/drivers/ata/pata_mpc52xx.c
> ===================================================================
> --- work-powerpc.git.orig/drivers/ata/pata_mpc52xx.c
> +++ work-powerpc.git/drivers/ata/pata_mpc52xx.c
> @@ -4,6 +4,7 @@
>   * libata driver for the Freescale MPC52xx on-chip IDE interface
>   *
>   * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
> + * Copyright (C) 2005,2006 Freescale - Bernard Kuhn, John Rigby
>   * Copyright (C) 2003 Mipsys - Benjamin Herrenschmidt
>   *
>   * This file is licensed under the terms of the GNU General Public License
> @@ -22,6 +23,8 @@
>  #include <asm/of_platform.h>
>  #include <asm/mpc52xx.h>
>  
> +#include <sysdev/bestcomm/bestcomm.h>
> +#include <sysdev/bestcomm/ata.h>
>  
>  #define DRV_NAME	"mpc52xx_ata"
>  #define DRV_VERSION	"0.1.0ac2"
> @@ -31,6 +34,14 @@
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
> @@ -39,6 +50,12 @@ struct mpc52xx_ata_priv {
>  	int				ata_irq;
>  	struct mpc52xx_ata_timings	timings[2];
>  	int				csel;
> +
> +	/* dma stuff follows */
> +	struct bcom_task *		dmatsk;
> +	const struct udmaspec *		udmaspec;
> +	const struct mdmaspec *		mdmaspec;
> +	int 				mpc52xx_ata_dma_last_write;
>  };
>  
>  
> @@ -53,6 +70,102 @@ static const int ataspec_ta[5]    = { 35
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
> +
> +// -----------------------------------------------------------------------------------------------
> +
> +static const struct mdmaspec mdmaspec66 = {
> +	{32,  10,  8},
> +	{15,  6,   5},
> +	{2,   1,   1},
> +	{2,   1,   1},
> +	{15,  4,   2},
> +	{4,   2,   2},
> +	{1,   1,   1}
> +};
> +
> +static const struct mdmaspec mdmaspec132 = {
> +	{64,  20,  16},
> +	{29,  11,  10},
> +	{3,   2,   2},
> +	{3,   1,   1},
> +	{29,  7,   4},
> +	{7,   4,   4},
> +	{2,   1,   1}
> +};
> +
> +
> +/* ATAPI-4 UDMA specs (in clocks) */
> +struct udmaspec {
> +	u32 tcyc[6];
> +	u32 t2cyc[6];
> +	u32 tds[6];
> +	u32 tdh[6];
> +	u32 tdvs[6];
> +	u32 tdvh[6];
> +	u32 tfs_min[6];
> +	u32 tli_max[6];
> +	u32 tmli[6];
> +	u32 taz[6];
> +	u32 tzah[6];
> +	u32 tenv_min[6];
> +	u32 tsr[6];
> +	u32 trfs[6];
> +	u32 trp[6];
> +	u32 tack[6];
> +	u32 tss[6];
> +};
> +
> +static const struct udmaspec udmaspec66 = {
> +	{ 8,  5,  4,  3,  2,  2},
> +	{16, 11,  8,  6,  4 , 2},
> +	{ 1,  1,  1,  1,  1,  1},
> +	{ 1,  1,  1,  1,  1,  1},
> +	{ 5,  4,  3,  2,  1,  1},
> +	{ 1,  1,  1,  1,  1,  1},
> +	{16, 14, 12,  9,  8,  6},
> +	{10, 10, 10,  7,  8,  5},
> +	{ 2,  2,  2,  2,  2,  2},
> +	{ 1,  1,  1,  1,  1,  1},
> +	{ 2,  2,  2,  2,  2,  2},
> +	{ 2,  2,  2,  2,  2,  2},
> +	{ 3,  2,  2,  2,  2,  2},
> +	{ 5,  5,  4,  4,  4,  4},
> +	{11,  9,  7,  7,  7,  6},
> +	{ 2,  2,  2,  2,  2,  2},
> +	{ 4,  4,  4,  4,  4,  4}
> +};
> +
> +static const struct udmaspec udmaspec132 = {
> +	{15, 10,  6,  7,  2,  3},
> +	{31, 21, 12, 12,  5,  6},
> +	{ 2,  2,  1,  1,  0,  1},
> +	{ 1,  1,  1,  1,  0,  1},
> +	{10,  7,  5,  3,  1,  1},
> +	{ 1,  1,  1,  1,  1,  1},
> +	{30, 27, 23, 15, 16, 12},
> +	{20, 20, 20, 13, 14, 10},
> +	{ 3,  3,  3,  3,  2,  3},
> +	{ 2,  2,  2,  2,  1,  2},
> +	{ 3,  3,  3,  3,  2,  3},
> +	{ 3,  3,  3,  3,  2,  3},
> +	{ 7,  4,  3,  3,  2,  3},
> +	{10, 10,  8,  8,  7,  7},
> +	{22, 17, 14, 14, 13, 12},
> +	{ 3,  3,  3,  3,  2,  3},
> +	{ 7,  7,  7,  7,  6,  7},
> +};
> +
> +// -----------------------------------------------------------------------------------------------
>  
>  /* Bit definitions inside the registers */
>  #define MPC52xx_ATA_HOSTCONF_SMR	0x80000000UL /* State machine reset */
> @@ -76,6 +189,10 @@ static const int ataspec_ta[5]    = { 35
>  #define MPC52xx_ATA_DMAMODE_HUT		0x40 /* Host UDMA burst terminate */
>  
>  
> +#define MAX_DMA_BUFFERS 128
> +#define MAX_DMA_BUFFER_SIZE 0x20000u
> +
> +
>  /* Structure of the hardware registers */
>  struct mpc52xx_ata {
>  
> @@ -141,6 +258,19 @@ struct mpc52xx_ata {
>  
>  /* MPC52xx low level hw control */
>  
> +static inline void
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
> +}
> +
>  static int
>  mpc52xx_ata_compute_pio_timings(struct mpc52xx_ata_priv *priv, int dev, int pio)
>  {
> @@ -165,6 +295,96 @@ mpc52xx_ata_compute_pio_timings(struct m
>  	return 0;
>  }
>  
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
> +	/*
> +	DPRINTK ("t0M = %d\n", t0M);
> +	DPRINTK ("td  = %d\n", td);
> +	DPRINTK ("tkw = %d\n", tkw);
> +	DPRINTK ("tm  = %d\n", tm);
> +	DPRINTK ("th  = %d\n", th);
> +	DPRINTK ("tj  = %d\n", tj);
> +	DPRINTK ("tn  = %d\n", tn);
> +	*/
> +	timing->mdma1 = (t0M << 24) | (td << 16) | (tkw << 8) | (tm);
> +	timing->mdma2 = (th << 24) | (tj << 16) | (tn << 8);
> +
> +	timing->using_udma = 0;
> +
> +	return 0;
> +}
> +
> +static int
> +mpc52xx_ata_compute_udma_timings(struct mpc52xx_ata_priv *priv, int dev, int speed)
> +{
> +	struct mpc52xx_ata_timings *timing = &priv->timings[dev];
> +	u32 t2cyc, tcyc, tds, tdh, tdvs, tdvh, tfs, tli, tmli, taz, tenv, tsr, tss, trfs, trp, tack, tzah;
> +
> +	if (speed < 0 || speed > 2)
> +		return -EINVAL;
> +
> +	t2cyc = priv->udmaspec->t2cyc[speed];
> +	tcyc = priv->udmaspec->tcyc[speed];
> +	tds = priv->udmaspec->tds[speed];
> +	tdh = priv->udmaspec->tdh[speed];
> +	tdvs = priv->udmaspec->tdvs[speed];
> +	tdvh = priv->udmaspec->tdvh[speed];
> +	tfs = priv->udmaspec->tfs_min[speed];
> +	tmli = priv->udmaspec->tmli[speed];
> +	tenv = priv->udmaspec->tenv_min[speed];
> +	tss = priv->udmaspec->tss[speed];
> +	trp = priv->udmaspec->trp[speed];
> +	tack = priv->udmaspec->tack[speed];
> +	tzah = priv->udmaspec->tzah[speed];
> +	taz = priv->udmaspec->taz[speed];
> +	trfs = priv->udmaspec->trfs[speed];
> +	tsr = priv->udmaspec->tsr[speed];
> +	tli = priv->udmaspec->tli_max[speed];
> +/*
> +	DPRINTK ("UDMA t2cyc = %d\n", t2cyc);
> +	DPRINTK ("UDMA tcyc  = %d\n", tcyc);
> +	DPRINTK ("UDMA tds   = %d\n", tds);
> +	DPRINTK ("UDMA tdh   = %d\n", tdh);
> +	DPRINTK ("UDMA tdvs  = %d\n", tdvs);
> +	DPRINTK ("UDMA tdvh  = %d\n", tdvh);
> +	DPRINTK ("UDMA tfs   = %d\n", tfs);
> +	DPRINTK ("UDMA tli   = %d\n", tli);
> +	DPRINTK ("UDMA tmli  = %d\n", tmli);
> +	DPRINTK ("UDMA taz   = %d\n", taz);
> +	DPRINTK ("UDMA tenv  = %d\n", tenv);
> +	DPRINTK ("UDMA tsr   = %d\n", tsr);
> +	DPRINTK ("UDMA tss   = %d\n", tss);
> +	DPRINTK ("UDMA trfs  = %d\n", trfs);
> +	DPRINTK ("UDMA trp   = %d\n", trp);
> +	DPRINTK ("UDMA tack  = %d\n", tack);
> +	DPRINTK ("UDMA tzah  = %d\n", tzah);
> +*/
> +	timing->udma1 = (t2cyc << 24) | (tcyc << 16) | (tds << 8) | (tdh);
> +	timing->udma2 = (tdvs << 24) | (tdvh << 16) | (tfs << 8) | (tli);
> +	timing->udma3 = (tmli << 24) | (taz << 16) | (tenv << 8) | (tsr);
> +	timing->udma4 = (tss << 24) | (trfs << 16) | (trp << 8) | (tack);
> +	timing->udma5 = (tzah << 24);
> +
> +	timing->using_udma = 1;
> +
> +	return 0;
> +}
> +
>  static void
>  mpc52xx_ata_apply_timings(struct mpc52xx_ata_priv *priv, int device)
>  {
> @@ -173,13 +393,13 @@ mpc52xx_ata_apply_timings(struct mpc52xx
>  
>  	out_be32(&regs->pio1,  timing->pio1);
>  	out_be32(&regs->pio2,  timing->pio2);
> -	out_be32(&regs->mdma1, 0);
> -	out_be32(&regs->mdma2, 0);
> -	out_be32(&regs->udma1, 0);
> -	out_be32(&regs->udma2, 0);
> -	out_be32(&regs->udma3, 0);
> -	out_be32(&regs->udma4, 0);
> -	out_be32(&regs->udma5, 0);
> +	out_be32(&regs->mdma1, timing->mdma1);
> +	out_be32(&regs->mdma2, timing->mdma2);
> +	out_be32(&regs->udma1, timing->udma1);
> +	out_be32(&regs->udma2, timing->udma2);
> +	out_be32(&regs->udma3, timing->udma3);
> +	out_be32(&regs->udma4, timing->udma4);
> +	out_be32(&regs->udma5, timing->udma5);
>  
>  	priv->csel = device;
>  }
> @@ -234,6 +454,7 @@ mpc52xx_ata_set_piomode(struct ata_port 
>  
>  	pio = adev->pio_mode - XFER_PIO_0;
>  
> +	// FIXME, can be called for dma mode?
>  	rv = mpc52xx_ata_compute_pio_timings(priv, adev->devno, pio);
>  
>  	if (rv) {
> @@ -245,6 +466,28 @@ mpc52xx_ata_set_piomode(struct ata_port 
>  	mpc52xx_ata_apply_timings(priv, adev->devno);
>  }
>  static void
> +mpc52xx_ata_set_dmamode(struct ata_port *ap, struct ata_device *adev)
> +{
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +	int rv;
> +
> +	if (adev->dma_mode >= XFER_UDMA_0) {
> +		int dma = adev->dma_mode - XFER_UDMA_0;
> +		rv = mpc52xx_ata_compute_udma_timings(priv, adev->devno, dma);
> +	} else {
> +		int dma = adev->dma_mode - XFER_MW_DMA_0;
> +		rv = mpc52xx_ata_compute_mdma_timings(priv, adev->devno, dma);
> +	}
> +
> +	if (rv) {
> +		printk(KERN_ERR DRV_NAME
> +			": Trying to select invalid DMA mode %d\n", adev->dma_mode);
> +		return;
> +	}
> +
> +	mpc52xx_ata_apply_timings(priv, adev->devno);
> +}
> +static void
>  mpc52xx_ata_dev_select(struct ata_port *ap, unsigned int device)
>  {
>  	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> @@ -258,10 +501,174 @@ mpc52xx_ata_dev_select(struct ata_port *
>  static void
>  mpc52xx_ata_error_handler(struct ata_port *ap)
>  {
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
> +
> +	printk(KERN_ALERT "%s: status: %08x; fifo_status_frame: %08x; fifo_status: %08x\n",
> +			__func__, in_be32(&regs->host_status),
> +			in_be32(&regs->fifo_status_frame),
> +			in_be32(&regs->fifo_status));
> +
>  	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset, NULL,
>  			ata_std_postreset);
>  }
>  
> +static void
> +mpc52xx_ata_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
> +{
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +
> +	mpc52xx_ata_wait_tip_bit_clear(priv->ata_regs);
> +
> +	ata_exec_command(ap, tf);
> +}
> +
> +static int
> +mpc52xx_ata_build_dmatable(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
> +	struct scatterlist *sg;
> +	unsigned int read = !(qc->tf.flags & ATA_TFLAG_WRITE);
> +	int count = 0;
> +
> +	if (read)
> +		bcom_ata_rx_prepare(priv->dmatsk);
> +	else
> +		bcom_ata_tx_prepare(priv->dmatsk);
> +
> +
> +	ata_for_each_sg(sg, qc) {
> +		u32 cur_addr = sg_dma_address(sg);
> +		u32 cur_len = sg_dma_len(sg);
> +
> +		while (cur_len) {
> +			unsigned int tc = min(cur_len, MAX_DMA_BUFFER_SIZE);
> +			struct bcom_ata_bd *bd;
> +
> +			bd = (struct bcom_ata_bd *)
> +				bcom_prepare_next_buffer(priv->dmatsk);
> +
> +			if (read) {
> +				bd->status = tc;
> +				bd->dst_pa = cur_addr;
> +				bd->src_pa = (__force u32)&regs->fifo_data; // virt_to_phys?
> +			} else {
> +				bd->status = tc;
> +				bd->dst_pa = (__force u32)&regs->fifo_data; // virt_to_phys?
> +				bd->src_pa = cur_addr;
> +
> +				/* and how does bestcomm know to increase one, and not other?
> +				 * XXX TODO */
> +			}
> +
> +			bcom_submit_next_buffer(priv->dmatsk, phys_to_virt(cur_addr)); // qc is just a cookie
> +
> +			cur_addr += tc;
> +			cur_len -= tc;
> +			count++;
> +
> +			if (count == MAX_DMA_BUFFERS) {
> +				printk(KERN_ALERT "%s: %i dma table too small\n",
> +						__func__, __LINE__);
> +				goto use_pio_instead;
> +			}
> +		}
> +	}
> +	return 1;
> +
> + use_pio_instead:
> +	bcom_ata_reset_bd(priv->dmatsk);
> +	//pci_unmap_sg ???
> +
> +	return 0;
> +}
> +
> +static void
> +mpc52xx_bmdma_setup(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
> +	unsigned int read = !(qc->tf.flags & ATA_TFLAG_WRITE);
> +	u8 dma_mode;
> +printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +
> +	if (!mpc52xx_ata_build_dmatable(qc)) {
> +		//ide_map_sg(drive, rq);
> +		printk(KERN_ALERT "%s: %i, return 1?\n", __func__, __LINE__);
> +	}
> +
> +	if (read) {
> +		dma_mode = MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_READ |
> +				MPC52xx_ATA_DMAMODE_FE;
> +
> +		/* Setup FIFO if direction changed */
> +		if (priv->mpc52xx_ata_dma_last_write) {
> +			priv->mpc52xx_ata_dma_last_write = 0;
> +			mpc52xx_ata_wait_tip_bit_clear(regs);
> +			out_8(&regs->dma_mode, MPC52xx_ATA_DMAMODE_FR);
> +			/* Configure it with granularity to 7 like sample code */
> +			out_8(&regs->fifo_control, 7);
> +			out_be16(&regs->fifo_alarm, 128);
> +		}
> +	} else {
> +		dma_mode = MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_WRITE;
> +
> +		/* Setup FIFO if direction changed */
> +		if (!priv->mpc52xx_ata_dma_last_write) {
> +			priv->mpc52xx_ata_dma_last_write = 1;
> +			mpc52xx_ata_wait_tip_bit_clear(regs);
> +			/* Configure FIFO with granularity to 4 like sample code */
> +			out_8(&regs->fifo_control, 4);
> +			//out_be16(&regs->fifo_alarm, 256);
> +			out_be16(&regs->fifo_alarm, 128);
> +		}
> +	}
> +
> +	if (priv->timings[qc->dev->devno].using_udma)
> +		dma_mode |= MPC52xx_ATA_DMAMODE_UDMA;
> +
> +	mpc52xx_ata_wait_tip_bit_clear(regs);
> +	out_8(&regs->dma_mode, dma_mode);
> +
> +	ap->ops->exec_command(ap, &qc->tf); // added, ata_bmdma_setup has it
> +}
> +
> +static void
> +mpc52xx_bmdma_start(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +
> +	//xlb_clear(); // WTF
> +	bcom_enable(priv->dmatsk);
> +}
> +
> +static void
> +mpc52xx_bmdma_stop(struct ata_queued_cmd *qc)
> +{
> +	// uh? looks like destructor for setup not start
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +
> +	bcom_disable(priv->dmatsk);
> +	//bcom_clear_irq(priv->dmatsk); //!!
> +	bcom_ata_reset_bd(priv->dmatsk);
> +
> +	//	mpc52xx_ata_destroy_dmatable();
> +}
> +// waiting_for_dma eliminated
> +
> +static u8
> +mpc52xx_bmdma_status(struct ata_port *ap)
> +{
> +printk(KERN_ALERT "%s: %i TODO\n", __func__, __LINE__);
> +	return 0;
> +}
>  
>  
>  static struct scsi_host_template mpc52xx_ata_sht = {
> @@ -282,25 +689,47 @@ static struct scsi_host_template mpc52xx
>  	.bios_param		= ata_std_bios_param,
>  };
>  
> +static void mpc52xx_ata_bmdma_freeze(struct ata_port *ap)
> +{
> +	printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +	ata_bmdma_freeze(ap);
> +}
> +static void mpc52xx_ata_bmdma_thaw(struct ata_port *ap)
> +{
> +	printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +	ata_bmdma_thaw(ap);
> +}
> +static void ata_dummy_noret(struct ata_port *ap)
> +{
> +printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +}
>  static struct ata_port_operations mpc52xx_ata_port_ops = {
>  	.port_disable		= ata_port_disable,
>  	.set_piomode		= mpc52xx_ata_set_piomode,
> +	.set_dmamode		= mpc52xx_ata_set_dmamode,
>  	.dev_select		= mpc52xx_ata_dev_select,
>  	.tf_load		= ata_tf_load,
>  	.tf_read		= ata_tf_read,
>  	.check_status		= ata_check_status,
> -	.exec_command		= ata_exec_command,
> -	.freeze			= ata_bmdma_freeze,
> -	.thaw			= ata_bmdma_thaw,
> +	.exec_command		= mpc52xx_ata_exec_command,
> +	.freeze			= mpc52xx_ata_bmdma_freeze,
> +	.thaw			= mpc52xx_ata_bmdma_thaw,
>  	.error_handler		= mpc52xx_ata_error_handler,
>  	.cable_detect		= ata_cable_40wire,
>  	.qc_prep		= ata_qc_prep,
>  	.qc_issue		= ata_qc_issue_prot,
>  	.data_xfer		= ata_data_xfer,
> -	.irq_clear		= ata_bmdma_irq_clear,
> +//	.irq_clear		= ata_bmdma_irq_clear,
> +	.irq_clear		= ata_dummy_noret,
>  	.irq_on			= ata_irq_on,
>  	.irq_ack		= ata_irq_ack,
>  	.port_start		= ata_port_start,
> +	.bmdma_setup		= mpc52xx_bmdma_setup,
> +	.bmdma_start		= mpc52xx_bmdma_start,
> +	.bmdma_stop		= mpc52xx_bmdma_stop,
> +	.bmdma_status		= mpc52xx_bmdma_status,
> +
> +// not ide_dma_check	int  (*check_atapi_dma) (struct ata_queued_cmd *qc);
>  };
>  
>  static int __devinit
> @@ -309,7 +738,6 @@ mpc52xx_ata_init_one(struct device *dev,
>  	struct ata_host *host;
>  	struct ata_port *ap;
>  	struct ata_ioports *aio;
> -	int rc;
>  
>  	host = ata_host_alloc(dev, 1);
>  	if (!host)
> @@ -317,9 +745,9 @@ mpc52xx_ata_init_one(struct device *dev,
>  
>  	ap = host->ports[0];
>  	ap->flags		|= ATA_FLAG_SLAVE_POSS;
> -	ap->pio_mask		= 0x1f;	/* Up to PIO4 */
> -	ap->mwdma_mask		= 0x00;	/* No MWDMA   */
> -	ap->udma_mask		= 0x00;	/* No UDMA    */
> +	ap->pio_mask		= ATA_PIO4;	/* Up to PIO4 */
> +	ap->mwdma_mask		= 0x07;		/* Up to MWDMA2 */
> +	ap->udma_mask		= ATA_UDMA2;	/* Up to UDMA2 */
>  	ap->ops			= &mpc52xx_ata_port_ops;
>  	host->private_data	= priv;
>  
> @@ -359,6 +787,15 @@ mpc52xx_ata_remove_one(struct device *de
>  /* OF Platform driver                                                       */
>  /* ======================================================================== */
>  
> +static irqreturn_t
> +mpc52xx_ata_task_irq(int irq, void *vpriv)
> +{
> +	struct mpc52xx_ata_priv *priv = vpriv;
> +printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int __devinit
>  mpc52xx_ata_probe(struct of_device *op, const struct of_device_id *match)
>  {
> @@ -426,6 +863,30 @@ mpc52xx_ata_probe(struct of_device *op, 
>  	priv->ata_irq = ata_irq;
>  	priv->csel = -1;
>  
> +	if (ipb_freq/1000000 == 66) {
> +		priv->mdmaspec = &mdmaspec66;
> +		priv->udmaspec = &udmaspec66;
> +	} else {
> +		priv->mdmaspec = &mdmaspec132;
> +		priv->udmaspec = &udmaspec132;
> +	}
> +
> +	priv->dmatsk = bcom_ata_init(MAX_DMA_BUFFERS, MAX_DMA_BUFFER_SIZE);
> +	if (!priv->dmatsk) {
> +		printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +		rv = -ENOMEM;
> +		goto err;
> +	}
> +	// XXX task irq? nope, it doesn't get any irq's
> +	{
> +		int ret;
> +		int task_irq = bcom_get_task_irq(priv->dmatsk);
> +		printk(KERN_ALERT "%s: ata task irq: %i\n", __func__, task_irq);
> +		ret = request_irq(task_irq, &mpc52xx_ata_task_irq, IRQF_DISABLED, "ata task", priv);
> +		if (ret)
> +			printk(KERN_ALERT "%s: request_irq failed with: %i\n", __func__, ret);
> +	}
> +
>  	/* Init the hw */
>  	rv = mpc52xx_ata_hw_init(priv);
>  	if (rv) {
> Index: work-powerpc.git/include/linux/libata.h
> ===================================================================
> --- work-powerpc.git.orig/include/linux/libata.h
> +++ work-powerpc.git/include/linux/libata.h
> @@ -51,7 +51,7 @@
>   * compile-time options: to be removed as soon as all the drivers are
>   * converted to the new debugging mechanism
>   */
> -#undef ATA_DEBUG		/* debugging output */
> +#define ATA_DEBUG		/* debugging output */
>  #undef ATA_VERBOSE_DEBUG	/* yet more debugging output */
>  #undef ATA_IRQ_TRAP		/* define to ack screaming irqs */
>  #undef ATA_NDEBUG		/* define to disable quick runtime checks */
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
