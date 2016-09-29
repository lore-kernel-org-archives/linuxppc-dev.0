Return-Path: <BATV+f2ecf1341dfe0364f26e+4785+infradead.org+acme@merlin.srs.infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3slHFv0spLzDsjp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Sep 2016 00:36:51 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux Weekly News <lwn@lwn.net>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Matt Fleming <matt.fleming@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/27] perf tests: Add dwarf unwind test for powerpc
Date: Thu, 29 Sep 2016 11:35:56 -0300
Message-Id: <1475159756-21326-28-git-send-email-acme@kernel.org>
In-Reply-To: <1475159756-21326-1-git-send-email-acme@kernel.org>
References: <1475159756-21326-1-git-send-email-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>

The user stack dump feature was recently added for powerpc. But there
was no test case available to test it.

This test works same as on other architectures by preparing a stack
frame on the perf test thread and comparing each frame by unwinding it.

  $ ./perf test 50
    50: Test dwarf unwind    : Ok

User stack dump for powerpc: https://lkml.org/lkml/2016/4/28/482

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Matt Fleming <matt.fleming@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/1474267100-31079-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/Build                |  1 +
 tools/perf/arch/powerpc/include/arch-tests.h | 13 ++++
 tools/perf/arch/powerpc/include/perf_regs.h  |  2 +
 tools/perf/arch/powerpc/tests/Build          |  4 ++
 tools/perf/arch/powerpc/tests/arch-tests.c   | 15 +++++
 tools/perf/arch/powerpc/tests/dwarf-unwind.c | 62 ++++++++++++++++++
 tools/perf/arch/powerpc/tests/regs_load.S    | 94 ++++++++++++++++++++++++++++
 tools/perf/tests/Build                       |  2 +-
 tools/perf/tests/dwarf-unwind.c              |  2 +-
 9 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/arch/powerpc/include/arch-tests.h
 create mode 100644 tools/perf/arch/powerpc/tests/Build
 create mode 100644 tools/perf/arch/powerpc/tests/arch-tests.c
 create mode 100644 tools/perf/arch/powerpc/tests/dwarf-unwind.c
 create mode 100644 tools/perf/arch/powerpc/tests/regs_load.S

diff --git a/tools/perf/arch/powerpc/Build b/tools/perf/arch/powerpc/Build
index 54afe4a467e7..db52fa22d3a1 100644
--- a/tools/perf/arch/powerpc/Build
+++ b/tools/perf/arch/powerpc/Build
@@ -1 +1,2 @@
 libperf-y += util/
+libperf-y += tests/
diff --git a/tools/perf/arch/powerpc/include/arch-tests.h b/tools/perf/arch/powerpc/include/arch-tests.h
new file mode 100644
index 000000000000..84d8dedef2ed
--- /dev/null
+++ b/tools/perf/arch/powerpc/include/arch-tests.h
@@ -0,0 +1,13 @@
+#ifndef ARCH_TESTS_H
+#define ARCH_TESTS_H
+
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+struct thread;
+struct perf_sample;
+int test__arch_unwind_sample(struct perf_sample *sample,
+			     struct thread *thread);
+#endif
+
+extern struct test arch_tests[];
+
+#endif
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 75de0e92e71e..c12f4e804f66 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -5,6 +5,8 @@
 #include <linux/types.h>
 #include <asm/perf_regs.h>
 
+void perf_regs_load(u64 *regs);
+
 #define PERF_REGS_MASK  ((1ULL << PERF_REG_POWERPC_MAX) - 1)
 #define PERF_REGS_MAX   PERF_REG_POWERPC_MAX
 #ifdef __powerpc64__
