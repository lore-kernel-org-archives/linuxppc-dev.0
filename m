Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 761DADE028
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Jan 2009 07:46:26 +1100 (EST)
From: Milton Miller <miltonm@bga.com>
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <kexec-29-1-7.miltonm@bga.com>
In-Reply-To: <kexec-29-1.miltonm@bga.com>
Subject: [PATCH] powerpc: check crash_base for relocatable kernel
Date: Fri, 02 Jan 2009 14:46:15 -0600
Cc: kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enforce that the crash kernel region never overlaps the current kernel,
as it will be written directly on kexec load.

Also, default to the previous KDUMP_KERNELBASE if the start is 0.

Other architectures (x86, ia64) state that specifying the start address
0 (or omitting it) will result in the kernel allocating it.  Before the
relocatable patch in 2.6.28, powerpc would adjust any other start value
to the hardcoded KDUMP_KERNELBASE of 32M.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
consider for stable 2.6.28:

A crash region start of 0 results either in a kernel panic (if all of
segemnt 0 is reserved) or confused kexec userspace (as the start
and length are not exported to userspace):

Starting new kernel
Reserving 512MB of memory at 0MB for crashkernel (System RAM: 2048MB)
Using pSeries machine description

...

[boot]0012 Setup Arch
Kernel panic - not syncing: ERROR: Failed to allocate 0x4000 bytes below 0x10000000.

or

# kexec -p /root/vmlinux
Memory for crashkernel is not reserved
Please reserve memory by passing "crashkernel=X@Y" parameter to the kernel
Then try loading kdump kernel
# cat /proc/cmdline
retain_initrd crashkernel=64M
#


Index: common/arch/powerpc/kernel/machine_kexec.c
===================================================================
--- common.orig/arch/powerpc/kernel/machine_kexec.c	2009-01-01 23:43:45.000000000 -0600
+++ common/arch/powerpc/kernel/machine_kexec.c	2009-01-02 00:40:24.000000000 -0600
@@ -13,6 +13,7 @@
 #include <linux/reboot.h>
 #include <linux/threads.h>
 #include <linux/lmb.h>
+#include <asm/sections.h>
 #include <asm/machdep.h>
 #include <asm/prom.h>
 
@@ -94,10 +95,35 @@ void __init reserve_crashkernel(void)
 				KDUMP_KERNELBASE);
 
 	crashk_res.start = KDUMP_KERNELBASE;
+#else
+	if (!crashk_res.start) {
+		/*
+		 * unspecified address, choose a region of specified size
+		 * can overlap with initrd (ignoring corruption when retained)
+		 * ppc64 requires kernel and some stacks to be in first segemnt
+		 */
+		crashk_res.start = KDUMP_KERNELBASE;
+	}
+
+	crash_base = PAGE_ALIGN(crashk_res.start);
+	if (crash_base != crashk_res.start) {
+		printk("Crash kernel base must be aligned to 0x%lx\n",
+				PAGE_SIZE);
+		crashk_res.start = crash_base;
+	}
+
 #endif
 	crash_size = PAGE_ALIGN(crash_size);
 	crashk_res.end = crashk_res.start + crash_size - 1;
 
+	/* The crash region must not overlap the current kernel */
+	if (overlaps_crashkernel(__pa(_stext), _end - _stext)) {
+		printk(KERN_WARNING
+			"Crash kernel can not overlap current kernel\n");
+		crashk_res.start = crashk_res.end = 0;
+		return;
+	}
+
 	/* Crash kernel trumps memory limit */
 	if (memory_limit && memory_limit <= crashk_res.end) {
 		memory_limit = crashk_res.end + 1;
