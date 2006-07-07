Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 703F467BE5
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:33 +1000 (EST)
Message-Id: <20060707165530.005860000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:10 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/12] aoa: i2sbus: fix for PowerMac7,2 and 7,3
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch cleans up the resource handling in i2sbus and adds
workarounds for the broken device trees on the PowerMac7,2
and 7,3.
Some of this code will later move again when macio_asic is
going to export all the sub-nodes too.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-07 12:15:50.007697157 +0200
+++ linux-2.6-fetch/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-07 12:15:51.277697157 +0200
@@ -7,13 +7,16 @@
  */
 
 #include <linux/module.h>
-#include <asm/macio.h>
-#include <asm/dbdma.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+
 #include <sound/driver.h>
 #include <sound/core.h>
-#include <linux/dma-mapping.h>
+
+#include <asm/macio.h>
+#include <asm/dbdma.h>
+
 #include "../soundbus.h"
 #include "i2sbus.h"
 
@@ -78,12 +81,12 @@ static void i2sbus_release_dev(struct de
  	if (i2sdev->intfregs) iounmap(i2sdev->intfregs);
  	if (i2sdev->out.dbdma) iounmap(i2sdev->out.dbdma);
  	if (i2sdev->in.dbdma) iounmap(i2sdev->in.dbdma);
-	for (i=0;i<3;i++)
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++)
 		if (i2sdev->allocated_resource[i])
 			release_and_free_resource(i2sdev->allocated_resource[i]);
 	free_dbdma_descriptor_ring(i2sdev, &i2sdev->out.dbdma_ring);
 	free_dbdma_descriptor_ring(i2sdev, &i2sdev->in.dbdma_ring);
-	for (i=0;i<3;i++)
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++)
 		free_irq(i2sdev->interrupts[i], i2sdev);
 	i2sbus_control_remove_dev(i2sdev->control, i2sdev);
 	mutex_destroy(&i2sdev->lock);
@@ -106,6 +109,50 @@ static irqreturn_t i2sbus_bus_intr(int i
 	return IRQ_HANDLED;
 }
 
