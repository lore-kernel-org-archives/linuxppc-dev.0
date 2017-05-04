Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJW6X6SMfzDqBJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 20:12:20 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id i63so1670453pgd.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 May 2017 03:12:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s: ibm,powerpc-cpu-features dt implementation
Date: Thu,  4 May 2017 20:12:04 +1000
Message-Id: <20170504101204.13856-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibm,powerpc-cpu-features dt binding describes CPU features with
ascii names and extensible compatibility, privilege, and enablement
metadata that allows improved flexibility and compatibility with new
hardware.

Design overview and specification of features is available in the OPAL
source.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Since last post:
- Check the "compatible" property.
- Update documentation, don't specify it has to be a child node of /cpus/
- POWER9 CPU_FTR_ICSWX bit is now clear upstream.
- Fix POWER9 DD1 feature getting applied.
- PPC_FEATURE2_EBB is left to PMU init for the moment (matching existing
  init).
- Slightly change how LPCR was being set in cpu_restore, to match existing
  code for idle reinit.
- Add init time TLB flushes to match existing boot init.

Mambo still has a few issues with POWER8:
- HFSCR bit 54 and 57 are now clear (mambo sets at init)
- PMAO_BUG is set. This is due to mambo setting architected POWER8 mode
  and POWER8E PVR. Current kernels lose PMAO_BUG bit.
