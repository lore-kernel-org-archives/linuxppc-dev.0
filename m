Message-ID: <02cc01c39231$dce0d200$3cc8a8c0@ANOSP>
From: "Colin Leroy" <colin@colino.net>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Fw: [PATCH] Right-click modifier
Date: Tue, 14 Oct 2003 11:02:15 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_02C9_01C39242.A0379580"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_02C9_01C39242.A0379580
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

[Forwarding, just in case.]

> Hi,
>
> this patch adds an entry in /proc,
> /proc/sys/dev/mac_hid/rclick_key_modifier.
>
> It lets the kernel report a right-click when KEY+Left click are pressed,
> where KEY is the KEY specified by echoing its code to the /proc entry.
>
> ie, "echo 29 > /proc/sys/dev/mac_hid/rclick_key_modifier" and you'll
have
> Ctrl-click = right click.
>
> It's a patch against linuxppc-2.5-benh tree rsync'ed tonight from
> source.mvista.com.
>
> hope it's useful,
> --
> Colin

------=_NextPart_000_02C9_01C39242.A0379580
Content-Type: application/octet-stream;
	name="rclick_key_modifier.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="rclick_key_modifier.patch"

--- linuxppc-2.5-benh/drivers/input/input.c.orig	Mon Oct 13 23:04:52 =
2003
+++ linuxppc-2.5-benh/drivers/input/input.c	Mon Oct 13 23:06:46 2003
@@ -63,6 +63,10 @@
 }
=20
=20
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+extern int mac_hid_mouse_emulate_buttons(int,int,int);
+#endif
+
 void input_event(struct input_dev *dev, unsigned int type, unsigned int =
code, int value)
 {
 	struct input_handle *handle;
@@ -91,7 +95,10 @@
 			break;
=20
 		case EV_KEY:
-
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+			if (mac_hid_mouse_emulate_buttons(2, code, value))
+				code =3D BTN_RIGHT;
+#endif
 			if (code > KEY_MAX || !test_bit(code, dev->keybit) || =
!!test_bit(code, dev->key) =3D=3D value)
 				return;
=20
--- linuxppc-2.5-benh/drivers/macintosh/mac_hid.c.orig	Mon Oct 13 =
23:04:46 2003
+++ linuxppc-2.5-benh/drivers/macintosh/mac_hid.c	Mon Oct 13 23:05:40 =
2003
@@ -21,7 +21,9 @@
 static int mouse_emulate_buttons =3D 0;
 static int mouse_button2_keycode =3D KEY_RIGHTCTRL;	/* right control =
key */
 static int mouse_button3_keycode =3D KEY_RIGHTALT;	/* right option key =
*/
+static int rclick_key_modifier   =3D 0;			/* disabled */
 static int mouse_last_keycode =3D 0;
+static int rclick_key_modifier_down =3D 0;
=20
 #if defined(CONFIG_SYSCTL)
 /* file(s) in /proc/sys/dev/mac_hid */
@@ -50,6 +52,14 @@
 		.mode		=3D 0644,
 		.proc_handler	=3D &proc_dointvec,
 	},
+	{
+		.ctl_name       =3D DEV_MAC_HID_RCLICK_KEY_MODIFIER,
+		.procname       =3D "rclick_key_modifier",
+		.data           =3D &rclick_key_modifier,
+		.maxlen         =3D sizeof(int),
+                .mode           =3D 0644,
+		.proc_handler   =3D &proc_dointvec,
+	},
 	{ .ctl_name =3D 0 }
 };
=20
@@ -98,6 +108,15 @@
 			}
 			mouse_last_keycode =3D down ? keycode : 0;
 		}
+		if (rclick_key_modifier=20
+		    && keycode =3D=3D rclick_key_modifier)
+			rclick_key_modifier_down =3D down;
+
+		break;
+	case 2:
+		/* Called from input.c */
+		if (keycode =3D=3D BTN_LEFT && rclick_key_modifier && =
rclick_key_modifier_down)
+			return 1;
 		break;
 	}
 	return 0;
--- linuxppc-2.5-benh/include/linux/sysctl.h.orig	Mon Oct 13 23:05:33 =
2003
+++ linuxppc-2.5-benh/include/linux/sysctl.h	Mon Oct 13 23:05:40 2003
@@ -681,7 +681,8 @@
 	DEV_MAC_HID_MOUSE_BUTTON_EMULATION=3D3,
 	DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE=3D4,
 	DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE=3D5,
-	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=3D6
+	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=3D6,
+	DEV_MAC_HID_RCLICK_KEY_MODIFIER=3D7
 };
=20
 /* /proc/sys/dev/scsi */
--- linuxppc-2.5-benh/arch/ppc/Kconfig.orig	Mon Oct 13 23:05:00 2003
+++ linuxppc-2.5-benh/arch/ppc/Kconfig	Mon Oct 13 23:05:40 2003
@@ -1243,6 +1243,11 @@
 	  /proc/sys/dev/mac_hid/mouse_button_emulation
 	  /proc/sys/dev/mac_hid/mouse_button2_keycode
 	  /proc/sys/dev/mac_hid/mouse_button3_keycode
+	  /proc/sys/dev/mac_hid/rclick_key_modifier
+
+	  rclick_key_modifier allows the kernel to handle "Key+LClick" as a=20
+	  right-click. It's disabled by default. Echo a keycode to it to=20
+	  enable it.
=20
 	  If you have an Apple machine with a 1-button mouse, say Y here.
=20
--- linuxppc-2.5-benh/arch/m68k/Kconfig.orig	Mon Oct 13 23:05:18 2003
+++ linuxppc-2.5-benh/arch/m68k/Kconfig	Mon Oct 13 23:05:40 2003
@@ -932,6 +932,11 @@
 	  /proc/sys/dev/mac_hid/mouse_button_emulation
 	  /proc/sys/dev/mac_hid/mouse_button2_keycode
 	  /proc/sys/dev/mac_hid/mouse_button3_keycode
+ 	  /proc/sys/dev/mac_hid/rclick_key_modifier
+=20
+	  rclick_key_modifier allows the kernel to handle "Key+LClick" as a=20
+	  right-click. It's disabled by default. Echo a keycode to it to=20
+	  enable it.
=20
 config ADB_KEYBOARD
 	bool "Support for ADB keyboard (old driver)"

------=_NextPart_000_02C9_01C39242.A0379580--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
