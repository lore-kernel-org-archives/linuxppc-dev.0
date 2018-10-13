Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF1AC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:32:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D485820895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D485820895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XQcm6FhlzF3DQ
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 00:32:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XQJy4SjvzF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 00:19:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XQJy3cMfz9sB5; Sun, 14 Oct 2018 00:19:14 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XQJy33kjz9sCt; Sun, 14 Oct 2018 00:19:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/6] powerpc/64s/hash: Simplify slb_flush_and_rebolt()
Date: Sun, 14 Oct 2018 00:18:35 +1100
Message-Id: <20181013131836.26764-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181013131836.26764-1-mpe@ellerman.id.au>
References: <20181013131836.26764-1-mpe@ellerman.id.au>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicholas Piggin <npiggin@gmail.com>

slb_flush_and_rebolt() is misleading, it is called in virtual mode, so
it can not possibly change the stack, so it should not be touching the
shadow area. And since vmalloc is no longer bolted, it should not
change any bolted mappings at all.

Change the name to slb_flush_and_restore_bolted(), and have it just
load the kernel stack from what's currently in the shadow SLB area.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
 arch/powerpc/kernel/swsusp_asm64.S            |  2 +-
 arch/powerpc/mm/hash_utils_64.c               |  4 +-
 arch/powerpc/mm/slb.c                         | 46 +++++++------------
 arch/powerpc/mm/slice.c                       |  2 +-
 5 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 14e552ea5e52..60cda8fb0677 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -503,7 +503,7 @@ struct slb_entry {
 };
 
 extern void slb_initialize(void);
-extern void slb_flush_and_rebolt(void);
+void slb_flush_and_restore_bolted(void);
 void slb_flush_all_realmode(void);
 void __slb_restore_bolted_realmode(void);
 void slb_restore_bolted_realmode(void);
diff --git a/arch/powerpc/kernel/swsusp_asm64.S b/arch/powerpc/kernel/swsusp_asm64.S
index f83bf6f72cb0..185216becb8b 100644
--- a/arch/powerpc/kernel/swsusp_asm64.S
+++ b/arch/powerpc/kernel/swsusp_asm64.S
@@ -262,7 +262,7 @@ END_FW_FTR_SECTION_IFCLR(FW_FEATURE_LPAR)
 
 	addi	r1,r1,-128
 #ifdef CONFIG_PPC_BOOK3S_64
-	bl	slb_flush_and_rebolt
+	bl	slb_flush_and_restore_bolted
 #endif
 	bl	do_after_copyback
 	addi	r1,r1,128
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 854edc3722e0..0cc7fbc3bd1c 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1125,7 +1125,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
 
 		copy_mm_to_paca(mm);
-		slb_flush_and_rebolt();
+		slb_flush_and_restore_bolted();
 	}
 }
 #endif /* CONFIG_PPC_64K_PAGES */
@@ -1197,7 +1197,7 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
 	if (user_region) {
 		if (psize != get_paca_psize(ea)) {
 			copy_mm_to_paca(mm);
-			slb_flush_and_rebolt();
+			slb_flush_and_restore_bolted();
 		}
 	} else if (get_paca()->vmalloc_sllp !=
 		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 3b7d8af09724..d8d9c9bd15d3 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -115,8 +115,6 @@ void __slb_restore_bolted_realmode(void)
 
 /*
  * Insert the bolted entries into an empty SLB.
- * This is not the same as rebolt because the bolted segments are not
- * changed, just loaded from the shadow area.
  */
 void slb_restore_bolted_realmode(void)
 {
@@ -135,12 +133,15 @@ void slb_flush_all_realmode(void)
 	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
 }
 
-void slb_flush_and_rebolt(void)
+/*
+ * This flushes non-bolted entries, it can be run in virtual mode. Must
+ * be called with interrupts disabled.
+ */
+void slb_flush_and_restore_bolted(void)
 {
-	/* If you change this make sure you change SLB_NUM_BOLTED
-	 * and PR KVM appropriately too. */
-	unsigned long linear_llp, lflags;
-	unsigned long ksp_esid_data, ksp_vsid_data;
+	struct slb_shadow *p = get_slb_shadow();
+
+	BUILD_BUG_ON(SLB_NUM_BOLTED != 2);
 
 	WARN_ON(!irqs_disabled());
 
@@ -150,30 +151,12 @@ void slb_flush_and_rebolt(void)
 	 */
 	hard_irq_disable();
 
-	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
-	lflags = SLB_VSID_KERNEL | linear_llp;
-
-	ksp_esid_data = mk_esid_data(get_paca()->kstack, mmu_kernel_ssize, KSTACK_INDEX);
-	if ((ksp_esid_data & ~0xfffffffUL) <= PAGE_OFFSET) {
-		ksp_esid_data &= ~SLB_ESID_V;
-		ksp_vsid_data = 0;
-		slb_shadow_clear(KSTACK_INDEX);
-	} else {
-		/* Update stack entry; others don't change */
-		slb_shadow_update(get_paca()->kstack, mmu_kernel_ssize, lflags, KSTACK_INDEX);
-		ksp_vsid_data =
-			be64_to_cpu(get_slb_shadow()->save_area[KSTACK_INDEX].vsid);
-	}
-
-	/* We need to do this all in asm, so we're sure we don't touch
-	 * the stack between the slbia and rebolting it. */
 	asm volatile("isync\n"
 		     "slbia\n"
-		     /* Slot 1 - kernel stack */
-		     "slbmte	%0,%1\n"
-		     "isync"
-		     :: "r"(ksp_vsid_data),
-		        "r"(ksp_esid_data)
+		     "slbmte  %0, %1\n"
+		     "isync\n"
+		     :: "r" (be64_to_cpu(p->save_area[KSTACK_INDEX].vsid)),
+			"r" (be64_to_cpu(p->save_area[KSTACK_INDEX].esid))
 		     : "memory");
 
 	get_paca()->slb_cache_ptr = 0;
@@ -254,7 +237,10 @@ void slb_dump_contents(struct slb_entry *slb_ptr)
 
 void slb_vmalloc_update(void)
 {
-	slb_flush_and_rebolt();
+	/*
+	 * vmalloc is not bolted, so just have to flush non-bolted.
+	 */
+	slb_flush_and_restore_bolted();
 }
 
 static bool preload_hit(struct thread_info *ti, unsigned long esid)
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 546dd07c8083..50ba3d0456a5 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -219,7 +219,7 @@ static void slice_flush_segments(void *parm)
 	copy_mm_to_paca(current->active_mm);
 
 	local_irq_save(flags);
-	slb_flush_and_rebolt();
+	slb_flush_and_restore_bolted();
 	local_irq_restore(flags);
 #endif
 }
-- 
2.17.1

