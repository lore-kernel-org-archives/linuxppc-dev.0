Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6530C2C00C6
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Oct 2013 10:15:36 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 1 Oct 2013 20:15:34 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id AB8776E8059
 for <linuxppc-dev@ozlabs.org>; Tue,  1 Oct 2013 20:15:30 -0400 (EDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r920FUTj64618566
 for <linuxppc-dev@ozlabs.org>; Wed, 2 Oct 2013 00:15:30 GMT
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r920IZX2028209
 for <linuxppc-dev@ozlabs.org>; Tue, 1 Oct 2013 18:18:35 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH 7/9][v5] powerpc/perf: Export Power8 memory hierarchy info to
 user space.
Date: Tue,  1 Oct 2013 17:15:08 -0700
Message-Id: <1380672911-12812-8-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Power8, the LDST field in SIER identifies the memory hierarchy level
(eg: L1, L2 etc), from which a data-cache miss for a marked instruction
was satisfied.

Use the 'perf_mem_data_src' object to export this hierarchy level to user
space. Fortunately, the memory hierarchy levels in Power8 map fairly easily
into the arch-neutral levels as described by the ldst_src_map[] table.

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
instructions may also be sampled. One alternative of sampling on
PM_MRK_GRP_CMPL and throwing away non-loads and non-store samples could
yield an inconsistent profile of the application.

As the precise semantics of 'perf mem -t load' or 'perf mem -t store' (which
require sampling only loads or only stores) cannot be implemented on Power,
we don't implement 'perf mem' on Power for now.

Thanks to input from Stephane Eranian, Michael Ellerman and Michael Neuling.

Cc: Stephane Eranian <eranian@google.com>
Cc: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Changelog[v2]:
	Drop support for 'perf mem' for Power (use perf-record and perf-report
	directly)

 arch/powerpc/include/asm/perf_event_server.h |    2 +
 arch/powerpc/perf/core-book3s.c              |   11 ++++++
 arch/powerpc/perf/power8-pmu.c               |   53 ++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 3fd2f1b..27d2c83 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -38,6 +38,8 @@ struct power_pmu {
 	void            (*config_bhrb)(u64 pmu_bhrb_filter);
 	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
 	int		(*limited_pmc_event)(u64 event_id);
+	void		(*get_mem_data_src)(union perf_mem_data_src *dsrc,
+				struct pt_regs *regs);
 	u32		flags;
 	const struct attribute_group	**attr_groups;
 	int		n_generic;
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index eeae308..5221ba1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1696,6 +1696,13 @@ ssize_t power_events_sysfs_show(struct device *dev,
 	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+static inline void power_get_mem_data_src(union perf_mem_data_src *dsrc,
+				struct pt_regs *regs)
+{
+	if  (ppmu->get_mem_data_src)
+		ppmu->get_mem_data_src(dsrc, regs);
+}
+
 struct pmu power_pmu = {
 	.pmu_enable	= power_pmu_enable,
 	.pmu_disable	= power_pmu_disable,
@@ -1777,6 +1784,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
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
index fc7ba38..ff73206 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -537,6 +537,58 @@ static struct attribute_group power8_pmu_events_group = {
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
@@ -635,6 +687,7 @@ static struct power_pmu power8_pmu = {
 	.get_constraint		= power8_get_constraint,
 	.get_alternatives	= power8_get_alternatives,
 	.disable_pmc		= power8_disable_pmc,
+	.get_mem_data_src	= power8_get_mem_data_src,
 	.flags			= PPMU_HAS_SSLOT | PPMU_HAS_SIER | PPMU_BHRB | PPMU_EBB,
 	.n_generic		= ARRAY_SIZE(power8_generic_events),
 	.generic_events		= power8_generic_events,
-- 
1.7.9.5
