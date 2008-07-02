Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 93B85DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 03:30:47 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so127443yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 02 Jul 2008 10:30:45 -0700 (PDT)
Date: Wed, 2 Jul 2008 11:30:40 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Tim Yamin <plasm@roo.me.uk>
Subject: Re: [PATCH]: [MPC5200] (v2) Add ATA DMA support
Message-ID: <20080702173040.GB23846@secretlab.ca>
References: <792f5f410806270544p69c773b9o9df4a5618d4babe1@mail.gmail.com>
	<20080701234943.GA16391@secretlab.ca>
	<792f5f410807020548m107cd6a5xf0360e07053e104c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <792f5f410807020548m107cd6a5xf0360e07053e104c@mail.gmail.com>
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

On Wed, Jul 02, 2008 at 01:48:39PM +0100, Tim Yamin wrote:
> Hi Grant,
> 
> Thanks for the feedback. New version is attached.

Your welcome.  The patch is looking pretty good.  Some more comments
below.

> > > -#define BCOM_IPR_ATA_RX		4
> > > -#define BCOM_IPR_ATA_TX		3
> > > +#define BCOM_IPR_ATA_RX		7
> > > +#define BCOM_IPR_ATA_TX		7
> >
> > Is this a bug fix?  If so, please put it into a separate patch.
> 
> I suppose so, yes. If Ethernet has higher priority than ATA, you can
> get a deadlock if you try and download a large file over a LAN to
> disk, for example. But given that nothing other than this patch uses
> BestComm for ATA do you have any specific reason to split it out into
> another patch?

I know that only ATA uses this; but it is nice to have fixes to things
that are obviously wrong in existing code to be split into their own
patches.  That way, even if the ATA patch gets backed out, the bug fix
will remain.

> >>       priv->ipb_period = 1000000000 / (ipb_freq / 1000);
> >>       priv->ata_regs = ata_regs;
> >> +     priv->ata_regs_pa = (struct mpc52xx_ata __iomem *) res_mem.start;
> >
> > I'm not fond of this.  First off, it is *not* __iomem.  It is physical
> > address.  It would be better to use the offset_of macro to add an offset
> > to the physical base address.  Doing it this way forces you to cast and
> > sidestep the compile time checks for incorrect dereferences.
> 
> I'm afraid I'm not quite sure what you have in mind here, could you
> please provide a pointer?

See below comments

> 
> Thanks,
> 
> Tim

> This patch adds MDMA/UDMA support (using BestComm for DMA) on the MPC5200
> platform.
> 
> Based heavily on previous work by Freescale (Bernard Kuhn, John Rigby)
> and Domen Puncer.
> 
> Using a SanDisk Extreme IV CF card I get read speeds of approximately
> 26.70 MB/sec.
> 
> The BestComm ATA task priority was changed to maximum in bestcomm_priv.h;
> this fixes a deadlock issue I was experiencing when heavy DMA was
> occuring on both the ATA and Ethernet BestComm tasks, e.g. when
> downloading a large file over a LAN to disk.
> 
> There's also what I believe to be a hardware bug if you have high levels
> of BestComm ATA DMA activity along with heavy LocalPlus Bus activity;
> the address bus seems to sometimes get corrupted with ATA commands while
> the LocalPlus Bus operation is still active (i.e. Chip Select is asserted).
> 
> I've asked Freescale about this but have not received a reply yet -- if
> anybody from Freescale has any ideas please contact me; I can supply some
> analyzer traces if needed. Therefore, for now, do not enable DMA if you
> need reliable LocalPlus Bus unless you do a fixup in your driver as
> follows:
> 
> Locking example:
> 
>         while (test_and_set_bit(0, &pata_mpc52xx_ata_dma_lock) != 0)
>         {
>                 struct bcom_task_2 *tsk = pata_mpc52xx_ata_dma_task;
> 
>                 if(bcom_buffer_done_2(tsk))
>                         return 1;
>         }
> 
> 	return 0;
> 
> (Save the return value to `flags`)
> 
> Unlocking example:
> 
>         if(flags == 0)
>                 clear_bit(0, &pata_mpc52xx_ata_dma_lock);
> 
> Comments and testing would of course be very welcome.
> 
> Thanks,
> 
> Signed-off-by: Tim Yamin <plasm@roo.me.uk>
> 
> diff -urp linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/ata.h linux-2.6.26-rc6-ata/arch/powerpc/sysdev/bestcomm/ata.h
> --- linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/ata.h	2008-04-17 03:49:44.000000000 +0100
> +++ linux-2.6.26-rc6-ata/arch/powerpc/sysdev/bestcomm/ata.h	2008-07-02 12:48:14.000000000 +0100
> @@ -16,8 +16,8 @@
>  
>  struct bcom_ata_bd {
>  	u32	status;
> -	u32	dst_pa;
>  	u32	src_pa;
> +	u32	dst_pa;
>  };

