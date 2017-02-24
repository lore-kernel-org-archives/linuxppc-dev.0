Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: skiboot@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC][PATCH][OPAL] cpufeatures: add base and POWER8 dt
Date: Fri, 24 Feb 2017 23:39:55 +1000
Message-Id: <20170224133955.11645-2-npiggin@gmail.com>
In-Reply-To: <20170224133955.11645-1-npiggin@gmail.com>
References: <20170224133955.11645-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this patch and the Linux one, I can boot (in mambo) a POWER8
without looking up any cpu tables. It's not quite complete, but
getting close.

Main questions are what features do we add, and what "base" feature set
do we start with. Where to discuss and document these features. OPAL
firmware group may become the "owner" of specification, but we will have
to involve userspace, the proprietary stack (if we can convince them),
etc.

For the base feature set I've started with ISAv207 minus some things:
a few large chunks like TM and FP and MMU, things that have FSCR bits,
CPU_FTR bits, things that have been missing from DD1 cores, etc.

Not that there are plans to drop any of these things that I know of, but
the more such "optional" things we have, the easier it will be for
different feature sets or quirks to be backward compatible -- whereas
adding a new negative feature to switch off something is not backward
compatible.

A few immediate pain points getting the Linux side going are:

- The PMU, that's for another day. We can cope with booting without a
  known PMU, or provide some subset functionality.

- TLB invalidate size, which we should be able to deal with using the
  tlb-congurence-classes property.

- The machine check handler. Moving most of that to OPAL will solve it.
  For POWER8 and possibly 9, processor specific MCE can be advertised for
  existing CPUs.

- Would be nice to avoid OPAL_REINIT_CPUS requiring the host to re-setup
  system registers (FSCR, LPCR, etc). If firmware could always
  save/restore, it would make life easier (for now I've ignored that on
  the Linux side). Ben said this only affects POWER8 DD1 and could be
  changed.

Thanks,
Nick
---
 core/device.c      |   7 ++
 core/init.c        |   3 +
 hdata/cpu-common.c | 305 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/device.h   |   1 +
 4 files changed, 316 insertions(+)

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
index 7bcb6809..35bd4e67 100644
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
index aa2752c1..050a0196 100644
--- a/hdata/cpu-common.c
+++ b/hdata/cpu-common.c
@@ -21,6 +21,305 @@
 
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
+#define CPU_P9			0x4
+
+#define CPU_ALL			(CPU_P8|CPU_P9_DD1|CPU_P9)
+
+#define ISA_BASE		0
+#define ISA_V207		2070
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
+ * set is POWER8 (ISA v2.07) less the following features:
+ *
+ * mmu-hash, big-endian, little-endian, smt, strong-access-ordering,
+ * come-from-address-register, PMU-POWER8, PCR-POWER8, idle-nap, subcore,
+ * floating-point, vector, data-stream-control-register,
+ * branch-history-rolling-buffer, transactional-memory, event-based-branch,
+ * target-address-register, processor-control-facility, control-register.
+ */
+
+static const struct cpu_feature cpu_features_table[] = {
+	{ "big-endian",				CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "little-endian",			CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "hypervisor",				CPU_ALL,
+	ISA_BASE, USABLE_HV, HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "mmu-hash",				CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "smt",				CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, 17,
+	NULL, },
+
+	{ "strong-access-ordering",		CPU_P8|CPU_P9,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "come-from-address-register",		CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "machine-check-exception-POWER8",	CPU_P8,
+	ISA_V207, USABLE_HV, HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+	{ "performance-monitor-POWER8",		CPU_P8,
+	ISA_V207, USABLE_HV|USABLE_OS, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "vrmasd",				CPU_P8,
+	ISA_V207, USABLE_HV, HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "idle-nap",				CPU_P8,
+	ISA_V207, USABLE_HV, HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "subcore",				CPU_P8,
+	ISA_V207, USABLE_HV|USABLE_OS, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "floating-point",			CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	63, -1, 4,
+	NULL, },
+	{ "vector",				CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	62, -1, -1 /* 3 and 24 */,
+	"floating-point", },
+	{ "decimal-floating-point",		CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, 21,
+	"floating-point", },
+	{ "data-stream-control-register",	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	61, -1, 34,
+	NULL, },
+
+	{ "branch-history-rolling-buffer",	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	59, -1, -1,
+	NULL, },
+	{ "transactional-memory",		CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	58, -1, 33,
+	NULL, },
+	{ "event-based-branch",			CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	56, 56, 35,
+	NULL, },
+	{ "target-address-register",		CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	55, 55, 37,
+	NULL, },
+	{ "control-register",			CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+	{ "processor-control-facility",		CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+	{ "processor-utilization-of-resources-register",	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+	{ "initiate-coprocessor-store-word",	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS, HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
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
+static void add_cpu_features(struct dt_node *cpus, uint32_t cpu_feature_cpu)
+{
+	struct dt_node *features;
+	struct dt_node *feature;
+	int i;
+
+	features = dt_new(cpus, "features");
+	assert(features);
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
+	uint32_t cpu_feature_cpu;
+	struct dt_node *cpus;
+
+	version = mfspr(SPR_PVR);
+	switch(PVR_TYPE(version)) {
+	case PVR_TYPE_P8E:
+	case PVR_TYPE_P8:
+	case PVR_TYPE_P8NVL:
+		cpu_feature_cpu = CPU_P8;
+		break;
+	case PVR_TYPE_P9:
+		if (PVR_VERS_MAJ(version) == 1)
+			cpu_feature_cpu = CPU_P9_DD1;
+		else
+			cpu_feature_cpu = CPU_P9;
+		break;
+	default:
+		cpu_feature_cpu = 0;
+		break;
+	}
+
+	cpus = dt_new_check(root, "cpus");
+
+	add_cpu_features(cpus, cpu_feature_cpu);
+}
+
 struct dt_node * add_core_common(struct dt_node *cpus,
 				 const struct sppcia_cpu_cache *cache,
 				 const struct sppaca_cpu_timebase *tb,
@@ -29,6 +328,7 @@ struct dt_node * add_core_common(struct dt_node *cpus,
 	const char *name;
 	struct dt_node *cpu;
 	uint32_t version;
+	uint32_t cpu_feature_cpu = 0;
 	uint64_t freq;
 	const uint8_t pa_features_p7[] = {
 		6, 0,
@@ -98,6 +398,7 @@ struct dt_node * add_core_common(struct dt_node *cpus,
 	case PVR_TYPE_P8:
 	case PVR_TYPE_P8NVL:
 		name = "PowerPC,POWER8";
+		cpu_feature_cpu = CPU_P8;
 		pa_features = pa_features_p8;
 		pa_features_size = sizeof(pa_features_p8);
 		tlb_congruence = 512;
@@ -105,9 +406,11 @@ struct dt_node * add_core_common(struct dt_node *cpus,
 	case PVR_TYPE_P9:
 		name = "PowerPC,POWER9";
 		if (PVR_VERS_MAJ(version) == 1) {
+			cpu_feature_cpu = CPU_P9_DD1;
 			pa_features = pa_features_p9_dd1;
 			pa_features_size = sizeof(pa_features_p9_dd1);
 		} else {
+			cpu_feature_cpu = CPU_P9;
 			pa_features = pa_features_p9_dd2;
 			pa_features_size = sizeof(pa_features_p9_dd2);
 		}
@@ -119,6 +422,8 @@ struct dt_node * add_core_common(struct dt_node *cpus,
 		pa_features = NULL;
 	}
 
+	add_cpu_features(cpus, cpu_feature_cpu);
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
