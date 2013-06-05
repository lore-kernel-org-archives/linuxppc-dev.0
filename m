Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>, benh@kernel.crashing.org
Subject: [PATCH] powerpc/cputable: fix oprofile_cpu_type on power8
In-reply-to: <26267.1370406880@ale.ozlabs.ibm.com>
References: <20130528203950.GA30172@linux.vnet.ibm.com>
 <26267.1370406880@ale.ozlabs.ibm.com>
Date: Wed, 05 Jun 2013 15:35:50 +1000
Message-ID: <30711.1370410550@ale.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Maynard Johnson <mpjohn@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In 2ac6f42 powerpc/cputable: Fix oprofile_cpu_type on power8 
we broke all power8 hw events.

This reverts this change and uses oprofile_type instead. Perf now works
on POWER8 again and oprofile will revert to using timers on POWER8.

Kudos to mpe this fix.

Signed-off-by: Michael Neuling <mikey@neuling.org>

---
tag: for-3.10

benh: disregard my previous revert request and apply this instead

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1f0937d..2a45d0f 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -452,8 +452,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.mmu_features		= MMU_FTRS_POWER8,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
-		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.oprofile_cpu_type	= 0,
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
 		.platform		= "power8",
@@ -506,8 +506,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= 0,
-		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.oprofile_cpu_type	= "ppc64/power8",
+		.oprofile_type		= PPC_OPROFILE_INVALID,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
 		.platform		= "power8",
