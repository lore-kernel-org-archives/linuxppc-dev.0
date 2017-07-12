Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6vms56tnzDqjy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 20:09:01 +1000 (AEST)
Message-Id: <630dc639c7321ac9afbe124eaee27165ef7ce08a.1499633349.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1499633349.git.christophe.leroy@c-s.fr>
References: <cover.1499633349.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/7] powerpc/8xx: mark init functions with __init
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 12 Jul 2017 12:08:55 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

setup_initial_memory_limit() is only called during init.
mmu_patch_cmp_limit() is only called from 8xx_mmu.c

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/8xx_mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index ab3b10746f36..f29212e40f40 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -87,7 +87,7 @@ void __init MMU_init_hw(void)
 #endif
 }
 
-static void mmu_mapin_immr(void)
+static void __init mmu_mapin_immr(void)
 {
 	unsigned long p = PHYS_IMMR_BASE;
 	unsigned long v = VIRT_IMMR_BASE;
@@ -107,7 +107,7 @@ extern unsigned int DTLBMiss_cmp, FixupDAR_cmp;
 extern unsigned int ITLBMiss_cmp;
 #endif
 
-void mmu_patch_cmp_limit(unsigned int *addr, unsigned long mapped)
+static void __init mmu_patch_cmp_limit(unsigned int *addr, unsigned long mapped)
 {
 	unsigned int instr = *addr;
 
@@ -151,8 +151,8 @@ unsigned long __init mmu_mapin_ram(unsigned long top)
 	return mapped;
 }
 
-void setup_initial_memory_limit(phys_addr_t first_memblock_base,
-				phys_addr_t first_memblock_size)
+void __init setup_initial_memory_limit(phys_addr_t first_memblock_base,
+				       phys_addr_t first_memblock_size)
 {
 	/* We don't currently support the first MEMBLOCK not mapping 0
 	 * physical on those processors
-- 
2.12.0
