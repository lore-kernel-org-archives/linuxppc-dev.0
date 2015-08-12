Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 969C81A1D2E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:03 +1000 (AEST)
Message-Id: <c5e4a7a8cee211720399b2149147eca442661639.1439382635.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 04/20] powerpc/8xx: move setup_initial_memory_limit() into
 8xx_mmu.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:00 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now we have a 8xx specific .c file for that so put it in there
as other powerpc variants do

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/8xx_mmu.c | 17 +++++++++++++++++
 arch/powerpc/mm/init_32.c | 19 -------------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index be6f041..0ddcb37 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -81,3 +81,20 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 
 	return mapped;
 }
+
+void setup_initial_memory_limit(phys_addr_t first_memblock_base,
+				phys_addr_t first_memblock_size)
+{
+	/* We don't currently support the first MEMBLOCK not mapping 0
+	 * physical on those processors
+	 */
+	BUG_ON(first_memblock_base != 0);
+
+#ifdef CONFIG_PIN_TLB
+	/* 8xx can only access 24MB at the moment */
+	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
+#else
+	/* 8xx can only access 8MB at the moment */
+	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x00800000));
+#endif
+}
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index a10be66..1a18e4b 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -193,22 +193,3 @@ void __init MMU_init(void)
 	/* Shortly after that, the entire linear mapping will be available */
 	memblock_set_current_limit(lowmem_end_addr);
 }
-
-#ifdef CONFIG_8xx /* No 8xx specific .c file to put that in ... */
-void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
-{
-	/* We don't currently support the first MEMBLOCK not mapping 0
-	 * physical on those processors
-	 */
-	BUG_ON(first_memblock_base != 0);
-
-#ifdef CONFIG_PIN_TLB
-	/* 8xx can only access 24MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x01800000));
-#else
-	/* 8xx can only access 8MB at the moment */
-	memblock_set_current_limit(min_t(u64, first_memblock_size, 0x00800000));
-#endif
-}
-#endif /* CONFIG_8xx */
-- 
2.1.0
