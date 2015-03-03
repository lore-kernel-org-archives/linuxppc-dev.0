Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 376AC1A0279
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 07:41:28 +1100 (AEDT)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, rsarmah@amcc.com,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v1 1/2] sata_dwc_460ex: move to generic DMA driver
Date: Tue,  3 Mar 2015 22:41:21 +0200
Message-Id: <1425415282-3750-2-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SATA implementation based on two actually different devices, i.e. SATA and
DMA controllers.

For Synopsys DesignWare DMA we have already a generic implementation of the
driver. Thus, the patch converts the code to use DMAEngine framework and
dw_dmac driver.

In future it will be better to split the devices inside DTS as well like it's
done on other platforms.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/sata_dwc_460ex.c | 736 +++++++------------------------------------
 1 file changed, 122 insertions(+), 614 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 7bc0c12..08cd63f 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -36,11 +36,16 @@
 #include <linux/platform_device.h>
 #include <linux/libata.h>
 #include <linux/slab.h>
+
 #include "libata.h"
 
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 
+/* Supported DMA engine drivers */
+#include <linux/platform_data/dma-dw.h>
+#include <linux/dma/dw.h>
+
 /* These two are defined in "libata.h" */
 #undef	DRV_NAME
 #undef	DRV_VERSION
@@ -60,153 +65,9 @@
 #define NO_IRQ		0
 #endif
 
-/* SATA DMA driver Globals */
-#define DMA_NUM_CHANS		1
-#define DMA_NUM_CHAN_REGS	8
-
-/* SATA DMA Register definitions */
 #define AHB_DMA_BRST_DFLT	64	/* 16 data items burst length*/
 
