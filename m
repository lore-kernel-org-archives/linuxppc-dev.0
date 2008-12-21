Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 5FAF5474E0
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 19:06:40 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2289593rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 00:06:40 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 4/4] powerpc/mpc5200: Add MDMA/UDMA support to MPC5200 ATA
	driver
To: linuxppc-dev@ozlabs.org, hans.lehmann@ritter-elektronik.de,
	matt@genesi-usa.com, olaf@aepfle.de
Date: Sun, 21 Dec 2008 01:06:35 -0700
Message-ID: <20081221080635.29029.39493.stgit@localhost.localdomain>
In-Reply-To: <20081221080213.29029.7646.stgit@localhost.localdomain>
References: <20081221080213.29029.7646.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Tim Yamin <plasm@roo.me.uk>

This patch adds MDMA/UDMA support using BestComm for DMA on the MPC5200
platform.  Based heavily on previous work by Freescale (Bernard Kuhn,
John Rigby) and Domen Puncer.

With this patch, a SanDisk Extreme IV CF card gets read speeds of
approximately 26.70 MB/sec.

Signed-off-by: Tim Yamin <plasm@roo.me.uk>
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/sysdev/bestcomm/ata.h |   17 -
 drivers/ata/Kconfig                |    3 
 drivers/ata/pata_mpc52xx.c         |  546 ++++++++++++++++++++++++++++++++----
 3 files changed, 488 insertions(+), 78 deletions(-)


diff --git a/arch/powerpc/sysdev/bestcomm/ata.h b/arch/powerpc/sysdev/bestcomm/ata.h
index 0374322..0b23718 100644
--- a/arch/powerpc/sysdev/bestcomm/ata.h
+++ b/arch/powerpc/sysdev/bestcomm/ata.h
@@ -20,18 +20,11 @@ struct bcom_ata_bd {
 	u32	dst_pa;
 };
 
-extern struct bcom_task *
-bcom_ata_init(int queue_len, int maxbufsize);
-
-extern void
-bcom_ata_rx_prepare(struct bcom_task *tsk);
-
-extern void
-bcom_ata_tx_prepare(struct bcom_task *tsk);
-
-extern void
-bcom_ata_reset_bd(struct bcom_task *tsk);
-
+extern struct bcom_task * bcom_ata_init(int queue_len, int maxbufsize);
+extern void bcom_ata_rx_prepare(struct bcom_task *tsk);
+extern void bcom_ata_tx_prepare(struct bcom_task *tsk);
+extern void bcom_ata_reset_bd(struct bcom_task *tsk);
+extern void bcom_ata_release(struct bcom_task *tsk);
 
 #endif /* __BESTCOMM_ATA_H__ */
 
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 421b7c7..1a7be96 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -456,7 +456,8 @@ config PATA_MARVELL
 
 config PATA_MPC52xx
 	tristate "Freescale MPC52xx SoC internal IDE"
-	depends on PPC_MPC52xx
+	depends on PPC_MPC52xx && PPC_BESTCOMM
+	select PPC_BESTCOMM_ATA
 	help
 	  This option enables support for integrated IDE controller
 	  of the Freescale MPC52xx SoC.
diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index a9e8273..50ae6d1 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -6,6 +6,9 @@
  * Copyright (C) 2006 Sylvain Munaut <tnt@246tNt.com>
  * Copyright (C) 2003 Mipsys - Benjamin Herrenschmidt
  *
+ * UDMA support based on patches by Freescale (Bernard Kuhn, John Rigby),
+ * Domen Puncer and Tim Yamin.
+ *
  * This file is licensed under the terms of the GNU General Public License
  * version 2. This program is licensed "as is" without any warranty of any
  * kind, whether express or implied.
@@ -17,28 +20,46 @@
 #include <linux/delay.h>
 #include <linux/libata.h>
 #include <linux/of_platform.h>
+#include <linux/types.h>
 
-#include <asm/types.h>
+#include <asm/cacheflush.h>
 #include <asm/prom.h>
 #include <asm/mpc52xx.h>
 
+#include <sysdev/bestcomm/bestcomm.h>
+#include <sysdev/bestcomm/bestcomm_priv.h>
+#include <sysdev/bestcomm/ata.h>
 
 #define DRV_NAME	"mpc52xx_ata"
