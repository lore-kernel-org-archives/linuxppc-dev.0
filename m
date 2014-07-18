Return-Path: <joel@jms.id.au>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 660B11A03F0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jul 2014 12:12:11 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id et14so4408007pad.23
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jul 2014 19:12:09 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Add cputable definition for POWER8 DD1
Date: Fri, 18 Jul 2014 11:41:37 +0930
Message-Id: <1405649497-679-1-git-send-email-joel@jms.id.au>
Cc: mikey@neuling.org, paulus@samba.org, anton@samba.org,
 preeti@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These processors do not currently support doorbell IPIs, so remove them
from the feature list if we are at DD 1.xx for the 0x004d part.

This fixes a regression caused by d4e58e5928f8 (powerpc/powernv: Enable
POWER8 doorbell IPIs). With that patch the kernel would hang at boot
when calling smp_call_function_many, as the doorbell would not be
received by the target CPUs:

  .smp_call_function_many+0x2bc/0x3c0 (unreliable)
  .on_each_cpu_mask+0x30/0x100
  .cpuidle_register_driver+0x158/0x1a0
  .cpuidle_register+0x2c/0x110
  .powernv_processor_idle_init+0x23c/0x2c0
  .do_one_initcall+0xd4/0x260
  .kernel_init_freeable+0x25c/0x33c
  .kernel_init+0x1c/0x120
  .ret_from_kernel_thread+0x58/0x7c

Fixes: d4e58e5928f8 (powerpc/powernv: Enable POWER8 doorbell IPIs)
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/include/asm/cputable.h |  1 +
 arch/powerpc/kernel/cputable.c      | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index bc23477..0fdd7ee 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -447,6 +447,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
 #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
+#define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 965291b..0c15764 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -527,6 +527,26 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
+	{	/* Power8 DD1: Does not support doorbell IPIs */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x004d0100,
+		.cpu_name		= "POWER8 (raw)",
+		.cpu_features		= CPU_FTRS_POWER8_DD1,
+		.cpu_user_features	= COMMON_USER_POWER8,
+		.cpu_user_features2	= COMMON_USER2_POWER8,
+		.mmu_features		= MMU_FTRS_POWER8,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/power8",
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.cpu_setup		= __setup_cpu_power8,
+		.cpu_restore		= __restore_cpu_power8,
+		.flush_tlb		= __flush_tlb_power8,
+		.machine_check_early	= __machine_check_early_realmode_p8,
+		.platform		= "power8",
+	},
 	{	/* Power8 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x004d0000,
-- 
2.0.1
