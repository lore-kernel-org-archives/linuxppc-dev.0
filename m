Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 63520DDE3F
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 11:37:45 +1000 (EST)
Date: Mon, 24 Sep 2007 02:50:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 08/11] [POWERPC] iSeries: move detection of virtual cdroms
Message-Id: <20070924025030.1e821ad6.sfr@canb.auug.org.au>
In-Reply-To: <20070921143750.4114b0b5.sfr@canb.auug.org.au>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
	<20070921143102.eb30d770.sfr@canb.auug.org.au>
	<20070921143205.64271521.sfr@canb.auug.org.au>
	<20070921143337.0e4a2f0a.sfr@canb.auug.org.au>
	<20070921143446.ad55d494.sfr@canb.auug.org.au>
	<20070921143540.75f3becf.sfr@canb.auug.org.au>
	<20070921143647.7ceebabc.sfr@canb.auug.org.au>
	<20070921143750.4114b0b5.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
devices (including their OS/400 properties).  This way viocd.c gets all
the information about the devices from the device tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vio.c               |    3 -
 arch/powerpc/platforms/iseries/Makefile |    2 +-
 arch/powerpc/platforms/iseries/dt.c     |    4 -
 arch/powerpc/platforms/iseries/vio.c    |  317 +++++++++++++++++++++++++++++++
 drivers/cdrom/viocd.c                   |  116 ++----------
 include/asm-powerpc/iseries/vio.h       |   24 +++
 6 files changed, 361 insertions(+), 105 deletions(-)
 create mode 100644 arch/powerpc/platforms/iseries/vio.c

This version creates the device tree entries unconditionally.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 9e1ff21..aec5fff 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -257,9 +257,6 @@ static int __init vio_bus_init(void)
 	int err;
 	struct device_node *node_vroot;
 
