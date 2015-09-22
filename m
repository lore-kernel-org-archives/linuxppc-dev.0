Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 0D8631A0352
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:41 +1000 (AEST)
Message-Id: <2b94a5b931daa6aa2f32ddad88175d932da4d573.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 06/25] powerpc32: iounmap() cannot vunmap() area mapped by
 TLBCAMs either
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:40 +0200 (CEST)
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
No change in v2

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
