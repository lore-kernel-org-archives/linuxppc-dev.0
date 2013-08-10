Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6D6222C04B5
 for <linuxppc-dev@ozlabs.org>; Sun, 11 Aug 2013 03:52:58 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Sat, 10 Aug 2013 18:52:56 +0100
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 32E486E803C
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:52:48 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7AHqrHK123736
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:52:53 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r7AHqqPe007314
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Aug 2013 13:52:53 -0400
Date: Sat, 10 Aug 2013 10:52:27 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 6/7] powerpc/perf: Export Power8 memory hierarchy info to
 user space
Message-ID: <20130810175227.GG15551@us.ibm.com>
References: <20130810174831.GA15551@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130810174831.GA15551@us.ibm.com>
Cc: Anton Blanchard <anton@au1.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Stephane Eranian <eranian@google.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[PATCH 6/7] powerpc/perf: Export Power8 memory hierarchy info to user space.

On Power8, the LDST field in SIER identifies the memory hierarchy level
(eg: L1, L2 etc), from which a data-cache miss for a marked instruction
was satisfied.

Use the 'perf_mem_data_src' object to export this hierarchy level to user
space. Fortunately, the memory hierarchy levels in Power8 map fairly easily
into the arch-neutral levels as described by the ldst_src_map[] table.

This hierarchy level information can be used with 'perf record --data'
or 'perf mem' command to analyze application behavior.

Usage:

	$ perf mem record <application>
	$ perf mem report

	OR

	$ perf record --data <application>
	$ perf report -D

	Sample records contain a 'data_src' field which encodes the memory
	hierarchy level: Eg: data_src 0x442 indicates MEM_OP_LOAD, MEM_LVL_HIT,
	MEM_LVL_L2 (i.e load hit L2).

Cc: Stephane Eranian <eranian@google.com>
Cc: Paul Mckerras <paulus@samba.org>
Cc: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |    2 +
 arch/powerpc/perf/core-book3s.c              |   11 +++++
 arch/powerpc/perf/power8-pmu.c               |   53 ++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index cc5f45b..2252798 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -37,6 +37,8 @@ struct power_pmu {
 	void            (*config_bhrb)(u64 pmu_bhrb_filter);
 	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
 	int		(*limited_pmc_event)(u64 event_id);
+	void		(*get_mem_data_src)(union perf_mem_data_src *dsrc,
+				struct pt_regs *regs);
 	u32		flags;
 	const struct attribute_group	**attr_groups;
 	int		n_generic;
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index a3985ae..e61fd05 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1693,6 +1693,13 @@ ssize_t power_events_sysfs_show(struct device *dev,
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
@@ -1774,6 +1781,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
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
index 0a7b632..2aaae63 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -538,6 +538,58 @@ static struct attribute_group power8_pmu_events_group = {
 	.attrs = power8_events_attr,
 };
 
+#define POWER8_SIER_TYPE_SHIFT		15
+#define POWER8_SIER_TYPE_MASK		(0x7LL << POWER8_SIER_TYPE_SHIFT)
+
+#define POWER8_SIER_LDST_SHIFT		1
+#define POWER8_SIER_LDST_MASK		(0x7LL << POWER8_SIER_LDST_SHIFT)
+
+#define P(a, b)		PERF_MEM_S(a, b)
+#define PLH(a, b)	(P(OP, LOAD) | P(LVL, HIT) | P(a, b))
+#define PSM(a, b)	(P(OP, STORE) | P(LVL, MISS) | P(a, b))
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
@@ -641,6 +693,7 @@ static struct power_pmu power8_pmu = {
 	.get_constraint		= power8_get_constraint,
 	.get_alternatives	= power8_get_alternatives,
 	.disable_pmc		= power8_disable_pmc,
+	.get_mem_data_src	= power8_get_mem_data_src,
 	.flags			= PPMU_HAS_SSLOT | PPMU_HAS_SIER | PPMU_BHRB | PPMU_EBB,
 	.n_generic		= ARRAY_SIZE(power8_generic_events),
 	.generic_events		= power8_generic_events,
-- 
1.7.1
