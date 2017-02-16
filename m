Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP4hT1mDZzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 16:38:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH 1/2] powerpc/mm: Convert slb_finish_load[_1T] to local symbols
Date: Thu, 16 Feb 2017 16:38:44 +1100
Message-Id: <1487223525-2665-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

slb_finish_load and slb_finish_load_1T are both only used within
slb_low.S, so make them local symbols.

This makes the code a little clearer, as it's more obvious neither is
intended to be an entry point from arbitrary other code, only the uses
in this file.

It also prevents them being used with kprobes and other tracing tools,
which is good because we're not able to safely take traps at these
locations, so making them local symbols avoids us needing to blacklist
them.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/slb_low.S | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index e2974fcd20f1..9beed92c1900 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -71,9 +71,9 @@ slb_miss_kernel_load_linear:
 
 
 BEGIN_FTR_SECTION
-	b	slb_finish_load
+	b	.Lslb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
-	b	slb_finish_load_1T
+	b	.Lslb_finish_load_1T
 
 1:
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
@@ -109,9 +109,9 @@ slb_miss_kernel_load_io:
 	addi	r9,r9,(MAX_USER_CONTEXT - 0xc + 1)@l
 
 BEGIN_FTR_SECTION
-	b	slb_finish_load
+	b	.Lslb_finish_load
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
-	b	slb_finish_load_1T
+	b	.Lslb_finish_load_1T
 
 0:	/*
 	 * For userspace addresses, make sure this is region 0.
@@ -174,9 +174,9 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	ld	r9,PACACONTEXTID(r13)
 BEGIN_FTR_SECTION
 	cmpldi	r10,0x1000
-	bge	slb_finish_load_1T
+	bge	.Lslb_finish_load_1T
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
-	b	slb_finish_load
+	b	.Lslb_finish_load
 
 8:	/* invalid EA - return an error indication */
 	crset	4*cr0+eq		/* indicate failure */
@@ -187,7 +187,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
  *
  * r3 = EA, r9 = context, r10 = ESID, r11 = flags, clobbers r9, cr7 = <> PAGE_OFFSET
  */
-slb_finish_load:
+.Lslb_finish_load:
 	rldimi  r10,r9,ESID_BITS,0
 	ASM_VSID_SCRAMBLE(r10,r9,256M)
 	/*
@@ -256,7 +256,7 @@ slb_compare_rr_to_size:
  *
  * r3 = EA, r9 = context, r10 = ESID(256MB), r11 = flags, clobbers r9
  */
-slb_finish_load_1T:
+.Lslb_finish_load_1T:
 	srdi	r10,r10,(SID_SHIFT_1T - SID_SHIFT)	/* get 1T ESID */
 	rldimi  r10,r9,ESID_BITS_1T,0
 	ASM_VSID_SCRAMBLE(r10,r9,1T)
-- 
2.7.4
