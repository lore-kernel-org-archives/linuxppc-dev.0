Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnK90kwMzDrh0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:02:04 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKx3Sq125698
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:03 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 253r8rpwjg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:02 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:31:59 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6E3F83940060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:57 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL1u6t15925316
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:57 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL1jC5005939
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:54 +0530
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
Subject: [PATCH 06/13] powerpc/perf: Add support for perf_arch_regs in powerpc
Date: Mon, 29 Aug 2016 02:30:51 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-7-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch defines struct perf_arch_regs{} for powerpc and
update the per-cpu perf pmu structure to include
perf_arch_regs bits. perf_arch_reg_value(), perf_get_arch_reg()
and perf_get_arch_regs_mask() are implemented to return
proper values for powerpc. Finally adds code to call the
processor specific function to update the arch_regs register
values.

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
 arch/powerpc/include/asm/perf_event_server.h | 11 ++++++++
 arch/powerpc/perf/core-book3s.c              | 38 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index e157489ee7a1..65699fefb5a8 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <asm/hw_irq.h>
 #include <linux/device.h>
+#include <uapi/asm/perf_regs.h>
 #include <uapi/asm/perf_event.h>
 
 /* Update perf_event_print_debug() if this changes */
@@ -21,6 +22,12 @@
 
 struct perf_event;
 
+struct perf_arch_regs {
+	unsigned long regs[PERF_ARCH_REG_POWERPC_MAX];
+};
+
+#define perf_arch_regs perf_arch_regs
+
 /*
  * This struct provides the constants and functions needed to
  * describe the PMU on a particular POWER-family CPU.
@@ -52,6 +59,10 @@ struct power_pmu {
 
 	/* BHRB entries in the PMU */
 	int		bhrb_nr;
+
+	/* perf_arch_regs bits */
+	u64		ar_mask;
+	void		(*get_arch_regs)(struct perf_arch_regs *regs);
 };
 
 /*
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 4ed377f0f7b2..6acf086f31b3 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -57,6 +57,9 @@ struct cpu_hw_events {
 	void				*bhrb_context;
 	struct	perf_branch_stack	bhrb_stack;
 	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
+
+	/* perf_arch_regs bits */
+	struct perf_arch_regs		ar_regs;
 };
 
 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
@@ -1928,6 +1931,33 @@ ssize_t power_events_sysfs_show(struct device *dev,
 	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+u64 perf_get_arch_regs_mask(void)
+{
+	return ppmu->ar_mask;
+}
+
+struct perf_arch_regs *perf_get_arch_reg()
+{
+	struct cpu_hw_events *cpuhw;
+
+	cpuhw = this_cpu_ptr(&cpu_hw_events);
+	if (!ppmu->ar_mask)
+		return NULL;
+
+	return &cpuhw->ar_regs;
+}
+
+u64 perf_arch_reg_value(struct perf_arch_regs *regs, int idx)
+{
+	struct cpu_hw_events *cpuhw;
+
+	cpuhw = this_cpu_ptr(&cpu_hw_events);
+	if (WARN_ON_ONCE(idx >= PERF_ARCH_REG_POWERPC_MAX))
+		return 0;
+
+	return cpuhw->ar_regs.regs[idx];
+}
+
 static struct pmu power_pmu = {
 	.pmu_enable	= power_pmu_enable,
 	.pmu_disable	= power_pmu_disable,
@@ -2009,6 +2039,14 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			data.br_stack = &cpuhw->bhrb_stack;
 		}
 
+		if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+			struct cpu_hw_events *cpuhw;
+			cpuhw = this_cpu_ptr(&cpu_hw_events);
+
+			if (ppmu->get_arch_regs)
+				ppmu->get_arch_regs(&cpuhw->ar_regs);
+		}
+
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	}
-- 
2.7.4
