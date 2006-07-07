Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2217667B6A
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:37 +1000 (EST)
Message-Id: <20060707165530.805500000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:12 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/12] aoa: i2sbus: revamp control layer
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch revamps the i2sbus control layer by using the macio/keylargo
functions instead of directly mapping.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-07-07 12:15:51.277697157 +0200
+++ linux-2.6-fetch/sound/aoa/soundbus/i2sbus/i2sbus.h	2006-07-07 12:15:53.277697157 +0200
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
--- linux-2.6-fetch.orig/sound/aoa/soundbus/i2sbus/i2sbus-control.c	2006-07-07 12:15:39.837697157 +0200
+++ linux-2.6-fetch/sound/aoa/soundbus/i2sbus/i2sbus-control.c	2006-07-07 12:15:53.277697157 +0200
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
 
@@ -93,19 +83,22 @@ int i2sbus_control_enable(struct i2sbus_
 			  struct i2sbus_dev *i2sdev)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	if (i2sdev->enable)
 		return pmf_call_one(i2sdev->enable, &args);
 
+	if (macio == NULL || macio->base == NULL)
+		return -ENODEV;
+
 	switch (i2sdev->bus_number) {
 	case 0:
-		cc = in_le32(&c->controlregs->cell_control);
-		out_le32(&c->controlregs->cell_control, cc | CTRL_CLOCK_INTF_0_ENABLE);
+		/* these need to be locked or done through
+		 * newly created feature calls! */
+		MACIO_BIS(KEYLARGO_FCR1, KL1_I2S0_ENABLE);
 		break;
 	case 1:
-		cc = in_le32(&c->controlregs->cell_control);
-		out_le32(&c->controlregs->cell_control, cc | CTRL_CLOCK_INTF_1_ENABLE);
+		MACIO_BIS(KEYLARGO_FCR1, KL1_I2S1_ENABLE);
 		break;
 	default:
 		return -ENODEV;
@@ -118,7 +111,7 @@ int i2sbus_control_cell(struct i2sbus_co
 			int enable)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	switch (enable) {
 	case 0:
@@ -133,18 +126,22 @@ int i2sbus_control_cell(struct i2sbus_co
 		printk(KERN_ERR "i2sbus: INVALID CELL ENABLE VALUE\n");
 		return -ENODEV;
 	}
+
+	if (macio == NULL || macio->base == NULL)
+		return -ENODEV;
+
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
@@ -157,7 +154,7 @@ int i2sbus_control_clock(struct i2sbus_c
 			 int enable)
 {
 	struct pmf_args args = { .count = 0 };
-	int cc;
+	struct macio_chip *macio = c->macio;
 
 	switch (enable) {
 	case 0:
@@ -172,18 +169,22 @@ int i2sbus_control_clock(struct i2sbus_c
 		printk(KERN_ERR "i2sbus: INVALID CLOCK ENABLE VALUE\n");
 		return -ENODEV;
 	}
+
+	if (macio == NULL || macio->base == NULL)
+		return -ENODEV;
+
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
--- linux-2.6-fetch.orig/sound/aoa/soundbus/i2sbus/i2sbus-control.h	2006-07-07 12:15:39.887697157 +0200
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

--
