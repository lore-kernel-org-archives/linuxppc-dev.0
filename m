Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00E91DE33F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 23:40:45 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] powerpc/cpm: Remove !CONFIG_PPC_CPM_NEW_BINDING code
Date: Thu, 12 Jun 2008 08:40:32 -0500
Message-Id: <1213278034-28552-4-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1213278034-28552-3-git-send-email-galak@kernel.crashing.org>
References: <1213278034-28552-1-git-send-email-galak@kernel.crashing.org>
	<1213278034-28552-2-git-send-email-galak@kernel.crashing.org>
	<1213278034-28552-3-git-send-email-galak@kernel.crashing.org>
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that arch/ppc is gone we always define CONFIG_PPC_CPM_NEW_BINDING so
we can remove all the code associated with !CONFIG_PPC_CPM_NEW_BINDING.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 include/asm-powerpc/cpm1.h |   20 --------------------
 include/asm-powerpc/cpm2.h |   26 --------------------------
 2 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/include/asm-powerpc/cpm1.h b/include/asm-powerpc/cpm1.h
index 3df4396..2ff7987 100644
--- a/include/asm-powerpc/cpm1.h
+++ b/include/asm-powerpc/cpm1.h
@@ -42,35 +42,15 @@
 
 #define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/* The dual ported RAM is multi-functional.  Some areas can be (and are
- * being) used for microcode.  There is an area that can only be used
- * as data ram for buffer descriptors, which is all we use right now.
- * Currently the first 512 and last 256 bytes are used for microcode.
- */
-#define CPM_DATAONLY_BASE	((uint)0x0800)
-#define CPM_DATAONLY_SIZE	((uint)0x0700)
-#define CPM_DP_NOSPACE		((uint)0x7fffffff)
-#endif
-
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
 extern cpm8xx_t __iomem *cpmp; /* Pointer to comm processor */
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 #define cpm_dpalloc cpm_muram_alloc
 #define cpm_dpfree cpm_muram_free
 #define cpm_dpram_addr cpm_muram_addr
 #define cpm_dpram_phys cpm_muram_dma
-#else
-extern unsigned long cpm_dpalloc(uint size, uint align);
-extern int cpm_dpfree(unsigned long offset);
-extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
-extern void cpm_dpdump(void);
-extern void *cpm_dpram_addr(unsigned long offset);
-extern uint cpm_dpram_phys(u8 *addr);
-#endif
 
 extern void cpm_setbrg(uint brg, uint rate);
 
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index 4c85ed9..2c7fd9c 100644
--- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -78,24 +78,6 @@
 #define mk_cr_cmd(PG, SBC, MCN, OP) \
 	((PG << 26) | (SBC << 21) | (MCN << 6) | OP)
 
-#ifndef CONFIG_PPC_CPM_NEW_BINDING
-/* Dual Port RAM addresses.  The first 16K is available for almost
- * any CPM use, so we put the BDs there.  The first 128 bytes are
- * used for SMC1 and SMC2 parameter RAM, so we start allocating
- * BDs above that.  All of this must change when we start
- * downloading RAM microcode.
- */
-#define CPM_DATAONLY_BASE	((uint)128)
-#define CPM_DP_NOSPACE		((uint)0x7fffffff)
-#if defined(CONFIG_8272) || defined(CONFIG_MPC8555)
-#define CPM_DATAONLY_SIZE	((uint)(8 * 1024) - CPM_DATAONLY_BASE)
-#define CPM_FCC_SPECIAL_BASE	((uint)0x00009000)
-#else
-#define CPM_DATAONLY_SIZE	((uint)(16 * 1024) - CPM_DATAONLY_BASE)
-#define CPM_FCC_SPECIAL_BASE	((uint)0x0000b000)
-#endif
-#endif
-
 /* The number of pages of host memory we allocate for CPM.  This is
  * done early in kernel initialization to get physically contiguous
  * pages.
@@ -107,17 +89,9 @@
  */
 extern cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor */
 
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
 #define cpm_dpalloc cpm_muram_alloc
 #define cpm_dpfree cpm_muram_free
 #define cpm_dpram_addr cpm_muram_addr
-#else
-extern unsigned long cpm_dpalloc(uint size, uint align);
-extern int cpm_dpfree(unsigned long offset);
-extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
-extern void cpm_dpdump(void);
-extern void *cpm_dpram_addr(unsigned long offset);
-#endif
 
 extern void cpm_setbrg(uint brg, uint rate);
 extern void cpm2_fastbrg(uint brg, uint rate, int div16);
-- 
1.5.5.1
