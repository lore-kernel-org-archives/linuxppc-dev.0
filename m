Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzkrx5hfszDq6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 01:01:21 +1000 (AEST)
Message-Id: <79e1d41f9e91bc3450dac1e8a90c4fb07f031f84.1462052178.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1462052178.git.christophe.leroy@c-s.fr>
References: <cover.1462052178.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/7] powerpc/8xx: Fix vaddr for IMMR early remap
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue,  3 May 2016 17:01:17 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory: 124428K/131072K available (3748K kernel code, 188K rwdata,
648K rodata, 508K init, 290K bss, 6644K reserved)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfde00000..0xfe000000  : consistent mem
  * 0xfddf6000..0xfde00000  : early ioremap
  * 0xc9000000..0xfddf6000  : vmalloc & ioremap
SLUB: HWalign=16, Order=0-3, MinObjects=0, CPUs=1, Nodes=1

Today, IMMR is mapped 1:1 at startup

Mapping IMMR 1:1 is just wrong because it may overlap with another
area. On most mpc8xx boards it is OK as IMMR is set to 0xff000000
but for instance on EP88xC board, IMMR is at 0xfa200000 which
overlaps with VM ioremap area

This patch fixes the virtual address for remapping IMMR with the fixmap
regardless of the value of IMMR.

The size of IMMR area is 256kbytes (CPM at offset 0, security engine
at offset 128k) so a 512k page is enough

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/fixmap.h |  7 +++++++
 arch/powerpc/kernel/asm-offsets.c |  8 ++++++++
 arch/powerpc/kernel/head_8xx.S    | 11 ++++++-----
 arch/powerpc/mm/mmu_decl.h        |  7 +++++++
 arch/powerpc/sysdev/cpm_common.c  | 15 ++++++++++++---
 5 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 90f604b..4508b32 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -51,6 +51,13 @@ enum fixed_addresses {
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN+(KM_TYPE_NR*NR_CPUS)-1,
 #endif
+#ifdef CONFIG_PPC_8xx
+	/* For IMMR we need an aligned 512K area */
+#define FIX_IMMR_SIZE	(512 * 1024 / PAGE_SIZE)
+	FIX_IMMR_START,
+	FIX_IMMR_BASE = __ALIGN_MASK(FIX_IMMR_START, FIX_IMMR_SIZE - 1) - 1 +
+		       FIX_IMMR_SIZE,
+#endif
 	/* FIX_PCIE_MCFG, */
 	__end_of_fixed_addresses
 };
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 9ea0955..2652233 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -68,6 +68,10 @@
 #include "../mm/mmu_decl.h"
 #endif
 
+#ifdef CONFIG_PPC_8xx
+#include <asm/fixmap.h>
+#endif
+
 int main(void)
 {
 	DEFINE(THREAD, offsetof(struct task_struct, thread));
@@ -783,5 +787,9 @@ int main(void)
 
 	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
 
+#ifdef CONFIG_PPC_8xx
+	DEFINE(VIRT_IMMR_BASE, __fix_to_virt(FIX_IMMR_BASE));
+#endif
+
 	return 0;
 }
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 80c6947..378a185 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -30,6 +30,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
+#include <asm/fixmap.h>
 
 /* Macro to make the code more readable. */
 #ifdef CONFIG_8xx_CPU6
@@ -763,7 +764,7 @@ start_here:
  * virtual to physical.  Also, set the cache mode since that is defined
  * by TLB entries and perform any additional mapping (like of the IMMR).
  * If configured to pin some TLBs, we pin the first 8 Mbytes of kernel,
- * 24 Mbytes of data, and the 8M IMMR space.  Anything not covered by
+ * 24 Mbytes of data, and the 512k IMMR space.  Anything not covered by
  * these mappings is mapped by page tables.
  */
 initial_mmu:
@@ -812,7 +813,7 @@ initial_mmu:
 	ori	r8, r8, MD_APG_INIT@l
 	mtspr	SPRN_MD_AP, r8
 
-	/* Map another 8 MByte at the IMMR to get the processor
+	/* Map a 512k page for the IMMR to get the processor
 	 * internal registers (among other things).
 	 */
 #ifdef CONFIG_PIN_TLB
@@ -820,12 +821,12 @@ initial_mmu:
 	mtspr	SPRN_MD_CTR, r10
 #endif
 	mfspr	r9, 638			/* Get current IMMR */
-	andis.	r9, r9, 0xff80		/* Get 8Mbyte boundary */
+	andis.	r9, r9, 0xfff8		/* Get 512 kbytes boundary */
 
-	mr	r8, r9			/* Create vaddr for TLB */
+	lis	r8, VIRT_IMMR_BASE@h	/* Create vaddr for TLB */
 	ori	r8, r8, MD_EVALID	/* Mark it valid */
 	mtspr	SPRN_MD_EPN, r8
-	li	r8, MD_PS8MEG		/* Set 8M byte page */
+	li	r8, MD_PS512K | MD_GUARDED	/* Set 512k byte page */
 	ori	r8, r8, MD_SVALID	/* Make it valid */
 	mtspr	SPRN_MD_TWC, r8
 	mr	r8, r9			/* Create paddr for TLB */
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index 6af6532..a41fab9 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -106,6 +106,13 @@ struct hash_pte;
 extern struct hash_pte *Hash, *Hash_end;
 extern unsigned long Hash_size, Hash_mask;
 
+#define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
+#ifdef CONFIG_PPC_8xx
+#define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
+#else
+#define VIRT_IMMR_BASE PHYS_IMMR_BASE
+#endif
+
 #endif /* CONFIG_PPC32 */
 
 extern unsigned long ioremap_bot;
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 0ac12e5..b1c7f62 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -28,6 +28,7 @@
 #include <asm/udbg.h>
 #include <asm/io.h>
 #include <asm/cpm.h>
+#include <asm/fixmap.h>
 #include <soc/fsl/qe/qe.h>
 
 #include <mm/mmu_decl.h>
@@ -37,12 +38,16 @@
 #endif
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
-static u32 __iomem *cpm_udbg_txdesc =
-	(u32 __iomem __force *)CONFIG_PPC_EARLY_DEBUG_CPM_ADDR;
+static u32 __iomem *cpm_udbg_txdesc;
 
 static void udbg_putc_cpm(char c)
 {
-	u8 __iomem *txbuf = (u8 __iomem __force *)in_be32(&cpm_udbg_txdesc[1]);
+	static u8 __iomem *txbuf;
+
+	if (unlikely(txbuf == NULL))
+		txbuf = (u8 __iomem __force *)
+			 (in_be32(&cpm_udbg_txdesc[1]) - PHYS_IMMR_BASE +
+			  VIRT_IMMR_BASE);
 
 	if (c == '\n')
 		udbg_putc_cpm('\r');
@@ -56,6 +61,10 @@ static void udbg_putc_cpm(char c)
 
 void __init udbg_init_cpm(void)
 {
+	cpm_udbg_txdesc = (u32 __iomem __force *)
+			  (CONFIG_PPC_EARLY_DEBUG_CPM_ADDR - PHYS_IMMR_BASE +
+			   VIRT_IMMR_BASE);
+
 	if (cpm_udbg_txdesc) {
 #ifdef CONFIG_CPM2
 		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
-- 
2.1.0
