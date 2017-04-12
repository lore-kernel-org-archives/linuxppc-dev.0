Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3BHc5xZczDq9K
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 03:49:00 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id g2so6710821pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:49:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH][OPAL] cpufeatures: add base and POWER8,
 POWER9 /cpus/features dt
Date: Thu, 13 Apr 2017 03:48:33 +1000
Message-Id: <20170412174833.5924-5-npiggin@gmail.com>
In-Reply-To: <20170412174833.5924-1-npiggin@gmail.com>
References: <20170412174833.5924-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is the skiboot patch included here if anyone wants to test or review.
I've put more of the feature documentation into this patch, so I haven't
duplicated it on the Linux side -- firmware will be canonical definition.

---
 core/Makefile.inc  |   2 +-
 core/cpufeatures.c | 888 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 core/device.c      |   7 +
 core/init.c        |   1 +
 include/device.h   |   1 +
 include/skiboot.h  |   5 +
 6 files changed, 903 insertions(+), 1 deletion(-)
 create mode 100644 core/cpufeatures.c

diff --git a/core/Makefile.inc b/core/Makefile.inc
index b09c30c0..7c247836 100644
--- a/core/Makefile.inc
+++ b/core/Makefile.inc
@@ -8,7 +8,7 @@ CORE_OBJS += pci-opal.o fast-reboot.o device.o exceptions.o trace.o affinity.o
 CORE_OBJS += vpd.o hostservices.o platform.o nvram.o nvram-format.o hmi.o
 CORE_OBJS += console-log.o ipmi.o time-utils.o pel.o pool.o errorlog.o
 CORE_OBJS += timer.o i2c.o rtc.o flash.o sensor.o ipmi-opal.o
-CORE_OBJS += flash-subpartition.o bitmap.o buddy.o pci-quirk.o
+CORE_OBJS += flash-subpartition.o bitmap.o buddy.o pci-quirk.o cpufeatures.o
 
 ifeq ($(SKIBOOT_GCOV),1)
 CORE_OBJS += gcov-profiling.o
