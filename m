Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRbF5bh0zDqrZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:31:21 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 37/38] powerpc/64: Make a few boot functions __init
Date: Mon, 27 Jun 2016 21:29:35 +1000
Message-Id: <1467026976-7974-38-git-send-email-benh@kernel.crashing.org>
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

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b41756e..9ca2df9 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -198,7 +198,7 @@ early_param("smt-enabled", early_smt_enabled);
 #endif /* CONFIG_SMP */
 
 /** Fix up paca fields required for the boot cpu */
-static void fixup_boot_paca(void)
+static void __init fixup_boot_paca(void)
 {
 	/* The boot cpu is started */
 	get_paca()->cpu_start = 1;
@@ -206,7 +206,7 @@ static void fixup_boot_paca(void)
 	get_paca()->data_offset = 0;
 }
 
-static void configure_exceptions(void)
+static void __init configure_exceptions(void)
 {
 	/* Setup the trampolines from the lowmem exception vectors
 	 * to the kdump kernel when not using a relocatable kernel.
@@ -528,7 +528,7 @@ static __init void print_system_info(void)
  * used to allocate interrupt or emergency stacks for which our
  * exception entry path doesn't deal with being interrupted.
  */
-static u64 safe_stack_limit(void)
+static __init u64 safe_stack_limit(void)
 {
 #ifdef CONFIG_PPC_BOOK3E
 	/* Freescale BookE bolts the entire linear mapping */
-- 
2.7.4
