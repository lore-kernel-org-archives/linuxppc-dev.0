Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRb96ZmnzDqp4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:31:17 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 35/38] powerpc: Re-order the call to smp_setup_cpu_maps()
Date: Mon, 27 Jun 2016 21:29:33 +1000
Message-Id: <1467026976-7974-36-git-send-email-benh@kernel.crashing.org>
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

It makes more sense to do it before intializing xmon() as xmon might
use the info in there. We do want to register the console early
though in case we want some functioning printk's in the cpu map setup.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_32.c | 4 ++--
 arch/powerpc/kernel/setup_64.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 5457911..58674b6 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -281,11 +281,11 @@ void __init setup_arch(char **cmdline_p)
 
 	find_legacy_serial_ports();
 
-	smp_setup_cpu_maps();
-
 	/* Register early console */
 	register_early_udbg_console();
 
+	smp_setup_cpu_maps();
+
 	xmon_setup();
 
 	if (ppc_md.panic)
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 108035b..df09d33 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -672,12 +672,13 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	register_early_udbg_console();
 
+	smp_setup_cpu_maps();
+
 	/*
 	 * Initialize xmon
 	 */
 	xmon_setup();
 
-	smp_setup_cpu_maps();
 	check_smt_enabled();
 	setup_tlb_core_data();
 
-- 
2.7.4