-struct dmareg {
-	u32 low;		/* Low bits 0-31 */
-	u32 high;		/* High bits 32-63 */
-};
-
-/* DMA Per Channel registers */
-struct dma_chan_regs {
-	struct dmareg sar;	/* Source Address */
-	struct dmareg dar;	/* Destination address */
-	struct dmareg llp;	/* Linked List Pointer */
-	struct dmareg ctl;	/* Control */
-	struct dmareg sstat;	/* Source Status not implemented in core */
-	struct dmareg dstat;	/* Destination Status not implemented in core*/
-	struct dmareg sstatar;	/* Source Status Address not impl in core */
-	struct dmareg dstatar;	/* Destination Status Address not implemente */
-	struct dmareg cfg;	/* Config */
-	struct dmareg sgr;	/* Source Gather */
-	struct dmareg dsr;	/* Destination Scatter */
-};
-
-/* Generic Interrupt Registers */
-struct dma_interrupt_regs {
-	struct dmareg tfr;	/* Transfer Interrupt */
-	struct dmareg block;	/* Block Interrupt */
-	struct dmareg srctran;	/* Source Transfer Interrupt */
-	struct dmareg dsttran;	/* Dest Transfer Interrupt */
-	struct dmareg error;	/* Error */
-};
-
-struct ahb_dma_regs {
-	struct dma_chan_regs	chan_regs[DMA_NUM_CHAN_REGS];
-	struct dma_interrupt_regs interrupt_raw;	/* Raw Interrupt */
-	struct dma_interrupt_regs interrupt_status;	/* Interrupt Status */
-	struct dma_interrupt_regs interrupt_mask;	/* Interrupt Mask */
-	struct dma_interrupt_regs interrupt_clear;	/* Interrupt Clear */
-	struct dmareg		statusInt;	/* Interrupt combined*/
-	struct dmareg		rq_srcreg;	/* Src Trans Req */
-	struct dmareg		rq_dstreg;	/* Dst Trans Req */
-	struct dmareg		rq_sgl_srcreg;	/* Sngl Src Trans Req*/
-	struct dmareg		rq_sgl_dstreg;	/* Sngl Dst Trans Req*/
-	struct dmareg		rq_lst_srcreg;	/* Last Src Trans Req*/
-	struct dmareg		rq_lst_dstreg;	/* Last Dst Trans Req*/
-	struct dmareg		dma_cfg;		/* DMA Config */
-	struct dmareg		dma_chan_en;		/* DMA Channel Enable*/
-	struct dmareg		dma_id;			/* DMA ID */
-	struct dmareg		dma_test;		/* DMA Test */
-	struct dmareg		res1;			/* reserved */
-	struct dmareg		res2;			/* reserved */
-	/*
-	 * DMA Comp Params
-	 * Param 6 = dma_param[0], Param 5 = dma_param[1],
-	 * Param 4 = dma_param[2] ...
-	 */
-	struct dmareg		dma_params[6];
-};
-
-/* Data structure for linked list item */
-struct lli {
-	u32		sar;		/* Source Address */
-	u32		dar;		/* Destination address */
-	u32		llp;		/* Linked List Pointer */
-	struct dmareg	ctl;		/* Control */
-	struct dmareg	dstat;		/* Destination Status */
-};
-
-enum {
-	SATA_DWC_DMAC_LLI_SZ =	(sizeof(struct lli)),
-	SATA_DWC_DMAC_LLI_NUM =	256,
-	SATA_DWC_DMAC_LLI_TBL_SZ = (SATA_DWC_DMAC_LLI_SZ * \
-					SATA_DWC_DMAC_LLI_NUM),
-	SATA_DWC_DMAC_TWIDTH_BYTES = 4,
-	SATA_DWC_DMAC_CTRL_TSIZE_MAX = (0x00000800 * \
-						SATA_DWC_DMAC_TWIDTH_BYTES),
-};
-
-/* DMA Register Operation Bits */
 enum {
-	DMA_EN	=		0x00000001, /* Enable AHB DMA */
-	DMA_CTL_LLP_SRCEN =	0x10000000, /* Blk chain enable Src */
-	DMA_CTL_LLP_DSTEN =	0x08000000, /* Blk chain enable Dst */
-};
-
-#define	DMA_CTL_BLK_TS(size)	((size) & 0x000000FFF)	/* Blk Transfer size */
-#define DMA_CHANNEL(ch)		(0x00000001 << (ch))	/* Select channel */
-	/* Enable channel */
-#define	DMA_ENABLE_CHAN(ch)	((0x00000001 << (ch)) |			\
-				 ((0x000000001 << (ch)) << 8))
-	/* Disable channel */
-#define	DMA_DISABLE_CHAN(ch)	(0x00000000 | ((0x000000001 << (ch)) << 8))
-	/* Transfer Type & Flow Controller */
-#define	DMA_CTL_TTFC(type)	(((type) & 0x7) << 20)
-#define	DMA_CTL_SMS(num)	(((num) & 0x3) << 25) /* Src Master Select */
-#define	DMA_CTL_DMS(num)	(((num) & 0x3) << 23)/* Dst Master Select */
-	/* Src Burst Transaction Length */
-#define DMA_CTL_SRC_MSIZE(size) (((size) & 0x7) << 14)
-	/* Dst Burst Transaction Length */
-#define	DMA_CTL_DST_MSIZE(size) (((size) & 0x7) << 11)
-	/* Source Transfer Width */
-#define	DMA_CTL_SRC_TRWID(size) (((size) & 0x7) << 4)
-	/* Destination Transfer Width */
-#define	DMA_CTL_DST_TRWID(size) (((size) & 0x7) << 1)
-
-/* Assign HW handshaking interface (x) to destination / source peripheral */
-#define	DMA_CFG_HW_HS_DEST(int_num) (((int_num) & 0xF) << 11)
-#define	DMA_CFG_HW_HS_SRC(int_num) (((int_num) & 0xF) << 7)
-#define	DMA_CFG_HW_CH_PRIOR(int_num) (((int_num) & 0xF) << 5)
-#define	DMA_LLP_LMS(addr, master) (((addr) & 0xfffffffc) | (master))
-
-/*
- * This define is used to set block chaining disabled in the control low
- * register.  It is already in little endian format so it can be &'d dirctly.
- * It is essentially: cpu_to_le32(~(DMA_CTL_LLP_SRCEN | DMA_CTL_LLP_DSTEN))
- */
-enum {
-	DMA_CTL_LLP_DISABLE_LE32 = 0xffffffe7,
-	DMA_CTL_TTFC_P2M_DMAC =	0x00000002, /* Per to mem, DMAC cntr */
-	DMA_CTL_TTFC_M2P_PER =	0x00000003, /* Mem to per, peripheral cntr */
-	DMA_CTL_SINC_INC =	0x00000000, /* Source Address Increment */
-	DMA_CTL_SINC_DEC =	0x00000200,
-	DMA_CTL_SINC_NOCHANGE =	0x00000400,
-	DMA_CTL_DINC_INC =	0x00000000, /* Destination Address Increment */
-	DMA_CTL_DINC_DEC =	0x00000080,
-	DMA_CTL_DINC_NOCHANGE =	0x00000100,
-	DMA_CTL_INT_EN =	0x00000001, /* Interrupt Enable */
-
-/* Channel Configuration Register high bits */
-	DMA_CFG_FCMOD_REQ =	0x00000001, /* Flow Control - request based */
-	DMA_CFG_PROTCTL	=	(0x00000003 << 2),/* Protection Control */
-
-/* Channel Configuration Register low bits */
-	DMA_CFG_RELD_DST =	0x80000000, /* Reload Dest / Src Addr */
-	DMA_CFG_RELD_SRC =	0x40000000,
-	DMA_CFG_HS_SELSRC =	0x00000800, /* Software handshake Src/ Dest */
-	DMA_CFG_HS_SELDST =	0x00000400,
-	DMA_CFG_FIFOEMPTY =     (0x00000001 << 9), /* FIFO Empty bit */
-
-/* Channel Linked List Pointer Register */
-	DMA_LLP_AHBMASTER1 =	0,	/* List Master Select */
-	DMA_LLP_AHBMASTER2 =	1,
-
 	SATA_DWC_MAX_PORTS = 1,
 
 	SATA_DWC_SCR_OFFSET = 0x24,
@@ -287,7 +148,7 @@ struct sata_dwc_device {
 	struct ata_host		*host;
 	u8 __iomem		*reg_base;
 	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
-	int			irq_dma;
+	struct dw_dma_chip	*dma;
 };
 
 #define SATA_DWC_QCMD_MAX	32
@@ -295,10 +156,13 @@ struct sata_dwc_device {
 struct sata_dwc_device_port {
 	struct sata_dwc_device	*hsdev;
 	int			cmd_issued[SATA_DWC_QCMD_MAX];
-	struct lli		*llit[SATA_DWC_QCMD_MAX];  /* DMA LLI table */
-	dma_addr_t		llit_dma[SATA_DWC_QCMD_MAX];
-	u32			dma_chan[SATA_DWC_QCMD_MAX];
 	int			dma_pending[SATA_DWC_QCMD_MAX];
+
+	/* DMA info */
+	struct dw_dma_slave		*dws;
+	struct dma_chan			*chan;
+	struct dma_async_tx_descriptor	*desc[SATA_DWC_QCMD_MAX];
+	u32				dma_interrupt_count;
 };
 
 /*
@@ -330,14 +194,18 @@ struct sata_dwc_host_priv {
 	void	__iomem	 *scr_addr_sstatus;
 	u32	sata_dwc_sactive_issued ;
 	u32	sata_dwc_sactive_queued ;
-	u32	dma_interrupt_count;
-	struct	ahb_dma_regs	*sata_dma_regs;
 	struct	device	*dwc_dev;
-	int	dma_channel;
 };
 
 static struct sata_dwc_host_priv host_pvt;
 
+static struct dw_dma_slave sata_dwc_dma_dws = {
+	.src_id = 0,
+	.dst_id = 0,
+	.src_master = 0,
+	.dst_master = 1,
+};
+
 /*
  * Prototypes
  */
@@ -347,12 +215,6 @@ static int sata_dwc_qc_complete(struct ata_port *ap, struct ata_queued_cmd *qc,
 static void sata_dwc_dma_xfer_complete(struct ata_port *ap, u32 check_status);
 static void sata_dwc_port_stop(struct ata_port *ap);
 static void sata_dwc_clear_dmacr(struct sata_dwc_device_port *hsdevp, u8 tag);
-static int dma_dwc_init(struct sata_dwc_device *hsdev, int irq);
-static void dma_dwc_exit(struct sata_dwc_device *hsdev);
-static int dma_dwc_xfer_setup(struct scatterlist *sg, int num_elems,
-			      struct lli *lli, dma_addr_t dma_lli,
-			      void __iomem *addr, int dir);
-static void dma_dwc_xfer_start(int dma_ch);
 
 static const char *get_prot_descript(u8 protocol)
 {
@@ -405,76 +267,8 @@ static void sata_dwc_tf_dump(struct ata_taskfile *tf)
 		tf->hob_lbah);
 }
 
-/*
- * Function: get_burst_length_encode
- * arguments: datalength: length in bytes of data
- * returns value to be programmed in register corresponding to data length
- * This value is effectively the log(base 2) of the length
- */
-static  int get_burst_length_encode(int datalength)
-{
-	int items = datalength >> 2;	/* div by 4 to get lword count */
-
-	if (items >= 64)
-		return 5;
-
-	if (items >= 32)
-		return 4;
-
-	if (items >= 16)
-		return 3;
-
-	if (items >= 8)
-		return 2;
-
-	if (items >= 4)
-		return 1;
-
-	return 0;
-}
-
-static  void clear_chan_interrupts(int c)
+static void dma_dwc_xfer_done(void *hsdev_instance)
 {
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.tfr.low),
-		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.block.low),
-		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.srctran.low),
-		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.dsttran.low),
-		 DMA_CHANNEL(c));
-	out_le32(&(host_pvt.sata_dma_regs->interrupt_clear.error.low),
-		 DMA_CHANNEL(c));
-}
-
-/*
- * Function: dma_request_channel
- * arguments: None
- * returns channel number if available else -1
- * This function assigns the next available DMA channel from the list to the
- * requester
- */
-static int dma_request_channel(void)
-{
-	/* Check if the channel is not currently in use */
-	if (!(in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low)) &
-		DMA_CHANNEL(host_pvt.dma_channel)))
-		return host_pvt.dma_channel;
-	dev_err(host_pvt.dwc_dev, "%s Channel %d is currently in use\n",
-		__func__, host_pvt.dma_channel);
-	return -1;
-}
-
-/*
- * Function: dma_dwc_interrupt
- * arguments: irq, dev_id, pt_regs
- * returns channel number if available else -1
- * Interrupt Handler for DW AHB SATA DMA
- */
-static irqreturn_t dma_dwc_interrupt(int irq, void *hsdev_instance)
-{
-	int chan;
-	u32 tfr_reg, err_reg;
 	unsigned long flags;
 	struct sata_dwc_device *hsdev = hsdev_instance;
 	struct ata_host *host = (struct ata_host *)hsdev->host;
@@ -488,341 +282,65 @@ static irqreturn_t dma_dwc_interrupt(int irq, void *hsdev_instance)
 	hsdevp = HSDEVP_FROM_AP(ap);
 	tag = ap->link.active_tag;
 
-	tfr_reg = in_le32(&(host_pvt.sata_dma_regs->interrupt_status.tfr\
-			.low));
-	err_reg = in_le32(&(host_pvt.sata_dma_regs->interrupt_status.error\
-			.low));
-
-	dev_dbg(ap->dev, "eot=0x%08x err=0x%08x pending=%d active port=%d\n",
-		tfr_reg, err_reg, hsdevp->dma_pending[tag], port);
-
-	chan = host_pvt.dma_channel;
-	if (chan >= 0) {
-		/* Check for end-of-transfer interrupt. */
-		if (tfr_reg & DMA_CHANNEL(chan)) {
-			/*
-			 * Each DMA command produces 2 interrupts.  Only
-			 * complete the command after both interrupts have been
-			 * seen. (See sata_dwc_isr())
-			 */
-			host_pvt.dma_interrupt_count++;
-			sata_dwc_clear_dmacr(hsdevp, tag);
-
-			if (hsdevp->dma_pending[tag] ==
-			    SATA_DWC_DMA_PENDING_NONE) {
-				dev_err(ap->dev, "DMA not pending eot=0x%08x "
-					"err=0x%08x tag=0x%02x pending=%d\n",
-					tfr_reg, err_reg, tag,
-					hsdevp->dma_pending[tag]);
-			}
-
-			if ((host_pvt.dma_interrupt_count % 2) == 0)
-				sata_dwc_dma_xfer_complete(ap, 1);
-
-			/* Clear the interrupt */
-			out_le32(&(host_pvt.sata_dma_regs->interrupt_clear\
-				.tfr.low),
-				 DMA_CHANNEL(chan));
-		}
-
-		/* Check for error interrupt. */
-		if (err_reg & DMA_CHANNEL(chan)) {
-			/* TODO Need error handler ! */
-			dev_err(ap->dev, "error interrupt err_reg=0x%08x\n",
-				err_reg);
-
-			/* Clear the interrupt. */
-			out_le32(&(host_pvt.sata_dma_regs->interrupt_clear\
-				.error.low),
-				 DMA_CHANNEL(chan));
-		}
-	}
-	spin_unlock_irqrestore(&host->lock, flags);
-	return IRQ_HANDLED;
-}
-
-/*
- * Function: dma_request_interrupts
- * arguments: hsdev
- * returns status
- * This function registers ISR for a particular DMA channel interrupt
- */
-static int dma_request_interrupts(struct sata_dwc_device *hsdev, int irq)
-{
-	int retval = 0;
-	int chan = host_pvt.dma_channel;
-
-	if (chan >= 0) {
-		/* Unmask error interrupt */
-		out_le32(&(host_pvt.sata_dma_regs)->interrupt_mask.error.low,
-			 DMA_ENABLE_CHAN(chan));
-
-		/* Unmask end-of-transfer interrupt */
-		out_le32(&(host_pvt.sata_dma_regs)->interrupt_mask.tfr.low,
-			 DMA_ENABLE_CHAN(chan));
-	}
-
-	retval = request_irq(irq, dma_dwc_interrupt, 0, "SATA DMA", hsdev);
-	if (retval) {
-		dev_err(host_pvt.dwc_dev, "%s: could not get IRQ %d\n",
-		__func__, irq);
-		return -ENODEV;
-	}
-
-	/* Mark this interrupt as requested */
-	hsdev->irq_dma = irq;
-	return 0;
-}
-
-/*
- * Function: map_sg_to_lli
- * The Synopsis driver has a comment proposing that better performance
- * is possible by only enabling interrupts on the last item in the linked list.
- * However, it seems that could be a problem if an error happened on one of the
- * first items.  The transfer would halt, but no error interrupt would occur.
- * Currently this function sets interrupts enabled for each linked list item:
- * DMA_CTL_INT_EN.
- */
-static int map_sg_to_lli(struct scatterlist *sg, int num_elems,
-			struct lli *lli, dma_addr_t dma_lli,
-			void __iomem *dmadr_addr, int dir)
-{
-	int i, idx = 0;
-	int fis_len = 0;
-	dma_addr_t next_llp;
-	int bl;
-	int sms_val, dms_val;
-
-	sms_val = 0;
-	dms_val = 1 + host_pvt.dma_channel;
-	dev_dbg(host_pvt.dwc_dev,
-		"%s: sg=%p nelem=%d lli=%p dma_lli=0x%pad dmadr=0x%p\n",
-		__func__, sg, num_elems, lli, &dma_lli, dmadr_addr);
-
-	bl = get_burst_length_encode(AHB_DMA_BRST_DFLT);
-
-	for (i = 0; i < num_elems; i++, sg++) {
-		u32 addr, offset;
-		u32 sg_len, len;
-
-		addr = (u32) sg_dma_address(sg);
-		sg_len = sg_dma_len(sg);
-
-		dev_dbg(host_pvt.dwc_dev, "%s: elem=%d sg_addr=0x%x sg_len"
-			"=%d\n", __func__, i, addr, sg_len);
-
-		while (sg_len) {
-			if (idx >= SATA_DWC_DMAC_LLI_NUM) {
-				/* The LLI table is not large enough. */
-				dev_err(host_pvt.dwc_dev, "LLI table overrun "
-				"(idx=%d)\n", idx);
-				break;
-			}
-			len = (sg_len > SATA_DWC_DMAC_CTRL_TSIZE_MAX) ?
-				SATA_DWC_DMAC_CTRL_TSIZE_MAX : sg_len;
-
-			offset = addr & 0xffff;
-			if ((offset + sg_len) > 0x10000)
-				len = 0x10000 - offset;
-
-			/*
-			 * Make sure a LLI block is not created that will span
-			 * 8K max FIS boundary.  If the block spans such a FIS
-			 * boundary, there is a chance that a DMA burst will
-			 * cross that boundary -- this results in an error in
-			 * the host controller.
-			 */
-			if (fis_len + len > 8192) {
-				dev_dbg(host_pvt.dwc_dev, "SPLITTING: fis_len="
-					"%d(0x%x) len=%d(0x%x)\n", fis_len,
-					 fis_len, len, len);
-				len = 8192 - fis_len;
-				fis_len = 0;
-			} else {
-				fis_len += len;
-			}
-			if (fis_len == 8192)
-				fis_len = 0;
-
-			/*
-			 * Set DMA addresses and lower half of control register
-			 * based on direction.
-			 */
-			if (dir == DMA_FROM_DEVICE) {
-				lli[idx].dar = cpu_to_le32(addr);
-				lli[idx].sar = cpu_to_le32((u32)dmadr_addr);
-
-				lli[idx].ctl.low = cpu_to_le32(
-					DMA_CTL_TTFC(DMA_CTL_TTFC_P2M_DMAC) |
-					DMA_CTL_SMS(sms_val) |
-					DMA_CTL_DMS(dms_val) |
-					DMA_CTL_SRC_MSIZE(bl) |
-					DMA_CTL_DST_MSIZE(bl) |
-					DMA_CTL_SINC_NOCHANGE |
-					DMA_CTL_SRC_TRWID(2) |
-					DMA_CTL_DST_TRWID(2) |
-					DMA_CTL_INT_EN |
-					DMA_CTL_LLP_SRCEN |
-					DMA_CTL_LLP_DSTEN);
-			} else {	/* DMA_TO_DEVICE */
-				lli[idx].sar = cpu_to_le32(addr);
-				lli[idx].dar = cpu_to_le32((u32)dmadr_addr);
-
-				lli[idx].ctl.low = cpu_to_le32(
-					DMA_CTL_TTFC(DMA_CTL_TTFC_M2P_PER) |
-					DMA_CTL_SMS(dms_val) |
-					DMA_CTL_DMS(sms_val) |
-					DMA_CTL_SRC_MSIZE(bl) |
-					DMA_CTL_DST_MSIZE(bl) |
-					DMA_CTL_DINC_NOCHANGE |
-					DMA_CTL_SRC_TRWID(2) |
-					DMA_CTL_DST_TRWID(2) |
-					DMA_CTL_INT_EN |
-					DMA_CTL_LLP_SRCEN |
-					DMA_CTL_LLP_DSTEN);
-			}
-
-			dev_dbg(host_pvt.dwc_dev, "%s setting ctl.high len: "
-				"0x%08x val: 0x%08x\n", __func__,
-				len, DMA_CTL_BLK_TS(len / 4));
-
-			/* Program the LLI CTL high register */
-			lli[idx].ctl.high = cpu_to_le32(DMA_CTL_BLK_TS\
-						(len / 4));
-
-			/* Program the next pointer.  The next pointer must be
-			 * the physical address, not the virtual address.
-			 */
-			next_llp = (dma_lli + ((idx + 1) * sizeof(struct \
-							lli)));
-
-			/* The last 2 bits encode the list master select. */
-			next_llp = DMA_LLP_LMS(next_llp, DMA_LLP_AHBMASTER2);
-
-			lli[idx].llp = cpu_to_le32(next_llp);
-			idx++;
-			sg_len -= len;
-			addr += len;
-		}
-	}
-
 	/*
-	 * The last next ptr has to be zero and the last control low register
-	 * has to have LLP_SRC_EN and LLP_DST_EN (linked list pointer source
-	 * and destination enable) set back to 0 (disabled.) This is what tells
-	 * the core that this is the last item in the linked list.
+	 * Each DMA command produces 2 interrupts.  Only
+	 * complete the command after both interrupts have been
+	 * seen. (See sata_dwc_isr())
 	 */
-	if (idx) {
-		lli[idx-1].llp = 0x00000000;
-		lli[idx-1].ctl.low &= DMA_CTL_LLP_DISABLE_LE32;
+	hsdevp->dma_interrupt_count++;
+	sata_dwc_clear_dmacr(hsdevp, tag);
 
-		/* Flush cache to memory */
-		dma_cache_sync(NULL, lli, (sizeof(struct lli) * idx),
-			       DMA_BIDIRECTIONAL);
+	if (hsdevp->dma_pending[tag] == SATA_DWC_DMA_PENDING_NONE) {
+		dev_err(ap->dev, "DMA not pending tag=0x%02x pending=%d\n",
+			tag, hsdevp->dma_pending[tag]);
 	}
 
-	return idx;
-}
+	if ((hsdevp->dma_interrupt_count % 2) == 0)
+	sata_dwc_dma_xfer_complete(ap, 1);
 
-/*
- * Function: dma_dwc_xfer_start
- * arguments: Channel number
- * Return : None
- * Enables the DMA channel
- */
-static void dma_dwc_xfer_start(int dma_ch)
-{
-	/* Enable the DMA channel */
-	out_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low),
-		 in_le32(&(host_pvt.sata_dma_regs->dma_chan_en.low)) |
-		 DMA_ENABLE_CHAN(dma_ch));
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int dma_dwc_xfer_setup(struct scatterlist *sg, int num_elems,
-			      struct lli *lli, dma_addr_t dma_lli,
-			      void __iomem *addr, int dir)
+static struct dma_async_tx_descriptor *dma_dwc_xfer_setup(struct ata_queued_cmd *qc)
 {
-	int dma_ch;
-	int num_lli;
-	/* Acquire DMA channel */
-	dma_ch = dma_request_channel();
-	if (dma_ch == -1) {
-		dev_err(host_pvt.dwc_dev, "%s: dma channel unavailable\n",
-			 __func__);
-		return -EAGAIN;
+	struct ata_port *ap = qc->ap;
+	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
+	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
+	dma_addr_t addr = (dma_addr_t)&hsdev->sata_dwc_regs->dmadr;
+	struct dma_slave_config sconf;
+	struct dma_async_tx_descriptor *desc;
+
+	if (qc->dma_dir == DMA_DEV_TO_MEM) {
+		sconf.src_addr = addr;
+		sconf.device_fc = true;
+	} else {	/* DMA_MEM_TO_DEV */
+		sconf.dst_addr = addr;
+		sconf.device_fc = false;
 	}
 
-	/* Convert SG list to linked list of items (LLIs) for AHB DMA */
-	num_lli = map_sg_to_lli(sg, num_elems, lli, dma_lli, addr, dir);
-
-	dev_dbg(host_pvt.dwc_dev, "%s sg: 0x%p, count: %d lli: %p dma_lli:"
-		" 0x%0xlx addr: %p lli count: %d\n", __func__, sg, num_elems,
-		 lli, (u32)dma_lli, addr, num_lli);
-
-	clear_chan_interrupts(dma_ch);
-
-	/* Program the CFG register. */
-	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].cfg.high),
-		 DMA_CFG_HW_HS_SRC(dma_ch) | DMA_CFG_HW_HS_DEST(dma_ch) |
-		 DMA_CFG_PROTCTL | DMA_CFG_FCMOD_REQ);
-	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].cfg.low),
-		 DMA_CFG_HW_CH_PRIOR(dma_ch));
-
-	/* Program the address of the linked list */
-	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].llp.low),
-		 DMA_LLP_LMS(dma_lli, DMA_LLP_AHBMASTER2));
-
-	/* Program the CTL register with src enable / dst enable */
-	out_le32(&(host_pvt.sata_dma_regs->chan_regs[dma_ch].ctl.low),
-		 DMA_CTL_LLP_SRCEN | DMA_CTL_LLP_DSTEN);
-	return dma_ch;
-}
-
-/*
- * Function: dma_dwc_exit
- * arguments: None
- * returns status
- * This function exits the SATA DMA driver
- */
-static void dma_dwc_exit(struct sata_dwc_device *hsdev)
-{
-	dev_dbg(host_pvt.dwc_dev, "%s:\n", __func__);
-	if (host_pvt.sata_dma_regs) {
-		iounmap((void __iomem *)host_pvt.sata_dma_regs);
-		host_pvt.sata_dma_regs = NULL;
-	}
+	sconf.direction = qc->dma_dir;
+	sconf.src_maxburst = AHB_DMA_BRST_DFLT;
+	sconf.dst_maxburst = AHB_DMA_BRST_DFLT;
+	sconf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	sconf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
-	if (hsdev->irq_dma) {
-		free_irq(hsdev->irq_dma, hsdev);
-		hsdev->irq_dma = 0;
-	}
-}
+	dmaengine_slave_config(hsdevp->chan, &sconf);
 