-	if (firmware_has_feature(FW_FEATURE_ISERIES))
-		iommu_vio_init();
-
 	err = bus_register(&vio_bus_type);
 	if (err) {
 		printk(KERN_ERR "failed to register VIO bus\n");
diff --git a/arch/powerpc/platforms/iseries/Makefile b/arch/powerpc/platforms/iseries/Makefile
index 60db509..a65f1b4 100644
--- a/arch/powerpc/platforms/iseries/Makefile
+++ b/arch/powerpc/platforms/iseries/Makefile
@@ -7,7 +7,7 @@ obj-y += hvlog.o hvlpconfig.o lpardata.o setup.o dt_mod.o mf.o lpevents.o \
 	hvcall.o proc.o htab.o iommu.o misc.o irq.o
 obj-$(CONFIG_PCI) += pci.o vpdinfo.o
 obj-$(CONFIG_SMP) += smp.o
-obj-$(CONFIG_VIOPATH) += viopath.o
+obj-$(CONFIG_VIOPATH) += viopath.o vio.o
 obj-$(CONFIG_MODULES) += ksyms.o
 
 quiet_cmd_dt_strings = DT_STR  $@
diff --git a/arch/powerpc/platforms/iseries/dt.c b/arch/powerpc/platforms/iseries/dt.c
index 9e8a334..84fcee1 100644
--- a/arch/powerpc/platforms/iseries/dt.c
+++ b/arch/powerpc/platforms/iseries/dt.c
@@ -381,10 +381,6 @@ static void __init dt_vdevices(struct iseries_flat_dt *dt)
 		dt_do_vdevice(dt, "viodasd", reg, i, device_type_block,
 				"IBM,iSeries-viodasd", 1);
 	reg += HVMAXARCHITECTEDVIRTUALDISKS;
-
-	for (i = 0; i < HVMAXARCHITECTEDVIRTUALCDROMS; i++)
-		dt_do_vdevice(dt, "viocd", reg, i, device_type_block,
-				"IBM,iSeries-viocd", 1);
 	reg += HVMAXARCHITECTEDVIRTUALCDROMS;
 
 	for (i = 0; i < HVMAXARCHITECTEDVIRTUALTAPES; i++)
diff --git a/arch/powerpc/platforms/iseries/vio.c b/arch/powerpc/platforms/iseries/vio.c
new file mode 100644
index 0000000..08f6884
--- /dev/null
+++ b/arch/powerpc/platforms/iseries/vio.c
@@ -0,0 +1,317 @@
+/*
+ * Legacy iSeries specific vio initialisation
+ * that needs to be built in (not a module).
+ *
+ * © Copyright 2007 IBM Corporation
+ *	Author: Stephen Rothwell
+ *	Some parts collected from various other files
+ *
+ * This program is free software;  you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/gfp.h>
+#include <linux/completion.h>
+#include <linux/proc_fs.h>
+
+#include <asm/firmware.h>
+#include <asm/iseries/vio.h>
+#include <asm/iseries/iommu.h>
+#include <asm/iseries/hv_types.h>
+#include <asm/iseries/hv_lp_event.h>
+
+#define FIRST_VTY	0
+#define NUM_VTYS	1
+#define FIRST_VSCSI	(FIRST_VTY + NUM_VTYS)
+#define NUM_VSCSIS	1
+#define FIRST_VLAN	(FIRST_VSCSI + NUM_VSCSIS)
+#define NUM_VLANS	HVMAXARCHITECTEDVIRTUALLANS
+#define FIRST_VIODASD	(FIRST_VLAN + NUM_VLANS)
+#define NUM_VIODASDS	HVMAXARCHITECTEDVIRTUALDISKS
+#define FIRST_VIOCD	(FIRST_VIODASD + NUM_VIODASDS)
+#define NUM_VIOCDS	HVMAXARCHITECTEDVIRTUALCDROMS
+#define FIRST_VIOTAPE	(FIRST_VIOCD + NUM_VIOCDS)
+#define NUM_VIOTAPES	HVMAXARCHITECTEDVIRTUALTAPES
+
+static struct property * __init new_property(const char *name, int length,
+		const void *value)
+{
+	struct property *np = kzalloc(sizeof(*np) + strlen(name) + 1 + length,
+			GFP_KERNEL);
+
+	if (!np)
+		return NULL;
+	np->name = (char *)(np + 1);
+	np->value = np->name + strlen(name) + 1;
+	strcpy(np->name, name);
+	memcpy(np->value, value, length);
+	np->length = length;
+	return np;
+}
+
+static void __init free_property(struct property *np)
+{
+	kfree(np);
+}
+
+static struct device_node * __init new_node(const char *path,
+		struct device_node *parent)
+{
+	struct device_node *np = kzalloc(sizeof(*np), GFP_KERNEL);
+
+	if (!np)
+		return NULL;
+	np->full_name = kmalloc(strlen(path) + 1, GFP_KERNEL);
+	if (!np->full_name) {
+		kfree(np);
+		return NULL;
+	}
+	strcpy(np->full_name, path);
+	of_node_set_flag(np, OF_DYNAMIC);
+	kref_init(&np->kref);
+	np->parent = of_node_get(parent);
+	return np;
+}
+
+static void __init free_node(struct device_node *np)
+{
+	struct property *next;
+	struct property *prop;
+
+	next = np->properties;
+	while (next) {
+		prop = next;
+		next = prop->next;
+		free_property(prop);
+	}
+	of_node_put(np->parent);
+	kfree(np->full_name);
+	kfree(np);
+}
+
+static int __init add_string_property(struct device_node *np, const char *name,
+		const char *value)
+{
+	struct property *nprop = new_property(name, strlen(value) + 1, value);
+
+	if (!nprop)
+		return 0;
+	prom_add_property(np, nprop);
+	return 1;
+}
+
+static int __init add_raw_property(struct device_node *np, const char *name,
+		int length, const void *value)
+{
+	struct property *nprop = new_property(name, length, value);
+
+	if (!nprop)
+		return 0;
+	prom_add_property(np, nprop);
+	return 1;
+}
+
+struct viocd_waitevent {
+	struct completion	com;
+	int			rc;
+	u16			sub_result;
+};
+
+struct cdrom_info {
+	char	rsrcname[10];
+	char	type[4];
+	char	model[3];
+};
+
+static void __init handle_cd_event(struct HvLpEvent *event)
+{
+	struct viocdlpevent *bevent;
+	struct viocd_waitevent *pwe;
+
+	if (!event)
+		/* Notification that a partition went away! */
+		return;
+
+	/* First, we should NEVER get an int here...only acks */
+	if (hvlpevent_is_int(event)) {
+		printk(KERN_WARNING "handle_cd_event: got an unexpected int\n");
+		if (hvlpevent_need_ack(event)) {
+			event->xRc = HvLpEvent_Rc_InvalidSubtype;
+			HvCallEvent_ackLpEvent(event);
+		}
+		return;
+	}
+
+	bevent = (struct viocdlpevent *)event;
+
+	switch (event->xSubtype & VIOMINOR_SUBTYPE_MASK) {
+	case viocdgetinfo:
+		pwe = (struct viocd_waitevent *)event->xCorrelationToken;
+		pwe->rc = event->xRc;
+		pwe->sub_result = bevent->sub_result;
+		complete(&pwe->com);
+		break;
+
+	default:
+		printk(KERN_WARNING "handle_cd_event: "
+			"message with unexpected subtype %0x04X!\n",
+			event->xSubtype & VIOMINOR_SUBTYPE_MASK);
+		if (hvlpevent_need_ack(event)) {
+			event->xRc = HvLpEvent_Rc_InvalidSubtype;
+			HvCallEvent_ackLpEvent(event);
+		}
+	}
+}
+
+static void __init get_viocd_info(struct device_node *vio_root)
+{
+	HvLpEvent_Rc hvrc;
+	u32 unit;
+	struct viocd_waitevent we;
+	struct cdrom_info *unitinfo;
+	dma_addr_t unitinfo_dmaaddr;
+	int ret;
+
+	ret = viopath_open(viopath_hostLp, viomajorsubtype_cdio, 2);
+	if (ret) {
+		printk(KERN_WARNING
+			"get_viocd_info: error opening path to host partition %d\n",
+			viopath_hostLp);
+		return;
+	}
+
+	/* Initialize our request handler */
+	vio_setHandler(viomajorsubtype_cdio, handle_cd_event);
+
+	unitinfo = iseries_hv_alloc(
+			sizeof(*unitinfo) * HVMAXARCHITECTEDVIRTUALCDROMS,
+			&unitinfo_dmaaddr, GFP_ATOMIC);
+	if (!unitinfo) {
+		printk(KERN_WARNING
+			"get_viocd_info: error allocating unitinfo\n");
+		goto clear_handler;
+	}
+
+	memset(unitinfo, 0, sizeof(*unitinfo) * HVMAXARCHITECTEDVIRTUALCDROMS);
+
+	init_completion(&we.com);
+
+	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
+			HvLpEvent_Type_VirtualIo,
+			viomajorsubtype_cdio | viocdgetinfo,
+			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
+			viopath_sourceinst(viopath_hostLp),
+			viopath_targetinst(viopath_hostLp),
+			(u64)&we, VIOVERSION << 16, unitinfo_dmaaddr, 0,
+			sizeof(*unitinfo) * HVMAXARCHITECTEDVIRTUALCDROMS, 0);
+	if (hvrc != HvLpEvent_Rc_Good) {
+		printk(KERN_WARNING
+			"get_viocd_info: cdrom error sending event. rc %d\n",
+			(int)hvrc);
+		goto hv_free;
+	}
+
+	wait_for_completion(&we.com);
+
+	if (we.rc) {
+		printk(KERN_WARNING "get_viocd_info: bad rc %d:0x%04X\n",
+			we.rc, we.sub_result);
+		goto hv_free;
+	}
+
+	for (unit = 0; (unit < HVMAXARCHITECTEDVIRTUALCDROMS) &&
+			unitinfo[unit].rsrcname[0]; unit++) {
+		struct device_node *np;
+		char name[64];
+		u32 reg = FIRST_VIOCD + unit;
+
+		snprintf(name, sizeof(name), "/vdevice/viocd@%08x", reg);
+		np = new_node(name, vio_root);
+		if (!np)
+			goto hv_free;
+		if (!add_string_property(np, "name", "viocd") ||
+			!add_string_property(np, "device_type", "block") ||
+			!add_string_property(np, "compatible",
+				"IBM,iSeries-viocd") ||
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
+	iseries_hv_free(sizeof(*unitinfo) * HVMAXARCHITECTEDVIRTUALCDROMS,
+			unitinfo, unitinfo_dmaaddr);
+ clear_handler:
+	vio_clearHandler(viomajorsubtype_cdio);
+	viopath_close(viopath_hostLp, viomajorsubtype_cdio, 2);
+}
+
+static int __init iseries_vio_init(void)
+{
+	struct device_node *vio_root;
+
+	if (!firmware_has_feature(FW_FEATURE_ISERIES))
+		return -ENODEV;
+
+	iommu_vio_init();
+
+	vio_root = of_find_node_by_path("/vdevice");
+	if (!vio_root)
+		return -ENODEV;
+
+	if (viopath_hostLp == HvLpIndexInvalid) {
+		vio_set_hostlp();
+		/* If we don't have a host, bail out */
+		if (viopath_hostLp == HvLpIndexInvalid)
+			goto put_node;
+	}
+
+	get_viocd_info(vio_root);
+
+	return 0;
+
+ put_node:
+	of_node_put(vio_root);
+	return -ENODEV;
+}
+arch_initcall(iseries_vio_init);
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
index c081e54..880b5dc 100644
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -56,30 +56,6 @@
 #define VIOCD_KERN_WARNING		KERN_WARNING "viocd: "
 #define VIOCD_KERN_INFO			KERN_INFO "viocd: "
 
-struct viocdlpevent {
-	struct HvLpEvent	event;
-	u32			reserved;
-	u16			version;
-	u16			sub_result;
-	u16			disk;
-	u16			flags;
-	u32			token;
-	u64			offset;		/* On open, max number of disks */
-	u64			len;		/* On open, size of the disk */
-	u32			block_size;	/* Only set on open */
-	u32			media_size;	/* Only set on open */
-};
-
-enum viocdsubtype {
-	viocdopen = 0x0001,
-	viocdclose = 0x0002,
-	viocdread = 0x0003,
-	viocdwrite = 0x0004,
-	viocdlockdoor = 0x0005,
-	viocdgetinfo = 0x0006,
-	viocdcheck = 0x0007
-};
-
 /*
  * Should probably make this a module parameter....sigh
  */
@@ -131,17 +107,13 @@ static struct capability_entry capability_table[] __initdata = {
 /* These are our internal structures for keeping track of devices */
 static int viocd_numdev;
 
-struct cdrom_info {
-	char	rsrcname[10];
-	char	type[4];
-	char	model[3];
-};
-
 struct disk_info {
 	struct gendisk			*viocd_disk;
 	struct cdrom_device_info	viocd_info;
 	struct device			*dev;
-	struct cdrom_info		unitinfo;
+	const char			*rsrcname;
+	const char			*type;
+	const char			*model;
 };
 static struct disk_info viocd_diskinfo[VIOCD_MAX_CD];
 
@@ -159,9 +131,9 @@ static int proc_viocd_show(struct seq_file *m, void *v)
 	for (i = 0; i < viocd_numdev; i++) {
 		seq_printf(m, "viocd device %d is iSeries resource %10.10s"
 				"type %4.4s, model %3.3s\n",
-				i, viocd_diskinfo[i].unitinfo.rsrcname,
-				viocd_diskinfo[i].unitinfo.type,
-				viocd_diskinfo[i].unitinfo.model);
+				i, viocd_diskinfo[i].rsrcname,
+				viocd_diskinfo[i].type,
+				viocd_diskinfo[i].model);
 	}
 	return 0;
 }
