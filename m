Date: Sun, 18 Jul 1999 14:49:49 -0400
From: Aidan Cully <aidan@kublai.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH]: Support for Mouse Systems A3 protocol mice
Message-ID: <19990718144949.A764@xanadu.kublai.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=KsGdsel6WgEHnImy
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii

This patch adds 3-button support for (at least) the Mouse Systems A3
Trackball, and Mac Point Pro products.  I've also changed a bit of how
the button-change logic works, since I think it's allowed for mice to
slip back into the 1-button mouse protocol.  I don't know if that's
entirely appropriate, but both Darwin and NetBSD seem to take that
precaution..

The patch is against kernel 2.2.10.  Hopefully, someone here will know
how to get it integrated into new kernel revisions.

I'm not subscribed to this list, so please CC: any replies to me.
Thanks,
--aidan

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mac_keyb.patch"

--- ../linux/drivers/macintosh/mac_keyb.c	Sun Jul 11 13:38:18 1999
+++ drivers/macintosh/mac_keyb.c	Sat Jul 17 23:07:19 1999
@@ -23,6 +23,7 @@
  * - Contour Design (Contour Mouse)
  * - Hunter digital (NoHandsMouse)
  * - Kensignton TurboMouse 5 (needs testing)
+ * - Mouse Systems A3 3 button mice and trackballs
  *
  * To do:
  *
@@ -239,6 +240,7 @@
 static void init_trackball(int id);
 static void init_turbomouse(int id);
 static void init_microspeed(int id);
+static void init_ms_a3(int id);
 
 #ifdef CONFIG_ADBMOUSE
 /* XXX: Hook for mouse driver */
@@ -268,6 +270,7 @@
 #define ADBMOUSE_TURBOMOUSE5    5	/* Turbomouse 5 (previously req. mousehack) */
 #define ADBMOUSE_MICROSPEED	6	/* Microspeed mouse (&trackball ?), MacPoint */
 #define ADBMOUSE_TRACKBALLPRO	7	/* Trackball Pro (special buttons) */
+#define ADBMOUSE_MS_A3		8	/* Mouse Systems A3 trackball (handler 3) */
 
 static int adb_mouse_kinds[16];
 
@@ -512,6 +515,11 @@
 		data[2] = (data[2] & 0x7f) | ((data[3] & 0x01) << 7);
 		data[3] = (data[3] & 0x77) | ((data[3] & 0x02) << 6);
 		break;
+	    case ADBMOUSE_MS_A3:
+		data[1] = (data[1] & 0x7f) | ((data[3] & 0x01) << 7);
+		data[2] = (data[2] & 0x7f) | ((data[3] & 0x02) << 6);
+		data[3] = ((data[3] & 0x04) << 5);
+		break;
 	}
 
 	if (adb_mouse_interrupt_hook)
@@ -522,7 +530,9 @@
 	/* Only send mouse codes when keyboard is in raw mode. */
 	if (kbd->kbdmode == VC_RAW) {
 		static unsigned char uch_ButtonStateSecond = 0x80;
+		static unsigned char uch_ButtonStateThird = 0x80;
 		unsigned char uchButtonSecond;
+		unsigned char uchButtonThird;
 
 		/* Send first button, second button and movement. */
 		mac_put_queue(0x7e);
@@ -542,17 +552,17 @@
 
 		/* Macintosh 3-button mouse (handler 4). */
 		if (nb >= 4) {
-			static unsigned char uch_ButtonStateThird = 0x80;
-			unsigned char uchButtonThird;
-
 			/* Store the button state for speed. */
 			uchButtonThird = (data[3] & 0x80);
+		} else {
+			/* If we got less than 4 bytes, assume the button is up. */
+			uchButtonThird = 0x80;
+		}
 
-			/* Send third button. */
-			if (uchButtonThird != uch_ButtonStateThird) {
-				mac_put_queue(0x40 | uchButtonThird);
-				uch_ButtonStateThird = uchButtonThird;
-			}
+		/* Send third button. */
+		if (uchButtonThird != uch_ButtonStateThird) {
+			mac_put_queue(0x40 | uchButtonThird);
+			uch_ButtonStateThird = uchButtonThird;
 		}
 	}
 }
@@ -757,6 +767,10 @@
 			printk("ADB mouse at %d, handler set to 4", id);
 			adb_mouse_kinds[id] = ADBMOUSE_EXTENDED;
 		}
+		else if (adb_try_handler_change(id, 3)) {
+			printk("ADB mouse at %d, handler set to 3", id);
+			adb_mouse_kinds[id] = ADBMOUSE_MS_A3;
+		}
 		else if (adb_try_handler_change(id, 2)) {
 			printk("ADB mouse at %d, handler set to 2", id);
 			adb_mouse_kinds[id] = ADBMOUSE_STANDARD_200;
@@ -785,6 +799,8 @@
 		if ((adb_mouse_kinds[id] == ADBMOUSE_TRACKBALLPRO)
 		    || (adb_mouse_kinds[id] == ADBMOUSE_MICROSPEED)) {
 			init_microspeed(id);
+		}  else if (adb_mouse_kinds[id] == ADBMOUSE_MS_A3) {
+			init_ms_a3(id);
 		}  else if (adb_mouse_kinds[id] ==  ADBMOUSE_EXTENDED) {
 			/*
 			 * Register 1 is usually used for device
@@ -974,6 +990,19 @@
 	    0x10,	/* extended protocol, no speed change */
 	    0x07);	/* all buttons enabled as mouse buttons, no locking */
 
+
+	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
+}
+
+static void init_ms_a3(int id)
+{
+	struct adb_request req;
+
+	printk(" (Mouse Systems A3 Mouse, or compatible)");
+	adb_request(&req, NULL, ADBREQ_SYNC, 3,
+	ADB_WRITEREG(id, 0x2),
+	    0x00,
+	    0x07);
 
 	adb_request(&req, NULL, ADBREQ_SYNC, 1, ADB_FLUSH(id));
 }

--KsGdsel6WgEHnImy--

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