This also looks like an obvious bug fix.  A separate patch would be nice
here.

>  
>  extern struct bcom_task *
> diff -urp linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm.c linux-2.6.26-rc6-ata/arch/powerpc/sysdev/bestcomm/bestcomm.c
> --- linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm.c	2008-04-17 03:49:44.000000000 +0100
> +++ linux-2.6.26-rc6-ata/arch/powerpc/sysdev/bestcomm/bestcomm.c	2008-07-02 12:48:14.000000000 +0100
> @@ -330,11 +330,16 @@ bcom_engine_init(void)
>  	/* Init 'always' initiator */
>  	out_8(&bcom_eng->regs->ipr[BCOM_INITIATOR_ALWAYS], BCOM_IPR_ALWAYS);
>  
> +	/* If ATA DMA is enabled, always turn prefetch off (it breaks things) */
> +#ifndef CONFIG_PATA_MPC52xx_DMA
>  	/* Disable COMM Bus Prefetch on the original 5200; it's broken */
>  	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) == MPC5200_SVR) {
> +#endif
>  		regval = in_be16(&bcom_eng->regs->PtdCntrl);
>  		out_be16(&bcom_eng->regs->PtdCntrl,  regval | 1);
> +#ifndef CONFIG_PATA_MPC52xx_DMA
>  	}
> +#endif
>  
>  	/* Init lock */
>  	spin_lock_init(&bcom_eng->lock);
> diff -urp linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm.h linux-2.6.26-rc6-ata/arch/powerpc/sysdev/bestcomm/bestcomm.h
> --- linux-2.6.26-rc6/arch/powerpc/sysdev/bestcomm/bestcomm.h	2008-04-17 03:49:44.000000000 +0100
> +++ linux-2.6.26-rc6-ata/arch/powerpc/sysdev/bestcomm/bestcomm.h	2008-07-02 12:48:14.000000000 +0100
> @@ -140,15 +140,29 @@ bcom_queue_full(struct bcom_task *tsk)
>  }
>  
>  /**
> + * bcom_get_bd - Get a BD from the queue
> + * @tsk: The BestComm task structure
> + * index: Index of the BD to fetch
> + */
> +static inline struct bcom_bd
> +*bcom_get_bd(struct bcom_task *tsk, unsigned int index)
> +{
> +	return ((void *) tsk->bd) + (index * tsk->bd_size);

Since the size of a bd is not a given, change the type of bcom_task.bd
from 'struct bcom_bd *' to simply 'void *'.  That will eliminate the
need for this cast.

> +}
> +
> +/**
>   * bcom_buffer_done - Checks if a BestComm 
>   * @tsk: The BestComm task structure
>   */
>  static inline int
>  bcom_buffer_done(struct bcom_task *tsk)
>  {
> +	struct bcom_bd *bd;
>  	if (bcom_queue_empty(tsk))
>  		return 0;
> -	return !(tsk->bd[tsk->outdex].status & BCOM_BD_READY);
> +
> +	bd = bcom_get_bd(tsk, tsk->outdex);
> +	return !(bd->status & BCOM_BD_READY);
>  }
>  
>  /**
> @@ -160,16 +174,21 @@ bcom_buffer_done(struct bcom_task *tsk)
>  static inline struct bcom_bd *
>  bcom_prepare_next_buffer(struct bcom_task *tsk)
>  {
> -	tsk->bd[tsk->index].status = 0;	/* cleanup last status */
> -	return &tsk->bd[tsk->index];
> +	struct bcom_bd *bd;
> +
> +	bd = bcom_get_bd(tsk, tsk->index);
> +	bd->status = 0;	/* cleanup last status */
> +	return bd;
>  }
>  
>  static inline void
>  bcom_submit_next_buffer(struct bcom_task *tsk, void *cookie)
>  {
> +	struct bcom_bd *bd = bcom_get_bd(tsk, tsk->index);
> +
>  	tsk->cookie[tsk->index] = cookie;
>  	mb();	/* ensure the bd is really up-to-date */
> -	tsk->bd[tsk->index].status |= BCOM_BD_READY;
> +	bd->status |= BCOM_BD_READY;
>  	tsk->index = _bcom_next_index(tsk);
>  	if (tsk->flags & BCOM_FLAGS_ENABLE_TASK)
>  		bcom_enable(tsk);
> @@ -179,10 +198,12 @@ static inline void *
>  bcom_retrieve_buffer(struct bcom_task *tsk, u32 *p_status, struct bcom_bd **p_bd)
>  {
>  	void *cookie = tsk->cookie[tsk->outdex];
> +	struct bcom_bd *bd = bcom_get_bd(tsk, tsk->outdex);
> +
>  	if (p_status)
> -		*p_status = tsk->bd[tsk->outdex].status;
> +		*p_status = bd->status;
>  	if (p_bd)
> -		*p_bd = &tsk->bd[tsk->outdex];
> +		*p_bd = bd;
>  	tsk->outdex = _bcom_next_outdex(tsk);
>  	return cookie;
>  }

The bestcomm changes are much better.  Can you please split them
into a separate patch?  The common bestcomm stuff is logically separate
from the ATA driver changes.

> diff -urp linux-2.6.26-rc6/drivers/ata/pata_mpc52xx.c linux-2.6.26-rc6-ata/drivers/ata/pata_mpc52xx.c
> --- linux-2.6.26-rc6/drivers/ata/pata_mpc52xx.c	2008-07-02 12:51:27.000000000 +0100
> +++ linux-2.6.26-rc6-ata/drivers/ata/pata_mpc52xx.c	2008-07-02 12:47:14.000000000 +0100
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
> +	struct mpc52xx_ata		*ata_regs_pa;

Change this to: 'phys_addr_t ata_regs_pa;'

>  	int				ata_irq;
>  	struct mpc52xx_ata_timings	timings[2];
>  	int				csel;
> +
> +	/* DMA */
> +	struct bcom_task		*dmatsk;
> +	const struct udmaspec		*udmaspec;
> +	const struct mdmaspec		*mdmaspec;
> +	int 				mpc52xx_ata_dma_last_write;
> +	int				waiting_for_dma;
>  };
>  
>  
> @@ -53,6 +75,95 @@ static const int ataspec_ta[5]    = { 35
>  
>  #define CALC_CLKCYC(c,v) ((((v)+(c)-1)/(c)))
>  
> +/* ======================================================================== */
> +
> +/* ATAPI-4 MDMA specs (in clocks) */
> +struct mdmaspec {
> +	u32 t0M;
> +	u32 td;
> +	u32 th;
> +	u32 tj;
> +	u32 tkw;
> +	u32 tm;
> +	u32 tn;
> +};
> +
> +static const struct mdmaspec mdmaspec66[3] = {
> +	{ .t0M = 32, .td = 15, .th = 2, .tj = 2, .tkw = 15, .tm = 4, .tn = 1 },
> +	{ .t0M = 10, .td = 6, .th = 1, .tj = 1, .tkw = 4, .tm = 2, .tn = 1 },
> +	{ .t0M = 8, .td = 5, .th = 1, .tj = 1, .tkw = 2, .tm = 2, .tn = 1 },
> +};
> +
> +static const struct mdmaspec mdmaspec132[3] = {
> +	{ .t0M = 64, .td = 29, .th = 3, .tj = 3, .tkw = 29, .tm = 7, .tn = 2 },
> +	{ .t0M = 20, .td = 11, .th = 2, .tj = 1, .tkw = 7, .tm = 4, .tn = 1 },
> +	{ .t0M = 16, .td = 10, .th = 2, .tj = 1, .tkw = 4, .tm = 4, .tn = 1 },
> +};
> +
> +/* ATAPI-4 UDMA specs (in clocks) */
> +struct udmaspec {
> +	u32 tcyc;
> +	u32 t2cyc;
> +	u32 tds;
> +	u32 tdh;
> +	u32 tdvs;
> +	u32 tdvh;
> +	u32 tfs;
> +	u32 tli;
> +	u32 tmli;
> +	u32 taz;
> +	u32 tzah;
> +	u32 tenv;
> +	u32 tsr;
> +	u32 trfs;
> +	u32 trp;
> +	u32 tack;
> +	u32 tss;
> +};
> +
> +static const struct udmaspec udmaspec66[6] = {
> +	{ .tcyc = 8, .t2cyc = 16, .tds = 1, .tdh = 1, .tdvs = 5, .tdvh = 1,
> +	  .tfs = 16, .tli = 10, .tmli = 2, .taz = 1, .tzah = 2, .tenv = 2,
> +	  .tsr = 3, .trfs = 5, .trp = 11, .tack = 2, .tss = 4 },
> +	{ .tcyc = 5, .t2cyc = 11, .tds = 1, .tdh = 1, .tdvs = 4, .tdvh = 1,
> +	  .tfs = 14, .tli = 10, .tmli = 2, .taz = 1, .tzah = 2, .tenv = 2,
> +	  .tsr = 2, .trfs = 5, .trp = 9, .tack = 2, .tss = 4 },
> +	{ .tcyc = 4, .t2cyc = 8, .tds = 1, .tdh = 1, .tdvs = 3, .tdvh = 1,
> +	  .tfs = 12, .tli = 10, .tmli = 2, .taz = 1, .tzah = 2, .tenv = 2,
> +	  .tsr = 2, .trfs = 4, .trp = 7, .tack = 2, .tss = 4 },
> +	{ .tcyc = 3, .t2cyc = 6, .tds = 1, .tdh = 1, .tdvs = 2, .tdvh = 1,
> +	  .tfs = 9, .tli = 7, .tmli = 2, .taz = 1, .tzah = 2, .tenv = 2,
> +	  .tsr = 2, .trfs = 4, .trp = 7, .tack = 2, .tss = 4 },
> +	{ .tcyc = 2, .t2cyc = 4, .tds = 1, .tdh = 1, .tdvs = 1, .tdvh = 1,
> +	  .tfs = 8, .tli = 8, .tmli = 2, .taz = 1, .tzah = 2, .tenv = 2,
> +	  .tsr = 2, .trfs = 4, .trp = 7, .tack = 2, .tss = 4 },
> +	{ .tcyc = 2, .t2cyc = 2, .tds = 1, .tdh = 1, .tdvs = 1, .tdvh = 1,
> +	  .tfs = 6, .tli = 5, .tmli = 2, .taz = 1, .tzah = 2, .tenv = 2,
> +	  .tsr = 2, .trfs = 4, .trp = 6, .tack = 2, .tss = 4 },
> +};

Yes, I think this is more robust.  One (very minor) nit.  Can you line up
the elements and put the closing brackets on the same line?  Makes it a
look less like noise.  for example:

+	{ .tcyc = 8,  .t2cyc = 16, .tds  = 1,  .tdh  = 1, .tdvs = 5, .tdvh = 1,
+	  .tfs  = 16, .tli   = 10, .tmli = 2,  .taz  = 1, .tzah = 2, .tenv = 2,
+	  .tsr  = 3,  .trfs  = 5,  .trp  = 11, .tack = 2, .tss  = 4,
+	},
+	{ .tcyc = 5,  .t2cyc = 11, .tds  = 1,  .tdh  = 1, .tdvs = 4, .tdvh = 1,
+	  .tfs  = 14, .tli   = 10, .tmli = 2,  .taz  = 1, .tzah = 2, .tenv = 2,
+	  .tsr  = 2,  .trfs  = 5,  .trp  = 9,  .tack = 2, .tss  = 4,
+	},

> +
> +static const struct udmaspec udmaspec132[6] = {
> +	{ .tcyc = 15, .t2cyc = 31, .tds = 2, .tdh = 1, .tdvs = 10, .tdvh = 1,
> +	  .tfs = 30, .tli = 20, .tmli = 3, .taz = 2, .tzah = 3, .tenv = 3,
> +	  .tsr = 7, .trfs = 10, .trp = 22, .tack = 3, .tss = 7 },
> +	{ .tcyc = 10, .t2cyc = 21, .tds = 2, .tdh = 1, .tdvs = 7, .tdvh = 1,
> +	  .tfs = 27, .tli = 20, .tmli = 3, .taz = 2, .tzah = 3, .tenv = 3,
> +	  .tsr = 4, .trfs = 10, .trp = 17, .tack = 3, .tss = 7 },
> +	{ .tcyc = 6, .t2cyc = 12, .tds = 1, .tdh = 1, .tdvs = 5, .tdvh = 1,
> +	  .tfs = 23, .tli = 20, .tmli = 3, .taz = 2, .tzah = 3, .tenv = 3,
> +	  .tsr = 3, .trfs = 8, .trp = 14, .tack = 3, .tss = 7 },
> +	{ .tcyc = 7, .t2cyc = 12, .tds = 1, .tdh = 1, .tdvs = 3, .tdvh = 1,
> +	  .tfs = 15, .tli = 13, .tmli = 3, .taz = 2, .tzah = 3, .tenv = 3,
> +	  .tsr = 3, .trfs = 8, .trp = 14, .tack = 3, .tss = 7 },
> +	{ .tcyc = 2, .t2cyc = 5, .tds = 0, .tdh = 0, .tdvs = 1, .tdvh = 1,
> +	  .tfs = 16, .tli = 14, .tmli = 2, .taz = 1, .tzah = 2, .tenv = 2,
> +	  .tsr = 2, .trfs = 7, .trp = 13, .tack = 2, .tss = 6 },
> +	{ .tcyc = 3, .t2cyc = 6, .tds = 1, .tdh = 1, .tdvs = 1, .tdvh = 1,
> +	  .tfs = 12, .tli = 10, .tmli = 3, .taz = 2, .tzah = 3, .tenv = 3,
> +	  .tsr = 3, .trfs = 7, .trp = 12, .tack = 3, .tss = 7 },
> +};
> +
> +static int
> +mpc52xx_ata_compute_udma_timings(struct mpc52xx_ata_priv *priv, int dev, int speed)
> +{
> +	struct mpc52xx_ata_timings *timing = &priv->timings[dev];
> +	const struct udmaspec *s = &priv->udmaspec[speed];
> +
> +	if (speed < 0 || speed > 2)
> +		return -EINVAL;
> +
> +	timing->udma1 = (s->t2cyc << 24) | (s->tcyc << 16) | (s->tds << 8) | (s->tdh);
> +	timing->udma2 = (s->tdvs << 24) | (s->tdvh << 16) | (s->tfs << 8) | (s->tli);
> +	timing->udma3 = (s->tmli << 24) | (s->taz << 16) | (s->tenv << 8) | (s->tsr);
> +	timing->udma4 = (s->tss << 24) | (s->trfs << 16) | (s->trp << 8) | (s->tack);
> +	timing->udma5 = (s->tzah << 24);

Nit; lines over 80 characters, but it's not a big deal.  Do whatever you
think looks the nicest.

> +	timing->using_udma = 1;
> +
> +	return 0;
> +}
> +
>  static void
>  mpc52xx_ata_apply_timings(struct mpc52xx_ata_priv *priv, int device)
>  {
> @@ -173,14 +313,13 @@ mpc52xx_ata_apply_timings(struct mpc52xx
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
> -
> +	out_be32(&regs->mdma1, timing->mdma1);
> +	out_be32(&regs->mdma2, timing->mdma2);
> +	out_be32(&regs->udma1, timing->udma1);
> +	out_be32(&regs->udma2, timing->udma2);
> +	out_be32(&regs->udma3, timing->udma3);
> +	out_be32(&regs->udma4, timing->udma4);
> +	out_be32(&regs->udma5, timing->udma5);
>  	priv->csel = device;
>  }
>  
> @@ -245,6 +384,29 @@ mpc52xx_ata_set_piomode(struct ata_port 
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
> +			": Trying to select invalid DMA mode %d\n",
> +			adev->dma_mode);
> +		return;
> +	}
> +
> +	mpc52xx_ata_apply_timings(priv, adev->devno);
> +}
> +static void
>  mpc52xx_ata_dev_select(struct ata_port *ap, unsigned int device)
>  {
>  	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> @@ -255,16 +416,190 @@ mpc52xx_ata_dev_select(struct ata_port *
>  	ata_sff_dev_select(ap,device);
>  }
>  
> +static int
> +mpc52xx_ata_build_dmatable(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +	struct mpc52xx_ata *regs_pa = priv->ata_regs_pa;
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
> +		dma_addr_t cur_addr = sg_dma_address(sg);
> +		u32 cur_len = sg_dma_len(sg);
> +
> +		while (cur_len) {
> +			unsigned int tc = min(cur_len, MAX_DMA_BUFFER_SIZE);
> +			struct bcom_ata_bd *bd = (struct bcom_ata_bd *) bcom_prepare_next_buffer(priv->dmatsk);
> +
> +			if (read) {
> +				bd->status = tc;
> +				bd->src_pa = (__force u32) &regs_pa->fifo_data;
> +				bd->dst_pa = (__force u32) cur_addr;
> +			} else {
> +				bd->status = tc;
> +				bd->src_pa = (__force u32) cur_addr;
> +				bd->dst_pa = (__force u32) &regs_pa->fifo_data;

These are the ugly casts of physical addresses stored in __iomem
pointers and then cast back into u32.  ata_regs_pa should be phys_addr_t
and &regs_pa->fifo_data should be changed to:
	ata_regs_pa + offsetof(struct mpc52xx_ata, fifo_data);

Truth be told; I'm not at all fond of using a structure to define
register offsets, but that is not a comment on this patch.  All the
5200 code is already written that way, so it is better to be consistent.

> +			}
> +
> +			bcom_submit_next_buffer(priv->dmatsk, NULL);
> +
> +			cur_addr += tc;
> +			cur_len -= tc;
> +			count++;
> +
> +			if (count > MAX_DMA_BUFFERS) {
> +				printk(KERN_ALERT "%s: %i dma table"
> +					"too small\n", __func__, __LINE__);
> +				goto use_pio_instead;
> +			}
> +		}
> +	}
> +	return 1;
> +
> +use_pio_instead:

It is good practise to indent goto labels with 1 space (not tab).  Doing
so means that diff will do the right thing on displaying the c function
name when a line changes after the label.

> +	bcom_ata_reset_bd(priv->dmatsk);
> +	return 0;
> +}
> +
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
> +	if (!mpc52xx_ata_build_dmatable(qc))
> +		printk(KERN_ALERT "%s: %i, return 1?\n", __func__, __LINE__);

