Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	skiboot@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH][OPAL] cpufeatures: add base and POWER8,
 POWER9 /cpus/features dt
Date: Tue,  7 Mar 2017 21:13:25 +1000
Message-Id: <20170307111326.28129-2-npiggin@gmail.com>
In-Reply-To: <20170307111326.28129-1-npiggin@gmail.com>
References: <20170307111326.28129-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this patch and the Linux one, I can boot (in mambo) a POWER8 or
POWER9 without looking up any cpu tables, and mainly looking at PVR
for MCE and PMU.

Machine and ISA speicfic features that are not abstracted by firmware
and not captured here will have to be handled on a case by case basis,
using PVR if necessary. Major ones that remain are PMU and machine check.

Open question is where and how to develop and document these features?
Not the dt representation created by skiboot, but the exact nature of
each feature. What exact behaviour does a particular feature imply, etc.

Thanks,
Nick
---
 core/device.c      |   7 +
 core/init.c        |   3 +
 hdata/cpu-common.c | 602 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/device.h   |   1 +
 4 files changed, 613 insertions(+)

diff --git a/core/device.c b/core/device.c
index 30b31f46..1900ba71 100644
--- a/core/device.c
+++ b/core/device.c
@@ -548,6 +548,13 @@ u32 dt_property_get_cell(const struct dt_property *prop, u32 index)
 	return fdt32_to_cpu(((const u32 *)prop->prop)[index]);
 }
 
