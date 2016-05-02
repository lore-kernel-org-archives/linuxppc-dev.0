Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qz1Nn5v7zzDqCj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 20:52:57 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 2 May 2016 20:52:56 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id ECAF02CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 20:52:53 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u42Aqj6t7864604
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 20:52:53 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u42AqLbV005422
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 May 2016 20:52:21 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/mm/subpage: Init user psize correctly
Date: Mon,  2 May 2016 16:21:50 +0530
Message-Id: <1462186311-1323-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check against a context.id value of zero instead of MMU_NO_CONTEXT
when doing a slice psize init. Without this patch we end up with
a slice psize value of zero and we always end up using 4K hpte.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mmu_context_book3s64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index b5288b460bef..a28ed6a96286 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -85,8 +85,16 @@ int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 		/* The old code would re-promote on fork, we don't do that
 		 * when using slices as it could cause problem promoting slices
 		 * that have been forced down to 4K
+		 *
+		 * For book3s we have MMU_NO_CONTEXT set to be ~0. Hence check
+		 * explicitly against context.id == 0. This ensures that we
+		 * properly initialize context slice details for newly allocated
+		 * mm and don't alter context slice inherited via fork.
+		 *
+		 * We should not be calling init_new_context on init_mm. Hence a
+		 * check against 0 is ok.
 		 */
-		if (slice_mm_new_context(mm))
+		if (mm->context.id == 0)
 			slice_set_user_psize(mm, mmu_virtual_psize);
 		subpage_prot_init_new_context(mm);
 	}
-- 
2.7.4
