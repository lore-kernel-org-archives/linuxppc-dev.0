Date: Tue, 29 Feb 2000 18:03:07 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Paul Mackerras <paulus@linuxcare.com>
cc: Linux/PPC Developer list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC should not use -fno-builtin (was Re: 2.3.47 imac build?)
In-Reply-To: <00022911542401.10645@argo.linuxcare.com.au>
Message-ID: <Pine.LNX.4.10.10002291744130.4907-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
> My linuxcare.com.au::linux-pmac-devel rsync tree is now up to 2.3.48, BTW.

Fails to compile (drivers/char/n_tty.c uses asm/spinlock.h, should use
linux/spinlock.h perhaps). After forcing it, it fails to boot on Lombard.
The way it fails booting is a bit entertaining: using BootX 1.1.3, it will
show a little more than half a page of messages (arch_exit or similar in
the last), then starts drawing funny color fringes on the screen until I
reset. Using BootX 1.2b3, it locks up after the first six or so lines of
text (before getting to the early console output). 2.3.29 worked fine. Any
ideas?

Patch appended (adbmouse.o is only built if CONFIG_BUSMOUSE is set and
make complained about getting busmouse.o twice in the target line, so
there).

	Michael

--- 2.3.48-devel/drivers/char/Makefile.org	Tue Feb 29 17:52:59 2000
+++ 2.3.48-devel/drivers/char/Makefile	Tue Feb 29 16:42:32 2000
@@ -154,7 +154,7 @@
 obj-$(CONFIG_MIXCOMWD) += mixcomwd.o
 obj-$(CONFIG_AMIGAMOUSE) += amigamouse.o
 obj-$(CONFIG_ATARIMOUSE) += atarimouse.o
-obj-$(CONFIG_ADBMOUSE) += adbmouse.o busmouse.o
+obj-$(CONFIG_ADBMOUSE) += adbmouse.o
 obj-$(CONFIG_PC110_PAD) += pc110pad.o
 obj-$(CONFIG_WDT) += wdt.o
 obj-$(CONFIG_RTC) += rtc.o
--- 2.3.48-devel/drivers/char/n_tty.c.org	Mon Feb 28 11:56:43 2000
+++ 2.3.48-devel/drivers/char/n_tty.c	Tue Feb 29 14:57:35 2000
@@ -28,6 +28,7 @@
 #include <linux/errno.h>
 #include <linux/signal.h>
 #include <linux/fcntl.h>
+#include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/tty.h>
@@ -42,7 +43,6 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/bitops.h>
-#include <asm/spinlock.h>

 #define CONSOLE_DEV MKDEV(TTY_MAJOR,0)
 #define SYSCONS_DEV  MKDEV(TTYAUX_MAJOR,1)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
