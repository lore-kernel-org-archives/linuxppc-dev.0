Return-Path: <micha.nelissen@prodrive.nl>
Received: from edu-smtp-02.edutel.nl (edu-smtp-02.edutel.nl [88.159.1.222])
	by ozlabs.org (Postfix) with ESMTP id B6450B7C98
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Feb 2010 09:47:40 +1100 (EST)
From: Micha Nelissen <micha.nelissen@prodrive.nl>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] RapidIO: add support for mapping outbound memory
Date: Fri, 12 Feb 2010 23:01:13 +0100
Message-Id: <1266012073-27584-1-git-send-email-micha.nelissen@prodrive.nl>
Cc: Micha Nelissen <micha.nelissen@prodrive.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Micha Nelissen <micha.nelissen@prodrive.nl>
---
 arch/powerpc/sysdev/fsl_rio.c |  175 ++++++++++++++++++++++++++++++++++++++++-
 drivers/rapidio/rio-scan.c    |    3 +-
 drivers/rapidio/rio.c         |  121 ++++++++++++++++++++++++++++-
 include/linux/rio.h           |   20 ++++-
 include/linux/rio_drv.h       |    5 +-
 5 files changed, 315 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index 757a83f..3290971 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -26,6 +26,8 @@
 
 #include <asm/io.h>
 
+#define DRVNAME			"fsl_rio"
+
 /* RapidIO definition irq, which read from OF-tree */
 #define IRQ_RIO_BELL(m)		(((struct rio_priv *)(m->priv))->bellirq)
 #define IRQ_RIO_TX(m)		(((struct rio_priv *)(m->priv))->txirq)
@@ -61,6 +63,49 @@
 #define RIO_MIN_RX_RING_SIZE	2
 #define RIO_MAX_RX_RING_SIZE	2048
 
+#define RIO_OUTB_ATMU_COUNT	    9
+#define RIO_INB_ATMU_COUNT	    4
+
+#define ROWTAR_LTGTID_MASK	    0xC0000000
+#define ROWTAR_TREXAD_TID_MASK	    0x3FC00000
+#define ROWTAR_TRAD_MASK	    0x003FFFFF
+#define ROWTAR_LTGTID_SHIFT	    30
+#define ROWTAR_TREXAD_TID_SHIFT	    22
+#define ROWTAR_TRAD_HOP_SHIFT	    12
+#define ROWTAR_LTGTID_VAL_SHIFT	    8
+#define ROWTAR_LTGTID_VAL_MASK	    3
+#define ROWTAR_TREXAD_TID_VAL_MASK  0xFF
+#define ROWTAR_TRAD_VAL_SHIFT	    12
+#define ROWTAR_TRAD_MAINT_SHIFT	    22
+#define ROWTEAR_LTGTID_VAL_SHIFT    10
+#define ROWBAR_BADD_VAL_SHIFT	    12
+#define ROWBAR_BADD_MASK	    0x000FFFFF
+#define ROWAR_TFLOWLVL_HIGHEST	    0x08000000
+#define ROWAR_TFLOWLVL_HIGH	    0x04000000
+#define ROWAR_NSEG_MASK		    0x00C00000
+#define ROWAR_NSSEG_MASK	    0x00300000
+#define ROWAR_SIZE_MASK		    0x0000003F
+#define ROWAR_NSEG_SHIFT	    22
+#define ROWAR_NSSEG_SHIFT	    20
+#define ROWAR_SIZE_SHIFT	    0
+#define ROWAR_ENABLE		    0x80000000
+#define ROWAR_PCI		    0x02000000
+#define ROWAR_NSEG_FOUR		    0x00800000
+#define ROWAR_NSSEG_EIGHT	    0x00300000
+#define ROWAR_RDTYP_NREAD	    0x00040000
+#define ROWAR_RDTYP_MAINT_READ	    0x00070000
+#define ROWAR_WRTYP_DOORBELL	    0x00002000	    /* parallel PHY only */
+#define ROWAR_WRTYP_NWRITE	    0x00004000
+#define ROWAR_WRTYP_MAINT_WRITE	    0x00007000
+#define ROWAR_SIZE_4KB		    0x0000000B
+#define ROWAR_SIZE_4MB		    0x00000015
+#define ROWAR_MAX_SEGS		    4		    /* must be power of 2 */
+#define ROWAR_MAX_SSEGS		    8		    /* idem */
+#define ROWAR_SIZE_MIN		    4096
+#define ROWSAR_SGTGTDID_MASK	    0x000000FF
+#define ROWSAR_RDTYP_NREAD	    0x00400000
+#define ROWSAR_WRTYP_NWRITE	    0x00040000
+
 #define DOORBELL_DMR_DI		0x00000002
 #define DOORBELL_DSR_TE		0x00000080
 #define DOORBELL_DSR_QFI	0x00000010
