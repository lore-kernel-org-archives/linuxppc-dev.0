Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id EAFC8DDE16
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 01:02:44 +1000 (EST)
From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@tungstengraphics.com>
To: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 1/2] hid: Rename some code identifiers from PowerBook specific
	to Apple generic.
Date: Sat, 13 Oct 2007 16:37:24 +0200
Message-Id: <1192286246-11489-2-git-send-email-michel@tungstengraphics.com>
In-Reply-To: <1192286246-11489-1-git-send-email-michel@tungstengraphics.com>
References: <1192286246-11489-1-git-send-email-michel@tungstengraphics.com>
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

Preserve identifiers exposed in build and run time configuration though in
order not to break existing configurations.

This is in preparation for adding support for Apple aluminum USB keyboards.

Signed-off-by: Michel Dänzer <michel@tungstengraphics.com>
---
 drivers/hid/hid-input.c         |   75 ++++++++++++++++++++-------------------
 drivers/hid/usbhid/hid-quirks.c |   26 +++++++-------
 include/linux/hid.h             |    8 ++--
 3 files changed, 55 insertions(+), 54 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 8edbd30..bcc61bb 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -34,10 +34,10 @@
 #include <linux/hid.h>
 #include <linux/hid-debug.h>
 
-static int hid_pb_fnmode = 1;
-module_param_named(pb_fnmode, hid_pb_fnmode, int, 0644);
+static int hid_apple_fnmode = 1;
+module_param_named(pb_fnmode, hid_apple_fnmode, int, 0644);
 MODULE_PARM_DESC(pb_fnmode,
-		"Mode of fn key on PowerBooks (0 = disabled, 1 = fkeyslast, 2 = fkeysfirst)");
+		"Mode of fn key on Apple keyboards (0 = disabled, 1 = fkeyslast, 2 = fkeysfirst)");
 
 #define unk	KEY_UNKNOWN
 
@@ -94,20 +94,20 @@ struct hidinput_key_translation {
 	u8 flags;
 };
 
