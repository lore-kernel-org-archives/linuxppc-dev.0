Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B224CDDE45
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 11:37:47 +1000 (EST)
Date: Mon, 24 Sep 2007 02:54:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 11/11] [POWERPC] iSeries: move viodasd probing
Message-Id: <20070924025416.b5bf16c2.sfr@canb.auug.org.au>
In-Reply-To: <20070921144051.fe554f57.sfr@canb.auug.org.au>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
	<20070921143102.eb30d770.sfr@canb.auug.org.au>
	<20070921143205.64271521.sfr@canb.auug.org.au>
	<20070921143337.0e4a2f0a.sfr@canb.auug.org.au>
	<20070921143446.ad55d494.sfr@canb.auug.org.au>
	<20070921143540.75f3becf.sfr@canb.auug.org.au>
	<20070921143647.7ceebabc.sfr@canb.auug.org.au>
	<20070921143750.4114b0b5.sfr@canb.auug.org.au>
	<20070921143841.37ad2a2f.sfr@canb.auug.org.au>
	<20070921143954.3b707ab5.sfr@canb.auug.org.au>
	<20070921144051.fe554f57.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This way we only have entries in the device tree for disks that actually
exist.  A slight complication is that disks may be attached to LPARs
at runtime.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/dt.c  |    6 -
 arch/powerpc/platforms/iseries/vio.c |  301 +++++++++++++++++++++++----------
 drivers/block/viodasd.c              |   77 +++------
 include/asm-powerpc/iseries/vio.h    |   47 ++++++
 4 files changed, 282 insertions(+), 149 deletions(-)

This version creates the device tree entries unconditionally.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index 2e4ad6b..4543c4b 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -72,7 +72,6 @@ static char __initdata device_type_cpu[] = "cpu";
 static char __initdata device_type_memory[] = "memory";
 static char __initdata device_type_serial[] = "serial";
 static char __initdata device_type_network[] = "network";
-static char __initdata device_type_block[] = "block";
 static char __initdata device_type_pci[] = "pci";
 static char __initdata device_type_vdevice[] = "vdevice";
 static char __initdata device_type_vscsi[] = "vscsi";
@@ -374,11 +373,6 @@ static void __init dt_vdevices(struct iseries_flat_dt *dt)
 
 		dt_end_node(dt);
 	}
-	reg += HVMAXARCHITECTEDVIRTUALLANS;
-
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++)
-		dt_do_vdevice(dt, "viodasd", reg, i, device_type_block,
-				"IBM,iSeries-viodasd", 1);
 
 	dt_end_node(dt);
 }
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index b4f7433..d6435b0 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -25,8 +25,10 @@
 #include <linux/gfp.h>
 #include <linux/completion.h>
 #include <linux/proc_fs.h>
+#include <linux/module.h>
 
 #include <asm/firmware.h>
+#include <asm/vio.h>
 #include <asm/iseries/vio.h>
 #include <asm/iseries/iommu.h>
 #include <asm/iseries/hv_types.h>
@@ -57,7 +59,7 @@ struct vio_resource {
 	char	model[3];
 };
 
