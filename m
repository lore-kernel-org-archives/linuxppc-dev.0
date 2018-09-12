Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4292Sj4PY2zF37d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 10:18:45 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
 <linux-kernel@vger.kernel.org>, Andreas Schwab <schwab@linux-m68k.org>
Message-Id: <1dd7bad420f01e3dc9d02c6dc493d8005ff2b5a1.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1536709753.git.fthain@telegraphics.com.au>
References: <cover.1536709753.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 2/7] macintosh/adb: Rework printk output again
Date: Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avoid the KERN_CONT problem by avoiding message fragments. The problem
arises during async ADB bus probing, when ADB messages may get mixed up
with other messages. See also, commit 4bcc595ccd80 ("printk: reinstate
KERN_CONT for printing continuation lines").

Remove a number of printk() continuation lines by logging handler
changes in adb_try_handler_change() instead.

This patch addresses the problematic use of "\n" at the beginning of
pr_cont() messages, which got overlooked in commit f2be6295684b
("macintosh/adb: Properly mark continued kernel messages").

That commit also changed printk(KERN_DEBUG ...) to pr_debug(...), which
hinders work on low-level ADB driver bugs. Revert that change.

Cc: Andreas Schwab <schwab@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/adb.c    |  8 ++++---
 drivers/macintosh/adbhid.c | 53 ++++++++++++++++++----------------------------
 2 files changed, 26 insertions(+), 35 deletions(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 76e98f0f7a3e..e49d1f287a17 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -203,15 +203,15 @@ static int adb_scan_bus(void)
 	}
 
 	/* Now fill in the handler_id field of the adb_handler entries. */
-	pr_debug("adb devices:\n");
 	for (i = 1; i < 16; i++) {
 		if (adb_handler[i].original_address == 0)
 			continue;
 		adb_request(&req, NULL, ADBREQ_SYNC | ADBREQ_REPLY, 1,
 			    (i << 4) | 0xf);
 		adb_handler[i].handler_id = req.reply[2];
-		pr_debug(" [%d]: %d %x\n", i, adb_handler[i].original_address,
-			 adb_handler[i].handler_id);
+		printk(KERN_DEBUG "adb device [%d]: %d 0x%X\n", i,
+		       adb_handler[i].original_address,
+		       adb_handler[i].handler_id);
 		devmask |= 1 << i;
 	}
 	return devmask;
@@ -579,6 +579,8 @@ adb_try_handler_change(int address, int new_id)
 	mutex_lock(&adb_handler_mutex);
 	ret = try_handler_change(address, new_id);
 	mutex_unlock(&adb_handler_mutex);
+	if (ret)
+		pr_debug("adb handler change: [%d] 0x%X\n", address, new_id);
 	return ret;
 }
 EXPORT_SYMBOL(adb_try_handler_change);
diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index a261892c03b3..75482eeab2c4 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -757,6 +757,7 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 	struct input_dev *input_dev;
 	int err;
 	int i;
