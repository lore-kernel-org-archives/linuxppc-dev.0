Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRvPH3hYrzDqb6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 20:50:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: rashmicy@gmail.com
Subject: [PATCH] powerpc/mm: Fix crash in page table dump with huge pages
Date: Tue, 16 May 2017 20:50:35 +1000
Message-Id: <1494931835-3813-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The page table dump code doesn't know about huge pages, so currently
it crashes (or walks random memory, usually leading to a crash), if it
finds a huge page. On Book3S we only see huge pages in the Linux page
tables when we're using the P9 Radix MMU.

Teaching the code to properly handle huge pages is a bit more involved,
so for now just prevent the crash.

Cc: stable@vger.kernel.org # v4.10+
Fixes: 8eb07b187000 ("powerpc/mm: Dump linux pagetables")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/dump_linuxpagetables.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/dump_linuxpagetables.c b/arch/powerpc/mm/dump_linuxpagetables.c
index d659345a98d6..6070d3d60ef1 100644
--- a/arch/powerpc/mm/dump_linuxpagetables.c
+++ b/arch/powerpc/mm/dump_linuxpagetables.c
@@ -391,7 +391,7 @@ static void walk_pmd(struct pg_state *st, pud_t *pud, unsigned long start)
 
 	for (i = 0; i < PTRS_PER_PMD; i++, pmd++) {
 		addr = start + i * PMD_SIZE;
-		if (!pmd_none(*pmd))
+		if (!pmd_none(*pmd) && !pmd_huge(*pmd))
 			/* pmd exists */
 			walk_pte(st, pmd, addr);
 		else
@@ -407,7 +407,7 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 
 	for (i = 0; i < PTRS_PER_PUD; i++, pud++) {
 		addr = start + i * PUD_SIZE;
-		if (!pud_none(*pud))
+		if (!pud_none(*pud) && !pud_huge(*pud))
 			/* pud exists */
 			walk_pmd(st, pud, addr);
 		else
@@ -427,7 +427,7 @@ static void walk_pagetables(struct pg_state *st)
 	 */
 	for (i = 0; i < PTRS_PER_PGD; i++, pgd++) {
 		addr = KERN_VIRT_START + i * PGDIR_SIZE;
-		if (!pgd_none(*pgd))
+		if (!pgd_none(*pgd) && !pgd_huge(*pgd))
 			/* pgd exists */
 			walk_pud(st, pgd, addr);
 		else
-- 
2.7.4
