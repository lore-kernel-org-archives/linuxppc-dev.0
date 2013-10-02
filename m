Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2A4E42C00BD
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 10:15:35 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 18:15:33 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 414FF19D8041
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 18:15:29 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r920FU1C303796
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:15:31 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r920IZ2a028247
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:18:36 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 8/9][v5] powerpc/perf: Export Power7 memory hierarchy info to
 user space.
Date: Tue,  1 Oct 2013 17:15:09 -0700
Message-Id: <1380672911-12812-9-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1380672911-12812-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: Michael Ellerman <michaele@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Paul Mackerras <paulus@samba.org>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Power7, the DCACHE_SRC field in MMCRA register identifies the memory
hierarchy level (eg: L2, L3 etc) from which a data-cache miss for a
marked instruction was satisfied.

Use the 'perf_mem_data_src' object to export this hierarchy level to user
space. Some memory hierarchy levels in Power7 don't map into the arch-neutral
levels. However, since newer generation of the processor (i.e. Power8) uses
fewer levels than in Power7, we don't really need to define new hierarchy
levels just for Power7.

We instead, map as many levels as possible and approximate the rest. See
comments near dcache-src_map[] in the patch.

Usage:

	perf record -d -e 'cpu/PM_MRK_GRP_CMPL/' <application>
	perf report -n --mem-mode --sort=mem,sym,dso,symbol_daddr,dso_daddr"

		For samples involving load/store instructions, the memory
		hierarchy level is shown as "L1 hit", "Remote RAM hit" etc.
	# or

	perf record --data <application>
	perf report -D

		Sample records contain a 'data_src' field which encodes the
		memory hierarchy level: Eg: data_src 0x442 indicates
		MEM_OP_LOAD, MEM_LVL_HIT, MEM_LVL_L2 (i.e load hit L2).

Note that the PMU event PM_MRK_GRP_CMPL tracks all marked group completions
events. While some of these are loads and stores, others like 'add'
instructions may also be sampled.

