Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	skiboot@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH][Linux] powerpc/64s: cpufeatures: add initial implementation
 for cpufeatures
Date: Tue,  7 Mar 2017 21:13:26 +1000
Message-Id: <20170307111326.28129-3-npiggin@gmail.com>
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

The /cpus/features dt binding describes architected CPU features along
with some compatibility, privilege, and enablement properties that allow
flexibility with discovering and enabling capabilities.

Presence of this feature implies a base level of functionality, then
additional feature nodes advertise the presence of new features.

A given feature and its setup procedure is defined once and used by all
CPUs which are compatible by that feature. Features that follow a
supported "prescription" can be enabled by a hypervisor or OS that
does not understand them natively.

Using this, we can do CPU setup without matching CPU tables on PVR, and
mambo can boot in POWER8 or POWER9 mode. Modulo allowances to support
MCE and PMU.

I'm looking at cpu features and hfscr/fscr/lpcr/msr etc bits before and
after the patch to make sure we're doing things properly. There are still
a few small differences:

POWER8
- CPU_FTR_NODSISRALIGN is now clear. DSISR is set on alignment interrupts.
- HFSCR bit 54 and 57 are now clear. This appears to be a mambo issue.

POWER9
- VRMASD is clear from LPCR. This is not supported in ISA3 mode.
- Privileged Doorbell Exit Enable is set in LPCR.

Before asking to merge this patch I'll send patches to existing cputable
code to change those and update this patch if they are rejected, so the
differences are squashed before merging.

Thanks,
Nick
---
 .../devicetree/bindings/powerpc/cpufeatures.txt    | 263 ++++++++++
 arch/powerpc/include/asm/cpu_has_feature.h         |   4 +-
 arch/powerpc/include/asm/cpufeatures.h             |  54 ++
 arch/powerpc/include/asm/cputable.h                |   1 +
 arch/powerpc/include/asm/reg.h                     |   1 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/cpufeatures.c                  | 565 +++++++++++++++++++++
 arch/powerpc/kernel/cputable.c                     |  14 +-
 arch/powerpc/kernel/prom.c                         | 201 +++++++-
 arch/powerpc/kernel/setup-common.c                 |   2 +-
 arch/powerpc/kernel/setup_64.c                     |  21 +-
 drivers/of/fdt.c                                   |  31 ++
 include/linux/of_fdt.h                             |   5 +
 13 files changed, 1144 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/cpufeatures.txt
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h
 create mode 100644 arch/powerpc/kernel/cpufeatures.c

