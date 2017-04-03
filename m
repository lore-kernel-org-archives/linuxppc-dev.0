Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxFnl26YczDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 12:06:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: scottwood@freescale.com
Subject: [PATCH] powerpc/nohash: Fix use of mmu_has_feature() in
 setup_initial_memory_limit()
Date: Mon,  3 Apr 2017 12:05:55 +1000
Message-Id: <1491185155-27876-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

setup_initial_memory_limit() is called from early_init_devtree(), which
runs prior to feature patching. If the kernel is built with CONFIG_JUMP_LABEL=y
and CONFIG_JUMP_LABEL_FEATURE_CHECKS=y then we will potentially get the
wrong value.

If we also have CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG=y we get a warning
and backtrace:

  Warning! mmu_has_feature() used prior to jump label init!
  CPU: 0 PID: 0 Comm: swapper Not tainted 4.11.0-rc4-gccN-next-20170331-g6af2434 #1
  Call Trace:
  [c000000000fc3d50] [c000000000a26c30] .dump_stack+0xa8/0xe8 (unreliable)
  [c000000000fc3de0] [c00000000002e6b8] .setup_initial_memory_limit+0xa4/0x104
  [c000000000fc3e60] [c000000000d5c23c] .early_init_devtree+0xd0/0x2f8
  [c000000000fc3f00] [c000000000d5d3b0] .early_setup+0x90/0x11c
  [c000000000fc3f90] [c000000000000520] start_here_multiplatform+0x68/0x80

Fix it by using early_mmu_has_feature().

Fixes: c12e6f24d413 ("powerpc: Add option to use jump label for mmu_has_feature()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/tlb_nohash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index ba28fcb98597..bfc4a0869609 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -770,7 +770,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 * avoid going over total available memory just in case...
 	 */
 #ifdef CONFIG_PPC_FSL_BOOK3E
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
+	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned long linear_sz;
 		unsigned int num_cams;
 
-- 
2.7.4
