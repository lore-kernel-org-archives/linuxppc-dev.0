Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B561E1A0CCF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 07:46:51 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 02:16:49 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6948B394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 02:16:45 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4Kkirb066024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 02:16:44 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4KkhOU028436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 02:16:44 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Stephane Eranian <eranian@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [RFC PATCH  3/3]perf/powerpc: Functions to update arch_misc_regs
Date: Thu,  5 Nov 2015 02:16:18 +0530
Message-Id: <1446669978-6366-4-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch adds function to update the arch_misc_reg struct
and an arch specific perf_sample_regs_intr() to hook up
arch_misc_regs to perf_regs pointer. Also makes
perf_sample_regs_intr() in kernel/event/core.c as __weak__
function to make arch specific implementation to replace.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Stephane Eranian <eranian@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 Would really appreciate comments and feedback for the patch

 arch/powerpc/perf/core-book3s.c | 29 +++++++++++++++++++++++++++++
 kernel/events/core.c            |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b0382f3f1095..508c181c163f 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -57,6 +57,7 @@ struct cpu_hw_events {
 	void				*bhrb_context;
 	struct	perf_branch_stack	bhrb_stack;
 	struct	perf_branch_entry	bhrb_entries[BHRB_MAX_ENTRIES];
+	struct arch_misc_regs arch_regs;
 };

 static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events);
@@ -1904,6 +1905,28 @@ ssize_t power_events_sysfs_show(struct device *dev,
 	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }

+void perf_sample_regs_intr(struct perf_regs *regs_intr, struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuhw;
+	cpuhw = this_cpu_ptr(&cpu_hw_events);
+
+	regs_intr->regs = regs;
+	regs_intr->arch_regs = &cpuhw->arch_regs;
+	regs_intr->abi  = perf_reg_abi(current);
+}
+
+static void power_arch_misc_regs(struct arch_misc_regs *regs)
+{
+	regs->pmc1 = mfspr(SPRN_PMC1);
+	regs->pmc2 = mfspr(SPRN_PMC2);
+	regs->pmc3 = mfspr(SPRN_PMC3);
+	regs->pmc4 = mfspr(SPRN_PMC4);
+	regs->pmc5 = mfspr(SPRN_PMC5);
+	regs->pmc6 = mfspr(SPRN_PMC6);
+	regs->mmcr0 = mfspr(SPRN_MMCR0);
+	regs->mmcr1 = mfspr(SPRN_MMCR1);
+}
+
 static struct pmu power_pmu = {
 	.pmu_enable	= power_pmu_enable,
 	.pmu_disable	= power_pmu_disable,
@@ -1985,6 +2008,12 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			data.br_stack = &cpuhw->bhrb_stack;
 		}

+		if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+			struct cpu_hw_events *cpuhw;
+			cpuhw = this_cpu_ptr(&cpu_hw_events);
+			power_arch_misc_regs(&cpuhw->arch_regs);
+		}
+
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	}
diff --git a/kernel/events/core.c b/kernel/events/core.c
index c04bdad3d365..9567be72da5a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4962,7 +4962,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
 	}
 }

-static void perf_sample_regs_intr(struct perf_regs *regs_intr,
+void __attribute__((weak)) perf_sample_regs_intr(struct perf_regs *regs_intr,
 				  struct pt_regs *regs)
 {
 	regs_intr->regs = regs;
--
1.9.1