diff --git a/Documentation/devicetree/bindings/powerpc/cpufeatures.txt b/Documentation/devicetree/bindings/powerpc/cpufeatures.txt
new file mode 100644
index 000000000000..4bb6d92a856e
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/cpufeatures.txt
@@ -0,0 +1,263 @@
+powerpc cpu features binding
+============================
+
+The device tree describes supported CPU features as nodes containing
+compatibility and enablement information as properties.
+
+The binding specifies features common to all CPUs in the system.
+Heterogeneous CPU features are not supported at present (such could be added
+by providing nodes with additional features and linking those to particular
+CPUs).
+
+This binding is intended to provide fine grained control of CPU features at
+all levels of the stack (firmware, hypervisor, OS, userspace), with the
+ability for new CPU features to be used by some components without all
+components being upgraded (e.g., a new floating point instruction could be
+used by userspace math library without upgrading kernel and hypervisor).
+
+The binding is passed to the hypervisor by firmware. The hypervisor must
+remove any features that require hypervisor enablement but that it does not
+enable. It must remove any features that depend on removed features. It may
+pass remaining features usable to the OS and PR to guests, depending on
+configuration policy (not specified here).
+
+The modified binding is passed to the guest by hypervisor, with HV bit
+cleared from the usable-mask and the hv-support and hfscr-bit properties
+removed. The guest must similarly rmeove features that require OS enablement
+that it does not enable. The OS may pass PR usable features to userspace via
+ELF AUX vectors AT_HWCAP, AT_HWCAP2, AT_HWCAP3, etc., or use some other
+method (outside the scope of this specification).
+
+The binding will specify a "base" level of features that will be present
+when the cpu features binding exists. Additional features will be explicitly
+specified.
+
+/cpus/features node binding
+---------------------------
+
+Node: features
+
+Description: Container of CPU feature nodes.
+
+The node name must be "features" and it must be a child of the node "/cpus".
+
+The node is optional but should be provided by new firmware.
+
+Each child node of cpufeatures represents an architected CPU feature (e.g.,
+a new set of vector instructions) or an important CPU performance
+characteristic (e.g., fast unaligned memory operations). The specification
+of each feature (instructions, registers, exceptions, etc.) will be
+documented with device tree bindings.
+
+As a rough guide, features should be based on functional groups of changes,
+those that share common enablement requirements, that share particular
+registers or functionality. For example, "POWER9" would be too general, and
+a new feature for every instruction would be too specific. The "summary of
+changes" preface in Power ISA specification is a good guideline for the
+architected features.
+
+Features should be "positive" where possible. For example the presence of a
+feature node should indicate the presence of a new CPU feature (e.g., a
+new instruction or register). An errata workaround for example would then
+remove that feature from the device tree to disable it. "Negative" features
+may be unavoidable in some cases.
+
+Properties:
+
+- device_type
+  Usage: required
+  Value type: string
+  Definition: "cpu-features"
+
+- isa
+  Usage: required
+  Value type: <u32>
+  Definition:
+
+  isa that the CPU is currently running in. This provides instruction set
+  compatibility, less the individual feature nodes. For example, an ISA v3.0
+  implementation that lacks the "transactional-memory" cpufeature node
+  should not use transactional memory facilities.
+
+  Value corresponds to the "Power ISA Version" multiplied by 1000.
+  For example, <3000> corresponds to Version 3.0, <2070> to Version 2.07.
+  The minor digit is available for revisions.
+
+/cpus/features/feature node bindings
+------------------------------------
+
+Node: A string describing an architected CPU feature, e.g., "vsx".
+
+Description: An architected feature supported by the CPUs.
+
+The name of the node will follow a convention such that software will
+match known features by a string comparison with the node name. Presence
+of the node indicates the feature is available to use (XXX: could
+advertise all supported by hardware, with disabled/enabled status
+property).
+
+The name of the child node corresponds to the name of the feature.
+Software will detect known features by string matching.
+
+Properties:
+
+- isa
+  Usage: required
+  Value type: <u32>
+  Definition:
+
+  First level of the Power ISA that the feature appears in.
+  Software should filter out features when constraining the
+  environment to a particular ISA version.
+
+  Value is defined similarly to /cpus/features/isa
+
+- usable-mask
+  Usage: required
+  Value type: <u32> bit mask
+  Definition:
+              bit 0 - PR (problem state / user mode)
+              bit 1 - OS (privileged state)
+              bit 2 - HV (hypervisor state)
+              All other bits reserved and should be zero.
+
+  This property describes the privilege levels and/or software components
+  that can use the feature.
+
+  If bit 0 is set, then the hwcap-bit-nr property will exist.
+
+  Reserved bits must be treated as the feature being unsupported.
+
+- hv-support
+  Usage: optional
+  Value type: <u32>
+  Definition:
+              1 -  Custom
+              2 -  HFSCR
+              Other values reserved.
+
+  This property describes the HV privilege state support required to
+  enable the feature. If the property does not exist then no support is
+  required.
+
+  If the value of this property is 1, then the hypervisor must have
+  explicit support for this feature.
+
+  If the value of this property is 2, then the hfscr-bit-nr property
+  will exist.
+
+  Reserved values must be treated as the feature being unsupported.
+
+- os-support
+  Usage: optional
+  Value type: <u32>
+  Definition:
+              1 -  Custom
+              2 -  FSCR
+              Other values reserved.
+
+  This property describes the OS privilege state support required to
+  enable the feature. If the property does not exist then no support is
+  required.
+
+  If the value of this property is 1, then the operating system must
+  have explicit support for this feature.
+
+  If the value of this property is 2, then the fscr-bit-nr property will
+  exist.
+
+  Reserved values must be treated as the feature being unsupported.
+
+- hfscr-bit-nr
+  Usage: optional
+  Value type: <u32>
+  Definition:
+
+  This property exists when the hv-support property value is 2. This
+  property describes the bit number in the HFSCR register that the
+  hypervisor must set in order to enable this feature.
+
+- fscr-bit-nr
+  Usage: optional
+  Value type: <u32>
+  Definition:
+
+  This property exists when the os-support property value is 2. This
+  property describes the bit number in the FSCR register that the
+  operating system must set in order to enable this feature.
+
+- hwcap-bit-nr
+  Usage: optional
+  Value type: <u32>
+  Definition:
+
+  This property may exist when the usable-mask property value has bit 0
+  (PR) set. This property describes the bit number that should be set in
+  the ELF AUX hardware capability vectors in order to advertise this
+  feature to userspace. Bits 0-31 correspond to bits 0-31 in AT_HWCAP
+  vector. Bits 32-63 correspond to 0-31 in AT_HWCAP2 vector, and so on.
+  Missing AT_HWCAPx vectors implies that the feature is not enabled or
+  can not be advertised. Operating systems may provide a number of
+  unassigned hardware capability bits to allow for new features to be
+  advertised.
+
+  Some properties representing features created before this binding are
+  advertised to userspace without a one-to-one hwcap bit number may not
+  specify this bit. Operating system will handle those bits specifically.
+  All new features usable by userspace will have a hwcap-bit-nr property.
+
+- dependencies
+  Usage: optional
+  Value type: <prop-encoded-array>
+  Definition:
+
+  If this property exists then it is a list of phandles to cpu feature
+  nodes that must be enabled for this feature to be enabled.
+
+
+Example
+-------
+
+	/cpus/features {
+		device_type = "cpu-features";
+
+		isa = <3020>;
+
+		darn {
+			isa = <3000>;
+			usable-mask = <1 | 2 | 4>;
+			hwcap-bit-nr = <xx>;
+		};
+
+		scv {
+			isa = <3000>;
+			usable-mask = <1 | 2>;
+			os-support = <1>;
+			hwcap-bit-nr = <xx>;
+		};
+
+		stop {
+			isa = <3000>;
+			usable-mask = <2 | 4>;
+			hv-support = <1>;
+			os-support = <1>;
+		};
+
+		vsx2 (hypothetical) {
+			isa = <3010>;
+			usable-mask = <1 | 2 | 4>;
+			hv-support = <1>;
+			os-support = <1>;
+			hwcap-bit-nr = <xx>;
+		};
+
+		vsx2-newinsns {
+			isa = <3020>;
+			usable-mask = <1 | 2 | 4>;
+			os-support = <2>;
+			fscr-bit-nr = <xx>;
+			hwcap-bit-nr = <xx>;
+			dependencies = <&vsx2>;
+		};
+
+	};
diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index 6e834caa3720..445495aa2bbf 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -1,5 +1,5 @@
-#ifndef __ASM_POWERPC_CPUFEATURES_H
-#define __ASM_POWERPC_CPUFEATURES_H
+#ifndef __ASM_POWERPC_CPU_HAS_FEATURE_H
+#define __ASM_POWERPC_CPU_HAS_FEATURE_H
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/cpufeatures.h b/arch/powerpc/include/asm/cpufeatures.h
new file mode 100644
index 000000000000..e6ba1bf31edb
--- /dev/null
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -0,0 +1,54 @@
+#ifndef __ASM_POWERPC_CPUFEATURES_H
+#define __ASM_POWERPC_CPUFEATURES_H
+
+/*
+ *  Copyright 2017, IBM Corporation
+ *  cpufeatures is the new way to discover CPU features with /cpus/features
+ *  devicetree. This supersedes PVR based discovery ("cputable"), and other
+ *  devic tree feature advertisement.
+ */
+
+#include <linux/types.h>
+#include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
+#include <uapi/asm/cputable.h>
+
+extern void cpufeatures_setup_cpu(void);
+
+/* Types for device tree parsing */
+#define USABLE_PR               (1U << 0)
+#define USABLE_OS               (1U << 1)
+#define USABLE_HV               (1U << 2)
+
+#define HV_SUPPORT_NONE         0
+#define HV_SUPPORT_CUSTOM       1
+#define HV_SUPPORT_HFSCR        2
+
+#define OS_SUPPORT_NONE         0
+#define OS_SUPPORT_CUSTOM       1
+#define OS_SUPPORT_FSCR         2
+
+#define ISA_BASE                0
+#define ISA_V207                2070
+#define ISA_V3                  3000
+
+struct dt_cpu_feature {
+	const char *name;
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
+extern void cpufeatures_setup_start(u32 isa);
+extern void cpufeatures_process_feature(struct dt_cpu_feature *f);
+extern void cpufeatures_setup_finished(void);
+
+/* kernel/prom.c */
+extern int early_init_devtree_check_cpu_features_exists(void);
+
+#endif
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index ab68d0ee7725..10b9a4be3434 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -118,6 +118,7 @@ extern struct cpu_spec		*cur_cpu_spec;
 
 extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
 
+extern void set_cur_cpu_spec(struct cpu_spec *s);
 extern struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr);
 extern void do_feature_fixups(unsigned long value, void *fixup_start,
 			      void *fixup_end);
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index cb02d32db147..2fe4b92ebaf6 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1223,6 +1223,7 @@
 #define PVR_POWER8E	0x004B
 #define PVR_POWER8NVL	0x004C
 #define PVR_POWER8	0x004D