-/*
- * Function: dma_dwc_init
- * arguments: hsdev
- * returns status
- * This function initializes the SATA DMA driver
- */
-static int dma_dwc_init(struct sata_dwc_device *hsdev, int irq)
-{
-	int err;
+	/* Convert SG list to linked list of items (LLIs) for AHB DMA */
+	desc = dmaengine_prep_slave_sg(hsdevp->chan, qc->sg, qc->n_elem,
+				       qc->dma_dir,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
-	err = dma_request_interrupts(hsdev, irq);
-	if (err) {
-		dev_err(host_pvt.dwc_dev, "%s: dma_request_interrupts returns"
-			" %d\n", __func__, err);
-		return err;
-	}
+	if (!desc)
+		return NULL;
 
-	/* Enabe DMA */
-	out_le32(&(host_pvt.sata_dma_regs->dma_cfg.low), DMA_EN);
+	desc->callback = dma_dwc_xfer_done;
+	desc->callback_param = hsdev;
 
-	dev_notice(host_pvt.dwc_dev, "DMA initialized\n");
-	dev_dbg(host_pvt.dwc_dev, "SATA DMA registers=0x%p\n", host_pvt.\
-		sata_dma_regs);
+	dev_dbg(host_pvt.dwc_dev, "%s sg: 0x%p, count: %d addr: %pad\n",
+		__func__, qc->sg, qc->n_elem, &addr);
 
-	return 0;
+	return desc;
 }
 
 static int sata_dwc_scr_read(struct ata_link *link, unsigned int scr, u32 *val)
@@ -892,21 +410,18 @@ static void sata_dwc_error_intr(struct ata_port *ap,
 	struct ata_queued_cmd *qc;
 	u32 serror;
 	u8 status, tag;
-	u32 err_reg;
 
 	ata_ehi_clear_desc(ehi);
 
 	serror = core_scr_read(SCR_ERROR);
 	status = ap->ops->sff_check_status(ap);
 
-	err_reg = in_le32(&(host_pvt.sata_dma_regs->interrupt_status.error.\
-			low));
 	tag = ap->link.active_tag;
 
-	dev_err(ap->dev, "%s SCR_ERROR=0x%08x intpr=0x%08x status=0x%08x "
-		"dma_intp=%d pending=%d issued=%d dma_err_status=0x%08x\n",
-		__func__, serror, intpr, status, host_pvt.dma_interrupt_count,
-		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag], err_reg);
+	dev_err(ap->dev,
+		"%s SCR_ERROR=0x%08x intpr=0x%08x status=0x%08x dma_intp=%d pending=%d issued=%d",
+		__func__, serror, intpr, status, hsdevp->dma_interrupt_count,
+		hsdevp->dma_pending[tag], hsdevp->cmd_issued[tag]);
 
 	/* Clear error register and interrupt bit */
 	clear_serror();
@@ -1033,7 +548,7 @@ DRVSTILLBUSY:
 			 * operation done interrupt. The command should be
 			 * completed only after both interrupts are seen.
 			 */
-			host_pvt.dma_interrupt_count++;
+			hsdevp->dma_interrupt_count++;
 			if (hsdevp->dma_pending[tag] == \
 					SATA_DWC_DMA_PENDING_NONE) {
 				dev_err(ap->dev,
@@ -1042,7 +557,7 @@ DRVSTILLBUSY:
 					hsdevp->dma_pending[tag]);
 			}
 
-			if ((host_pvt.dma_interrupt_count % 2) == 0)
+			if ((hsdevp->dma_interrupt_count % 2) == 0)
 				sata_dwc_dma_xfer_complete(ap, 1);
 		} else if (ata_is_pio(qc->tf.protocol)) {
 			ata_sff_hsm_move(ap, qc, status, 0);
@@ -1116,12 +631,12 @@ DRVSTILLBUSY:
 		dev_dbg(ap->dev, "%s NCQ command, protocol: %s\n", __func__,
 			get_prot_descript(qc->tf.protocol));
 		if (ata_is_dma(qc->tf.protocol)) {
-			host_pvt.dma_interrupt_count++;
+			hsdevp->dma_interrupt_count++;
 			if (hsdevp->dma_pending[tag] == \
 					SATA_DWC_DMA_PENDING_NONE)
 				dev_warn(ap->dev, "%s: DMA not pending?\n",
 					__func__);
-			if ((host_pvt.dma_interrupt_count % 2) == 0)
+			if ((hsdevp->dma_interrupt_count % 2) == 0)
 				sata_dwc_dma_xfer_complete(ap, 1);
 		} else {
 			if (unlikely(sata_dwc_qc_complete(ap, qc, 1)))
@@ -1269,6 +784,18 @@ static void sata_dwc_enable_interrupts(struct sata_dwc_device *hsdev)
 		in_le32(&hsdev->sata_dwc_regs->errmr));
 }
 
