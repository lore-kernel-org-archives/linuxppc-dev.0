Date: Fri, 17 Oct 2003 12:44:31 +0200
From: Colin Leroy <colin@colino.net>
To: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] Right-click modifier
Message-Id: <20031017124431.76c63243.colin@colino.net>
In-Reply-To: <20031013231820.45fb75b8.colin@colino.net>
References: <20031013231820.45fb75b8.colin@colino.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__17_Oct_2003_12:44:31_+0200_110544f0"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart_Fri__17_Oct_2003_12:44:31_+0200_110544f0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 13 Oct 2003 at 23h18, Colin Leroy wrote:

Hi,

> this patch adds an entry in /proc,
> /proc/sys/dev/mac_hid/rclick_key_modifier.

Here's the backport to linux-2.4.18. (this one to apply with -p0)

hth,
--
Colin
  top - 01:44:29 up 5 min,  2 users,  load average: 411.07, 114.57, 39.44

--Multipart_Fri__17_Oct_2003_12:44:31_+0200_110544f0
Content-Type: text/plain;
 name="rclick_key_modifier-2.4.18.patch"
Content-Disposition: attachment;
 filename="rclick_key_modifier-2.4.18.patch"
Content-Transfer-Encoding: 7bit

--- drivers/input/input.c.orig	Fri Oct 17 12:34:14 2003
+++ drivers/input/input.c	Fri Oct 17 12:39:34 2003
@@ -60,6 +60,10 @@
 static int input_number;
 static long input_devices[NBITS(INPUT_DEVICES)];

+#ifdef CONFIG_MAC_EMUMOUSEBTN
+extern int mac_hid_mouse_emulate_buttons(int,int,int);
+#endif
+
 void input_event(struct input_dev *dev, unsigned int type, unsigned int code, int value)
 {
 	struct input_handle *handle = dev->handle;
@@ -74,7 +78,10 @@
 	switch (type) {

 		case EV_KEY:
-
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+			if (mac_hid_mouse_emulate_buttons(3, code, value))
+				code = BTN_RIGHT;
+#endif
 			if (code > KEY_MAX || !test_bit(code, dev->keybit) || !!test_bit(code, dev->key) == value)
 				return;

--- drivers/macintosh/mac_hid.c.orig	Fri Oct 17 12:35:01 2003
+++ drivers/macintosh/mac_hid.c	Fri Oct 17 12:37:32 2003
@@ -221,7 +221,9 @@
 static int mouse_emulate_buttons = 0;
 static int mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
 static int mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
+static int rclick_key_modifier   = 0;			/* disabled */
 static int mouse_last_keycode = 0;
+static int rclick_key_modifier_down = 0;
 #endif

 extern void pckbd_init_hw(void);
@@ -258,6 +260,10 @@
     "mouse_button3_keycode", &mouse_button3_keycode, sizeof(int),
     0644, NULL, &proc_dointvec
   },
+    DEV_MAC_HID_RCLICK_KEY_MODIFIER,
+    "rclick_key_modifier", &rclick_key_modifier, sizeof(int),
+    0644, NULL, &proc_dointvec
+  },
 #endif
   { 0 }
 };
@@ -437,6 +443,9 @@
 			}
 			mouse_last_keycode = down ? keycode : 0;
 		}
+		if (rclick_key_modifier
+		    && keycode == rclick_key_modifier)
+			rclick_key_modifier_down = down;
 		break;
 	case 2:
 		/* Called from mousedev.c */
@@ -447,6 +456,10 @@
 				return 2; /* map to right button */
 		}
 		return keycode; /* keep button */
+	case 3:
+		/* Called from input.c */
+		if (keycode == BTN_LEFT && rclick_key_modifier && rclick_key_modifier_down)
+			return 1;
 	}
 	return 0;
 }
--- include/linux/sysctl.h.orig	Fri Oct 17 12:37:51 2003
+++ include/linux/sysctl.h	Fri Oct 17 12:38:09 2003
@@ -611,7 +611,8 @@
 	DEV_MAC_HID_MOUSE_BUTTON_EMULATION=3,
 	DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE=4,
 	DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE=5,
-	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6
+	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6,
+	DEV_MAC_HID_RCLICK_KEY_MODIFIER=7
 };

 /* /proc/sys/abi */

--Multipart_Fri__17_Oct_2003_12:44:31_+0200_110544f0--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
