Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 168BD67A3E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 17:50:18 +1000 (EST)
Subject: Re: snd-aoa: g5 tas codec problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1152258426.9862.44.camel@localhost.localdomain>
References: <1152258426.9862.44.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 17:50:00 +1000
Message-Id: <1152258601.9862.47.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-07-07 at 17:47 +1000, Benjamin Herrenschmidt wrote:

> Note that the patch applies on top of Andreas latest one fixing the irq
> on latest git.

Actually, it applies on top of Andres patch, plus my patch fixing the
resources on g5, updated to apply on top of latest git:

I'll do a combo patch later (or you can do one if you want)

Ben.

Index: linux-irq-work/sound/aoa/soundbus/i2sbus/i2sbus-core.c
===================================================================
--- linux-irq-work.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-07 15:40:53.000000000 +1000
+++ linux-irq-work/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-07 15:45:06.000000000 +1000
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
 
@@ -24,6 +27,12 @@
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
@@ -73,7 +82,7 @@
  	if (i2sdev->intfregs) iounmap(i2sdev->intfregs);
  	if (i2sdev->out.dbdma) iounmap(i2sdev->out.dbdma);
  	if (i2sdev->in.dbdma) iounmap(i2sdev->in.dbdma);
-	for (i=0;i<3;i++)
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++)
 		if (i2sdev->allocated_resource[i])
 			release_and_free_resource(i2sdev->allocated_resource[i]);
 	free_dbdma_descriptor_ring(i2sdev, &i2sdev->out.dbdma_ring);
@@ -101,10 +110,47 @@
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
+ bail:
+	of_node_put(parent);
+	return rc;
+}
 
 /* FIXME: look at device node refcounting */
 static int i2sbus_add_dev(struct macio_dev *macio,
@@ -113,7 +159,8 @@
 {
 	struct i2sbus_dev *dev;
 	struct device_node *child = NULL, *sound = NULL;
-	int i;
+	struct resource *r;
+	int i, layout = 0;
 	static const char *rnames[] = { "i2sbus: %s (control)",
 					"i2sbus: %s (tx)",
 					"i2sbus: %s (rx)" };
@@ -144,8 +191,9 @@
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
@@ -175,23 +223,32 @@
 	dev->bus_number = np->name[4] - 'a';
 	INIT_LIST_HEAD(&dev->sound.codec_list);
 
-	for (i=0;i<3;i++) {
+	for (i = aoa_resource_i2smmio; i <= aoa_resource_rxdbdma; i++) {
 		dev->interrupts[i] = -1;
-		snprintf(dev->rnames[i], sizeof(dev->rnames[i]), rnames[i], np->name);
+		snprintf(dev->rnames[i], sizeof(dev->rnames[i]), rnames[i],
+			 np->name);
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
+
+		/* If only we could use our resource dev->resources[i]...
 		 * but request_resource doesn't know about parents and
-		 * contained resources... */
+		 * contained resources...
+		 */
 		dev->allocated_resource[i] = 
 			request_mem_region(dev->resources[i].start,
 					   dev->resources[i].end -
@@ -203,12 +260,12 @@
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
 
Index: linux-irq-work/sound/aoa/soundbus/i2sbus/i2sbus.h
===================================================================
--- linux-irq-work.orig/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-06-23 13:22:14.000000000 +1000
+++ linux-irq-work/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-07-07 15:41:40.000000000 +1000
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
@@ -45,6 +47,12 @@
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
Index: linux-irq-work/sound/aoa/soundbus/i2sbus/i2sbus-control.c
===================================================================
--- linux-irq-work.orig/sound/aoa/soundbus/i2sbus/i2sbus-control.c	2006-06-23 13:22:14.000000000 +1000
+++ linux-irq-work/sound/aoa/soundbus/i2sbus/i2sbus-control.c	2006-07-07 15:41:40.000000000 +1000
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
@@ -22,26 +26,12 @@
 
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
 
@@ -93,19 +83,19 @@
 			  struct i2sbus_dev *i2sdev)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	if (i2sdev->enable)
 		return pmf_call_one(i2sdev->enable, &args);
 
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
@@ -118,7 +108,7 @@
 			int enable)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	switch (enable) {
 	case 0:
@@ -133,18 +123,21 @@
 		printk(KERN_ERR "i2sbus: INVALID CELL ENABLE VALUE\n");
 		return -ENODEV;
 	}
+
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
@@ -157,7 +150,7 @@
 			 int enable)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	switch (enable) {
 	case 0:
@@ -172,18 +165,20 @@
 		printk(KERN_ERR "i2sbus: INVALID CLOCK ENABLE VALUE\n");
 		return -ENODEV;
 	}
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
Index: linux-irq-work/sound/aoa/soundbus/i2sbus/i2sbus-control.h
===================================================================
--- linux-irq-work.orig/sound/aoa/soundbus/i2sbus/i2sbus-control.h	2006-06-23 13:22:14.000000000 +1000
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
Index: linux-irq-work/sound/aoa/codecs/snd-aoa-codec-tas.c
===================================================================
--- linux-irq-work.orig/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-06-23 13:22:14.000000000 +1000
+++ linux-irq-work/sound/aoa/codecs/snd-aoa-codec-tas.c	2006-07-07 17:49:19.000000000 +1000
@@ -310,6 +310,7 @@
 }
 
 MIXER_CONTROL(pcm1, "PCM1", 0);
+MIXER_CONTROL(pcm2, "PCM2", 1);
 MIXER_CONTROL(monitor, "Monitor", 2);
 
 static int tas_snd_capture_source_info(struct snd_kcontrol *kcontrol,
@@ -507,6 +508,10 @@
 	if (err)
 		goto error;
 
+	err = aoa_snd_ctl_add(snd_ctl_new1(&pcm2_control, tas));
+	if (err)
+		goto error;
+
 	err = aoa_snd_ctl_add(snd_ctl_new1(&monitor_control, tas));
 	if (err)
 		goto error;
