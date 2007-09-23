Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6F84FDDE3F
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 11:37:46 +1000 (EST)
Date: Mon, 24 Sep 2007 02:52:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 09/11] [POWERPC] iSeries: move detection of virtual tapes
Message-Id: <20070924025230.62df2dbf.sfr@canb.auug.org.au>
In-Reply-To: <20070921143841.37ad2a2f.sfr@canb.auug.org.au>
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

Now we will only have entries in the device tree for the actual existing
devices (including their OS/400 properties).  This way viotape.c gets
all the information about the devices from the device tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/dt.c  |    7 --
 arch/powerpc/platforms/iseries/vio.c |  149 ++++++++++++++++++++++++++++++----
 drivers/char/viotape.c               |  124 ++++------------------------
 include/asm-powerpc/iseries/vio.h    |   41 +++++++++
 4 files changed, 192 insertions(+), 129 deletions(-)

This version creates the device tree entries unconditionally.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index 84fcee1..2e4ad6b 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -73,7 +73,6 @@ static char __initdata device_type_memory[] = "memory";
 static char __initdata device_type_serial[] = "serial";
 static char __initdata device_type_network[] = "network";
 static char __initdata device_type_block[] = "block";
-static char __initdata device_type_byte[] = "byte";
 static char __initdata device_type_pci[] = "pci";
 static char __initdata device_type_vdevice[] = "vdevice";
 static char __initdata device_type_vscsi[] = "vscsi";
@@ -380,12 +379,6 @@ static void __init dt_vdevices(struct iseries_flat_dt *dt)
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALDISKS; i++)
 		dt_do_vdevice(dt, "viodasd", reg, i, device_type_block,
 				"IBM,iSeries-viodasd", 1);
-	reg += HVMAXARCHITECTEDVIRTUALDISKS;
-	reg += HVMAXARCHITECTEDVIRTUALCDROMS;
-
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++)
-		dt_do_vdevice(dt, "viotape", reg, i, device_type_byte,
-				"IBM,iSeries-viotape", 1);
 
 	dt_end_node(dt);
 }
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
index 08f6884..b4f7433 100644
--- a/arch/powerpc/platforms/iseries/vio.c
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -45,6 +45,18 @@
 #define FIRST_VIOTAPE	(FIRST_VIOCD + NUM_VIOCDS)
 #define NUM_VIOTAPES	HVMAXARCHITECTEDVIRTUALTAPES
 
