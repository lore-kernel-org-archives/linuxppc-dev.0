Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7468067B5A
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 02:10:17 +1000 (EST)
Received: from tate.cathedrallabs.org
	(201-25-167-1.ctame704.dsl.brasiltelecom.net.br [201.25.167.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by tinc.cathedrallabs.org (Postfix) with ESMTP id 1001F10009
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Aug 2006 11:41:30 -0400 (EDT)
Date: Tue, 8 Aug 2006 12:41:17 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] adbhid: enable KEY_FN key reporting
Message-ID: <20060808154117.GA3363@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch enables the KEY_FN reporting on ADB based machines. This is a
needed step to move special key sequences handling to user space and to
allow the usage of Fn key to other purposes. I've been running this for
some days without problems.

Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>
Acked-by: Michael Hanselmann <linux-kernel@hansmi.ch>

Index: ppc-2.6/drivers/macintosh/adbhid.c
===================================================================
--- ppc-2.6.orig/drivers/macintosh/adbhid.c	2006-08-04 08:53:20.000000000 -0300
+++ ppc-2.6/drivers/macintosh/adbhid.c	2006-08-04 09:45:43.000000000 -0300
@@ -70,7 +70,7 @@
 #define ADB_KEY_POWER_OLD	0x7e
 #define ADB_KEY_POWER		0x7f
 
-u8 adb_to_linux_keycodes[128] = {
+u16 adb_to_linux_keycodes[128] = {
 	/* 0x00 */ KEY_A, 		/*  30 */
 	/* 0x01 */ KEY_S, 		/*  31 */
 	/* 0x02 */ KEY_D,		/*  32 */
@@ -134,7 +134,7 @@
 	/* 0x3c */ KEY_RIGHT,		/* 106 */
 	/* 0x3d */ KEY_DOWN,		/* 108 */
 	/* 0x3e */ KEY_UP,		/* 103 */
-	/* 0x3f */ 0,
+	/* 0x3f */ KEY_FN,		/* 0x1d0 */
 	/* 0x40 */ 0,
 	/* 0x41 */ KEY_KPDOT,		/*  83 */
 	/* 0x42 */ 0,
@@ -208,7 +208,7 @@
 	int original_handler_id;
 	int current_handler_id;
 	int mouse_kind;
-	unsigned char *keycode;
+	u16 *keycode;
 	char name[64];
 	char phys[32];
 	int flags;
@@ -275,7 +275,7 @@
 adbhid_input_keycode(int id, int keycode, int repeat, struct pt_regs *regs)
 {
 	struct adbhid *ahid = adbhid[id];
-	int up_flag;
+	int up_flag, key;
 
 	up_flag = (keycode & 0x80);
 	keycode &= 0x7f;
@@ -322,8 +322,7 @@
 			}
 		} else
 			ahid->flags |= FLAG_FN_KEY_PRESSED;
-		/* Swallow the key press */
-		return;
+		break;
 	case ADB_KEY_DEL:
 		/* Emulate Fn+delete = forward delete */
 		if (ahid->flags & FLAG_FN_KEY_PRESSED) {
@@ -337,10 +336,10 @@
 #endif /* CONFIG_PPC_PMAC */
 	}
 
-	if (adbhid[id]->keycode[keycode]) {
+	key = adbhid[id]->keycode[keycode];
+	if (key) {
 		input_regs(adbhid[id]->input, regs);
-		input_report_key(adbhid[id]->input,
-				 adbhid[id]->keycode[keycode], !up_flag);
+		input_report_key(adbhid[id]->input, key, !up_flag);
 		input_sync(adbhid[id]->input);
 	} else
 		printk(KERN_INFO "Unhandled ADB key (scancode %#02x) %s.\n", keycode,
@@ -764,8 +763,8 @@
 		input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
 		input_dev->ledbit[0] = BIT(LED_SCROLLL) | BIT(LED_CAPSL) | BIT(LED_NUML);
 		input_dev->event = adbhid_kbd_event;
-		input_dev->keycodemax = 127;
-		input_dev->keycodesize = 1;
+		input_dev->keycodemax = KEY_FN;
+		input_dev->keycodesize = sizeof(hid->keycode[0]);
 		break;
 
 	case ADB_MOUSE:
