Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 102B41A1D2E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:09 +1000 (AEST)
Message-Id: <695716d50f9e5f93357e6a25789d56d064ae9f8c.1439382635.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 07/20] powerpc32: refactor x_mapped_by_bats() and
 x_mapped_by_tlbcam() together
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:06 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

x_mapped_by_bats() and x_mapped_by_tlbcam() serve the same kind of
purpose, so lets group them into a single function.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable_32.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 03a073a..3fd9083 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -67,6 +67,28 @@ extern unsigned long p_mapped_by_tlbcam(phys_addr_t pa);
 #define p_mapped_by_tlbcam(x)	(0UL)
 #endif /* HAVE_TLBCAM */
 
+static inline unsigned long p_mapped_by_other(phys_addr_t pa)
+{
+	unsigned long v;
+
+	v = p_mapped_by_bats(pa);
+	if (v /*&& p_mapped_by_bats(p+size-1)*/)
+		return v;
+
+	return p_mapped_by_tlbcam(pa);
+}
+
+static inline phys_addr_t v_mapped_by_other(unsigned long va)
+{
+	phys_addr_t p;
+
+	p = v_mapped_by_bats(va);
+	if (p)
+		return p;
+
+	return v_mapped_by_tlbcam(va);
+}
+
 #define PGDIR_ORDER	(32 + PGD_T_LOG2 - PGDIR_SHIFT)
 
 #ifndef CONFIG_PPC_4K_PAGES
@@ -237,10 +259,8 @@ __ioremap_caller(phys_addr_t addr, unsigned long size, unsigned long flags,
 	 * same virt address (and this is contiguous).
 	 *  -- Cort
 	 */
-	if ((v = p_mapped_by_bats(p)) /*&& p_mapped_by_bats(p+size-1)*/ )
-		goto out;
-
-	if ((v = p_mapped_by_tlbcam(p)))
+	v = p_mapped_by_other(p);
+	if (v)
 		goto out;
 
 	if (slab_is_available()) {
@@ -278,8 +298,7 @@ void iounmap(volatile void __iomem *addr)
 	 * If mapped by BATs then there is nothing to do.
 	 * Calling vfree() generates a benign warning.
 	 */
-	if (v_mapped_by_bats((unsigned long)addr) ||
-	    v_mapped_by_tlbcam((unsigned long)addr))
+	if (v_mapped_by_other((unsigned long)addr))
 		return;
 
 	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
@@ -405,7 +424,7 @@ static int __change_page_attr(struct page *page, pgprot_t prot)
 	BUG_ON(PageHighMem(page));
 	address = (unsigned long)page_address(page);
 
-	if (v_mapped_by_bats(address) || v_mapped_by_tlbcam(address))
+	if (v_mapped_by_other(address))
 		return 0;
 	if (!get_pteptr(&init_mm, address, &kpte, &kpmd))
 		return -EINVAL;
-- 
2.1.0
