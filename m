Date: Thu, 14 Oct 1999 13:27:20 -0400
From: "Peter A. Padilla" <p.a.padilla@larc.nasa.gov>
To: linuxppc-dev@lists.linuxppc.org
Subject: Macally patch (oops)
Message-ID: <19991014132720.A2573@goog.larc.nasa.gov>
Reply-To: "Peter A. Padilla" <p.a.padilla@larc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Here is the patch in the right format:

--- mac_keyb.c.orig	Thu Apr 29 15:53:48 1999
+++ mac_keyb.c	Thu Oct 14 10:58:16 1999
@@ -268,6 +268,7 @@
 #define ADBMOUSE_TURBOMOUSE5    5	/* Turbomouse 5 (previously req. mousehack) */
 #define ADBMOUSE_MICROSPEED	6	/* Microspeed mouse (&trackball ?), MacPoint */
 #define ADBMOUSE_TRACKBALLPRO	7	/* Trackball Pro (special buttons) */
+#define ADBMOUSE_MACALLY	8	/* Macally mouse  */
 
 static int adb_mouse_kinds[16];
 
@@ -512,6 +513,14 @@
 		data[2] = (data[2] & 0x7f) | ((data[3] & 0x01) << 7);
 		data[3] = (data[3] & 0x77) | ((data[3] & 0x02) << 6);
 		break;
+	   case ADBMOUSE_MACALLY:
+		/* Emulate third button, use xmodmap to assign */
+		data[3] = (data[1] & 0x80) | (data[2] & 0x80) | 0x08;
+		if ((data[3] & 0x80) == 0x00) {
+		  data[2] = (data[2] & 0x7f) | 0x80;
+		  data[1] = (data[1] & 0x7f) | 0x80;
+		}
+		break; 
 	}
 
 	if (adb_mouse_interrupt_hook)
@@ -751,31 +760,41 @@
 
 	/* Try to switch all mice to handler 4, or 2 for three-button
 	   mode and full resolution. */
+	/* Changed the order from the specific to more general, also
+	 * added new code for Macally mouse and, in order for the second
+	 * button to be enabled it needs to be set to handler 66 (0x42)
+	 * but it won't accept that handler unless it has been set to
+	 * handler 4 first. */
 	for (i = 0; i < mouse_ids.nids; i++) {
 		int id = mouse_ids.id[i];
-		if (adb_try_handler_change(id, 4)) {
-			printk("ADB mouse at %d, handler set to 4", id);
-			adb_mouse_kinds[id] = ADBMOUSE_EXTENDED;
-		}
-		else if (adb_try_handler_change(id, 2)) {
-			printk("ADB mouse at %d, handler set to 2", id);
-			adb_mouse_kinds[id] = ADBMOUSE_STANDARD_200;
+		if (adb_try_handler_change(id, 0x5F)) {
+			printk("ADB mouse at %d, handler set to 0x5F", id);
+			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
 		}
 		else if (adb_try_handler_change(id, 0x2F)) {
 			printk("ADB mouse at %d, handler set to 0x2F", id);
 			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
 		}
+		else if (adb_try_handler_change(id, 0x66)) {
+			printk("ADB mouse at %d, handler set to 0x66", id);
+			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
+		}
 		else if (adb_try_handler_change(id, 0x42)) {
 			printk("ADB mouse at %d, handler set to 0x42", id);
 			adb_mouse_kinds[id] = ADBMOUSE_TRACKBALLPRO;
 		}
-		else if (adb_try_handler_change(id, 0x66)) {
-			printk("ADB mouse at %d, handler set to 0x66", id);
-			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
+		else if (adb_try_handler_change(id, 4) &&
+		         adb_try_handler_change(id, 0x42)) {
+			printk("ADB mouse at %d, handler set to 0x42", id);
+			adb_mouse_kinds[id] = ADBMOUSE_MACALLY;
 		}
-		else if (adb_try_handler_change(id, 0x5F)) {
-			printk("ADB mouse at %d, handler set to 0x5F", id);
-			adb_mouse_kinds[id] = ADBMOUSE_MICROSPEED;
+		else if (adb_try_handler_change(id, 4)) {
+			printk("ADB mouse at %d, handler set to 4", id);
+			adb_mouse_kinds[id] = ADBMOUSE_EXTENDED;
+		}
+   		else if (adb_try_handler_change(id, 2)) {
+			printk("ADB mouse at %d, handler set to 2", id);
+			adb_mouse_kinds[id] = ADBMOUSE_STANDARD_200;
 		}
 		else {
 			printk("ADB mouse at %d, handler 1", id);

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
