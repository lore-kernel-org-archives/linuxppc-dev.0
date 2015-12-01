Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEB901A1AD8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:25 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:22 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 96907E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:08:00 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bIqG60883138
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:18 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bGPb022560
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 33/35] powerpc/nohash: we don't use real_pte_t for nohash
Date: Tue,  1 Dec 2015 09:06:58 +0530
Message-Id: <1448941020-15168-34-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the related functions and #defines

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/nohash/64/pgtable.h | 33 ----------------------------
 1 file changed, 33 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 03c226965b46..b9f734dd5b81 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -106,39 +106,6 @@
 #endif /* CONFIG_PPC_MM_SLICES */
 
 #ifndef __ASSEMBLY__
-
-/*
- * This is the default implementation of various PTE accessors, it's
- * used in all cases except Book3S with 64K pages where we have a
- * concept of sub-pages
- */
-#ifndef __real_pte
-
-#ifdef CONFIG_STRICT_MM_TYPECHECKS
-#define __real_pte(e,p)		((real_pte_t){(e)})
-#define __rpte_to_pte(r)	((r).pte)
-#else
-#define __real_pte(e,p)		(e)
-#define __rpte_to_pte(r)	(__pte(r))
-#endif
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> _PAGE_F_GIX_SHIFT)
-
-#define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
-	do {							         \
-		index = 0;					         \
-		shift = mmu_psize_defs[psize].shift;		         \
-
-#define pte_iterate_hashed_end() } while(0)
-
-/*
- * We expect this to be called only for user addresses or kernel virtual
- * addresses other than the linear mapping.
- */
-#define pte_pagesize_index(mm, addr, pte)	MMU_PAGE_4K
-
-#endif /* __real_pte */
-
-
 /* pte_clear moved to later in this file */
 
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
-- 
2.5.0