diff --git a/tools/perf/arch/powerpc/tests/Build b/tools/perf/arch/powerpc/tests/Build
new file mode 100644
index 000000000000..d827ef384b33
--- /dev/null
+++ b/tools/perf/arch/powerpc/tests/Build
@@ -0,0 +1,4 @@
+libperf-$(CONFIG_DWARF_UNWIND) += regs_load.o
+libperf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
+
+libperf-y += arch-tests.o
diff --git a/tools/perf/arch/powerpc/tests/arch-tests.c b/tools/perf/arch/powerpc/tests/arch-tests.c
new file mode 100644
index 000000000000..e24f46241f40
--- /dev/null
+++ b/tools/perf/arch/powerpc/tests/arch-tests.c
@@ -0,0 +1,15 @@
+#include <string.h>
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+struct test arch_tests[] = {
+#ifdef HAVE_DWARF_UNWIND_SUPPORT
+	{
+		.desc = "Test dwarf unwind",
+		.func = test__dwarf_unwind,
+	},
+#endif
+	{
+		.func = NULL,
+	},
+};
diff --git a/tools/perf/arch/powerpc/tests/dwarf-unwind.c b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
new file mode 100644
index 000000000000..0bac3137ccbd
--- /dev/null
+++ b/tools/perf/arch/powerpc/tests/dwarf-unwind.c
@@ -0,0 +1,62 @@
+#include <string.h>
+#include "perf_regs.h"
+#include "thread.h"
+#include "map.h"
+#include "event.h"
+#include "debug.h"
+#include "tests/tests.h"
+#include "arch-tests.h"
+
+#define STACK_SIZE 8192
+
+static int sample_ustack(struct perf_sample *sample,
+			 struct thread *thread, u64 *regs)
+{
+	struct stack_dump *stack = &sample->user_stack;
+	struct map *map;
+	unsigned long sp;
+	u64 stack_size, *buf;
+
+	buf = malloc(STACK_SIZE);
+	if (!buf) {
+		pr_debug("failed to allocate sample uregs data\n");
+		return -1;
+	}
+
+	sp = (unsigned long) regs[PERF_REG_POWERPC_R1];
+
+	map = map_groups__find(thread->mg, MAP__VARIABLE, (u64) sp);
+	if (!map) {
+		pr_debug("failed to get stack map\n");
+		free(buf);
+		return -1;
+	}
+
+	stack_size = map->end - sp;
+	stack_size = stack_size > STACK_SIZE ? STACK_SIZE : stack_size;
+
+	memcpy(buf, (void *) sp, stack_size);
+	stack->data = (char *) buf;
+	stack->size = stack_size;
+	return 0;
+}
+
+int test__arch_unwind_sample(struct perf_sample *sample,
+			     struct thread *thread)
+{
+	struct regs_dump *regs = &sample->user_regs;
+	u64 *buf;
+
+	buf = calloc(1, sizeof(u64) * PERF_REGS_MAX);
+	if (!buf) {
+		pr_debug("failed to allocate sample uregs data\n");
+		return -1;
+	}
+
+	perf_regs_load(buf);
+	regs->abi  = PERF_SAMPLE_REGS_ABI;
+	regs->regs = buf;
+	regs->mask = PERF_REGS_MASK;
+
+	return sample_ustack(sample, thread, buf);
+}
diff --git a/tools/perf/arch/powerpc/tests/regs_load.S b/tools/perf/arch/powerpc/tests/regs_load.S
new file mode 100644
index 000000000000..d76c9a32f327
--- /dev/null
+++ b/tools/perf/arch/powerpc/tests/regs_load.S
@@ -0,0 +1,94 @@
+#include <linux/linkage.h>
+
+/* Offset is based on macros from arch/powerpc/include/uapi/asm/ptrace.h. */
+#define R0	 0
+#define R1	 1 * 8
+#define R2	 2 * 8
+#define R3	 3 * 8
+#define R4	 4 * 8
+#define R5	 5 * 8
+#define R6	 6 * 8
+#define R7	 7 * 8
+#define R8	 8 * 8
+#define R9	 9 * 8
+#define R10	10 * 8
+#define R11	11 * 8
+#define R12	12 * 8
+#define R13	13 * 8
+#define R14	14 * 8
+#define R15	15 * 8
+#define R16	16 * 8
+#define R17	17 * 8
+#define R18	18 * 8
+#define R19	19 * 8
+#define R20	20 * 8
+#define R21	21 * 8
+#define R22	22 * 8
+#define R23	23 * 8
+#define R24	24 * 8
+#define R25	25 * 8
+#define R26	26 * 8
+#define R27	27 * 8
+#define R28	28 * 8
+#define R29	29 * 8
+#define R30	30 * 8
+#define R31	31 * 8
+#define NIP	32 * 8
+#define CTR	35 * 8
+#define LINK	36 * 8
+#define XER	37 * 8
+
+.globl perf_regs_load
+perf_regs_load:
+	std 0, R0(3)
+	std 1, R1(3)
+	std 2, R2(3)
+	std 3, R3(3)
+	std 4, R4(3)
+	std 5, R5(3)
+	std 6, R6(3)
+	std 7, R7(3)
+	std 8, R8(3)
+	std 9, R9(3)
+	std 10, R10(3)
+	std 11, R11(3)
+	std 12, R12(3)
+	std 13, R13(3)
+	std 14, R14(3)
+	std 15, R15(3)
+	std 16, R16(3)
+	std 17, R17(3)
+	std 18, R18(3)
+	std 19, R19(3)
+	std 20, R20(3)
+	std 21, R21(3)
+	std 22, R22(3)
+	std 23, R23(3)
+	std 24, R24(3)
+	std 25, R25(3)
+	std 26, R26(3)
+	std 27, R27(3)
+	std 28, R28(3)
+	std 29, R29(3)
+	std 30, R30(3)
+	std 31, R31(3)
+
+	/* store NIP */
+	mflr 4
+	std 4, NIP(3)
+
+	/* Store LR */
+	std 4, LINK(3)
+
+	/* Store XER */
+	mfxer 4
+	std 4, XER(3)
+
+	/* Store CTR */
+	mfctr 4
+	std 4, CTR(3)
+
+	/* Restore original value of r4 */
+	ld 4, R4(3)
+
+	blr
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index dc51bc570e51..8a4ce492f7b2 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -71,7 +71,7 @@ $(OUTPUT)tests/llvm-src-relocation.c: tests/bpf-script-test-relocation.c tests/B
 	$(Q)sed -e 's/"/\\"/g' -e 's/\(.*\)/"\1\\n"/g' $< >> $@
 	$(Q)echo ';' >> $@
 
-ifeq ($(ARCH),$(filter $(ARCH),x86 arm arm64))
+ifeq ($(ARCH),$(filter $(ARCH),x86 arm arm64 powerpc))
 perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
 endif
 
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 8f6eb853aaf7..1046491de4b2 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -11,7 +11,7 @@
 #include "thread.h"
 #include "callchain.h"
 
-#if defined (__x86_64__) || defined (__i386__)
+#if defined (__x86_64__) || defined (__i386__) || defined (__powerpc__)
 #include "arch-tests.h"
 #endif
 
-- 
2.7.4