diff --git a/core/cpufeatures.c b/core/cpufeatures.c
new file mode 100644
index 00000000..d717e4d7
--- /dev/null
+++ b/core/cpufeatures.c
@@ -0,0 +1,888 @@
+/* Copyright 2017 IBM Corp.
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ * 	http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
+ * implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+
+/*
+ * This file deals with setting up the /cpus/features device tree
+ * by discovering CPU hardware and populating feature nodes.
+ */
+
+#include <skiboot.h>
+#include <cpu.h>
+#include <ccan/str/str.h>
+#include <device.h>
+
+#define DEBUG 1
+#ifdef DEBUG
+#define DBG(fmt, a...)	prlog(PR_DEBUG, "CPUFT: " fmt, ##a)
+#else
+#define DBG(fmt, a...)
+#endif
+
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
+/* CPU variant numbers */
+#define CPUFEATURES_CPU_P8_DD1	1 /* leave 0 unused */
+#define CPUFEATURES_CPU_P8_DD2	2
+#define CPUFEATURES_CPU_P9_DD1	3
+#define CPUFEATURES_CPU_P9_DD2	4
+
+/* Bitmasks for the match table */
+#define P8_DD1		(1U << CPUFEATURES_CPU_P8_DD1)
+#define P8_DD2		(1U << CPUFEATURES_CPU_P8_DD2)
+#define P9_DD1		(1U << CPUFEATURES_CPU_P9_DD1)
+#define P9_DD2		(1U << CPUFEATURES_CPU_P9_DD2)
+
+#define P8			(P8_DD1|P8_DD2)
+#define P9			(P9_DD1|P9_DD2)
+#define CPU_ALL			(P8|P9)
+
+#define CPUFEATURES_ISA_V2_07B	2070
+#define CPUFEATURES_ISA_V3_0B	3000
+
+#define ISA_BASE		0
+#define ISA_V3_0B		CPUFEATURES_ISA_V3_0B
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
+ * set is POWER8 (ISAv2.07B), less features that are listed explicitly.
+ *
+ * There will be a /cpus/features/isa property that specifies the currently
+ * active ISA level. Those architected features without explicit nodes
+ * will match the current ISA level. A greater ISA level will imply some
+ * features are phased out.
+ *
+ * XXX: currently, the feature dependencies are not necessarily captured
+ * exactly or completely. This is somewhat acceptable because all
+ * implementations must be aware of all these features.
+ */
+static const struct cpu_feature cpu_features_table[] = {
+	/*
+	 * Big endian as in ISAv2.07B, MSR_LE=0
+	 */
+	{ "big-endian",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * Little endian as in ISAv2.07B, MSR_LE=1.
+	 *
+	 * When both big and little endian are defined, there is an LPCR ILE
+	 * bit and implementation specific way to switch HILE mode, MSR_SLE,
+	 * etc.
+	 */
+	{ "little-endian",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * MSR_HV=1 mode as in ISAv2.07B (i.e., hypervisor privileged
+	 * instructions and registers).
+	 */
+	{ "hypervisor",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B interrupt vectors, registers, and control registers
+	 * (e.g., AIL, ILE, HV, etc LPCR bits).
+	 *
+	 * This does not necessarily specify all possible interrupt types.
+	 * floating-point, for example requires some ways to handle floating
+	 * point exceptions, but the low level details of interrupt handler
+	 * is not a dependency there.
+	 */
+	{ "interrupt-facilities",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "smt",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, 14,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Program Priority Registers (PPR)
+	 * PPR and associated control registers (e.g. RPR, PSPB),
+	 * priority "or" instructions, etc.
+	 */
+	{ "program-priority-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Book3S Chapter 5.7.9.1. Virtual Page Class Key Protecion
+	 * AMR, IAMR, AMOR, UAMOR, etc registers and MMU key bits.
+	 */
+	{ "virtual-page-class-key-protection",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B SAO storage control attribute
+	 */
+	{ "strong-access-ordering",
+	CPU_ALL & ~P9_DD1,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B no-execute storage control attribute
+	 */
+	{ "no-execute",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * Cache inhibited attribute supported on large pages.
+	 */
+	{ "cache-inhibited-large-page",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Book3S Chapter 8. Debug Facilities
+	 * CIEA, CIABR, DEAW, MEte, trace interrupt, etc.
+	 * Except CFAR, branch tracing.
+	 */
+	{ "debug-facilities",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B CFAR
+	 */
+	{ "come-from-address-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	"debug-facilities", },
+
+	/*
+	 * ISAv2.07B Branch tracing (optional in ISA)
+	 */
+	{ "branch-tracing",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	"debug-facilities", },
+
+	/*
+	 * ISAv2.07B Floating-point Facility
+	 */
+	{ "floating-point",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	PPC_BITLSHIFT(63), -1, 27,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Vector Facility (VMX)
+	 */
+	{ "vector",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	PPC_BITLSHIFT(62), -1, 28,
+	"floating-point", },
+
+	/*
+	 * ISAv2.07B Vector-scalar Facility (VSX)
+	 */
+	{ "vector-scalar",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, 7,
+	"vector", },
+
+	{ "vector-crypto",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, 57,
+	"vector", },
+
+	/*
+	 * ISAv2.07B Binary Coded Decimal (BCD)
+	 * BCD fixed point instructions
+	 */
+	{ "decimal-integer",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Decimal floating-point Facility (DFP)
+	 */
+	{ "decimal-floating-point",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, 10,
+	"floating-point", },
+
+	/*
+	 * ISAv2.07B
+	 * DSCR, default data prefetch LPCR, etc
+	 */
+	{ "data-stream-control-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	PPC_BITLSHIFT(61), PPC_BITLSHIFT(61), 61,
+	NULL, },
+
+	/* BHRB */
+	{ "branch-history-rolling-buffer",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	PPC_BITLSHIFT(59), -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Transactional Memory Facility (TM or HTM)
+	 */
+	{ "transactional-memory",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	PPC_BITLSHIFT(58), -1, 62,
+	NULL, },
+
+	/*
+	 * ISAv3.0B TM additions
+	 * TEXASR bit 17, self-induced vs external footprint overflow
+	 */
+	{ "transactional-memory-v3",
+	CPU_ALL,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"transactional-memory", },
+
+	/*
+	 * ISAv2.07B Event-Based Branch Facility (EBB)
+	 */
+	{ "event-based-branch",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	PPC_BITLSHIFT(56), PPC_BITLSHIFT(56), 60,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Target Address Register (TAR)
+	 */
+	{ "target-address-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	PPC_BITLSHIFT(55), PPC_BITLSHIFT(55), 58,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Control Register (CTRL)
+	 */
+	{ "control-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Book3S Chapter 11. Processor Control.
+	 * msgsnd, msgsndp, doorbell, etc.
+	 *
+	 * ISAv3.0B is not compatible (different addressing, HFSCR required
+	 * for msgsndp).
+	 */
+	{ "processor-control-facility",
+	P8_DD2, /* P8 DD1 has no dbell */
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B PURR, SPURR registers
+	 */
+	{ "processor-utilization-of-resources-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER8 initiate coprocessor store word indexed (icswx) instruction
+	 */
+	{ "coprocessor-icswx",
+	P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B hash based MMU and all instructions, registers,
+	 * data structures, exceptions, etc.
+	 */
+	{ "mmu-hash",
+	P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER8 MCE / machine check exception.
+	 */
+	{ "machine-check-power8",
+	P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER8 PMU / performance monitor unit.
+	 */
+	{ "performance-monitor-power8",
+	P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B alignment interrupts set DSISR register
+	 *
+	 * POWER CPUs do not used this, and it's removed from ISAv3.0B.
+	 */
+	{ "alignment-interrupt-dsisr",
+	0,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B / POWER8 doze, nap, sleep, winkle instructions
+	 * XXX: is Linux we using some BookIV specific implementation details
+	 * in nap handling? We have no POWER8 specific key here.
+	 */
+	{ "idle-nap",
+	P8,
+	ISA_BASE, USABLE_HV,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B wait instruction
+	 */
+	{ "wait",
+	P8,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "subcore",
+	P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	"smt", },
+
+	/*
+	 * ISAv3.0B radix based MMU
+	 */
+	{ "mmu-radix",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B hash based MMU, new hash pte format, PCTR, etc
+	 */
+	{ "mmu-hash-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B wait instruction
+	 */
+	{ "wait-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B stop idle instructions and registers
+	 * XXX: Same question as for idle-nap
+	 */
+	{ "idle-stop",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B Hypervisor Virtualization Interrupt
+	 * Also associated system registers, LPCR EE, HEIC, HVICE,
+	 * system reset SRR1 reason, etc.
+	 */
+	{ "hypervisor-virtualization-interrupt",
+	P9,
+	ISA_V3_0B, USABLE_HV,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER9 MCE / machine check exception.
+	 */
+	{ "machine-check-power9",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER9 PMU / performance monitor unit.
+	 */
+	{ "performance-monitor-power9",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B scv/rfscv system call instructions and exceptions, fscr bit
+	 * etc.
+	 */
+	{ "system-call-vectored",
+	P9,
+	ISA_V3_0B, USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_CUSTOM,
+	-1, PPC_BITLSHIFT(51), -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B Book3S Chapter 10. Processor Control.
+	 * global msgsnd, msgsndp, msgsync, doorbell, etc.
+	 */
+	{ "processor-control-facility-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_CUSTOM, OS_SUPPORT_NONE,
+	PPC_BITLSHIFT(53), -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B addpcis instruction
+	 */
+	{ "pc-relative-addressing",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Book3S Chapter 7. Timer Facilities
+	 * TB, VTB, DEC, HDEC, IC, etc registers and exceptions.
+	 * Not including PURR or SPURR registers.
+	 */
+	{ "timer-facilities",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B Book3S Chapter 7. Timer Facilities
+	 * Large decrementer and hypervisor decrementer
+	 */
+	{ "timer-facilities-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"timer-facilities", },
+
+	/*
+	 * ISAv3.0B deliver a random number instruction (darn)
+	 */
+	{ "random-number-generator",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B fixed point instructions
+	 * multiply-add, modulo, count trailing zeroes, cmprb, cmpeqb,
+	 * extswsli, mfvsrld, mtvsrdd, mtvsrws, addex
+	 */
+	{ "fixed-point-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "decimal-integer-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"fixed-point-v3 decimal-integer", },
+
+	/*
+	 * ISAv3.0B lightweight mffs
+	 */
+	{ "floating-point-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"floating-point", },
+
+	{ "decimal-floating-point-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"floating-point-v3 decimal-floating-point", },
+
+	{ "vector-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"vector", },
+
+	{ "vector-scalar-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"vector-v3 vector-scalar" },
+
+	{ "vector-binary128",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, 54,
+	"vector-scalar-v3", },
+
+	{ "vector-binary16",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"vector-v3", },
+
+	/*
+	 * ISAv3.0B branch instruction and register additions
+	 * CA32, OV32, mcrxrx, setb
+	 */
+	{ "branch-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B external exception for EBB
+	 */
+	{ "event-based-branch-v3",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	"event-based-branch", },
+
+	/*
+	 * ISAv3.0B Atomic Memory Operations (AMO)
+	 */
+	{ "atomic-memory-operations",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B Copy-Paste Facility
+	 */
+	{ "copy-paste",
+	P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B GSR SPR register
+	 * POWER9 does not implement it
+	 */
+	{ "group-start-register",
+	0,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_SUPPORT_NONE, OS_SUPPORT_NONE,
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
+static void add_cpufeatures(struct dt_node *cpus,
+		uint32_t cpu_feature_isa, uint32_t cpu_feature_cpu)
+{
+	struct dt_node *features;
+	struct dt_node *feature;
+	uint32_t cpu_mask = (1U << cpu_feature_cpu);
+	int i;
+
+	DBG("creating cpufeatures for cpu:%d isa:%d\n", cpu_feature_cpu, cpu_feature_isa);
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
+		if (f->cpus_supported & cpu_mask) {
+			// too verbose early DBG("  '%s'\n", f->name);
+			add_cpu_feature_nodeps(features, f);
+		}
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
+
+		DBG("feature %s has %d dependencies (%s)\n", f->name, nr_deps, deps_names);
+		/*
+		 * For each one, find the depended feature then advance to
+		 * next name.
+		 */
+		for (i = 0; i < nr_deps; i++) {
+			struct dt_node *dep;
+			int len;
+		       
+			if (nr_deps - i == 1)
+				len = strlen(deps_names);
+			else
+				len = strchr(deps_names, ' ') - deps_names;
+
+			dt_for_each_node(features, dep) {
+				if (!strncmp(deps_names, dep->name, len))
+					goto found_dep;
+			}
+
+			prlog(PR_ERR, "CPUFT: feature %s dependencies not found\n", f->name);
+			break;
+found_dep:
+			DBG(" %s found dep (%s)\n", f->name, dep->name);
+			dt_property_set_cell(deps, i, dep->phandle);
+
+			/* Advance over the name + delimiter */
+			deps_names += len + 1;
+		}
+	}
+}
+
+void dt_add_cpufeatures(struct dt_node *root)
+{
+	int version;
+	uint32_t cpu_feature_isa = 0;
+	uint32_t cpu_feature_cpu = 0;
+	struct dt_node *cpus;
+
+
+	version = mfspr(SPR_PVR);
+	switch(PVR_TYPE(version)) {
+	case PVR_TYPE_P8:
+	case PVR_TYPE_P8E:
+	case PVR_TYPE_P8NVL:
+		cpu_feature_isa = CPUFEATURES_ISA_V2_07B;
+		if (PVR_VERS_MAJ(version) == 1)
+			cpu_feature_cpu = CPUFEATURES_CPU_P8_DD1;
+		else
+			cpu_feature_cpu = CPUFEATURES_CPU_P8_DD2;
+		break;
+	case PVR_TYPE_P9:
+		cpu_feature_isa = CPUFEATURES_ISA_V3_0B;
+		if (PVR_VERS_MAJ(version) == 1)
+			cpu_feature_cpu = CPUFEATURES_CPU_P9_DD1;
+		else
+			cpu_feature_cpu = CPUFEATURES_CPU_P9_DD2;
+		break;
+	default:
+		return;
+	}
+
+	cpus = dt_new_check(root, "cpus");
+
+	add_cpufeatures(cpus, cpu_feature_isa, cpu_feature_cpu);
+}
diff --git a/core/device.c b/core/device.c
index f3ee63fb..38a420eb 100644
--- a/core/device.c
+++ b/core/device.c
@@ -598,6 +598,13 @@ u32 dt_property_get_cell(const struct dt_property *prop, u32 index)
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
index 6b8137c8..4d4bf651 100644
--- a/core/init.c
+++ b/core/init.c
@@ -790,6 +790,7 @@ void __noreturn __nomcount main_cpu_entry(const void *fdt)
 	} else {
 		dt_expand(fdt);
 	}
+	dt_add_cpufeatures(dt_root);
 
 	/* Now that we have a full devicetree, verify that we aren't on fire. */
 	per_thread_sanity_checks();
diff --git a/include/device.h b/include/device.h
index 5155daad..ca4dd0b0 100644
--- a/include/device.h
+++ b/include/device.h
@@ -125,6 +125,7 @@ void dt_check_del_prop(struct dt_node *node, const char *name);
 /* Warning: moves *prop! */
 void dt_resize_property(struct dt_property **prop, size_t len);
 
+void dt_property_set_cell(struct dt_property *prop, u32 index, u32 val);
 u32 dt_property_get_cell(const struct dt_property *prop, u32 index);
 
 /* First child of this node. */
diff --git a/include/skiboot.h b/include/skiboot.h
index 8bc767a4..eb7262d0 100644
--- a/include/skiboot.h
+++ b/include/skiboot.h
@@ -184,6 +184,11 @@ extern void start_kernel_secondary(uint64_t entry) __noreturn;
 /* Get description of machine from HDAT and create device-tree */
 extern int parse_hdat(bool is_opal);
 
+struct dt_node;
+
+/* Add /cpus/features node for boot environment that passes an fdt */
+extern void dt_add_cpufeatures(struct dt_node *root);
+
 /* Root of device tree. */
 extern struct dt_node *dt_root;
 
-- 
2.11.0