+	char *keyboard_type;
 
 	if (adbhid[id]) {
 		pr_err("Trying to reregister ADB HID on ID %d\n", id);
@@ -798,24 +799,23 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 
 		memcpy(hid->keycode, adb_to_linux_keycodes, sizeof(adb_to_linux_keycodes));
 
-		pr_info("Detected ADB keyboard, type ");
 		switch (original_handler_id) {
 		default:
-			pr_cont("<unknown>.\n");
+			keyboard_type = "<unknown>";
 			input_dev->id.version = ADB_KEYBOARD_UNKNOWN;
 			break;
 
 		case 0x01: case 0x02: case 0x03: case 0x06: case 0x08:
 		case 0x0C: case 0x10: case 0x18: case 0x1B: case 0x1C:
 		case 0xC0: case 0xC3: case 0xC6:
-			pr_cont("ANSI.\n");
+			keyboard_type = "ANSI";
 			input_dev->id.version = ADB_KEYBOARD_ANSI;
 			break;
 
 		case 0x04: case 0x05: case 0x07: case 0x09: case 0x0D:
 		case 0x11: case 0x14: case 0x19: case 0x1D: case 0xC1:
 		case 0xC4: case 0xC7:
-			pr_cont("ISO, swapping keys.\n");
+			keyboard_type = "ISO, swapping keys";
 			input_dev->id.version = ADB_KEYBOARD_ISO;
 			i = hid->keycode[10];
 			hid->keycode[10] = hid->keycode[50];
@@ -824,10 +824,11 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 
 		case 0x12: case 0x15: case 0x16: case 0x17: case 0x1A:
 		case 0x1E: case 0xC2: case 0xC5: case 0xC8: case 0xC9:
-			pr_cont("JIS.\n");
+			keyboard_type = "JIS";
 			input_dev->id.version = ADB_KEYBOARD_JIS;
 			break;
 		}
+		pr_info("Detected ADB keyboard, type %s.\n", keyboard_type);
 
 		for (i = 0; i < 128; i++)
 			if (hid->keycode[i])
@@ -972,16 +973,13 @@ adbhid_probe(void)
 		   ->get it to send separate codes for left and right shift,
 		   control, option keys */
 #if 0		/* handler 5 doesn't send separate codes for R modifiers */
-		if (adb_try_handler_change(id, 5))
-			printk("ADB keyboard at %d, handler set to 5\n", id);
-		else
+		if (!adb_try_handler_change(id, 5))
 #endif
-		if (adb_try_handler_change(id, 3))
-			printk("ADB keyboard at %d, handler set to 3\n", id);
-		else
-			printk("ADB keyboard at %d, handler 1\n", id);
+		adb_try_handler_change(id, 3);
 
 		adb_get_infos(id, &default_id, &cur_handler_id);
+		printk(KERN_DEBUG "ADB keyboard at %d has handler 0x%X\n",
+		       id, cur_handler_id);
 		reg |= adbhid_input_reregister(id, default_id, org_handler_id,
 					       cur_handler_id, 0);
 	}
