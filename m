Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id C0A7C1A0570
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:41 +1000 (AEST)
Message-Id: <8d187921d6efdad878aa3a5c5195cd6a16fa0b37.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 04/25] powerpc/8xx: move setup_initial_memory_limit() into
 8xx_mmu.c
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:36 +0200 (CEST)
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
No change in v2

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