-#define DRV_VERSION	"0.1.2"
-
 
 /* Private structures used by the driver */
 struct mpc52xx_ata_timings {
 	u32	pio1;
 	u32	pio2;
+	u32	mdma1;
+	u32	mdma2;
+	u32	udma1;
+	u32	udma2;
+	u32	udma3;
+	u32	udma4;
+	u32	udma5;
+	int	using_udma;
 };
 
 struct mpc52xx_ata_priv {
 	unsigned int			ipb_period;
-	struct mpc52xx_ata __iomem *	ata_regs;
+	struct mpc52xx_ata __iomem	*ata_regs;
+	phys_addr_t			ata_regs_pa;
 	int				ata_irq;
 	struct mpc52xx_ata_timings	timings[2];
 	int				csel;
+
+	/* DMA */
+	struct bcom_task		*dmatsk;
+	const struct udmaspec		*udmaspec;
+	const struct mdmaspec		*mdmaspec;
+	int 				mpc52xx_ata_dma_last_write;
+	int				waiting_for_dma;
 };
 
 
@@ -53,6 +74,107 @@ static const int ataspec_ta[5]    = { 35,  35,  35,  35,  35};
 
 #define CALC_CLKCYC(c,v) ((((v)+(c)-1)/(c)))
 
+/* ======================================================================== */
+
+/* ATAPI-4 MDMA specs (in clocks) */
+struct mdmaspec {
+	u32 t0M;
+	u32 td;
+	u32 th;
+	u32 tj;
+	u32 tkw;
+	u32 tm;
+	u32 tn;
+};
+
+static const struct mdmaspec mdmaspec66[3] = {
+	{ .t0M = 32, .td = 15, .th = 2, .tj = 2, .tkw = 15, .tm = 4, .tn = 1 },
+	{ .t0M = 10, .td = 6,  .th = 1, .tj = 1, .tkw = 4,  .tm = 2, .tn = 1 },
+	{ .t0M = 8,  .td = 5,  .th = 1, .tj = 1, .tkw = 2,  .tm = 2, .tn = 1 },
+};
+
+static const struct mdmaspec mdmaspec132[3] = {
+	{ .t0M = 64, .td = 29, .th = 3, .tj = 3, .tkw = 29, .tm = 7, .tn = 2 },
+	{ .t0M = 20, .td = 11, .th = 2, .tj = 1, .tkw = 7,  .tm = 4, .tn = 1 },
+	{ .t0M = 16, .td = 10, .th = 2, .tj = 1, .tkw = 4,  .tm = 4, .tn = 1 },
+};
+
+/* ATAPI-4 UDMA specs (in clocks) */
+struct udmaspec {
+	u32 tcyc;
+	u32 t2cyc;
+	u32 tds;
+	u32 tdh;
+	u32 tdvs;
+	u32 tdvh;
+	u32 tfs;
+	u32 tli;
+	u32 tmli;
+	u32 taz;
+	u32 tzah;
+	u32 tenv;
+	u32 tsr;
+	u32 trfs;
+	u32 trp;
+	u32 tack;
+	u32 tss;
+};
+
+static const struct udmaspec udmaspec66[6] = {
+	{ .tcyc = 8,  .t2cyc = 16, .tds  = 1,  .tdh  = 1, .tdvs = 5,  .tdvh = 1,
+	  .tfs  = 16, .tli   = 10, .tmli = 2,  .taz  = 1, .tzah = 2,  .tenv = 2,
+	  .tsr  = 3,  .trfs  = 5,  .trp  = 11, .tack = 2, .tss  = 4,
+	},
+	{ .tcyc = 5,  .t2cyc = 11, .tds  = 1,  .tdh  = 1, .tdvs = 4,  .tdvh = 1,
+	  .tfs  = 14, .tli   = 10, .tmli = 2,  .taz  = 1, .tzah = 2,  .tenv = 2,
+	  .tsr  = 2,  .trfs  = 5,  .trp  = 9,  .tack = 2, .tss  = 4,
+	},
+	{ .tcyc = 4,  .t2cyc = 8,  .tds  = 1,  .tdh  = 1, .tdvs = 3,  .tdvh = 1,
+	  .tfs  = 12, .tli   = 10, .tmli = 2,  .taz  = 1, .tzah = 2,  .tenv = 2,
+	  .tsr  = 2,  .trfs  = 4,  .trp  = 7,  .tack = 2, .tss  = 4,
+	},
+	{ .tcyc = 3,  .t2cyc = 6,  .tds  = 1,  .tdh  = 1, .tdvs = 2,  .tdvh = 1,
+	  .tfs  = 9,  .tli   = 7,  .tmli = 2,  .taz  = 1, .tzah = 2,  .tenv = 2,
+	  .tsr  = 2,  .trfs  = 4,  .trp  = 7,  .tack = 2, .tss  = 4,
+	},
+	{ .tcyc = 2,  .t2cyc = 4,  .tds  = 1,  .tdh  = 1, .tdvs = 1,  .tdvh = 1,
+	  .tfs  = 8,  .tli   = 8,  .tmli = 2,  .taz  = 1, .tzah = 2,  .tenv = 2,
+	  .tsr  = 2,  .trfs  = 4,  .trp  = 7,  .tack = 2, .tss  = 4,
+	},
+	{ .tcyc = 2,  .t2cyc = 2,  .tds  = 1,  .tdh  = 1, .tdvs = 1,  .tdvh = 1,
+	  .tfs  = 6,  .tli   = 5,  .tmli = 2,  .taz  = 1, .tzah = 2,  .tenv = 2,
+	  .tsr  = 2,  .trfs  = 4,  .trp  = 6,  .tack = 2, .tss  = 4,
+	},
+};
+
+static const struct udmaspec udmaspec132[6] = {
+	{ .tcyc = 15, .t2cyc = 31, .tds  = 2,  .tdh  = 1, .tdvs = 10, .tdvh = 1,
+	  .tfs  = 30, .tli   = 20, .tmli = 3,  .taz  = 2, .tzah = 3,  .tenv = 3,
+	  .tsr  = 7,  .trfs  = 10, .trp  = 22, .tack = 3, .tss  = 7,
+	},
+	{ .tcyc = 10, .t2cyc = 21, .tds  = 2,  .tdh  = 1, .tdvs = 7,  .tdvh = 1,
+	  .tfs  = 27, .tli   = 20, .tmli = 3,  .taz  = 2, .tzah = 3,  .tenv = 3,
+	  .tsr  = 4,  .trfs  = 10, .trp  = 17, .tack = 3, .tss  = 7,
+	},
+	{ .tcyc = 6,  .t2cyc = 12, .tds  = 1,  .tdh  = 1, .tdvs = 5,  .tdvh = 1,
+	  .tfs  = 23, .tli   = 20, .tmli = 3,  .taz  = 2, .tzah = 3,  .tenv = 3,
+	  .tsr  = 3,  .trfs  = 8,  .trp  = 14, .tack = 3, .tss  = 7,
+	},
+	{ .tcyc = 7,  .t2cyc = 12, .tds  = 1,  .tdh  = 1, .tdvs = 3,  .tdvh = 1,
+	  .tfs  = 15, .tli   = 13, .tmli = 3,  .taz  = 2, .tzah = 3,  .tenv = 3,
+	  .tsr  = 3,  .trfs  = 8,  .trp  = 14, .tack = 3, .tss  = 7,
+	},
+	{ .tcyc = 2,  .t2cyc = 5,  .tds  = 0,  .tdh  = 0, .tdvs = 1,  .tdvh = 1,
+	  .tfs  = 16, .tli   = 14, .tmli = 2,  .taz  = 1, .tzah = 2,  .tenv = 2,
+	  .tsr  = 2,  .trfs  = 7,  .trp  = 13, .tack = 2, .tss  = 6,
+	},
+	{ .tcyc = 3,  .t2cyc = 6,  .tds  = 1,  .tdh  = 1, .tdvs = 1,  .tdvh = 1,
+	  .tfs  = 12, .tli   = 10, .tmli = 3,  .taz  = 2, .tzah = 3,  .tenv = 3,
+	  .tsr  = 3,  .trfs  = 7,  .trp  = 12, .tack = 3, .tss  = 7,
+	},
+};
+
+/* ======================================================================== */
 
 /* Bit definitions inside the registers */
 #define MPC52xx_ATA_HOSTCONF_SMR	0x80000000UL /* State machine reset */