+static bool sata_dwc_dma_filter(struct dma_chan *chan, void *param)
+{
+	struct sata_dwc_device_port *hsdevp = param;
+	struct dw_dma_slave *dws = hsdevp->dws;
+
+	if (dws->dma_dev != chan->device->dev)
+		return false;
+
+	chan->private = dws;
+	return true;
+}
+
 static void sata_dwc_setup_port(struct ata_ioports *port, unsigned long base)
 {
 	port->cmd_addr = (void __iomem *)base + 0x00;
@@ -1303,6 +830,7 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	struct sata_dwc_device *hsdev;
 	struct sata_dwc_device_port *hsdevp = NULL;
 	struct device *pdev;
+	dma_cap_mask_t mask;
 	int i;
 
 	hsdev = HSDEV_FROM_AP(ap);
@@ -1326,29 +854,27 @@ static int sata_dwc_port_start(struct ata_port *ap)
 	}
 	hsdevp->hsdev = hsdev;
 
+	hsdevp->dws = &sata_dwc_dma_dws;
+	hsdevp->dws->dma_dev = host_pvt.dwc_dev;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	/* Acquire DMA channel */
+	hsdevp->chan = dma_request_channel(mask, sata_dwc_dma_filter, hsdevp);
+	if (!hsdevp->chan) {
+		dev_err(host_pvt.dwc_dev, "%s: dma channel unavailable\n",
+			 __func__);
+		err = -EAGAIN;
+		goto CLEANUP_ALLOC;
+	}
+
 	for (i = 0; i < SATA_DWC_QCMD_MAX; i++)
 		hsdevp->cmd_issued[i] = SATA_DWC_CMD_ISSUED_NOT;
 
 	ap->bmdma_prd = NULL;	/* set these so libata doesn't use them */
 	ap->bmdma_prd_dma = 0;
 
