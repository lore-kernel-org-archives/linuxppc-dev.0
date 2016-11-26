Return-Path: <whitebox@nefkom.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQv291pS7zDvsh
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 00:30:09 +1100 (AEDT)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tQv282nMKz9vDY
 for <linuxppc-dev@ozlabs.org>; Sun, 27 Nov 2016 00:30:08 +1100 (AEDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 3tQtsf0869z3hj1D
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Nov 2016 14:22:45 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 3tQtsd20kvzvlwC
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Nov 2016 14:22:45 +0100 (CET)
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
 port 10024) with ESMTP id 4yLRJKBqgAtA for <linuxppc-dev@ozlabs.org>;
 Sat, 26 Nov 2016 14:22:42 +0100 (CET)
Received: from igel.home (ppp-88-217-27-16.dynamic.mnet-online.de
 [88.217.27.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA
 for <linuxppc-dev@ozlabs.org>; Sat, 26 Nov 2016 14:22:42 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] adb: properly mark continued kernel messages
Date: Sat, 26 Nov 2016 14:22:41 +0100
Message-ID: <87r35ynzoe.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use pr_cont where appropriate, and switch to pr_foo throughout.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 drivers/macintosh/adb.c    | 24 +++++++++-----------
 drivers/macintosh/adbhid.c | 56 +++++++++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 226179b975..bb6c759b66 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -206,18 +206,17 @@ static int adb_scan_bus(void)
 	}
 
 	/* Now fill in the handler_id field of the adb_handler entries. */
-	printk(KERN_DEBUG "adb devices:");
+	pr_debug("adb devices:\n");
 	for (i = 1; i < 16; i++) {
 		if (adb_handler[i].original_address == 0)
 			continue;
 		adb_request(&req, NULL, ADBREQ_SYNC | ADBREQ_REPLY, 1,
 			    (i << 4) | 0xf);
 		adb_handler[i].handler_id = req.reply[2];
-		printk(" [%d]: %d %x", i, adb_handler[i].original_address,
-		       adb_handler[i].handler_id);
+		pr_debug(" [%d]: %d %x\n", i, adb_handler[i].original_address,
+			 adb_handler[i].handler_id);
 		devmask |= 1 << i;
 	}
-	printk("\n");
 	return devmask;
 }
 
@@ -228,9 +227,9 @@ static int adb_scan_bus(void)
 static int
 adb_probe_task(void *x)
 {
-	printk(KERN_INFO "adb: starting probe task...\n");
+	pr_info("adb: starting probe task...\n");
 	do_adb_reset_bus();
-	printk(KERN_INFO "adb: finished probe task...\n");
+	pr_info("adb: finished probe task...\n");
 
 	up(&adb_probe_mutex);
 
@@ -340,7 +339,7 @@ static int __init adb_init(void)
 	    adb_controller->init())
 		adb_controller = NULL;
 	if (adb_controller == NULL) {
-		printk(KERN_WARNING "Warning: no ADB interface detected\n");
+		pr_warn("Warning: no ADB interface detected\n");
 	} else {
 #ifdef CONFIG_PPC
 		if (of_machine_is_compatible("AAPL,PowerBook1998") ||
@@ -483,8 +482,7 @@ adb_register(int default_id, int handler_id, struct adb_ids *ids,
 		    (!handler_id || (handler_id == adb_handler[i].handler_id) || 
 		    try_handler_change(i, handler_id))) {
 			if (adb_handler[i].handler != 0) {
-				printk(KERN_ERR
-				       "Two handlers for ADB device %d\n",
+				pr_err("Two handlers for ADB device %d\n",
 				       default_id);
 				continue;
 			}
@@ -538,10 +536,10 @@ adb_input(unsigned char *buf, int nb, int autopoll)
 		
 	id = buf[0] >> 4;
 	if (dump_adb_input) {
-		printk(KERN_INFO "adb packet: ");
+		pr_info("adb packet: ");
 		for (i = 0; i < nb; ++i)
-			printk(" %x", buf[i]);
-		printk(", id = %d\n", id);
+			pr_cont(" %x", buf[i]);
+		pr_cont(", id = %d\n", id);
 	}
 	write_lock_irqsave(&adb_handler_lock, flags);
 	handler = adb_handler[id].handler;
@@ -891,7 +889,7 @@ static void __init
 adbdev_init(void)
 {
 	if (register_chrdev(ADB_MAJOR, "adb", &adb_fops)) {
-		printk(KERN_ERR "adb: unable to get major %d\n", ADB_MAJOR);
+		pr_err("adb: unable to get major %d\n", ADB_MAJOR);
 		return;
 	}
 
diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
index 09d72bb00d..3c37e54b0b 100644
--- a/drivers/macintosh/adbhid.c
+++ b/drivers/macintosh/adbhid.c
@@ -267,7 +267,7 @@ adbhid_keyboard_input(unsigned char *data, int nb, int apoll)
 	int id = (data[0] >> 4) & 0x0f;
 
 	if (!adbhid[id]) {
-		printk(KERN_ERR "ADB HID on ID %d not yet registered, packet %#02x, %#02x, %#02x, %#02x\n",
+		pr_err("ADB HID on ID %d not yet registered, packet %#02x, %#02x, %#02x, %#02x\n",
 		       id, data[0], data[1], data[2], data[3]);
 		return;
 	}
@@ -319,8 +319,8 @@ adbhid_input_keycode(int id, int scancode, int repeat)
 					ahid->flags &= ~FLAG_CAPSLOCK_TRANSLATE;
 				}
 			} else {
-				printk(KERN_INFO "Spurious caps lock event "
-						 "(scancode 0xff).\n");
+				pr_info("Spurious caps lock event "
+					"(scancode 0xff).\n");
 			}
 		}
 	}
@@ -396,8 +396,8 @@ adbhid_input_keycode(int id, int scancode, int repeat)
 		input_report_key(adbhid[id]->input, key, !up_flag);
 		input_sync(adbhid[id]->input);
 	} else
-		printk(KERN_INFO "Unhandled ADB key (scancode %#02x) %s.\n", keycode,
-		       up_flag ? "released" : "pressed");
+		pr_info("Unhandled ADB key (scancode %#02x) %s.\n", keycode,
+			up_flag ? "released" : "pressed");
 
 }
 
