Message-ID: <38165935.A73FB5BF@wanadoo.fr>
Date: Wed, 27 Oct 1999 03:45:26 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Missing USB keys (Was Re: Problems compiling ppc kernels.)
References: <199910262141.XAA06091@bogomips.masq.in-berlin.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Gerd Knorr wrote:

> I got 2.3.23 sorta working on my iMac (rev B).  "grep ^C .config" is attached
> at the end of this mail.  There are alot of gliches:
[...]
>   * usb keyboard needs a (trivial) patch, see below.
>   * usb keyboard works only if ADB_KEYBOARD is compiled in too.
>   * I have a few keys which don't work at all because they are
>     not mapped by usb_kbd_map (that's why the debug printk in the
>     patch).

Gerd,

I suppose you have a German keyboard. Having had the same problem of
missing keys on a French USB keyboard, I dug into this USB->ADB keycode
translation stuff, and I think I understand some of it now. As I see it,
this part of the kernel sources is a pretty ugly hack, but it is
"official linux", so it is here to stay, and the following explanation
(possibly improved by someone more knowledgeable) will have to go into
some kind of FAQ (unless the kernel sources were patched accordingly):

1. The keycodes produced by a USB keyboard are first translated by the
kernel into the corresponding keycodes of an ADB keyboard. This has the
advantage that (even for for German, French etc keyboards) one can use
the same keymaps in /usr/lib/kbd/ and in /usr/lib/X11/xkb/ for USB
keyboards as for ADB keyboards, and one can use an ADB keyboard at the
same time as a USB keyboard. At least in principle...

2. This translation is done using the array usb_kbd_map which is defined
in the file drivers/usb/keymap-mac.c (for Mac keyboards, i.e. if
CONFIG_ADB_KEYBOARD is defined). In this array, undefined keys are
translated into keycode 0x00, so it would suffice to patch this file and
to write the correct ADB keycodes into the right places, except that...

3. The file drivers/usb/keymap-mac.c is a generated file which is made
during kernel compilation by the shell script drivers/usb/mkmap.adb.
This script uses two keymaps living in drivers/usb/maps/, namely usb.map
and mac.map and figures out how to translate between these two. The
mac.map is a standard ADB keymap, but to understand usb.map, one has to
recall some historical facts:

4. There exist two completely different USB drivers, namely UUSB which
was in use for example in the 2.2.6 kernel, and the newer USB which is
used from 2.2.10 onwards. In the UUSB system, one needed special USB
keymaps, because there the USB keycodes are directly translated into key
symbols, and there is no intermediate ADB keycode step. The usb.map in
drivers/usb/maps/ is such a keymap (used, however, within the new USB
system).

5. Thus the keycode translation in the new USB driver is a hack on top
of the old UUSB driver; the USB keycodes are in a sense first translated
into symbols via an old UUSB keymap and then retranslated into ADB
keycodes via an ADB keymap.

6. So where is the problem? The problem, of course, is that the two
keymaps in drivers/usb/maps/ which are used to produce the translation
table, are goddamn^H^H^H^H^H^H^Hstandard US keymaps. Therefore some of
the keys of European Apple Extended keyboards are missing (maybe just
one or two?). The right solution is therefore to add the missing keys in
both keymaps, which is what I did, see the patch below. Another (not so
universal) solution would be to replace both US keymaps by equivalent
French ones. Or German ones, of course, but I suspect this would produce
an identical usb_kbd_map translation table.

My patch for French USB keyboards is the following (the important part
is the "at numersign" stuff, the "KP_Equals" business is something I
don't quite understand, it might be related to weird mouse button
emulations). The patch is against the 2.3.18 vger kernel, but I think
any 2.3.x kernel should work similarly. And I would bet 2 Pfennig that
this patch makes the German keyboard work as well.

===================================================================
RCS file: /cvs/linux/linux/drivers/usb/maps/mac.map,v
retrieving revision 1.1
diff -u -r1.1 mac.map
--- drivers/usb/maps/mac.map    1999/06/09 08:20:17     1.1
+++ drivers/usb/maps/mac.map    1999/10/26 17:34:41
@@ -22,7 +22,7 @@
 keycode 0x08 = c
        altgr   keycode 0x08 = Hex_C   
 keycode 0x09 = v
-keycode 0x0a =
+keycode 0x0a = at numbersign
 keycode 0x0b = b
        altgr   keycode 0x0b = Hex_B
 keycode 0x0c = q               
@@ -144,7 +144,7 @@
 keycode 0x4f =
 keycode 0x50 =
 keycode 0x51 =
-#keycode 0x51 = KP_Equals
+keycode 0x51 = KP_Equals
 keycode 0x52 = KP_0            
        alt     keycode 0x52 = Ascii_0         
        altgr   keycode 0x52 = Hex_0         
Index: drivers/usb/maps/usb.map
===================================================================
RCS file: /cvs/linux/linux/drivers/usb/maps/usb.map,v
retrieving revision 1.1
diff -u -r1.1 usb.map
--- drivers/usb/maps/usb.map    1999/04/28 11:52:38     1.1
+++ drivers/usb/maps/usb.map    1999/10/26 17:34:42
@@ -88,7 +88,7 @@
 keycode  49 = backslash        bar             
        control keycode  43 = Control_backslash
        alt     keycode  43 = Meta_backslash  
-keycode 50 =
+keycode  50 = backslash        bar
 keycode  51 = semicolon        colon           
        alt     keycode  39 = Meta_semicolon  
 keycode  52 = apostrophe       quotedbl        
@@ -215,10 +215,10 @@
 keycode  99 = KP_Period       
 #      altgr   control keycode  83 = Boot            
        control alt     keycode  83 = Boot            
-keycode 100 =
+keycode 100 = at  numbersign
 keycode 101 = Application
 keycode 102 =
-keycode 103 =
+keycode 103 = KP_Equals
 keycode 104 = F13             
 keycode 105 = F14             

===================================================================

Have fun
--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