+#define PVR_POWER9	0x004E
 #define PVR_BE		0x0070
 #define PVR_PA6T	0x0090
 
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 811f441a125f..cc3584820220 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpufeatures.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
diff --git a/arch/powerpc/kernel/cpufeatures.c b/arch/powerpc/kernel/cpufeatures.c
new file mode 100644
index 000000000000..6bceff7d4152
--- /dev/null
+++ b/arch/powerpc/kernel/cpufeatures.c
@@ -0,0 +1,565 @@
+/*
+ *  Copyright 2017, IBM Corporation
+ */
+
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/threads.h>
+#include <linux/init.h>
+#include <linux/export.h>
+#include <linux/jump_label.h>
+
+#include <asm/cpufeatures.h>
+#include <asm/cputable.h>
+#include <asm/prom.h>		/* for PTRRELOC on ARCH=ppc */
+#include <asm/oprofile_impl.h>
+#include <asm/mmu.h>
+#include <asm/setup.h>
+
+#ifndef CONFIG_PPC_BOOK3S_64
+#error "BOOK3S_64 only"
+#endif
+
+#define CPU_FTRS_BASE \
+	   (CPU_FTR_USE_TB | \
+	    CPU_FTR_LWSYNC | \
+	    CPU_FTR_FPU_UNAVAILABLE |\
+	    CPU_FTR_NODSISRALIGN |\
+	    CPU_FTR_NOEXECUTE |\
+	    CPU_FTR_COHERENT_ICACHE | \
+	    CPU_FTR_STCX_CHECKS_ADDRESS |\
+	    CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
+	    CPU_FTR_DAWR | \
+	    CPU_FTR_ARCH_206 |\
+	    CPU_FTR_ARCH_207S)
+
+#define MMU_FTRS_HASH_BASE (MMU_FTRS_POWER8)
+
+#define COMMON_USER_BASE	(PPC_FEATURE_32 | PPC_FEATURE_64 | \
+				 PPC_FEATURE_ARCH_2_06 |\
+				 PPC_FEATURE_ICACHE_SNOOP)
+#define COMMON_USER2_BASE	(PPC_FEATURE2_ARCH_2_07 | \
+				 PPC_FEATURE2_ISEL)
+/*
+ * Set up the base CPU
+ */
+
+extern void __flush_tlb_power8(unsigned int action);
+extern void __flush_tlb_power9(unsigned int action);
+extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
+
+void __init cpufeatures_setup_cpu(void)
+{
+	/* XXX: CPU name gets populated from device tree, but that's not
+	 * backward compatible if anything parses it. Must special case for
+	 * P8/9 and get from DT in future */
+	static char cpu_name_array[32] = "PowerPC (unknown)";
+	struct cpu_spec s = {
+		.cpu_name		= cpu_name_array,
+		.cpu_features		= CPU_FTRS_BASE,
+		.cpu_user_features	= COMMON_USER_BASE,
+		.cpu_user_features2	= COMMON_USER2_BASE,
+		.mmu_features		= 0,
+		.icache_bsize		= 32, /* minimum block size, fixed by */
+		.dcache_bsize		= 32, /* cache info init.             */
+		.num_pmcs		= 0,
+		.pmc_type		= PPC_PMC_DEFAULT,
+		.oprofile_cpu_type	= NULL,
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.cpu_setup		= NULL,
+		.cpu_restore		= NULL,
+		.flush_tlb		= NULL,
+		.machine_check_early	= NULL,
+		.platform		= NULL,
+	};
+
+	s.pvr_mask = 0xffffffff;
+	s.pvr_value = mfspr(SPRN_PVR);
+
+	/* PVR workarounds for compatibility. Must be moved to firmware. */
+	switch (PVR_VER(s.pvr_value)) {
+	case PVR_POWER8:
+	case PVR_POWER8E:
+	case PVR_POWER8NVL:
+		cur_cpu_spec->platform = "power8";
+		cur_cpu_spec->flush_tlb = __flush_tlb_power8;
+		cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p8;
+	case PVR_POWER9:
+		cur_cpu_spec->platform = "power9";
+		cur_cpu_spec->flush_tlb = __flush_tlb_power9;
+		break;
+	}
+
+	set_cur_cpu_spec(&s);
+
+	/* Initialize the base environment -- clear FSCR/HFSCR.  */
+	if (mfmsr() & MSR_HV)
+		mtspr(SPRN_HFSCR, 0);
+	mtspr(SPRN_FSCR, 0);
+}
+
+static int __init feat_try_enable_unknown(struct dt_cpu_feature *f)
+{
+	if (f->hv_support == HV_SUPPORT_NONE) {
+	} else if (f->hv_support == HV_SUPPORT_HFSCR) {
+		u64 hfscr = mfspr(SPRN_HFSCR);
+		hfscr |= PPC_BIT(f->hfscr_bit_nr);
+		mtspr(SPRN_HFSCR, hfscr);
+	} else {
+		return 0;
+	}
+
+	if (f->os_support == OS_SUPPORT_NONE) {
+	} else if (f->os_support == OS_SUPPORT_FSCR) {
+		u64 fscr = mfspr(SPRN_FSCR);
+		fscr |= PPC_BIT(f->fscr_bit_nr);
+		mtspr(SPRN_FSCR, fscr);
+	} else {
+		return 0;
+	}
+
+	if ((f->usable_mask & USABLE_PR) && (f->hwcap_bit_nr != -1)) {
+		uint32_t word = f->hwcap_bit_nr / 32;
+		uint32_t bit = f->hwcap_bit_nr % 32;
+
+		if (word == 0)
+			cur_cpu_spec->cpu_user_features |= PPC_BIT(bit) >> 32;
+		else if (word == 1)
+			cur_cpu_spec->cpu_user_features2 |= PPC_BIT(bit) >> 32;
+		else
+			printk("CPU feature: %s could not advertise to user (no hwcap bits)\n", f->name);
+	}
+
+	return 1;
+}
+
+static int __init feat_enable(struct dt_cpu_feature *f)
+{
+	if (f->hv_support) {
+		if (f->hfscr_bit_nr != -1) {
+			u64 hfscr = mfspr(SPRN_HFSCR);
+			hfscr |= PPC_BIT(f->hfscr_bit_nr);
+			mtspr(SPRN_HFSCR, hfscr);
+		}
+	}
+
+	if (f->os_support) {
+		if (f->fscr_bit_nr != -1) {
+			u64 fscr = mfspr(SPRN_FSCR);
+			fscr |= PPC_BIT(f->fscr_bit_nr);
+			mtspr(SPRN_FSCR, fscr);
+		}
+	}
+
+	if ((f->usable_mask & USABLE_PR) && (f->hwcap_bit_nr != -1)) {
+		uint32_t word = f->hwcap_bit_nr / 32;
+		uint32_t bit = f->hwcap_bit_nr % 32;
+
+		if (word == 0)
+			cur_cpu_spec->cpu_user_features |= PPC_BIT(bit) >> 32;
+		else if (word == 1)
+			cur_cpu_spec->cpu_user_features2 |= PPC_BIT(bit) >> 32;
+		else
+			printk("CPU feature: %s could not advertise to user (no hwcap bits)\n", f->name);
+	}
+
+	return 1;
+}
+
+static int __init feat_disable(struct dt_cpu_feature *f)
+{
+	return 0;
+}
+
+static int __initdata prereq_pece_msgp = 0;
+
+static int __init feat_enable_hv(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	if (!(mfmsr() & MSR_HV)) {
+		printk("CPU feature hypervisor present in device tree but HV mode not enabled in the CPU. Ignoring.\n");
+		return 0;
+	}
+
+	mtspr(SPRN_LPID, 0);
+
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr &=  ~LPCR_LPES0; /* HV external interrupts */
+	mtspr(SPRN_LPCR, lpcr);
+
+	cur_cpu_spec->cpu_features |= CPU_FTR_HVMODE;
+
+	return 1;
+}
+
+static int __init feat_enable_le(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_TRUE_LE;
+	return 1;
+}
+
+static int __init feat_enable_smt(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_SMT;
+	return 1;
+}
+
+static int __init feat_enable_idle_nap(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	/* Set PECE wakeup modes for ISA 207 */
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |=  LPCR_PECE0;
+	lpcr |=  LPCR_PECE1;
+	lpcr |=  LPCR_PECE2;
+	mtspr(SPRN_LPCR, lpcr);
+
+	return 1;
+}
+
+static int __init feat_enable_align_dsisr(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->cpu_features &= ~CPU_FTR_NODSISRALIGN;
+
+	return 1;
+}
+
+static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	/* Set PECE wakeup modes for ISA 300 */
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |=  LPCR_PECE0;
+	lpcr |=  LPCR_PECE1;
+	lpcr |=  LPCR_PECE2;
+	mtspr(SPRN_LPCR, lpcr);
+
+	prereq_pece_msgp++;
+
+	return 1;
+}
+
+static int __init feat_enable_mmu_hash(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr &= ~LPCR_ISL;
+
+	/* VRMASD */
+	lpcr |= LPCR_VPM0;
+	lpcr &= ~LPCR_VPM1;
+	lpcr |= 0x10UL << LPCR_VRMASD_SH; /* L=1 LP=00 */
+	mtspr(SPRN_LPCR, lpcr);
+
+	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_MMU;
+
+	return 1;
+}
+
+static int __init feat_enable_mmu_hash_v3(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr &= ~LPCR_ISL;
+	mtspr(SPRN_LPCR, lpcr);
+
+	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_MMU;
+
+	return 1;
+}
+
+
+static int __init feat_enable_mmu_radix(struct dt_cpu_feature *f)
+{
+#ifdef CONFIG_PPC_RADIX_MMU
+	cur_cpu_spec->mmu_features |= MMU_FTR_TYPE_RADIX;
+	cur_cpu_spec->mmu_features |= MMU_FTRS_HASH_BASE;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_MMU;
+
+	return 1;
+#endif
+	return 0;
+}
+
+static int __init feat_enable_dscr(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	feat_enable(f);
+
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr &= ~LPCR_DPFD;
+	lpcr |=  (4UL << LPCR_DPFD_SH);
+	mtspr(SPRN_LPCR, lpcr);
+
+	return 1;
+}
+
+static void hfscr_pm_enable(void)
+{
+	u64 hfscr = mfspr(SPRN_HFSCR);
+	hfscr |= PPC_BIT(60);
+	mtspr(SPRN_HFSCR, hfscr);
+}
+
+static int __init feat_enable_pm_ISA207(struct dt_cpu_feature *f)
+{
+	hfscr_pm_enable();
+
+	if (mfmsr() & MSR_HV) {
+		mtspr(SPRN_MMCRC, 0);
+		mtspr(SPRN_MMCRH, 0);
+	}
+
+	mtspr(SPRN_MMCRA, 0);
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR1, 0);
+	mtspr(SPRN_MMCR2, 0);
+	mtspr(SPRN_MMCRS, 0);
+
+	cur_cpu_spec->cpu_features |= CPU_FTR_MMCRA;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_PSERIES_PERFMON_COMPAT;
+	if (pvr_version_is(PVR_POWER8E))
+		cur_cpu_spec->cpu_features |= CPU_FTR_PMAO_BUG;
+
+	cur_cpu_spec->num_pmcs		= 6;
+	cur_cpu_spec->pmc_type		= PPC_PMC_IBM;
+	cur_cpu_spec->oprofile_cpu_type	= "ppc64/power8";
+	cur_cpu_spec->oprofile_type	= PPC_OPROFILE_INVALID;
+
+	return 1;
+}
+
+static int __init feat_enable_pm_ISA3(struct dt_cpu_feature *f)
+{
+	hfscr_pm_enable();
+
+	if (mfmsr() & MSR_HV) {
+		mtspr(SPRN_MMCRC, 0);
+	}
+
+	mtspr(SPRN_MMCRA, 0);
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR1, 0);
+	mtspr(SPRN_MMCR2, 0);
+
+	cur_cpu_spec->cpu_features |= CPU_FTR_MMCRA;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_PSERIES_PERFMON_COMPAT;
+
+	cur_cpu_spec->num_pmcs		= 6;
+	cur_cpu_spec->pmc_type		= PPC_PMC_IBM;
+	cur_cpu_spec->oprofile_cpu_type	= "ppc64/power9";
+	cur_cpu_spec->oprofile_type	= PPC_OPROFILE_INVALID;
+
+	return 1;
+}
+
+static int __init feat_enable_tm(struct dt_cpu_feature *f)
+{
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	feat_enable(f);
+	cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_HTM_NOSC;
+	return 1;
+#endif
+	return 0;
+}
+
+static int __init feat_enable_fp(struct dt_cpu_feature *f)
+{
+	feat_enable(f);
+	cur_cpu_spec->cpu_features &= ~CPU_FTR_FPU_UNAVAILABLE;
+
+	return 1;
+}
+
+static int __init feat_enable_vector(struct dt_cpu_feature *f)
+{
+#if defined(CONFIG_ALTIVEC) && defined(CONFIG_VSX)
+	feat_enable(f);
+	cur_cpu_spec->cpu_features |= CPU_FTR_ALTIVEC;
+	cur_cpu_spec->cpu_features |= CPU_FTR_VSX;
+	cur_cpu_spec->cpu_features |= CPU_FTR_VMX_COPY;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_VSX;
+
+	return 1;
+#endif
+	return 0;
+}
+
+static int __init feat_enable_purr(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->cpu_features |= CPU_FTR_PURR | CPU_FTR_SPURR;
+
+	return 1;
+}
+
+static int __init feat_enable_dbell(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	/* P9 has an HFSCR for privileged state */
+	feat_enable(f);
+
+	cur_cpu_spec->cpu_features |= CPU_FTR_DBELL;
+
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |=  LPCR_PECEDH; /* hyp doorbell wakeup */
+	mtspr(SPRN_LPCR, lpcr);
+
+	prereq_pece_msgp++;
+
+	return 1;
+}
+
+static int __init feat_enable_hvi(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |=  LPCR_PECE_HVEE | LPCR_HVICE;
+	mtspr(SPRN_LPCR, lpcr);
+
+	return 1;
+}
+
+static int __init feat_enable_large_ci(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->mmu_features |= MMU_FTR_CI_LARGE_PAGE;
+
+	return 1;
+}
+
+
+struct dt_cpu_feature_match {
+	const char *name;
+	int (*enable)(struct dt_cpu_feature *f);
+	u64 cpu_ftr_bit_mask;
+};
+
+static const struct dt_cpu_feature_match __initconst
+		dt_cpu_feature_match_table[] = {
+	{"hypervisor", feat_enable_hv, 0},
+	{"big-endian", feat_enable, 0},
+	{"little-endian", feat_enable_le, CPU_FTR_REAL_LE},
+	{"smt", feat_enable_smt, 0},
+	{"come-from-address-register", feat_enable, CPU_FTR_CFAR},
+	{"floating-point", feat_enable_fp, 0},
+	{"vector", feat_enable_vector, 0},
+	{"decimal-floating-point", feat_enable, 0},
+	{"decimal-integer", feat_enable, 0},
+	{"vector-crypto", feat_enable, 0},
+	{"mmu-hash", feat_enable_mmu_hash, 0},
+	{"mmu-radix", feat_enable_mmu_radix, 0},
+	{"mmu-hash-v3", feat_enable_mmu_hash_v3, 0},
+	{"transactional-memory", feat_enable_tm, CPU_FTR_TM},
+	{"idle-nap", feat_enable_idle_nap, 0},
+	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
+	{"idle-stop", feat_enable_idle_stop, 0},
+	{"performance-monitor-v207", feat_enable_pm_ISA207, 0},
+	{"data-stream-control-register", feat_enable_dscr, CPU_FTR_DSCR},
+	{"event-based-branch", feat_enable, 0},
+	{"target-address-register", feat_enable, 0},
+	{"branch-history-rolling-buffer", feat_enable, 0},
+	{"control-register", feat_enable, CPU_FTR_CTRL},
+	{"processor-control-facility", feat_enable_dbell, CPU_FTR_DBELL},
+	{"processor-control-facility-v3", feat_enable_dbell, CPU_FTR_DBELL},
+	{"processor-utilization-of-resources-register", feat_enable_purr, 0},
+	{"subcore", feat_enable, CPU_FTR_SUBCORE},
+	{"strong-access-ordering", feat_enable, CPU_FTR_SAO},
+	{"cache-inhibited-large-page", feat_enable_large_ci, 0},
+	{"initiate-coprocessor-store-word", feat_enable, CPU_FTR_ICSWX},
+	{"hypervisor-virtualization-interrupt", feat_enable_hvi, 0},
+	{"program-priority-register", feat_enable, CPU_FTR_HAS_PPR},
+	{"wait", feat_enable, 0},
+	{"atomic-memory-operations", feat_enable, 0},
+	{"branch-v3", feat_enable, 0},
+	{"copy-paste", feat_enable, 0},
+	{"decimal-floating-point-v3", feat_enable, 0},
+	{"decimal-integer-v3", feat_enable, 0},
+	{"fixed-point-v3", feat_enable, 0},
+	{"group-start-register", feat_enable, 0},
+	{"pc-relative-addressing", feat_enable, 0},
+	{"performance-monitor-v3", feat_enable_pm_ISA3, 0},
+	{"event-based-branch-v3", feat_enable, 0},
+	{"large-decrementer", feat_enable, 0},
+	{"random-number-generator", feat_enable, 0},
+	{"system-call-vectored", feat_disable, 0},
+	{"trace-interrupt-v3", feat_enable, 0},
+	{"vector-v3", feat_enable, 0},
+	{"vector-binary128", feat_enable, 0},
+	{"vector-binary16", feat_enable, 0},
+	{"wait-v3", feat_enable, 0},
+};
+
+/* XXX: how to configure this? Default + boot time? */
+#define CPU_FEATURE_ENABLE_UNKNOWN 1
+
+void __init cpufeatures_setup_start(u32 isa)
+{
+	printk("CPUFEATURES setup for isa %d\n", isa);
+	if (isa >= 3000) {
+		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_300;
+		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_00;
+	}
+}
+
+void __init cpufeatures_process_feature(struct dt_cpu_feature *f)
+{
+	const struct dt_cpu_feature_match *m;
+	int known = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dt_cpu_feature_match_table); i++) {
+		m = &dt_cpu_feature_match_table[i];
+		if (!strcmp(f->name, m->name)) {
+			known = 1;
+			if (m->enable(f))
+				goto enabled;
+			goto not_enabled;
+		}
+	}
+
+	if (CPU_FEATURE_ENABLE_UNKNOWN) {
+		if (feat_try_enable_unknown(f))
+			goto enabled;
+	}
+
+not_enabled:
+	if (known)
+		printk("CPU feature not enabling:%s (disabled or unsupported by kernel)\n", f->name);
+	else
+		printk("CPU feature not enabling:%s (unknown and unsupported by kernel)\n", f->name);
+	return;
+enabled:
+	if (m->cpu_ftr_bit_mask)
+		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
+	if (known)
+		printk("CPU feature enabling:%s\n", f->name);
+	else
+		printk("CPU feature enabling:%s (unknown)\n", f->name);
+}
+
+void __init cpufeatures_setup_finished(void)
+{
+	if ((mfmsr() & MSR_HV) && !(cur_cpu_spec->cpu_features & CPU_FTR_HVMODE)) {
+		printk("CPU feature hypervisor not present in device tree but HV mode is enabled in the CPU. Enabling.\n");
+		cur_cpu_spec->cpu_features |= CPU_FTR_HVMODE;
+	}
+
+	if (prereq_pece_msgp == 2) { /* doorbell and stop */
+		u64 lpcr;
+
+		lpcr = mfspr(SPRN_LPCR);
+		lpcr |=  LPCR_PECEDP; /* priv doorbell wakeup */
+		mtspr(SPRN_LPCR, lpcr);
+	}
+}
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6a82ef039c50..379767ef64f9 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -23,7 +23,9 @@
 #include <asm/mmu.h>
 #include <asm/setup.h>
 
