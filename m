Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D38541A0171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:12:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/6] mm/gup: Replace ACCESS_ONCE with READ_ONCE for
 STRICT_MM_TYPECHECKS
Date: Wed, 25 Mar 2015 20:11:58 +1100
Message-Id: <1427274719-25890-5-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
References: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
Cc: aarcange@redhat.com, aneesh.kumar@in.ibm.com, steve.capper@linaro.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
 akpm@linux-foundation.org, kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If STRICT_MM_TYPECHECKS is enabled the generic gup code fails to build
because we are using ACCESS_ONCE on non-scalar types.

Convert all uses to READ_ONCE.

Cc: akpm@linux-foundation.org
Cc: kirill.shutemov@linux.intel.com
Cc: aarcange@redhat.com
Cc: borntraeger@de.ibm.com
Cc: steve.capper@linaro.org
Cc: linux-mm@kvack.org
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 mm/gup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a6e24e246f86..120c3adc843c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -901,7 +901,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		 *
 		 * for an example see gup_get_pte in arch/x86/mm/gup.c
 		 */
-		pte_t pte = ACCESS_ONCE(*ptep);
+		pte_t pte = READ_ONCE(*ptep);
 		struct page *page;
 
 		/*
@@ -1191,7 +1191,7 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
 	local_irq_save(flags);
 	pgdp = pgd_offset(mm, addr);
 	do {
-		pgd_t pgd = ACCESS_ONCE(*pgdp);
+		pgd_t pgd = READ_ONCE(*pgdp);
 
 		next = pgd_addr_end(addr, end);
 		if (pgd_none(pgd))
-- 
2.1.0
