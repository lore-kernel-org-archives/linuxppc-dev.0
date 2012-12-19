Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7C2EB2C00A5
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2012 18:29:05 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 19 Dec 2012 02:29:03 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 387CBC9003C
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2012 02:29:00 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBJ7T0A731522996
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2012 02:29:00 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBJ7SxpK009880
 for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2012 02:28:59 -0500
Date: Tue, 18 Dec 2012 23:28:49 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anton Blanchard <anton@au1.ibm.com>, Jiri Olsa <jolsa@redhat.com>,
 robert.richter@amd.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] perf/POWER7: Make generic event translations available
 in sysfs
Message-ID: <20121219072848.GB30790@us.ibm.com>
References: <20121219072646.GA30580@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121219072646.GA30580@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[PATCH 3/5] perf/POWER7: Make generic event translations available in sysfs

Make the generic perf events in POWER7 available via sysfs.

	$ ls /sys/bus/event_source/devices/cpu/events
	branch-instructions
	branch-misses
	cache-misses
	cache-references
	cpu-cycles
	instructions
	stalled-cycles-backend
	stalled-cycles-frontend

	$ cat /sys/bus/event_source/devices/cpu/events/cache-misses
	event=0x400f0

This patch is based on commits that implement this functionality on x86.
Eg:
	commit a47473939db20e3961b200eb00acf5fcf084d755
	Author: Jiri Olsa <jolsa@redhat.com>
	Date:   Wed Oct 10 14:53:11 2012 +0200

	    perf/x86: Make hardware event translations available in sysfs

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |   25 +++++++++++++++++++
 arch/powerpc/perf/core-book3s.c              |   12 +++++++++
 arch/powerpc/perf/power7-pmu.c               |   34 ++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 9710be3..20ca90f 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <asm/hw_irq.h>
+#include <linux/device.h>
 
 #define MAX_HWEVENTS		8
 #define MAX_EVENT_ALTERNATIVES	8
@@ -35,6 +36,7 @@ struct power_pmu {
 	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
 	int		(*limited_pmc_event)(u64 event_id);
 	u32		flags;
+	const struct attribute_group	**attr_groups;
 	int		n_generic;
 	int		*generic_events;
 	int		(*cache_events)[PERF_COUNT_HW_CACHE_MAX]
@@ -109,3 +111,26 @@ extern unsigned long perf_instruction_pointer(struct pt_regs *regs);
  * If an event_id is not subject to the constraint expressed by a particular
  * field, then it will have 0 in both the mask and value for that field.
  */
+
+extern ssize_t power_events_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *page);
+
+/*
+ * EVENT_VAR() is same as PMU_EVENT_VAR with a suffix.
+ *
+ * Having a suffix allows us to have aliases in sysfs - eg: the generic
+ * event 'cpu-cycles' can have two entries in sysfs: 'cpu-cycles' and
+ * 'PM_CYC' where the latter is the name by which the event is known in
+ * POWER CPU specification.
+ */
+#define	EVENT_VAR(_id, _suffix)		event_attr_##_id##_suffix
+#define	EVENT_PTR(_id, _suffix)		PMU_EVENT_PTR(EVENT_VAR(_id, _suffix))
+#define	EVENT_ID(_id)			PME_PM_##_id
+
+#define	EVENT_ATTR(_name, _id, _suffix)					\
+	PMU_EVENT_ATTR(_name, EVENT_VAR(_id, _suffix), EVENT_ID(_id),	\
+			power_events_sysfs_show)
+
+#define	GENERIC_EVENT_ATTR(_name, _id)	EVENT_ATTR(_name, _id, _g)
+#define	GENERIC_EVENT_PTR(_id)		EVENT_PTR(_id, _g)
+
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index aa2465e..fa476d5 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1305,6 +1305,16 @@ static int power_pmu_event_idx(struct perf_event *event)
 	return event->hw.idx;
 }
 
+ssize_t power_events_sysfs_show(struct device *dev,
+				struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
 struct pmu power_pmu = {
 	.pmu_enable	= power_pmu_enable,
 	.pmu_disable	= power_pmu_disable,
@@ -1537,6 +1547,8 @@ int __cpuinit register_power_pmu(struct power_pmu *pmu)
 	pr_info("%s performance monitor hardware support registered\n",
 		pmu->name);
 
+	power_pmu.attr_groups = ppmu->attr_groups;
+
 #ifdef MSR_HV
 	/*
 	 * Use FCHV to ignore kernel events if MSR.HV is set.
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 44e70d2..ae5d757 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -363,6 +363,39 @@ static int power7_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
 	},
 };
 
+
+GENERIC_EVENT_ATTR(cpu-cycles,			CYC);
+GENERIC_EVENT_ATTR(stalled-cycles-frontend,	GCT_NOSLOT_CYC);
+GENERIC_EVENT_ATTR(stalled-cycles-backend,	CMPLU_STALL);
+GENERIC_EVENT_ATTR(instructions,		INST_CMPL);
+GENERIC_EVENT_ATTR(cache-references,		LD_REF_L1);
+GENERIC_EVENT_ATTR(cache-misses,		LD_MISS_L1);
+GENERIC_EVENT_ATTR(branch-instructions,		BRU_FIN);
+GENERIC_EVENT_ATTR(branch-misses,		BRU_MPRED);
+
+static struct attribute *power7_events_attr[] = {
+	GENERIC_EVENT_PTR(CYC),
+	GENERIC_EVENT_PTR(GCT_NOSLOT_CYC),
+	GENERIC_EVENT_PTR(CMPLU_STALL),
+	GENERIC_EVENT_PTR(INST_CMPL),
+	GENERIC_EVENT_PTR(LD_REF_L1),
+	GENERIC_EVENT_PTR(LD_MISS_L1),
+	GENERIC_EVENT_PTR(BRU_FIN),
+	GENERIC_EVENT_PTR(BRU_MPRED),
+	NULL
+};
+
+
+static struct attribute_group power7_pmu_events_group = {
+	.name = "events",
+	.attrs = power7_events_attr,
+};
+
+static const struct attribute_group *power7_pmu_attr_groups[] = {
+	&power7_pmu_events_group,
+	NULL,
+};
+
 static struct power_pmu power7_pmu = {
 	.name			= "POWER7",
 	.n_counter		= 6,
@@ -374,6 +407,7 @@ static struct power_pmu power7_pmu = {
 	.get_alternatives	= power7_get_alternatives,
 	.disable_pmc		= power7_disable_pmc,
 	.flags			= PPMU_ALT_SIPR,
+	.attr_groups		= power7_pmu_attr_groups,
 	.n_generic		= ARRAY_SIZE(power7_generic_events),
 	.generic_events		= power7_generic_events,
 	.cache_events		= &power7_cache_events,
-- 
1.7.1
