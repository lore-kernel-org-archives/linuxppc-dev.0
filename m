Return-Path: <anton@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D68F8B7094
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 17:00:47 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B517ADDDE6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 17:00:47 +1000 (EST)
Message-Id: <20090714065425.555222245@samba.org>
References: <20090714065350.659537380@samba.org>
Date: Tue, 14 Jul 2009 16:53:53 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [patch 3/3] powerpc: Preload application text segment instead of
	TASK_UNMAPPED_BASE
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

TASK_UNMAPPED_BASE is not used with the new top down mmap layout. We can
reuse this preload slot by loading in the segment at 0x10000000, where almost
all PowerPC binaries are linked at.

On a microbenchmark that bounces a token between two 64bit processes over pipes
and calls gettimeofday each iteration (to access the VDSO), both the 32bit and
64bit context switch rate improves (tested on a 4GHz POWER6):

32bit: 273k/sec -> 283k/sec
64bit: 277k/sec -> 284k/sec

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/mm/slb.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/mm/slb.c	2009-07-14 15:09:39.000000000 +1000
+++ linux.trees.git/arch/powerpc/mm/slb.c	2009-07-14 15:12:42.000000000 +1000
@@ -191,7 +191,7 @@
 	unsigned long slbie_data = 0;
 	unsigned long pc = KSTK_EIP(tsk);
 	unsigned long stack = KSTK_ESP(tsk);
-	unsigned long unmapped_base;
+	unsigned long exec_base;
 
 	if (!cpu_has_feature(CPU_FTR_NO_SLBIE_B) &&
 	    offset <= SLB_CACHE_ENTRIES) {
@@ -219,14 +219,13 @@
 
 	/*
 	 * preload some userspace segments into the SLB.
+	 * Almost all 32 and 64bit PowerPC executables are linked at
+	 * 0x10000000 so it makes sense to preload this segment.
 	 */
-	if (test_tsk_thread_flag(tsk, TIF_32BIT))
-		unmapped_base = TASK_UNMAPPED_BASE_USER32;
-	else
-		unmapped_base = TASK_UNMAPPED_BASE_USER64;
+	exec_base = 0x10000000;
 
 	if (is_kernel_addr(pc) || is_kernel_addr(stack) ||
-	    is_kernel_addr(unmapped_base))
+	    is_kernel_addr(exec_base))
 		return;
 
 	slb_allocate(pc);
@@ -234,9 +233,9 @@
 	if (!esids_match(pc, stack))
 		slb_allocate(stack);
 
-	if (!esids_match(pc, unmapped_base) &&
-	    !esids_match(stack, unmapped_base))
-		slb_allocate(unmapped_base);
+	if (!esids_match(pc, exec_base) &&
+	    !esids_match(stack, exec_base))
+		slb_allocate(exec_base);
 }
 
 static inline void patch_slb_encoding(unsigned int *insn_addr,

-- 
