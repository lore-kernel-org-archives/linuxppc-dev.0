Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 310D71A031B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:50:39 +1000 (AEST)
Message-Id: <83ffd345e7a3fe00443e32b6caf900e7618453d6.1442939410.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1442939410.git.christophe.leroy@c-s.fr>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 05/25] powerpc/8xx: Fix vaddr for IMMR early remap
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 22 Sep 2015 18:50:38 +0200 (CEST)
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

Mapping IMMR 1:1 is just wrong because it may overlap with another
area. On most mpc8xx boards it is OK because IMMR is set to
0xff000000 but for instance on EP88xC board, IMMR is at 0xfa200000
which overlaps with VM ioremap area

This patch fixes the virtual address for remapping IMMR to 0xff000000,
regardless of the value of IMMR.

The size of IMMR area is 256kbytes (CPM at offset 0, security engine
at offset 128) so 512kbytes is enough and allows to handle the EP88xC
case (which is not 8Mbytes but only 2Mbytes aligned) the same way.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
No change in v2

 arch/powerpc/Kconfig.debug     |  1 -
 arch/powerpc/kernel/head_8xx.S | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 3a510f4..70168a2 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -326,7 +326,6 @@ config PPC_EARLY_DEBUG_40x_PHYSADDR
 config PPC_EARLY_DEBUG_CPM_ADDR
 	hex "CPM UART early debug transmit descriptor address"
 	depends on PPC_EARLY_DEBUG_CPM
-	default "0xfa202008" if PPC_EP88XC
 	default "0xf0001ff8" if CPM2
 	default "0xff002008" if CPM1
 	help
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index bcba51b..603124e 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -763,7 +763,7 @@ start_here:
  * virtual to physical.  Also, set the cache mode since that is defined
  * by TLB entries and perform any additional mapping (like of the IMMR).
  * If configured to pin some TLBs, we pin the first 8 Mbytes of kernel,
- * 24 Mbytes of data, and the 8M IMMR space.  Anything not covered by
+ * 24 Mbytes of data, and the 512k IMMR space.  Anything not covered by
  * these mappings is mapped by page tables.
  */
 initial_mmu:
@@ -812,7 +812,7 @@ initial_mmu:
 	ori	r8, r8, MD_APG_INIT@l
 	mtspr	SPRN_MD_AP, r8
 
-	/* Map another 8 MByte at the IMMR to get the processor
+	/* Map 512 kBytes at 0xff000000 for the IMMR to get the processor
 	 * internal registers (among other things).
 	 */
 #ifdef CONFIG_PIN_TLB
@@ -820,12 +820,12 @@ initial_mmu:
 	mtspr	SPRN_MD_CTR, r10
 #endif
 	mfspr	r9, 638			/* Get current IMMR */
-	andis.	r9, r9, 0xff80		/* Get 8Mbyte boundary */
+	andis.	r9, r9, 0xfff8		/* Get 512 kbytes boundary */
 
-	mr	r8, r9			/* Create vaddr for TLB */
+	lis	r8, 0xff00		/* Create vaddr for TLB at 0xff000000 */
 	ori	r8, r8, MD_EVALID	/* Mark it valid */
 	mtspr	SPRN_MD_EPN, r8
-	li	r8, MD_PS8MEG		/* Set 8M byte page */
+	li	r8, MD_PS512K | MD_GUARDED	/* Set 512k byte page */
 	ori	r8, r8, MD_SVALID	/* Make it valid */
 	mtspr	SPRN_MD_TWC, r8
 	mr	r8, r9			/* Create paddr for TLB */
-- 
2.1.0
