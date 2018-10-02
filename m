Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC0DC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:43:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E65C2082A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 14:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbSsXQq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E65C2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Phhn6xrgzF3HZ
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 00:43:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbSsXQq/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jbSsXQq/"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PhMW48J3zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 00:28:07 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id y15-v6so1713946plr.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qo2xNKz7XaVYRZJGX4B1tBhmmrhB++Kv8OKkG8a1AnA=;
 b=jbSsXQq/Iaq/UYdWnDWDn2GKUFxcy97I/BRyxCBjqWslXtP7ZW2ofFQwxGOTSs4+0b
 40o7vHGU9hpZ/CMCGBo7PZyNEuahSV347tYzdZ6KnZFNHIcnolop3WIEmypDkYBlzvNv
 BrydKJvpK+Uzsslp8t/UV1bRfngH+Qrdp5LWHkd6OhVAPeyBy1+NQOO5VN+xm1pEeuwi
 rOsiHT/kx3YSPzN9CzalpFv8NySXBYQgefsDct5aaDm+JQ14KbiOY5LM5I02UgDaepja
 xCgAdFcQHQeNx3OYNq0UssdW3Dpb1g1ifZrMsUiepiE01eN39DKw1eOZ59292DatP47V
 McBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qo2xNKz7XaVYRZJGX4B1tBhmmrhB++Kv8OKkG8a1AnA=;
 b=tecsdFvHP02L+oJOvZ/ioBQP1FIeqhZLcyqNdPlTPKIq7TI8nZoklh85vOn3JH0Hr2
 rItRyASCOkg28gQ+1NXdj1BryInjAkWziu0z0JRHh+et54E+hhHmLTTtnz5+RVMclpm3
 QhDP50nrBX6t/ZNp3NS+ilc/7nLUxt6k0kSGugpkZPR0Pv6wJVa+4y34HuCDA0hSELSW
 kIxfvoCqMTu3C4opZjcXBnJ9RD8FJEka1ZHqVUw8yHe9vY6ulkY/55ocQxpsM7Df1jNP
 89PoBTiMjtQY9iy+tLXL5B6q+GH0cfzZ6lQb+200CeKEpsdBklJixAw5/MKs21eMkyNX
 BuHA==
X-Gm-Message-State: ABuFfog1o1ofNU9HgEv1ETcSdJ4R/Z29YaplcPP4rx9h9BugFZ0Y7lbz
 RD/b2cNL+Rib2PAggee6c+RCL3Hi
X-Google-Smtp-Source: ACcGV63o2PYMtc712ijAkixMOZYTmG9lkYJQHMRCG/64wHMyRRk+d0LapG6d5BhFsrNfJO/wvh+lDA==
X-Received: by 2002:a63:cf0e:: with SMTP id
 j14-v6mr14448572pgg.195.1538490485543; 
 Tue, 02 Oct 2018 07:28:05 -0700 (PDT)
Received: from roar.local0.net (59-102-83-213.tpgi.com.au. [59.102.83.213])
 by smtp.gmail.com with ESMTPSA id p3-v6sm21862621pfo.130.2018.10.02.07.28.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 02 Oct 2018 07:28:05 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/9] Revert "powerpc/64s/hash: remove user SLB data from
 the paca"
Date: Wed,  3 Oct 2018 00:27:51 +1000
Message-Id: <20181002142759.6244-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181002142759.6244-1-npiggin@gmail.com>
References: <20181002142759.6244-1-npiggin@gmail.com>
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This reverts commit 8fed04d0f6aedf99b3d811ba58d38bb7f938a47a.

There are a number of problems with this patch, there are minor bugs
like vmalloc_sllp update no longer being picked up into pacas, but
more fundamentally the SLB flush can not be broadcast out to other
CPUs because it must be done in places where interrupts can be
disabled, which would deadlock.

