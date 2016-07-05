Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBjR6hTpzDqxm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:08:11 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBjR1qf1z9s9Z
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:08:11 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 37/41] powerpc/64: Make a few boot functions __init
Date: Tue,  5 Jul 2016 15:07:50 +1000
Message-Id: <1467695274-14667-37-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695274-14667-36-git-send-email-benh@kernel.crashing.org>
References: <1467695274-14667-36-git-send-email-benh@kernel.crashing.org>
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
index bb1b65e..46787d9 100644
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
@@ -515,7 +515,7 @@ static __init void print_system_info(void)
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
