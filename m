Message-ID: <39A7C246.7BB137EB@wanadoo.fr>
Date: Sat, 26 Aug 2000 15:12:38 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
CC: paulus@linuxcare.com.au
Subject: Patches for 2.4.0-test7
Content-Type: multipart/mixed;
 boundary="------------A1C66088F5C4DE46ACFF8F6D"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------A1C66088F5C4DE46ACFF8F6D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

here are some patches that are necessary for 2.4.0-test7 (bitkeeper as
well as pmac-devel) to compile and run.

Some of them have been sent to the list (even repeatedly) before (by me
and
others). Now that the gun smoke over the drivers/input battlefield has
lifted, I dare resubmit them and hope they won't continue to be ignored.

- The patch for arch/ppc/kernel/ppc_ksyms.c is necessary if you want to
compile rtc as a module. If you don't want it as a module, you don't
need to EXPORT these variables at all.

- The patch for include/asm-ppc/mman.h is necessary so that the loop
device ("mount -o loop") works. I suppose the values for these MCL_*
variables have been chosen by analogy to some other architectures, but
they are already defined by glibc in /usr/include/bits/mman.h, so you
can't take arbitrary values.

- The patch for drivers/macintosh/Makefile is necessary for successful
compilation if you have CONFIG_ADBMOUSE, but not CONFIG_ADB_KEYBOARD,
which is possible with the latest version of the new input layer. (Not
that the adbmouse works for me if I choose CONFIG_INPUT_ADBHID=y, but
that's another story).

I have 3 other pet peeves that I would like to recall:

- I think the new input layer with CONFIG_INPUT_ADBHID=y and
CONFIG_MAC_ADBKEYCODES=y on an ISO (=European) ADB keyboard gives the
wrong keycodes for the 2 keys with codes 10 and 50. Wrong in the sense
that they differ from what all other kernels from the oldest times up to
linux-pmac-devel before yesterday were giving. The tables,
mac_keycodes[]
in drivers/input/keybdev.c and adb_to_linux_keycodes[] in
drivers/macintosh/adbhid.c, are probably correct. But then
adbhid_input_register() in drivers/macintosh/adbhid.c swaps the 2 keys
if it detects an ISO ADB keyboard. IMHO the swapping should occur for
USB
keyboards and not for ADB keyboards. I had some discussion with Franz
which was not conclusive.

My question is: Are these 2 keys giving correct results if one has
either dev.mac_hid.keyboard_sends_linux_keycodes=1 or an ISO USB
keyboard?

- Paul's pmac-devel kernel still eats the LD_LIBRARY_PATH environment
variable, therefore stopping Mozilla from running. This is so weird (but
consistent since several months) that I have not the faintest idea where
it could come from. It is a feature of linux-pmac-devel, not present in
linux-bk-devel.

- Finally: The ptrace code in 2.4.0-testX has a bug that prevents strace
from working. I have no idea what's wrong, but it would be nice to have
a working strace again.

--
Martin
--------------A1C66088F5C4DE46ACFF8F6D
Content-Type: text/plain; charset=us-ascii;
 name="ppc_ksyms.patch"
Content-Disposition: inline;
 filename="ppc_ksyms.patch"
Content-Transfer-Encoding: 7bit

--- arch/ppc/kernel/ppc_ksyms.c.ori	Tue Aug 22 01:45:16 2000
+++ arch/ppc/kernel/ppc_ksyms.c	Sat Aug 26 11:37:28 2000
@@ -259,7 +259,7 @@
 EXPORT_SYMBOL(pmac_xpram_read);
 EXPORT_SYMBOL(pmac_xpram_write);
 #endif /* CONFIG_NVRAM */
-#ifdef CONFIG_PPC_RTC
+#ifdef CONFIG_PPC_RTC_MODULE
 EXPORT_SYMBOL(mktime);
 EXPORT_SYMBOL(to_tm);
 #endif


--------------A1C66088F5C4DE46ACFF8F6D
Content-Type: text/plain; charset=us-ascii;
 name="mman.h.patch"
Content-Disposition: inline;
 filename="mman.h.patch"
Content-Transfer-Encoding: 7bit

--- include/asm-ppc/mman.h.ori	Sat Mar 25 06:50:09 2000
+++ include/asm-ppc/mman.h	Thu Aug 17 17:18:47 2000
@@ -22,8 +22,8 @@
 #define MS_INVALIDATE	2		/* invalidate the caches */
 #define MS_SYNC		4		/* synchronous memory sync */

-#define MCL_CURRENT	1		/* lock all current mappings */
-#define MCL_FUTURE	2		/* lock all future mappings */
+#define MCL_CURRENT	0x2000		/* lock all current mappings */
+#define MCL_FUTURE	0x4000		/* lock all future mappings */

 #define MADV_NORMAL	0x0		/* default page-in behavior */
 #define MADV_RANDOM	0x1		/* page-in minimum required */


--------------A1C66088F5C4DE46ACFF8F6D
Content-Type: text/plain; charset=us-ascii;
 name="macintosh.patch"
Content-Disposition: inline;
 filename="macintosh.patch"
Content-Transfer-Encoding: 7bit

--- drivers/macintosh/Makefile~	Fri Aug 25 08:52:03 2000
+++ drivers/macintosh/Makefile	Sat Aug 26 12:59:40 2000
@@ -51,6 +51,7 @@

 obj-$(CONFIG_ADB)		+= adb.o
 obj-$(CONFIG_ADB_KEYBOARD)	+= mac_keyb.o
+obj-$(CONFIG_ADBMOUSE)		+= mac_keyb.o
 obj-$(CONFIG_ADB_MACII)		+= via-macii.o
 obj-$(CONFIG_ADB_MACIISI)	+= via-maciisi.o
 obj-$(CONFIG_ADB_CUDA)		+= via-cuda.o


--------------A1C66088F5C4DE46ACFF8F6D--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