@@ -407,7 +407,7 @@ adbhid_mouse_input(unsigned char *data, int nb, int autopoll)
 	int id = (data[0] >> 4) & 0x0f;
 
 	if (!adbhid[id]) {
-		printk(KERN_ERR "ADB HID on ID %d not yet registered\n", id);
+		pr_err("ADB HID on ID %d not yet registered\n", id);
 		return;
 	}
 
@@ -505,7 +505,7 @@ adbhid_buttons_input(unsigned char *data, int nb, int autopoll)
 	int id = (data[0] >> 4) & 0x0f;
 
 	if (!adbhid[id]) {
-		printk(KERN_ERR "ADB HID on ID %d not yet registered\n", id);
+		pr_err("ADB HID on ID %d not yet registered\n", id);
 		return;
 	}
 
@@ -533,8 +533,8 @@ adbhid_buttons_input(unsigned char *data, int nb, int autopoll)
 			break;
 
 		default:
-			printk(KERN_INFO "Unhandled ADB_MISC event %02x, %02x, %02x, %02x\n",
-			       data[0], data[1], data[2], data[3]);
+			pr_info("Unhandled ADB_MISC event %02x, %02x, %02x, %02x\n",
+				data[0], data[1], data[2], data[3]);
 			break;
 		}
 	  }
@@ -608,14 +608,14 @@ adbhid_buttons_input(unsigned char *data, int nb, int autopoll)
 				break;
 
 			default:
-				printk(KERN_INFO "Unhandled ADB_MISC event %02x, %02x, %02x, %02x\n",
-				       data[0], data[1], data[2], data[3]);
+				pr_info("Unhandled ADB_MISC event %02x, %02x, %02x, %02x\n",
+					data[0], data[1], data[2], data[3]);
 				break;
 			}
 			break;
 		default:
-			printk(KERN_INFO "Unhandled ADB_MISC event %02x, %02x, %02x, %02x\n",
-			       data[0], data[1], data[2], data[3]);
+			pr_info("Unhandled ADB_MISC event %02x, %02x, %02x, %02x\n",
+				data[0], data[1], data[2], data[3]);
 			break;
 		}
 	  }
@@ -759,7 +759,7 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 	int i;
 
 	if (adbhid[id]) {
-		printk(KERN_ERR "Trying to reregister ADB HID on ID %d\n", id);
+		pr_err("Trying to reregister ADB HID on ID %d\n", id);
 		return -EEXIST;
 	}
 
@@ -798,24 +798,24 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 
 		memcpy(hid->keycode, adb_to_linux_keycodes, sizeof(adb_to_linux_keycodes));
 