@@ -66,6 +188,7 @@ static const int ataspec_ta[5]    = { 35,  35,  35,  35,  35};
 #define MPC52xx_ATA_HOSTSTAT_WERR	0x01000000UL /* Write Error */
 
 #define MPC52xx_ATA_FIFOSTAT_EMPTY	0x01 /* FIFO Empty */
+#define MPC52xx_ATA_FIFOSTAT_ERROR	0x40 /* FIFO Error */
 
 #define MPC52xx_ATA_DMAMODE_WRITE	0x01 /* Write DMA */
 #define MPC52xx_ATA_DMAMODE_READ	0x02 /* Read DMA */
@@ -75,6 +198,8 @@ static const int ataspec_ta[5]    = { 35,  35,  35,  35,  35};
 #define MPC52xx_ATA_DMAMODE_FR		0x20 /* FIFO Reset */
 #define MPC52xx_ATA_DMAMODE_HUT		0x40 /* Host UDMA burst terminate */
 
+#define MAX_DMA_BUFFERS 128
+#define MAX_DMA_BUFFER_SIZE 0x20000u
 
 /* Structure of the hardware registers */
 struct mpc52xx_ata {
@@ -140,7 +265,6 @@ struct mpc52xx_ata {
 
 
 /* MPC52xx low level hw control */
-
 static int
 mpc52xx_ata_compute_pio_timings(struct mpc52xx_ata_priv *priv, int dev, int pio)
 {
@@ -148,7 +272,7 @@ mpc52xx_ata_compute_pio_timings(struct mpc52xx_ata_priv *priv, int dev, int pio)
 	unsigned int ipb_period = priv->ipb_period;
 	unsigned int t0, t1, t2_8, t2_16, t2i, t4, ta;
 
-	if ((pio<0) || (pio>4))
+	if ((pio < 0) || (pio > 4))
 		return -EINVAL;
 
 	t0	= CALC_CLKCYC(ipb_period, 1000 * ataspec_t0[pio]);
@@ -165,6 +289,43 @@ mpc52xx_ata_compute_pio_timings(struct mpc52xx_ata_priv *priv, int dev, int pio)
 	return 0;
 }
 
+static int
+mpc52xx_ata_compute_mdma_timings(struct mpc52xx_ata_priv *priv, int dev,
+				 int speed)
+{
+	struct mpc52xx_ata_timings *t = &priv->timings[dev];
+	const struct mdmaspec *s = &priv->mdmaspec[speed];
+
+	if (speed < 0 || speed > 2)
+		return -EINVAL;
+
+	t->mdma1 = (s->t0M << 24) | (s->td << 16) | (s->tkw << 8) | (s->tm);
+	t->mdma2 = (s->th << 24) | (s->tj << 16) | (s->tn << 8);
+	t->using_udma = 0;
+
+	return 0;
+}
+
+static int
+mpc52xx_ata_compute_udma_timings(struct mpc52xx_ata_priv *priv, int dev,
+				 int speed)
+{
+	struct mpc52xx_ata_timings *t = &priv->timings[dev];
+	const struct udmaspec *s = &priv->udmaspec[speed];
+
+	if (speed < 0 || speed > 2)
+		return -EINVAL;
+
+	t->udma1 = (s->t2cyc << 24) | (s->tcyc << 16) | (s->tds << 8) | s->tdh;
+	t->udma2 = (s->tdvs << 24) | (s->tdvh << 16) | (s->tfs << 8) | s->tli;
+	t->udma3 = (s->tmli << 24) | (s->taz << 16) | (s->tenv << 8) | s->tsr;
+	t->udma4 = (s->tss << 24) | (s->trfs << 16) | (s->trp << 8) | s->tack;
+	t->udma5 = (s->tzah << 24);
+	t->using_udma = 1;
+
+	return 0;
+}
+
 static void
 mpc52xx_ata_apply_timings(struct mpc52xx_ata_priv *priv, int device)
 {
@@ -173,14 +334,13 @@ mpc52xx_ata_apply_timings(struct mpc52xx_ata_priv *priv, int device)
 
 	out_be32(&regs->pio1,  timing->pio1);
 	out_be32(&regs->pio2,  timing->pio2);
-	out_be32(&regs->mdma1, 0);
-	out_be32(&regs->mdma2, 0);
-	out_be32(&regs->udma1, 0);
-	out_be32(&regs->udma2, 0);
-	out_be32(&regs->udma3, 0);
-	out_be32(&regs->udma4, 0);
-	out_be32(&regs->udma5, 0);
-
+	out_be32(&regs->mdma1, timing->mdma1);
+	out_be32(&regs->mdma2, timing->mdma2);
+	out_be32(&regs->udma1, timing->udma1);
+	out_be32(&regs->udma2, timing->udma2);
+	out_be32(&regs->udma3, timing->udma3);
+	out_be32(&regs->udma4, timing->udma4);
+	out_be32(&regs->udma5, timing->udma5);
 	priv->csel = device;
 }
 
@@ -208,7 +368,7 @@ mpc52xx_ata_hw_init(struct mpc52xx_ata_priv *priv)
 
 	/* Set the time slot to 1us */
 	tslot = CALC_CLKCYC(priv->ipb_period, 1000000);
-	out_be32(&regs->share_cnt, tslot << 16 );
+	out_be32(&regs->share_cnt, tslot << 16);
 
 	/* Init timings to PIO0 */
 	memset(priv->timings, 0x00, 2*sizeof(struct mpc52xx_ata_timings));
@@ -237,13 +397,37 @@ mpc52xx_ata_set_piomode(struct ata_port *ap, struct ata_device *adev)
 	rv = mpc52xx_ata_compute_pio_timings(priv, adev->devno, pio);
 
 	if (rv) {
-		printk(KERN_ERR DRV_NAME
-			": Trying to select invalid PIO mode %d\n", pio);
+		dev_err(ap->dev, "error: invalid PIO mode: %d\n", pio);
+		return;
+	}
+
+	mpc52xx_ata_apply_timings(priv, adev->devno);
+}
+
+static void
+mpc52xx_ata_set_dmamode(struct ata_port *ap, struct ata_device *adev)
+{
+	struct mpc52xx_ata_priv *priv = ap->host->private_data;
+	int rv;
+
+	if (adev->dma_mode >= XFER_UDMA_0) {
+		int dma = adev->dma_mode - XFER_UDMA_0;
+		rv = mpc52xx_ata_compute_udma_timings(priv, adev->devno, dma);
+	} else {
+		int dma = adev->dma_mode - XFER_MW_DMA_0;
+		rv = mpc52xx_ata_compute_mdma_timings(priv, adev->devno, dma);
+	}
+
+	if (rv) {
+		dev_alert(ap->dev,
+			"Trying to select invalid DMA mode %d\n",
+			adev->dma_mode);
 		return;
 	}
 
 	mpc52xx_ata_apply_timings(priv, adev->devno);
 }
+
 static void
 mpc52xx_ata_dev_select(struct ata_port *ap, unsigned int device)
 {
@@ -252,7 +436,173 @@ mpc52xx_ata_dev_select(struct ata_port *ap, unsigned int device)
 	if (device != priv->csel)
 		mpc52xx_ata_apply_timings(priv, device);
 
-	ata_sff_dev_select(ap,device);
+	ata_sff_dev_select(ap, device);
+}
+
+static int
+mpc52xx_ata_build_dmatable(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct mpc52xx_ata_priv *priv = ap->host->private_data;
+	struct bcom_ata_bd *bd;
+	unsigned int read = !(qc->tf.flags & ATA_TFLAG_WRITE), si;
+	struct scatterlist *sg;
+	int count = 0;
+
+	if (read)
+		bcom_ata_rx_prepare(priv->dmatsk);
+	else
+		bcom_ata_tx_prepare(priv->dmatsk);
+
+	for_each_sg(qc->sg, sg, qc->n_elem, si) {
+		dma_addr_t cur_addr = sg_dma_address(sg);
+		u32 cur_len = sg_dma_len(sg);
+
+		while (cur_len) {
+			unsigned int tc = min(cur_len, MAX_DMA_BUFFER_SIZE);
+			bd = (struct bcom_ata_bd *)
+				bcom_prepare_next_buffer(priv->dmatsk);
+
+			if (read) {
+				bd->status = tc;
+				bd->src_pa = (__force u32) priv->ata_regs_pa +
+					offsetof(struct mpc52xx_ata, fifo_data);
+				bd->dst_pa = (__force u32) cur_addr;
+			} else {
+				bd->status = tc;
+				bd->src_pa = (__force u32) cur_addr;
+				bd->dst_pa = (__force u32) priv->ata_regs_pa +
+					offsetof(struct mpc52xx_ata, fifo_data);
+			}
+
+			bcom_submit_next_buffer(priv->dmatsk, NULL);
+
+			cur_addr += tc;
+			cur_len -= tc;
+			count++;
+
+			if (count > MAX_DMA_BUFFERS) {
+				dev_alert(ap->dev, "dma table"
+					"too small\n");
+				goto use_pio_instead;
+			}
+		}
+	}
+	return 1;
+
+ use_pio_instead:
+	bcom_ata_reset_bd(priv->dmatsk);
+	return 0;
+}
+
+static void
+mpc52xx_bmdma_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct mpc52xx_ata_priv *priv = ap->host->private_data;
+	struct mpc52xx_ata __iomem *regs = priv->ata_regs;
+
+	unsigned int read = !(qc->tf.flags & ATA_TFLAG_WRITE);
+	u8 dma_mode;
+
+	if (!mpc52xx_ata_build_dmatable(qc))
+		dev_alert(ap->dev, "%s: %i, return 1?\n",
+			__func__, __LINE__);
+
+	/* Check FIFO is OK... */
+	if (in_8(&priv->ata_regs->fifo_status) & MPC52xx_ATA_FIFOSTAT_ERROR)
+		dev_alert(ap->dev, "%s: FIFO error detected: 0x%02x!\n",
+			__func__, in_8(&priv->ata_regs->fifo_status));
+
+	if (read) {
+		dma_mode = MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_READ |
+				MPC52xx_ATA_DMAMODE_FE;
+
+		/* Setup FIFO if direction changed */
+		if (priv->mpc52xx_ata_dma_last_write != 0) {
+			priv->mpc52xx_ata_dma_last_write = 0;
+
+			/* Configure FIFO with granularity to 7 */
+			out_8(&regs->fifo_control, 7);
+			out_be16(&regs->fifo_alarm, 128);
+
+			/* Set FIFO Reset bit (FR) */
+			out_8(&regs->dma_mode, MPC52xx_ATA_DMAMODE_FR);
+		}
+	} else {
+		dma_mode = MPC52xx_ATA_DMAMODE_IE | MPC52xx_ATA_DMAMODE_WRITE;
+
+		/* Setup FIFO if direction changed */
+		if (priv->mpc52xx_ata_dma_last_write != 1) {
+			priv->mpc52xx_ata_dma_last_write = 1;
+
+			/* Configure FIFO with granularity to 4 */
+			out_8(&regs->fifo_control, 4);
+			out_be16(&regs->fifo_alarm, 128);
+		}
+	}
+
+	if (priv->timings[qc->dev->devno].using_udma)
+		dma_mode |= MPC52xx_ATA_DMAMODE_UDMA;
+
+	out_8(&regs->dma_mode, dma_mode);
+	priv->waiting_for_dma = ATA_DMA_ACTIVE;
+
+	ata_wait_idle(ap);
+	ap->ops->sff_exec_command(ap, &qc->tf);
+}
+
+static void
+mpc52xx_bmdma_start(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct mpc52xx_ata_priv *priv = ap->host->private_data;
+
+	bcom_set_task_auto_start(priv->dmatsk->tasknum, priv->dmatsk->tasknum);
+	bcom_enable(priv->dmatsk);
+}
+
+static void
+mpc52xx_bmdma_stop(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct mpc52xx_ata_priv *priv = ap->host->private_data;
+
+	bcom_disable(priv->dmatsk);
+	bcom_ata_reset_bd(priv->dmatsk);
+	priv->waiting_for_dma = 0;
+
+	/* Check FIFO is OK... */
+	if (in_8(&priv->ata_regs->fifo_status) & MPC52xx_ATA_FIFOSTAT_ERROR)
+		dev_alert(ap->dev, "%s: FIFO error detected: 0x%02x!\n",
+			__func__, in_8(&priv->ata_regs->fifo_status));
+}
+
+static u8
+mpc52xx_bmdma_status(struct ata_port *ap)
+{
+	struct mpc52xx_ata_priv *priv = ap->host->private_data;
+
+	/* Check FIFO is OK... */
+	if (in_8(&priv->ata_regs->fifo_status) & MPC52xx_ATA_FIFOSTAT_ERROR) {
+		dev_alert(ap->dev, "%s: FIFO error detected: 0x%02x!\n",
+			__func__, in_8(&priv->ata_regs->fifo_status));
+		return priv->waiting_for_dma | ATA_DMA_ERR;
+	}
+
+	return priv->waiting_for_dma;
+}
+
+static irqreturn_t
+mpc52xx_ata_task_irq(int irq, void *vpriv)
+{
+	struct mpc52xx_ata_priv *priv = vpriv;
+	while (bcom_buffer_done(priv->dmatsk))
+		bcom_retrieve_buffer(priv->dmatsk, NULL, NULL);
+
+	priv->waiting_for_dma |= ATA_DMA_INTR;
+
+	return IRQ_HANDLED;
 }
 
 static struct scsi_host_template mpc52xx_ata_sht = {
@@ -262,14 +612,18 @@ static struct scsi_host_template mpc52xx_ata_sht = {
 static struct ata_port_operations mpc52xx_ata_port_ops = {
 	.inherits		= &ata_sff_port_ops,
 	.sff_dev_select		= mpc52xx_ata_dev_select,
-	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= mpc52xx_ata_set_piomode,
-	.post_internal_cmd	= ATA_OP_NULL,
+	.set_dmamode		= mpc52xx_ata_set_dmamode,
+	.bmdma_setup		= mpc52xx_bmdma_setup,
+	.bmdma_start		= mpc52xx_bmdma_start,
+	.bmdma_stop		= mpc52xx_bmdma_stop,
+	.bmdma_status		= mpc52xx_bmdma_status,
+	.qc_prep		= ata_noop_qc_prep,
 };
 
 static int __devinit
 mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv,
-		     unsigned long raw_ata_regs)
+		     unsigned long raw_ata_regs, int mwdma_mask, int udma_mask)
 {
 	struct ata_host *host;
 	struct ata_port *ap;
@@ -281,9 +635,9 @@ mpc52xx_ata_init_one(struct device *dev, struct mpc52xx_ata_priv *priv,
 
 	ap = host->ports[0];
 	ap->flags		|= ATA_FLAG_SLAVE_POSS;
-	ap->pio_mask		= 0x1f;	/* Up to PIO4 */
-	ap->mwdma_mask		= 0x00;	/* No MWDMA   */
-	ap->udma_mask		= 0x00;	/* No UDMA    */
+	ap->pio_mask		= ATA_PIO4;
+	ap->mwdma_mask		= mwdma_mask;
+	ap->udma_mask		= udma_mask;
 	ap->ops			= &mpc52xx_ata_port_ops;
 	host->private_data	= priv;
 
@@ -330,89 +684,139 @@ mpc52xx_ata_probe(struct of_device *op, const struct of_device_id *match)
 {
 	unsigned int ipb_freq;
 	struct resource res_mem;
-	int ata_irq;
+	int ata_irq = 0;
 	struct mpc52xx_ata __iomem *ata_regs;
-	struct mpc52xx_ata_priv *priv;
-	int rv;
+	struct mpc52xx_ata_priv *priv = NULL;
+	int rv, ret, task_irq = 0;
+	int mwdma_mask = 0, udma_mask = 0;
+	const __be32 *prop;
+	int proplen;
+	struct bcom_task *dmatsk = NULL;
 
 	/* Get ipb frequency */
 	ipb_freq = mpc52xx_find_ipb_freq(op->node);
 	if (!ipb_freq) {
-		printk(KERN_ERR DRV_NAME ": "
-			"Unable to find IPB Bus frequency\n" );
+		dev_err(&op->dev, "could not determine IPB bus frequency\n");
 		return -ENODEV;
 	}
 
-	/* Get IRQ and register */
+	/* Get device base address from device tree, request the region
+	 * and ioremap it. */
 	rv = of_address_to_resource(op->node, 0, &res_mem);
 	if (rv) {
-		printk(KERN_ERR DRV_NAME ": "
-			"Error while parsing device node resource\n" );
+		dev_err(&op->dev, "could not determine device base address\n");
 		return rv;
 	}
 
-	ata_irq = irq_of_parse_and_map(op->node, 0);
-	if (ata_irq == NO_IRQ) {
-		printk(KERN_ERR DRV_NAME ": "
-			"Error while mapping the irq\n");
-		return -EINVAL;
-	}
-
-	/* Request mem region */
 	if (!devm_request_mem_region(&op->dev, res_mem.start,
-				     sizeof(struct mpc52xx_ata), DRV_NAME)) {
-		printk(KERN_ERR DRV_NAME ": "
-			"Error while requesting mem region\n");
-		rv = -EBUSY;
-		goto err;
+				     sizeof(*ata_regs), DRV_NAME)) {
+		dev_err(&op->dev, "error requesting register region\n");
+		return -EBUSY;
 	}
 
-	/* Remap registers */
-	ata_regs = devm_ioremap(&op->dev, res_mem.start,
-				sizeof(struct mpc52xx_ata));
+	ata_regs = devm_ioremap(&op->dev, res_mem.start, sizeof(*ata_regs));
 	if (!ata_regs) {
-		printk(KERN_ERR DRV_NAME ": "
-			"Error while mapping register set\n");
+		dev_err(&op->dev, "error mapping device registers\n");
 		rv = -ENOMEM;
 		goto err;
 	}
 
+	/*
+	 * By default, all DMA modes are disabled for the MPC5200.  Some
+	 * boards don't have the required signals routed to make DMA work.
+	 * Also, the MPC5200B has a silicon bug that causes data corruption
+	 * with UDMA if it is used at the same time as the LocalPlus bus.
+	 *
+	 * Instead of trying to guess what modes are usable, check the
+	 * ATA device tree node to find out what DMA modes work on the board.
+	 * UDMA/MWDMA modes can also be forced by adding "libata.force=<mode>"
+	 * to the kernel boot parameters.
+	 *
+	 * The MPC5200 ATA controller supports MWDMA modes 0, 1 and 2 and
+	 * UDMA modes 0, 1 and 2.
+	 */
+	prop = of_get_property(op->node, "mwdma-mode", &proplen);
+	if ((prop) && (proplen >= 4))
+		mwdma_mask = 0x7 & ((1 << (*prop + 1)) - 1);
+	prop = of_get_property(op->node, "udma-mode", &proplen);
+	if ((prop) && (proplen >= 4))
+		udma_mask = 0x7 & ((1 << (*prop + 1)) - 1);
+
+	ata_irq = irq_of_parse_and_map(op->node, 0);
+	if (ata_irq == NO_IRQ) {
+		dev_err(&op->dev, "error mapping irq\n");
+		return -EINVAL;
+	}
+
 	/* Prepare our private structure */
-	priv = devm_kzalloc(&op->dev, sizeof(struct mpc52xx_ata_priv),
-			    GFP_ATOMIC);
+	priv = devm_kzalloc(&op->dev, sizeof(*priv), GFP_ATOMIC);
 	if (!priv) {
-		printk(KERN_ERR DRV_NAME ": "
-			"Error while allocating private structure\n");
+		dev_err(&op->dev, "error allocating private structure\n");
 		rv = -ENOMEM;
 		goto err;
 	}
 
 	priv->ipb_period = 1000000000 / (ipb_freq / 1000);
 	priv->ata_regs = ata_regs;
+	priv->ata_regs_pa = res_mem.start;
 	priv->ata_irq = ata_irq;
 	priv->csel = -1;
+	priv->mpc52xx_ata_dma_last_write = -1;
+
+	if (ipb_freq/1000000 == 66) {
+		priv->mdmaspec = mdmaspec66;
+		priv->udmaspec = udmaspec66;
+	} else {
+		priv->mdmaspec = mdmaspec132;
+		priv->udmaspec = udmaspec132;
+	}
+
+	/* Allocate a BestComm task for DMA */
+	dmatsk = bcom_ata_init(MAX_DMA_BUFFERS, MAX_DMA_BUFFER_SIZE);
+	if (!dmatsk) {
+		dev_err(&op->dev, "bestcomm initialization failed\n");
+		rv = -ENOMEM;
+		goto err;
+	}
+
+	task_irq = bcom_get_task_irq(dmatsk);
+	ret = request_irq(task_irq, &mpc52xx_ata_task_irq, IRQF_DISABLED,
+				"ATA task", priv);
+	if (ret) {
+		dev_err(&op->dev, "error requesting DMA IRQ\n");
+		goto err;
+	}
+	priv->dmatsk = dmatsk;
 
 	/* Init the hw */
 	rv = mpc52xx_ata_hw_init(priv);
 	if (rv) {
-		printk(KERN_ERR DRV_NAME ": Error during HW init\n");
+		dev_err(&op->dev, "error initializing hardware\n");
 		goto err;
 	}
 
 	/* Register ourselves to libata */
-	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem.start);
+	rv = mpc52xx_ata_init_one(&op->dev, priv, res_mem.start,
+				  mwdma_mask, udma_mask);
 	if (rv) {
-		printk(KERN_ERR DRV_NAME ": "
-			"Error while registering to ATA layer\n");
-		return rv;
+		dev_err(&op->dev, "error registering with ATA layer\n");
+		goto err;
 	}
 
-	/* Done */
 	return 0;
 
-	/* Error path */
-err:
-	irq_dispose_mapping(ata_irq);
+ err:
+	devm_release_mem_region(&op->dev, res_mem.start, sizeof(*ata_regs));
+	if (ata_irq)
+		irq_dispose_mapping(ata_irq);
+	if (task_irq)
+		irq_dispose_mapping(task_irq);
+	if (dmatsk)
+		bcom_ata_release(dmatsk);
+	if (ata_regs)
+		devm_iounmap(&op->dev, ata_regs);
+	if (priv)
+		devm_kfree(&op->dev, priv);
 	return rv;
 }
 