-#define POWERBOOK_FLAG_FKEY 0x01
+#define APPLE_FLAG_FKEY 0x01
 
 static struct hidinput_key_translation powerbook_fn_keys[] = {
 	{ KEY_BACKSPACE, KEY_DELETE },
-	{ KEY_F1,       KEY_BRIGHTNESSDOWN,     POWERBOOK_FLAG_FKEY },
-	{ KEY_F2,       KEY_BRIGHTNESSUP,       POWERBOOK_FLAG_FKEY },
-	{ KEY_F3,       KEY_MUTE,               POWERBOOK_FLAG_FKEY },
-	{ KEY_F4,       KEY_VOLUMEDOWN,         POWERBOOK_FLAG_FKEY },
-	{ KEY_F5,       KEY_VOLUMEUP,           POWERBOOK_FLAG_FKEY },
-	{ KEY_F6,       KEY_NUMLOCK,            POWERBOOK_FLAG_FKEY },
-	{ KEY_F7,       KEY_SWITCHVIDEOMODE,    POWERBOOK_FLAG_FKEY },
-	{ KEY_F8,       KEY_KBDILLUMTOGGLE,     POWERBOOK_FLAG_FKEY },
-	{ KEY_F9,       KEY_KBDILLUMDOWN,       POWERBOOK_FLAG_FKEY },
-	{ KEY_F10,      KEY_KBDILLUMUP,         POWERBOOK_FLAG_FKEY },
+	{ KEY_F1,       KEY_BRIGHTNESSDOWN,     APPLE_FLAG_FKEY },
+	{ KEY_F2,       KEY_BRIGHTNESSUP,       APPLE_FLAG_FKEY },
+	{ KEY_F3,       KEY_MUTE,               APPLE_FLAG_FKEY },
+	{ KEY_F4,       KEY_VOLUMEDOWN,         APPLE_FLAG_FKEY },
+	{ KEY_F5,       KEY_VOLUMEUP,           APPLE_FLAG_FKEY },
+	{ KEY_F6,       KEY_NUMLOCK,            APPLE_FLAG_FKEY },
+	{ KEY_F7,       KEY_SWITCHVIDEOMODE,    APPLE_FLAG_FKEY },
+	{ KEY_F8,       KEY_KBDILLUMTOGGLE,     APPLE_FLAG_FKEY },
+	{ KEY_F9,       KEY_KBDILLUMDOWN,       APPLE_FLAG_FKEY },
+	{ KEY_F10,      KEY_KBDILLUMUP,         APPLE_FLAG_FKEY },
 	{ KEY_UP,       KEY_PAGEUP },
 	{ KEY_DOWN,     KEY_PAGEDOWN },
 	{ KEY_LEFT,     KEY_HOME },
@@ -138,7 +138,7 @@ static struct hidinput_key_translation powerbook_numlock_keys[] = {
 	{ }
 };
 
-static struct hidinput_key_translation powerbook_iso_keyboard[] = {
+static struct hidinput_key_translation apple_iso_keyboard[] = {
 	{ KEY_GRAVE,    KEY_102ND },
 	{ KEY_102ND,    KEY_GRAVE },
 	{ }
@@ -156,39 +156,39 @@ static struct hidinput_key_translation *find_translation(struct hidinput_key_tra
 	return NULL;
 }
 
-static int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
+static int hidinput_apple_event(struct hid_device *hid, struct input_dev *input,
 		struct hid_usage *usage, __s32 value)
 {
 	struct hidinput_key_translation *trans;
 
 	if (usage->code == KEY_FN) {
-		if (value) hid->quirks |=  HID_QUIRK_POWERBOOK_FN_ON;
-		else       hid->quirks &= ~HID_QUIRK_POWERBOOK_FN_ON;
+		if (value) hid->quirks |=  HID_QUIRK_APPLE_FN_ON;
+		else       hid->quirks &= ~HID_QUIRK_APPLE_FN_ON;
 
 		input_event(input, usage->type, usage->code, value);
 
 		return 1;
 	}
 
-	if (hid_pb_fnmode) {
+	if (hid_apple_fnmode) {
 		int do_translate;
 
 		trans = find_translation(powerbook_fn_keys, usage->code);
 		if (trans) {
-			if (test_bit(usage->code, hid->pb_pressed_fn))
+			if (test_bit(usage->code, hid->apple_pressed_fn))
 				do_translate = 1;
-			else if (trans->flags & POWERBOOK_FLAG_FKEY)
+			else if (trans->flags & APPLE_FLAG_FKEY)
 				do_translate =
-					(hid_pb_fnmode == 2 &&  (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON)) ||
-					(hid_pb_fnmode == 1 && !(hid->quirks & HID_QUIRK_POWERBOOK_FN_ON));
+					(hid_apple_fnmode == 2 &&  (hid->quirks & HID_QUIRK_APPLE_FN_ON)) ||
+					(hid_apple_fnmode == 1 && !(hid->quirks & HID_QUIRK_APPLE_FN_ON));
 			else
-				do_translate = (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON);
+				do_translate = (hid->quirks & HID_QUIRK_APPLE_FN_ON);
 
 			if (do_translate) {
 				if (value)
-					set_bit(usage->code, hid->pb_pressed_fn);
+					set_bit(usage->code, hid->apple_pressed_fn);
 				else
-					clear_bit(usage->code, hid->pb_pressed_fn);
+					clear_bit(usage->code, hid->apple_pressed_fn);
 
 				input_event(input, usage->type, trans->to, value);
 
@@ -213,8 +213,8 @@ static int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
 		}
 	}
 
-	if (hid->quirks & HID_QUIRK_POWERBOOK_ISO_KEYBOARD) {
-		trans = find_translation(powerbook_iso_keyboard, usage->code);
+	if (hid->quirks & HID_QUIRK_APPLE_ISO_KEYBOARD) {
+		trans = find_translation(apple_iso_keyboard, usage->code);
 		if (trans) {
 			input_event(input, usage->type, trans->to, value);
 			return 1;
@@ -224,7 +224,7 @@ static int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
 	return 0;
 }
 
-static void hidinput_pb_setup(struct input_dev *input)
+static void hidinput_apple_setup(struct input_dev *input)
 {
 	struct hidinput_key_translation *trans;
 
@@ -237,18 +237,19 @@ static void hidinput_pb_setup(struct input_dev *input)
 	for (trans = powerbook_numlock_keys; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
 
-	for (trans = powerbook_iso_keyboard; trans->from; trans++)
+	for (trans = apple_iso_keyboard; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
 
 }
 #else
-static inline int hidinput_pb_event(struct hid_device *hid, struct input_dev *input,
-		struct hid_usage *usage, __s32 value)
+static inline int hidinput_apple_event(struct hid_device *hid,
+				       struct input_dev *input,
+				       struct hid_usage *usage, __s32 value)
 {
 	return 0;
 }
 
-static inline void hidinput_pb_setup(struct input_dev *input)
+static inline void hidinput_apple_setup(struct input_dev *input)
 {
 }
 #endif
@@ -742,14 +743,14 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			}
 			break;
 
-		case HID_UP_CUSTOM: /* Reported on Logitech and Powerbook USB keyboards */
+		case HID_UP_CUSTOM: /* Reported on Logitech and Apple USB keyboards */
 
 			set_bit(EV_REP, input->evbit);
 			switch(usage->hid & HID_USAGE) {
 				case 0x003:
-					/* The fn key on Apple PowerBooks */
+					/* The fn key on Apple USB keyboards */
 					map_key_clear(KEY_FN);
-					hidinput_pb_setup(input);
+					hidinput_apple_setup(input);
 					break;
 
 				default:    goto ignore;
@@ -929,7 +930,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 	}
 
-	if ((hid->quirks & HID_QUIRK_POWERBOOK_HAS_FN) && hidinput_pb_event(hid, input, usage, value))
+	if ((hid->quirks & HID_QUIRK_APPLE_HAS_FN) && hidinput_apple_event(hid, input, usage, value))
 		return;
 
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 6b21a21..5e4ad65 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -516,19 +516,19 @@ static const struct hid_blacklist {
 
 	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_POWERBOOK_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_POWERBOOK_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_POWERBOOK_ISO_KEYBOARD},
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
-	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_POWERBOOK_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ANSI, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER_JIS, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ANSI, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER3_JIS, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ANSI, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_ISO, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE | HID_QUIRK_APPLE_ISO_KEYBOARD},
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER4_JIS, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_TP_ONLY, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
+	{ USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_GEYSER1_TP_ONLY, HID_QUIRK_APPLE_HAS_FN | HID_QUIRK_IGNORE_MOUSE },
 
 	{ USB_VENDOR_ID_DELL, USB_DEVICE_ID_DELL_W7658, HID_QUIRK_RESET_LEDS },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_KBD, HID_QUIRK_RESET_LEDS },
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 898103b..e03f210 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -263,10 +263,10 @@ struct hid_item {
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x00000100
 #define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x00000200
 #define HID_QUIRK_MIGHTYMOUSE			0x00000400
-#define HID_QUIRK_POWERBOOK_HAS_FN		0x00000800
-#define HID_QUIRK_POWERBOOK_FN_ON		0x00001000
+#define HID_QUIRK_APPLE_HAS_FN			0x00000800
+#define HID_QUIRK_APPLE_FN_ON			0x00001000
 #define HID_QUIRK_INVERT_HWHEEL			0x00002000
-#define HID_QUIRK_POWERBOOK_ISO_KEYBOARD        0x00004000
+#define HID_QUIRK_APPLE_ISO_KEYBOARD		0x00004000
 #define HID_QUIRK_BAD_RELATIVE_KEYS		0x00008000
 #define HID_QUIRK_SKIP_OUTPUT_REPORTS		0x00010000
 #define HID_QUIRK_IGNORE_MOUSE			0x00020000
@@ -459,7 +459,7 @@ struct hid_device {							/* device report descriptor */
 				  struct hid_usage *, __s32);
 	void (*hiddev_report_event) (struct hid_device *, struct hid_report *);
 #ifdef CONFIG_USB_HIDINPUT_POWERBOOK
-	unsigned long pb_pressed_fn[NBITS(KEY_MAX)];
+	unsigned long apple_pressed_fn[NBITS(KEY_MAX)];
 	unsigned long pb_pressed_numlock[NBITS(KEY_MAX)];
 #endif
 };
-- 
1.5.3.4
