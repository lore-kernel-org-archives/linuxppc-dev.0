Return-Path: <roel.kluin@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 50B4CDDDF6
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 05:54:53 +1000 (EST)
Received: by ey-out-2122.google.com with SMTP id 9so750096eyd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 12:54:51 -0700 (PDT)
Message-ID: <4A08828B.7090106@gmail.com>
Date: Mon, 11 May 2009 21:54:51 +0200
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: johannes@sipsolutions.net
Subject: [PATCH] aoa: remove driver_data direct access of struct device
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To avoid direct access to the driver_data pointer in struct device, the
functions dev_get_drvdata() and dev_set_drvdata() should be used.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index fbf5c93..586965f 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1037,7 +1037,7 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 	}
 	ldev->selfptr_headphone.ptr = ldev;
 	ldev->selfptr_lineout.ptr = ldev;
-	sdev->ofdev.dev.driver_data = ldev;
+	dev_set_drvdata(&sdev->ofdev.dev, ldev);
 	list_add(&ldev->list, &layouts_list);
 	layouts_list_items++;
 
@@ -1081,7 +1081,7 @@ static int aoa_fabric_layout_probe(struct soundbus_dev *sdev)
 
 static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
 {
-	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
 	int i;
 
 	for (i=0; i<MAX_CODECS_PER_BUS; i++) {
@@ -1114,7 +1114,7 @@ static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
 #ifdef CONFIG_PM
 static int aoa_fabric_layout_suspend(struct soundbus_dev *sdev, pm_message_t state)
 {
-	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
 
 	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
 		ldev->gpio.methods->all_amps_off(&ldev->gpio);
@@ -1124,7 +1124,7 @@ static int aoa_fabric_layout_suspend(struct soundbus_dev *sdev, pm_message_t sta
 
 static int aoa_fabric_layout_resume(struct soundbus_dev *sdev)
 {
-	struct layout_dev *ldev = sdev->ofdev.dev.driver_data;
+	struct layout_dev *ldev = dev_get_drvdata(&sdev->ofdev.dev);
 
 	if (ldev->gpio.methods && ldev->gpio.methods->all_amps_off)
 		ldev->gpio.methods->all_amps_restore(&ldev->gpio);
diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 418c84c..4e3b819 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -358,14 +358,14 @@ static int i2sbus_probe(struct macio_dev* dev, const struct of_device_id *match)
 		return -ENODEV;
 	}
 
-	dev->ofdev.dev.driver_data = control;
+	dev_set_drvdata(&dev->ofdev.dev, control);
 
 	return 0;
 }
 
 static int i2sbus_remove(struct macio_dev* dev)
 {
-	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct i2sbus_control *control = dev_get_drvdata(&dev->ofdev.dev);
 	struct i2sbus_dev *i2sdev, *tmp;
 
 	list_for_each_entry_safe(i2sdev, tmp, &control->list, item)
@@ -377,7 +377,7 @@ static int i2sbus_remove(struct macio_dev* dev)
 #ifdef CONFIG_PM
 static int i2sbus_suspend(struct macio_dev* dev, pm_message_t state)
 {
-	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct i2sbus_control *control = dev_get_drvdata(&dev->ofdev.dev);
 	struct codec_info_item *cii;
 	struct i2sbus_dev* i2sdev;
 	int err, ret = 0;
@@ -407,7 +407,7 @@ static int i2sbus_suspend(struct macio_dev* dev, pm_message_t state)
 
 static int i2sbus_resume(struct macio_dev* dev)
 {
-	struct i2sbus_control *control = dev->ofdev.dev.driver_data;
+	struct i2sbus_control *control = dev_get_drvdata(&dev->ofdev.dev);
 	struct codec_info_item *cii;
 	struct i2sbus_dev* i2sdev;
 	int err, ret = 0;