Rather than try put some bandaids on this, the best fix is to revert
it. I think it's a worthwhile approach, but it should be solved by
demotig things eagerly at setup or map time, rather than in low level
hash faults. Most cases are rarely used by software or apply to very
old hardware.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  1 -
 arch/powerpc/include/asm/paca.h               | 13 ++++++
 arch/powerpc/kernel/asm-offsets.c             |  9 ++++
 arch/powerpc/kernel/paca.c                    | 22 +++++++++
 arch/powerpc/mm/hash_utils_64.c               | 46 ++++++++++++++-----
 arch/powerpc/mm/mmu_context.c                 |  3 +-
 arch/powerpc/mm/slb.c                         | 20 +-------
 arch/powerpc/mm/slice.c                       | 29 ++++++++----
 8 files changed, 103 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index bbeaf6adf93c..14e552ea5e52 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -503,7 +503,6 @@ struct slb_entry {
 };
 
 extern void slb_initialize(void);
-extern void core_flush_all_slbs(struct mm_struct *mm);
 extern void slb_flush_and_rebolt(void);
 void slb_flush_all_realmode(void);
 void __slb_restore_bolted_realmode(void);
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6d6b3706232c..4838149ee07b 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -146,6 +146,18 @@ struct paca_struct {
 	struct tlb_core_data tcd;
 #endif /* CONFIG_PPC_BOOK3E */
 
+#ifdef CONFIG_PPC_BOOK3S
+	mm_context_id_t mm_ctx_id;
+#ifdef CONFIG_PPC_MM_SLICES
+	unsigned char mm_ctx_low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
+	unsigned char mm_ctx_high_slices_psize[SLICE_ARRAY_SIZE];
+	unsigned long mm_ctx_slb_addr_limit;
+#else
+	u16 mm_ctx_user_psize;
+	u16 mm_ctx_sllp;
+#endif
+#endif
+
 	/*
 	 * then miscellaneous read-write fields
 	 */
@@ -248,6 +260,7 @@ struct paca_struct {
 #endif /* CONFIG_PPC_BOOK3S_64 */
 } ____cacheline_aligned;
 
+extern void copy_mm_to_paca(struct mm_struct *mm);
 extern struct paca_struct **paca_ptrs;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
 extern void setup_paca(struct paca_struct *new_paca);
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index ba9d0fc98730..27c78b6c9909 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -180,6 +180,15 @@ int main(void)
 	OFFSET(PACAIRQSOFTMASK, paca_struct, irq_soft_mask);
 	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
 	OFFSET(PACA_FTRACE_ENABLED, paca_struct, ftrace_enabled);
+#ifdef CONFIG_PPC_BOOK3S
+	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
+#ifdef CONFIG_PPC_MM_SLICES
+	OFFSET(PACALOWSLICESPSIZE, paca_struct, mm_ctx_low_slices_psize);
+	OFFSET(PACAHIGHSLICEPSIZE, paca_struct, mm_ctx_high_slices_psize);
+	OFFSET(PACA_SLB_ADDR_LIMIT, paca_struct, mm_ctx_slb_addr_limit);
+	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
+#endif /* CONFIG_PPC_MM_SLICES */
+#endif
 
 #ifdef CONFIG_PPC_BOOK3E
 	OFFSET(PACAPGD, paca_struct, pgd);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 0cf84e30d1cd..0ee3e6d50f28 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -258,3 +258,25 @@ void __init free_unused_pacas(void)
 	printk(KERN_DEBUG "Allocated %u bytes for %u pacas\n",
 			paca_ptrs_size + paca_struct_size, nr_cpu_ids);
 }
+
+void copy_mm_to_paca(struct mm_struct *mm)
+{
+#ifdef CONFIG_PPC_BOOK3S
+	mm_context_t *context = &mm->context;
+
+	get_paca()->mm_ctx_id = context->id;
+#ifdef CONFIG_PPC_MM_SLICES
+	VM_BUG_ON(!mm->context.slb_addr_limit);
+	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
+	memcpy(&get_paca()->mm_ctx_low_slices_psize,
+	       &context->low_slices_psize, sizeof(context->low_slices_psize));
+	memcpy(&get_paca()->mm_ctx_high_slices_psize,
+	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
+#else /* CONFIG_PPC_MM_SLICES */
+	get_paca()->mm_ctx_user_psize = context->user_psize;
+	get_paca()->mm_ctx_sllp = context->sllp;
+#endif
+#else /* !CONFIG_PPC_BOOK3S */
+	return;
+#endif
+}
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 88c95dc8b141..f23a89d8e4ce 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1088,16 +1088,16 @@ unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap)
 }
 
 #ifdef CONFIG_PPC_MM_SLICES
