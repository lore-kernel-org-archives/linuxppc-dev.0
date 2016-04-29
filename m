Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxk727QzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 10/70] powerpc/mm: Use pte_user() instead of open coding
Date: Fri, 29 Apr 2016 23:25:33 +1000
Message-Id: <1461936393-10131-10-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We have a common declaration in pte-common.h Add a book3s specific one
and switch to pte_user() in callchain.c. In a subsequent patch we will
switch _PAGE_USER to _PAGE_PRIVILEGED in the book3s version only.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 5 +++++
 arch/powerpc/perf/callchain.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 77d3ce05798e..60e84260a07d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -185,6 +185,11 @@ extern struct page *pgd_page(pgd_t pgd);
 #define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
 #define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
 
+static inline bool pte_user(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_USER);
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
