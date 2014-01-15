Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 17A3D2C0091
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 17:51:54 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 15 Jan 2014 12:21:52 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 78D73E0053
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 12:24:43 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0F6piLJ48300242
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 12:21:44 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0F6pn6J019772
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 12:21:49 +0530
Message-ID: <52D62FBD.7060504@linux.vnet.ibm.com>
Date: Wed, 15 Jan 2014 12:20:37 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux PPC dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc, perf: Define perf_event_print_debug() to print PMU
 register values
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Ellerman <michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As of now "echo p > /proc/sysrq-trigger" command does not print anything on
the console as we have a blank perf_event_print_debug function. This patch
defines perf_event_print_debug function to print various PMU registers.

With this patch, "echo p > /proc/sysrq-trigger" command on a POWER8 system
generates this sample output on the console.

echo p > /proc/sysrq-trigger
SysRq : Show Regs
CPU#5 PMC#1:  00000000 PMC#2:  00000000
CPU#5 PMC#3:  00000000 PMC#4:  00000000
CPU#5 PMC#5:  d03737ba PMC#6:  843aaf8c
CPU#5 MMCR0:  0000000000000000 MMCR1:  0000000000000000
CPU#5 MMCRA:  0000000000000000 SIAR:   0000000000000000
CPU#5 SDAR:   0000000000000000
CPU#5 SIER:   0000000000000000
CPU#5 MMCR2:  0000000000000000 EBBHR:  0000000000000000
CPU#5 EBBRR:  0000000000000000 BESCR:  0000000000000000

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 29b89e8..ac35aae 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -562,9 +562,63 @@ out:
 #endif /* CONFIG_PPC64 */
 
 static void perf_event_interrupt(struct pt_regs *regs);
+static unsigned long read_pmc(int idx);
 
+/* Called from generic sysrq dump register handler */
 void perf_event_print_debug(void)
 {
+	unsigned long flags;
+	int cpu, idx;
+
+	if (!ppmu->n_counter)
+		return;
+
+	local_irq_save(flags);
+
+	cpu = smp_processor_id();
+
+	/* General PMU counters */
+	for (idx = 1; idx <= ppmu->n_counter; idx = idx + 2)
+		pr_info("CPU#%d PMC#%d:  %08lx PMC#%d:  %08lx\n",
+			cpu, idx, read_pmc(idx), idx + 1, read_pmc(idx + 1));
+
+	/* General PMU config registers */
+	pr_info("CPU#%d MMCR0:  %016lx MMCR1:  %016lx\n", cpu,
+					mfspr(SPRN_MMCR0), mfspr(SPRN_MMCR1));
+	pr_info("CPU#%d MMCRA:  %016lx SIAR:   %016lx\n", cpu,
+					mfspr(SPRN_MMCRA), mfspr(SPRN_SIAR));
+
+#ifdef CONFIG_PPC64
+	pr_info("CPU#%d SDAR:   %016lx\n", cpu, mfspr(SPRN_SDAR));
+#endif /* CONFIG_PPC64 */
+
+	/* PMU specific config registers */
+	if (ppmu->flags & PPMU_HAS_SIER)
+		pr_info("CPU#%d SIER:   %016lx\n", cpu, mfspr(SPRN_SIER));
+
+
+	if (ppmu->flags & PPMU_EBB) {
+		pr_info("CPU#%d MMCR2:  %016lx EBBHR:  %016lx\n", cpu,
+					mfspr(SPRN_MMCR2), mfspr(SPRN_EBBHR));
+		pr_info("CPU#%d EBBRR:  %016lx BESCR:  %016lx\n", cpu,
+					mfspr(SPRN_EBBRR), mfspr(SPRN_BESCR));
+	}
+
+	if (ppmu->flags & PPMU_BHRB) {
+		u64 val;
+
+		for (idx = 0; idx < ppmu->bhrb_nr; idx++) {
+			val = read_bhrb(idx);
+
+			/* BHRB terminal marker */
+			if (!val)
+				break;
+
+			pr_info("CPU#%d BHRBE[%d]:  %016llx\n", cpu, idx, val);
+		}
+	}
+
+	local_irq_restore(flags);
 }
 
 /*
-- 
1.7.11.7
