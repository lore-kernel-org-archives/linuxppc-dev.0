Return-Path: <aio@nocrew.org>
Received: from junk.nocrew.org (junk.nocrew.org [213.242.147.30])
	by ozlabs.org (Postfix) with ESMTP id BF12567A97
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Jan 2005 11:37:06 +1100 (EST)
Received: from localhost ([127.0.0.1] ident=aio)
	by junk.nocrew.org with esmtp (Exim 3.35 #1 (Debian))
	for linuxppc-dev@ozlabs.org
	id 1Ctand-0000hP-00; Wed, 26 Jan 2005 01:12:45 +0100
Date: Wed, 26 Jan 2005 01:12:56 +0100 (CET)
From: Joakim Karlsson <aio@nocrew.org>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.58.0501260109220.2914@jadzia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] Extended keyboard+mouse emulation
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everyone!

This is my first patch ever, so I hope I'm doing this right. In short,
this patch allows standard usage of the mouse button emulation in the
mac_hid. It extends the functionality to a combination of a key and mouse
button, retaining full compatibility. Project site:
http://aio.nocrew.org/projects/pbmousehack/

I have successfully tested it on 2.6.9 and 2.6.10.

Regards, Joakim Karlsson <aio@nocrew.org>

diff -urN linux-2.6.9.old/drivers/input/mousedev.c linux-2.6.9.new/drivers/input/mousedev.c
--- linux-2.6.9.old/drivers/input/mousedev.c	2004-10-18 23:55:07.000000000 +0200
+++ linux-2.6.9.new/drivers/input/mousedev.c	2004-12-14 01:11:48.644153752 +0100
@@ -168,6 +168,11 @@
 	}
 }

+#ifdef CONFIG_MAC_EMUMOUSEBTN
+extern int mac_hid_mouse_emulate_buttons(int, int, int);
+extern int mac_hid_get_mouse_combination(int);
+#endif /* CONFIG_MAC_EMUMOUSEBTN */
+
 static void mousedev_key_event(struct mousedev *mousedev, unsigned int code, int value)
 {
 	int index;
@@ -192,9 +197,17 @@
 	}

 	if (value) {
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+	        if (index == 0)
+	                index += mac_hid_get_mouse_combination(1);
+#endif /* CONFIG_MAC_EMUMOUSEBTN */
 		set_bit(index, &mousedev->packet.buttons);
 		set_bit(index, &mousedev_mix.packet.buttons);
 	} else {
+#ifdef CONFIG_MAC_EMUMOUSEBTN
+	        if (index == 0)
+		        index += mac_hid_get_mouse_combination(0);
+#endif /* CONFIG_MAC_EMUMOUSEBTN */
 		clear_bit(index, &mousedev->packet.buttons);
 		clear_bit(index, &mousedev_mix.packet.buttons);
 	}
diff -urN linux-2.6.9.old/drivers/macintosh/mac_hid.c linux-2.6.9.new/drivers/macintosh/mac_hid.c
--- linux-2.6.9.old/drivers/macintosh/mac_hid.c	2004-10-18 23:54:55.000000000 +0200
+++ linux-2.6.9.new/drivers/macintosh/mac_hid.c	2004-12-14 01:12:11.998603336 +0100
@@ -15,10 +15,10 @@
 #include <linux/input.h>
 #include <linux/module.h>

-
 static struct input_dev emumousebtn;
 static void emumousebtn_input_register(void);
 static int mouse_emulate_buttons = 0;
+static int mouse_combine_buttons = 0;
 static int mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
 static int mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
 static int mouse_last_keycode = 0;
@@ -35,6 +35,14 @@
 		.proc_handler	= &proc_dointvec,
 	},
 	{
+		.ctl_name	= DEV_MAC_HID_MOUSE_BUTTON_COMBINATION,
+		.procname	= "mouse_combine_emulation",
+		.data		= &mouse_combine_buttons,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
 		.ctl_name	= DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE,
 		.procname	= "mouse_button2_keycode",
 		.data		= &mouse_button2_keycode,
@@ -81,12 +89,37 @@

 #endif /* endif CONFIG_SYSCTL */

+int mac_hid_get_mouse_combination(int set)
+{
+  static int button = 0;
+  int retval = 0;
+
+  if (set == 1) {
+    button = mouse_last_keycode;
+    if (button == mouse_button2_keycode)
+      retval = 1;
+    else if (button == mouse_button3_keycode)
+      retval = 2;
+    else
+      retval = 0;
+  } else {
+    if (button == mouse_button2_keycode)
+      retval = 1;
+    else if (button == mouse_button3_keycode)
+      retval = 2;
+    else
+      retval = 0;
+    button = 0;
+  }
+  return retval;
+}
+
 int mac_hid_mouse_emulate_buttons(int caller, unsigned int keycode, int down)
 {
 	switch (caller) {
 	case 1:
 		/* Called from keyboard.c */
-		if (mouse_emulate_buttons
+		if (mouse_emulate_buttons && !mouse_combine_buttons
 		    && (keycode == mouse_button2_keycode
 			|| keycode == mouse_button3_keycode)) {
 			if (mouse_emulate_buttons == 1) {
@@ -98,6 +131,12 @@
 			}
 			mouse_last_keycode = down ? keycode : 0;
 		}
+		if (mouse_combine_buttons
+		    && (keycode == mouse_button2_keycode
+			|| keycode == mouse_button3_keycode)) {
+			mouse_last_keycode = down ? keycode : 0;
+		        return 0;
+		}
 		break;
 	}
 	return 0;
diff -urN linux-2.6.9.old/include/linux/sysctl.h linux-2.6.9.new/include/linux/sysctl.h
--- linux-2.6.9.old/include/linux/sysctl.h	2004-10-18 23:54:31.000000000 +0200
+++ linux-2.6.9.new/include/linux/sysctl.h	2004-12-14 01:13:44.179589696 +0100
@@ -747,7 +747,8 @@
 	DEV_MAC_HID_MOUSE_BUTTON_EMULATION=3,
 	DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE=4,
 	DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE=5,
-	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6
+	DEV_MAC_HID_ADB_MOUSE_SENDS_KEYCODES=6,
+	DEV_MAC_HID_MOUSE_BUTTON_COMBINATION=8
 };

 /* /proc/sys/dev/scsi */