- CI_LARGE_PAGE is now set (mambo boot does not set it for some reason,
  haven't looked at why).
---
 .../bindings/powerpc/ibm,powerpc-cpu-features.txt  | 246 +++++++
 arch/powerpc/Kconfig                               |  16 +
 arch/powerpc/include/asm/cpu_has_feature.h         |   4 +-
 arch/powerpc/include/asm/cpufeatures.h             |  55 ++
 arch/powerpc/include/asm/cputable.h                |   2 +
 arch/powerpc/include/asm/reg.h                     |   1 +
 arch/powerpc/include/uapi/asm/cputable.h           |   6 +
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/cpufeatures.c                  | 724 +++++++++++++++++++++
 arch/powerpc/kernel/cputable.c                     |  37 +-
 arch/powerpc/kernel/prom.c                         | 338 +++++++++-
 arch/powerpc/kernel/setup-common.c                 |   2 +-
 arch/powerpc/kernel/setup_64.c                     |  15 +-
 13 files changed, 1430 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/ibm,powerpc-cpu-features.txt
 create mode 100644 arch/powerpc/include/asm/cpufeatures.h
 create mode 100644 arch/powerpc/kernel/cpufeatures.c

diff --git a/Documentation/devicetree/bindings/powerpc/ibm,powerpc-cpu-features.txt b/Documentation/devicetree/bindings/powerpc/ibm,powerpc-cpu-features.txt
new file mode 100644
index 000000000000..2cabfc4d7e18
--- /dev/null
+++ b/Documentation/devicetree/bindings/powerpc/ibm,powerpc-cpu-features.txt
@@ -0,0 +1,246 @@
+*** NOTE ***
+This document is copied from OPAL firmware
+(skiboot/doc/device-tree/ibm,powerpc-cpu-features/binding.txt)
+
+There is more complete overview and documentation of features in that
+source tree.  All patches and modifications should go there.
+************
+
+ibm,powerpc-cpu-features binding
+================================
+
+This device tree binding describes CPU features available to software, with
+enablement, privilege, and compatibility metadata.
+
+More general description of design and implementation of this binding is
+found in design.txt, which also points to documentation of specific features.
+
+
+/cpus/ibm,powerpc-cpu-features node binding
+-------------------------------------------
+
+Node: ibm,powerpc-cpu-features
+
+Description: Container of CPU feature nodes.
+
+The node name must be "ibm,powerpc-cpu-features".
+
+It is implemented as a child of the node "/cpus", but this must not be
+assumed by parsers.
+
+The node is optional but should be provided by new OPAL firmware.
+
+Properties:
+
+- device_type
+  Usage: required
+  Value type: string
+  Definition: "cpu-features"
+
+- compatible
+  Usage: required
+  Value type: string
+  Definition: "ibm,powerpc-cpu-features"
+
+  This compatibility refers to backwards compatibility of the overall
+  design with parsers that behave according to these guidelines. This can
+  be extended in a backward compatible manner which would not warrant a
+  revision of the compatible property.
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
+/cpus/ibm,powerpc-cpu-features/example-feature node bindings
+----------------------------------------------------------------
+
+Each child node of cpu-features represents a CPU feature / capability.
+
+Node: A string describing an architected CPU feature, e.g., "floating-point".
+
+Description: A feature or capability supported by the CPUs.
+
+The name of the node is a human readable string that forms the interface
+used to describe features to software. Features are currently documented
+in the code where they are implemented in skiboot/core/cpufeatures.c
+
+Presence of the node indicates the feature is available.
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
+- usable-privilege
+  Usage: required
+  Value type: <u32> bit mask
+  Definition:
+              Bit numbers are LSB0
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
+
+- hv-support
+  Usage: optional
+  Value type: <u32> bit mask
+  Definition:
+              Bit numbers are LSB0
+              bit 0 -  HFSCR
+              All other bits reserved and should be zero.
+
+  This property describes the HV privilege support required to enable the
+  feature to lesser privilege levels. If the property does not exist then no
+  support is required.
+
+  If no bits are set, the hypervisor must have explicit/custom support for
+  this feature.
+
+  If the HFSCR bit is set, then the hfscr-bit-nr property will exist and
+  the feature may be enabled by setting this bit in the HFSCR register.
+
+
+- os-support
+  Usage: optional
+  Value type: <u32> bit mask
+  Definition:
+              Bit numbers are LSB0
+              bit 0 -  FSCR
+              All other bits reserved and should be zero.
+
+  This property describes the OS privilege support required to enable the
+  feature to lesser privilege levels. If the property does not exist then no
+  support is required.
+
+  If no bits are set, the operating system must have explicit/custom support
+  for this feature.
+
+  If the FSCR bit is set, then the fscr-bit-nr property will exist and
+  the feature may be enabled by setting this bit in the FSCR register.
+
+
+- hfscr-bit-nr
+  Usage: optional
+  Value type: <u32>
+  Definition: HFSCR bit position (LSB0)
+
+  This property exists when the hv-support property HFSCR bit is set. This
+  property describes the bit number in the HFSCR register that the
+  hypervisor must set in order to enable this feature.
+
+  This property also exists if an HFSCR bit corresponds with this feature.
+  This makes CPU feature parsing slightly simpler.
+
+
+- fscr-bit-nr
+  Usage: optional
+  Value type: <u32>
+  Definition: FSCR bit position (LSB0)
+
+  This property exists when the os-support property FSCR bit is set. This
+  property describes the bit number in the FSCR register that the
+  operating system must set in order to enable this feature.
+
+  This property also exists if an FSCR bit corresponds with this feature.
+  This makes CPU feature parsing slightly simpler.
+
+
+- hwcap-bit-nr
+  Usage: optional
+  Value type: <u32>
+  Definition: Linux ELF AUX vector bit position (LSB0)
+
+  This property may exist when the usable-privilege property value has PR bit set.
+  This property describes the bit number that should be set in the ELF AUX
+  hardware capability vectors in order to advertise this feature to userspace.
+  Bits 0-31 correspond to bits 0-31 in AT_HWCAP vector. Bits 32-63 correspond
+  to 0-31 in AT_HWCAP2 vector, and so on.  Missing AT_HWCAPx vectors implies
+  that the feature is not enabled or can not be advertised. Operating systems
+  may provide a number of unassigned hardware capability bits to allow for new
+  features to be advertised.
+
+  Some properties representing features created before this binding are
+  advertised to userspace without a one-to-one hwcap bit number may not specify
+  this bit. Operating system will handle those bits specifically.  All new
+  features usable by userspace will have a hwcap-bit-nr property.
+
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
+	/cpus/ibm,powerpc-cpu-features {
+		device_type = "ibm,powerpc-cpu-features";
+
+		isa = <3020>;
+
+		darn {
+			isa = <3000>;
+			usable-privilege = <1 | 2 | 4>;
+			hwcap-bit-nr = <xx>;
+		};
+
+		scv {
+			isa = <3000>;
+			usable-privilege = <1 | 2>;
+			os-support = <0>;
+			hwcap-bit-nr = <xx>;
+		};
+
+		stop {
+			isa = <3000>;
+			usable-privilege = <2 | 4>;
+			hv-support = <0>;
+			os-support = <0>;
+		};
+
+		vsx2 (hypothetical) {
+			isa = <3010>;
+			usable-privilege = <1 | 2 | 4>;
+			hv-support = <0>;
+			os-support = <0>;
+			hwcap-bit-nr = <xx>;
+		};
+
+		vsx2-newinsns {
+			isa = <3020>;
+			usable-privilege = <1 | 2 | 4>;
+			os-support = <1>;
+			fscr-bit-nr = <xx>;
+			hwcap-bit-nr = <xx>;
+			dependencies = <&vsx2>;
+		};
+
+	};
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 67ee6731f4e9..e705772c347b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -380,6 +380,22 @@ source "arch/powerpc/platforms/Kconfig"
 
 menu "Kernel options"
 
+config PPC_CPUFEATURES_DT
+	bool "cpufeatures cpu setup and device tree support (UNSTABLE)"
+	depends on PPC_BOOK3S_64
+	default n
+	---help---
+	  cpufeatures is a proposed new device tree binding for describing
+	  CPU compatibility and features. Saying y here will attempt to use
+	  cpufeatures binding if the firmware provides it. This binding is
+	  not stable, so a kernel built with this option may not function
+	  properly with future firmware.
+
+config PPC_CPUFEATURES_ENABLE_UNKNOWN
+	bool "cpufeatures pass through unknown features to guest/userspace"
+	depends on PPC_CPUFEATURES_DT
+	default y
+
 config HIGHMEM
 	bool "High memory support"
 	depends on PPC32
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
index 000000000000..867c0e06982c
--- /dev/null
+++ b/arch/powerpc/include/asm/cpufeatures.h
@@ -0,0 +1,55 @@
+#ifndef __ASM_POWERPC_CPUFEATURES_H
+#define __ASM_POWERPC_CPUFEATURES_H
+
+/*
+ *  Copyright 2017, IBM Corporation
+ *  cpufeatures is the new way to discover CPU features with /cpus/features
+ *  devicetree. This supersedes PVR based discovery ("cputable"), and older
+ *  device tree feature advertisement.
+ */
+
+#include <linux/types.h>
+#include <asm/asm-compat.h>
+#include <asm/feature-fixups.h>
+#include <uapi/asm/cputable.h>
+
+extern void cpufeatures_setup_cpu(void);
+
+/* Device-tree visible constants follow */
+#define ISA_V2_07B      2070
+#define ISA_V3_0B       3000
+
+#define USABLE_PR               (1U << 0)
+#define USABLE_OS               (1U << 1)
+#define USABLE_HV               (1U << 2)
+
+#define HV_SUPPORT_HFSCR        (1U << 0)
+#define OS_SUPPORT_FSCR         (1U << 0)
+
+/* For parsing, we define all bits set as "NONE" case */
+#define HV_SUPPORT_NONE		0xffffffffU
+#define OS_SUPPORT_NONE		0xffffffffU
+
+struct dt_cpu_feature {
+	const char *name;
+	uint32_t isa;
+	uint32_t usable_privilege;
+	uint32_t hv_support;
+	uint32_t os_support;
+	uint32_t hfscr_bit_nr;
+	uint32_t fscr_bit_nr;
+	uint32_t hwcap_bit_nr;
+	/* fdt parsing */
+	unsigned long node;
+	int enabled;
+	int disabled;
+};
+
+extern void cpufeatures_setup_start(u32 isa);
+extern int cpufeatures_process_feature(struct dt_cpu_feature *f);
+extern void cpufeatures_setup_finished(void);
+
+/* kernel/prom.c */
+extern int early_init_devtree_check_cpu_features_exists(void);
+
+#endif
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 1f6847b107e4..c2d509584a98 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -118,7 +118,9 @@ extern struct cpu_spec		*cur_cpu_spec;
 
 extern unsigned int __start___ftr_fixup, __stop___ftr_fixup;
 
+extern void set_cur_cpu_spec(struct cpu_spec *s);
 extern struct cpu_spec *identify_cpu(unsigned long offset, unsigned int pvr);
+extern void identify_cpu_name(unsigned int pvr);
 extern void do_feature_fixups(unsigned long value, void *fixup_start,
 			      void *fixup_end);
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d4f653c9259a..7e50e47375d6 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1229,6 +1229,7 @@
 #define PVR_POWER8E	0x004B
 #define PVR_POWER8NVL	0x004C
 #define PVR_POWER8	0x004D
+#define PVR_POWER9	0x004E
 #define PVR_BE		0x0070
 #define PVR_PA6T	0x0090
 
diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h
index f63c96cd3608..b411f9e7757c 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -1,6 +1,12 @@
 #ifndef _UAPI__ASM_POWERPC_CPUTABLE_H
 #define _UAPI__ASM_POWERPC_CPUTABLE_H
 
+/*
+ * IMPORTANT!
+ * All future PPC_FEATURE_* definitions must be allocated by OPAL / skiboot
+ * firmware, in accordance with the ibm,powerpc-cpu-features specification.
+ */
+
 /* in AT_HWCAP */
 #define PPC_FEATURE_32			0x80000000
 #define PPC_FEATURE_64			0x40000000
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index b9db46ae545b..f4db8b23ec38 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_PPC_RTAS)		+= rtas.o rtas-rtc.o $(rtaspci-y-y)
 obj-$(CONFIG_PPC_RTAS_DAEMON)	+= rtasd.o
 obj-$(CONFIG_RTAS_FLASH)	+= rtas_flash.o
 obj-$(CONFIG_RTAS_PROC)		+= rtas-proc.o
