Message-ID: <3874E746.9100F6AA@denise.shiny.it>
Date: Thu, 06 Jan 2000 20:04:38 +0100
From: Giuliano Pochini <pochini@denise.shiny.it>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [patch] MacAlly 2-buttons mouse support for 2.2.14
Content-Type: multipart/mixed;
 boundary="------------CB37F5A79B94B6F1EF313B85"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------CB37F5A79B94B6F1EF313B85
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Does anyone read my msgs ?? I posted these ones for ages but they still are
not been included into official kernels...

Bye.
--------------CB37F5A79B94B6F1EF313B85
Content-Type: text/plain; charset=us-ascii;
 name="Mousepatch"
Content-Disposition: inline;
 filename="Mousepatch"
Content-Transfer-Encoding: 7bit

--- drivers/macintosh/mac_keyb.old	Thu Jan  6 18:07:49 2000
+++ drivers/macintosh/mac_keyb.c	Thu Jan  6 19:35:47 2000
@@ -24,6 +24,7 @@
  * - Hunter digital (NoHandsMouse)
  * - Kensignton TurboMouse 5 (needs testing)
  * - Mouse Systems A3 mice and trackballs <aidan@kublai.com>
+ * - MacAlly 2-buttons mouse (needs testing) <pochini@denise.shiny.it>
  *
  * To do:
  *
@@ -272,6 +273,7 @@
 #define ADBMOUSE_MICROSPEED	6	/* Microspeed mouse (&trackball ?), MacPoint */
 #define ADBMOUSE_TRACKBALLPRO	7	/* Trackball Pro (special buttons) */
 #define ADBMOUSE_MS_A3		8	/* Mouse systems A3 trackball (handler 3) */
+#define ADBMOUSE_MACALLY2	9	/* MacAlly 2-button mouse */
 
 static int adb_mouse_kinds[16];
 
@@ -490,6 +492,18 @@
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
 
@@ -521,6 +535,11 @@
 		data[2] = (data[2] & 0x7f) | ((data[3] & 0x02) << 6);
 		data[3] = ((data[3] & 0x04) << 5);
 		break;
+            case ADBMOUSE_MACALLY2:
+		data[3] = (data[2] & 0x80) ? 0x80 : 0x00;
+		data[2] |= 0x80;	/* Right button is mapped as button 3 */
+		nb=4;
+                break;
 	}
 
 	if (adb_mouse_interrupt_hook)
@@ -825,6 +844,14 @@
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


--------------CB37F5A79B94B6F1EF313B85--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