@@ -211,61 +183,6 @@ struct block_device_operations viocd_fops = {
 	.media_changed =	viocd_blk_media_changed,
 };
 
-/* Get info on CD devices from OS/400 */
-static void __init get_viocd_info(void)
-{
-	HvLpEvent_Rc hvrc;
-	int i;
-	struct viocd_waitevent we;
-	struct cdrom_info *viocd_unitinfo;
-	dma_addr_t unitinfo_dmaaddr;
-
-	viocd_unitinfo = iseries_hv_alloc(
-			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
-			&unitinfo_dmaaddr, GFP_ATOMIC);
-	if (viocd_unitinfo == NULL) {
-		printk(VIOCD_KERN_WARNING "error allocating unitinfo\n");
-		return;
-	}
-
-	memset(viocd_unitinfo, 0, sizeof(*viocd_unitinfo) * VIOCD_MAX_CD);
-
-	init_completion(&we.com);
-
-	hvrc = HvCallEvent_signalLpEventFast(viopath_hostLp,
-			HvLpEvent_Type_VirtualIo,
-			viomajorsubtype_cdio | viocdgetinfo,
-			HvLpEvent_AckInd_DoAck, HvLpEvent_AckType_ImmediateAck,
-			viopath_sourceinst(viopath_hostLp),
-			viopath_targetinst(viopath_hostLp),
-			(u64)&we, VIOVERSION << 16, unitinfo_dmaaddr, 0,
-			sizeof(*viocd_unitinfo) * VIOCD_MAX_CD, 0);
-	if (hvrc != HvLpEvent_Rc_Good) {
-		printk(VIOCD_KERN_WARNING "cdrom error sending event. rc %d\n",
-				(int)hvrc);
-		goto error_ret;
-	}
-
-	wait_for_completion(&we.com);
-
-	if (we.rc) {
-		const struct vio_error_entry *err =
-			vio_lookup_rc(viocd_err_table, we.sub_result);
-		printk(VIOCD_KERN_WARNING "bad rc %d:0x%04X on getinfo: %s\n",
-				we.rc, we.sub_result, err->msg);
-		goto error_ret;
-	}
-
-	for (i = 0; (i < VIOCD_MAX_CD) && viocd_unitinfo[i].rsrcname[0]; i++) {
-		viocd_diskinfo[viocd_numdev].unitinfo = viocd_unitinfo[i];
-		viocd_numdev++;
-	}
-
-error_ret:
-	iseries_hv_free(sizeof(*viocd_unitinfo) * VIOCD_MAX_CD,
-			viocd_unitinfo, unitinfo_dmaaddr);
-}
-
 static int viocd_open(struct cdrom_device_info *cdi, int purpose)
 {
         struct disk_info *diskinfo = cdi->handle;
@@ -576,7 +493,6 @@ static void vio_handle_cd_event(struct HvLpEvent *event)
 					bevent->block_size / 512);
 		}
 		/* FALLTHROUGH !! */
