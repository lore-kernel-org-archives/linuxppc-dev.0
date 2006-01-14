Return-Path: <dtor_core@ameritech.net>
Received: from smtp105.sbc.mail.re2.yahoo.com (smtp105.sbc.mail.re2.yahoo.com
	[68.142.229.100]) by ozlabs.org (Postfix) with SMTP id C4DE6689DA
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 15:58:37 +1100 (EST)
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Date: Fri, 13 Jan 2006 23:58:33 -0500
References: <20051225212041.GA6094@hansmi.ch>
	<20060113074749.GA7103@midnight.suse.cz>
	<20060113220252.GA1516@hansmi.ch>
In-Reply-To: <20060113220252.GA1516@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200601132358.33861.dtor_core@ameritech.net>
Cc: linux-kernel@killerfox.forkbomb.ch, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Vojtech Pavlik <vojtech@suse.cz>,
	linux-input@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 13 January 2006 17:02, Michael Hanselmann wrote:
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0case 0x003: map_key_clear(KEY_FN);=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0break;
> +#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0/* The fn key on Apple PowerBooks */
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0case 0x0003: {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct hidinput_key_translatio=
n *trans;
> +
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0map_key_clear(KEY_FN);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0set_bit(KEY_NUMLOCK, input->ke=
ybit);
> +

One little thing - I think that we should report FN key even if PowerBook
support is disabled. Can I solicit input on the patch below (I also rearran=
ged
teh code slightly)?=20

=2D-=20
Dmitry

=46rom: Michael Hanselmann <linux-kernel@hansmi.ch>

Input: HID - add support for fn key on Apple PowerBooks

This patch implements support for the fn key on Apple PowerBooks using
USB based keyboards and makes them behave like their ADB counterparts.

Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
Acked-by: Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>
Acked-by: Johannes Berg <johannes@sipsolutions.net>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
=2D--

 drivers/usb/input/Kconfig     |   10 ++
 drivers/usb/input/hid-core.c  |    8 ++
 drivers/usb/input/hid-input.c |  166 +++++++++++++++++++++++++++++++++++++=
++++-
 drivers/usb/input/hid.h       |   31 ++++---
 4 files changed, 201 insertions(+), 14 deletions(-)

Index: work/drivers/usb/input/hid-core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- work.orig/drivers/usb/input/hid-core.c
+++ work/drivers/usb/input/hid-core.c
@@ -1585,6 +1585,14 @@ static const struct hid_blacklist {
=20
 	{ USB_VENDOR_ID_CHERRY, USB_DEVICE_ID_CHERRY_CYMOTION, HID_QUIRK_CYMOTION=
 },
=20
+	{ USB_VENDOR_ID_APPLE, 0x020E, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x020F, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0214, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0215, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x0216, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x030A, HID_QUIRK_POWERBOOK_HAS_FN },
+	{ USB_VENDOR_ID_APPLE, 0x030B, HID_QUIRK_POWERBOOK_HAS_FN },
+
 	{ 0, 0 }
 };
=20
Index: work/drivers/usb/input/hid.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- work.orig/drivers/usb/input/hid.h
+++ work/drivers/usb/input/hid.h
@@ -235,18 +235,20 @@ struct hid_item {
  * HID device quirks.
  */
=20
=2D#define HID_QUIRK_INVERT			0x001
=2D#define HID_QUIRK_NOTOUCH			0x002
=2D#define HID_QUIRK_IGNORE			0x004
=2D#define HID_QUIRK_NOGET				0x008
=2D#define HID_QUIRK_HIDDEV			0x010
=2D#define HID_QUIRK_BADPAD			0x020
=2D#define HID_QUIRK_MULTI_INPUT			0x040
=2D#define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x080
=2D#define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x100
=2D#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x200
=2D#define HID_QUIRK_2WHEEL_POWERMOUSE		0x400
=2D#define HID_QUIRK_CYMOTION			0x800
+#define HID_QUIRK_INVERT			0x00000001
+#define HID_QUIRK_NOTOUCH			0x00000002
+#define HID_QUIRK_IGNORE			0x00000004
+#define HID_QUIRK_NOGET				0x00000008
+#define HID_QUIRK_HIDDEV			0x00000010
+#define HID_QUIRK_BADPAD			0x00000020
+#define HID_QUIRK_MULTI_INPUT			0x00000040
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_7		0x00000080
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_5		0x00000100
+#define HID_QUIRK_2WHEEL_MOUSE_HACK_ON		0x00000200
+#define HID_QUIRK_2WHEEL_POWERMOUSE		0x00000400
+#define HID_QUIRK_CYMOTION			0x00000800
+#define HID_QUIRK_POWERBOOK_HAS_FN		0x00001000
+#define HID_QUIRK_POWERBOOK_FN_ON		0x00002000
=20
 /*
  * This is the global environment of the parser. This information is
@@ -432,6 +434,11 @@ struct hid_device {							/* device repo
 	void (*ff_exit)(struct hid_device*);                            /* Called=
 by hid_exit_ff(hid) */
 	int (*ff_event)(struct hid_device *hid, struct input_dev *input,
 			unsigned int type, unsigned int code, int value);
+
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+	unsigned long pb_pressed_fn[NBITS(KEY_MAX)];
+	unsigned long pb_pressed_numlock[NBITS(KEY_MAX)];
+#endif
 };
=20
 #define HID_GLOBAL_STACK_SIZE 4
Index: work/drivers/usb/input/hid-input.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- work.orig/drivers/usb/input/hid-input.c
+++ work/drivers/usb/input/hid-input.c
@@ -73,6 +73,160 @@ static const struct {
 #define map_key_clear(c)	do { map_key(c); clear_bit(c, bit); } while (0)
 #define map_ff_effect(c)	do { set_bit(c, input->ffbit); } while (0)
=20
+#ifdef CONFIG_USB_HIDINPUT_POWERBOOK
+
+struct hidinput_key_translation {
+	u16 from;
+	u16 to;
+	u8 flags;
+};
+
+#define POWERBOOK_FLAG_FKEY 0x01
+
+static struct hidinput_key_translation powerbook_fn_keys[] =3D {
+	{ KEY_BACKSPACE, KEY_DELETE },
+	{ KEY_F1,	KEY_BRIGHTNESSDOWN,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F2,	KEY_BRIGHTNESSUP,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F3,	KEY_MUTE,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F4,	KEY_VOLUMEDOWN,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F5,	KEY_VOLUMEUP,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F6,	KEY_NUMLOCK,		POWERBOOK_FLAG_FKEY },
+	{ KEY_F7,	KEY_SWITCHVIDEOMODE,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F8,	KEY_KBDILLUMTOGGLE,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F9,	KEY_KBDILLUMDOWN,	POWERBOOK_FLAG_FKEY },
+	{ KEY_F10,	KEY_KBDILLUMUP,		POWERBOOK_FLAG_FKEY },
+	{ KEY_UP,	KEY_PAGEUP },
+	{ KEY_DOWN,	KEY_PAGEDOWN },
+	{ KEY_LEFT,	KEY_HOME },
+	{ KEY_RIGHT,	KEY_END },
+	{ }
+};
+
+static struct hidinput_key_translation powerbook_numlock_keys[] =3D {
+	{ KEY_J,	KEY_KP1 },
+	{ KEY_K,	KEY_KP2 },
+	{ KEY_L,	KEY_KP3 },
+	{ KEY_U,	KEY_KP4 },
+	{ KEY_I,	KEY_KP5 },
+	{ KEY_O,	KEY_KP6 },
+	{ KEY_7,	KEY_KP7 },
+	{ KEY_8,	KEY_KP8 },
+	{ KEY_9,	KEY_KP9 },
+	{ KEY_M,	KEY_KP0 },
+	{ KEY_DOT,	KEY_KPDOT },
+	{ KEY_SLASH,	KEY_KPPLUS },
+	{ KEY_SEMICOLON, KEY_KPMINUS },
+	{ KEY_P,	KEY_KPASTERISK },
+	{ KEY_MINUS,	KEY_KPEQUAL },
+	{ KEY_0,	KEY_KPSLASH },
+	{ KEY_F6,	KEY_NUMLOCK },
+	{ KEY_KPENTER,	KEY_KPENTER },
+	{ KEY_BACKSPACE, KEY_BACKSPACE },
+	{ }
+};
+
+static int usbhid_pb_fnmode =3D 1;
+module_param_named(pb_fnmode, usbhid_pb_fnmode, int, 0644);
+MODULE_PARM_DESC(pb_fnmode,
+	"Mode of fn key on PowerBooks (0 =3D disabled, 1 =3D fkeyslast, 2 =3D fke=
ysfirst)");
+
+static struct hidinput_key_translation *find_translation(struct hidinput_k=
ey_translation *table, u16 from)
+{
+	struct hidinput_key_translation *trans;
+
+	/* Look for the translation */
+	for (trans =3D table; trans->from; trans++)
+		if (trans->from =3D=3D from)
+			return trans;
+
+	return NULL;
+}
+
+static int hidinput_pb_event(struct hid_device *hid, struct input_dev *inp=
ut,
+			     struct hid_usage *usage, __s32 value)
+{
+	struct hidinput_key_translation *trans;
+
+	if (usage->code =3D=3D KEY_FN) {
+		if (value) hid->quirks |=3D  HID_QUIRK_POWERBOOK_FN_ON;
+		else       hid->quirks &=3D ~HID_QUIRK_POWERBOOK_FN_ON;
+
+		input_event(input, usage->type, usage->code, value);
+
+		return 1;
+	}
+
+	if (usbhid_pb_fnmode) {
+		int do_translate;
+
+		trans =3D find_translation(powerbook_fn_keys, usage->code);
+		if (trans) {
+			if (test_bit(usage->code, hid->pb_pressed_fn))
+				do_translate =3D 1;
+			else if (trans->flags & POWERBOOK_FLAG_FKEY)
+				do_translate =3D
+					(usbhid_pb_fnmode =3D=3D 2 &&  (hid->quirks & HID_QUIRK_POWERBOOK_FN_=
ON)) ||
+					(usbhid_pb_fnmode =3D=3D 1 && !(hid->quirks & HID_QUIRK_POWERBOOK_FN_=
ON));
+			else
+				do_translate =3D (hid->quirks & HID_QUIRK_POWERBOOK_FN_ON);
+
+			if (do_translate) {
+				if (value)
+					set_bit(usage->code, hid->pb_pressed_fn);
+				else
+					clear_bit(usage->code, hid->pb_pressed_fn);
+
+				input_event(input, usage->type, trans->to, value);
+
+				return 1;
+			}
+		}
+
+		if (test_bit(usage->code, hid->pb_pressed_numlock) ||
+		    test_bit(LED_NUML, input->led)) {
+			trans =3D find_translation(powerbook_numlock_keys, usage->code);
+
+			if (trans) {
+				if (value)
+					set_bit(usage->code, hid->pb_pressed_numlock);
+				else
+					clear_bit(usage->code, hid->pb_pressed_numlock);
+
+				input_event(input, usage->type, trans->to, value);
+			}
+
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static void hidinput_pb_setup(struct input_dev *input)
+{
+	struct hidinput_key_translation *trans;
+
+	set_bit(KEY_NUMLOCK, input->keybit);
+
+	/* Enable all needed keys */
+	for (trans =3D powerbook_fn_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+
+	for (trans =3D powerbook_numlock_keys; trans->from; trans++)
+		set_bit(trans->to, input->keybit);
+}
+#else
+static inline int hidinput_pb_event(struct hid_device *hid, struct input_d=
ev *input,
+				    struct hid_usage *usage, __s32 value)
+{
+	return 0;
+}
+
+static inline void hidinput_pb_setup(struct input_dev *input)
+{
+}
+#endif
+
 static void hidinput_configure_usage(struct hid_input *hidinput, struct hi=
d_field *field,
 				     struct hid_usage *usage)
 {
@@ -336,7 +490,12 @@ static void hidinput_configure_usage(str
=20
 			set_bit(EV_REP, input->evbit);
 			switch(usage->hid & HID_USAGE) {
=2D				case 0x003: map_key_clear(KEY_FN);		break;
+				case 0x003:
+					/* The fn key on Apple PowerBooks */
+					map_key_clear(KEY_FN);
+					hidinput_pb_setup(input);
+					break;
+
 				default:    goto ignore;
 			}
 			break;
@@ -493,6 +652,9 @@ void hidinput_hid_event(struct hid_devic
 		return;
 	}
=20
+	if ((hid->quirks & HID_QUIRK_POWERBOOK_HAS_FN) && hidinput_pb_event(hid, =
input, usage, value))
+		return;
+
 	if (usage->hat_min < usage->hat_max || usage->hat_dir) {
 		int hat_dir =3D usage->hat_dir;
 		if (!hat_dir)
@@ -535,7 +697,7 @@ void hidinput_hid_event(struct hid_devic
 		return;
 	}
=20
=2D	if((usage->type =3D=3D EV_KEY) && (usage->code =3D=3D 0)) /* Key 0 is "=
unassigned", not KEY_UNKNOWN */
+	if ((usage->type =3D=3D EV_KEY) && (usage->code =3D=3D 0)) /* Key 0 is "u=
nassigned", not KEY_UNKNOWN */
 		return;
=20
 	input_event(input, usage->type, usage->code, value);
Index: work/drivers/usb/input/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- work.orig/drivers/usb/input/Kconfig
+++ work/drivers/usb/input/Kconfig
@@ -37,6 +37,16 @@ config USB_HIDINPUT
=20
 	  If unsure, say Y.
=20
+config USB_HIDINPUT_POWERBOOK
+	bool "Enable support for iBook/PowerBook special keys"
+	default n
+	depends on USB_HIDINPUT
+	help
+	  Say Y here if you want support for the special keys (Fn, Numlock) on
+	  Apple iBooks and PowerBooks.
+
+	  If unsure, say N.
+
 config HID_FF
 	bool "Force feedback support (EXPERIMENTAL)"
 	depends on USB_HIDINPUT && EXPERIMENTAL
