Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B2A367B8F
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Jul 2006 03:00:29 +1000 (EST)
Message-Id: <20060707165529.605137000@sipsolutions.net>
References: <20060707165207.877010000@sipsolutions.net>
Date: Fri, 07 Jul 2006 18:52:09 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/12] aoa: i2sbus: move module parameter declaration up
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch moves the i2sbus 'force' module parameter declaration
to the top of the file.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-07 12:15:48.607697157 +0200
+++ linux-2.6-fetch/sound/aoa/soundbus/i2sbus/i2sbus-core.c	2006-07-07 12:15:50.007697157 +0200
@@ -24,6 +24,11 @@ MODULE_DESCRIPTION("Apple Soundbus: I2S 
  * string that macio puts into the relevant device */
 MODULE_ALIAS("of:Ni2sTi2sC");
 
+static int force;
+module_param(force, int, 0444);
+MODULE_PARM_DESC(force, "Force loading i2sbus even when"
+			" no layout-id property is present");
+
 static struct of_device_id i2sbus_match[] = {
 	{ .name = "i2s" },
 	{ }
@@ -101,11 +106,6 @@ static irqreturn_t i2sbus_bus_intr(int i
 	return IRQ_HANDLED;
 }
 
-static int force;
-module_param(force, int, 0444);
-MODULE_PARM_DESC(force, "Force loading i2sbus even when"
-			" no layout-id property is present");
-
 /* FIXME: look at device node refcounting */
 static int i2sbus_add_dev(struct macio_dev *macio,
 			  struct i2sbus_control *control,

--
