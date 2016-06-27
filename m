Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRbC506CzDqnC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:31:19 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 36/38] powerpc: Re-order setup_panic()
Date: Mon, 27 Jun 2016 21:29:34 +1000
Message-Id: <1467026976-7974-37-git-send-email-benh@kernel.crashing.org>
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

Do it right after probe_machine() since it's about testing ppc_md,
and put the test in the common code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup-common.c | 2 ++
 arch/powerpc/kernel/setup_32.c     | 5 ++---
 arch/powerpc/kernel/setup_64.c     | 5 ++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 7e85fac..d0256a3 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -687,6 +687,8 @@ static struct notifier_block ppc_panic_block = {
 
 void __init setup_panic(void)
 {
+	if (!ppc_md.panic)
+		return;
 	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
 }
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 58674b6..6247a3a 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -277,6 +277,8 @@ void __init setup_arch(char **cmdline_p)
 
 	probe_machine();
 
+	setup_panic();
+
 	setup_power_save();
 
 	find_legacy_serial_ports();
@@ -288,9 +290,6 @@ void __init setup_arch(char **cmdline_p)
 
 	xmon_setup();
 
-	if (ppc_md.panic)
-		setup_panic();
-
 	init_mm.start_code = (unsigned long)_stext;
 	init_mm.end_code = (unsigned long) _etext;
 	init_mm.end_data = (unsigned long) _edata;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index df09d33..b41756e 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -660,6 +660,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Probe the machine type */
 	probe_machine();
 
+	setup_panic();
+
  	/*
 	 * We can discover serial ports now since the above did setup the
 	 * hash table management for us, thus ioremap works. We do that early
@@ -708,9 +710,6 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	reserve_hugetlb_gpages();
 
-	if (ppc_md.panic)
-		setup_panic();
-
 	klp_init_thread_info(&init_thread_info);
 
 	init_mm.start_code = (unsigned long)_stext;
-- 
2.7.4
