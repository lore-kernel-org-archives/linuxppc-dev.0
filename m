Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922DFC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:28:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BA2920895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 13:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BA2920895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XQWw6rsRzF3Bl
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 00:28:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XQJx06zxzF3D5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 00:19:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42XQJw6Hrzz9sB5; Sun, 14 Oct 2018 00:19:12 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42XQJw5pswz9sCW; Sun, 14 Oct 2018 00:19:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/6] powerpc/64s/hash: Provide arch_setup_exec() hooks for
 hash slice setup
Date: Sun, 14 Oct 2018 00:18:33 +1100
Message-Id: <20181013131836.26764-3-mpe@ellerman.id.au>
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

This will be used by the SLB code in the next patch, but for now this
sets the slb_addr_limit to the correct size for 32-bit tasks.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 ++
 arch/powerpc/include/asm/slice.h              |  1 +
 arch/powerpc/include/asm/thread_info.h        |  6 ++++++
 arch/powerpc/kernel/process.c                 |  9 +++++++++
 arch/powerpc/mm/mmu_context_book3s64.c        |  5 +++++
 arch/powerpc/mm/slice.c                       | 14 ++++++++++++++
 6 files changed, 37 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index e0e4ce8f77d6..14e552ea5e52 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -487,6 +487,8 @@ int htab_remove_mapping(unsigned long vstart, unsigned long vend,
 extern void pseries_add_gpage(u64 addr, u64 page_size, unsigned long number_of_pages);
 extern void demote_segment_4k(struct mm_struct *mm, unsigned long addr);
 
+extern void hash__setup_new_exec(void);
+
 #ifdef CONFIG_PPC_PSERIES
 void hpte_init_pseries(void);
 #else
diff --git a/arch/powerpc/include/asm/slice.h b/arch/powerpc/include/asm/slice.h
index e40406cf5628..a595461c9cb0 100644
--- a/arch/powerpc/include/asm/slice.h
+++ b/arch/powerpc/include/asm/slice.h
@@ -32,6 +32,7 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize);
 
 void slice_init_new_context_exec(struct mm_struct *mm);
+void slice_setup_new_exec(void);
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 3185f8ac1182..916a3d67b592 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -72,6 +72,12 @@ static inline struct thread_info *current_thread_info(void)
 }
 
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
+
+#ifdef CONFIG_PPC_BOOK3S_64
+void arch_setup_new_exec(void);
+#define arch_setup_new_exec arch_setup_new_exec
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 /*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f9d1cca28cce..96cd9cd1a119 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1490,6 +1490,15 @@ void flush_thread(void)
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+void arch_setup_new_exec(void)
+{
+	if (radix_enabled())
+		return;
+	hash__setup_new_exec();
+}
+#endif
+
 int set_thread_uses_vas(void)
 {
 #ifdef CONFIG_PPC_BOOK3S_64
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index dbd8f762140b..f7352c66b6b8 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -84,6 +84,11 @@ static int hash__init_new_context(struct mm_struct *mm)
 	return index;
 }
 
+void hash__setup_new_exec(void)
+{
+	slice_setup_new_exec();
+}
+
 static int radix__init_new_context(struct mm_struct *mm)
 {
 	unsigned long rts_field;
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 205fe557ca10..546dd07c8083 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -757,6 +757,20 @@ void slice_init_new_context_exec(struct mm_struct *mm)
 		bitmap_fill(mask->high_slices, SLICE_NUM_HIGH);
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
+void slice_setup_new_exec(void)
+{
+	struct mm_struct *mm = current->mm;
+
+	slice_dbg("slice_setup_new_exec(mm=%p)\n", mm);
+
+	if (!is_32bit_task())
+		return;
+
+	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
+}
+#endif
+
 void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 			   unsigned long len, unsigned int psize)
 {
-- 
2.17.1