You should use the dev_alert() macros instead of printk().  Ditto through
the rest of the file.  Look in include/linux/device.h for the full list.

> +
> +	/* Check FIFO is OK... */
> +	if(in_8(&priv->ata_regs->fifo_status) & MPC52xx_ATA_FIFOSTAT_ERROR)
> +		printk(KERN_ALERT "%s: FIFO error detected: 0x%02x!\n",
> +			__func__, in_8(&priv->ata_regs->fifo_status));
> +
> +	if (read) {
> +		dma_mode = MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_READ |
> +				MPC52xx_ATA_DMAMODE_FE;
> +
> +		/* Setup FIFO if direction changed */
> +		if (priv->mpc52xx_ata_dma_last_write != 0) {
> +			priv->mpc52xx_ata_dma_last_write = 0;
> +
> +			/* Configure FIFO with granularity to 7 */
> +			out_8(&regs->fifo_control, 7);
> +			out_be16(&regs->fifo_alarm, 128);
> +
> +			/* Set FIFO Reset bit (FR) */
> +			out_8(&regs->dma_mode, MPC52xx_ATA_DMAMODE_FR);
> +		}
> +	} else {
> +		dma_mode = MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_WRITE;
> +
> +		/* Setup FIFO if direction changed */
> +		if (priv->mpc52xx_ata_dma_last_write != 1) {
> +			priv->mpc52xx_ata_dma_last_write = 1;
> +
> +			/* Configure FIFO with granularity to 4 */
> +			out_8(&regs->fifo_control, 4);
> +			out_be16(&regs->fifo_alarm, 128);
> +		}
> +	}
> +
> +	if (priv->timings[qc->dev->devno].using_udma)
> +		dma_mode |= MPC52xx_ATA_DMAMODE_UDMA;
> +
> +	out_8(&regs->dma_mode, dma_mode);
> +	priv->waiting_for_dma = ATA_DMA_ACTIVE;
> +
> +	ata_wait_idle(ap);
> +	ap->ops->sff_exec_command(ap, &qc->tf);
> +}
> +
> +static void
> +mpc52xx_bmdma_start(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +
> +	/* LocalBus lock */
> +	while (test_and_set_bit(0, &pata_mpc52xx_ata_dma_lock) != 0)
> +		;

Need to be able to bail on timeout.

> +
> +	bcom_set_task_auto_start(priv->dmatsk->tasknum, priv->dmatsk->tasknum);
> +	bcom_enable(priv->dmatsk);
> +}
> +
> +static void
> +mpc52xx_bmdma_stop(struct ata_queued_cmd *qc)
> +{
> +	struct ata_port *ap = qc->ap;
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +
> +	bcom_disable(priv->dmatsk);
> +	bcom_ata_reset_bd(priv->dmatsk);
> +
> +	/* LocalBus unlock*/
> +	clear_bit(0, &pata_mpc52xx_ata_dma_lock);
> +
> +	priv->waiting_for_dma = 0;
> +
> +	/* Check FIFO is OK... */
> +	if(in_8(&priv->ata_regs->fifo_status) & MPC52xx_ATA_FIFOSTAT_ERROR)
> +		printk(KERN_ALERT "%s: FIFO error detected: 0x%02x!\n",
> +			__func__, in_8(&priv->ata_regs->fifo_status));
> +}
> +
> +static u8
> +mpc52xx_bmdma_status(struct ata_port *ap)
> +{
> +	struct mpc52xx_ata_priv *priv = ap->host->private_data;
> +
> +	/* Check FIFO is OK... */
> +	if(in_8(&priv->ata_regs->fifo_status) & MPC52xx_ATA_FIFOSTAT_ERROR) {
> +		printk(KERN_ALERT "%s: FIFO error detected: 0x%02x!\n",
> +			__func__, in_8(&priv->ata_regs->fifo_status));
> +		return priv->waiting_for_dma | ATA_DMA_ERR;
> +	}
> +
> +	return priv->waiting_for_dma;
> +}
> +
> +static irqreturn_t
> +mpc52xx_ata_task_irq(int irq, void *vpriv)
> +{
> +	struct mpc52xx_ata_priv *priv = vpriv;
> +	priv->waiting_for_dma |= ATA_DMA_INTR;
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static struct scsi_host_template mpc52xx_ata_sht = {
>  	ATA_PIO_SHT(DRV_NAME),
>  };
>  
>  static struct ata_port_operations mpc52xx_ata_port_ops = {
>  	.inherits		= &ata_sff_port_ops,
> -	.sff_dev_select		= mpc52xx_ata_dev_select,
> -	.cable_detect		= ata_cable_40wire,
> +
>  	.set_piomode		= mpc52xx_ata_set_piomode,
> -	.post_internal_cmd	= ATA_OP_NULL,
> +	.set_dmamode		= mpc52xx_ata_set_dmamode,
> +	.sff_dev_select		= mpc52xx_ata_dev_select,
> +
> +	.bmdma_setup		= mpc52xx_bmdma_setup,
> +	.bmdma_start		= mpc52xx_bmdma_start,
> +	.bmdma_stop		= mpc52xx_bmdma_stop,
> +	.bmdma_status		= mpc52xx_bmdma_status,
> +
> +	.qc_prep		= ata_noop_qc_prep,
>  };
>  
>  static int __devinit
> @@ -281,9 +615,14 @@ mpc52xx_ata_init_one(struct device *dev,
>  
>  	ap = host->ports[0];
>  	ap->flags		|= ATA_FLAG_SLAVE_POSS;
> -	ap->pio_mask		= 0x1f;	/* Up to PIO4 */
> -	ap->mwdma_mask		= 0x00;	/* No MWDMA   */
> -	ap->udma_mask		= 0x00;	/* No UDMA    */
> +	ap->pio_mask		= ATA_PIO4;	/* Up to PIO4 */
> +#ifdef CONFIG_PATA_MPC52xx_DMA
> +	ap->mwdma_mask		= ATA_MWDMA2;	/* Up to MWDMA2 */
> +	ap->udma_mask		= ATA_UDMA2;	/* Up to UDMA2 */
> +#else
> +	ap->mwdma_mask		= 0x00;		/* No MWDMA */
> +	ap->udma_mask		= 0x00;		/* No UDMA */
> +#endif

ap->* values are already zeroed.  You can drop the whole of the #else
side of this clause.  (the old code didn't need to set them to zero).

>  	ap->ops			= &mpc52xx_ata_port_ops;
>  	host->private_data	= priv;
>  
> @@ -333,7 +672,7 @@ mpc52xx_ata_probe(struct of_device *op, 
>  	int ata_irq;
>  	struct mpc52xx_ata __iomem *ata_regs;
>  	struct mpc52xx_ata_priv *priv;
> -	int rv;
> +	int rv, ret, task_irq;
>  
>  	/* Get ipb frequency */
>  	ipb_freq = mpc52xx_find_ipb_freq(op->node);
> @@ -389,8 +728,34 @@ mpc52xx_ata_probe(struct of_device *op, 
>  
>  	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
>  	priv->ata_regs = ata_regs;
> +	priv->ata_regs_pa = (struct mpc52xx_ata *) res_mem.start;

And this should simply be: priv->ata_regs_pa = res_mem.start;

>  	priv->ata_irq = ata_irq;
>  	priv->csel = -1;
> +	priv->mpc52xx_ata_dma_last_write = -1;
> +
> +	if (ipb_freq/1000000 == 66) {
> +		priv->mdmaspec = mdmaspec66;
> +		priv->udmaspec = udmaspec66;
> +	} else {
> +		priv->mdmaspec = mdmaspec132;
> +		priv->udmaspec = udmaspec132;
> +	}
> +
> +	pata_mpc52xx_ata_dma_lock = 0;
> +	priv->dmatsk = bcom_ata_init(MAX_DMA_BUFFERS, MAX_DMA_BUFFER_SIZE);
> +	pata_mpc52xx_ata_dma_task = priv->dmatsk;
> +	if (!priv->dmatsk) {
> +		printk(KERN_ALERT "%s: %i\n", __func__, __LINE__);
> +		rv = -ENOMEM;
> +		goto err;
> +	}
> +
> +	task_irq = bcom_get_task_irq(priv->dmatsk);
> +	ret = request_irq(task_irq, &mpc52xx_ata_task_irq, IRQF_DISABLED,
> +				"ATA task", priv);
> +	if (ret)
> +		printk(KERN_ALERT "%s: request_irq failed with: "
> +					"%i\n", __func__, ret);
>  
>  	/* Init the hw */
>  	rv = mpc52xx_ata_hw_init(priv);
