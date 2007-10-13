Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 72AD0DDE1C
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 01:02:44 +1000 (EST)
From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@tungstengraphics.com>
To: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 2/2] hid: Add support for Apple aluminum USB keyboards.
Date: Sat, 13 Oct 2007 16:37:25 +0200
Message-Id: <1192286246-11489-3-git-send-email-michel@tungstengraphics.com>
In-Reply-To: <1192286246-11489-2-git-send-email-michel@tungstengraphics.com>
References: <1192286246-11489-1-git-send-email-michel@tungstengraphics.com>
	<1192286246-11489-2-git-send-email-michel@tungstengraphics.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org,
	mactel-linux-devel@lists.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reuse the existing quirks for Apple laptop USB keyboards.

Signed-off-by: Michel Dänzer <michel@tungstengraphics.com>
---
 drivers/hid/hid-input.c         |   24 +++++++++++++++++++++++-
 drivers/hid/usbhid/Kconfig      |    5 +++--
 drivers/hid/usbhid/hid-quirks.c |    6 ++++++
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index bcc61bb..cae98c2 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -96,6 +96,22 @@ struct hidinput_key_translation {
 
 #define APPLE_FLAG_FKEY 0x01
 
+static struct hidinput_key_translation apple_fn_keys[] = {
+	{ KEY_F1,       KEY_BRIGHTNESSDOWN,     APPLE_FLAG_FKEY },
+	{ KEY_F2,       KEY_BRIGHTNESSUP,       APPLE_FLAG_FKEY },
+	{ KEY_F3,       KEY_CYCLEWINDOWS,       APPLE_FLAG_FKEY }, /* Exposé */
+	{ KEY_F4,       KEY_FN_F4,              APPLE_FLAG_FKEY }, /* Dashboard */
+	{ KEY_F5,       KEY_FN_F5 },
+	{ KEY_F6,       KEY_FN_F6 },
+	{ KEY_F7,       KEY_BACK,               APPLE_FLAG_FKEY },
+	{ KEY_F8,       KEY_PLAYPAUSE,          APPLE_FLAG_FKEY },
+	{ KEY_F9,       KEY_FORWARD,            APPLE_FLAG_FKEY },
+	{ KEY_F10,      KEY_MUTE,               APPLE_FLAG_FKEY },
+	{ KEY_F11,      KEY_VOLUMEDOWN,         APPLE_FLAG_FKEY },
+	{ KEY_F12,      KEY_VOLUMEUP,           APPLE_FLAG_FKEY },
+	{ }
+};
+
 static struct hidinput_key_translation powerbook_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
 	{ KEY_F1,       KEY_BRIGHTNESSDOWN,     APPLE_FLAG_FKEY },
@@ -173,7 +189,10 @@ static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 	if (hid_apple_fnmode) {
 		int do_translate;
 
-		trans = find_translation(powerbook_fn_keys, usage->code);
+		trans = find_translation((hid->product < 0x220 ||
+					  hid->product >= 0x300) ?
+					 powerbook_fn_keys : apple_fn_keys,
+					 usage->code);
 		if (trans) {
 			if (test_bit(usage->code, hid->apple_pressed_fn))
 				do_translate = 1;
@@ -231,6 +250,9 @@ static void hidinput_apple_setup(struct input_dev *input)
 	set_bit(KEY_NUMLOCK, input->keybit);
 
 	/* Enable all needed keys */
+	for (trans = apple_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
 	for (trans = powerbook_fn_keys; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
 
diff --git a/drivers/hid/usbhid/Kconfig b/drivers/hid/usbhid/Kconfig
index 1b4b572..74d7ff7 100644
--- a/drivers/hid/usbhid/Kconfig
+++ b/drivers/hid/usbhid/Kconfig
@@ -25,12 +25,13 @@ comment "Input core support is needed for USB HID input layer or HIDBP support"
 	depends on USB_HID && INPUT=n
 
 config USB_HIDINPUT_POWERBOOK
-	bool "Enable support for iBook/PowerBook/MacBook/MacBookPro special keys"
+	bool "Enable support for Apple laptop/aluminum USB special keys"
 	default n
 	depends on USB_HID
 	help
 	  Say Y here if you want support for the special keys (Fn, Numlock) on
-	  Apple iBooks, PowerBooks, MacBooks and MacBook Pros.
+	  Apple iBooks, PowerBooks, MacBooks, MacBook Pros and aluminum USB
+	  keyboards.
 
 	  If unsure, say N.
 
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 5e4ad65..8a469fd 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -59,6 +59,9 @@
 #define USB_DEVICE_ID_APPLE_GEYSER4_ANSI	0x021a
 #define USB_DEVICE_ID_APPLE_GEYSER4_ISO	0x021b
 #define USB_DEVICE_ID_APPLE_GEYSER4_JIS	0x021c
+#define USB_DEVICE_ID_APPLE_ALU_ANSI	0x0220
+#define USB_DEVICE_ID_APPLE_ALU_ISO	0x0221
+#define USB_DEVICE_ID_APPLE_ALU_JIS	0x0222
 #define USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY	0x030a
 #define USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY	0x030b
 
@@ -527,6 +530,9 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ANSI, HID_QUIRK_APPLE_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_APPLE_ISO_KEYBOARD },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_ALU_JIS, HID_QUIRK_APPLE_HAS_FN },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 
-- 
1.5.3.4