-	/*
-	 * DMA - Assign scatter gather LLI table. We can't use the libata
-	 * version since it's PRD is IDE PCI specific.
-	 */
-	for (i = 0; i < SATA_DWC_QCMD_MAX; i++) {
-		hsdevp->llit[i] = dma_alloc_coherent(pdev,
-						     SATA_DWC_DMAC_LLI_TBL_SZ,
-						     &(hsdevp->llit_dma[i]),
-						     GFP_ATOMIC);
-		if (!hsdevp->llit[i]) {
-			dev_err(ap->dev, "%s: dma_alloc_coherent failed\n",
-				 __func__);
-			err = -ENOMEM;
-			goto CLEANUP_ALLOC;
-		}
-	}
-
 	if (ap->port_no == 0)  {
 		dev_dbg(ap->dev, "%s: clearing TXCHEN, RXCHEN in DMAC\n",
 			__func__);
@@ -1377,22 +903,14 @@ CLEANUP:
 
 static void sata_dwc_port_stop(struct ata_port *ap)
 {
-	int i;
-	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
 	dev_dbg(ap->dev, "%s: ap->id = %d\n", __func__, ap->print_id);
 
-	if (hsdevp && hsdev) {
-		/* deallocate LLI table */
-		for (i = 0; i < SATA_DWC_QCMD_MAX; i++) {
-			dma_free_coherent(ap->host->dev,
-					  SATA_DWC_DMAC_LLI_TBL_SZ,
-					 hsdevp->llit[i], hsdevp->llit_dma[i]);
-		}
+	dmaengine_terminate_all(hsdevp->chan);
+	dma_release_channel(hsdevp->chan);
 
-		kfree(hsdevp);
-	}
+	kfree(hsdevp);
 	ap->private_data = NULL;
 }
 
@@ -1448,12 +966,12 @@ static void sata_dwc_bmdma_setup(struct ata_queued_cmd *qc)
 static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 {
 	int start_dma;
-	u32 reg, dma_chan;
+	u32 reg;
 	struct sata_dwc_device *hsdev = HSDEV_FROM_QC(qc);
 	struct ata_port *ap = qc->ap;
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
+	struct dma_async_tx_descriptor *desc = hsdevp->desc[tag];
 	int dir = qc->dma_dir;
-	dma_chan = hsdevp->dma_chan[tag];
 
 	if (hsdevp->cmd_issued[tag] != SATA_DWC_CMD_ISSUED_NOT) {
 		start_dma = 1;
@@ -1489,7 +1007,8 @@ static void sata_dwc_bmdma_start_by_tag(struct ata_queued_cmd *qc, u8 tag)
 				SATA_DWC_DMACR_RXCHEN);
 
 		/* Enable AHB DMA transfer on the specified channel */
-		dma_dwc_xfer_start(dma_chan);
+		dmaengine_submit(desc);
+		dma_async_issue_pending(hsdevp->chan);
 	}
 }
 