+struct vio_waitevent {
+	struct completion	com;
+	int			rc;
+	u16			sub_result;
+};
+
+struct vio_resource {
+	char	rsrcname[10];
+	char	type[4];
+	char	model[3];
+};
+
 static struct property * __init new_property(const char *name, int length,
 		const void *value)
 {
@@ -123,22 +135,10 @@ static int __init add_raw_property(struct device_node *np, const char *name,
 	return 1;
 }
 
-struct viocd_waitevent {
-	struct completion	com;
-	int			rc;
-	u16			sub_result;
-};
-
-struct cdrom_info {
-	char	rsrcname[10];
-	char	type[4];
-	char	model[3];
-};
-
 static void __init handle_cd_event(struct HvLpEvent *event)
 {
 	struct viocdlpevent *bevent;
-	struct viocd_waitevent *pwe;
+	struct vio_waitevent *pwe;
 
 	if (!event)
 		/* Notification that a partition went away! */
@@ -158,7 +158,7 @@ static void __init handle_cd_event(struct HvLpEvent *event)
 
 	switch (event->xSubtype & VIOMINOR_SUBTYPE_MASK) {
 	case viocdgetinfo:
-		pwe = (struct viocd_waitevent *)event->xCorrelationToken;
+		pwe = (struct vio_waitevent *)event->xCorrelationToken;
 		pwe->rc = event->xRc;
 		pwe->sub_result = bevent->sub_result;
 		complete(&pwe->com);
@@ -179,8 +179,8 @@ static void __init get_viocd_info(struct device_node *vio_root)
 {
 	HvLpEvent_Rc hvrc;
 	u32 unit;
-	struct viocd_waitevent we;
-	struct cdrom_info *unitinfo;
+	struct vio_waitevent we;
+	struct vio_resource *unitinfo;
 	dma_addr_t unitinfo_dmaaddr;
 	int ret;
 
@@ -286,6 +286,122 @@ static void __init get_viocd_info(struct device_node *vio_root)
 	viopath_close(viopath_hostLp, viomajorsubtype_cdio, 2);
 }
 
+/* Handle interrupt events for tape */
+static void __init handle_tape_event(struct HvLpEvent *event)
+{
+	struct vio_waitevent *we;
+	struct viotapelpevent *tevent = (struct viotapelpevent *)event;
+
+	if (event == NULL)
+		/* Notification that a partition went away! */
+		return;
+
+	we = (struct vio_waitevent *)event->xCorrelationToken;
+	switch (event->xSubtype & VIOMINOR_SUBTYPE_MASK) {
+	case viotapegetinfo:
+		we->rc = tevent->sub_type_result;
+		complete(&we->com);
+		break;
+	default:
+		printk(KERN_WARNING "handle_tape_event: weird ack\n");
+	}
+}
+
+static void __init get_viotape_info(struct device_node *vio_root)
+{
+	HvLpEvent_Rc hvrc;
+	u32 unit;
+	struct vio_resource *unitinfo;
+	dma_addr_t unitinfo_dmaaddr;
+	size_t len = sizeof(*unitinfo) * HVMAXARCHITECTEDVIRTUALTAPES;
+	struct vio_waitevent we;
+	int ret;
+
+	ret = viopath_open(viopath_hostLp, viomajorsubtype_tape, 2);
+	if (ret) {
+		printk(KERN_WARNING "get_viotape_info: "
+			"error on viopath_open to hostlp %d\n", ret);
+		return;
+	}
+
+	vio_setHandler(viomajorsubtype_tape, handle_tape_event);
+
+	unitinfo = iseries_hv_alloc(len, &unitinfo_dmaaddr, GFP_ATOMIC);
+	if (!unitinfo)
+		goto clear_handler;
+
+	memset(unitinfo, 0, len);
+
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_tape | viotapegetinfo,
+			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			(u64)(unsigned long)&we, VIOVERSION << 16,
+			unitinfo_dmaaddr, len, 0, 0);
+	if (hvrc != HvLpEvent_Rc_Good) {
+		printk(KERN_WARNING "get_viotape_info: hv error on op %d\n",
+				(int)hvrc);
+		goto hv_free;
+	}
+
+	wait_for_completion(&we.com);
+
+	for (unit = 0; (unit < HVMAXARCHITECTEDVIRTUALTAPES) &&
+			unitinfo[unit].rsrcname[0]; unit++) {
+		struct device_node *np;
+		char name[64];
+		u32 reg = FIRST_VIOTAPE + unit;
+
+		snprintf(name, sizeof(name), "/vdevice/viotape@%08x", reg);
+		np = new_node(name, vio_root);
+		if (!np)
+			goto hv_free;
+		if (!add_string_property(np, "name", "viotape") ||
+			!add_string_property(np, "device_type", "byte") ||
+			!add_string_property(np, "compatible",
+				"IBM,iSeries-viotape") ||
+			!add_raw_property(np, "reg", sizeof(reg), &reg) ||
+			!add_raw_property(np, "linux,unit_address",
+				sizeof(unit), &unit) ||
+			!add_raw_property(np, "linux,vio_rsrcname",
+				sizeof(unitinfo[unit].rsrcname),
+				unitinfo[unit].rsrcname) ||
+			!add_raw_property(np, "linux,vio_type",
+				sizeof(unitinfo[unit].type),
+				unitinfo[unit].type) ||
+			!add_raw_property(np, "linux,vio_model",
+				sizeof(unitinfo[unit].model),
+				unitinfo[unit].model))
+			goto node_free;
+		np->name = of_get_property(np, "name", NULL);
+		np->type = of_get_property(np, "device_type", NULL);
+		of_attach_node(np);
+#ifdef CONFIG_PROC_DEVICETREE
+		if (vio_root->pde) {
+			struct proc_dir_entry *ent;
+
+			ent = proc_mkdir(strrchr(np->full_name, '/') + 1,
+					vio_root->pde);
+			if (ent)
+				proc_device_tree_add_node(np, ent);
+		}
+#endif
+		continue;
+
+ node_free:
+		free_node(np);
+		break;
+	}
+
+ hv_free:
+	iseries_hv_free(len, unitinfo, unitinfo_dmaaddr);
+ clear_handler:
+	vio_clearHandler(viomajorsubtype_tape);
+	viopath_close(viopath_hostLp, viomajorsubtype_tape, 2);
+}
+
 static int __init iseries_vio_init(void)
 {
 	struct device_node *vio_root;
@@ -307,6 +423,7 @@ static int __init iseries_vio_init(void)
 	}
 
 	get_viocd_info(vio_root);
+	get_viotape_info(vio_root);
 
 	return 0;
 
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index 064c091..f1d60f0 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -92,47 +92,6 @@ struct viot_devinfo_struct {
 #define VIOTAPOP_SETPART       14
 #define VIOTAPOP_UNLOAD        15
 
-struct viotapelpevent {
-	struct HvLpEvent event;
-	u32 reserved;
-	u16 version;
-	u16 sub_type_result;
-	u16 tape;
-	u16 flags;
-	u32 token;
-	u64 len;
-	union {
-		struct {
-			u32 tape_op;
-			u32 count;
-		} op;
-		struct {
-			u32 type;
-			u32 resid;
-			u32 dsreg;
-			u32 gstat;
-			u32 erreg;
-			u32 file_no;
-			u32 block_no;
-		} get_status;
-		struct {
-			u32 block_no;
-		} get_pos;
-	} u;
-};
-
-enum viotapesubtype {
-	viotapeopen = 0x0001,
-	viotapeclose = 0x0002,
-	viotaperead = 0x0003,
-	viotapewrite = 0x0004,
-	viotapegetinfo = 0x0005,
-	viotapeop = 0x0006,
-	viotapegetpos = 0x0007,
-	viotapesetpos = 0x0008,
-	viotapegetstatus = 0x0009
-};
-
 enum viotaperc {
 	viotape_InvalidRange = 0x0601,
 	viotape_InvalidToken = 0x0602,
@@ -223,14 +182,11 @@ static const struct vio_error_entry viotape_err_table[] = {
 #define VIOT_WRITING		2
 
 /* Our info on the tapes */
-struct tape_descr {
-	char rsrcname[10];
-	char type[4];
-	char model[3];
-};
-
-static struct tape_descr *viotape_unitinfo;
-static dma_addr_t viotape_unitinfo_token;
+static struct {
+	const char *rsrcname;
+	const char *type;
+	const char *model;
+} viotape_unitinfo[VIOTAPE_MAX_TAPE];
 
 static struct mtget viomtget[VIOTAPE_MAX_TAPE];
 
@@ -381,53 +337,6 @@ int tape_rc_to_errno(int tape_rc, char *operation, int tapeno)
 	return -err->errno;
 }
 
-/* Get info on all tapes from OS/400 */
-static int get_viotape_info(void)
-{
-	HvLpEvent_Rc hvrc;
-	int i;
-	size_t len = sizeof(*viotape_unitinfo) * VIOTAPE_MAX_TAPE;
-	struct op_struct *op = get_op_struct();
-
-	if (op == NULL)
-		return -ENOMEM;
-
-	viotape_unitinfo = iseries_hv_alloc(len, &viotape_unitinfo_token,
-		GFP_ATOMIC);
-	if (viotape_unitinfo == NULL) {
-		free_op_struct(op);
-		return -ENOMEM;
-	}
-
-	memset(viotape_unitinfo, 0, len);
-
-	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
-			HvLpEvent_Type_VirtualIo,
-			viomajorsubtype_tape | viotapegetinfo,
-			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
-			viopath_sourceinst(viopath_hostLp),
-			viopath_targetinst(viopath_hostLp),
-			(u64) (unsigned long) op, VIOVERSION << 16,
-			viotape_unitinfo_token, len, 0, 0);
-	if (hvrc != HvLpEvent_Rc_Good) {
-		printk(VIOTAPE_KERN_WARN "hv error on op %d\n",
-				(int)hvrc);
-		free_op_struct(op);
-		return -EIO;
-	}
-
-	wait_for_completion(&op->com);
-
-	free_op_struct(op);
-
-	for (i = 0;
-	     ((i < VIOTAPE_MAX_TAPE) && (viotape_unitinfo[i].rsrcname[0]));
-	     i++)
-		viotape_numdev++;
-	return 0;
-}
-
-
 /* Write */
 static ssize_t viotap_write(struct file *file, const char *buf,
 		size_t count, loff_t * ppos)
@@ -899,7 +808,6 @@ static void vioHandleTapeEvent(struct HvLpEvent *event)
 	tapeminor = event->xSubtype & VIOMINOR_SUBTYPE_MASK;
 	op = (struct op_struct *)event->xCorrelationToken;
 	switch (tapeminor) {
-	case viotapegetinfo:
 	case viotapeopen:
 	case viotapeclose:
 		op->rc = tevent->sub_type_result;
@@ -942,11 +850,23 @@ static int viotape_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 {
 	int i = vdev->unit_address;
 	int j;
+	struct device_node *node = vdev->dev.archdata.of_node;
 
-	if (i >= viotape_numdev)
+	if (i > VIOTAPE_MAX_TAPE)
+		return -ENODEV;
+	if (!node)
 		return -ENODEV;
 
+	if (i >= viotape_numdev)
+		viotape_numdev = i + 1;
+
 	tape_device[i] = &vdev->dev;
+	viotape_unitinfo[i].rsrcname = of_get_property(node,
+					"linux,vio_rsrcname", NULL);
+	viotape_unitinfo[i].type = of_get_property(node, "linux,vio_type",
+					NULL);
+	viotape_unitinfo[i].model = of_get_property(node, "linux,vio_model",
+					NULL);
 
 	state[i].cur_part = 0;
 	for (j = 0; j < MAX_PARTITIONS; ++j)
@@ -1044,11 +964,6 @@ int __init viotap_init(void)
 		goto unreg_chrdev;
 	}
 
-	if ((ret = get_viotape_info()) < 0) {
-		printk(VIOTAPE_KERN_WARN "Unable to obtain virtual device information");
-		goto unreg_class;
-	}
-
 	ret = vio_register_driver(&viotape_driver);
 	if (ret)
 		goto unreg_class;
@@ -1102,9 +1017,6 @@ static void __exit viotap_exit(void)
 	vio_unregister_driver(&viotape_driver);
 	class_destroy(tape_class);
 	unregister_chrdev(VIOTAPE_MAJOR, "viotape");
-	if (viotape_unitinfo)
-		iseries_hv_free(sizeof(viotape_unitinfo[0]) * VIOTAPE_MAX_TAPE,
-				viotape_unitinfo, viotape_unitinfo_token);
 	viopath_close(viopath_hostLp, viomajorsubtype_tape, VIOTAPE_MAXREQ + 2);
 	vio_clearHandler(viomajorsubtype_tape);
 	clear_op_struct_pool();
diff --git a/include/asm-powerpc/iseries/vio.h b/include/asm-powerpc/iseries/vio.h
index e5a405b..2555dfd 100644
--- a/include/asm-powerpc/iseries/vio.h
+++ b/include/asm-powerpc/iseries/vio.h
@@ -75,6 +75,47 @@ enum viocdsubtype {
 	viocdcheck = 0x0007
 };
 
+struct viotapelpevent {
+	struct HvLpEvent event;
+	u32 reserved;
+	u16 version;
+	u16 sub_type_result;
+	u16 tape;
+	u16 flags;
+	u32 token;
+	u64 len;
+	union {
+		struct {
+			u32 tape_op;
+			u32 count;
+		} op;
+		struct {
+			u32 type;
+			u32 resid;
+			u32 dsreg;
+			u32 gstat;
+			u32 erreg;
+			u32 file_no;
+			u32 block_no;
+		} get_status;
+		struct {
+			u32 block_no;
+		} get_pos;
+	} u;
+};
+
+enum viotapesubtype {
+	viotapeopen = 0x0001,
+	viotapeclose = 0x0002,
+	viotaperead = 0x0003,
+	viotapewrite = 0x0004,
+	viotapegetinfo = 0x0005,
+	viotapeop = 0x0006,
+	viotapegetpos = 0x0007,
+	viotapesetpos = 0x0008,
+	viotapegetstatus = 0x0009
+};
+
 /*
  * Each subtype can register a handler to process their events.
  * The handler must have this interface.
-- 
1.5.3.2
