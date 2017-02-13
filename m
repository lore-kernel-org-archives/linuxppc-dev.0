Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMCr11KSwzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 15:53:52 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1D4mufq121409
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 23:53:50 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28jgbpstux-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 23:53:50 -0500
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 12 Feb 2017 23:53:50 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 5/7] powerpc/mm: Move copy_mm_to_paca to paca.c
Date: Mon, 13 Feb 2017 10:23:11 +0530
In-Reply-To: <1486961593-32365-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486961593-32365-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1486961593-32365-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will be updating this later to use struct mm_struct. Move this so that function
finds the definition of struct mm_struct;

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h | 18 +-----------------
 arch/powerpc/kernel/paca.c      | 19 +++++++++++++++++++
 arch/powerpc/mm/hash_utils_64.c |  4 ++--
 arch/powerpc/mm/slb.c           |  2 +-
 arch/powerpc/mm/slice.c         |  2 +-
 5 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6a6792bb39fb..f25d3c93a30f 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -207,23 +207,7 @@ struct paca_struct {
 #endif
 };
 
-#ifdef CONFIG_PPC_BOOK3S
-static inline void copy_mm_to_paca(mm_context_t *context)
-{
-	get_paca()->mm_ctx_id = context->id;
-#ifdef CONFIG_PPC_MM_SLICES
-	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
-	memcpy(&get_paca()->mm_ctx_high_slices_psize,
-	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
-#else
-	get_paca()->mm_ctx_user_psize = context->user_psize;
-	get_paca()->mm_ctx_sllp = context->sllp;
-#endif
-}
-#else
-static inline void copy_mm_to_paca(mm_context_t *context){}
-#endif
-
+extern void copy_mm_to_paca(struct mm_struct *mm);
 extern struct paca_struct *paca;
 extern void initialise_paca(struct paca_struct *new_paca, int cpu);
 extern void setup_paca(struct paca_struct *new_paca);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index fa20060ff7a5..b64daf124fee 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -244,3 +244,22 @@ void __init free_unused_pacas(void)
 
 	free_lppacas();
 }
+
+void copy_mm_to_paca(struct mm_struct *mm)
+{
+#ifdef CONFIG_PPC_BOOK3S
+	mm_context_t *context = &mm->context;
+
+	get_paca()->mm_ctx_id = context->id;
+#ifdef CONFIG_PPC_MM_SLICES
+	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
+	memcpy(&get_paca()->mm_ctx_high_slices_psize,
+	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
+#else /* CONFIG_PPC_MM_SLICES */
+	get_paca()->mm_ctx_user_psize = context->user_psize;
+	get_paca()->mm_ctx_sllp = context->sllp;
+#endif
+#else /* CONFIG_PPC_BOOK3S */
+	return;
+#endif
+}
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 978314b6b8d7..67937a6eb541 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1084,7 +1084,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
 	copro_flush_all_slbs(mm);
 	if ((get_paca_psize(addr) != MMU_PAGE_4K) && (current->mm == mm)) {
 
-		copy_mm_to_paca(&mm->context);
+		copy_mm_to_paca(mm);
 		slb_flush_and_rebolt();
 	}
 }
@@ -1156,7 +1156,7 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
 {
 	if (user_region) {
 		if (psize != get_paca_psize(ea)) {
-			copy_mm_to_paca(&mm->context);
+			copy_mm_to_paca(mm);
 			slb_flush_and_rebolt();
 		}
 	} else if (get_paca()->vmalloc_sllp !=
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 48fc28bab544..15157b14b0b6 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -227,7 +227,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 		asm volatile("slbie %0" : : "r" (slbie_data));
 
 	get_paca()->slb_cache_ptr = 0;
-	copy_mm_to_paca(&mm->context);
+	copy_mm_to_paca(mm);
 
 	/*
 	 * preload some userspace segments into the SLB.
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 0ec750adbe7f..116868bb91f5 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -190,7 +190,7 @@ static void slice_flush_segments(void *parm)
 	if (mm != current->active_mm)
 		return;
 
-	copy_mm_to_paca(&current->active_mm->context);
+	copy_mm_to_paca(current->active_mm);
 
 	local_irq_save(flags);
 	slb_flush_and_rebolt();
-- 
2.7.4
