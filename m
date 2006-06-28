Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 984AF67B18
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 18:01:29 +1000 (EST)
Subject: snd-aoa issues & fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 18:01:17 +1000
Message-Id: <1151481678.4044.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So I've been trying to fix snd-aoa for the G5s and found a few issues...
I think I got most of it right, however I don't have any sound... I hear
"clacs" when I toggle the mutes pretty much as expected and I see
interrupts counting when playing sound but there is no actual sound in
the speaker. I've verified that snd-powermac works on the same machine
(PowerMac7,3 with tas codec). I've been toying with all the controls
available in alsamixer, it didn't help. Sounds to me that there is
nothing going out of the tas... maybe some mixer control that is not
quite right, duno

- Redefinition of various FCR related bits in i2s-control. I've fixed
that in the patch and used existing definitions. However, we still have
a problem that we don't properly lock with pmac_feature for access to
these. We need to either expose new feature calls now that we are
upstream or expose the pmac_feature spinlock

- I noticed you don't call pmac_feature and don't set bits in FCR3
etc... (enabling the 18Mhz clock for example). Is that normal ? You
don't use that clock ? That's the only difference in FCR content that
I've been able to spot between snd-powermac and snd-aoa but hacking it
doesn't seem to make much difference.

- The fabric stuff needs a bit of cleanup... You seem to be fond of
defining lotsa struct's :) Even when they don't contain much :) Triggers
another problem below

- I've had a crash with built-in snd-aoa at boot... The problem is that
when built-in, there is no enforced ordering between module_init() calls
except for link order... What happens here is that soundbus is last in
the Makefile, thus we try to register soundbus devices before we
register the bus type. I fixes that in the patch both by putting
soundbus first in the Make

- If i2sbus is loaded after the codec and fabric, the codec fails to
initialize. I haven't tried to debug that one

- The dmesg output could use some cleanup :)

- The driver is trying to access non existing codecs on the i2c bus,
that's a pretty bad idea.

I think we need to change the codec probe phase dramatically: 

  1 - codec drivers register the i2c thingy as normal
  2 - i2c kicks in, they do the current device-node and/or i2c bus name
check and register
      themselves with the core. They do not try to touch the hardware at
this point
  3 - fabric kicks in (or was already there). It checks the list of
codecs registered when
      loaded and gets notified of new ones added. If codec matches the
layout, then codec
      init is called
  4 - codec init called by fabric. That is where we try to tap the
hardware. Might fail in
      which case the fabric doesn't try to use the codec

(That is, there is a global list of registered codecs at the core, and a
list of "active" codecs in the fabric or bus, whatever...)

Here's my current patch:

Index: linux-snd-aoa/sound/aoa/soundbus/i2sbus/i2sbus-core.c
===================================================================
--- linux-snd-aoa.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-06-26 12:29:38.000000000 +1000
+++ linux-snd-aoa/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-06-28 16:10:27.000000000 +1000
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
 
