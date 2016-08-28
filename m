Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnKC3Hl3zDrgX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:02:07 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKx1CK110241
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:05 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0b-001b2d01.pphosted.com with ESMTP id 253r50f121-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:04 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:32:01 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0A93E1258061
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:01 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL1x9b18546854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:59 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL1ru6006138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:59 +0530
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
Subject: [PATCH 07/13] powerpc/perf: Add support for perf_arch_regs for Power7
 processor
Date: Mon, 29 Aug 2016 02:30:52 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-8-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add code to define support functions and registers mask for
Power7 processor.

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
 arch/powerpc/perf/power7-pmu.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index a383c23a9070..1eac466d4881 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -13,6 +13,7 @@
 #include <linux/string.h>
 #include <asm/reg.h>
 #include <asm/cputable.h>
+#include <uapi/asm/perf_regs.h>
 
 /*
  * Bits in event code for POWER7
@@ -427,6 +428,31 @@ static const struct attribute_group *power7_pmu_attr_groups[] = {
 	NULL,
 };
 
+#define POWER7_ARCH_REGS_MASK  (PERF_ARCH_REG_PVR |\
+		PERF_ARCH_REG_PMC1 | PERF_ARCH_REG_PMC2 |\
+		PERF_ARCH_REG_PMC3 | PERF_ARCH_REG_PMC4 |\
+		PERF_ARCH_REG_PMC5 | PERF_ARCH_REG_PMC6 |\
+		PERF_ARCH_REG_MMCR0 | PERF_ARCH_REG_MMCR1 |\
+		PERF_ARCH_REG_SIER | PERF_ARCH_REG_SIAR |\
+		PERF_ARCH_REG_SDAR | PERF_ARCH_REG_MMCRA)
+
+static void power7_get_arch_regs(struct perf_arch_regs *regs)
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
+}
+
 static struct power_pmu power7_pmu = {
 	.name			= "POWER7",
 	.n_counter		= 6,
@@ -442,6 +468,8 @@ static struct power_pmu power7_pmu = {
 	.n_generic		= ARRAY_SIZE(power7_generic_events),
 	.generic_events		= power7_generic_events,
 	.cache_events		= &power7_cache_events,
+	.ar_mask		= POWER7_ARCH_REGS_MASK,
+	.get_arch_regs		= power7_get_arch_regs,
 };
 
 static int __init init_power7_pmu(void)
-- 
2.7.4
