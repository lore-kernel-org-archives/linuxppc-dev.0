Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPbqb5LqTzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 13:01:47 +1100 (AEDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: paulus@ozlabs.org, mikey@neuling.org, Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2] powerpc: Add POWER9 architected mode to cputable
Date: Fri, 17 Feb 2017 13:01:35 +1100
Message-Id: <20170217020135.6361-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PVR value of 0x0F000005 means we are arch v3.00 compliant (i.e. POWER9).

Acked-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/cputable.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6a82ef039c50..d23a54b09436 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -386,6 +386,25 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
+	{	/* 3.00-compliant processor, i.e. Power9 "architected" mode */
+		.pvr_mask		= 0xffffffff,
+		.pvr_value		= 0x0f000005,
+		.cpu_name		= "POWER9 (architected)",
+		.cpu_features		= CPU_FTRS_POWER9,
+		.cpu_user_features	= COMMON_USER_POWER9,
+		.cpu_user_features2	= COMMON_USER2_POWER9,
+		.mmu_features		= MMU_FTRS_POWER9,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.cpu_setup		= __setup_cpu_power9,
+		.cpu_restore		= __restore_cpu_power9,
+		.flush_tlb		= __flush_tlb_power9,
+		.platform		= "power9",
+	},
 	{	/* Power7 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x003f0000,
-- 
2.11.1