@@ -1515,26 +1034,21 @@ static void sata_dwc_bmdma_start(struct ata_queued_cmd *qc)
  */
 static void sata_dwc_qc_prep_by_tag(struct ata_queued_cmd *qc, u8 tag)
 {
-	struct scatterlist *sg = qc->sg;
+	struct dma_async_tx_descriptor *desc;
 	struct ata_port *ap = qc->ap;
-	int dma_chan;
-	struct sata_dwc_device *hsdev = HSDEV_FROM_AP(ap);
 	struct sata_dwc_device_port *hsdevp = HSDEVP_FROM_AP(ap);
 
 	dev_dbg(ap->dev, "%s: port=%d dma dir=%s n_elem=%d\n",
 		__func__, ap->port_no, get_dma_dir_descript(qc->dma_dir),
 		 qc->n_elem);
 
-	dma_chan = dma_dwc_xfer_setup(sg, qc->n_elem, hsdevp->llit[tag],
-				      hsdevp->llit_dma[tag],
-				      (void __iomem *)&hsdev->sata_dwc_regs->dmadr,
-				      qc->dma_dir);
-	if (dma_chan < 0) {
-		dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns err %d\n",
-			__func__, dma_chan);
+	desc = dma_dwc_xfer_setup(qc);
+	if (!desc) {
+		dev_err(ap->dev, "%s: dma_dwc_xfer_setup returns NULL\n",
+			__func__);
 		return;
 	}
-	hsdevp->dma_chan[tag] = dma_chan;
+	hsdevp->desc[tag] = desc;
 }
 
 static unsigned int sata_dwc_qc_issue(struct ata_queued_cmd *qc)