-static unsigned int get_psize(struct mm_struct *mm, unsigned long addr)
+static unsigned int get_paca_psize(unsigned long addr)
 {
 	unsigned char *psizes;
 	unsigned long index, mask_index;
 
 	if (addr < SLICE_LOW_TOP) {
-		psizes = mm->context.low_slices_psize;
+		psizes = get_paca()->mm_ctx_low_slices_psize;
 		index = GET_LOW_SLICE_INDEX(addr);
 	} else {
-		psizes = mm->context.high_slices_psize;
+		psizes = get_paca()->mm_ctx_high_slices_psize;
 		index = GET_HIGH_SLICE_INDEX(addr);
 	}
 	mask_index = index & 0x1;
@@ -1105,9 +1105,9 @@ static unsigned int get_psize(struct mm_struct *mm, unsigned long addr)
 }
 
 #else
-unsigned int get_psize(struct mm_struct *mm, unsigned long addr)
+unsigned int get_paca_psize(unsigned long addr)
 {
-	return mm->context.user_psize;
+	return get_paca()->mm_ctx_user_psize;
 }
 #endif
 
@@ -1118,11 +1118,15 @@ unsigned int get_psize(struct mm_struct *mm, unsigned long addr)
 #ifdef CONFIG_PPC_64K_PAGES
 void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 {
-	if (get_psize(mm, addr) == MMU_PAGE_4K)
+	if (get_slice_psize(mm, addr) == MMU_PAGE_4K)
 		return;
 	slice_set_range_psize(mm, addr, 1, MMU_PAGE_4K);
 	copro_flush_all_slbs(mm);
-	core_flush_all_slbs(mm);
+	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
+
+		copy_mm_to_paca(mm);
+		slb_flush_and_rebolt();
+	}
 }
 #endif /* CONFIG_PPC_64K_PAGES */
 
@@ -1187,6 +1191,22 @@ void hash_failure_debug(unsigned long ea, unsigned long access,
 		trap, vsid, ssize, psize, lpsize, pte);
 }
 
+static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
+			     int psize, bool user_region)
+{
+	if (user_region) {
+		if (psize != get_paca_psize(ea)) {
+			copy_mm_to_paca(mm);
+			slb_flush_and_rebolt();
+		}
+	} else if (get_paca()->vmalloc_sllp !=
+		   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
+		get_paca()->vmalloc_sllp =
+			mmu_psize_defs[mmu_vmalloc_psize].sllp;
+		slb_vmalloc_update();
+	}
+}
+
 /* Result code is:
  *  0 - handled
  *  1 - normal page fault
@@ -1219,7 +1239,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 			rc = 1;
 			goto bail;
 		}
-		psize = get_psize(mm, ea);
+		psize = get_slice_psize(mm, ea);
 		ssize = user_segment_size(ea);
 		vsid = get_user_vsid(&mm->context, ea, ssize);
 		break;
@@ -1307,6 +1327,9 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 			WARN_ON(1);
 		}
 #endif
+		if (current->mm == mm)
+			check_paca_psize(ea, mm, psize, user_region);
+
 		goto bail;
 	}
 
@@ -1341,14 +1364,15 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 			       "to 4kB pages because of "
 			       "non-cacheable mapping\n");
 			psize = mmu_vmalloc_psize = MMU_PAGE_4K;
-			slb_vmalloc_update();
 			copro_flush_all_slbs(mm);
-			core_flush_all_slbs(mm);
 		}
 	}
 
 #endif /* CONFIG_PPC_64K_PAGES */
 
