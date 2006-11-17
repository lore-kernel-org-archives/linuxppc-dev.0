Return-Path: <dtor@insightbb.com>
Received: from asav14.insightbb.com (gateway.insightbb.com [74.128.0.19])
	by ozlabs.org (Postfix) with ESMTP id 3D50A67BDF
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 17:41:48 +1100 (EST)
From: Dmitry Torokhov <dtor@insightbb.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFT] drivers/macintosh: handle errors from input_register_device()
Date: Fri, 17 Nov 2006 01:31:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200611170131.38486.dtor@insightbb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Could anyone with a box that has ADB give this patch a quick spin to
make sure I did not break anything?

Thanks!

-- 
Dmitry

Input: handle errors from input_register_device in drivers/macintosh

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/macintosh/adbhid.c  |   10 +++++++---
 drivers/macintosh/mac_hid.c |    8 ++++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

Index: work/drivers/macintosh/adbhid.c
===================================================================
--- work.orig/drivers/macintosh/adbhid.c
+++ work/drivers/macintosh/adbhid.c
@@ -689,7 +689,6 @@ adbhid_input_register(int id, int defaul
 	if (!hid || !input_dev) {
 		err = -ENOMEM;
 		goto fail;
-
 	}
 
 	sprintf(hid->phys, "adb%d:%d.%02x/input", id, default_id, original_handler_id);
@@ -807,7 +806,9 @@ adbhid_input_register(int id, int defaul
 
 	input_dev->keycode = hid->keycode;
 
-	input_register_device(input_dev);
+	err = input_register_device(input_dev);
+	if (err)
+		goto fail;
 
 	if (default_id == ADB_KEYBOARD) {
 		/* HACK WARNING!! This should go away as soon there is an utility
@@ -820,7 +821,10 @@ adbhid_input_register(int id, int defaul
 	return 0;
 
  fail:	input_free_device(input_dev);
-	kfree(hid);
+	if (hid) {
+		kfree(hid->keycode);
+		kfree(hid);
+	}
 	adbhid[id] = NULL;
 	return err;
 }
Index: work/drivers/macintosh/mac_hid.c
===================================================================
--- work.orig/drivers/macintosh/mac_hid.c
+++ work/drivers/macintosh/mac_hid.c
@@ -106,6 +106,8 @@ EXPORT_SYMBOL(mac_hid_mouse_emulate_butt
 
 static int emumousebtn_input_register(void)
 {
+	int ret;
+
 	emumousebtn = input_allocate_device();
 	if (!emumousebtn)
 		return -ENOMEM;
@@ -120,9 +122,11 @@ static int emumousebtn_input_register(vo
 	emumousebtn->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT) | BIT(BTN_MIDDLE) | BIT(BTN_RIGHT);
 	emumousebtn->relbit[0] = BIT(REL_X) | BIT(REL_Y);
 
-	input_register_device(emumousebtn);
+	ret = input_register_device(emumousebtn);
+	if (ret)
+		input_free_device(emumousebtn);
 
-	return 0;
+	return ret;
 }
 
 int __init mac_hid_init(void)