@@ -420,10 +824,23 @@ static int
 mpc52xx_ata_remove(struct of_device *op)
 {
 	struct mpc52xx_ata_priv *priv;
+	int task_irq;
 
+	/* Deregister the ATA interface */
 	priv = mpc52xx_ata_remove_one(&op->dev);
+
+	/* Clean up DMA */
+	task_irq = bcom_get_task_irq(priv->dmatsk);
+	irq_dispose_mapping(task_irq);
+	bcom_ata_release(priv->dmatsk);
 	irq_dispose_mapping(priv->ata_irq);
 
+	/* Clear up IO allocations */
+	devm_iounmap(&op->dev, priv->ata_regs);
+	devm_release_mem_region(&op->dev, priv->ata_regs_pa,
+				sizeof(*priv->ata_regs));
+	devm_kfree(&op->dev, priv);
+
 	return 0;
 }
 
@@ -447,7 +864,7 @@ mpc52xx_ata_resume(struct of_device *op)
 
 	rv = mpc52xx_ata_hw_init(priv);
 	if (rv) {
-		printk(KERN_ERR DRV_NAME ": Error during HW init\n");
+		dev_err(host->dev, "error initializing hardware\n");
 		return rv;
 	}
 
@@ -507,5 +924,4 @@ MODULE_AUTHOR("Sylvain Munaut <tnt@246tNt.com>");
 MODULE_DESCRIPTION("Freescale MPC52xx IDE/ATA libata driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(of, mpc52xx_ata_of_match);
-MODULE_VERSION(DRV_VERSION);
 