As such, the precise semantics of 'perf mem -t load' or 'perf mem -t store'
(which require sampling only loads or only stores cannot be implemented on
Power. (Sampling on PM_MRK_GRP_CMPL and throwing away non-loads and non-store
samples could yield an inconsistent profile of the application).

Thanks to input from Stephane Eranian, Michael Ellerman and Michael Neuling.

Cc: Stephane Eranian <eranian@google.com>
Cc: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changelog[v4]:
	Drop support for 'perf mem' for Power (use perf-record and perf-report
	directly)

Changelog[v3]:
	[Michael Ellerman] If newer levels that we defined in [v2] are not
	needed for Power8, ignore the new levels for Power7 also, and
	approximate them.
	Separate the TLB level mapping to a separate patchset.

Changelog[v2]:
        [Stephane Eranian] Define new levels rather than ORing the L2 and L3
        with REM_CCE1 and REM_CCE2.
        [Stephane Eranian] allocate a bit PERF_MEM_XLVL_NA for architectures
        that don't use the ->mem_xlvl field.
        Insert the TLB patch ahead so the new TLB bits are contigous with
        existing TLB bits.

 arch/powerpc/perf/power7-pmu.c |   94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 56c67bc..ddfa548 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -11,8 +11,10 @@
 #include <linux/kernel.h>
 #include <linux/perf_event.h>
 #include <linux/string.h>
+#include <linux/uaccess.h>
 #include <asm/reg.h>
 #include <asm/cputable.h>
+#include <asm/code-patching.h>
 
 /*
  * Bits in event code for POWER7
@@ -317,6 +319,97 @@ static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SH(pmc));
 }
 
+#define POWER7_MMCRA_DCACHE_MISS	(0x1LL << 55)
+#define POWER7_MMCRA_DCACHE_SRC_SHIFT	51
+#define POWER7_MMCRA_DCACHE_SRC_MASK	(0xFLL << POWER7_MMCRA_DCACHE_SRC_SHIFT)
+
+#define P(a, b)		PERF_MEM_S(a, b)
+#define PLH(a, b)	(P(OP, LOAD) | P(LVL, HIT) | P(a, b))
+/*
+ * Map the Power7 DCACHE_SRC field (bits 9..12) in MMCRA register to the
+ * architecture-neutral memory hierarchy levels. For the levels in Power7
+ * that don't map to the arch-neutral levels, approximate to nearest
+ * level.
+ *
+ *	1-hop:	indicates another core on the same chip (2.1 and 3.1 levels).
+ *	2-hops:	indicates a different chip on same or different node (remote
+ *		and distant levels).
+ *
+ * For consistency with this interpretation of the hops, we dont use
+ * the REM_RAM1 level below.
+ *
+ * The *SHR and *MOD states of the cache are ignored/not exported to user.
+ *
+ * ### Levels marked with ### in comments below are approximated
+ */
+static u64 dcache_src_map[] = {
+	PLH(LVL, L2),			/* 00: FROM_L2 */
+	PLH(LVL, L3),			/* 01: FROM_L3 */
+
+	P(LVL, NA),			/* 02: Reserved */
+	P(LVL, NA),			/* 03: Reserved */
+
+	PLH(LVL, REM_CCE1),		/* 04: FROM_L2.1_SHR ### */
+	PLH(LVL, REM_CCE1),		/* 05: FROM_L2.1_MOD ### */
+
+	PLH(LVL, REM_CCE1),		/* 06: FROM_L3.1_SHR ### */
+	PLH(LVL, REM_CCE1),		/* 07: FROM_L3.1_MOD ### */
+
+	PLH(LVL, REM_CCE2),		/* 08: FROM_RL2L3_SHR ### */
+	PLH(LVL, REM_CCE2),		/* 09: FROM_RL2L3_MOD ### */
+
+	PLH(LVL, REM_CCE2),		/* 10: FROM_DL2L3_SHR ### */
+	PLH(LVL, REM_CCE2),		/* 11: FROM_DL2L3_MOD ### */
+
+	PLH(LVL, LOC_RAM),		/* 12: FROM_LMEM */
+	PLH(LVL, REM_RAM2),		/* 13: FROM_RMEM ### */
+	PLH(LVL, REM_RAM2),		/* 14: FROM_DMEM */
+
+	P(LVL, NA),			/* 15: Reserved */
+};
+
+/*
+ * Determine the memory-hierarchy information (if applicable) for the
+ * instruction/address we are sampling. If we encountered a DCACHE_MISS,
+ * mmcra[DCACHE_SRC_MASK] specifies the memory level from which the operand
+ * was loaded.
+ *
+ * Otherwise, it is an L1-hit, provided the instruction was a load/store.
+ */
+static void power7_get_mem_data_src(union perf_mem_data_src *dsrc,
+			struct pt_regs *regs)
+{
+	u64 idx;
+	u64 mmcra = regs->dsisr;
+	u64 addr;
+	int ret;
+	unsigned int instr;
+
+	if (mmcra & POWER7_MMCRA_DCACHE_MISS) {
+		idx = mmcra & POWER7_MMCRA_DCACHE_SRC_MASK;
+		idx >>= POWER7_MMCRA_DCACHE_SRC_SHIFT;
+
+		dsrc->val |= dcache_src_map[idx];
+		return;
+	}
+
+	instr = 0;
+	addr = perf_instruction_pointer(regs);
+
+	if (is_kernel_addr(addr))
+		instr = *(unsigned int *)addr;
+	else {
+		pagefault_disable();
+		ret = __get_user_inatomic(instr, (unsigned int __user *)addr);
+		pagefault_enable();
+		if (ret)
+			instr = 0;
+	}
+	if (instr && instr_is_load_store(&instr))
+		dsrc->val |= PLH(LVL, L1);
+}
+
+
 static int power7_generic_events[] = {
 	[PERF_COUNT_HW_CPU_CYCLES] =			PME_PM_CYC,
 	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PME_PM_GCT_NOSLOT_CYC,
@@ -437,6 +530,7 @@ static struct power_pmu power7_pmu = {
 	.get_constraint		= power7_get_constraint,
 	.get_alternatives	= power7_get_alternatives,
 	.disable_pmc		= power7_disable_pmc,
+	.get_mem_data_src	= power7_get_mem_data_src,
 	.flags			= PPMU_ALT_SIPR,
 	.attr_groups		= power7_pmu_attr_groups,
 	.n_generic		= ARRAY_SIZE(power7_generic_events),
-- 
1.7.9.5
