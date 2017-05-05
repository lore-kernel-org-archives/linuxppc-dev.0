Return-Path: <pasha.tatashin@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wKJBb25lxzDqCv
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 May 2017 03:03:35 +1000 (AEST)
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net
Subject: [v3 1/9] sparc64: simplify vmemmap_populate
Date: Fri,  5 May 2017 13:03:08 -0400
Message-Id: <1494003796-748672-2-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove duplicating code, by using common functions
vmemmap_pud_populate and vmemmap_pgd_populate functions.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/mm/init_64.c |   23 ++++++-----------------
 1 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 0cda653..14cc1fc 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2530,30 +2530,19 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 	vstart = vstart & PMD_MASK;
 	vend = ALIGN(vend, PMD_SIZE);
 	for (; vstart < vend; vstart += PMD_SIZE) {
-		pgd_t *pgd = pgd_offset_k(vstart);
+		pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
 		unsigned long pte;
 		pud_t *pud;
 		pmd_t *pmd;
 
-		if (pgd_none(*pgd)) {
-			pud_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
+		if (!pgd)
+			return -ENOMEM;
 
-			if (!new)
-				return -ENOMEM;
-			pgd_populate(&init_mm, pgd, new);
-		}
-
-		pud = pud_offset(pgd, vstart);
-		if (pud_none(*pud)) {
-			pmd_t *new = vmemmap_alloc_block(PAGE_SIZE, node);
-
-			if (!new)
-				return -ENOMEM;
-			pud_populate(&init_mm, pud, new);
-		}
+		pud = vmemmap_pud_populate(pgd, vstart, node);
+		if (!pud)
+			return -ENOMEM;
 
 		pmd = pmd_offset(pud, vstart);
-
 		pte = pmd_val(*pmd);
 		if (!(pte & _PAGE_VALID)) {
 			void *block = vmemmap_alloc_block(PMD_SIZE, node);
-- 
1.7.1