-struct cpu_spec* cur_cpu_spec = NULL;
+static struct cpu_spec the_cpu_spec __read_mostly;
+
+struct cpu_spec* cur_cpu_spec __read_mostly = NULL;
 EXPORT_SYMBOL(cur_cpu_spec);
 
 /* The platform string corresponding to the real PVR */
@@ -2159,7 +2161,15 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif /* CONFIG_E500 */
 };
 
-static struct cpu_spec the_cpu_spec;
+void __init set_cur_cpu_spec(struct cpu_spec *s)
+{
+	struct cpu_spec *t = &the_cpu_spec;
+
+	t = PTRRELOC(t);
+	*t = *s;
+
+	*PTRRELOC(&cur_cpu_spec) = &the_cpu_spec;
+}
 
 static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
 					       struct cpu_spec *s)
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index f5d399e46193..714c673ad048 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -58,6 +58,7 @@
 #include <asm/debug.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/firmware.h>
+#include <asm/cpufeatures.h>
 
 #include <mm/mmu_decl.h>
 
@@ -70,6 +71,7 @@
 #ifdef CONFIG_PPC64
 int __initdata iommu_is_off;
 int __initdata iommu_force_on;
+int __initdata has_cpufeatures_node = 0;
 unsigned long tce_alloc_start, tce_alloc_end;
 u64 ppc64_rma_size;
 #endif