-	case viocdgetinfo:
 	case viocdlockdoor:
 		pwe = (struct viocd_waitevent *)event->xCorrelationToken;
 return_complete:
@@ -660,22 +576,30 @@ static int viocd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	int deviceno;
 	struct disk_info *d;
 	struct cdrom_device_info *c;
-	struct cdrom_info *ci;
 	struct request_queue *q;
+	struct device_node *node = vdev->dev.archdata.of_node;
 
 	deviceno = vdev->unit_address;
-	if (deviceno >= viocd_numdev)
+	if (deviceno > VIOCD_MAX_CD)
 		return -ENODEV;
+	if (!node)
+		return -ENODEV;
+
+	if (deviceno >= viocd_numdev)
+		viocd_numdev = deviceno + 1;
 
 	d = &viocd_diskinfo[deviceno];
+	d->rsrcname = of_get_property(node, "linux,vio_rsrcname", NULL);
+	d->type = of_get_property(node, "linux,vio_type", NULL);
+	d->model = of_get_property(node, "linux,vio_model", NULL);
+
 	c = &d->viocd_info;
-	ci = &d->unitinfo;
 
 	c->ops = &viocd_dops;
 	c->speed = 4;
 	c->capacity = 1;
 	c->handle = d;
-	c->mask = ~find_capability(ci->type);
+	c->mask = ~find_capability(d->type);
 	sprintf(c->name, VIOCD_DEVICE "%c", 'a' + deviceno);
 
 	if (register_cdrom(c) != 0) {
@@ -685,7 +609,7 @@ static int viocd_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	}
 	printk(VIOCD_KERN_INFO "cd %s is iSeries resource %10.10s "
 			"type %4.4s, model %3.3s\n",
-			c->name, ci->rsrcname, ci->type, ci->model);
+			c->name, d->rsrcname, d->type, d->model);
 	q = blk_init_queue(do_viocd_request, &viocd_reqlock);
 	if (q == NULL) {
 		printk(VIOCD_KERN_WARNING "Cannot allocate queue for %s!\n",
@@ -794,8 +718,6 @@ static int __init viocd_init(void)
 	/* Initialize our request handler */
 	vio_setHandler(viomajorsubtype_cdio, vio_handle_cd_event);
 
-	get_viocd_info();
-
 	spin_lock_init(&viocd_reqlock);
 
 	ret = vio_register_driver(&viocd_driver);
diff --git a/include/asm-powerpc/iseries/vio.h b/include/asm-powerpc/iseries/vio.h
index 5a5cd0f..e5a405b 100644
--- a/include/asm-powerpc/iseries/vio.h
+++ b/include/asm-powerpc/iseries/vio.h
@@ -51,6 +51,30 @@
  */
 #define VIO_MAX_SUBTYPES 8
 
+struct viocdlpevent {
+	struct HvLpEvent	event;
+	u32			reserved;
+	u16			version;
+	u16			sub_result;
+	u16			disk;
+	u16			flags;
+	u32			token;
+	u64			offset;		/* On open, max number of disks */
+	u64			len;		/* On open, size of the disk */
+	u32			block_size;	/* Only set on open */
+	u32			media_size;	/* Only set on open */
+};
+
+enum viocdsubtype {
+	viocdopen = 0x0001,
+	viocdclose = 0x0002,
+	viocdread = 0x0003,
+	viocdwrite = 0x0004,
+	viocdlockdoor = 0x0005,
+	viocdgetinfo = 0x0006,
+	viocdcheck = 0x0007
+};
+
 /*
  * Each subtype can register a handler to process their events.
  * The handler must have this interface.
-- 
1.5.3.2
