Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDA151A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 01:50:19 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 06:39:58 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 6BFA63E4005E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 06:39:57 -0700 (MST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u27DdubE27590806
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 13:39:56 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27Ddu16032568
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 08:39:56 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 04/14] powerpc/mm: Use pte_user instead of opencoding
Date: Mon,  7 Mar 2016 19:09:24 +0530
Message-Id: <1457357974-20839-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have common declaration in pte-common.h Add book3s specific one
and switch to pte_user. In the later patch we will be switching
_PAGE_USER to _PAGE_PRIVILEGED

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 5 +++++
 arch/powerpc/perf/callchain.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 77d3ce05798e..4ac6221802ad 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -185,6 +185,11 @@ extern struct page *pgd_page(pgd_t pgd);
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
 #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
 
+static inline bool pte_user(pte_t pte)
+{
+	return (pte_val(pte) & _PAGE_USER);
+}
+
 #ifdef CONFIG_MEM_SOFT_DIRTY
 #define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
 #else
diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
index e04a6752b399..0071de76d776 100644
--- a/arch/powerpc/perf/callchain.c
+++ b/arch/powerpc/perf/callchain.c
@@ -137,7 +137,7 @@ static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
 	offset = addr & ((1UL << shift) - 1);
 
 	pte = READ_ONCE(*ptep);
-	if (!pte_present(pte) || !(pte_val(pte) & _PAGE_USER))
+	if (!pte_present(pte) || !pte_user(pte))
 		goto err_out;
 	pfn = pte_pfn(pte);
 	if (!page_is_ram(pfn))
-- 
2.5.0
