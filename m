Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRYn0c2czDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:30:04 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 07/38] powerpc: Move 64-bit memory reserves to setup_arch()
Date: Mon, 27 Jun 2016 21:29:05 +1000
Message-Id: <1467026976-7974-8-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is really no need to do them that early, early_setup() runs
before MMU is on, we should do the strict minimum there to get the
MMU going.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index e79cf1b..bcc95ac 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -296,16 +296,6 @@ void __init early_setup(unsigned long dt_ptr)
 	 */
 	cpu_ready_for_interrupts();
 
-	/* Reserve large chunks of memory for use by CMA for KVM */
-	kvm_cma_reserve();
-
-	/*
-	 * Reserve any gigantic pages requested on the command line.
-	 * memblock needs to have been initialized by the time this is
-	 * called since this will reserve memory.
-	 */
-	reserve_hugetlb_gpages();
-
 	DBG(" <- early_setup()\n");
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_BOOTX
@@ -688,6 +678,17 @@ void __init setup_arch(char **cmdline_p)
 	dcache_bsize = ppc64_caches.dline_size;
 	icache_bsize = ppc64_caches.iline_size;
 
+
+	/* Reserve large chunks of memory for use by CMA for KVM */
+	kvm_cma_reserve();
+
+	/*
+	 * Reserve any gigantic pages requested on the command line.
+	 * memblock needs to have been initialized by the time this is
+	 * called since this will reserve memory.
+	 */
+	reserve_hugetlb_gpages();
+
 	if (ppc_md.panic)
 		setup_panic();
 
@@ -712,7 +713,6 @@ void __init setup_arch(char **cmdline_p)
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
 #endif
-
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
-- 
2.7.4
