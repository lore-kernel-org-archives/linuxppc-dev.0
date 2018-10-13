Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B52C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:27:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9A4E20895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A4E20895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XQTv0TVGzF09y
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 00:26:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XQJw1PG8zF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 00:19:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XQJv6SDqz9sB5; Sun, 14 Oct 2018 00:19:11 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XQJv57GCz9sCT; Sun, 14 Oct 2018 00:19:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/6] powerpc/64s/hash: Add SLB allocation status bitmaps
Date: Sun, 14 Oct 2018 00:18:32 +1100
Message-Id: <20181013131836.26764-2-mpe@ellerman.id.au>
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

Add 32-entry bitmaps to track the allocation status of the first 32
SLB entries, and whether they are user or kernel entries. These are
used to allocate free SLB entries first, before resorting to the round
robin allocator.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/paca.h   |  6 ++-
 arch/powerpc/kernel/asm-offsets.c |  2 +-
 arch/powerpc/mm/slb.c             | 64 ++++++++++++++++++++++++-------
 arch/powerpc/xmon/xmon.c          |  4 +-
 4 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index c6d01f0aa898..97e8a57a4998 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -113,7 +113,10 @@ struct paca_struct {
  				 * on the linear mapping */
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
-	u16 slb_cache_ptr;
+	u8 slb_cache_ptr;
+	u8 stab_rr;			/* stab/slb round-robin counter */
+	u32 slb_used_bitmap;		/* Bitmaps for first 32 SLB entries. */
+	u32 slb_kern_bitmap;
 	u32 slb_cache[SLB_CACHE_ENTRIES];
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
@@ -160,7 +163,6 @@ struct paca_struct {
 	 */
 	struct task_struct *__current;	/* Pointer to current */
 	u64 kstack;			/* Saved Kernel stack addr */
-	u64 stab_rr;			/* stab/slb round-robin counter */
 	u64 saved_r1;			/* r1 save for RTAS calls or PM or EE=0 */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 92156c61d21c..10ef2e4db2fd 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -178,7 +178,6 @@ int main(void)
 	OFFSET(PACAKSAVE, paca_struct, kstack);
 	OFFSET(PACACURRENT, paca_struct, __current);
 	OFFSET(PACASAVEDMSR, paca_struct, saved_msr);
-	OFFSET(PACASTABRR, paca_struct, stab_rr);
 	OFFSET(PACAR1, paca_struct, saved_r1);
 	OFFSET(PACATOC, paca_struct, kernel_toc);
 	OFFSET(PACAKBASE, paca_struct, kernelbase);
@@ -217,6 +216,7 @@ int main(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	OFFSET(PACASLBCACHE, paca_struct, slb_cache);
 	OFFSET(PACASLBCACHEPTR, paca_struct, slb_cache_ptr);
+	OFFSET(PACASTABRR, paca_struct, stab_rr);
 	OFFSET(PACAVMALLOCSLLP, paca_struct, vmalloc_sllp);
 #ifdef CONFIG_PPC_MM_SLICES
 	OFFSET(MMUPSIZESLLP, mmu_psize_def, sllp);
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 76c1a9523049..ed61639fe4f4 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -122,6 +122,9 @@ void slb_restore_bolted_realmode(void)
 {
 	__slb_restore_bolted_realmode();
 	get_paca()->slb_cache_ptr = 0;
+
+	get_paca()->slb_kern_bitmap = (1U << SLB_NUM_BOLTED) - 1;
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 }
 
 /*
@@ -129,9 +132,6 @@ void slb_restore_bolted_realmode(void)
  */
 void slb_flush_all_realmode(void)
 {
-	/*
-	 * This flushes all SLB entries including 0, so it must be realmode.
-	 */
 	asm volatile("slbmte %0,%0; slbia" : : "r" (0));
 }
 
@@ -177,6 +177,9 @@ void slb_flush_and_rebolt(void)
 		     : "memory");
 
 	get_paca()->slb_cache_ptr = 0;
+
+	get_paca()->slb_kern_bitmap = (1U << SLB_NUM_BOLTED) - 1;
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 }
 
 void slb_save_contents(struct slb_entry *slb_ptr)
@@ -209,7 +212,7 @@ void slb_dump_contents(struct slb_entry *slb_ptr)
 		return;
 
 	pr_err("SLB contents of cpu 0x%x\n", smp_processor_id());
-	pr_err("Last SLB entry inserted at slot %lld\n", get_paca()->stab_rr);
+	pr_err("Last SLB entry inserted at slot %d\n", get_paca()->stab_rr);
 
 	for (i = 0; i < mmu_slb_size; i++) {
 		e = slb_ptr->esid;
@@ -342,10 +345,13 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 				     "isync"
 				     :: "r"(ksp_vsid_data),
 					"r"(ksp_esid_data));
+
+			get_paca()->slb_kern_bitmap = (1U << SLB_NUM_BOLTED) - 1;
 		}
 
 		get_paca()->slb_cache_ptr = 0;
 	}
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
 	copy_mm_to_paca(mm);
 