-		printk(KERN_INFO "Detected ADB keyboard, type ");
+		pr_info("Detected ADB keyboard, type ");
 		switch (original_handler_id) {
 		default:
-			printk("<unknown>.\n");
+			pr_cont("<unknown>.\n");
 			input_dev->id.version = ADB_KEYBOARD_UNKNOWN;
 			break;
 
 		case 0x01: case 0x02: case 0x03: case 0x06: case 0x08:
 		case 0x0C: case 0x10: case 0x18: case 0x1B: case 0x1C:
 		case 0xC0: case 0xC3: case 0xC6:
-			printk("ANSI.\n");
+			pr_cont("ANSI.\n");
 			input_dev->id.version = ADB_KEYBOARD_ANSI;
 			break;
 
 		case 0x04: case 0x05: case 0x07: case 0x09: case 0x0D:
 		case 0x11: case 0x14: case 0x19: case 0x1D: case 0xC1:
 		case 0xC4: case 0xC7:
-			printk("ISO, swapping keys.\n");
+			pr_cont("ISO, swapping keys.\n");
 			input_dev->id.version = ADB_KEYBOARD_ISO;
 			i = hid->keycode[10];
 			hid->keycode[10] = hid->keycode[50];
@@ -824,7 +824,7 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 
 		case 0x12: case 0x15: case 0x16: case 0x17: case 0x1A:
 		case 0x1E: case 0xC2: case 0xC5: case 0xC8: case 0xC9:
-			printk("JIS.\n");
+			pr_cont("JIS.\n");
 			input_dev->id.version = ADB_KEYBOARD_JIS;
 			break;
 		}
@@ -883,7 +883,7 @@ adbhid_input_register(int id, int default_id, int original_handler_id,
 		/* else fall through */
 
 	default:
-		printk(KERN_INFO "Trying to register unknown ADB device to input layer.\n");
+		pr_info("Trying to register unknown ADB device to input layer.\n");
 		err = -ENODEV;
 		goto fail;
 	}
@@ -1072,12 +1072,12 @@ adbhid_probe(void)
 			    (req.reply[1] == 0x4b) && (req.reply[2] == 0x4f) &&
 			    (req.reply[3] == 0x49) && (req.reply[4] == 0x54)) {
 				if (adb_try_handler_change(id, 0x42)) {
-					printk("\nADB MacAlly 2-button mouse at %d, handler set to 0x42", id);
+					pr_cont("\nADB MacAlly 2-button mouse at %d, handler set to 0x42", id);
 					mouse_kind = ADBMOUSE_MACALLY2;
 				}
 			}
 		}
-		printk("\n");
+		pr_cont("\n");
 
 		adb_get_infos(id, &default_id, &cur_handler_id);
 		reg |= adbhid_input_reregister(id, default_id, org_handler_id,
@@ -1092,12 +1092,12 @@ init_trackpad(int id)
 	struct adb_request req;
 	unsigned char r1_buffer[8];
 
-	printk(" (trackpad)");
+	pr_cont(" (trackpad)");
 
 	adb_request(&req, NULL, ADBREQ_SYNC | ADBREQ_REPLY, 1,
 		    ADB_READREG(id,1));
 	if (req.reply_len < 8)
-	    printk("bad length for reg. 1\n");
+	    pr_cont("bad length for reg. 1\n");
 	else
 	{
 	    memcpy(r1_buffer, &req.reply[1], 8);
@@ -1145,7 +1145,7 @@ init_trackball(int id)
 {
 	struct adb_request req;
 
-	printk(" (trackman/mouseman)");
+	pr_cont(" (trackman/mouseman)");
 
 	adb_request(&req, NULL, ADBREQ_SYNC, 3,
 	ADB_WRITEREG(id,1), 00,0x81);
@@ -1177,7 +1177,7 @@ init_turbomouse(int id)
 {
 	struct adb_request req;
 
-        printk(" (TurboMouse 5)");
+        pr_cont(" (TurboMouse 5)");
 
 	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
 
@@ -1213,7 +1213,7 @@ init_microspeed(int id)
 {
 	struct adb_request req;
 
-        printk(" (Microspeed/MacPoint or compatible)");
+        pr_cont(" (Microspeed/MacPoint or compatible)");
 
 	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
 
@@ -1253,7 +1253,7 @@ init_ms_a3(int id)
 {
 	struct adb_request req;
 
-	printk(" (Mouse Systems A3 Mouse, or compatible)");
+	pr_cont(" (Mouse Systems A3 Mouse, or compatible)");
 	adb_request(&req, NULL, ADBREQ_SYNC, 3,
 	ADB_WRITEREG(id, 0x2),
 	    0x00,
-- 
2.10.2


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
