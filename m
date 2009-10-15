Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc perf events: Fix priority of MSR HV vs PR bits 
In-reply-to: <15714.1255583517@neuling.org> 
References: <15714.1255583517@neuling.org>
Date: Thu, 15 Oct 2009 16:32:15 +1100
Message-ID: <18412.1255584735@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The architecture defines that if MSR PR is set we are in problem state
irrespective of the HV bit.  This fixes perf events to reflect this.

Also, on bare metal systems, samples taken in Linux will now be reported
as kernel rather than hypervisor.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
CC: paulus@samba.org
---
Paulus suggested that the comment needed updating to reflect the
additional functionality that I've changed.

 arch/powerpc/kernel/perf_event.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/perf_event.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/perf_event.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/perf_event.c
@@ -116,20 +116,23 @@ static inline void perf_get_data_addr(st
 static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 {
 	unsigned long mmcra = regs->dsisr;
+	unsigned long sihv = MMCRA_SIHV;
+	unsigned long sipr = MMCRA_SIPR;
 
 	if (TRAP(regs) != 0xf00)
 		return 0;	/* not a PMU interrupt */
 
 	if (ppmu->flags & PPMU_ALT_SIPR) {
-		if (mmcra & POWER6_MMCRA_SIHV)
-			return PERF_RECORD_MISC_HYPERVISOR;
-		return (mmcra & POWER6_MMCRA_SIPR) ?
-			PERF_RECORD_MISC_USER : PERF_RECORD_MISC_KERNEL;
+		sihv = POWER6_MMCRA_SIHV;
+		sipr = POWER6_MMCRA_SIPR;
 	}
-	if (mmcra & MMCRA_SIHV)
+
+	/* PR has priority over HV, so order below is important */
+	if (mmcra & sipr)
+		return PERF_RECORD_MISC_USER;
+	if ((mmcra & sihv) && (freeze_events_kernel != MMCR0_FCHV))
 		return PERF_RECORD_MISC_HYPERVISOR;
-	return (mmcra & MMCRA_SIPR) ? PERF_RECORD_MISC_USER :
-		PERF_RECORD_MISC_KERNEL;
+	return PERF_RECORD_MISC_KERNEL;
 }
 
 /*