@@ -300,6 +302,159 @@ static void __init check_cpu_feature_properties(unsigned long node)
 	}
 }
 
+#define CPUFT_WARN(str, name) printk(KERN_WARNING "WARNING: /cpus/features/%s dt:%s\n", name, str)
+
+static int __init scan_cpufeatures_subnodes(unsigned long node,
+					  const char *uname,
+					  void *data)
+{
+	const __be32 *prop;
+	struct dt_cpu_feature f;
+	int len;
+
+	memset(&f, 0, sizeof(f));
+
+	f.name = uname;
+
+	prop = of_get_flat_dt_prop(node, "isa", &len);
+	if (!prop) {
+		CPUFT_WARN("missing isa property", uname);
+		return 0;
+	}
+	f.isa = be32_to_cpup(prop);
+
+	prop = of_get_flat_dt_prop(node, "usable-mask", &len);
+	if (!prop) {
+		CPUFT_WARN("missing usable-mask property", uname);
+		return 0;
+	}
+	f.usable_mask = be32_to_cpup(prop);
+
+	prop = of_get_flat_dt_prop(node, "hv-support", &len);
+	if (prop)
+		f.hv_support = be32_to_cpup(prop);
+	prop = of_get_flat_dt_prop(node, "os-support", &len);
+	if (prop)
+		f.os_support = be32_to_cpup(prop);
+
+	prop = of_get_flat_dt_prop(node, "hfscr-bit-nr", &len);
+	if (prop)
+		f.hfscr_bit_nr = be32_to_cpup(prop);
+	else
+		f.hfscr_bit_nr = -1;
+	prop = of_get_flat_dt_prop(node, "fscr-bit-nr", &len);
+	if (prop)
+		f.fscr_bit_nr = be32_to_cpup(prop);
+	else
+		f.fscr_bit_nr = -1;
+	prop = of_get_flat_dt_prop(node, "hwcap-bit-nr", &len);
+	if (prop)
+		f.hwcap_bit_nr = be32_to_cpup(prop);
+	else
+		f.hwcap_bit_nr = -1;
+
+	if (f.usable_mask & USABLE_HV) {
+		if (!(mfmsr() & MSR_HV)) {
+			CPUFT_WARN("HV feature passed to guest\n", uname);
+			return 0;
+		}
+
+		if (!f.hv_support && f.hfscr_bit_nr != -1) {
+			CPUFT_WARN("unwanted hfscr_bit_nr\n", uname);
+			return 0;
+		}
+
+		if (f.hv_support == HV_SUPPORT_HFSCR) {
+			if (f.hfscr_bit_nr == -1) {
+				CPUFT_WARN("missing hfscr_bit_nr\n", uname);
+				return 0;
+			}
+		}
+	} else {
+		if (f.hv_support != HV_SUPPORT_NONE || f.hfscr_bit_nr != -1) {
+			CPUFT_WARN("unwanted hv_support/hfscr_bit_nr\n", uname);
+			return 0;
+		}
+	}
+
+	if (f.usable_mask & USABLE_OS) {
+		if (!f.os_support && f.fscr_bit_nr != -1) {
+			CPUFT_WARN("unwanted fscr_bit_nr\n", uname);
+			return 0;
+		}
+
+		if (f.os_support == OS_SUPPORT_FSCR) {
+			if (f.fscr_bit_nr == -1) {
+				CPUFT_WARN("missing fscr_bit_nr\n", uname);
+				return 0;
+			}
+		}
+	} else {
+		if (f.os_support != OS_SUPPORT_NONE || f.fscr_bit_nr != -1) {
+			CPUFT_WARN("unwanted os_support/fscr_bit_nr\n", uname);
+			return 0;
+		}
+	}
+
+	if (!(f.usable_mask & USABLE_PR)) {
+		if (f.hwcap_bit_nr != -1) {
+			CPUFT_WARN("unwanted hwcap_bit_nr\n", uname);
+			return 0;
+		}
+	}
+
+	cpufeatures_process_feature(&f);
+
+	return 0;
+}
+
+static int __init early_init_dt_scan_cpufeatures(unsigned long node,
+					  const char *uname, int depth,
+					  void *data)
+{
+	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	const __be32 *prop;
+	u32 isa;
+
+	/* We are scanning "features" nodes only */
+	if (type == NULL || strcmp(type, "cpu-features") != 0)
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "isa", NULL);
+	if (!prop) {
+		printk("cpu-features node has missing property \"isa\"\n");
+		return 0;
+	}
+
+	isa = be32_to_cpup(prop);
+
+	has_cpufeatures_node = 1;
+
+	cpufeatures_setup_start(isa);
+
+	of_scan_flat_dt_subnodes(node, scan_cpufeatures_subnodes, NULL);
+
+	cpufeatures_setup_finished();
+
+	return 0;
+}
+
+static int __init early_init_dt_scan_cpufeatures_exists(unsigned long node,
+					  const char *uname, int depth,
+					  void *data)
+{
+	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
+	int *exists = data;
+
+	/* We are scanning "features" nodes only */
+	if (type == NULL || strcmp(type, "cpu-features") != 0)
+		return 0;
+
+	*exists = 1;
+
+	return 0;
+}
+
 static int __init early_init_dt_scan_cpus(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
@@ -377,22 +532,32 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	 * uses the 0x0f000002 PVR value; in POWER5+ mode
 	 * it uses 0x0f000001.
 	 */
-	prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
-	if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000)
-		identify_cpu(0, be32_to_cpup(prop));
+	if (!has_cpufeatures_node) {
+		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
+		if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000)
+			identify_cpu(0, be32_to_cpup(prop));
+		identical_pvr_fixup(node);
 
