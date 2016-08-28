Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnKH158wzDrgs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:02:10 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKwth9095807
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:09 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2537cvy0dq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:09 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:32:05 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id E0CC4E0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:04 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL23O49830520
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:03 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL20ue006316
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:03 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 08/13] powerpc/perf: Add support for perf_arch_regs for newer
 Power processor
Date: Mon, 29 Aug 2016 02:30:53 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-9-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add code to define support functions and registers mask for
Power8 and later processor.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephane Eranian <eranian@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 18 ++++++++++++++++++
 arch/powerpc/perf/isa207-common.h | 10 ++++++++++
 arch/powerpc/perf/power8-pmu.c    |  2 ++
 arch/powerpc/perf/power9-pmu.c    |  2 ++
 4 files changed, 32 insertions(+)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 6143c99f3ec5..43931c695ecb 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -261,3 +261,21 @@ void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 	if (pmc <= 3)
 		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SHIFT(pmc + 1));
 }
+
+void isa207_get_arch_regs(struct perf_arch_regs *regs)
+{
+	regs->regs[PERF_ARCH_REG_POWERPC_PVR] = mfspr(SPRN_PVR);
+	regs->regs[PERF_ARCH_REG_POWERPC_PMC1] = mfspr(SPRN_PMC1);
+	regs->regs[PERF_ARCH_REG_POWERPC_PMC2] = mfspr(SPRN_PMC2);
+	regs->regs[PERF_ARCH_REG_POWERPC_PMC3] = mfspr(SPRN_PMC3);
+	regs->regs[PERF_ARCH_REG_POWERPC_PMC4] = mfspr(SPRN_PMC4);
+	regs->regs[PERF_ARCH_REG_POWERPC_PMC5] = mfspr(SPRN_PMC5);
+	regs->regs[PERF_ARCH_REG_POWERPC_PMC6] = mfspr(SPRN_PMC6);
+	regs->regs[PERF_ARCH_REG_POWERPC_MMCR0] = mfspr(SPRN_MMCR0);
+	regs->regs[PERF_ARCH_REG_POWERPC_MMCR1] = mfspr(SPRN_MMCR1);
+	regs->regs[PERF_ARCH_REG_POWERPC_SIER] = mfspr(SPRN_SIER);
+	regs->regs[PERF_ARCH_REG_POWERPC_SIAR] = mfspr(SPRN_SIAR);
+	regs->regs[PERF_ARCH_REG_POWERPC_SDAR] = mfspr(SPRN_SDAR);
+	regs->regs[PERF_ARCH_REG_POWERPC_MMCRA] = mfspr(SPRN_MMCRA);
+	regs->regs[PERF_ARCH_REG_POWERPC_MMCR2] = mfspr(SPRN_MMCR2);
+}
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 4d0a4e5017c2..94bf8dd548ac 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -16,6 +16,7 @@
 #include <linux/perf_event.h>
 #include <asm/firmware.h>
 #include <asm/cputable.h>
+#include <uapi/asm/perf_regs.h>
 
 /*
  * Raw event encoding for PowerISA v2.07:
@@ -227,10 +228,19 @@
 #define MAX_ALT				2
 #define MAX_PMU_COUNTERS		6
 
+#define	ISA207_ARCH_REGS_MASK  (PERF_ARCH_REG_PVR |\
+		PERF_ARCH_REG_PMC1 | PERF_ARCH_REG_PMC2 |\
+		PERF_ARCH_REG_PMC3 | PERF_ARCH_REG_PMC4 |\
+		PERF_ARCH_REG_PMC5 | PERF_ARCH_REG_PMC6 |\
+		PERF_ARCH_REG_MMCR0 | PERF_ARCH_REG_MMCR1 |\
+		PERF_ARCH_REG_SIER | PERF_ARCH_REG_SIAR |\
+		PERF_ARCH_REG_SDAR | PERF_ARCH_REG_MMCRA | PERF_ARCH_REG_MMCR2)
+
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp);
 int isa207_compute_mmcr(u64 event[], int n_ev,
 				unsigned int hwc[], unsigned long mmcr[],
 				struct perf_event *pevents[]);
 void isa207_disable_pmc(unsigned int pmc, unsigned long mmcr[]);
+void isa207_get_arch_regs(struct perf_arch_regs *regs);
 
 #endif
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 5fde2b192fec..8c8bc5083eb2 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -394,6 +394,8 @@ static struct power_pmu power8_pmu = {
 	.cache_events		= &power8_cache_events,
 	.attr_groups		= power8_pmu_attr_groups,
 	.bhrb_nr		= 32,
+	.ar_mask		= ISA207_ARCH_REGS_MASK,
+	.get_arch_regs		= isa207_get_arch_regs,
 };
 
 static int __init init_power8_pmu(void)
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 788346303852..1e66ec36b90f 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -307,6 +307,8 @@ static struct power_pmu power9_pmu = {
 	.cache_events		= &power9_cache_events,
 	.attr_groups		= power9_pmu_attr_groups,
 	.bhrb_nr		= 32,
+	.ar_mask                = ISA207_ARCH_REGS_MASK,
+	.get_arch_regs          = isa207_get_arch_regs,
 };
 
 static int __init init_power9_pmu(void)
-- 
2.7.4
