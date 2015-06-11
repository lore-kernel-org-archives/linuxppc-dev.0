Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ECAA21A0DE6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 18:44:08 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 14:14:06 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3BE18E0056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:17:26 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B8i1Ng54788234
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:14:01 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B8hxLX016744
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:14:00 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 khandual@linux.vnet.ibm.com, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 6/8]powerpc/perf: Export Power8 memory hierarchy info to user
 space
Date: Thu, 11 Jun 2015 14:13:35 +0530
Message-Id: <1434012217-9776-7-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

On Power8, the LDST field in SIER identifies the memory hierarchy level
(eg: L1, L2 etc), from which a data-cache miss for a marked instruction
was satisfied.

Use the 'perf_mem_data_src' object to export this hierarchy level to user
space. Fortunately, the memory hierarchy levels in Power8 map fairly easily
into the arch-neutral levels as described by the ldst_src_map[] table.

Usage:

	perf record -d -e 'cpu/mem_access/' <application>
	perf report -n --mem-mode --sort=mem,sym,dso,symbol_daddr,dso_daddr"

		For samples involving load/store instructions, the memory
		hierarchy level is shown as "L1 hit", "Remote RAM hit" etc.
	# or

	perf record --data <application>
	perf report -D

		Sample records contain a 'data_src' field which encodes the
		memory hierarchy level: Eg: data_src 0x442 indicates
		MEM_OP_LOAD, MEM_LVL_HIT, MEM_LVL_L2 (i.e load hit L2).

As the precise semantics of 'perf mem -t load' or 'perf mem -t store' (which
require sampling only loads or only stores) cannot be implemented on Power,
we don't implement 'perf mem' on Power for now.

Thanks to input from Stephane Eranian, Michael Ellerman and Michael Neuling.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 Edited the commit message to fit in the new event name

 arch/powerpc/include/asm/perf_event_server.h |  2 ++
 arch/powerpc/perf/core-book3s.c              | 11 ++++++
 arch/powerpc/perf/power8-pmu.c               | 53 ++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 0691087..b147cb6 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -42,6 +42,8 @@ struct power_pmu {
 	void            (*config_bhrb)(u64 pmu_bhrb_filter);
 	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
 	int		(*limited_pmc_event)(u64 event_id);
+	void		(*get_mem_data_src)(union perf_mem_data_src *dsrc,
+				struct pt_regs *regs);
 	u32		flags;
 	const struct attribute_group	**attr_groups;
 	int		n_generic;
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 7c4f669..4b27caf 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1888,6 +1888,13 @@ ssize_t power_events_sysfs_show(struct device *dev,
 	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+static inline void power_get_mem_data_src(union perf_mem_data_src *dsrc,
+                               struct pt_regs *regs)
+{
+	if  (ppmu->get_mem_data_src)
+		ppmu->get_mem_data_src(dsrc, regs);
+}
+
 static struct pmu power_pmu = {
 	.pmu_enable	= power_pmu_enable,
 	.pmu_disable	= power_pmu_disable,
@@ -1969,6 +1976,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			data.br_stack = &cpuhw->bhrb_stack;
 		}
 
+		if (event->attr.sample_type & PERF_SAMPLE_DATA_SRC &&
+						ppmu->get_mem_data_src)
+			ppmu->get_mem_data_src(&data.data_src, regs);
+
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	}
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 282ab40..40e74a0 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -636,6 +636,58 @@ static struct attribute_group power8_pmu_events_group = {
 	.attrs = power8_events_attr,
 };
 
+#define POWER8_SIER_TYPE_SHIFT	15
+#define POWER8_SIER_TYPE_MASK	(0x7LL << POWER8_SIER_TYPE_SHIFT)
+
+#define POWER8_SIER_LDST_SHIFT	1
+#define POWER8_SIER_LDST_MASK	(0x7LL << POWER8_SIER_LDST_SHIFT)
+
+#define P(a, b)			PERF_MEM_S(a, b)
+#define PLH(a, b)		(P(OP, LOAD) | P(LVL, HIT) | P(a, b))
+#define PSM(a, b)		(P(OP, STORE) | P(LVL, MISS) | P(a, b))
+
+/*
+ * Power8 interpretations:
+ * REM_CCE1: 1-hop indicates L2/L3 cache of a different core on same chip
+ * REM_CCE2: 2-hop indicates different chip or different node.
+ */
+static u64 ldst_src_map[] = {
+	/* 000 */	P(LVL, NA),
+
+	/* 001 */	PLH(LVL, L1),
+	/* 010 */	PLH(LVL, L2),
+	/* 011 */	PLH(LVL, L3),
+	/* 100 */	PLH(LVL, LOC_RAM),
+	/* 101 */	PLH(LVL, REM_CCE1),
+	/* 110 */	PLH(LVL, REM_CCE2),
+
+	/* 111 */	PSM(LVL, L1),
+};
+
+static inline bool is_load_store_inst(u64 sier)
+{
+	u64 val;
+	val = (sier & POWER8_SIER_TYPE_MASK) >> POWER8_SIER_TYPE_SHIFT;
+
+	/* 1 = load, 2 = store */
+	return val == 1 || val == 2;
+}
+
+static void power8_get_mem_data_src(union perf_mem_data_src *dsrc,
+			struct pt_regs *regs)
+{
+	u64 idx;
+	u64 sier;
+
+	sier = mfspr(SPRN_SIER);
+
+	if (is_load_store_inst(sier)) {
+		idx = (sier & POWER8_SIER_LDST_MASK) >> POWER8_SIER_LDST_SHIFT;
+
+		dsrc->val |= ldst_src_map[idx];
+	}
+}
+
 PMU_FORMAT_ATTR(event,		"config:0-49");
 PMU_FORMAT_ATTR(pmcxsel,	"config:0-7");
 PMU_FORMAT_ATTR(mark,		"config:8");
@@ -845,6 +897,7 @@ static struct power_pmu power8_pmu = {
 	.bhrb_filter_map	= power8_bhrb_filter_map,
 	.get_constraint		= power8_get_constraint,
 	.get_alternatives	= power8_get_alternatives,
+	.get_mem_data_src       = power8_get_mem_data_src,
 	.disable_pmc		= power8_disable_pmc,
 	.flags			= PPMU_HAS_SSLOT | PPMU_HAS_SIER | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power8_generic_events),
-- 
1.9.1