-	identical_pvr_fixup(node);
-
-	check_cpu_feature_properties(node);
-	check_cpu_pa_features(node);
-	init_mmu_slb_size(node);
+		check_cpu_feature_properties(node);
+		check_cpu_pa_features(node);
 
 #ifdef CONFIG_PPC64
-	if (nthreads > 1)
-		cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
-	else
-		cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
+		if (nthreads > 1)
+			cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
+		else
+			cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
 #endif
+	} else {
+		strcpy(cur_cpu_spec->cpu_name, uname);
+#ifdef CONFIG_PPC64
+		if (nthreads == 1)
+			cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
+#endif
+	}
+
+
+	init_mmu_slb_size(node);
+
 	return 0;
 }
 
@@ -648,6 +813,16 @@ static void __init early_reserve_mem(void)
 #endif
 }
 
+/*
+ * Does the /cpus/features/ node exist?
+ */
+int __init early_init_devtree_check_cpu_features_exists(void)
+{
+	int exists = 0;
+	of_scan_flat_dt(early_init_dt_scan_cpufeatures_exists, &exists);
+	return exists;
+}
+
 void __init early_init_devtree(void *params)
 {
 	phys_addr_t limit;
@@ -722,6 +897,8 @@ void __init early_init_devtree(void *params)
 
 	DBG("Scanning CPUs ...\n");
 
+	of_scan_flat_dt(early_init_dt_scan_cpufeatures, NULL);
+
 	/* Retrieve CPU related informations from the flat tree
 	 * (altivec support, boot CPU ID, ...)
 	 */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4697da895133..fe52229681da 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -256,7 +256,7 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "cpu\t\t: ");
 
