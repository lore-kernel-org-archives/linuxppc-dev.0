Return-Path: <mikey@neuling.org>
Message-Id: <20101118045247.454793259@neuling.org>
Date: Thu, 18 Nov 2010 15:52:42 +1100
From: mikey@neuling.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/4] powerpc: remove unneeded cpu_setup/restore from POWER7
	cputable entry
References: <20101118045241.071482503@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are not needed so just remove them

Signed-off-by: Michael Neuling <mikey@neuling.org>

---
 arch/powerpc/kernel/cputable.c |    2 --
 arch/powerpc/kernel/misc.S     |    5 -----
 2 files changed, 7 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/cputable.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/cputable.c
@@ -457,8 +457,6 @@
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_IBM,
-		.cpu_setup		= __setup_cpu_power7,
-		.cpu_restore		= __restore_cpu_power7,
 		.oprofile_cpu_type	= "ppc64/power7",
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.oprofile_mmcra_sihv	= POWER6_MMCRA_SIHV,
Index: linux-2.6-ozlabs/arch/powerpc/kernel/misc.S
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/misc.S
+++ linux-2.6-ozlabs/arch/powerpc/kernel/misc.S
@@ -122,8 +122,3 @@
 	mtlr	r0
 	mr	r3,r4
 	blr
-
-_GLOBAL(__setup_cpu_power7)
-_GLOBAL(__restore_cpu_power7)
-	/* place holder */
-	blr
