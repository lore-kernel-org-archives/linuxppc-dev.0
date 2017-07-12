Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6vmd1SLVzDqjb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:08:48 +1000 (AEST)
Message-Id: <c50fa95f2cf32fe602108861064a950881012c46.1499633349.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1499633349.git.christophe.leroy@c-s.fr>
References: <cover.1499633349.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/7] powerpc/8xx: Ensures RAM mapped with LTLB is seen as
 block mapped on 8xx.
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Jul 2017 12:08:45 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On the 8xx, the RAM mapped with LTLBs must be seen as block mapped,
just like areas mapped with BATs on standard PPC32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/8xx_mmu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index f4c6472f2fc4..f3a00cef9c34 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -22,8 +22,11 @@
 
 extern int __map_without_ltlbs;
 
+static unsigned long block_mapped_ram;
+
 /*
- * Return PA for this VA if it is in IMMR area, or 0
+ * Return PA for this VA if it is in an area mapped with LTLBs.
+ * Otherwise, returns 0
  */
 phys_addr_t v_block_mapped(unsigned long va)
 {
@@ -33,11 +36,13 @@ phys_addr_t v_block_mapped(unsigned long va)
 		return 0;
 	if (va >= VIRT_IMMR_BASE && va < VIRT_IMMR_BASE + IMMR_SIZE)
 		return p + va - VIRT_IMMR_BASE;
+	if (va >= PAGE_OFFSET && va < PAGE_OFFSET + block_mapped_ram)
+		return __pa(va);
 	return 0;
 }
 
 /*
- * Return VA for a given PA or 0 if not mapped
+ * Return VA for a given PA mapped with LTLBs or 0 if not mapped
  */
 unsigned long p_block_mapped(phys_addr_t pa)
 {
@@ -47,6 +52,8 @@ unsigned long p_block_mapped(phys_addr_t pa)
 		return 0;
 	if (pa >= p && pa < p + IMMR_SIZE)
 		return VIRT_IMMR_BASE + pa - p;
+	if (pa < block_mapped_ram)
+		return (unsigned long)__va(pa);
 	return 0;
 }
 
@@ -133,6 +140,8 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	if (mapped)
 		memblock_set_current_limit(mapped);
 
+	block_mapped_ram = mapped;
+
 	return mapped;
 }
 
-- 
2.12.0
