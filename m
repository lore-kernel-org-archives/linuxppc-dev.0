Date: Sun, 9 Jan 2000 20:42:45 +0100
From: Olaf Hering <olh@suse.de>
To: BenH <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] MacAlly 2-buttons mouse support for 2.2.14
Message-ID: <20000109204245.C17984@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <3874E746.9100F6AA@denise.shiny.it> <20000108155610.003478@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000108155610.003478@192.168.1.10>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jan 08, BenH wrote:

> On Thu, Jan 6, 2000, Giuliano Pochini <pochini@denise.shiny.it> wrote:
> 
> >Does anyone read my msgs ?? I posted these ones for ages but they still are
> >not been included into official kernels...
> 
> They look clean. I'll add them to my test kernels in order to get some
> feedback. If they seem to work fine, they'll end up in the main tree.

We have also a nice mouse patch :-)

cat zzz_onebutton_mouse.dif :

diff -urN linux/drivers/char/adbmouse.c linux-2.2.14pre14.SuSE.ppc/drivers/char/adbmouse.c
--- linux/drivers/char/adbmouse.c	Thu Apr 29 21:53:48 1999
+++ linux-2.2.14pre14.SuSE.ppc/drivers/char/adbmouse.c	Sat Dec 18 02:01:45 1999
@@ -50,6 +50,10 @@
 extern int adb_button2_keycode;
 extern int adb_button3_keycode;
 
+extern unsigned char onebutton_keycode;
+extern unsigned char onebutton_upflag;
+extern unsigned char onebutton_clicked;
+
 extern int console_loglevel;
 
 /*
@@ -193,6 +197,17 @@
     dx = mouse.dx;
     dy = mouse.dy;
     buttons = mouse.buttons;
+ 
+    if (buttons == 3) {
+        if (onebutton_keycode == 55)
+            buttons = 5;
+        else if (onebutton_keycode == 54)
+            buttons = 6;
+        if (onebutton_upflag)
+		onebutton_keycode = 0;
+	onebutton_clicked = 1;
+    }                                                       
+
     if (dx > 127)
 	dx = 127;
     else if (dx < -128)
diff -urN linux/drivers/char/keyboard.c linux-2.2.14pre14.SuSE.ppc/drivers/char/keyboard.c
--- linux/drivers/char/keyboard.c	Mon Aug  9 21:05:01 1999
+++ linux-2.2.14pre14.SuSE.ppc/drivers/char/keyboard.c	Sat Dec 18 01:43:26 1999
@@ -62,6 +62,9 @@
 #endif
 
 EXPORT_SYMBOL(handle_scancode);
+unsigned char onebutton_keycode = 0;
+unsigned char onebutton_upflag  = 1;
+unsigned char onebutton_clicked = 0;
 
 extern void ctrl_alt_del(void);
 
@@ -240,8 +243,14 @@
 		rep = 0;
 		if(!test_and_clear_bit(keycode, key_down))
 		    up_flag = kbd_unexpected_up(keycode);
-	} else
+	        if (onebutton_clicked)
+			onebutton_keycode = 0;
+	} else {
 		rep = test_and_set_bit(keycode, key_down);
+		onebutton_keycode = keycode;
+		onebutton_clicked = 0;
+	}
+	onebutton_upflag = up_flag;
 
 #ifdef CONFIG_MAGIC_SYSRQ		/* Handle the SysRq Hack */
 	if (keycode == SYSRQ_KEY) {
diff -urN linux/drivers/usb/mouse.c linux-2.2.14pre14.SuSE.ppc/drivers/usb/mouse.c
--- linux/drivers/usb/mouse.c	Sat Dec 18 02:14:43 1999
+++ linux-2.2.14pre14.SuSE.ppc/drivers/usb/mouse.c	Sat Dec 18 01:45:36 1999
@@ -40,6 +40,10 @@
 
 #include <asm/spinlock.h>
 
+extern unsigned char onebutton_keycode;
+extern unsigned char onebutton_upflag;
+extern unsigned char onebutton_clicked;                                         
+
 #include "usb.h"
 
 #define USB_MOUSE_MINOR 32
@@ -188,6 +192,16 @@
 				buttons |= 0x10;
 			if (mouse->dy < 0)
 				buttons |= 0x20;
+			if (buttons == 1) {
+				if (onebutton_keycode == 54)
+					buttons = 2;
+				else if (onebutton_keycode == 55)
+					buttons = 4;
+				onebutton_keycode = 0;
+				if (onebutton_upflag)
+					onebutton_keycode = 0;
+				onebutton_clicked = 1;
+			}
 			put_user(buttons, buffer);
 			buffer++;
 			retval++;



Right mouse button is CMND , middle mouse button is CTRL.
Would be nice to get some feedback. 


Gruss Olaf

-- 
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
