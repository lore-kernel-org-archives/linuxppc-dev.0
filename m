Return-Path: <anton@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D44B5B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 14 Jul 2009 17:00:47 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AE726DDDB6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jul 2009 17:00:47 +1000 (EST)
Message-Id: <20090714065425.460605043@samba.org>
References: <20090714065350.659537380@samba.org>
Date: Tue, 14 Jul 2009 16:53:52 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [patch 2/3] powerpc: Rearrange SLB preload code
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the new top down layout it is likely that the pc and stack will be in the
same segment, because the pc is most likely in a library allocated via a top
down mmap. Right now we bail out early if these segments match.

Rearrange the SLB preload code to sanity check all SLB preload addresses
are not in the kernel, then check all addresses for conflicts.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/mm/slb.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/mm/slb.c	2009-07-14 15:06:26.000000000 +1000
+++ linux.trees.git/arch/powerpc/mm/slb.c	2009-07-14 15:09:39.000000000 +1000
@@ -225,23 +225,18 @@
 	else
 		unmapped_base = TASK_UNMAPPED_BASE_USER64;
 
-	if (is_kernel_addr(pc))
-		return;
-	slb_allocate(pc);
-
-	if (esids_match(pc,stack))
+	if (is_kernel_addr(pc) || is_kernel_addr(stack) ||
+	    is_kernel_addr(unmapped_base))
 		return;
 
-	if (is_kernel_addr(stack))
-		return;
-	slb_allocate(stack);
+	slb_allocate(pc);
 
-	if (esids_match(pc,unmapped_base) || esids_match(stack,unmapped_base))
-		return;
+	if (!esids_match(pc, stack))
+		slb_allocate(stack);
 
-	if (is_kernel_addr(unmapped_base))
-		return;
-	slb_allocate(unmapped_base);
+	if (!esids_match(pc, unmapped_base) &&
+	    !esids_match(stack, unmapped_base))
+		slb_allocate(unmapped_base);
 }
 
 static inline void patch_slb_encoding(unsigned int *insn_addr,

-- 