-static struct property * __init new_property(const char *name, int length,
+static struct property *new_property(const char *name, int length,
 		const void *value)
 {
 	struct property *np = kzalloc(sizeof(*np) + strlen(name) + 1 + length,
@@ -78,7 +80,7 @@ static void __init free_property(struct property *np)
 	kfree(np);
 }
 
-static struct device_node * __init new_node(const char *path,
+static struct device_node *new_node(const char *path,
 		struct device_node *parent)
 {
 	struct device_node *np = kzalloc(sizeof(*np), GFP_KERNEL);
@@ -97,7 +99,7 @@ static struct device_node * __init new_node(const char *path,
 	return np;
 }
 
-static void __init free_node(struct device_node *np)
+static void free_node(struct device_node *np)
 {
 	struct property *next;
 	struct property *prop;
@@ -113,7 +115,7 @@ static void __init free_node(struct device_node *np)
 	kfree(np);
 }
 
-static int __init add_string_property(struct device_node *np, const char *name,
+static int add_string_property(struct device_node *np, const char *name,
 		const char *value)
 {
 	struct property *nprop = new_property(name, strlen(value) + 1, value);
@@ -124,7 +126,7 @@ static int __init add_string_property(struct device_node *np, const char *name,
 	return 1;
 }
 
-static int __init add_raw_property(struct device_node *np, const char *name,
+static int add_raw_property(struct device_node *np, const char *name,
 		int length, const void *value)
 {
 	struct property *nprop = new_property(name, length, value);
@@ -135,6 +137,201 @@ static int __init add_raw_property(struct device_node *np, const char *name,
 	return 1;
 }
 
+static struct device_node *do_device_node(struct device_node *parent,
+		const char *name, u32 reg, u32 unit, const char *type,
+		const char *compat, struct vio_resource *res)
+{
+	struct device_node *np;
+	char path[32];
+
+	snprintf(path, sizeof(path), "/vdevice/%s@%08x", name, reg);
+	np = new_node(path, parent);
+	if (!np)
+		return NULL;
+	if (!add_string_property(np, "name", name) ||
+		!add_string_property(np, "device_type", type) ||
+		!add_string_property(np, "compatible", compat) ||
+		!add_raw_property(np, "reg", sizeof(reg), &reg) ||
+		!add_raw_property(np, "linux,unit_address",
+			sizeof(unit), &unit)) {
+		goto node_free;
+	}
+	if (res) {
+		if (!add_raw_property(np, "linux,vio_rsrcname",
+				sizeof(res->rsrcname), res->rsrcname) ||
+			!add_raw_property(np, "linux,vio_type",
+				sizeof(res->type), res->type) ||
+			!add_raw_property(np, "linux,vio_model",
+				sizeof(res->model), res->model))
+			goto node_free;
+	}
+	np->name = of_get_property(np, "name", NULL);
+	np->type = of_get_property(np, "device_type", NULL);
+	of_attach_node(np);
+#ifdef CONFIG_PROC_DEVICETREE
+	if (parent->pde) {
+		struct proc_dir_entry *ent;
+
+		ent = proc_mkdir(strrchr(np->full_name, '/') + 1, parent->pde);
+		if (ent)
+			proc_device_tree_add_node(np, ent);
+	}
+#endif
+	return np;
+
+ node_free:
+	free_node(np);
+	return NULL;
+}
+
+/*
+ * This is here so that we can dynamically add viodasd
+ * devices without exposing all the above infrastructure.
+ */
+struct vio_dev *vio_create_viodasd(u32 unit)
+{
+	struct device_node *vio_root;
+	struct device_node *np;
+	struct vio_dev *vdev = NULL;
+
+	vio_root = of_find_node_by_path("/vdevice");
+	if (!vio_root)
+		return NULL;
+	np = do_device_node(vio_root, "viodasd", FIRST_VIODASD + unit, unit,
+			"block", "IBM,iSeries-viodasd", NULL);
+	of_node_put(vio_root);
+	if (np) {
+		vdev = vio_register_device_node(np);
+		if (!vdev)
+			free_node(np);
+	}
+	return vdev;
+}
+EXPORT_SYMBOL_GPL(vio_create_viodasd);
+
+static void __init handle_block_event(struct HvLpEvent *event)
+{
+	struct vioblocklpevent *bevent = (struct vioblocklpevent *)event;
+	struct vio_waitevent *pwe;
+
+	if (event == NULL)
+		/* Notification that a partition went away! */
+		return;
+	/* First, we should NEVER get an int here...only acks */
+	if (hvlpevent_is_int(event)) {
+		printk(KERN_WARNING "handle_viod_request: "
+		       "Yikes! got an int in viodasd event handler!\n");
+		if (hvlpevent_need_ack(event)) {
+			event->xRc = HvLpEvent_Rc_InvalidSubtype;
+			HvCallEvent_ackLpEvent(event);
+		}
+		return;
+	}
+
+	switch (event->xSubtype & VIOMINOR_SUBTYPE_MASK) {
+	case vioblockopen:
+		/*
+		 * Handle a response to an open request.  We get all the
+		 * disk information in the response, so update it.  The
+		 * correlation token contains a pointer to a waitevent
+		 * structure that has a completion in it.  update the
+		 * return code in the waitevent structure and post the
+		 * completion to wake up the guy who sent the request
+		 */
+		pwe = (struct vio_waitevent *)event->xCorrelationToken;
+		pwe->rc = event->xRc;
+		pwe->sub_result = bevent->sub_result;
+		complete(&pwe->com);
+		break;
+	case vioblockclose:
+		break;
+	default:
+		printk(KERN_WARNING "handle_viod_request: unexpected subtype!");
+		if (hvlpevent_need_ack(event)) {
+			event->xRc = HvLpEvent_Rc_InvalidSubtype;
+			HvCallEvent_ackLpEvent(event);
+		}
+	}
+}
+
+static void __init probe_disk(struct device_node *vio_root, u32 unit)
+{
+	HvLpEvent_Rc hvrc;
+	struct vio_waitevent we;
+	u16 flags = 0;
+
+retry:
+	init_completion(&we.com);
+
+	/* Send the open event to OS/400 */
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_blockio | vioblockopen,
+			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			(u64)(unsigned long)&we, VIOVERSION << 16,
+			((u64)unit << 48) | ((u64)flags<< 32),
+			0, 0, 0);
+	if (hvrc != 0) {
+		printk(KERN_WARNING "probe_disk: bad rc on HV open %d\n",
+			(int)hvrc);
+		return;
+	}
+
+	wait_for_completion(&we.com);
+
+	if (we.rc != 0) {
+		if (flags != 0)
+			return;
+		/* try again with read only flag set */
+		flags = vioblockflags_ro;
+		goto retry;
+	}
+
+	/* Send the close event to OS/400.  We DON'T expect a response */
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_blockio | vioblockclose,
+			HvLpEvent_AckInd_NoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			0, VIOVERSION << 16,
+			((u64)unit << 48) | ((u64)flags << 32),
+			0, 0, 0);
+	if (hvrc != 0) {
+		printk(KERN_WARNING "probe_disk: "
+		       "bad rc sending event to OS/400 %d\n", (int)hvrc);
+		return;
+	}
+
+	do_device_node(vio_root, "viodasd", FIRST_VIODASD + unit, unit,
+			"block", "IBM,iSeries-viodasd", NULL);
+}
+
+static void __init get_viodasd_info(struct device_node *vio_root)
+{
+	int rc;
+	u32 unit;
+
+	rc = viopath_open(viopath_hostLp, viomajorsubtype_blockio, 2);
+	if (rc) {
+		printk(KERN_WARNING "get_viodasd_info: "
+		       "error opening path to host partition %d\n",
+		       viopath_hostLp);
+		return;
+	}
+
+	/* Initialize our request handler */
+	vio_setHandler(viomajorsubtype_blockio, handle_block_event);
+
+	for (unit = 0; unit < HVMAXARCHITECTEDVIRTUALDISKS; unit++)
+		probe_disk(vio_root, unit);
+
+	vio_clearHandler(viomajorsubtype_blockio);
+	viopath_close(viopath_hostLp, viomajorsubtype_blockio, 2);
+}
+
 static void __init handle_cd_event(struct HvLpEvent *event)
 {
 	struct viocdlpevent *bevent;
@@ -233,49 +430,9 @@ static void __init get_viocd_info(struct device_node *vio_root)
 
 	for (unit = 0; (unit < HVMAXARCHITECTEDVIRTUALCDROMS) &&
 			unitinfo[unit].rsrcname[0]; unit++) {
-		struct device_node *np;
-		char name[64];
-		u32 reg = FIRST_VIOCD + unit;
-
-		snprintf(name, sizeof(name), "/vdevice/viocd@%08x", reg);
-		np = new_node(name, vio_root);
-		if (!np)
-			goto hv_free;
-		if (!add_string_property(np, "name", "viocd") ||
-			!add_string_property(np, "device_type", "block") ||
-			!add_string_property(np, "compatible",
-				"IBM,iSeries-viocd") ||
-			!add_raw_property(np, "reg", sizeof(reg), &reg) ||
-			!add_raw_property(np, "linux,unit_address",
-				sizeof(unit), &unit) ||
-			!add_raw_property(np, "linux,vio_rsrcname",
-				sizeof(unitinfo[unit].rsrcname),
-				unitinfo[unit].rsrcname) ||
-			!add_raw_property(np, "linux,vio_type",
-				sizeof(unitinfo[unit].type),
-				unitinfo[unit].type) ||
-			!add_raw_property(np, "linux,vio_model",
-				sizeof(unitinfo[unit].model),
-				unitinfo[unit].model))
-			goto node_free;
-		np->name = of_get_property(np, "name", NULL);
-		np->type = of_get_property(np, "device_type", NULL);
-		of_attach_node(np);
-#ifdef CONFIG_PROC_DEVICETREE
-		if (vio_root->pde) {
-			struct proc_dir_entry *ent;
-
-			ent = proc_mkdir(strrchr(np->full_name, '/') + 1,
-					vio_root->pde);
-			if (ent)
-				proc_device_tree_add_node(np, ent);
-		}
-#endif
-		continue;
-
- node_free:
-		free_node(np);
-		break;
+		if (!do_device_node(vio_root, "viocd", FIRST_VIOCD + unit, unit,
+				"block", "IBM,iSeries-viocd", &unitinfo[unit]))
+			break;
 	}
 
  hv_free:
@@ -350,49 +507,10 @@ static void __init get_viotape_info(struct device_node *vio_root)
 
 	for (unit = 0; (unit < HVMAXARCHITECTEDVIRTUALTAPES) &&
 			unitinfo[unit].rsrcname[0]; unit++) {
-		struct device_node *np;
-		char name[64];
-		u32 reg = FIRST_VIOTAPE + unit;
-
-		snprintf(name, sizeof(name), "/vdevice/viotape@%08x", reg);
-		np = new_node(name, vio_root);
-		if (!np)
-			goto hv_free;
-		if (!add_string_property(np, "name", "viotape") ||
-			!add_string_property(np, "device_type", "byte") ||
-			!add_string_property(np, "compatible",
-				"IBM,iSeries-viotape") ||
-			!add_raw_property(np, "reg", sizeof(reg), &reg) ||
-			!add_raw_property(np, "linux,unit_address",
-				sizeof(unit), &unit) ||
-			!add_raw_property(np, "linux,vio_rsrcname",
-				sizeof(unitinfo[unit].rsrcname),
-				unitinfo[unit].rsrcname) ||
-			!add_raw_property(np, "linux,vio_type",
-				sizeof(unitinfo[unit].type),
-				unitinfo[unit].type) ||
-			!add_raw_property(np, "linux,vio_model",
-				sizeof(unitinfo[unit].model),
-				unitinfo[unit].model))
-			goto node_free;
-		np->name = of_get_property(np, "name", NULL);
-		np->type = of_get_property(np, "device_type", NULL);
-		of_attach_node(np);
-#ifdef CONFIG_PROC_DEVICETREE
-		if (vio_root->pde) {
-			struct proc_dir_entry *ent;
-
-			ent = proc_mkdir(strrchr(np->full_name, '/') + 1,
-					vio_root->pde);
-			if (ent)
-				proc_device_tree_add_node(np, ent);
-		}
-#endif
-		continue;
-
- node_free:
-		free_node(np);
-		break;
+		if (!do_device_node(vio_root, "viotape", FIRST_VIOTAPE + unit,
+				unit, "byte", "IBM,iSeries-viotape",
+				&unitinfo[unit]))
+			break;
 	}
 
  hv_free:
@@ -422,6 +540,7 @@ static int __init iseries_vio_init(void)
 			goto put_node;
 	}
 
+	get_viodasd_info(vio_root);
 	get_viocd_info(vio_root);
 	get_viotape_info(vio_root);
 
diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
index af3969a..e824b67 100644
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -74,53 +74,9 @@ enum {
 static DEFINE_SPINLOCK(viodasd_spinlock);
 
 #define VIOMAXREQ		16
-#define VIOMAXBLOCKDMA		12
 
 #define DEVICE_NO(cell)	((struct viodasd_device *)(cell) - &viodasd_devices[0])
 
-struct open_data {
-	u64	disk_size;
-	u16	max_disk;
-	u16	cylinders;
-	u16	tracks;
-	u16	sectors;
-	u16	bytes_per_sector;
-};
-
-struct rw_data {
-	u64	offset;
-	struct {
-		u32	token;
-		u32	reserved;
-		u64	len;
-	} dma_info[VIOMAXBLOCKDMA];
-};
-
-struct vioblocklpevent {
-	struct HvLpEvent	event;
-	u32			reserved;
-	u16			version;
-	u16			sub_result;
-	u16			disk;
-	u16			flags;
-	union {
-		struct open_data	open_data;
-		struct rw_data		rw_data;
-		u64			changed;
-	} u;
-};
-
-#define vioblockflags_ro   0x0001
-
-enum vioblocksubtype {
-	vioblockopen = 0x0001,
-	vioblockclose = 0x0002,
-	vioblockread = 0x0003,
-	vioblockwrite = 0x0004,
-	vioblockflush = 0x0005,
-	vioblockcheck = 0x0007
-};
-
 struct viodasd_waitevent {
 	struct completion	com;
 	int			rc;
@@ -429,7 +385,7 @@ static void do_viodasd_request(struct request_queue *q)
  * Probe a single disk and fill in the viodasd_device structure
  * for it.
  */
-static void probe_disk(struct viodasd_device *d)
+static int probe_disk(struct viodasd_device *d)
 {
 	HvLpEvent_Rc hvrc;
 	struct viodasd_waitevent we;
@@ -453,14 +409,14 @@ retry:
 			0, 0, 0);
 	if (hvrc != 0) {
 		printk(VIOD_KERN_WARNING "bad rc on HV open %d\n", (int)hvrc);
-		return;
+		return 0;
 	}
 
 	wait_for_completion(&we.com);
 
 	if (we.rc != 0) {
 		if (flags != 0)
-			return;
+			return 0;
 		/* try again with read only flag set */
 		flags = vioblockflags_ro;
 		goto retry;
@@ -490,15 +446,32 @@ retry:
 	if (hvrc != 0) {
 		printk(VIOD_KERN_WARNING
 		       "bad rc sending event to OS/400 %d\n", (int)hvrc);
-		return;
+		return 0;
 	}
+
+	if (d->dev == NULL) {
+		/* this is when we reprobe for new disks */
+		if (vio_create_viodasd(dev_no) == NULL) {
+			printk(VIOD_KERN_WARNING
+				"cannot allocate virtual device for disk %d\n",
+				dev_no);
+			return 0;
+		}
+		/*
+		 * The vio_create_viodasd will have recursed into this
+		 * routine with d->dev set to the new vio device and
+		 * will finish the setup of the disk below.
+		 */
+		return 1;
+	}
+
 	/* create the request queue for the disk */
 	spin_lock_init(&d->q_lock);
 	q = blk_init_queue(do_viodasd_request, &d->q_lock);
 	if (q == NULL) {
 		printk(VIOD_KERN_WARNING "cannot allocate queue for disk %d\n",
 				dev_no);
-		return;
+		return 0;
 	}
 	g = alloc_disk(1 << PARTITION_SHIFT);
 	if (g == NULL) {
@@ -506,7 +479,7 @@ retry:
 				"cannot allocate disk structure for disk %d\n",
 				dev_no);
 		blk_cleanup_queue(q);
-		return;
+		return 0;
 	}
 
 	d->disk = g;
@@ -538,6 +511,7 @@ retry:
 
 	/* register us in the global list */
 	add_disk(g);
+	return 1;
 }
 
 /* returns the total number of scatterlist elements converted */
@@ -718,8 +692,7 @@ static int viodasd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	struct viodasd_device *d = &viodasd_devices[vdev->unit_address];
 
 	d->dev = &vdev->dev;
-	probe_disk(d);
-	if (d->disk == NULL)
+	if (!probe_disk(d))
 		return -ENODEV;
 	return 0;
 }
diff --git a/include/asm-powerpc/iseries/vio.h b/include/asm-powerpc/iseries/vio.h
index 2555dfd..f9ac0d0 100644
--- a/include/asm-powerpc/iseries/vio.h
+++ b/include/asm-powerpc/iseries/vio.h
@@ -51,6 +51,51 @@
  */
 #define VIO_MAX_SUBTYPES 8
 
+#define VIOMAXBLOCKDMA	12
+
+struct open_data {
+	u64	disk_size;
+	u16	max_disk;
+	u16	cylinders;
+	u16	tracks;
+	u16	sectors;
+	u16	bytes_per_sector;
+};
+
+struct rw_data {
+	u64	offset;
+	struct {
+		u32	token;
+		u32	reserved;
+		u64	len;
+	} dma_info[VIOMAXBLOCKDMA];
+};
+
+struct vioblocklpevent {
+	struct HvLpEvent	event;
+	u32			reserved;
+	u16			version;
+	u16			sub_result;
+	u16			disk;
+	u16			flags;
+	union {
+		struct open_data	open_data;
+		struct rw_data		rw_data;
+		u64			changed;
+	} u;
+};
+
+#define vioblockflags_ro   0x0001
+
+enum vioblocksubtype {
+	vioblockopen = 0x0001,
+	vioblockclose = 0x0002,
+	vioblockread = 0x0003,
+	vioblockwrite = 0x0004,
+	vioblockflush = 0x0005,
+	vioblockcheck = 0x0007
+};
+
 struct viocdlpevent {
 	struct HvLpEvent	event;
 	u32			reserved;
@@ -133,6 +178,8 @@ extern void vio_set_hostlp(void);
 extern void *vio_get_event_buffer(int subtype);
 extern void vio_free_event_buffer(int subtype, void *buffer);
 
+extern struct vio_dev *vio_create_viodasd(u32 unit);
+
 extern HvLpIndex viopath_hostLp;
 extern HvLpIndex viopath_ourLp;
 
-- 
1.5.3.2