-	if (cur_cpu_spec->pvr_mask)
+	if (cur_cpu_spec->pvr_mask && cur_cpu_spec->cpu_name)
 		seq_printf(m, "%s", cur_cpu_spec->cpu_name);
 	else
 		seq_printf(m, "unknown (%08x)", pvr);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b9855f1b290a..8326f4ebd143 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -49,6 +49,7 @@
 #include <asm/paca.h>
 #include <asm/time.h>
 #include <asm/cputable.h>
+#include <asm/cpufeatures.h>
 #include <asm/sections.h>
 #include <asm/btext.h>
 #include <asm/nvram.h>
@@ -264,11 +265,22 @@ static void cpu_ready_for_interrupts(void)
 void __init early_setup(unsigned long dt_ptr)
 {
 	static __initdata struct paca_struct boot_paca;
+	int cpufeatures = 0;
 
 	/* -------- printk is _NOT_ safe to use here ! ------- */
 
-	/* Identify CPU type */
-	identify_cpu(0, mfspr(SPRN_PVR));
+#ifdef CONFIG_PPC_BOOK3S_64
+	/* Setup flat device-tree pointer */
+	initial_boot_params = __va(dt_ptr);
+	if (early_init_devtree_check_cpu_features_exists()) {
+		cpufeatures = 1;
+		cpufeatures_setup_cpu();
+	} else
+#endif
+	{
+		/* Legacy table-based approach when /cpus/features is missing */
+		identify_cpu(0, mfspr(SPRN_PVR));
+	}
 
 	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
 	initialise_paca(&boot_paca, 0);
@@ -282,6 +294,8 @@ void __init early_setup(unsigned long dt_ptr)
 
  	DBG(" -> early_setup(), dt_ptr: 0x%lx\n", dt_ptr);
 
+	printk("cpufeatures:%d\n", cpufeatures);
+
 	/*
 	 * Do early initialization using the flattened device
 	 * tree, such as retrieving the physical memory map or
@@ -531,6 +545,9 @@ void __init initialize_cache_info(void)
 	dcache_bsize = ppc64_caches.l1d.block_size;
 	icache_bsize = ppc64_caches.l1i.block_size;
 
+	cur_cpu_spec->dcache_bsize = dcache_bsize;
+	cur_cpu_spec->icache_bsize = icache_bsize;
+
 	DBG(" <- initialize_cache_info()\n");
 }
 
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index e5ce4b59e162..3a6dc53fa87b 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -754,6 +754,37 @@ int __init of_scan_flat_dt(int (*it)(unsigned long node,
 }
 
 /**
+ * of_scan_flat_dt_subnodes - scan sub-nodes of a node call callback on each.
+ * @it: callback function
+ * @data: context data pointer
+ *
+ * This function is used to scan sub-nodes of a node.
+ */
+int __init of_scan_flat_dt_subnodes(unsigned long node,
+				    int (*it)(unsigned long node,
+					      const char *uname,
+					      void *data),
+				    void *data)
+{
+	const void *blob = initial_boot_params;
+	const char *pathp;
+	int offset, rc = 0;
+
+	offset = node;
+        for (offset = fdt_first_subnode(blob, offset);
+             offset >= 0 && !rc;
+             offset = fdt_next_subnode(blob, offset)) {
+
+		pathp = fdt_get_name(blob, offset, NULL);
+		if (*pathp == '/')
+			pathp = kbasename(pathp);
+		rc = it(offset, pathp, data);
+	}
+	return rc;
+}
+
+
+/**
  * of_get_flat_dt_subnode_by_name - get the subnode by given name
  *
  * @node: the parent node
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 271b3fdf0070..22c346ac0100 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -54,6 +54,11 @@ extern char __dtb_end[];
 extern int of_scan_flat_dt(int (*it)(unsigned long node, const char *uname,
 				     int depth, void *data),
 			   void *data);
+extern int of_scan_flat_dt_subnodes(unsigned long node,
+				    int (*it)(unsigned long node,
+					      const char *uname,
+					      void *data),
+				    void *data);
 extern int of_get_flat_dt_subnode_by_name(unsigned long node,
 					  const char *uname);
 extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
-- 
2.11.0
