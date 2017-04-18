Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	skiboot@lists.ozlabs.org
Subject: [PATCH][OPAL] cpu-features: add base and POWER8, POWER9 /cpus/ibm,
 powerpc-cpu-features dt
Date: Wed, 19 Apr 2017 05:12:20 +1000
Message-Id: <20170418191220.3166-6-npiggin@gmail.com>
In-Reply-To: <20170418191220.3166-1-npiggin@gmail.com>
References: <20170418191220.3166-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since last time:
- Added binding specification and design overview documentation.
- Renamed the dt node to ibm,powerpc specific.
- Moved dependency building pass into its own function.

---
 core/Makefile.inc                                  |   2 +-
 core/cpufeatures.c                                 | 896 +++++++++++++++++++++
 core/device.c                                      |   7 +
 core/init.c                                        |   1 +
 .../ibm,powerpc-cpu-features/binding.txt           | 226 ++++++
 .../ibm,powerpc-cpu-features/design.txt            | 157 ++++
 include/device.h                                   |   1 +
 include/skiboot.h                                  |   5 +
 8 files changed, 1294 insertions(+), 1 deletion(-)
 create mode 100644 core/cpufeatures.c
 create mode 100644 doc/device-tree/ibm,powerpc-cpu-features/binding.txt
 create mode 100644 doc/device-tree/ibm,powerpc-cpu-features/design.txt

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
index 00000000..1acedc1d
--- /dev/null
+++ b/core/cpufeatures.c
@@ -0,0 +1,896 @@
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
+#ifdef DEBUG
+#define DBG(fmt, a...)	prlog(PR_DEBUG, "CPUFT: " fmt, ##a)
+#else
+#define DBG(fmt, a...)
+#endif
+
+/* Device-tree visible constants follow */
+#define ISA_V2_07B	2070
+#define ISA_V3_0B	3000
+
+#define USABLE_PR		(1U << 0)
+#define USABLE_OS		(1U << 1)
+#define USABLE_HV		(1U << 2)
+
+#define HV_SUPPORT_HFSCR	(1U << 0)
+#define OS_SUPPORT_FSCR		(1U << 0)
+
+/* Following are definitions for the match tables, not the DT binding itself */
+#define ISA_BASE	0
+
+#define HV_NONE		0
+#define HV_CUSTOM	1
+#define HV_HFSCR	2
+
+#define OS_NONE		0
+#define OS_CUSTOM	1
+#define OS_FSCR		2
+
+/* CPU bitmasks for match table */
+#define CPU_P8_DD1	(1U << 0)
+#define CPU_P8_DD2	(1U << 1)
+#define CPU_P9_DD1	(1U << 2)
+#define CPU_P9_DD2	(1U << 3)
+
+#define CPU_P8		(CPU_P8_DD1|CPU_P8_DD2)
+#define CPU_P9		(CPU_P9_DD1|CPU_P9_DD2)
+#define CPU_ALL		(CPU_P8|CPU_P9)
+
+struct cpu_feature {
+	const char *name;
+	uint32_t cpus_supported;
+	uint32_t isa;
+	uint32_t usable_privilege;
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
+ * when no child nodes of the /cpus/ibm,powerpc-cpu-features node exist. The
+ * base feature set is POWER8 (ISAv2.07B), less features that are listed
+ * explicitly.
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
+	HV_CUSTOM, OS_CUSTOM,
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
+	HV_CUSTOM, OS_CUSTOM,
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
+	HV_CUSTOM, OS_NONE,
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
+	 * is not a dependency there. There will always be *some* interrupt
+	 * handler, (and some way to provide memory magagement, etc.).
+	 */
+	{ "interrupt-facilities",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	{ "smt",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
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
+	HV_NONE, OS_NONE,
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
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B SAO storage control attribute
+	 */
+	{ "strong-access-ordering",
+	CPU_ALL & ~CPU_P9_DD1,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B no-execute storage control attribute
+	 */
+	{ "no-execute",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * Cache inhibited attribute supported on large pages.
+	 */
+	{ "cache-inhibited-large-page",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
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
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B CFAR
+	 */
+	{ "come-from-address-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	"debug-facilities", },
+
+	/*
+	 * ISAv2.07B Branch tracing (optional in ISA)
+	 */
+	{ "branch-tracing",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	"debug-facilities", },
+
+	/*
+	 * ISAv2.07B Floating-point Facility
+	 */
+	{ "floating-point",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
+	PPC_BITLSHIFT(63), -1, 27,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Vector Facility (VMX)
+	 */
+	{ "vector",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
+	PPC_BITLSHIFT(62), -1, 28,
+	"floating-point", },
+
+	/*
+	 * ISAv2.07B Vector-scalar Facility (VSX)
+	 */
+	{ "vector-scalar",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, 7,
+	"vector", },
+
+	{ "vector-crypto",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
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
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Decimal floating-point Facility (DFP)
+	 */
+	{ "decimal-floating-point",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
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
+	HV_CUSTOM, OS_CUSTOM,
+	PPC_BITLSHIFT(61), PPC_BITLSHIFT(61), 61,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Branch History Rolling Buffer (BHRB)
+	 */
+	{ "branch-history-rolling-buffer",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
+	PPC_BITLSHIFT(59), -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Transactional Memory Facility (TM or HTM)
+	 */
+	{ "transactional-memory",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
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
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"transactional-memory", },
+
+	/*
+	 * ISAv2.07B Event-Based Branch Facility (EBB)
+	 */
+	{ "event-based-branch",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
+	PPC_BITLSHIFT(56), PPC_BITLSHIFT(56), 60,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Target Address Register (TAR)
+	 */
+	{ "target-address-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_CUSTOM, OS_CUSTOM,
+	PPC_BITLSHIFT(55), PPC_BITLSHIFT(55), 58,
+	NULL, },
+
+	/*
+	 * ISAv2.07B Control Register (CTRL)
+	 */
+	{ "control-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
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
+	CPU_P8_DD2, /* P8 DD1 has no dbell */
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B PURR, SPURR registers
+	 */
+	{ "processor-utilization-of-resources-register",
+	CPU_ALL,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER8 initiate coprocessor store word indexed (icswx) instruction
+	 */
+	{ "coprocessor-icswx",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B hash based MMU and all instructions, registers,
+	 * data structures, exceptions, etc.
+	 */
+	{ "mmu-hash",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER8 MCE / machine check exception.
+	 */
+	{ "machine-check-power8",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER8 PMU / performance monitor unit.
+	 */
+	{ "performance-monitor-power8",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
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
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B / POWER8 doze, nap, sleep, winkle instructions
+	 * XXX: is Linux we using some BookIV specific implementation details
+	 * in nap handling? We have no POWER8 specific key here.
+	 */
+	{ "idle-nap",
+	CPU_P8,
+	ISA_BASE, USABLE_HV,
+	HV_CUSTOM, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv2.07B wait instruction
+	 */
+	{ "wait",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "subcore",
+	CPU_P8,
+	ISA_BASE, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	"smt", },
+
+	/*
+	 * ISAv3.0B radix based MMU
+	 */
+	{ "mmu-radix",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B hash based MMU, new hash pte format, PCTR, etc
+	 */
+	{ "mmu-hash-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B wait instruction
+	 */
+	{ "wait-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B stop idle instructions and registers
+	 * XXX: Same question as for idle-nap
+	 */
+	{ "idle-stop",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B Hypervisor Virtualization Interrupt
+	 * Also associated system registers, LPCR EE, HEIC, HVICE,
+	 * system reset SRR1 reason, etc.
+	 */
+	{ "hypervisor-virtualization-interrupt",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV,
+	HV_CUSTOM, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER9 MCE / machine check exception.
+	 */
+	{ "machine-check-power9",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * POWER9 PMU / performance monitor unit.
+	 */
+	{ "performance-monitor-power9",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_CUSTOM,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B scv/rfscv system call instructions and exceptions, fscr bit
+	 * etc.
+	 */
+	{ "system-call-vectored",
+	CPU_P9,
+	ISA_V3_0B, USABLE_OS|USABLE_PR,
+	HV_NONE, OS_CUSTOM,
+	-1, PPC_BITLSHIFT(51), -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B Book3S Chapter 10. Processor Control.
+	 * global msgsnd, msgsndp, msgsync, doorbell, etc.
+	 */
+	{ "processor-control-facility-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_CUSTOM, OS_NONE,
+	PPC_BITLSHIFT(53), -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B addpcis instruction
+	 */
+	{ "pc-relative-addressing",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
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
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B Book3S Chapter 7. Timer Facilities
+	 * Large decrementer and hypervisor decrementer
+	 */
+	{ "timer-facilities-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"timer-facilities", },
+
+	/*
+	 * ISAv3.0B deliver a random number instruction (darn)
+	 */
+	{ "random-number-generator",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B fixed point instructions
+	 * multiply-add, modulo, count trailing zeroes, cmprb, cmpeqb,
+	 * extswsli, mfvsrld, mtvsrdd, mtvsrws, addex
+	 */
+	{ "fixed-point-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	{ "decimal-integer-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"fixed-point-v3 decimal-integer", },
+
+	/*
+	 * ISAv3.0B lightweight mffs
+	 */
+	{ "floating-point-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"floating-point", },
+
+	{ "decimal-floating-point-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"floating-point-v3 decimal-floating-point", },
+
+	{ "vector-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"vector", },
+
+	{ "vector-scalar-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"vector-v3 vector-scalar" },
+
+	{ "vector-binary128",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, 54,
+	"vector-scalar-v3", },
+
+	{ "vector-binary16",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"vector-v3", },
+
+	/*
+	 * ISAv3.0B branch instruction and register additions
+	 * CA32, OV32, mcrxrx, setb
+	 */
+	{ "branch-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B external exception for EBB
+	 */
+	{ "event-based-branch-v3",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	"event-based-branch", },
+
+	/*
+	 * ISAv3.0B Atomic Memory Operations (AMO)
+	 */
+	{ "atomic-memory-operations",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
+	-1, -1, -1,
+	NULL, },
+
+	/*
+	 * ISAv3.0B Copy-Paste Facility
+	 */
+	{ "copy-paste",
+	CPU_P9,
+	ISA_V3_0B, USABLE_HV|USABLE_OS|USABLE_PR,
+	HV_NONE, OS_NONE,
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
+	HV_NONE, OS_NONE,
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
+	dt_add_property_cells(feature, "usable-privilege", f->usable_privilege);
+
+	if (f->usable_privilege & USABLE_HV) {
+		if (f->hv_support != HV_NONE) {
+			uint32_t s = 0;
+			if (f->hv_support == HV_HFSCR)
+				s |= HV_SUPPORT_HFSCR;
+
+			dt_add_property_cells(feature, "hv-support", s);
+			if (f->hfscr_bit_nr != -1)
+				dt_add_property_cells(feature, "hfscr-bit-nr", f->hfscr_bit_nr);
+		} else {
+			assert(f->hfscr_bit_nr == -1);
+		}
+	}
+
+	if (f->usable_privilege & USABLE_OS) {
+		if (f->os_support != OS_NONE) {
+			uint32_t s = 0;
+			if (f->os_support == OS_FSCR)
+				s |= OS_SUPPORT_FSCR;
+			dt_add_property_cells(feature, "os-support", s);
+			if (f->fscr_bit_nr != -1)
+				dt_add_property_cells(feature, "fscr-bit-nr", f->fscr_bit_nr);
+		} else {
+			assert(f->fscr_bit_nr == -1);
+		}
+	}
+
+	if (f->usable_privilege & USABLE_PR) {
+		if (f->hwcap_bit_nr != -1)
+			dt_add_property_cells(feature, "hwcap-bit-nr", f->hwcap_bit_nr);
+	}
+
+	if (f->dependencies_names)
+		dt_add_property(feature, "dependencies", NULL, 0);
+}
+
+static void add_cpufeatures_dependencies(struct dt_node *features)
+{
+	struct dt_node *feature;
+
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
+static void add_cpufeatures(struct dt_node *cpus,
+		uint32_t cpu_feature_isa, uint32_t cpu_feature_cpu)
+{
+	struct dt_node *features;
+	int i;
+
+	DBG("creating cpufeatures for cpu:%d isa:%d\n", cpu_feature_cpu, cpu_feature_isa);
+
+	features = dt_new(cpus, "features");
+	assert(features);
+
+	dt_add_property_cells(features, "isa", cpu_feature_isa);
+
+	dt_add_property_string(features, "device_type", "ibm,powerpc-cpu-features");
+
+	/* add without dependencies */
+	for (i = 0; i < ARRAY_SIZE(cpu_features_table); i++) {
+		const struct cpu_feature *f = &cpu_features_table[i];
+
+		if (f->cpus_supported & cpu_feature_cpu) {
+			DBG("  '%s'\n", f->name);
+			add_cpu_feature_nodeps(features, f);
+		}
+	}
+
+	/* dependency construction pass */
+	add_cpufeatures_dependencies(features);
+}
+
+void dt_add_cpufeatures(struct dt_node *root)
+{
+	int version;
+	uint32_t cpu_feature_isa = 0;
+	uint32_t cpu_feature_cpu = 0;
+	struct dt_node *cpus;
+
+	version = mfspr(SPR_PVR);
+	switch(PVR_TYPE(version)) {
+	case PVR_TYPE_P8:
+	case PVR_TYPE_P8E:
+	case PVR_TYPE_P8NVL:
+		cpu_feature_isa = ISA_V2_07B;
+		if (PVR_VERS_MAJ(version) == 1)
+			cpu_feature_cpu = CPU_P8_DD1;
+		else
+			cpu_feature_cpu = CPU_P8_DD2;
+		break;
+	case PVR_TYPE_P9:
+		cpu_feature_isa = ISA_V3_0B;
+		if (PVR_VERS_MAJ(version) == 1)
+			cpu_feature_cpu = CPU_P9_DD1;
+		else
+			cpu_feature_cpu = CPU_P9_DD2;
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
diff --git a/doc/device-tree/ibm,powerpc-cpu-features/binding.txt b/doc/device-tree/ibm,powerpc-cpu-features/binding.txt
new file mode 100644
index 00000000..a5270484
--- /dev/null
+++ b/doc/device-tree/ibm,powerpc-cpu-features/binding.txt
@@ -0,0 +1,226 @@
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
+The node name must be "ibm,powerpc-cpu-features" and it must be a child of the
+node "/cpus".
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
diff --git a/doc/device-tree/ibm,powerpc-cpu-features/design.txt b/doc/device-tree/ibm,powerpc-cpu-features/design.txt
new file mode 100644
index 00000000..490e80c5
--- /dev/null
+++ b/doc/device-tree/ibm,powerpc-cpu-features/design.txt
@@ -0,0 +1,157 @@
+ibm,powerpc-cpu-features binding
+================================
+
+The OPAL / skiboot code is the canonical location for this specification.  All
+definitions of features, constant, bit positions, etc. must be documented here
+before being deployed in Linux. This is not presently part of LoPAPR.
+
+
+Interfaces
+----------
+This specification describes the /cpus/ibm,powerpc-cpu-features binding (the
+formal definition of binding can be found in binding.txt in this directory).
+
+This specification also involves the Linux ELF AUXV AT_HWCAP and AT_HWCAP2
+interfaces for PPC_FEATURE* bits. Allocation of new AT_HWCAP bits should be
+done in coordination with OPAL / skiboot, Linux, and glibc projects.
+
+The binding is passed to the hypervisor by firmware. The hypervisor may
+build a subset with unsupported/disabled features and hypervisor specifics
+removed, and pass that to a guest OS. The OS may advertise features to
+userspace.
+
+
+Background
+----------
+The cpu-features binding (subsequently "cpu-features") aims to provide an
+extensible metadata and protocol between different levels of system software
+(firmware, hypervisor, OS/guest, userspace) to advertise the CPU features
+available on the system. With each level able to shape the features available
+to the next.
+
+The binding specifies features common to all CPUs in the system. Heterogeneous
+CPU features are not supported at present (such could be added by providing
+additional cpu-features nodes and linking those to particular CPUs with
+additional features).
+
+There is no strict definition for what a CPU feature must be, but an
+architectural behaviour or performance characteristic (or group of related
+behaviours). They must be documented in skiboot/core/cpufeatures.c sufficiently
+precisely. More guidelines for feature definitions below.
+
+cpu-features is intended to provide fine grained control of CPU features at
+all levels of the stack (firmware, hypervisor, OS, userspace), with the
+ability for new CPU features to be used by some components without all
+components being upgraded (e.g., a new floating point instruction could be
+used by userspace math library without upgrading kernel and hypervisor).
+
+
+Overview
+--------
+
+The cpu-features node is created by firmware and passed to the hypervisor.
+The hypervisor may create cpu-features node to be passed to guest, based on
+the features that have been enabled, and policy decisions. Hypervisor specific
+features, and hypervisor bits and properties should not be advertised to
+guests. Guest OS may advertise features to userspace using another method
+(e.g., using AUXV vectors, userspace typically does not parse DT).
+
+When the cpu-features node is present, ibm,pa-features and individual feature
+properties (e.g., "ibm,vsx"), and cpu-version under the "cpu" compatible nodes
+can be ignored by the consumer. For compatibility, the provider must continue
+to provide those older properties and the consumer must not assume cpu-features
+exists.
+
+When this node exists, software may assume a base feature set which is ISA
+v2.07B (BookS) minus the explicit features listed in core/cpufeatures.c
+entries in this source tree.
+
+Each feature is advertised as a node underneath the cpu-features node, named
+with a human-readable string name that uniquely identifies specification of
+that capability.
+
+A feature node has a number of metadata properties describing privilege levels
+a feature may be used (HV, OS, PR/user), and information about how it is to
+be enabled and advertised to lesser privilege levels. Enabling means to make
+it available at a lesser privilege level, (how to enable a given feature
+for this privilege level is implicit: if the software know how to use a
+feature, it also knows how to enable it).
+
+Feature node properties:
+
+- "isa", the Power ISA version where this feature first became available.
+  In case of an implementation specific feature
+
+- "usable-privilege", a bitmask (HV, OS, PR/user) specifying which privilege
+  levels this feature may be used in.
+
+- "hv-support", a bitmask. If this exists, the hypervisor must do some work
+  to enable support for lesser privilege levels. Bits can be set in this mask
+  to specify prescription/recipes to enable the feature without custom code.
+  If no bits are set, no recipe exists and custom code must be used. HFSCR
+  register enable bit is the only such recipe currently.
+
+- "os-support", similar to hv-support. FSCR recipe.
+
+- Features may have additional properties associated, must be documented with
+  the feature.
+
+- Recipes may have additional properties associated. HFSCR recipe has
+  hfscr-bit-nr, and FSCR recipe has fscr-bit-nr.
+
+- "dependencies" array of phandles. If this exists, it links to the
+  features that must be enabled in order for this feature to be enabled.
+
+- "hwcap-bit-nr" if it exists provides a Linux ELF AUXV HWCAP bit number that
+  can be used to advertise this feature to userspace.
+
+Together, these compatibility, support, and dependencies properties allow
+unknown features to be enabled and advertised to lesser privilege levels
+(when possible).
+
+All bits not defined in usable, support masks must be 0, and should be ignored
+by consumers. This allows extensibility to add new privilege levels and new
+recipes. Unknown properties should also be ignored. This allows extensibility
+for additional methods and metadata for enablement and advertisement.
+
+The policy for seleting and configuring which features to advertise and use
+is left for implementations.
+
+
+Guidelines for defining features
+--------------------------------
+
+As a rough guide, features should be based on functional groups of changes
+to the ISA, or related performance characteristics.
+
+Grouping should be made by one or a combination of those that:
+- Share common enablement requirements (e.g., share particular registers or
+  firmware setup requirements).
+- Share common usage patterns (e..g, likely to be used together).
+- Are implemented with a particular new hardware unit.
+- Are optional in the ISA.
+
+Granularity can be debated, but fine grained and encompassing is generally
+preferable. For example, memory management unit may be considered fundamental,
+but the MMU in POWER9 is very different and in many ways incompatible from
+that in POWER8 even in hash mode.
+
+For example, "POWER9" would be too general, but a new feature for every
+instruction would be too specific. The "summary of changes" preface in Power
+ISA specification is a good starting point to give a guideline for granularity
+of the architected features.
+
+New features that offer additional or incompatible functionality beyond
+an existing feature may contain an ISA version postfix.
+
+Implementation specific behaviour should contain a CPU type postfix. E.g.,
+"machine-check-power9" gives exact MCE properties. If a future CPU has the same
+MCE architecture, it should define the same property. If it has a
+backward-compatible superset, it could additionally define
+"machine-check-newcpu".
+
+Features should be "positive" as much as possible. That is, the presence of
+a feature should indicate the presence of an additional CPU feature (e.g., a
+new instruction or register). This requires some anticipation and foresight
+for defining CPU features. "Negative" features may be unavoidable in some
+cases.
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
index 2b1f8a57..764ce8d2 100644
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