+obj-$(CONFIG_PPC_CPUFEATURES_DT)	+= cpufeatures.o
 obj-$(CONFIG_EEH)              += eeh.o eeh_pe.o eeh_dev.o eeh_cache.o \
 				  eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
diff --git a/arch/powerpc/kernel/cpufeatures.c b/arch/powerpc/kernel/cpufeatures.c
new file mode 100644
index 000000000000..76b688652012
--- /dev/null
+++ b/arch/powerpc/kernel/cpufeatures.c
@@ -0,0 +1,724 @@
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
+#ifdef DEBUG
+#define DBG(fmt...) pr_err(fmt)
+#else
+#define DBG(fmt...)
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
+extern long __machine_check_early_realmode_p9(struct pt_regs *regs);
+
+static int hv_mode;
+
+static struct {
+	u64	lpcr;
+	u64	hfscr;
+	u64	fscr;
+} system_registers;
+
+static void (*init_pmu_registers)(void);
+
+static void cpufeatures_flush_tlb(void)
+{
+	unsigned long rb;
+	unsigned int i, num_sets;
+
+	/*
+	 * This is a temporary measure to keep equivalent TLB flush as the
+	 * cputable based setup code.
+	 */
+	switch (PVR_VER(mfspr(SPRN_PVR))) {
+	case PVR_POWER8:
+	case PVR_POWER8E:
+	case PVR_POWER8NVL:
+		num_sets = POWER8_TLB_SETS;
+		break;
+	case PVR_POWER9:
+		num_sets = POWER9_TLB_SETS_HASH;
+		break;
+	default:
+		num_sets = 1;
+		pr_err("cpufeatures unknown CPU version for boot TLB flush\n");
+		break;
+	}
+
+	asm volatile("ptesync" : : : "memory");
+	rb = TLBIEL_INVAL_SET;
+	for (i = 0; i < num_sets; i++) {
+		asm volatile("tlbiel %0" : : "r" (rb));
+		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
+	}
+	asm volatile("ptesync" : : : "memory");
+}
+
+static void __restore_cpu_cpufeatures(void)
+{
+	/*
+	 * LPCR is restored by the power on engine already. It can be changed
+	 * after early init e.g., by radix enable, and we have no unified API
+	 * for saving and restoring such SPRs.
+	 *
+	 * This ->restore hook should really be removed from idle and register
+	 * restore moved directly into the idle restore code, because this code
+	 * doesn't know how idle is implemented or what it needs restored here.
+	 *
+	 * The best we can do to accommodate secondary boot and idle restore
+	 * for now is "or" LPCR with existing.
+	 */
+
+	mtspr(SPRN_LPCR, system_registers.lpcr | mfspr(SPRN_LPCR));
+	if (hv_mode) {
+		mtspr(SPRN_LPID, 0);
+		mtspr(SPRN_HFSCR, system_registers.hfscr);
+	}
+	mtspr(SPRN_FSCR, system_registers.fscr);
+
+	if (init_pmu_registers)
+		init_pmu_registers();
+
+	cpufeatures_flush_tlb();
+}
+
+static struct cpu_spec __initdata base_cpu_spec = {
+	.cpu_name		= NULL,
+	.cpu_features		= CPU_FTRS_BASE,
+	.cpu_user_features	= COMMON_USER_BASE,
+	.cpu_user_features2	= COMMON_USER2_BASE,
+	.mmu_features		= 0,
+	.icache_bsize		= 32, /* minimum block size, fixed by */
+	.dcache_bsize		= 32, /* cache info init.             */
+	.num_pmcs		= 0,
+	.pmc_type		= PPC_PMC_DEFAULT,
+	.oprofile_cpu_type	= NULL,
+	.oprofile_type		= PPC_OPROFILE_INVALID,
+	.cpu_setup		= NULL,
+	.cpu_restore		= __restore_cpu_cpufeatures,
+	.flush_tlb		= NULL,
+	.machine_check_early	= NULL,
+	.platform		= NULL,
+};
+
+void __init cpufeatures_setup_cpu(void)
+{
+	set_cur_cpu_spec(&base_cpu_spec);
+
+	cur_cpu_spec->pvr_mask = -1;
+	cur_cpu_spec->pvr_value = mfspr(SPRN_PVR);
+
+	/* Initialize the base environment -- clear FSCR/HFSCR.  */
+	hv_mode = !!(mfmsr() & MSR_HV);
+	if (hv_mode) {
+		/* CPU_FTR_HVMODE is used early in PACA setup */
+		cur_cpu_spec->cpu_features |= CPU_FTR_HVMODE;
+		mtspr(SPRN_HFSCR, 0);
+	}
+	mtspr(SPRN_FSCR, 0);
+
+	/*
+	 * LPCR does not get cleared, to match behaviour with secondaries
+	 * in __restore_cpu_cpufeatures. Once the idle code is fixed, this
+	 * could clear LPCR too.
+	 */
+}
+
+static int __init feat_try_enable_unknown(struct dt_cpu_feature *f)
+{
+	if (f->hv_support == HV_SUPPORT_NONE) {
+	} else if (f->hv_support & HV_SUPPORT_HFSCR) {
+		u64 hfscr = mfspr(SPRN_HFSCR);
+		hfscr |= 1UL << f->hfscr_bit_nr;
+		mtspr(SPRN_HFSCR, hfscr);
+	} else {
+		/* Does not have a known recipe */
+		return 0;
+	}
+
+	if (f->os_support == OS_SUPPORT_NONE) {
+	} else if (f->os_support & OS_SUPPORT_FSCR) {
+		u64 fscr = mfspr(SPRN_FSCR);
+		fscr |= 1UL << f->fscr_bit_nr;
+		mtspr(SPRN_FSCR, fscr);
+	} else {
+		/* Does not have a known recipe */
+		return 0;
+	}
+
+	if ((f->usable_privilege & USABLE_PR) && (f->hwcap_bit_nr != -1)) {
+		uint32_t word = f->hwcap_bit_nr / 32;
+		uint32_t bit = f->hwcap_bit_nr % 32;
+
+		if (word == 0)
+			cur_cpu_spec->cpu_user_features |= 1U << bit;
+		else if (word == 1)
+			cur_cpu_spec->cpu_user_features2 |= 1U << bit;
+		else
+			pr_err("CPU feature: %s could not advertise to user (no hwcap bits)\n", f->name);
+	}
+
+	return 1;
+}
+
+static int __init feat_enable(struct dt_cpu_feature *f)
+{
+	if (f->hv_support != HV_SUPPORT_NONE) {
+		if (f->hfscr_bit_nr != -1) {
+			u64 hfscr = mfspr(SPRN_HFSCR);
+			hfscr |= 1UL << f->hfscr_bit_nr;
+			mtspr(SPRN_HFSCR, hfscr);
+		}
+	}
+
+	if (f->os_support != OS_SUPPORT_NONE) {
+		if (f->fscr_bit_nr != -1) {
+			u64 fscr = mfspr(SPRN_FSCR);
+			fscr |= 1UL << f->fscr_bit_nr;
+			mtspr(SPRN_FSCR, fscr);
+		}
+	}
+
+	if ((f->usable_privilege & USABLE_PR) && (f->hwcap_bit_nr != -1)) {
+		uint32_t word = f->hwcap_bit_nr / 32;
+		uint32_t bit = f->hwcap_bit_nr % 32;
+
+		if (word == 0)
+			cur_cpu_spec->cpu_user_features |= 1U << bit;
+		else if (word == 1)
+			cur_cpu_spec->cpu_user_features2 |= 1U << bit;
+		else
+			pr_err("CPU feature: %s could not advertise to user (no hwcap bits)\n", f->name);
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
+static int __init feat_enable_hv(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	if (!hv_mode) {
+		pr_err("CPU feature hypervisor present in device tree but HV mode not enabled in the CPU. Ignoring.\n");
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
+	/* Set PECE wakeup modes for ISAv3.0B */
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |=  LPCR_PECE0;
+	lpcr |=  LPCR_PECE1;
+	lpcr |=  LPCR_PECE2;
+	mtspr(SPRN_LPCR, lpcr);
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
+static void hfscr_pmu_enable(void)
+{
+	u64 hfscr = mfspr(SPRN_HFSCR);
+	hfscr |= PPC_BIT(60);
+	mtspr(SPRN_HFSCR, hfscr);
+}
+
+static void init_pmu_power8(void)
+{
+	if (hv_mode) {
+		mtspr(SPRN_MMCRC, 0);
+		mtspr(SPRN_MMCRH, 0);
+	}
+
+	mtspr(SPRN_MMCRA, 0);
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR1, 0);
+	mtspr(SPRN_MMCR2, 0);
+	mtspr(SPRN_MMCRS, 0);
+}
+
+static int __init feat_enable_mce_power8(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->platform = "power8";
+	cur_cpu_spec->flush_tlb = __flush_tlb_power8;
+	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p8;
+
+	return 1;
+}
+
+static int __init feat_enable_pmu_power8(struct dt_cpu_feature *f)
+{
+	hfscr_pmu_enable();
+
+	init_pmu_power8();
+	init_pmu_registers = init_pmu_power8;
+
+	cur_cpu_spec->cpu_features |= CPU_FTR_MMCRA;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_PSERIES_PERFMON_COMPAT;
+	if (pvr_version_is(PVR_POWER8E))
+		cur_cpu_spec->cpu_features |= CPU_FTR_PMAO_BUG;
+
+	cur_cpu_spec->num_pmcs		= 6;
+	cur_cpu_spec->pmc_type		= PPC_PMC_IBM;
+	cur_cpu_spec->oprofile_cpu_type	= "ppc64/power8";
+
+	return 1;
+}
+
+static void init_pmu_power9(void)
+{
+	if (hv_mode)
+		mtspr(SPRN_MMCRC, 0);
+
+	mtspr(SPRN_MMCRA, 0);
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_MMCR1, 0);
+	mtspr(SPRN_MMCR2, 0);
+}
+
+static int __init feat_enable_mce_power9(struct dt_cpu_feature *f)
+{
+	cur_cpu_spec->platform = "power9";
+	cur_cpu_spec->flush_tlb = __flush_tlb_power9;
+	cur_cpu_spec->machine_check_early = __machine_check_early_realmode_p9;
+
+	return 1;
+}
+
+static int __init feat_enable_pmu_power9(struct dt_cpu_feature *f)
+{
+	hfscr_pmu_enable();
+
+	init_pmu_power9();
+	init_pmu_registers = init_pmu_power9;
+
+	cur_cpu_spec->cpu_features |= CPU_FTR_MMCRA;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_PSERIES_PERFMON_COMPAT;
+
+	cur_cpu_spec->num_pmcs		= 6;
+	cur_cpu_spec->pmc_type		= PPC_PMC_IBM;
+	cur_cpu_spec->oprofile_cpu_type	= "ppc64/power9";
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
+#ifdef CONFIG_ALTIVEC
+	feat_enable(f);
+	cur_cpu_spec->cpu_features |= CPU_FTR_ALTIVEC;
+	cur_cpu_spec->cpu_features |= CPU_FTR_VMX_COPY;
+	cur_cpu_spec->cpu_user_features |= PPC_FEATURE_HAS_ALTIVEC;
+
+	return 1;
+#endif
+	return 0;
+}
+
+static int __init feat_enable_vsx(struct dt_cpu_feature *f)
+{
+#ifdef CONFIG_VSX
+	feat_enable(f);
+	cur_cpu_spec->cpu_features |= CPU_FTR_VSX;
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
+static int __init feat_enable_ebb(struct dt_cpu_feature *f)
+{
+	/*
+	 * PPC_FEATURE2_EBB is enabled in PMU init code because it has
+	 * historically been related to the PMU facility. This may have
+	 * to be decoupled if EBB becomes more generic. For now, follow
+	 * existing convention.
+	 */
+	f->hwcap_bit_nr = -1;
+	feat_enable(f);
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
+	return 1;
+}
+
+static int __init feat_enable_hvi(struct dt_cpu_feature *f)
+{
+	u64 lpcr;
+
+	/*
+	 * POWER9 XIVE interrupts including in OPAL XICS compatibility
+	 * are always delivered as hypervisor virtualization interrupts (HVI)
+	 * rather than EE.
+	 *
+	 * However LPES0 is not set here, in the chance that an EE does get
+	 * delivered to the host somehow, the EE handler would not expect it
+	 * to be delivered in LPES0 mode (e.g., using SRR[01]). This could
+	 * happen if there is a bug in interrupt controller code, or IC is
+	 * misconfigured in systemsim.
+	 */
+
+	lpcr = mfspr(SPRN_LPCR);
+	lpcr |= LPCR_HVICE;	/* enable hvi interrupts */
+	lpcr |= LPCR_HEIC;	/* disable ee interrupts when MSR_HV */
+	lpcr |= LPCR_PECE_HVEE; /* hvi can wake from stop */
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
+struct dt_cpu_feature_match {
+	const char *name;
+	int (*enable)(struct dt_cpu_feature *f);
+	u64 cpu_ftr_bit_mask;
+};
+
+static struct dt_cpu_feature_match __initdata
+		dt_cpu_feature_match_table[] = {
+	{"hypervisor", feat_enable_hv, 0},
+	{"big-endian", feat_enable, 0},
+	{"little-endian", feat_enable_le, CPU_FTR_REAL_LE},
+	{"smt", feat_enable_smt, 0},
+	{"interrupt-facilities", feat_enable, 0},
+	{"timer-facilities", feat_enable, 0},
+	{"timer-facilities-v3", feat_enable, 0},
+	{"debug-facilities", feat_enable, 0},
+	{"come-from-address-register", feat_enable, CPU_FTR_CFAR},
+	{"branch-tracing", feat_enable, 0},
+	{"floating-point", feat_enable_fp, 0},
+	{"vector", feat_enable_vector, 0},
+	{"vector-scalar", feat_enable_vsx, 0},
+	{"vector-scalar-v3", feat_enable, 0},
+	{"decimal-floating-point", feat_enable, 0},
+	{"decimal-integer", feat_enable, 0},
+	{"quadword-load-store", feat_enable, 0},
+	{"vector-crypto", feat_enable, 0},
+	{"mmu-hash", feat_enable_mmu_hash, 0},
+	{"mmu-radix", feat_enable_mmu_radix, 0},
+	{"mmu-hash-v3", feat_enable_mmu_hash_v3, 0},
+	{"virtual-page-class-key-protection", feat_enable, 0},
+	{"transactional-memory", feat_enable_tm, CPU_FTR_TM},
+	{"transactional-memory-v3", feat_enable_tm, 0},
+	{"idle-nap", feat_enable_idle_nap, 0},
+	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
+	{"idle-stop", feat_enable_idle_stop, 0},
+	{"machine-check-power8", feat_enable_mce_power8, 0},
+	{"performance-monitor-power8", feat_enable_pmu_power8, 0},
+	{"data-stream-control-register", feat_enable_dscr, CPU_FTR_DSCR},
+	{"event-based-branch", feat_enable_ebb, 0},
+	{"target-address-register", feat_enable, 0},
+	{"branch-history-rolling-buffer", feat_enable, 0},
+	{"control-register", feat_enable, CPU_FTR_CTRL},
+	{"processor-control-facility", feat_enable_dbell, CPU_FTR_DBELL},
+	{"processor-control-facility-v3", feat_enable_dbell, CPU_FTR_DBELL},
+	{"processor-utilization-of-resources-register", feat_enable_purr, 0},
+	{"subcore", feat_enable, CPU_FTR_SUBCORE},
+	{"no-execute", feat_enable, 0},
+	{"strong-access-ordering", feat_enable, CPU_FTR_SAO},
+	{"cache-inhibited-large-page", feat_enable_large_ci, 0},
+	{"coprocessor-icswx", feat_enable, CPU_FTR_ICSWX},
+	{"hypervisor-virtualization-interrupt", feat_enable_hvi, 0},
+	{"program-priority-register", feat_enable, CPU_FTR_HAS_PPR},
+	{"wait", feat_enable, 0},
+	{"atomic-memory-operations", feat_enable, 0},
+	{"branch-v3", feat_enable, 0},
+	{"copy-paste", feat_enable, 0},
+	{"decimal-floating-point-v3", feat_enable, 0},
+	{"decimal-integer-v3", feat_enable, 0},
+	{"fixed-point-v3", feat_enable, 0},
+	{"floating-point-v3", feat_enable, 0},
+	{"group-start-register", feat_enable, 0},
+	{"pc-relative-addressing", feat_enable, 0},
+	{"machine-check-power9", feat_enable_mce_power9, 0},
+	{"performance-monitor-power9", feat_enable_pmu_power9, 0},
+	{"event-based-branch-v3", feat_enable, 0},
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
+#ifdef CONFIG_PPC_CPUFEATURES_ENABLE_UNKNOWN
+#define CPU_FEATURE_ENABLE_UNKNOWN 1
+#else
+#define CPU_FEATURE_ENABLE_UNKNOWN 0
+#endif
+
+void __init cpufeatures_setup_start(u32 isa)
+{
+	DBG("CPUFEATURES setup for isa %d\n", isa);
+
+	if (isa >= 3000) {
+		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_300;
+		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_00;
+	}
+}
+
+int __init cpufeatures_process_feature(struct dt_cpu_feature *f)
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
+		DBG("CPU feature not enabling:%s (disabled or unsupported by kernel)\n", f->name);
+	else
+		DBG("CPU feature not enabling:%s (unknown and unsupported by kernel)\n", f->name);
+
+	return 0;
+
+enabled:
+	if (m->cpu_ftr_bit_mask)
+		cur_cpu_spec->cpu_features |= m->cpu_ftr_bit_mask;
+	if (known)
+		DBG("CPU feature enabling:%s\n", f->name);
+	else
+		DBG("CPU feature enabling:%s (unknown)\n", f->name);
+
+	return 1;
+}
+
+static __init void cpufeatures_cpu_quirks(void)
+{
+	int version = mfspr(SPRN_PVR);
+
+	/*
+	 * Not all quirks can be derived from the cpufeatures device tree.
+	 */
+	if ((version & 0xffffff00) == 0x004e0100)
+		cur_cpu_spec->cpu_features |= CPU_FTR_POWER9_DD1;
+}
+
+void __init cpufeatures_setup_finished(void)
+{
+	cpufeatures_cpu_quirks();
+
+	if (hv_mode && !(cur_cpu_spec->cpu_features & CPU_FTR_HVMODE)) {
+		pr_err("CPU feature hypervisor not present in device tree but HV mode is enabled in the CPU. Enabling.\n");
+		cur_cpu_spec->cpu_features |= CPU_FTR_HVMODE;
+	}
+
+	system_registers.lpcr = mfspr(SPRN_LPCR);
+	system_registers.hfscr = mfspr(SPRN_HFSCR);
+	system_registers.fscr = mfspr(SPRN_FSCR);
+
+	cpufeatures_flush_tlb();
+}
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e79b9daa873c..9b3e88b1a9c8 100644
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
@@ -2179,7 +2181,15 @@ static struct cpu_spec __initdata cpu_specs[] = {
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
@@ -2266,6 +2276,29 @@ struct cpu_spec * __init identify_cpu(unsigned long offset, unsigned int pvr)
 	return NULL;
 }
 
+/*
+ * Used by cpufeatures to get the name for CPUs with a PVR table.
+ * If they don't hae a PVR table, cpufeatures gets the name from
+ * cpu device-tree node.
+ */
+void __init identify_cpu_name(unsigned int pvr)
+{
+	struct cpu_spec *s = cpu_specs;
+	struct cpu_spec *t = &the_cpu_spec;
+	int i;
+
+	s = PTRRELOC(s);
+	t = PTRRELOC(t);
+
+	for (i = 0; i < ARRAY_SIZE(cpu_specs); i++,s++) {
+		if ((pvr & s->pvr_mask) == s->pvr_value) {
+			t->cpu_name = s->cpu_name;
+			return;
+		}
+	}
+}
+
+
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
 struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS] = {
 			[0 ... NUM_CPU_FTR_KEYS - 1] = STATIC_KEY_TRUE_INIT
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d2f0afeae5a0..c6352a9fe302 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -57,6 +57,7 @@
 #include <asm/fadump.h>
 #include <asm/epapr_hcalls.h>
 #include <asm/firmware.h>
+#include <asm/cpufeatures.h>
 
 #include <mm/mmu_decl.h>
 
@@ -66,6 +67,12 @@
 #define DBG(fmt...)
 #endif
 
+#ifdef CONFIG_PPC_CPUFEATURES_DT
+int __initdata has_cpufeatures_node = 0;
+#else
+static const int has_cpufeatures_node = 0;
+#endif
+
 #ifdef CONFIG_PPC64
 int __initdata iommu_is_off;
 int __initdata iommu_force_on;
@@ -299,6 +306,273 @@ static void __init check_cpu_feature_properties(unsigned long node)
 	}
 }
 
+#ifdef CONFIG_PPC_CPUFEATURES_DT
+#define CPUFT_WARN(str, name) printk(KERN_WARNING "WARNING: /cpus/features/%s dt:%s\n", name, str)
+
+static int nr_dt_cpu_features;
+static struct dt_cpu_feature *dt_cpu_features;
+
+static int __init process_cpufeatures_node(unsigned long node,
+					  const char *uname, int i)
+{
+	const __be32 *prop;
+	struct dt_cpu_feature *f;
+	int len;
+
+	f = &dt_cpu_features[i];
+	memset(f, 0, sizeof(struct dt_cpu_feature));
+
+	f->node = node;
+
+	f->name = uname;
+
+	prop = of_get_flat_dt_prop(node, "isa", &len);
+	if (!prop) {
+		CPUFT_WARN("missing isa property", uname);
+		return 0;
+	}
+	f->isa = be32_to_cpup(prop);
+
+	prop = of_get_flat_dt_prop(node, "usable-privilege", &len);
+	if (!prop) {
+		CPUFT_WARN("missing usable-privilege property", uname);
+		return 0;
+	}
+	f->usable_privilege = be32_to_cpup(prop);
+
+	prop = of_get_flat_dt_prop(node, "hv-support", &len);
+	if (prop)
+		f->hv_support = be32_to_cpup(prop);
+	else
+		f->hv_support = HV_SUPPORT_NONE;
+
+	prop = of_get_flat_dt_prop(node, "os-support", &len);
+	if (prop)
+		f->os_support = be32_to_cpup(prop);
+	else
+		f->os_support = OS_SUPPORT_NONE;
+
+	prop = of_get_flat_dt_prop(node, "hfscr-bit-nr", &len);
+	if (prop)
+		f->hfscr_bit_nr = be32_to_cpup(prop);
+	else
+		f->hfscr_bit_nr = -1;
+	prop = of_get_flat_dt_prop(node, "fscr-bit-nr", &len);
+	if (prop)
+		f->fscr_bit_nr = be32_to_cpup(prop);
+	else
+		f->fscr_bit_nr = -1;
+	prop = of_get_flat_dt_prop(node, "hwcap-bit-nr", &len);
+	if (prop)
+		f->hwcap_bit_nr = be32_to_cpup(prop);
+	else
+		f->hwcap_bit_nr = -1;
+
+	if (f->usable_privilege & USABLE_HV) {
+		if (!(mfmsr() & MSR_HV)) {
+			CPUFT_WARN("HV feature passed to guest\n", uname);
+			return 0;
+		}
+
+		if (f->hv_support == HV_SUPPORT_NONE && f->hfscr_bit_nr != -1) {
+			CPUFT_WARN("unwanted hfscr_bit_nr\n", uname);
+			return 0;
+		}
+
+		if (f->hv_support == HV_SUPPORT_HFSCR) {
+			if (f->hfscr_bit_nr == -1) {
+				CPUFT_WARN("missing hfscr_bit_nr\n", uname);
+				return 0;
+			}
+		}
+	} else {
+		if (f->hv_support != HV_SUPPORT_NONE || f->hfscr_bit_nr != -1) {
+			CPUFT_WARN("unwanted hv_support/hfscr_bit_nr\n", uname);
+			return 0;
+		}
+	}
+
+	if (f->usable_privilege & USABLE_OS) {
+		if (f->os_support == OS_SUPPORT_NONE && f->fscr_bit_nr != -1) {
+			CPUFT_WARN("unwanted fscr_bit_nr\n", uname);
+			return 0;
+		}
+
+		if (f->os_support == OS_SUPPORT_FSCR) {
+			if (f->fscr_bit_nr == -1) {
+				CPUFT_WARN("missing fscr_bit_nr\n", uname);
+				return 0;
+			}
+		}
+	} else {
+		if (f->os_support != OS_SUPPORT_NONE || f->fscr_bit_nr != -1) {
+			CPUFT_WARN("unwanted os_support/fscr_bit_nr\n", uname);
+			return 0;
+		}
+	}
+
+	if (!(f->usable_privilege & USABLE_PR)) {
+		if (f->hwcap_bit_nr != -1) {
+			CPUFT_WARN("unwanted hwcap_bit_nr\n", uname);
+			return 0;
+		}
+	}
+
+	/* Do all the independent features in the first pass */
+	if (!of_get_flat_dt_prop(node, "dependencies", &len)) {
+		if (cpufeatures_process_feature(f))
+			f->enabled = 1;
+		else
+			f->disabled = 1;
+	}
+
+	return 0;
+}
+
+static void __init cpufeatures_deps_enable(struct dt_cpu_feature *f)
+{
+	const __be32 *prop;
+	int len;
+	int nr_deps;
+	int i;
+
+	if (f->enabled || f->disabled)
+		return;
+
+	prop = of_get_flat_dt_prop(f->node, "dependencies", &len);
+	if (!prop) {
+		CPUFT_WARN("missing dependencies property", f->name);
+		return;
+	}
+
+	nr_deps = len / sizeof(int);
+
+	for (i = 0; i < nr_deps; i++) {
+		unsigned long phandle = be32_to_cpu(prop[i]);
+		int j;
+
+		for (j = 0; j < nr_dt_cpu_features; j++) {
+			struct dt_cpu_feature *d = &dt_cpu_features[j];
+
+			if (of_get_flat_dt_phandle(d->node) == phandle) {
+				cpufeatures_deps_enable(d);
+				if (d->disabled) {
+					f->disabled = 1;
+					return;
+				}
+			}
+		}
+	}
+
+	if (cpufeatures_process_feature(f))
+		f->enabled = 1;
+	else
+		f->disabled = 1;
+}
+
+static int __init scan_cpufeatures_subnodes(unsigned long node,
+					  const char *uname,
+					  void *data)
+{
+	int *count = data;
+
+	process_cpufeatures_node(node, uname, *count);
+
+	(*count)++;
+
+	return 0;
+}
+
+static int __init count_cpufeatures_subnodes(unsigned long node,
+					  const char *uname,
+					  void *data)
+{
+	int *count = data;
+
+	(*count)++;
+
+	return 0;
+}
+
+static int __init early_init_dt_scan_cpufeatures(unsigned long node,
+					  const char *uname, int depth,
+					  void *data)
+{
+	const char *compat = of_get_flat_dt_prop(node, "compatible", NULL);
+	const __be32 *prop;
+	int count, i;
+	u32 isa;
+
+	/* We are scanning "ibm,powerpc-cpu-features" nodes only */
+	if (compat == NULL || strcmp(compat, "ibm,powerpc-cpu-features") != 0)
+		return 0;
+
+	prop = of_get_flat_dt_prop(node, "isa", NULL);
+	if (!prop) {
+		printk("ibm,powerpc-cpu-features node has missing property \"isa\"\n");
+		return 0;
+	}
+
+	isa = be32_to_cpup(prop);
+
+	has_cpufeatures_node = 1;
+
+	/* Count and allocate space for cpu features */
+	of_scan_flat_dt_subnodes(node, count_cpufeatures_subnodes,
+						&nr_dt_cpu_features);
+	dt_cpu_features = __va(
+		memblock_alloc(sizeof(struct dt_cpu_feature)*
+				nr_dt_cpu_features, PAGE_SIZE));
+
+	cpufeatures_setup_start(isa);
+
+	/* Scan nodes into dt_cpu_features and enable those without deps  */
+	count = 0;
+	of_scan_flat_dt_subnodes(node, scan_cpufeatures_subnodes, &count);
+
+	/* Recursive enable remaining features with dependencies */
+	for (i = 0; i < nr_dt_cpu_features; i++) {
+		struct dt_cpu_feature *f = &dt_cpu_features[i];
+
+		cpufeatures_deps_enable(f);
+	}
+
+	cpufeatures_setup_finished();
+
+	memblock_free(__pa(dt_cpu_features),
+			sizeof(struct dt_cpu_feature)*nr_dt_cpu_features);
+
+	return 0;
+}
+
+static int __init early_init_dt_scan_cpufeatures_exists(unsigned long node,
+					  const char *uname, int depth,
+					  void *data)
+{
+	const char *compat = of_get_flat_dt_prop(node, "compatible", NULL);
+	int *exists = data;
+
+	/* We are scanning "ibm,powerpc-cpu-features" nodes only */
+	if (compat == NULL || strcmp(compat, "ibm,powerpc-cpu-features") != 0)
+		return 0;
+
+	*exists = 1;
+
+	return 0;
+}
+
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
+#endif /* CONFIG_PPC_CPUFEATURES_DT */
+
 static int __init early_init_dt_scan_cpus(unsigned long node,
 					  const char *uname, int depth,
 					  void *data)
@@ -375,23 +649,61 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 	 * A POWER6 partition in "POWER6 architected" mode
 	 * uses the 0x0f000002 PVR value; in POWER5+ mode
 	 * it uses 0x0f000001.
+	 *
+	 * In the case of the cpufeatures node existing, it is the
+	 * responsibility of the firmware/hypervisor to provide the
+	 * correct feature set for the architecture level.
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
+		check_cpu_feature_properties(node);
+		check_cpu_pa_features(node);
 
-	check_cpu_feature_properties(node);
-	check_cpu_pa_features(node);
-	init_mmu_slb_size(node);
+#ifdef CONFIG_PPC64
+		if (nthreads > 1)
+			cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
+		else
+			cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
+#endif
+	} else {
+		unsigned int pvr;
+
+		/*
+		 * Fill cpu_name with PVR table if it exists, for backward
+		 * compatibility.
+		 */
+		pvr = cur_cpu_spec->pvr_value;
+		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
+		if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000)
+			pvr = be32_to_cpup(prop);
+		identify_cpu_name(pvr);
+
+		/* Otherwise use cpu node dt */
+		if (!cur_cpu_spec->cpu_name) {
+			static char cpu_name[32];
+			char *c;
+
+			/* Get cpu_name from device-tree cpu node */
+			strncpy(cpu_name, uname, 32);
+			c = strchr(cpu_name, '@');
+			if (c)
+				*c = '\0';
+			cur_cpu_spec->cpu_name = cpu_name;
+		}
 
 #ifdef CONFIG_PPC64
-	if (nthreads > 1)
-		cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
-	else
-		cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
+		if (nthreads == 1)
+			cur_cpu_spec->cpu_features &= ~CPU_FTR_SMT;
 #endif
+	}
+
+
+	init_mmu_slb_size(node);
+
 	return 0;
 }
 
