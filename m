Message-Id: <200007292107.WAA04363@hyperion.valhalla.net>
Date: Sat, 29 Jul 2000 22:06:54 +0100
Subject: 2.4.0-test5 observations
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

1.  My build problem was solved by:

--- bk-devel/drivers/input/adbhid.c Sat Jul 29 08:04:54 2000
+++ linux-2.4.0-t5-wrk/drivers/input/adbhid.c Sat Jul 29 17:28:42 2000
@@ -40,9 +40,9 @@
 #include <linux/input.h>
 #include <linux/kbd_ll.h>

-#include <asm/adb.h>
-#include <asm/cuda.h>
-#include <asm/pmu.h>
+#include <linux/adb.h>
+#include <linux/cuda.h>
+#include <linux/pmu.h>
 #include <asm/backlight.h>

 #define KEYB_KEYREG 0 /* register # for key up/down data */


======

This may be related to my so-called "broken" distro re. kernel builds - but
there it is...

========
2. The sound [AWACS rev 3] (at present) exhibits the following behaviour
(built as modules).

The first buffer plays and then.... silence...

I don't know if it's related, but the kernel log is filling up with:

Jul 29 22:50:41 athena VFS: Disk change detected on device ide1(22,0)
Jul 29 22:50:41 athena last message repeated 684 times

messages... IIRC this happened also on 2.4.0-test4


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