@@ -80,7 +125,7 @@ struct rio_atmu_regs {
 	u32 rowbar;
 	u32 pad2;
 	u32 rowar;
-	u32 pad3[3];
+	u32 rowsar[3];
 };
 
 struct rio_msg_regs {
@@ -171,6 +216,9 @@ struct rio_priv {
 	struct rio_dbell_ring dbell_ring;
 	struct rio_msg_tx_ring msg_tx_ring;
 	struct rio_msg_rx_ring msg_rx_ring;
+	int mem_atmu_segs[RIO_OUTB_ATMU_COUNT];
+	unsigned long law_start_free;
+	unsigned long law_end;
 	int bellirq;
 	int txirq;
 	int rxirq;
@@ -870,6 +918,129 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+int rio_open_outb_mem(struct rio_dev *rdev, int region, struct resource *res)
+{
+	struct rio_dev_mem *rmem;
+	resource_size_t start, len;
+	unsigned int seg, num_seg, num_sseg, used_segs, win_size_log;
+	unsigned long trad_start, sseg_len, win_start, win_size;
+	struct rio_mport *port = rdev->net->hport;
+	struct rio_priv *priv = port->priv;
+	u32 rowar, rowtar, rowsar;
+	u16 dev_destid, destid;
+	int i;
+
+	rmem = rio_find_dev_mem(rdev->vid, rdev->did, region);
+	if (!rmem)
+		return -ENODEV;
+
+	start = rmem->start;
+	len = rmem->len;
+	dev_destid = rdev->destid;
+	for (i = 0; i < RIO_OUTB_ATMU_COUNT; i++) {
+		rowar = in_be32(&priv->atmu_regs[i].rowar);
+		if (!(rowar & ROWAR_ENABLE))
+			continue;
+
+		rowtar = in_be32(&priv->atmu_regs[i].rowtar);
+		num_seg = 1 << ((rowar & ROWAR_NSEG_MASK) >> ROWAR_NSEG_SHIFT);
+		num_sseg = 1 << ((rowar & ROWAR_NSSEG_MASK) >> ROWAR_NSSEG_SHIFT);
+		sseg_len = (1 << ((rowar & ROWAR_SIZE_MASK) + 1)) / (num_seg * num_sseg);
+		/* trad_start is to be 33..2 */
+		trad_start = (rowtar & ROWTAR_TRAD_MASK) << (ROWTAR_TRAD_VAL_SHIFT - 2);
+		if (start < trad_start || start + (len >> 2) > trad_start + (sseg_len >> 2))
+			continue;
+
+		destid = (rowtar & ROWTAR_TREXAD_TID_MASK) >> ROWTAR_TREXAD_TID_SHIFT;
+		if (port->sys_size)
+			destid |= (((rowtar & ROWTAR_LTGTID_MASK) >> ROWTAR_LTGTID_SHIFT)
+					<< ROWTAR_LTGTID_VAL_SHIFT) |
+				(in_be32(&priv->atmu_regs[i].rowtear)
+					<< ROWTEAR_LTGTID_VAL_SHIFT);
+
+		seg = 0;
+		if (destid <= dev_destid && dev_destid < destid + num_sseg)
+			goto atmu_found;
+		used_segs = priv->mem_atmu_segs[i];
+		for (; seg < used_segs; seg++) {
+			rowsar = in_be32(&priv->atmu_regs[i].rowsar[seg]);
+			destid = rowsar & ROWSAR_SGTGTDID_MASK;
+			if (destid <= dev_destid && dev_destid < destid + num_sseg) {
+				/* seg = 0 <=> second segment in ATMU */
+				seg++;
+				goto atmu_found;
+			}
+		}
+		if (seg < ROWAR_MAX_SEGS) {
+			/* use segment for this destid range */
+			out_be32(&priv->atmu_regs[i].rowsar[seg], ROWSAR_RDTYP_NREAD |
+				ROWSAR_WRTYP_NWRITE | (dev_destid &
+				    (ROWSAR_SGTGTDID_MASK & ~(ROWAR_MAX_SSEGS-1))));
+			seg++;
+			/* seg = number of extra segments = segment number */
+			priv->mem_atmu_segs[i] = seg;
+			goto atmu_found;
+		}
+	}
+
+	/* try to find a new ATMU to configure */
+	for (i = 0; i < RIO_OUTB_ATMU_COUNT; i++)
+		if (!(in_be32(&priv->atmu_regs[i].rowar) & ROWAR_ENABLE))
+			break;
+
+	if (i == RIO_OUTB_ATMU_COUNT)
+		return -EBUSY;
+
+	sseg_len = rio_find_largest_dev_mem(start);
+	if (sseg_len < ROWAR_SIZE_MIN)
+		sseg_len = ROWAR_SIZE_MIN;
+	num_seg = ROWAR_MAX_SEGS;
+	num_sseg = ROWAR_MAX_SSEGS;
+	win_size = sseg_len * num_seg * num_sseg;
+	/* align win_size to next power of 2 */
+	win_size_log = __ilog2(win_size) + ((win_size & (win_size - 1)) != 0);
+	win_size = 1 << win_size_log;
+	/* align base address to next multiple of win_size */
+	win_start = (priv->law_start_free + win_size - 1) & ~(win_size - 1);
+	/* check if enough outbound memory */
+	if (priv->law_end - win_start < win_size)
+		return -EBUSY;
+
+	pr_debug(DRVNAME ": opening new window %d at 0x%08lx, size 0x%08lx (log %u)\n",
+			i, win_start, win_size, win_size_log);
+	rowtar = ((dev_destid & (ROWTAR_TREXAD_TID_VAL_MASK & ~(ROWAR_MAX_SSEGS-1)))
+		<< ROWTAR_TREXAD_TID_SHIFT) | (start >> (ROWTAR_TRAD_VAL_SHIFT - 2));
+	if (port->sys_size) {
+		rowtar |= (((dev_destid >> ROWTAR_LTGTID_VAL_SHIFT)
+			& ROWTAR_LTGTID_VAL_MASK) << ROWTAR_LTGTID_SHIFT);
+		out_be32(&priv->atmu_regs[i].rowtear,
+			dev_destid >> ROWTEAR_LTGTID_VAL_SHIFT);
+	}
+	out_be32(&priv->atmu_regs[i].rowtar, rowtar);
+	out_be32(&priv->atmu_regs[i].rowbar, win_start >> ROWBAR_BADD_VAL_SHIFT);
+	out_be32(&priv->atmu_regs[i].rowar, ROWAR_ENABLE | ROWAR_PCI |
+		ROWAR_NSEG_FOUR | ROWAR_NSSEG_EIGHT | ROWAR_RDTYP_NREAD |
+		ROWAR_WRTYP_NWRITE | (win_size_log - 1));
+	priv->law_start_free = win_start + win_size;
+	res->start = win_start;
+	seg = 0;
+	goto res_start_found;
+atmu_found:
+	res->start = start - trad_start +
+		((priv->atmu_regs[i].rowbar & ROWBAR_BADD_MASK) << ROWBAR_BADD_VAL_SHIFT);
+res_start_found:
+	res->start += (seg * num_sseg + (dev_destid & (ROWAR_MAX_SSEGS-1))) * sseg_len;
+	res->end = res->start + len - 1;
+	pr_debug(DRVNAME ": device destid %d mapped to 0x%08x-0x%08x (seg %d)\n",
+			dev_destid, res->start, res->end, seg);
+	return 0;
+}
+
+void rio_close_outb_mem(struct rio_dev *rdev, int window)
+{
+	/* TODO, keep track of window usage */
+}
+
 /**
  * fsl_rio_doorbell_init - MPC85xx doorbell interface init
  * @mport: Master port implementing the inbound doorbell unit
@@ -1168,6 +1339,8 @@ int fsl_rio_setup(struct of_device *dev)
 	out_be32(&priv->maint_atmu_regs->rowar, 0x80077015);	/* 4M */
 
 	priv->maint_win = ioremap(law_start, RIO_MAINT_WIN_SIZE);
+	priv->law_start_free = law_start + RIO_MAINT_WIN_SIZE;
+	priv->law_end = law_start + law_size;
 
 	/* Configure outbound doorbell window */
 	out_be32(&priv->dbell_atmu_regs->rowbar,
diff --git a/drivers/rapidio/rio-scan.c b/drivers/rapidio/rio-scan.c
index 4541509..3389fa5 100644
--- a/drivers/rapidio/rio-scan.c
+++ b/drivers/rapidio/rio-scan.c
@@ -387,8 +387,7 @@ static struct rio_dev __devinit *rio_setup_device(struct rio_net *net,
 
 	if ((rdev->pef & RIO_PEF_INB_DOORBELL) &&
 	    (rdev->dst_ops & RIO_DST_OPS_DOORBELL))
-		rio_init_dbell_res(&rdev->riores[RIO_DOORBELL_RESOURCE],
-				   0, 0xffff);
+		rio_init_dbell_res(&rdev->doorbell_res, 0, 0xffff);
 
 	ret = rio_add_device(rdev);
 	if (ret)
diff --git a/drivers/rapidio/rio.c b/drivers/rapidio/rio.c
index 6395c78..68eade9 100644
--- a/drivers/rapidio/rio.c
+++ b/drivers/rapidio/rio.c
@@ -28,6 +28,7 @@
 #include "rio.h"
 
 static LIST_HEAD(rio_mports);
+static LIST_HEAD(rio_dev_mem_list);
 
 /**
  * rio_local_get_device_id - Get the base/extended device id for a port
@@ -305,8 +306,7 @@ struct resource *rio_request_outb_dbell(struct rio_dev *rdev, u16 start,
 		rio_init_dbell_res(res, start, end);
 
 		/* Make sure these doorbells aren't in use */
-		if (request_resource(&rdev->riores[RIO_DOORBELL_RESOURCE], res)
-		    < 0) {
+		if (request_resource(&rdev->doorbell_res, res) < 0) {
 			kfree(res);
 			res = NULL;
 		}
@@ -388,6 +388,74 @@ rio_mport_get_feature(struct rio_mport * port, int local, u16 destid,
 	return 0;
 }
 
+int rio_claim_resource(u16 vid, u16 did, u32 start, u32 len)
+{
+	struct rio_dev_mem *rmem;
+
+	rmem = rio_find_dev_mem_by_addr(vid, did, start);
+	if (rmem != NULL) {
+		rmem->len = len;
+		return 0;
+	}
+
+	rmem = kzalloc(sizeof(*rmem), GFP_KERNEL);
+	if (rmem == NULL)
+		return -ENOMEM;
+
+	rmem->vendor_id = vid;
+	rmem->device_id = did;
+	rmem->start = start;
+	rmem->len = len;
+	spin_lock(&rio_global_list_lock);
+	list_add_tail(&rmem->node, &rio_dev_mem_list);
+	spin_unlock(&rio_global_list_lock);
+	return 0;
+}
+
+int rio_request_region(struct rio_dev *rdev, int region, char *res_name)
+{
+	struct resource *res;
+	int rc;
+
+	if (region >= RIO_MAX_REGIONS)
+		return -EINVAL;
+
+	if (rdev->mem_res[region] != NULL)
+		return -EBUSY;
+
+	res = kzalloc (sizeof(struct resource), GFP_KERNEL);
+	if (res == NULL)
+		return -ENOMEM;
+
+	rc = rio_open_outb_mem(rdev, region, res);
+	if (rc < 0)
+		goto err_res;
+
+	res->name = res_name;
+	rc = request_resource(&rdev->net->hport->iores, res);
+	if (rc < 0)
+		goto err_res;
+
+	rdev->mem_res[region] = res;
+	goto out;
+err_res:
+	kfree(res);
+	res = NULL;
+out:
+	return rc;
+}
+
+void rio_release_region(struct rio_dev *rdev, int region)
+{
+	if (region >= RIO_MAX_REGIONS)
+		return;
+
+	rio_close_outb_mem(rdev, region);
+	release_resource(rdev->mem_res[region]);
+	kfree(rdev->mem_res[region]);
+	rdev->mem_res[region] = NULL;
+}
+
 /**
  * rio_get_asm - Begin or continue searching for a RIO device by vid/did/asm_vid/asm_did
  * @vid: RIO vid to match or %RIO_ANY_ID to match all vids
@@ -451,6 +519,52 @@ struct rio_dev *rio_get_device(u16 vid, u16 did, struct rio_dev *from)
 	return rio_get_asm(vid, did, RIO_ANY_ID, RIO_ANY_ID, from);
 }
 
+static struct rio_dev_mem *rio_get_dev_mem(u16 vid, u16 did, int region, u32 start)
+{
+	struct rio_dev_mem *rmem;
+
+	spin_lock(&rio_global_list_lock);
+	list_for_each_entry(rmem, &rio_dev_mem_list, node) {
+		if (vid == rmem->vendor_id && did == rmem->device_id) {
+			if (region <= 0 && (start == RIO_ANY_ADDR || start == rmem->start))
+				goto out;
+			else
+				region--;
+		}
+	}
+
+	rmem = NULL;
+out:
+	spin_unlock(&rio_global_list_lock);
+	return rmem;
+}
+
+struct rio_dev_mem *rio_find_dev_mem(u16 vid, u16 did, int region)
+{
+	return rio_get_dev_mem(vid, did, region, RIO_ANY_ADDR);
+}
+
+struct rio_dev_mem *rio_find_dev_mem_by_addr(u16 vid, u16 did, u32 start)
+{
+	return rio_get_dev_mem(vid, did, -1, start);
+}
+
+u32 rio_find_largest_dev_mem(u32 start)
+{
+	struct rio_dev_mem *rmem;
+	u32 len;
+
+	len = 0;
+	spin_lock(&rio_global_list_lock);
+	list_for_each_entry(rmem, &rio_dev_mem_list, node) {
+		if (rmem->start == start && rmem->len > len)
+			len = rmem->len;
+	}
+	spin_unlock(&rio_global_list_lock);
+
+	return len;
+}
+
 static void rio_fixup_device(struct rio_dev *dev)
 {
 }
@@ -509,3 +623,6 @@ EXPORT_SYMBOL_GPL(rio_request_inb_mbox);
 EXPORT_SYMBOL_GPL(rio_release_inb_mbox);
 EXPORT_SYMBOL_GPL(rio_request_outb_mbox);
 EXPORT_SYMBOL_GPL(rio_release_outb_mbox);
+EXPORT_SYMBOL_GPL(rio_claim_resource);
+EXPORT_SYMBOL_GPL(rio_request_region);
+EXPORT_SYMBOL_GPL(rio_release_region);
diff --git a/include/linux/rio.h b/include/linux/rio.h
index dc0c755..343d714 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -25,7 +25,7 @@
 #define RIO_INVALID_DESTID	0xffff
 
 #define RIO_MAX_MPORT_RESOURCES	16
-#define RIO_MAX_DEV_RESOURCES	16
+#define RIO_MAX_REGIONS		16
 
 #define RIO_GLOBAL_TABLE	0xff	/* Indicates access of a switch's
 					   global routing table if it
@@ -36,6 +36,8 @@
 					   entry is invalid (no route
 					   exists for the device ID) */
 
+#define RIO_ANY_ADDR		0xffffffff
+
 #define RIO_MAX_ROUTE_ENTRIES(size)	(size ? (1 << 16) : (1 << 8))
 #define RIO_ANY_DESTID(size)		(size ? 0xffff : 0xff)
 
@@ -69,6 +71,14 @@ extern struct list_head rio_devices;	/* list of all devices */
 
 struct rio_mport;
 
+struct rio_dev_mem {
+	struct list_head node;
+	unsigned short vendor_id;
+	unsigned short device_id;
+	u32 start;	    /* bits 33..2 */
+	u32 len;
+};
+
 /**
  * struct rio_dev - RIO device info
  * @global_list: Node in list of all RIO devices
@@ -89,7 +99,8 @@ struct rio_mport;
  * @rswitch: Pointer to &struct rio_switch if valid for this device
  * @driver: Driver claiming this device
  * @dev: Device model device
- * @riores: RIO resources this device owns
+ * @mem_res: RIO resources this device owns
+ * @doorbell_res: Outbound doorbell ranges in use by drivers/users
  * @destid: Network destination ID
  */
 struct rio_dev {
@@ -111,7 +122,8 @@ struct rio_dev {
 	struct rio_switch *rswitch;	/* RIO switch info */
 	struct rio_driver *driver;	/* RIO driver claiming this device */
 	struct device dev;	/* LDM device structure */
-	struct resource riores[RIO_MAX_DEV_RESOURCES];
+	struct resource *mem_res[RIO_MAX_REGIONS];
+	struct resource doorbell_res;
 	u16 destid;
 };
 
@@ -330,5 +342,7 @@ extern int rio_open_inb_mbox(struct rio_mport *, void *, int, int);
 extern void rio_close_inb_mbox(struct rio_mport *, int);
 extern int rio_open_outb_mbox(struct rio_mport *, void *, int, int);
 extern void rio_close_outb_mbox(struct rio_mport *, int);
+extern int rio_open_outb_mem(struct rio_dev *, int, struct resource *res);
+extern void rio_close_outb_mem(struct rio_dev *, int);
 
 #endif				/* LINUX_RIO_H */
diff --git a/include/linux/rio_drv.h b/include/linux/rio_drv.h
index c93a58a..cbcd68d 100644
--- a/include/linux/rio_drv.h
+++ b/include/linux/rio_drv.h
@@ -407,7 +407,7 @@ extern struct resource *rio_request_outb_dbell(struct rio_dev *, u16, u16);
 extern int rio_release_outb_dbell(struct rio_dev *, struct resource *);
 
 /* Memory region management */
-int rio_claim_resource(struct rio_dev *, int);
+int rio_claim_resource(u16 vid, u16 did, u32 start, u32 len);
 int rio_request_regions(struct rio_dev *, char *);
 void rio_release_regions(struct rio_dev *);
 int rio_request_region(struct rio_dev *, int, char *);
@@ -461,5 +461,8 @@ extern u16 rio_local_get_device_id(struct rio_mport *port);
 extern struct rio_dev *rio_get_device(u16 vid, u16 did, struct rio_dev *from);
 extern struct rio_dev *rio_get_asm(u16 vid, u16 did, u16 asm_vid, u16 asm_did,
 				   struct rio_dev *from);
+extern struct rio_dev_mem *rio_find_dev_mem(u16 vid, u16 did, int region);
+extern struct rio_dev_mem *rio_find_dev_mem_by_addr(u16 vid, u16 did, u32 start);
+extern u32 rio_find_largest_dev_mem(u32 start);
 
 #endif				/* LINUX_RIO_DRV_H */
-- 
1.6.5.7