@@ -24,6 +27,12 @@ MODULE_DESCRIPTION("Apple Soundbus: I2S 
  * string that macio puts into the relevant device */
 MODULE_ALIAS("of:Ni2sTi2sC");
 
+static int force;
+module_param(force, int, 0444);
+MODULE_PARM_DESC(force, "Force loading i2sbus even when"
+		 " no layout-id property is present");
+
+
 static struct of_device_id i2sbus_match[] = {
 	{ .name = "i2s" },
 	{ }
@@ -73,7 +82,7 @@ static void i2sbus_release_dev(struct de
  	if (i2sdev->intfregs) iounmap(i2sdev->intfregs);
  	if (i2sdev->out.dbdma) iounmap(i2sdev->out.dbdma);
  	if (i2sdev->in.dbdma) iounmap(i2sdev->in.dbdma);
-	for (i=0;i<3;i++)
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++)
 		if (i2sdev->allocated_resource[i])
 			release_and_free_resource(i2sdev->allocated_resource[i]);
 	free_dbdma_descriptor_ring(i2sdev, &i2sdev->out.dbdma_ring);
@@ -101,10 +110,49 @@ static irqreturn_t i2sbus_bus_intr(int i
 	return IRQ_HANDLED;
 }
 
-static int force;
-module_param(force, int, 0444);
-MODULE_PARM_DESC(force, "Force loading i2sbus even when"
-			" no layout-id property is present");
+/*
+ * XXX FIXME: We have to test the layout_id's here to get the proper way
+ * of mapping in various registers, thanks to bugs in Apple device-trees.
+ * Ideally, that should be handled by the layout fabric but doing so would
+ * require a little bit of shuffling around
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
+	printk("i2sbus rsrc %d -> %lx..%lx\n", index,
+	       res->start, res->end);
+ bail:
+	of_node_put(parent);
+	return rc;
+}
 
 /* FIXME: look at device node refcounting */
 static int i2sbus_add_dev(struct macio_dev *macio,
@@ -113,7 +161,8 @@ static int i2sbus_add_dev(struct macio_d
 {
 	struct i2sbus_dev *dev;
 	struct device_node *child = NULL, *sound = NULL;
-	int i;
+	struct resource *r;
+	int i, layout = 0;
 	static const char *rnames[] = { "i2sbus: %s (control)",
 					"i2sbus: %s (tx)",
 					"i2sbus: %s (rx)" };
@@ -147,8 +196,9 @@ static int i2sbus_add_dev(struct macio_d
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
@@ -180,20 +230,28 @@ static int i2sbus_add_dev(struct macio_d
 
 	for (i=0;i<3;i++) {
 		dev->interrupts[i] = -1;
-		snprintf(dev->rnames[i], sizeof(dev->rnames[i]), rnames[i], np->name);
+		snprintf(dev->rnames[i], sizeof(dev->rnames[i]), rnames[i],
+			 np->name);
 	}
 	for (i=0;i<3;i++) {
-		if (request_irq(np->intrs[i].line, ints[i], 0, dev->rnames[i], dev))
+		if (request_irq(np->intrs[i].line, ints[i], 0, dev->rnames[i],
+				dev))
 			goto err;
 		dev->interrupts[i] = np->intrs[i].line;
 	}
 
-	for (i=0;i<3;i++) {
-		if (of_address_to_resource(np, i, &dev->resources[i]))
+	/* Resource handling is problematic as some device-trees contain
+	 * useless crap (ugh ugh ugh). We work around that here by calling
+	 * specific functions for calculating the appropriate resources.
+	 */
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
+		if (i2sbus_get_and_fixup_rsrc(np,i,layout,&dev->resources[i]))
 			goto err;
-		/* if only we could use our resource dev->resources[i]...
+
+		/* If only we could use our resource dev->resources[i]...
 		 * but request_resource doesn't know about parents and
-		 * contained resources... */
+		 * contained resources...
+		 */
 		dev->allocated_resource[i] = 
 			request_mem_region(dev->resources[i].start,
 					   dev->resources[i].end -
@@ -205,12 +263,12 @@ static int i2sbus_add_dev(struct macio_d
 		}
 	}
 	/* should do sanity checking here about length of them */
-	dev->intfregs = ioremap(dev->resources[0].start,
-				dev->resources[0].end-dev->resources[0].start+1);
-	dev->out.dbdma = ioremap(dev->resources[1].start,
-			 	 dev->resources[1].end-dev->resources[1].start+1);
-	dev->in.dbdma = ioremap(dev->resources[2].start,
-				dev->resources[2].end-dev->resources[2].start+1);
+	r = &dev->resources[aoa_resource_i2smmio];
+	dev->intfregs = ioremap(r->start, r->end - r->start + 1);
+	r = &dev->resources[aoa_resource_txdbdma];
+	dev->out.dbdma = ioremap(r->start, r->end - r->start + 1);
+	r = &dev->resources[aoa_resource_rxdbdma];
+	dev->in.dbdma = ioremap(r->start, r->end - r->start + 1);
 	if (!dev->intfregs || !dev->out.dbdma || !dev->in.dbdma)
 		goto err;
 
Index: linux-snd-aoa/sound/aoa/soundbus/i2sbus/i2sbus.h
===================================================================
--- linux-snd-aoa.orig/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-06-26 12:29:38.000000000 +1000
+++ linux-snd-aoa/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-06-28 15:16:40.000000000 +1000
@@ -7,20 +7,22 @@
  */
 #ifndef __I2SBUS_H
 #define __I2SBUS_H
-#include <asm/dbdma.h>
 #include <linux/interrupt.h>
-#include <sound/pcm.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+
+#include <sound/pcm.h>
+
 #include <asm/prom.h>
+#include <asm/pmac_feature.h>
+#include <asm/dbdma.h>
+
 #include "i2sbus-interface.h"
-#include "i2sbus-control.h"
 #include "../soundbus.h"
 
 struct i2sbus_control {
-	volatile struct i2s_control_regs __iomem *controlregs;
-	struct resource rsrc;
 	struct list_head list;
+	struct macio_chip *macio;
 };
 
 #define MAX_DBDMA_COMMANDS	32
@@ -45,6 +47,12 @@ struct pcm_info {
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
Index: linux-snd-aoa/sound/aoa/soundbus/i2sbus/i2sbus-control.c
===================================================================
--- linux-snd-aoa.orig/sound/aoa/soundbus/i2sbus/i2sbus-control.c	2006-06-26 12:29:38.000000000 +1000
+++ linux-snd-aoa/sound/aoa/soundbus/i2sbus/i2sbus-control.c	2006-06-28 16:09:44.000000000 +1000
@@ -6,12 +6,16 @@
  * GPL v2, can be found in COPYING.
  */
 
-#include <asm/io.h>
+#include <linux/kernel.h>
 #include <linux/delay.h>
+
+#include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/macio.h>
 #include <asm/pmac_feature.h>
 #include <asm/pmac_pfunc.h>
+#include <asm/keylargo.h>
+
 #include "i2sbus.h"
 
 int i2sbus_control_init(struct macio_dev* dev, struct i2sbus_control **c)
@@ -22,26 +26,12 @@ int i2sbus_control_init(struct macio_dev
 
 	INIT_LIST_HEAD(&(*c)->list);
 
-	if (of_address_to_resource(dev->ofdev.node, 0, &(*c)->rsrc))
-		goto err;
-	/* we really should be using feature calls instead of mapping
-	 * these registers. It's safe for now since no one else is
-	 * touching them... */
-	(*c)->controlregs = ioremap((*c)->rsrc.start,
-				    sizeof(struct i2s_control_regs));
-	if (!(*c)->controlregs)
-		goto err;
-
+	(*c)->macio = dev->bus->chip;
 	return 0;
- err:
-	kfree(*c);
-	*c = NULL;
-	return -ENODEV;
 }
 
 void i2sbus_control_destroy(struct i2sbus_control *c)
 {
-	iounmap(c->controlregs);
 	kfree(c);
 }
 
@@ -93,19 +83,20 @@ int i2sbus_control_enable(struct i2sbus_
 			  struct i2sbus_dev *i2sdev)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	if (i2sdev->enable)
 		return pmf_call_one(i2sdev->enable, &args);
 
+	printk("i2sbus_control_enable fallback\n");
+	if (macio == NULL || macio->base == NULL)
+		return -ENODEV;
 	switch (i2sdev->bus_number) {
 	case 0:
-		cc = in_le32(&c->controlregs->cell_control);
-		out_le32(&c->controlregs->cell_control, cc | CTRL_CLOCK_INTF_0_ENABLE);
+		MACIO_BIS(KEYLARGO_FCR1, KL1_I2S0_ENABLE);
 		break;
 	case 1:
-		cc = in_le32(&c->controlregs->cell_control);
-		out_le32(&c->controlregs->cell_control, cc | CTRL_CLOCK_INTF_1_ENABLE);
+		MACIO_BIS(KEYLARGO_FCR1, KL1_I2S1_ENABLE);
 		break;
 	default:
 		return -ENODEV;
@@ -118,7 +109,7 @@ int i2sbus_control_cell(struct i2sbus_co
 			int enable)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	switch (enable) {
 	case 0:
@@ -133,18 +124,22 @@ int i2sbus_control_cell(struct i2sbus_co
 		printk(KERN_ERR "i2sbus: INVALID CELL ENABLE VALUE\n");
 		return -ENODEV;
 	}
+
+	printk("i2sbus_control_cell fallback\n");
+	if (macio == NULL || macio->base == NULL)
+		return -ENODEV;
 	switch (i2sdev->bus_number) {
 	case 0:
-		cc = in_le32(&c->controlregs->cell_control);
-		cc &= ~CTRL_CLOCK_CELL_0_ENABLE;
-		cc |= enable * CTRL_CLOCK_CELL_0_ENABLE;
-		out_le32(&c->controlregs->cell_control, cc);
+		if (enable)
+			MACIO_BIS(KEYLARGO_FCR1, KL1_I2S0_CELL_ENABLE);
+		else
+			MACIO_BIC(KEYLARGO_FCR1, KL1_I2S0_CELL_ENABLE);
 		break;
 	case 1:
-		cc = in_le32(&c->controlregs->cell_control);
-		cc &= ~CTRL_CLOCK_CELL_1_ENABLE;
-		cc |= enable * CTRL_CLOCK_CELL_1_ENABLE;
-		out_le32(&c->controlregs->cell_control, cc);
+		if (enable)
+			MACIO_BIS(KEYLARGO_FCR1, KL1_I2S1_CELL_ENABLE);
+		else
+			MACIO_BIC(KEYLARGO_FCR1, KL1_I2S1_CELL_ENABLE);
 		break;
 	default:
 		return -ENODEV;
@@ -157,7 +152,7 @@ int i2sbus_control_clock(struct i2sbus_c
 			 int enable)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	switch (enable) {
 	case 0:
@@ -172,18 +167,22 @@ int i2sbus_control_clock(struct i2sbus_c
 		printk(KERN_ERR "i2sbus: INVALID CLOCK ENABLE VALUE\n");
 		return -ENODEV;
 	}
+
+	printk("i2sbus_control_clock fallback\n");
+	if (macio == NULL || macio->base == NULL)
+		return -ENODEV;
 	switch (i2sdev->bus_number) {
 	case 0:
-		cc = in_le32(&c->controlregs->cell_control);
-		cc &= ~CTRL_CLOCK_CLOCK_0_ENABLE;
-		cc |= enable * CTRL_CLOCK_CLOCK_0_ENABLE;
-		out_le32(&c->controlregs->cell_control, cc);
+		if (enable)
+			MACIO_BIS(KEYLARGO_FCR1, KL1_I2S0_CLK_ENABLE_BIT);
+		else
+			MACIO_BIC(KEYLARGO_FCR1, KL1_I2S0_CLK_ENABLE_BIT);
 		break;
 	case 1:
-		cc = in_le32(&c->controlregs->cell_control);
-		cc &= ~CTRL_CLOCK_CLOCK_1_ENABLE;
-		cc |= enable * CTRL_CLOCK_CLOCK_1_ENABLE;
-		out_le32(&c->controlregs->cell_control, cc);
+		if (enable)
+			MACIO_BIS(KEYLARGO_FCR1, KL1_I2S1_CLK_ENABLE_BIT);
+		else
+			MACIO_BIC(KEYLARGO_FCR1, KL1_I2S1_CLK_ENABLE_BIT);
 		break;
 	default:
 		return -ENODEV;
Index: linux-snd-aoa/sound/aoa/soundbus/i2sbus/i2sbus-control.h
===================================================================
--- linux-snd-aoa.orig/sound/aoa/soundbus/i2sbus/i2sbus-control.h	2006-06-26 12:29:38.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,37 +0,0 @@
-/*
- * i2sbus driver -- bus register definitions
- *
- * Copyright 2006 Johannes Berg <johannes@sipsolutions.net>
- *
- * GPL v2, can be found in COPYING.
- */
-#ifndef __I2SBUS_CONTROLREGS_H
-#define __I2SBUS_CONTROLREGS_H
-
-/* i2s control registers, at least what we know about them */
-
-#define __PAD(m,n) u8 __pad##m[n]
-#define _PAD(line, n) __PAD(line, n)
-#define PAD(n) _PAD(__LINE__, (n))
-struct i2s_control_regs {
-	PAD(0x38);
-	__le32 fcr0;		/* 0x38 (unknown) */
-	__le32 cell_control;	/* 0x3c (fcr1) */
-	__le32 fcr2;		/* 0x40 (unknown) */
-	__le32 fcr3;		/* 0x44 (fcr3) */
-	__le32 clock_control;	/* 0x48 (unknown) */
-	PAD(4);
-	/* total size: 0x50 bytes */
-}  __attribute__((__packed__));
-
-#define CTRL_CLOCK_CELL_0_ENABLE	(1<<10)
-#define CTRL_CLOCK_CLOCK_0_ENABLE	(1<<12)
-#define CTRL_CLOCK_SWRESET_0		(1<<11)
-#define CTRL_CLOCK_INTF_0_ENABLE	(1<<13)
-
-#define CTRL_CLOCK_CELL_1_ENABLE	(1<<17)
-#define CTRL_CLOCK_CLOCK_1_ENABLE	(1<<18)
-#define CTRL_CLOCK_SWRESET_1		(1<<19)
-#define CTRL_CLOCK_INTF_1_ENABLE	(1<<20)
-
-#endif /* __I2SBUS_CONTROLREGS_H */
Index: linux-snd-aoa/sound/aoa/Makefile
===================================================================
--- linux-snd-aoa.orig/sound/aoa/Makefile	2006-06-26 12:29:38.000000000 +1000
+++ linux-snd-aoa/sound/aoa/Makefile	2006-06-28 15:51:55.000000000 +1000
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SND_AOA) += core/
+obj-$(CONFIG_SND_AOA_SOUNDBUS) += soundbus/
 obj-$(CONFIG_SND_AOA) += codecs/
 obj-$(CONFIG_SND_AOA) += fabrics/
-obj-$(CONFIG_SND_AOA_SOUNDBUS) += soundbus/
Index: linux-snd-aoa/sound/aoa/codecs/snd-aoa-codec-onyx.c
===================================================================
--- linux-snd-aoa.orig/sound/aoa/codecs/snd-aoa-codec-onyx.c	2006-06-26 12:29:38.000000000 +1000
+++ linux-snd-aoa/sound/aoa/codecs/snd-aoa-codec-onyx.c	2006-06-28 15:37:17.000000000 +1000
@@ -1080,6 +1080,7 @@ static int onyx_i2c_detach(struct i2c_cl
 	struct onyx *onyx = container_of(client, struct onyx, i2c);
 	int err;
 
+	printk("onyx_i2c_detach...\n");
 	if ((err = i2c_detach_client(client)))
 		return err;
 	aoa_codec_unregister(&onyx->codec);
Index: linux-snd-aoa/sound/aoa/soundbus/core.c
===================================================================
--- linux-snd-aoa.orig/sound/aoa/soundbus/core.c	2006-06-26 12:29:38.000000000 +1000
+++ linux-snd-aoa/sound/aoa/soundbus/core.c	2006-06-28 16:00:35.000000000 +1000
@@ -194,16 +194,6 @@ static struct bus_type soundbus_bus_type
 	.dev_attrs	= soundbus_dev_attrs,
 };
 
-static int __init soundbus_init(void)
-{
-	return bus_register(&soundbus_bus_type);
-}
-
-static void __exit soundbus_exit(void)
-{
-	bus_unregister(&soundbus_bus_type);
-}
-
 int soundbus_add_one(struct soundbus_dev *dev)
 {
 	static int devcount;
@@ -246,5 +236,15 @@ void soundbus_unregister_driver(struct s
 }
 EXPORT_SYMBOL_GPL(soundbus_unregister_driver);
 
-module_init(soundbus_init);
+static int __init soundbus_init(void)
+{
+	return bus_register(&soundbus_bus_type);
+}
+
+static void __exit soundbus_exit(void)
+{
+	bus_unregister(&soundbus_bus_type);
+}
+
+subsys_initcall(soundbus_init);
 module_exit(soundbus_exit);
