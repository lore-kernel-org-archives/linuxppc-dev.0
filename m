Return-Path: <anton@samba.org>
Date: Tue, 26 Jun 2012 21:00:13 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com
Subject: [PATCH 1/4] powerpc/perf: Create mmcra_sihv/mmcra_sipv helpers
Message-ID: <20120626210013.2fbb9044@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We want to access the MMCRA_SIHV and MMCRA_SIPR bits elsewhere so 
create mmcra_sihv and mmcra_sipr which hide the differences between
the old and new layout of the bits.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/perf/core-book3s.c
===================================================================
--- linux-build.orig/arch/powerpc/perf/core-book3s.c	2012-06-26 10:26:40.695707845 +1000
+++ linux-build/arch/powerpc/perf/core-book3s.c	2012-06-26 10:28:53.325958826 +1000
@@ -116,6 +116,26 @@ static inline void perf_get_data_addr(st
 		*addrp = mfspr(SPRN_SDAR);
 }
 
+static bool mmcra_sihv(unsigned long mmcra)
+{
+	unsigned long sihv = MMCRA_SIHV;
+
+	if (ppmu->flags & PPMU_ALT_SIPR)
+		sihv = POWER6_MMCRA_SIHV;
+
+	return !!(mmcra & sihv);
+}
+
+static bool mmcra_sipr(unsigned long mmcra)
+{
+	unsigned long sipr = MMCRA_SIPR;
+
+	if (ppmu->flags & PPMU_ALT_SIPR)
+		sipr = POWER6_MMCRA_SIPR;
+
+	return !!(mmcra & sipr);
+}
+
 static inline u32 perf_flags_from_msr(struct pt_regs *regs)
 {
 	if (regs->msr & MSR_PR)
@@ -128,8 +148,6 @@ static inline u32 perf_flags_from_msr(st
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	unsigned long mmcra = regs->dsisr;
-	unsigned long sihv = MMCRA_SIHV;
-	unsigned long sipr = MMCRA_SIPR;
 
 	/* Not a PMU interrupt: Make up flags from regs->msr */
 	if (TRAP(regs) != 0xf00)
@@ -156,15 +174,10 @@ static inline u32 perf_get_misc_flags(st
 		return PERF_RECORD_MISC_USER;
 	}
 
-	if (ppmu->flags & PPMU_ALT_SIPR) {
-		sihv = POWER6_MMCRA_SIHV;
-		sipr = POWER6_MMCRA_SIPR;
-	}
-
 	/* PR has priority over HV, so order below is important */
-	if (mmcra & sipr)
+	if (mmcra_sipr(mmcra))
 		return PERF_RECORD_MISC_USER;
-	if ((mmcra & sihv) && (freeze_events_kernel != MMCR0_FCHV))
+	if (mmcra_sihv(mmcra) && (freeze_events_kernel != MMCR0_FCHV))
 		return PERF_RECORD_MISC_HYPERVISOR;
 	return PERF_RECORD_MISC_KERNEL;
 }
