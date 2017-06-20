Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsS3Y40qZzDqhy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 22:35:05 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 3/3] powerpc/64s: Rename slb_allocate_realmode() to
 slb_allocate()
Date: Tue, 20 Jun 2017 22:34:57 +1000
Message-Id: <1497962097-9402-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1497962097-9402-1-git-send-email-mpe@ellerman.id.au>
References: <1497962097-9402-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As for slb_miss_realmode(), rename slb_allocate_realmode() to avoid
confusion over whether it runs in real or virtual mode - it runs in
both.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/exceptions-64s.S |  2 +-
 arch/powerpc/mm/slb.c                | 10 +---------
 arch/powerpc/mm/slb_low.S            |  6 +++---
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6ad755e0cb29..07b79c2c70f8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -605,7 +605,7 @@ EXC_COMMON_BEGIN(slb_miss_common)
 	crset	4*cr0+eq
 #ifdef CONFIG_PPC_STD_MMU_64
 BEGIN_MMU_FTR_SECTION
-	bl	slb_allocate_realmode
+	bl	slb_allocate
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 #endif
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 654a0d7ba0e7..13cfe413b40d 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -33,15 +33,7 @@ enum slb_index {
 	KSTACK_INDEX	= 2, /* Kernel stack map */
 };
 
-extern void slb_allocate_realmode(unsigned long ea);
-
-static void slb_allocate(unsigned long ea)
-{
-	/* Currently, we do real mode for all SLBs including user, but
-	 * that will change if we bring back dynamic VSIDs
-	 */
-	slb_allocate_realmode(ea);
-}
+extern void slb_allocate(unsigned long ea);
 
 #define slb_esid_mask(ssize)	\
 	(((ssize) == MMU_SEGSIZE_256M)? ESID_MASK: ESID_MASK_1T)
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 9869b44a04dc..bde378559d01 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -65,7 +65,7 @@ MMU_FTR_SECTION_ELSE							\
 ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_68_BIT_VA)
 
 
-/* void slb_allocate_realmode(unsigned long ea);
+/* void slb_allocate(unsigned long ea);
  *
  * Create an SLB entry for the given EA (user or kernel).
  * 	r3 = faulting address, r13 = PACA
@@ -73,7 +73,7 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_68_BIT_VA)
  *	r3 is preserved.
  * No other registers are examined or changed.
  */
-_GLOBAL(slb_allocate_realmode)
+_GLOBAL(slb_allocate)
 	/*
 	 * check for bad kernel/user address
 	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
@@ -309,7 +309,7 @@ slb_compare_rr_to_size:
 	b	7b
 
 
-_ASM_NOKPROBE_SYMBOL(slb_allocate_realmode)
+_ASM_NOKPROBE_SYMBOL(slb_allocate)
 _ASM_NOKPROBE_SYMBOL(slb_miss_kernel_load_linear)
 _ASM_NOKPROBE_SYMBOL(slb_miss_kernel_load_io)
 _ASM_NOKPROBE_SYMBOL(slb_compare_rr_to_size)
-- 
2.7.4