+	if (current->mm == mm)
+		check_paca_psize(ea, mm, psize, user_region);
+
 #ifdef CONFIG_PPC_64K_PAGES
 	if (psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
@@ -1436,7 +1460,7 @@ int __hash_page(unsigned long ea, unsigned long msr, unsigned long trap,
 #ifdef CONFIG_PPC_MM_SLICES
 static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
 {
-	int psize = get_psize(mm, ea);
+	int psize = get_slice_psize(mm, ea);
 
 	/* We only prefault standard pages for now */
 	if (unlikely(psize != mm->context.user_psize))
diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
index 28ae2835db3d..f84e14f23e50 100644
--- a/arch/powerpc/mm/mmu_context.c
+++ b/arch/powerpc/mm/mmu_context.c
@@ -54,7 +54,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		 * MMU context id, which is then moved to SPRN_PID.
 		 *
 		 * For the hash MMU it is either the first load from slb_cache
-		 * in switch_slb(), and/or load of MMU context id.
+		 * in switch_slb(), and/or the store of paca->mm_ctx_id in
+		 * copy_mm_to_paca().
 		 *
 		 * On the other side, the barrier is in mm/tlb-radix.c for
 		 * radix which orders earlier stores to clear the PTEs vs
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index b438220c4336..74c3b6f8e9b7 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -430,6 +430,8 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	}
 	get_paca()->slb_used_bitmap = get_paca()->slb_kern_bitmap;
 
+	copy_mm_to_paca(mm);
+
 	/*
 	 * We gradually age out SLBs after a number of context switches to
 	 * reduce reload overhead of unused entries (like we do with FP/VEC
@@ -460,24 +462,6 @@ void slb_set_size(u16 size)
 	mmu_slb_size = size;
 }
 
-static void cpu_flush_slb(void *parm)
-{
-	struct mm_struct *mm = parm;
-	unsigned long flags;
-
-	if (mm != current->active_mm)
-		return;
-
-	local_irq_save(flags);
-	slb_flush_and_rebolt();
-	local_irq_restore(flags);
-}
-
-void core_flush_all_slbs(struct mm_struct *mm)
-{
-	on_each_cpu(cpu_flush_slb, mm, 1);
-}
-
 void slb_initialize(void)
 {
 	unsigned long linear_llp, vmalloc_llp, io_llp;
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index fc5b3a1ec666..546dd07c8083 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -207,6 +207,23 @@ static bool slice_check_range_fits(struct mm_struct *mm,
 	return true;
 }
 
+static void slice_flush_segments(void *parm)
+{
+#ifdef CONFIG_PPC64
+	struct mm_struct *mm = parm;
+	unsigned long flags;
+
+	if (mm != current->active_mm)
+		return;
+
+	copy_mm_to_paca(current->active_mm);
+
+	local_irq_save(flags);
+	slb_flush_and_rebolt();
+	local_irq_restore(flags);
+#endif
+}
+
 static void slice_convert(struct mm_struct *mm,
 				const struct slice_mask *mask, int psize)
 {
@@ -272,9 +289,6 @@ static void slice_convert(struct mm_struct *mm,
 	spin_unlock_irqrestore(&slice_convert_lock, flags);
 
 	copro_flush_all_slbs(mm);
-#ifdef CONFIG_PPC64
-	core_flush_all_slbs(mm);
-#endif
 }
 
 /*
@@ -488,9 +502,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		 * be already initialised beyond the old address limit.
 		 */
 		mm->context.slb_addr_limit = high_limit;
-#ifdef CONFIG_PPC64
-		core_flush_all_slbs(mm);
-#endif
+
+		on_each_cpu(slice_flush_segments, mm, 1);
 	}
 
 	/* Sanity checks */
@@ -652,10 +665,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 		(SLICE_NUM_HIGH &&
 		 !bitmap_empty(potential_mask.high_slices, SLICE_NUM_HIGH))) {
 		slice_convert(mm, &potential_mask, psize);
-#ifdef CONFIG_PPC64
 		if (psize > MMU_PAGE_BASE)
-			core_flush_all_slbs(mm);
-#endif
+			on_each_cpu(slice_flush_segments, mm, 1);
 	}
 	return newaddr;
 
-- 
2.18.0

