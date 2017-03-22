Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnwPZ4s4YzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 14:38:10 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2M3T9ai125057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:08 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29b9vmagmd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 23:38:08 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 21:38:07 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 13/17] powerpc/mm/hash: Store task size in PACA
Date: Wed, 22 Mar 2017 09:06:59 +0530
In-Reply-To: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1490153823-29241-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1490153823-29241-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We optmize the slice page size array copy to paca by copying only the
range based on task size. This will require us to not look at page size
array beyond task size in PACA on slb fault. To enable that copy task size
to paca which will be used during slb fault.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h   | 4 +++-
 arch/powerpc/kernel/asm-offsets.c | 4 ++++
 arch/powerpc/kernel/paca.c        | 1 +
 arch/powerpc/mm/slb_low.S         | 8 +++++++-
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index f48c250339fd..25f4a1c14759 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -144,7 +144,9 @@ struct paca_struct {
 	u16 mm_ctx_sllp;
 #endif
 #endif
-
+#ifdef CONFIG_PPC_STD_MMU_64
+	u64 task_size;
+#endif
 	/*
 	 * then miscellaneous read-write fields
 	 */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4367e7df51a1..a60ef1d976ab 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -189,6 +189,10 @@ int main(void)
 #endif /* CONFIG_PPC_MM_SLICES */
 #endif
 
+#ifdef CONFIG_PPC_STD_MMU_64
+	DEFINE(PACATASKSIZE, offsetof(struct paca_struct, task_size));
+#endif
+
 #ifdef CONFIG_PPC_BOOK3E
 	OFFSET(PACAPGD, paca_struct, pgd);
 	OFFSET(PACA_KERNELPGD, paca_struct, kernel_pgd);
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index bffdbd6d6774..50b60e23d07f 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -254,6 +254,7 @@ void copy_mm_to_paca(struct mm_struct *mm)
 	get_paca()->mm_ctx_id = context->id;
 #ifdef CONFIG_PPC_MM_SLICES
 	VM_BUG_ON(!mm->task_size);
+	get_paca()->task_size = mm->task_size;
 	get_paca()->mm_ctx_low_slices_psize = context->low_slices_psize;
 	memcpy(&get_paca()->mm_ctx_high_slices_psize,
 	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 35e91e89640f..b09e7748856f 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -149,7 +149,13 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	 * For userspace addresses, make sure this is region 0.
 	 */
 	cmpdi	r9, 0
-	bne	8f
+	bne-	8f
+        /*
+         * user space make sure we are within the allowed limit
+	 */
+	ld	r11,PACATASKSIZE(r13)
+	cmpld	r3,r11
+	bge-	8f
 
 	/* when using slices, we extract the psize off the slice bitmaps
 	 * and then we need to get the sllp encoding off the mmu_psize_defs
-- 
2.7.4
