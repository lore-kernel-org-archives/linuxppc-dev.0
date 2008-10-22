Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31CF4474DC
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 07:39:36 +1100 (EST)
Date: Wed, 22 Oct 2008 15:39:16 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/ppc64/kdump: better flag for running relocatable
Message-id: <kexec-kern-2@bga.com>
In-Reply-To: <f90d4d7306443a720ca31adf513faf25@bga.com>
Cc: linuxppc-dev@ozlabs.org, Simon Horman <horms@verge.net.au>,
	kexec@lists.infradead.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The __kdump_flag ABI is overly constraining for future development.  

As of 2.6.27, the kernel entry point has 4 constraints:  Offset 0 is
the starting point for the master (boot) cpu (entered with r3 pointing
to the device tree structure), offset 0x60 is code for the slave cpus
(entered with r3 set to their device tree physical id), offset 0x20 is
used by the iseries hypervisor, and secondary cpus must be well behaved
when the first 256 bytes are copied to address 0.

Placing the __kdump_flag at 0x18 is bad because:

- It was taking the last 8 bytes before the iseries hypervisor data.  
- It was 8 bytes for a boolean flag
- It had no way of identifying that the flag was present
- It does leave any room for the master to add any additional code
  before branching, which hurts debug.
- It will be unnecessarily hard for 32 bit code to be common (8 bytes)

Now that we have eliminated the use of __kdump_flag in favor of
the standard is_kdump_kernel(), this flag only controls run without
relocating the kernel to PHYSICAL_START (0), so rename it __run_at_load.

Move the flag to 0x5c, 1 word before the secondary cpu entry point at
0x60.  Use the copy at address 0 not the one in the base kernel image to
make it easier on kexec-tools.  Initialize it with "run0" to say it will
run at 0 unless it is set to 1.  It only exists if we are relocatable.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I left it global so it appears that way in System.map, but it would
not need to be.

I kept the guards with CONFIG_CRASH_DUMP for now.  They could be relaxed
to just CONFIG_RELOCATABLE.

Tested with normal kexec (kernel moved to 0) and a custom boot-loader
(kernel stayed at loaded 16MB start).

Index: next.git/arch/powerpc/kernel/head_64.S
===================================================================
--- next.git.orig/arch/powerpc/kernel/head_64.S	2008-10-22 04:30:08.000000000 -0500
+++ next.git/arch/powerpc/kernel/head_64.S	2008-10-22 04:59:55.000000000 -0500
@@ -97,12 +97,6 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.llong	0x0
 
-	/* This flag is set by purgatory if we should be a kdump kernel. */
-	/* Do not move this variable as purgatory knows about it. */
-	.globl	__kdump_flag
-__kdump_flag:
-	.llong	0x0
-
 #ifdef CONFIG_PPC_ISERIES
 	/*
 	 * At offset 0x20, there is a pointer to iSeries LPAR data.
@@ -112,6 +106,20 @@ __kdump_flag:
 	.llong hvReleaseData-KERNELBASE
 #endif /* CONFIG_PPC_ISERIES */
 
+#ifdef CONFIG_CRASH_DUMP
+	/* This flag is set to 1 by a loader if the kernel should run
+	 * at the loaded address instead of the linked address.  This
+	 * is used by kexec-tools to keep the the kdump kernel in the
+	 * crash_kernel region.  The loader is responsible for
+	 * observing the alignment requirement.
+	 */
+	/* Do not move this variable as kexec-tools knows about it. */
+	. = 0x5c
+	.globl	__run_at_load
+__run_at_load:
+	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
+#endif
+
 	. = 0x60
 /*
  * The following code is used to hold secondary processors
@@ -1391,8 +1399,8 @@ _STATIC(__after_prom_start)
 	lis	r25,PAGE_OFFSET@highest	/* compute virtual base of kernel */
 	sldi	r25,r25,32
 #ifdef CONFIG_CRASH_DUMP
-	ld	r7,__kdump_flag-_stext(r26)
-	cmpldi	cr0,r7,1	/* kdump kernel ? - stay where we are */
+	lwz	r7,__run_at_load-_stext(0)
+	cmplwi	cr0,r7,1	/* kdump kernel ? - stay where we are */
 	bne	1f
 	add	r25,r25,r26
 #endif
@@ -1416,11 +1424,11 @@ _STATIC(__after_prom_start)
 #ifdef CONFIG_CRASH_DUMP
 /*
  * Check if the kernel has to be running as relocatable kernel based on the
- * variable __kdump_flag, if it is set the kernel is treated as relocatable
+ * variable __run_at_load, if it is set the kernel is treated as relocatable
  * kernel, otherwise it will be moved to PHYSICAL_START
  */
-	ld	r7,__kdump_flag-_stext(r26)
-	cmpldi	cr0,r7,1
+	lwz	r7,__run_at_load-_stext(0)
+	cmplwi	cr0,r7,1
 	bne	3f
 
 	li	r5,__end_interrupts - _stext	/* just copy interrupts */