+void dt_property_set_cell(struct dt_property *prop, u32 index, u32 val)
+{
+	assert(prop->len >= (index+1)*sizeof(u32));
+	/* Always aligned, so this works. */
+	((u32 *)prop->prop)[index] = cpu_to_fdt32(val);
+}
+
 /* First child of this node. */
 struct dt_node *dt_first(const struct dt_node *root)
 {
diff --git a/core/init.c b/core/init.c
index 58f96f47..938920eb 100644
--- a/core/init.c
+++ b/core/init.c
@@ -703,6 +703,8 @@ static void per_thread_sanity_checks(void)
 /* Called from head.S, thus no prototype. */
 void main_cpu_entry(const void *fdt);
 
+extern void mambo_add_cpu_features(struct dt_node *root);
+
 void __noreturn __nomcount main_cpu_entry(const void *fdt)
 {
 	/*
@@ -774,6 +776,7 @@ void __noreturn __nomcount main_cpu_entry(const void *fdt)
 			abort();
 	} else {
 		dt_expand(fdt);
+		mambo_add_cpu_features(dt_root);
 	}
 
 	/* Now that we have a full devicetree, verify that we aren't on fire. */
diff --git a/hdata/cpu-common.c b/hdata/cpu-common.c
index aa2752c1..1da1b1cb 100644
--- a/hdata/cpu-common.c
+++ b/hdata/cpu-common.c
@@ -21,6 +21,599 @@
 
 #include "hdata.h"
 
+/* Table to set up the /cpus/features dt */
+#define USABLE_PR		(1U << 0)
+#define USABLE_OS		(1U << 1)
+#define USABLE_HV		(1U << 2)
+
+#define HV_SUPPORT_NONE		0
+#define HV_SUPPORT_CUSTOM	1
+#define HV_SUPPORT_HFSCR	2
+
+#define OS_SUPPORT_NONE		0
+#define OS_SUPPORT_CUSTOM	1
+#define OS_SUPPORT_FSCR		2
+
+#define CPU_P8			0x1
+#define CPU_P9_DD1		0x2
+#define CPU_P9_DD2		0x4
+
+#define CPU_P9			(CPU_P9_DD1|CPU_P9_DD2)
+#define CPU_ALL			(CPU_P8|CPU_P9)
+
+#define ISA_BASE		0
+#define ISA_V3			3000
+
+struct cpu_feature {
+	const char *name;
+	uint32_t cpus_supported;
+	uint32_t isa;
+	uint32_t usable_mask;
+	uint32_t hv_support;
+	uint32_t os_support;
+	uint32_t hfscr_bit_nr;
+	uint32_t fscr_bit_nr;
+	uint32_t hwcap_bit_nr;
+	const char *dependencies_names; /* space-delimited names */
+};
+
+/*
+ * The base (or NULL) cpu feature set is the CPU features available
+ * when no child nodes of the /cpus/features node exist. The base feature
+ * set is POWER8 (ISA v2.07), less features that are listed explicitly.
+ *
+ * There will be a /cpus/features/isa property that specifies the currently
+ * active ISA level. Those architected features without explicit nodes
+ * will match the current ISA level. A greater ISA level will imply some
+ * features are phased out.
+ */
+static const struct cpu_feature cpu_features_table[] = {
+	{ "big-endian",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "little-endian",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* MSR_HV mode */
+	{ "hypervisor",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "smt",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, 17,
+	NULL, },
+
+	/* PPR */
+	{ "program-priority-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "strong-access-ordering",
+	CPU_ALL & ~CPU_P9_DD1,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "cache-inhibited-large-page",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* CFAR */
+	{ "come-from-address-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* FPU */
+	{ "floating-point",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	63, -1, 4,
+	NULL, },
+
+	/* VSX / VMX */
+	{ "vector",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	62, -1, -1 /* 3 and 24 */,
+	"floating-point", },
+
+	{ "vector-crypto",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, 38,
+	"vector", },
+
+	/* BCD */
+	{ "decimal-integer",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* DFP */
+	{ "decimal-floating-point",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, 21,
+	"floating-point", },
+
+	/* DSCR */
+	{ "data-stream-control-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	61, -1, 34,
+	NULL, },
+
+	/* BHRB */
+	{ "branch-history-rolling-buffer",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	59, -1, -1,
+	NULL, },
+
+	/* HTM */
+	{ "transactional-memory",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	58, -1, 33,
+	NULL, },
+
+	/* EBB */
+	{ "event-based-branch",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	56, 56, 35,
+	NULL, },
+
+	/* TAR */
+	{ "target-address-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	55, 55, 37,
+	NULL, },
+
+	/* CTRL */
+	{ "control-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* msgsnd, msgsndp, doorbell */
+	{ "processor-control-facility",
+	CPU_P8, /* P9 requires HFSCR for msgsndp */
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* PURR, SPURR */
+	{ "processor-utilization-of-resources-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* icsxw XXX? */
+	{ "initiate-coprocessor-store-word",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* v207 hash */
+	{ "mmu-hash",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* v207 PMU */
+	{ "performance-monitor-v207",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* Alignment interrupt sets DSISR */
+	{ "alignment-interrupt-dsisr",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* POWER8 doze, nap, sleep, winkle instructions */
+	{ "idle-nap",
+	CPU_P8,
+	ISA_BASE, USABLE_HV,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* ISA207 wait instruction */
+	{ "wait",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "subcore",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "mmu-radix",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* New hash pte format, PCTR, etc */
+	{ "mmu-hash-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* ISA300 wait instruction */
+	{ "wait-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* ISA300 stop idle instructions and registers */
+	{ "idle-stop",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "hypervisor-virtualization-interrupt",
+	CPU_P9,
+	ISA_V3, USABLE_HV,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* v3 PMU */
+	{ "performance-monitor-v3",
+	CPU_P9,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/* lm */
+	{ "load-monitored",
+	/* CPU_P9 XXX */ 0,
+	ISA_V3, USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_CUSTOM,
+	-1, 52, -1,
+	NULL, },
+
+	/* scv */
+	{ "system-call-vectored",
+	CPU_P9,
+	ISA_V3, USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_CUSTOM,
+	-1, 51, -1,
+	NULL, },
+
+	/* msgsnd, msgsndp, doorbell, global msgsnd, msgsync */
+	{ "processor-control-facility-v3",
+	CPU_P9, /* P9 requires HFSCR for msgsndp */
+	ISA_V3, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	53, -1, -1,
+	NULL, },
+
+	/* addpcis */
+	{ "pc-relative-addressing",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "large-decrementer",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* darn */
+	{ "random-number-generator",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* multiply-add, modulo, count trailing zeroes, cmprb, cmpeqb, extswsli
+	 * mfvsrld, mtvsrdd, mtvsrws
+	 */
+	{ "fixed-point-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "decimal-integer-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"decimal-integer", },
+
+	{ "decimal-floating-point-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"decimal-floating-point", },
+
+	{ "vector-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"vector", },
+
+	{ "vector-binary128",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, 41,
+	"vector-v3", },
+
+	{ "vector-binary16",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"vector-v3", },
+
+	/* CA32, OV32, mcrxrx, setb */
+	{ "branch-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* external event based branch */
+	{ "event-based-branch-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"event-based-branch", },
+
+	{ "atomic-memory-operations",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "copy-paste",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* GSR SPR */
+	{ "group-start-register",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/* TM completion tracing */
+	/* (XXX: branch tracing is optional?) */
+	{ "trace-interrupt-v3",
+	CPU_P9,
+	ISA_V3, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+};
+
+static void add_cpu_feature_nodeps(struct dt_node *features, const struct cpu_feature *f)
+{
+	struct dt_node *feature;
+
+	feature = dt_new(features, f->name);
+	assert(feature);
+
+	dt_add_property_cells(feature, "isa", f->isa);
+	dt_add_property_cells(feature, "usable-mask", f->usable_mask);
+
+	if (f->usable_mask & USABLE_HV) {
+		if (f->hv_support != HV_SUPPORT_NONE) {
+			dt_add_property_cells(feature, "hv-support", f->hv_support);
+			if (f->hfscr_bit_nr != -1)
+				dt_add_property_cells(feature, "hfscr-bit-nr", f->hfscr_bit_nr);
+		} else {
+			assert(f->hfscr_bit_nr == -1);
+		}
+	}
+
+	if (f->usable_mask & USABLE_OS) {
+		if (f->os_support != OS_SUPPORT_NONE) {
+			dt_add_property_cells(feature, "os-support", f->os_support);
+			if (f->fscr_bit_nr != -1)
+				dt_add_property_cells(feature, "fscr-bit-nr", f->fscr_bit_nr);
+		} else {
+			assert(f->fscr_bit_nr == -1);
+		}
+	}
+
+	if (f->usable_mask & USABLE_PR) {
+		if (f->hwcap_bit_nr != -1)
+			dt_add_property_cells(feature, "hwcap-bit-nr", f->hwcap_bit_nr);
+	}
+
+	if (f->dependencies_names)
+		dt_add_property(feature, "dependencies", NULL, 0);
+}
+
+static void add_cpu_features(struct dt_node *cpus,
+		uint32_t cpu_feature_isa, uint32_t cpu_feature_cpu)
+{
+	struct dt_node *features;
+	struct dt_node *feature;
+	int i;
+
+	features = dt_new(cpus, "features");
+	assert(features);
+
+	dt_add_property_cells(features, "isa", cpu_feature_isa);
+
+	dt_add_property_string(features, "device_type", "cpu-features");
+
+	for (i = 0; i < ARRAY_SIZE(cpu_features_table); i++) {
+		const struct cpu_feature *f = &cpu_features_table[i];
+
+		if (f->cpus_supported & cpu_feature_cpu)
+			add_cpu_feature_nodeps(features, f);
+	}
+
+	/* dependency construction pass */
+	dt_for_each_node(features, feature) {
+		const struct cpu_feature *f;
+		const char *deps_names;
+		struct dt_property *deps;
+		int nr_deps;
+		int i;
+
+		/* Find features with dependencies */
+
+		deps = __dt_find_property(feature, "dependencies");
+		if (!deps)
+			continue;
+
+		/* Find the matching cpu table */
+		for (i = 0; i < ARRAY_SIZE(cpu_features_table); i++) {
+			f = &cpu_features_table[i];
+			if (!strcmp(f->name, feature->name))
+				break;
+		}
+		assert(f->dependencies_names);
+
+		/*
+		 * Count number of depended features and allocate space
+		 * for phandles in the property.
+		 */
+		deps_names = f->dependencies_names;
+		nr_deps = strcount(deps_names, " ") + 1;
+		dt_resize_property(&deps, nr_deps * sizeof(u32));
+		deps->len = nr_deps * sizeof(u32);
+		printf("resize nr_deps:%d\n", nr_deps);
+
+		/*
+		 * For each one, find the depended feature then advance to
+		 * next name.
+		 */
+		for (i = 0; i < nr_deps; i++) {
+			struct dt_node *dep;
+
+			dt_for_each_node(features, dep) {
+				if (strstarts(deps_names, dep->name))
+					break;
+			}
+
+			printf("  set cell:%d\n", i);
+			dt_property_set_cell(deps, i, dep->phandle);
+
+			/* Advance over the name + delimiter */
+			deps_names += strlen(dep->name) + 1;
+		}
+	}
+}
+
+extern void mambo_add_cpu_features(struct dt_node *root);
+void mambo_add_cpu_features(struct dt_node *root)
+{
+	int version;
+	uint32_t cpu_feature_isa = 0;
+	uint32_t cpu_feature_cpu = 0;
+	struct dt_node *cpus;
+
+	version = mfspr(SPR_PVR);
+	switch(PVR_TYPE(version)) {
+	case PVR_TYPE_P8E:
+	case PVR_TYPE_P8:
+	case PVR_TYPE_P8NVL:
+		cpu_feature_isa = 2070;
+		cpu_feature_cpu = CPU_P8;
+		break;
+	case PVR_TYPE_P9:
+		cpu_feature_isa = 3000;
+		if (PVR_VERS_MAJ(version) == 1)
+			cpu_feature_cpu = CPU_P9_DD1;
+		else
+			cpu_feature_cpu = CPU_P9;
+		break;
+	}
+
+	cpus = dt_new_check(root, "cpus");
+
+	add_cpu_features(cpus, cpu_feature_isa, cpu_feature_cpu);
+}
+
 struct dt_node * add_core_common(struct dt_node *cpus,
 				 const struct sppcia_cpu_cache *cache,
 				 const struct sppaca_cpu_timebase *tb,
@@ -29,6 +622,8 @@ struct dt_node * add_core_common(struct dt_node *cpus,
 	const char *name;
 	struct dt_node *cpu;
 	uint32_t version;
+	uint32_t cpu_feature_isa = 0;
+	uint32_t cpu_feature_cpu = 0;
 	uint64_t freq;
 	const uint8_t pa_features_p7[] = {
 		6, 0,
@@ -98,16 +693,21 @@ struct dt_node * add_core_common(struct dt_node *cpus,
 	case PVR_TYPE_P8:
 	case PVR_TYPE_P8NVL:
 		name = "PowerPC,POWER8";
+		cpu_feature_isa = 2070;
+		cpu_feature_cpu = CPU_P8;
 		pa_features = pa_features_p8;
 		pa_features_size = sizeof(pa_features_p8);
 		tlb_congruence = 512;
 		break;
 	case PVR_TYPE_P9:
 		name = "PowerPC,POWER9";
+		cpu_feature_isa = 3000;
 		if (PVR_VERS_MAJ(version) == 1) {
+			cpu_feature_cpu = CPU_P9_DD1;
 			pa_features = pa_features_p9_dd1;
 			pa_features_size = sizeof(pa_features_p9_dd1);
 		} else {
+			cpu_feature_cpu = CPU_P9;
 			pa_features = pa_features_p9_dd2;
 			pa_features_size = sizeof(pa_features_p9_dd2);
 		}
@@ -119,6 +719,8 @@ struct dt_node * add_core_common(struct dt_node *cpus,
 		pa_features = NULL;
 	}
 
+	add_cpu_features(cpus, cpu_feature_isa, cpu_feature_cpu);
+
 	cpu = dt_new_addr(cpus, name, int_server);
 	assert(cpu);
 	dt_add_property_string(cpu, "device_type", "cpu");
diff --git a/include/device.h b/include/device.h
index 1ad403f1..8073b06b 100644
--- a/include/device.h
+++ b/include/device.h
@@ -125,6 +125,7 @@ void dt_check_del_prop(struct dt_node *node, const char *name);
 /* Warning: moves *prop! */
 void dt_resize_property(struct dt_property **prop, size_t len);
 
+void dt_property_set_cell(struct dt_property *prop, u32 index, u32 val);
 u32 dt_property_get_cell(const struct dt_property *prop, u32 index);
 
 /* First child of this node. */
-- 
2.11.0