@@ -1678,7 +1192,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	struct ata_port_info pi = sata_dwc_port_info[0];
 	const struct ata_port_info *ppi[] = { &pi, NULL };
 	struct device_node *np = ofdev->dev.of_node;
-	u32 dma_chan;
 
 	/* Allocate DWC SATA device */
 	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_DWC_MAX_PORTS);
@@ -1688,13 +1201,6 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 	host->private_data = hsdev;
 
-	if (of_property_read_u32(np, "dma-channel", &dma_chan)) {
-		dev_warn(&ofdev->dev, "no dma-channel property set."
-			 " Use channel 0\n");
-		dma_chan = 0;
-	}
-	host_pvt.dma_channel = dma_chan;
-
 	/* Ioremap SATA registers */
 	base = of_iomap(np, 0);
 	if (!base) {
@@ -1721,16 +1227,16 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 		   idr, ver[0], ver[1], ver[2]);
 
 	/* Get SATA DMA interrupt number */
-	irq = irq_of_parse_and_map(np, 1);
-	if (irq == NO_IRQ) {
+	hsdev->dma->irq = irq_of_parse_and_map(np, 1);
+	if (hsdev->dma->irq == NO_IRQ) {
 		dev_err(&ofdev->dev, "no SATA DMA irq\n");
 		err = -ENODEV;
 		goto error_iomap;
 	}
 
 	/* Get physical SATA DMA register base address */
-	host_pvt.sata_dma_regs = (void *)of_iomap(np, 1);
-	if (!(host_pvt.sata_dma_regs)) {
+	hsdev->dma->regs = of_iomap(np, 1);
+	if (!hsdev->dma->regs) {
 		dev_err(&ofdev->dev,
 			"ioremap failed for AHBDMA register address\n");
 		err = -ENODEV;
@@ -1740,8 +1246,10 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	/* Save dev for later use in dev_xxx() routines */
 	host_pvt.dwc_dev = &ofdev->dev;
 
+	hsdev->dma->dev = &ofdev->dev;
+
 	/* Initialize AHB DMAC */
-	err = dma_dwc_init(hsdev, irq);
+	err = dw_dma_probe(hsdev->dma, NULL);
 	if (err)
 		goto error_dma_iomap;
 
@@ -1770,9 +1278,9 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 
 error_out:
 	/* Free SATA DMA resources */
-	dma_dwc_exit(hsdev);
+	dw_dma_remove(hsdev->dma);
 error_dma_iomap:
-	iounmap((void __iomem *)host_pvt.sata_dma_regs);
+	iounmap(hsdev->dma->regs);
 error_iomap:
 	iounmap(base);
 	return err;
@@ -1787,9 +1295,9 @@ static int sata_dwc_remove(struct platform_device *ofdev)
 	ata_host_detach(host);
 
 	/* Free SATA DMA resources */
-	dma_dwc_exit(hsdev);
+	dw_dma_remove(hsdev->dma);
 
-	iounmap((void __iomem *)host_pvt.sata_dma_regs);
+	iounmap(hsdev->dma->regs);
 	iounmap(hsdev->reg_base);
 	dev_dbg(&ofdev->dev, "done\n");
 	return 0;
-- 
2.1.4
