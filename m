Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CxfT0k32zF1pv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 22:51:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/64e: Fix oops due to deferral of paca allocation
Date: Sat, 31 Mar 2018 22:51:38 +1100
Message-Id: <20180331115138.5731-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit Book3E systems, in setup_tlb_core_data() we reference other
CPUs pacas. But in commit 59f577743d71 ("powerpc/64: Defer paca
allocation until memory topology is discovered") the allocation of
non-boot-CPU pacas was deferred until later in boot.

This leads to an oops:

  CPU maps initialized for 1 thread per core
  Unable to handle kernel paging request for data at address 0x8888888888888918
  Faulting instruction address: 0xc000000000e2f0d0
  Oops: Kernel access of bad area, sig: 11 [#1]
  NIP .setup_tlb_core_data+0xdc/0x160
  Call Trace:
    .setup_tlb_core_data+0x5c/0x160 (unreliable)
    .setup_arch+0x80/0x348
    .start_kernel+0x7c/0x598
    start_here_common+0x1c/0x40

Luckily setup_tlb_core_data() is called immediately prior to
smp_setup_pacas(). So simply switching their order is sufficient to
fix the oops and seems unlikely to have any other unwanted side
effects.

Fixes: 59f577743d71 ("powerpc/64: Defer paca allocation until memory topology is discovered")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup-common.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 56f7a2b793e0..0af5c11b9e78 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -915,9 +915,6 @@ void __init setup_arch(char **cmdline_p)
 	/* Parse memory topology */
 	mem_topology_setup();
 
-	/* On BookE, setup per-core TLB data structures. */
-	setup_tlb_core_data();
-
 	/*
 	 * Release secondary cpus out of their spinloops at 0x60 now that
 	 * we can map physical -> logical CPU ids.
@@ -927,6 +924,10 @@ void __init setup_arch(char **cmdline_p)
 	 */
 #ifdef CONFIG_SMP
 	smp_setup_pacas();
+
+	/* On BookE, setup per-core TLB data structures. */
+	setup_tlb_core_data();
+
 	smp_release_cpus();
 #endif
 
-- 
2.14.1
