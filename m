Message-ID: <3820AA1F.AC7D84D@denise.shiny.it>
Date: Wed, 03 Nov 1999 22:33:19 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] Macally 2-button mouse support
Content-Type: multipart/mixed;
 boundary="------------34E688A8C00EA6F450885127"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------34E688A8C00EA6F450885127
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


This patch adds support for that mouse. The code is tested only by me. I
didn't get any infos from Macally (GRRR!) so I don't know if the values I use
to identify the mouse are the same for all M2BM mouses on the market.

Bye.
--------------34E688A8C00EA6F450885127
Content-Type: text/plain; charset=us-ascii;
 name="mouse.patch.2.2.13"
Content-Disposition: inline;
 filename="mouse.patch.2.2.13"
Content-Transfer-Encoding: 7bit

--- drivers/macintosh/mac_keyb.old	Fri Aug 27 23:44:58 1999
+++ drivers/macintosh/mac_keyb.c	Sat Aug 28 00:02:23 1999
@@ -272,6 +272,7 @@
 #define ADBMOUSE_MICROSPEED	6	/* Microspeed mouse (&trackball ?), MacPoint */
 #define ADBMOUSE_TRACKBALLPRO	7	/* Trackball Pro (special buttons) */
 #define ADBMOUSE_MS_A3		8	/* Mouse systems A3 trackball (handler 3) */
+#define ADBMOUSE_MACALLY2	9	/* MacAlly 2-button mouse */
 
 static int adb_mouse_kinds[16];
 
@@ -490,6 +491,18 @@
     data[3] = byyy bxxx Third button and fourth button.  Y is additional
 	      high bits of y-axis motion.  XY is additional
 	      high bits of x-axis motion.
+
+    MacAlly 2-button mouse protocol.
+
+    For MacAlly 2-button mouse protocol the data array will contain the
+    following values:
+
+		BITS    COMMENTS
+    data[0] = dddd 1100 ADB command: Talk, register 0, for device dddd.
+    data[1] = bxxx xxxx Left button and x-axis motion.
+    data[2] = byyy yyyy Right button and y-axis motion.
+    data[3] = ???? ???? unknown
+    data[4] = ???? ???? unknown
   */
 	struct kbd_struct *kbd;
 
@@ -521,6 +534,11 @@
 		data[2] = (data[2] & 0x7f) | ((data[3] & 0x02) << 6);
 		data[3] = ((data[3] & 0x04) << 5);
 		break;
+            case ADBMOUSE_MACALLY2:
+		data[3] = (data[2] & 0x80) ? 0x80 : 0x00;
+		data[2] |= 0x80;	/* 2nd button is mapped as button 3 */
+		nb=4;
+                break;
 	}
 
 	if (adb_mouse_interrupt_hook)
@@ -825,6 +843,14 @@
 			    (req.reply[1] == 0x4b) && (req.reply[2] == 0x4d) &&
 			    (req.reply[3] == 0x4c) && (req.reply[4] == 0x31))
 				init_turbomouse(id);
+			else if ((req.reply_len == 9) &&
+			    (req.reply[1] == 0x4b) && (req.reply[2] == 0x4f) &&
+			    (req.reply[3] == 0x49) && (req.reply[4] == 0x54)){
+				if (adb_try_handler_change(id, 0x42)) {
+					printk("\nADB MacAlly 2-button mouse at %d, handler set to 0x42", id);
+					adb_mouse_kinds[id] = ADBMOUSE_MACALLY2;
+				}
+			}
 		}
 		printk("\n");
         }

--------------34E688A8C00EA6F450885127--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