@@ -721,6 +1033,10 @@ void __init early_init_devtree(void *params)
 
 	DBG("Scanning CPUs ...\n");
 
+#ifdef CONFIG_PPC_CPUFEATURES_DT
+	of_scan_flat_dt(early_init_dt_scan_cpufeatures, NULL);
+#endif
+
 	/* Retrieve CPU related informations from the flat tree
 	 * (altivec support, boot CPU ID, ...)
 	 */
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 5c10b5925ac2..b57df7fc9e5f 100644
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
index 0d4dcaeaafcb..fd4426b84230 100644
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
@@ -274,8 +275,17 @@ void __init early_setup(unsigned long dt_ptr)
 
 	/* -------- printk is _NOT_ safe to use here ! ------- */
 
-	/* Identify CPU type */
+#ifdef CONFIG_PPC_CPUFEATURES_DT
+	/* Setup flat device-tree pointer */
+	initial_boot_params = __va(dt_ptr);
+	if (early_init_devtree_check_cpu_features_exists())
+		cpufeatures_setup_cpu();
+	else
+		/* Legacy table-based approach when /cpus/features is missing */
+		identify_cpu(0, mfspr(SPRN_PVR));
+#else
 	identify_cpu(0, mfspr(SPRN_PVR));
+#endif
 
 	/* Assume we're on cpu 0 for now. Don't write to the paca yet! */
 	initialise_paca(&boot_paca, 0);
@@ -541,6 +551,9 @@ void __init initialize_cache_info(void)
 	dcache_bsize = ppc64_caches.l1d.block_size;
 	icache_bsize = ppc64_caches.l1i.block_size;
 
+	cur_cpu_spec->dcache_bsize = dcache_bsize;
+	cur_cpu_spec->icache_bsize = icache_bsize;
+
 	DBG(" <- initialize_cache_info()\n");
 }
 
-- 
2.11.0
