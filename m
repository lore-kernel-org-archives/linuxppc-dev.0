Message-ID: <37A68EC1.BDE6FF5F@cable.a2000.nl>
Date: Tue, 03 Aug 1999 08:40:01 +0200
From: Otto Moerbeek <otto@cable.a2000.nl>
MIME-Version: 1.0
To: linuxppc-dev-digest@lists.linuxppc.org
CC: otto@cable.a2000.nl
Subject: 2.2.10 kernel and Apple USB ISO keyboards
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I tried the 2.2.10 kernel, following Robert Shaws advice on
<http://www.inficad.com/~rshaw/>. It seems like we are really moving 
towards a compile out of the box for the Blue G3's!

But I had some problems: my Apple ISO USB keyboard refused to work 
properly: the backquote/tilde, backslash/bar and keypad equals keys 
did not work. I traced the problem down the way the USB keyboard 
driver works and made a patch. I tested this patch only on my Dutch
keyboard, but as far as I know the ISO keyboards only different 
in the key labeling, and the patch should not hurt ANSI (US) 
keyboards. See below for the patch. Please note that this patch should
be applied after the 2.2.10 pmac patch, that can be found on the above
mentioned page.

I also have another problem: I have a single button standard Apple USB
mouse. Using the 2.2.6 kernel the clear and keypad equal keys were
mapped to mouse button 2 and 3. This is not done anymore by the new USB
driver in 2.2.10. The 2.2.6 UUSB driver does this translation at a
really low level, so no mapping in the X server is needed. As this seems
rather a dirty trick, I prefer to resolve this problem in the X server. 
It seems however that only the Xpmac server has the feature to map key 
events to button events, not the others like XF86_FBDev, the one I am 
using now. Any ideas on this?

Regards,
Otto


--- linux-2.2.10/drivers/usb/keymap-mac.c       Mon Aug  2 18:20:03 1999
+++ linux-2.2.10-otto/drivers/usb/keymap-mac.c  Tue Aug  3 05:45:57 1999
@@ -1,3 +1,23 @@
+/*
+ * History:
+ * - Tue Aug  3 1999
+ *   Changes made by Otto Moerbeek <otto@cable.a2000.nl> to properly
+ *   handle the Apple ISO Mac USB keyboard, that has a slightly different
+ *   layout and an extra key as compared to the ANSI (US) USB keyboard:
+ *
+ *   The following entrie were changed:
+ * 
+ *   - entry 0x32 from 0x00 to to 0x2a (backslash/bar)
+ *   - entry 0x64 from 0x00 to 0x32 to (backquote/tilde)
+ *   - entry 0x67 from 0x00 to 0x51 (KP_Equal in X11, no PC equivalent 
+ *     known to me, set it to 0x51, which is unused as far as I know) 
+ * 
+ *   Known problem: both the paragraph/plusminus key and the
+ *   backquote/tilde key are mapped to the same keycode. This cannot
+ *   be changed without breaking the keymappings for ANSI keyboards.
+ * 
+ */
+
 unsigned char usb_kbd_map[256] = 
 {
     0x00,  0x00,  0x00,  0x00,  0x80,  0x0b,  0x08,  0x02,
@@ -9,7 +29,7 @@
     0x14,  0x15,  0x17,  0x16,  0x1a,  0x1c,  0x19,  0x1d,
     0x24,  0x35,  0x33,  0x30,  0x31,  0x1b,  0x18,  0x21,
 
-    0x1e,  0x2a,  0x00,  0x29,  0x27,  0x32,  0x2b,  0x2f,
+    0x1e,  0x2a,  0x2a,  0x29,  0x27,  0x32,  0x2b,  0x2f,
     0x2c,  0x39,  0x7a,  0x78,  0x63,  0x76,  0x60,  0x61,
 
     0x62,  0x64,  0x65,  0x6d,  0x67,  0x6f,  0x69,  0x6b,
@@ -18,7 +38,7 @@
     0x3b,  0x3d,  0x3e,  0x47,  0x4b,  0x43,  0x4e,  0x45,
     0x4c,  0x53,  0x54,  0x55,  0x56,  0x57,  0x58,  0x59,
 
-    0x5b,  0x5c,  0x52,  0x41,  0x00,  0x00,  0x00,  0x00,
+    0x5b,  0x5c,  0x52,  0x41,  0x32,  0x00,  0x00,  0x51,
     0x69,  0x6b,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,
 
     0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,  0x00,

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