@@ -999,48 +997,44 @@ adbhid_probe(void)
 	for (i = 0; i < mouse_ids.nids; i++) {
 		int id = mouse_ids.id[i];
 		int mouse_kind;
+		char *desc = "standard";
 
 		adb_get_infos(id, &default_id, &org_handler_id);
 
 		if (adb_try_handler_change(id, 4)) {
-			printk("ADB mouse at %d, handler set to 4", id);
 			mouse_kind = ADBMOUSE_EXTENDED;
 		}
 		else if (adb_try_handler_change(id, 0x2F)) {
-			printk("ADB mouse at %d, handler set to 0x2F", id);
 			mouse_kind = ADBMOUSE_MICROSPEED;
 		}
 		else if (adb_try_handler_change(id, 0x42)) {
-			printk("ADB mouse at %d, handler set to 0x42", id);
 			mouse_kind = ADBMOUSE_TRACKBALLPRO;
 		}
 		else if (adb_try_handler_change(id, 0x66)) {
-			printk("ADB mouse at %d, handler set to 0x66", id);
 			mouse_kind = ADBMOUSE_MICROSPEED;
 		}
 		else if (adb_try_handler_change(id, 0x5F)) {
-			printk("ADB mouse at %d, handler set to 0x5F", id);
 			mouse_kind = ADBMOUSE_MICROSPEED;
 		}
 		else if (adb_try_handler_change(id, 3)) {
-			printk("ADB mouse at %d, handler set to 3", id);
 			mouse_kind = ADBMOUSE_MS_A3;
 		}
 		else if (adb_try_handler_change(id, 2)) {
-			printk("ADB mouse at %d, handler set to 2", id);
 			mouse_kind = ADBMOUSE_STANDARD_200;
 		}
 		else {
-			printk("ADB mouse at %d, handler 1", id);
 			mouse_kind = ADBMOUSE_STANDARD_100;
 		}
 
 		if ((mouse_kind == ADBMOUSE_TRACKBALLPRO)
 		    || (mouse_kind == ADBMOUSE_MICROSPEED)) {
+			desc = "Microspeed/MacPoint or compatible";
 			init_microspeed(id);
 		} else if (mouse_kind == ADBMOUSE_MS_A3) {
+			desc = "Mouse Systems A3 Mouse or compatible";
 			init_ms_a3(id);
 		} else if (mouse_kind ==  ADBMOUSE_EXTENDED) {
+			desc = "extended";
 			/*
 			 * Register 1 is usually used for device
 			 * identification.  Here, we try to identify
@@ -1054,32 +1048,36 @@ adbhid_probe(void)
 			    (req.reply[1] == 0x9a) && ((req.reply[2] == 0x21)
 			    	|| (req.reply[2] == 0x20))) {
 				mouse_kind = ADBMOUSE_TRACKBALL;
+				desc = "trackman/mouseman";
 				init_trackball(id);
 			}
 			else if ((req.reply_len >= 4) &&
 			    (req.reply[1] == 0x74) && (req.reply[2] == 0x70) &&
 			    (req.reply[3] == 0x61) && (req.reply[4] == 0x64)) {
 				mouse_kind = ADBMOUSE_TRACKPAD;
+				desc = "trackpad";
 				init_trackpad(id);
 			}
 			else if ((req.reply_len >= 4) &&
 			    (req.reply[1] == 0x4b) && (req.reply[2] == 0x4d) &&
 			    (req.reply[3] == 0x4c) && (req.reply[4] == 0x31)) {
 				mouse_kind = ADBMOUSE_TURBOMOUSE5;
+				desc = "TurboMouse 5";
 				init_turbomouse(id);
 			}
 			else if ((req.reply_len == 9) &&
 			    (req.reply[1] == 0x4b) && (req.reply[2] == 0x4f) &&
 			    (req.reply[3] == 0x49) && (req.reply[4] == 0x54)) {
 				if (adb_try_handler_change(id, 0x42)) {
-					pr_cont("\nADB MacAlly 2-button mouse at %d, handler set to 0x42", id);
 					mouse_kind = ADBMOUSE_MACALLY2;
+					desc = "MacAlly 2-button";
 				}
 			}
 		}
-		pr_cont("\n");
 
 		adb_get_infos(id, &default_id, &cur_handler_id);
+		printk(KERN_DEBUG "ADB mouse (%s) at %d has handler 0x%X\n",
+		       desc, id, cur_handler_id);
 		reg |= adbhid_input_reregister(id, default_id, org_handler_id,
 					       cur_handler_id, mouse_kind);
 	}
@@ -1092,12 +1090,10 @@ init_trackpad(int id)
 	struct adb_request req;
 	unsigned char r1_buffer[8];
 
-	pr_cont(" (trackpad)");
-
 	adb_request(&req, NULL, ADBREQ_SYNC | ADBREQ_REPLY, 1,
 		    ADB_READREG(id,1));
 	if (req.reply_len < 8)
-	    pr_cont("bad length for reg. 1\n");
+		pr_err("%s: bad length for reg. 1\n", __func__);
 	else
 	{
 	    memcpy(r1_buffer, &req.reply[1], 8);
@@ -1145,8 +1141,6 @@ init_trackball(int id)
 {
 	struct adb_request req;
 
-	pr_cont(" (trackman/mouseman)");
-
 	adb_request(&req, NULL, ADBREQ_SYNC, 3,
 	ADB_WRITEREG(id,1), 00,0x81);
 
@@ -1177,8 +1171,6 @@ init_turbomouse(int id)
 {
 	struct adb_request req;
 
-	pr_cont(" (TurboMouse 5)");
-
 	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
 
 	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(3));
@@ -1213,8 +1205,6 @@ init_microspeed(int id)
 {
 	struct adb_request req;
 
-	pr_cont(" (Microspeed/MacPoint or compatible)");
-
 	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
 
 	/* This will initialize mice using the Microspeed, MacPoint and
@@ -1253,7 +1243,6 @@ init_ms_a3(int id)
 {
 	struct adb_request req;
 
-	pr_cont(" (Mouse Systems A3 Mouse, or compatible)");
 	adb_request(&req, NULL, ADBREQ_SYNC, 3,
 	ADB_WRITEREG(id, 0x2),
 	    0x00,
-- 
2.16.4