+
+/*
+ * XXX FIXME: We test the layout_id's here to get the proper way of
+ * mapping in various registers, thanks to bugs in Apple device-trees.
+ * We could instead key off the machine model and the name of the i2s
+ * node (i2s-a). This we'll do when we move it all to macio_asic.c
+ * and have that export items for each sub-node too.
+ */
+static int i2sbus_get_and_fixup_rsrc(struct device_node *np, int index,
+				     int layout, struct resource *res)
+{
+	struct device_node *parent;
+	int pindex, rc = -ENXIO;
+	u32 *reg;
+
+	/* Machines with layout 76 and 36 (K2 based) have a weird device
+	 * tree what we need to special case.
+	 * Normal machines just fetch the resource from the i2s-X node.
+	 * Darwin further divides normal machines into old and new layouts
+	 * with a subtely different code path but that doesn't seem necessary
+	 * in practice, they just bloated it. In addition, even on our K2
+	 * case the i2s-modem node, if we ever want to handle it, uses the
+	 * normal layout
+	 */
+	if (layout != 76 && layout != 36)
+		return of_address_to_resource(np, index, res);
+
+	parent = of_get_parent(np);
+	pindex = (index == aoa_resource_i2smmio) ? 0 : 1;
+	rc = of_address_to_resource(parent, pindex, res);
+	if (rc)
+		goto bail;
+	reg = (u32 *)get_property(np, "reg", NULL);
+	if (reg == NULL) {
+		rc = -ENXIO;
+		goto bail;
+	}
+	res->start += reg[index * 2];
+	res->end = res->start + reg[index * 2 + 1] - 1;
+ bail:
+	of_node_put(parent);
+	return rc;
+}
+
 /* FIXME: look at device node refcounting */
 static int i2sbus_add_dev(struct macio_dev *macio,
 			  struct i2sbus_control *control,
@@ -113,7 +160,8 @@ static int i2sbus_add_dev(struct macio_d
 {
 	struct i2sbus_dev *dev;
 	struct device_node *child = NULL, *sound = NULL;
-	int i;
+	struct resource *r;
+	int i, layout = 0, rlen;
 	static const char *rnames[] = { "i2sbus: %s (control)",
 					"i2sbus: %s (tx)",
 					"i2sbus: %s (rx)" };
@@ -144,8 +192,9 @@ static int i2sbus_add_dev(struct macio_d
 		u32 *layout_id;
 		layout_id = (u32*) get_property(sound, "layout-id", NULL);
 		if (layout_id) {
+			layout = *layout_id;
 			snprintf(dev->sound.modalias, 32,
-				 "sound-layout-%d", *layout_id);
+				 "sound-layout-%d", layout);
 			force = 1;
 		}
 	}
@@ -175,23 +224,32 @@ static int i2sbus_add_dev(struct macio_d
 	dev->bus_number = np->name[4] - 'a';
 	INIT_LIST_HEAD(&dev->sound.codec_list);
 
-	for (i=0;i<3;i++) {
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
 		dev->interrupts[i] = -1;
-		snprintf(dev->rnames[i], sizeof(dev->rnames[i]), rnames[i], np->name);
+		snprintf(dev->rnames[i], sizeof(dev->rnames[i]),
+			 rnames[i], np->name);
 	}
-	for (i=0;i<3;i++) {
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
 		int irq = irq_of_parse_and_map(np, i);
 		if (request_irq(irq, ints[i], 0, dev->rnames[i], dev))
 			goto err;
 		dev->interrupts[i] = irq;
 	}
 
-	for (i=0;i<3;i++) {
-		if (of_address_to_resource(np, i, &dev->resources[i]))
+
+	/* Resource handling is problematic as some device-trees contain
+	 * useless crap (ugh ugh ugh). We work around that here by calling
+	 * specific functions for calculating the appropriate resources.
+	 *
+	 * This will all be moved to macio_asic.c at one point
+	 */
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
+		if (i2sbus_get_and_fixup_rsrc(np,i,layout,&dev->resources[i]))
 			goto err;
-		/* if only we could use our resource dev->resources[i]...
+		/* If only we could use our resource dev->resources[i]...
 		 * but request_resource doesn't know about parents and
-		 * contained resources... */
+		 * contained resources...
+		 */
 		dev->allocated_resource[i] = 
 			request_mem_region(dev->resources[i].start,
 					   dev->resources[i].end -
@@ -202,13 +260,25 @@ static int i2sbus_add_dev(struct macio_d
 			goto err;
 		}
 	}
-	/* should do sanity checking here about length of them */
-	dev->intfregs = ioremap(dev->resources[0].start,
-				dev->resources[0].end-dev->resources[0].start+1);
-	dev->out.dbdma = ioremap(dev->resources[1].start,
-			 	 dev->resources[1].end-dev->resources[1].start+1);
-	dev->in.dbdma = ioremap(dev->resources[2].start,
-				dev->resources[2].end-dev->resources[2].start+1);
+
+	r = &dev->resources[aoa_resource_i2smmio];
+	rlen = r->end - r->start + 1;
+	if (rlen < sizeof(struct i2s_interface_regs))
+		goto err;
+	dev->intfregs = ioremap(r->start, rlen);
+
+	r = &dev->resources[aoa_resource_txdbdma];
+	rlen = r->end - r->start + 1;
+	if (rlen < sizeof(struct dbdma_regs))
+		goto err;
+	dev->out.dbdma = ioremap(r->start, rlen);
+
+	r = &dev->resources[aoa_resource_rxdbdma];
+	rlen = r->end - r->start + 1;
+	if (rlen < sizeof(struct dbdma_regs))
+		goto err;
+	dev->in.dbdma = ioremap(r->start, rlen);
+
 	if (!dev->intfregs || !dev->out.dbdma || !dev->in.dbdma)
 		goto err;
 
--- linux-2.6-fetch.orig/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-07-07 12:15:40.337697157 +0200
+++ linux-2.6-fetch/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-07-07 12:15:51.277697157 +0200
@@ -45,6 +45,12 @@ struct pcm_info {
 	volatile struct dbdma_regs __iomem *dbdma;
 };
 
+enum {
+	aoa_resource_i2smmio = 0,
+	aoa_resource_txdbdma,
+	aoa_resource_rxdbdma,
+};
+
 struct i2sbus_dev {
 	struct soundbus_dev sound;
 	struct macio_dev *macio;

--