@@ -402,6 +408,8 @@ void slb_initialize(void)
 	}
 
 	get_paca()->stab_rr = SLB_NUM_BOLTED - 1;
+	get_paca()->slb_kern_bitmap = (1U << SLB_NUM_BOLTED) - 1;
+	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
 	lflags = SLB_VSID_KERNEL | linear_llp;
 
@@ -453,17 +461,47 @@ static void slb_cache_update(unsigned long esid_data)
 	}
 }
 
-static enum slb_index alloc_slb_index(void)
+static enum slb_index alloc_slb_index(bool kernel)
 {
 	enum slb_index index;
 
-	/* round-robin replacement of slb starting at SLB_NUM_BOLTED. */
-	index = get_paca()->stab_rr;
-	if (index < (mmu_slb_size - 1))
-		index++;
-	else
-		index = SLB_NUM_BOLTED;
-	get_paca()->stab_rr = index;
+	/*
+	 * The allocation bitmaps can become out of synch with the SLB
+	 * when the _switch code does slbie when bolting a new stack
+	 * segment and it must not be anywhere else in the SLB. This leaves
+	 * a kernel allocated entry that is unused in the SLB. With very
+	 * large systems or small segment sizes, the bitmaps could slowly
+	 * fill with these entries. They will eventually be cleared out
+	 * by the round robin allocator in that case, so it's probably not
+	 * worth accounting for.
+	 */
+
+	/*
+	 * SLBs beyond 32 entries are allocated with stab_rr only
+	 * POWER7/8/9 have 32 SLB entries, this could be expanded if a
+	 * future CPU has more.
+	 */
+	if (local_paca->slb_used_bitmap != U32_MAX) {
+		index = ffz(local_paca->slb_used_bitmap);
+		local_paca->slb_used_bitmap |= 1U << index;
+		if (kernel)
+			local_paca->slb_kern_bitmap |= 1U << index;
+	} else {
+		/* round-robin replacement of slb starting at SLB_NUM_BOLTED. */
+		index = local_paca->stab_rr;
+		if (index < (mmu_slb_size - 1))
+			index++;
+		else
+			index = SLB_NUM_BOLTED;
+		local_paca->stab_rr = index;
+		if (index < 32) {
+			if (kernel)
+				local_paca->slb_kern_bitmap |= 1U << index;
+			else
+				local_paca->slb_kern_bitmap &= ~(1U << index);
+		}
+	}
+	BUG_ON(index < SLB_NUM_BOLTED);
 
 	return index;
 }
@@ -490,7 +528,7 @@ static long slb_insert_entry(unsigned long ea, unsigned long context,
 	 */
 	barrier();
 
-	index = alloc_slb_index();
+	index = alloc_slb_index(kernel);
 
 	vsid_data = __mk_vsid_data(vsid, ssize, flags);
 	esid_data = mk_esid_data(ea, ssize, index);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 8345defa0e43..58e67b67a97c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2394,7 +2394,9 @@ static void dump_one_paca(int cpu)
 			}
 		}
 		DUMP(p, vmalloc_sllp, "%#-*x");
-		DUMP(p, stab_rr, "%#-*llx");
+		DUMP(p, stab_rr, "%#-*x");
+		DUMP(p, slb_used_bitmap, "%#-*x");
+		DUMP(p, slb_kern_bitmap, "%#-*x");
 
 		if (!early_cpu_has_feature(CPU_FTR_ARCH_300)) {
 			DUMP(p, slb_cache_ptr, "%#-*x");
-- 
2.17.1

