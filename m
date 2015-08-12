Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 143091A1D2D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:07 +1000 (AEST)
Message-Id: <d6b368478df22450db3786649b04dd66dd9c5f0e.1439382635.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 06/20] powerpc32: iounmap() cannot vunmap() area mapped by
 TLBCAMs either
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:04 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

iounmap() cannot vunmap() area mapped by TLBCAMs either

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable_32.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 7692d1b..03a073a 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -278,7 +278,9 @@ void iounmap(volatile void __iomem *addr)
 	 * If mapped by BATs then there is nothing to do.
 	 * Calling vfree() generates a benign warning.
 	 */
-	if (v_mapped_by_bats((unsigned long)addr)) return;
+	if (v_mapped_by_bats((unsigned long)addr) ||
+	    v_mapped_by_tlbcam((unsigned long)addr))
+		return;
 
 	if (addr > high_memory && (unsigned long) addr < ioremap_bot)
 		vunmap((void *) (PAGE_MASK & (unsigned long)addr));
-- 
2.1.0
