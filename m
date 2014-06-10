Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 845D01A0198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 22:23:19 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 4/4] selftests/powerpc: Add tests of PMU EBBs
Date: Tue, 10 Jun 2014 22:23:10 +1000
Message-Id: <1402402990-31925-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1402402990-31925-1-git-send-email-mpe@ellerman.id.au>
References: <1402402990-31925-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Power8 Performance Monitor Unit (PMU) has a new feature called Event
Based Branches (EBB). This commit adds tests of the kernel API for using
EBBs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/Makefile       |  26 +-
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |  32 +
 .../powerpc/pmu/ebb/back_to_back_ebbs_test.c       | 106 +++
 .../powerpc/pmu/ebb/close_clears_pmcc_test.c       |  59 ++
 .../powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c |  93 +++
 .../powerpc/pmu/ebb/cpu_event_vs_ebb_test.c        |  89 +++
 .../selftests/powerpc/pmu/ebb/cycles_test.c        |  58 ++
 .../powerpc/pmu/ebb/cycles_with_freeze_test.c      | 117 ++++
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      | 727 +++++++++++++++++++++
 tools/testing/selftests/powerpc/pmu/ebb/ebb.h      |  78 +++
 .../selftests/powerpc/pmu/ebb/ebb_handler.S        | 365 +++++++++++
 .../selftests/powerpc/pmu/ebb/ebb_on_child_test.c  |  86 +++
 .../powerpc/pmu/ebb/ebb_on_willing_child_test.c    |  92 +++
 .../powerpc/pmu/ebb/ebb_vs_cpu_event_test.c        |  86 +++
 .../powerpc/pmu/ebb/event_attributes_test.c        | 131 ++++
 .../powerpc/pmu/ebb/fixed_instruction_loop.S       |  43 ++
 .../selftests/powerpc/pmu/ebb/fork_cleanup_test.c  |  79 +++
 .../powerpc/pmu/ebb/instruction_count_test.c       | 164 +++++
 .../powerpc/pmu/ebb/lost_exception_test.c          | 100 +++
 .../selftests/powerpc/pmu/ebb/multi_counter_test.c |  91 +++
 .../powerpc/pmu/ebb/multi_ebb_procs_test.c         | 109 +++
 .../selftests/powerpc/pmu/ebb/no_handler_test.c    |  61 ++
 .../selftests/powerpc/pmu/ebb/pmae_handling_test.c | 106 +++
 .../powerpc/pmu/ebb/pmc56_overflow_test.c          |  93 +++
 tools/testing/selftests/powerpc/pmu/ebb/reg.h      |  49 ++
 .../selftests/powerpc/pmu/ebb/reg_access_test.c    |  39 ++
 .../pmu/ebb/task_event_pinned_vs_ebb_test.c        |  91 +++
 .../powerpc/pmu/ebb/task_event_vs_ebb_test.c       |  83 +++
 tools/testing/selftests/powerpc/pmu/ebb/trace.c    | 300 +++++++++
 tools/testing/selftests/powerpc/pmu/ebb/trace.h    |  41 ++
 tools/testing/selftests/powerpc/pmu/event.c        |  26 +
 tools/testing/selftests/powerpc/pmu/event.h        |   4 +
 tools/testing/selftests/powerpc/pmu/lib.c          | 252 +++++++
 tools/testing/selftests/powerpc/pmu/lib.h          |  41 ++
 34 files changed, 3913 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/Makefile
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/cpu_event_vs_ebb_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb.h
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_handler.S
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/event_attributes_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/fixed_instruction_loop.S
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/reg.h
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/trace.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/ebb/trace.h
 create mode 100644 tools/testing/selftests/powerpc/pmu/lib.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/lib.h

diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index 7216f00..b9ff0db 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -4,7 +4,7 @@ noarg:
 PROGS := count_instructions
 EXTRA_SOURCES := ../harness.c event.c
 
-all: $(PROGS)
+all: $(PROGS) sub_all
 
 $(PROGS): $(EXTRA_SOURCES)
 
@@ -12,12 +12,30 @@ $(PROGS): $(EXTRA_SOURCES)
 count_instructions: loop.S count_instructions.c $(EXTRA_SOURCES)
 	$(CC) $(CFLAGS) -m64 -o $@ $^
 
-run_tests: all
+run_tests: all sub_run_tests
 	@-for PROG in $(PROGS); do \
 		./$$PROG; \
 	done;
 
-clean:
+clean: sub_clean
 	rm -f $(PROGS) loop.o
 
-.PHONY: all run_tests clean
+
+SUB_TARGETS = ebb
+
+sub_all:
+	@for TARGET in $(SUB_TARGETS); do \
+		$(MAKE) -C $$TARGET all; \
+	done;
+
+sub_run_tests: all
+	@for TARGET in $(SUB_TARGETS); do \
+		$(MAKE) -C $$TARGET run_tests; \
+	done;
+
+sub_clean:
+	@for TARGET in $(SUB_TARGETS); do \
+		$(MAKE) -C $$TARGET clean; \
+	done;
+
+.PHONY: all run_tests clean sub_all sub_run_tests sub_clean
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
new file mode 100644
index 0000000..edbba2a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -0,0 +1,32 @@
+noarg:
+	$(MAKE) -C ../../
+
+# The EBB handler is 64-bit code and everything links against it
+CFLAGS += -m64
+
+PROGS := reg_access_test event_attributes_test cycles_test	\
+	 cycles_with_freeze_test pmc56_overflow_test		\
+	 ebb_vs_cpu_event_test cpu_event_vs_ebb_test		\
+	 cpu_event_pinned_vs_ebb_test task_event_vs_ebb_test	\
+	 task_event_pinned_vs_ebb_test multi_ebb_procs_test	\
+	 multi_counter_test pmae_handling_test			\
+	 close_clears_pmcc_test instruction_count_test		\
+	 fork_cleanup_test ebb_on_child_test			\
+	 ebb_on_willing_child_test back_to_back_ebbs_test	\
+	 lost_exception_test no_handler_test
+
+all: $(PROGS)
+
+$(PROGS): ../../harness.c ../event.c ../lib.c ebb.c ebb_handler.S trace.c
+
+instruction_count_test: ../loop.S
+
+lost_exception_test: ../lib.c
+
+run_tests: all
+	@-for PROG in $(PROGS); do \
+		./$$PROG; \
+	done;
+
+clean:
+	rm -f $(PROGS)
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c b/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
new file mode 100644
index 0000000..66ea765
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "ebb.h"
+
+
+#define NUMBER_OF_EBBS	50
+
+/*
+ * Test that if we overflow the counter while in the EBB handler, we take
+ * another EBB on exiting from the handler.
+ *
+ * We do this by counting with a stupidly low sample period, causing us to
+ * overflow the PMU while we're still in the EBB handler, leading to another
+ * EBB.
+ *
+ * We get out of what would otherwise be an infinite loop by leaving the
+ * counter frozen once we've taken enough EBBs.
+ */
+
+static void ebb_callee(void)
+{
+	uint64_t siar, val;
+
+	val = mfspr(SPRN_BESCR);
+	if (!(val & BESCR_PMEO)) {
+		ebb_state.stats.spurious++;
+		goto out;
+	}
+
+	ebb_state.stats.ebb_count++;
+	trace_log_counter(ebb_state.trace, ebb_state.stats.ebb_count);
+
+	/* Resets the PMC */
+	count_pmc(1, sample_period);
+
+out:
+	if (ebb_state.stats.ebb_count == NUMBER_OF_EBBS)
+		/* Reset but leave counters frozen */
+		reset_ebb_with_clear_mask(MMCR0_PMAO);
+	else
+		/* Unfreezes */
+		reset_ebb();
+
+	/* Do some stuff to chew some cycles and pop the counter */
+	siar = mfspr(SPRN_SIAR);
+	trace_log_reg(ebb_state.trace, SPRN_SIAR, siar);
+
+	val = mfspr(SPRN_PMC1);
+	trace_log_reg(ebb_state.trace, SPRN_PMC1, val);
+
+	val = mfspr(SPRN_MMCR0);
+	trace_log_reg(ebb_state.trace, SPRN_MMCR0, val);
+}
+
+int back_to_back_ebbs(void)
+{
+	struct event event;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	setup_ebb_handler(ebb_callee);
+
+	FAIL_IF(ebb_event_enable(&event));
+
+	sample_period = 5;
+
+	ebb_freeze_pmcs();
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+	ebb_global_enable();
+	ebb_unfreeze_pmcs();
+
+	while (ebb_state.stats.ebb_count < NUMBER_OF_EBBS)
+		FAIL_IF(core_busy_loop());
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+
+	dump_ebb_state();
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count != NUMBER_OF_EBBS);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(back_to_back_ebbs, "back_to_back_ebbs");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c b/tools/testing/selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c
new file mode 100644
index 0000000..0f0423d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c
@@ -0,0 +1,59 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <signal.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test that closing the EBB event clears MMCR0_PMCC, preventing further access
+ * by userspace to the PMU hardware.
+ */
+
+int close_clears_pmcc(void)
+{
+	struct event event;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	FAIL_IF(event_open(&event));
+
+	ebb_enable_pmc_counting(1);
+	setup_ebb_handler(standard_ebb_callee);
+	ebb_global_enable();
+	FAIL_IF(ebb_event_enable(&event));
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	while (ebb_state.stats.ebb_count < 1)
+		FAIL_IF(core_busy_loop());
+
+	ebb_global_disable();
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+
+	/* The real test is here, do we take a SIGILL when writing PMU regs now
+	 * that we have closed the event. We expect that we will. */
+
+	FAIL_IF(catch_sigill(write_pmc1));
+
+	/* We should still be able to read EBB regs though */
+	mfspr(SPRN_EBBHR);
+	mfspr(SPRN_EBBRR);
+	mfspr(SPRN_BESCR);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(close_clears_pmcc, "close_clears_pmcc");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c
new file mode 100644
index 0000000..d3ed64d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c
@@ -0,0 +1,93 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "ebb.h"
+
+
+/*
+ * Tests a pinned cpu event vs an EBB - in that order. The pinned cpu event
+ * should remain and the EBB event should fail to enable.
+ */
+
+static int setup_cpu_event(struct event *event, int cpu)
+{
+	event_init_named(event, 0x400FA, "PM_RUN_INST_CMPL");
+
+	event->attr.pinned = 1;
+
+	event->attr.exclude_kernel = 1;
+	event->attr.exclude_hv = 1;
+	event->attr.exclude_idle = 1;
+
+	SKIP_IF(require_paranoia_below(1));
+	FAIL_IF(event_open_with_cpu(event, cpu));
+	FAIL_IF(event_enable(event));
+
+	return 0;
+}
+
+int cpu_event_pinned_vs_ebb(void)
+{
+	union pipe read_pipe, write_pipe;
+	struct event event;
+	int cpu, rc;
+	pid_t pid;
+
+	cpu = pick_online_cpu();
+	FAIL_IF(cpu < 0);
+	FAIL_IF(bind_to_cpu(cpu));
+
+	FAIL_IF(pipe(read_pipe.fds) == -1);
+	FAIL_IF(pipe(write_pipe.fds) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		/* NB order of pipes looks reversed */
+		exit(ebb_child(write_pipe, read_pipe));
+	}
+
+	/* We setup the cpu event first */
+	rc = setup_cpu_event(&event, cpu);
+	if (rc) {
+		kill_child_and_wait(pid);
+		return rc;
+	}
+
+	/* Signal the child to install its EBB event and wait */
+	if (sync_with_child(read_pipe, write_pipe))
+		/* If it fails, wait for it to exit */
+		goto wait;
+
+	/* Signal the child to run */
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+wait:
+	/* We expect it to fail to read the event */
+	FAIL_IF(wait_for_child(pid) != 2);
+
+	FAIL_IF(event_disable(&event));
+	FAIL_IF(event_read(&event));
+
+	event_report(&event);
+
+	/* The cpu event should have run */
+	FAIL_IF(event.result.value == 0);
+	FAIL_IF(event.result.enabled != event.result.running);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(cpu_event_pinned_vs_ebb, "cpu_event_pinned_vs_ebb");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_vs_ebb_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_vs_ebb_test.c
new file mode 100644
index 0000000..8b972c2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_vs_ebb_test.c
@@ -0,0 +1,89 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "ebb.h"
+
+
+/*
+ * Tests a cpu event vs an EBB - in that order. The EBB should force the cpu
+ * event off the PMU.
+ */
+
+static int setup_cpu_event(struct event *event, int cpu)
+{
+	event_init_named(event, 0x400FA, "PM_RUN_INST_CMPL");
+
+	event->attr.exclude_kernel = 1;
+	event->attr.exclude_hv = 1;
+	event->attr.exclude_idle = 1;
+
+	SKIP_IF(require_paranoia_below(1));
+	FAIL_IF(event_open_with_cpu(event, cpu));
+	FAIL_IF(event_enable(event));
+
+	return 0;
+}
+
+int cpu_event_vs_ebb(void)
+{
+	union pipe read_pipe, write_pipe;
+	struct event event;
+	int cpu, rc;
+	pid_t pid;
+
+	cpu = pick_online_cpu();
+	FAIL_IF(cpu < 0);
+	FAIL_IF(bind_to_cpu(cpu));
+
+	FAIL_IF(pipe(read_pipe.fds) == -1);
+	FAIL_IF(pipe(write_pipe.fds) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		/* NB order of pipes looks reversed */
+		exit(ebb_child(write_pipe, read_pipe));
+	}
+
+	/* We setup the cpu event first */
+	rc = setup_cpu_event(&event, cpu);
+	if (rc) {
+		kill_child_and_wait(pid);
+		return rc;
+	}
+
+	/* Signal the child to install its EBB event and wait */
+	if (sync_with_child(read_pipe, write_pipe))
+		/* If it fails, wait for it to exit */
+		goto wait;
+
+	/* Signal the child to run */
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+wait:
+	/* We expect the child to succeed */
+	FAIL_IF(wait_for_child(pid));
+
+	FAIL_IF(event_disable(&event));
+	FAIL_IF(event_read(&event));
+
+	event_report(&event);
+
+	/* The cpu event may have run */
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(cpu_event_vs_ebb, "cpu_event_vs_ebb");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
new file mode 100644
index 0000000..8590fc1
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
@@ -0,0 +1,58 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "ebb.h"
+
+
+/*
+ * Basic test that counts user cycles and takes EBBs.
+ */
+int cycles(void)
+{
+	struct event event;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	ebb_enable_pmc_counting(1);
+	setup_ebb_handler(standard_ebb_callee);
+	ebb_global_enable();
+	FAIL_IF(ebb_event_enable(&event));
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	while (ebb_state.stats.ebb_count < 10) {
+		FAIL_IF(core_busy_loop());
+		FAIL_IF(ebb_check_mmcr0());
+	}
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+
+	dump_ebb_state();
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+	FAIL_IF(!ebb_check_count(1, sample_period, 100));
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(cycles, "cycles");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
new file mode 100644
index 0000000..754b3f2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
@@ -0,0 +1,117 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test of counting cycles while using MMCR0_FC (freeze counters) to only count
+ * parts of the code. This is complicated by the fact that FC is set by the
+ * hardware when the event overflows. We may take the EBB after we have set FC,
+ * so we have to be careful about whether we clear FC at the end of the EBB
+ * handler or not.
+ */
+
+static bool counters_frozen = false;
+static int ebbs_while_frozen = 0;
+
+static void ebb_callee(void)
+{
+	uint64_t mask, val;
+
+	mask = MMCR0_PMAO | MMCR0_FC;
+
+	val = mfspr(SPRN_BESCR);
+	if (!(val & BESCR_PMEO)) {
+		ebb_state.stats.spurious++;
+		goto out;
+	}
+
+	ebb_state.stats.ebb_count++;
+	trace_log_counter(ebb_state.trace, ebb_state.stats.ebb_count);
+
+	val = mfspr(SPRN_MMCR0);
+	trace_log_reg(ebb_state.trace, SPRN_MMCR0, val);
+
+	if (counters_frozen) {
+		trace_log_string(ebb_state.trace, "frozen");
+		ebbs_while_frozen++;
+		mask &= ~MMCR0_FC;
+	}
+
+	count_pmc(1, sample_period);
+out:
+	reset_ebb_with_clear_mask(mask);
+}
+
+int cycles_with_freeze(void)
+{
+	struct event event;
+	uint64_t val;
+	bool fc_cleared;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	setup_ebb_handler(ebb_callee);
+	ebb_global_enable();
+	FAIL_IF(ebb_event_enable(&event));
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	fc_cleared = false;
+
+	/* Make sure we loop until we take at least one EBB */
+	while ((ebb_state.stats.ebb_count < 20 && !fc_cleared) ||
+		ebb_state.stats.ebb_count < 1)
+	{
+		counters_frozen = false;
+		mb();
+		mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_FC);
+
+		FAIL_IF(core_busy_loop());
+
+		counters_frozen = true;
+		mb();
+		mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) |  MMCR0_FC);
+
+		val = mfspr(SPRN_MMCR0);
+		if (! (val & MMCR0_FC)) {
+			printf("Outside of loop, FC NOT set MMCR0 0x%lx\n", val);
+			fc_cleared = true;
+		}
+	}
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+
+	dump_ebb_state();
+
+	printf("EBBs while frozen %d\n", ebbs_while_frozen);
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+	FAIL_IF(fc_cleared);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(cycles_with_freeze, "cycles_with_freeze");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
new file mode 100644
index 0000000..1b46be9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -0,0 +1,727 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#define _GNU_SOURCE	/* For CPU_ZERO etc. */
+
+#include <sched.h>
+#include <sys/wait.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "trace.h"
+#include "reg.h"
+#include "ebb.h"
+
+
+void (*ebb_user_func)(void);
+
+void ebb_hook(void)
+{
+	if (ebb_user_func)
+		ebb_user_func();
+}
+
+struct ebb_state ebb_state;
+
+u64 sample_period = 0x40000000ull;
+
+void reset_ebb_with_clear_mask(unsigned long mmcr0_clear_mask)
+{
+	u64 val;
+
+	/* 2) clear MMCR0[PMAO] - docs say BESCR[PMEO] should do this */
+	/* 3) set MMCR0[PMAE]	- docs say BESCR[PME] should do this */
+	val = mfspr(SPRN_MMCR0);
+	mtspr(SPRN_MMCR0, (val & ~mmcr0_clear_mask) | MMCR0_PMAE);
+
+	/* 4) clear BESCR[PMEO] */
+	mtspr(SPRN_BESCRR, BESCR_PMEO);
+
+	/* 5) set BESCR[PME] */
+	mtspr(SPRN_BESCRS, BESCR_PME);
+
+	/* 6) rfebb 1 - done in our caller */
+}
+
+void reset_ebb(void)
+{
+	reset_ebb_with_clear_mask(MMCR0_PMAO | MMCR0_FC);
+}
+
+/* Called outside of the EBB handler to check MMCR0 is sane */
+int ebb_check_mmcr0(void)
+{
+	u64 val;
+
+	val = mfspr(SPRN_MMCR0);
+	if ((val & (MMCR0_FC | MMCR0_PMAO)) == MMCR0_FC) {
+		/* It's OK if we see FC & PMAO, but not FC by itself */
+		printf("Outside of loop, only FC set 0x%llx\n", val);
+		return 1;
+	}
+
+	return 0;
+}
+
+bool ebb_check_count(int pmc, u64 sample_period, int fudge)
+{
+	u64 count, upper, lower;
+
+	count = ebb_state.stats.pmc_count[PMC_INDEX(pmc)];
+
+	lower = ebb_state.stats.ebb_count * (sample_period - fudge);
+
+	if (count < lower) {
+		printf("PMC%d count (0x%llx) below lower limit 0x%llx (-0x%llx)\n",
+			pmc, count, lower, lower - count);
+		return false;
+	}
+
+	upper = ebb_state.stats.ebb_count * (sample_period + fudge);
+
+	if (count > upper) {
+		printf("PMC%d count (0x%llx) above upper limit 0x%llx (+0x%llx)\n",
+			pmc, count, upper, count - upper);
+		return false;
+	}
+
+	printf("PMC%d count (0x%llx) is between 0x%llx and 0x%llx delta +0x%llx/-0x%llx\n",
+		pmc, count, lower, upper, count - lower, upper - count);
+
+	return true;
+}
+
+void standard_ebb_callee(void)
+{
+	int found, i;
+	u64 val;
+
+	val = mfspr(SPRN_BESCR);
+	if (!(val & BESCR_PMEO)) {
+		ebb_state.stats.spurious++;
+		goto out;
+	}
+
+	ebb_state.stats.ebb_count++;
+	trace_log_counter(ebb_state.trace, ebb_state.stats.ebb_count);
+
+	val = mfspr(SPRN_MMCR0);
+	trace_log_reg(ebb_state.trace, SPRN_MMCR0, val);
+
+	found = 0;
+	for (i = 1; i <= 6; i++) {
+		if (ebb_state.pmc_enable[PMC_INDEX(i)])
+			found += count_pmc(i, sample_period);
+	}
+
+	if (!found)
+		ebb_state.stats.no_overflow++;
+
+out:
+	reset_ebb();
+}
+
+extern void ebb_handler(void);
+
+void setup_ebb_handler(void (*callee)(void))
+{
+	u64 entry;
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	entry = (u64)ebb_handler;
+#else
+	struct opd
+	{
+	    u64 entry;
+	    u64 toc;
+	} *opd;
+
+	opd = (struct opd *)ebb_handler;
+	entry = opd->entry;
+#endif
+	printf("EBB Handler is at %#llx\n", entry);
+
+	ebb_user_func = callee;
+
+	/* Ensure ebb_user_func is set before we set the handler */
+	mb();
+	mtspr(SPRN_EBBHR, entry);
+
+	/* Make sure the handler is set before we return */
+	mb();
+}
+
+void clear_ebb_stats(void)
+{
+	memset(&ebb_state.stats, 0, sizeof(ebb_state.stats));
+}
+
+void dump_summary_ebb_state(void)
+{
+	printf("ebb_state:\n"			\
+	       "  ebb_count    = %d\n"		\
+	       "  spurious     = %d\n"		\
+	       "  negative     = %d\n"		\
+	       "  no_overflow  = %d\n"		\
+	       "  pmc[1] count = 0x%llx\n"	\
+	       "  pmc[2] count = 0x%llx\n"	\
+	       "  pmc[3] count = 0x%llx\n"	\
+	       "  pmc[4] count = 0x%llx\n"	\
+	       "  pmc[5] count = 0x%llx\n"	\
+	       "  pmc[6] count = 0x%llx\n",
+		ebb_state.stats.ebb_count, ebb_state.stats.spurious,
+		ebb_state.stats.negative, ebb_state.stats.no_overflow,
+		ebb_state.stats.pmc_count[0], ebb_state.stats.pmc_count[1],
+		ebb_state.stats.pmc_count[2], ebb_state.stats.pmc_count[3],
+		ebb_state.stats.pmc_count[4], ebb_state.stats.pmc_count[5]);
+}
+
+static char *decode_mmcr0(u32 value)
+{
+	static char buf[16];
+
+	buf[0] = '\0';
+
+	if (value & (1 << 31))
+		strcat(buf, "FC ");
+	if (value & (1 << 26))
+		strcat(buf, "PMAE ");
+	if (value & (1 << 7))
+		strcat(buf, "PMAO ");
+
+	return buf;
+}
+
+static char *decode_bescr(u64 value)
+{
+	static char buf[16];
+
+	buf[0] = '\0';
+
+	if (value & (1ull << 63))
+		strcat(buf, "GE ");
+	if (value & (1ull << 32))
+		strcat(buf, "PMAE ");
+	if (value & 1)
+		strcat(buf, "PMAO ");
+
+	return buf;
+}
+
+void dump_ebb_hw_state(void)
+{
+	u64 bescr;
+	u32 mmcr0;
+
+	mmcr0 = mfspr(SPRN_MMCR0);
+	bescr = mfspr(SPRN_BESCR);
+
+	printf("HW state:\n"		\
+	       "MMCR0 0x%016x %s\n"	\
+	       "EBBHR 0x%016lx\n"	\
+	       "BESCR 0x%016llx %s\n"	\
+	       "PMC1  0x%016lx\n"	\
+	       "PMC2  0x%016lx\n"	\
+	       "PMC3  0x%016lx\n"	\
+	       "PMC4  0x%016lx\n"	\
+	       "PMC5  0x%016lx\n"	\
+	       "PMC6  0x%016lx\n"	\
+	       "SIAR  0x%016lx\n",
+	       mmcr0, decode_mmcr0(mmcr0), mfspr(SPRN_EBBHR), bescr,
+	       decode_bescr(bescr), mfspr(SPRN_PMC1), mfspr(SPRN_PMC2),
+	       mfspr(SPRN_PMC3), mfspr(SPRN_PMC4), mfspr(SPRN_PMC5),
+	       mfspr(SPRN_PMC6), mfspr(SPRN_SIAR));
+}
+
+void dump_ebb_state(void)
+{
+	dump_summary_ebb_state();
+
+	dump_ebb_hw_state();
+
+	trace_buffer_print(ebb_state.trace);
+}
+
+int count_pmc(int pmc, uint32_t sample_period)
+{
+	uint32_t start_value;
+	u64 val;
+
+	/* 0) Read PMC */
+	start_value = pmc_sample_period(sample_period);
+
+	val = read_pmc(pmc);
+	if (val < start_value)
+		ebb_state.stats.negative++;
+	else
+		ebb_state.stats.pmc_count[PMC_INDEX(pmc)] += val - start_value;
+
+	trace_log_reg(ebb_state.trace, SPRN_PMC1 + pmc - 1, val);
+
+	/* 1) Reset PMC */
+	write_pmc(pmc, start_value);
+
+	/* Report if we overflowed */
+	return val >= COUNTER_OVERFLOW;
+}
+
+int ebb_event_enable(struct event *e)
+{
+	int rc;
+
+	/* Ensure any SPR writes are ordered vs us */
+	mb();
+
+	rc = ioctl(e->fd, PERF_EVENT_IOC_ENABLE);
+	if (rc)
+		return rc;
+
+	rc = event_read(e);
+
+	/* Ditto */
+	mb();
+
+	return rc;
+}
+
+void ebb_freeze_pmcs(void)
+{
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) | MMCR0_FC);
+	mb();
+}
+
+void ebb_unfreeze_pmcs(void)
+{
+	/* Unfreeze counters */
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_FC);
+	mb();
+}
+
+void ebb_global_enable(void)
+{
+	/* Enable EBBs globally and PMU EBBs */
+	mtspr(SPRN_BESCR, 0x8000000100000000ull);
+	mb();
+}
+
+void ebb_global_disable(void)
+{
+	/* Disable EBBs & freeze counters, events are still scheduled */
+	mtspr(SPRN_BESCRR, BESCR_PME);
+	mb();
+}
+
+void event_ebb_init(struct event *e)
+{
+	e->attr.config |= (1ull << 63);
+}
+
+void event_bhrb_init(struct event *e, unsigned ifm)
+{
+	e->attr.config |= (1ull << 62) | ((u64)ifm << 60);
+}
+
+void event_leader_ebb_init(struct event *e)
+{
+	event_ebb_init(e);
+
+	e->attr.exclusive = 1;
+	e->attr.pinned = 1;
+}
+
+int core_busy_loop(void)
+{
+	int rc;
+
+	asm volatile (
+		"li  3,  0x3030\n"
+		"std 3,  -96(1)\n"
+		"li  4,  0x4040\n"
+		"std 4,  -104(1)\n"
+		"li  5,  0x5050\n"
+		"std 5,  -112(1)\n"
+		"li  6,  0x6060\n"
+		"std 6,  -120(1)\n"
+		"li  7,  0x7070\n"
+		"std 7,  -128(1)\n"
+		"li  8,  0x0808\n"
+		"std 8,  -136(1)\n"
+		"li  9,  0x0909\n"
+		"std 9,  -144(1)\n"
+		"li  10, 0x1010\n"
+		"std 10, -152(1)\n"
+		"li  11, 0x1111\n"
+		"std 11, -160(1)\n"
+		"li  14, 0x1414\n"
+		"std 14, -168(1)\n"
+		"li  15, 0x1515\n"
+		"std 15, -176(1)\n"
+		"li  16, 0x1616\n"
+		"std 16, -184(1)\n"
+		"li  17, 0x1717\n"
+		"std 17, -192(1)\n"
+		"li  18, 0x1818\n"
+		"std 18, -200(1)\n"
+		"li  19, 0x1919\n"
+		"std 19, -208(1)\n"
+		"li  20, 0x2020\n"
+		"std 20, -216(1)\n"
+		"li  21, 0x2121\n"
+		"std 21, -224(1)\n"
+		"li  22, 0x2222\n"
+		"std 22, -232(1)\n"
+		"li  23, 0x2323\n"
+		"std 23, -240(1)\n"
+		"li  24, 0x2424\n"
+		"std 24, -248(1)\n"
+		"li  25, 0x2525\n"
+		"std 25, -256(1)\n"
+		"li  26, 0x2626\n"
+		"std 26, -264(1)\n"
+		"li  27, 0x2727\n"
+		"std 27, -272(1)\n"
+		"li  28, 0x2828\n"
+		"std 28, -280(1)\n"
+		"li  29, 0x2929\n"
+		"std 29, -288(1)\n"
+		"li  30, 0x3030\n"
+		"li  31, 0x3131\n"
+
+		"li    3,  0\n"
+		"0: "
+		"addi  3, 3, 1\n"
+		"cmpwi 3, 100\n"
+		"blt   0b\n"
+
+		/* Return 1 (fail) unless we get through all the checks */
+		"li	0, 1\n"
+
+		/* Check none of our registers have been corrupted */
+		"cmpwi  4,  0x4040\n"
+		"bne	1f\n"
+		"cmpwi  5,  0x5050\n"
+		"bne	1f\n"
+		"cmpwi  6,  0x6060\n"
+		"bne	1f\n"
+		"cmpwi  7,  0x7070\n"
+		"bne	1f\n"
+		"cmpwi  8,  0x0808\n"
+		"bne	1f\n"
+		"cmpwi  9,  0x0909\n"
+		"bne	1f\n"
+		"cmpwi  10, 0x1010\n"
+		"bne	1f\n"
+		"cmpwi  11, 0x1111\n"
+		"bne	1f\n"
+		"cmpwi  14, 0x1414\n"
+		"bne	1f\n"
+		"cmpwi  15, 0x1515\n"
+		"bne	1f\n"
+		"cmpwi  16, 0x1616\n"
+		"bne	1f\n"
+		"cmpwi  17, 0x1717\n"
+		"bne	1f\n"
+		"cmpwi  18, 0x1818\n"
+		"bne	1f\n"
+		"cmpwi  19, 0x1919\n"
+		"bne	1f\n"
+		"cmpwi  20, 0x2020\n"
+		"bne	1f\n"
+		"cmpwi  21, 0x2121\n"
+		"bne	1f\n"
+		"cmpwi  22, 0x2222\n"
+		"bne	1f\n"
+		"cmpwi  23, 0x2323\n"
+		"bne	1f\n"
+		"cmpwi  24, 0x2424\n"
+		"bne	1f\n"
+		"cmpwi  25, 0x2525\n"
+		"bne	1f\n"
+		"cmpwi  26, 0x2626\n"
+		"bne	1f\n"
+		"cmpwi  27, 0x2727\n"
+		"bne	1f\n"
+		"cmpwi  28, 0x2828\n"
+		"bne	1f\n"
+		"cmpwi  29, 0x2929\n"
+		"bne	1f\n"
+		"cmpwi  30, 0x3030\n"
+		"bne	1f\n"
+		"cmpwi  31, 0x3131\n"
+		"bne	1f\n"
+
+		/* Load junk into all our registers before we reload them from the stack. */
+		"li  3,  0xde\n"
+		"li  4,  0xad\n"
+		"li  5,  0xbe\n"
+		"li  6,  0xef\n"
+		"li  7,  0xde\n"
+		"li  8,  0xad\n"
+		"li  9,  0xbe\n"
+		"li  10, 0xef\n"
+		"li  11, 0xde\n"
+		"li  14, 0xad\n"
+		"li  15, 0xbe\n"
+		"li  16, 0xef\n"
+		"li  17, 0xde\n"
+		"li  18, 0xad\n"
+		"li  19, 0xbe\n"
+		"li  20, 0xef\n"
+		"li  21, 0xde\n"
+		"li  22, 0xad\n"
+		"li  23, 0xbe\n"
+		"li  24, 0xef\n"
+		"li  25, 0xde\n"
+		"li  26, 0xad\n"
+		"li  27, 0xbe\n"
+		"li  28, 0xef\n"
+		"li  29, 0xdd\n"
+
+		"ld     3,  -96(1)\n"
+		"cmpwi  3,  0x3030\n"
+		"bne	1f\n"
+		"ld     4,  -104(1)\n"
+		"cmpwi  4,  0x4040\n"
+		"bne	1f\n"
+		"ld     5,  -112(1)\n"
+		"cmpwi  5,  0x5050\n"
+		"bne	1f\n"
+		"ld     6,  -120(1)\n"
+		"cmpwi  6,  0x6060\n"
+		"bne	1f\n"
+		"ld     7,  -128(1)\n"
+		"cmpwi  7,  0x7070\n"
+		"bne	1f\n"
+		"ld     8,  -136(1)\n"
+		"cmpwi  8,  0x0808\n"
+		"bne	1f\n"
+		"ld     9,  -144(1)\n"
+		"cmpwi  9,  0x0909\n"
+		"bne	1f\n"
+		"ld     10, -152(1)\n"
+		"cmpwi  10, 0x1010\n"
+		"bne	1f\n"
+		"ld     11, -160(1)\n"
+		"cmpwi  11, 0x1111\n"
+		"bne	1f\n"
+		"ld     14, -168(1)\n"
+		"cmpwi  14, 0x1414\n"
+		"bne	1f\n"
+		"ld     15, -176(1)\n"
+		"cmpwi  15, 0x1515\n"
+		"bne	1f\n"
+		"ld     16, -184(1)\n"
+		"cmpwi  16, 0x1616\n"
+		"bne	1f\n"
+		"ld     17, -192(1)\n"
+		"cmpwi  17, 0x1717\n"
+		"bne	1f\n"
+		"ld     18, -200(1)\n"
+		"cmpwi  18, 0x1818\n"
+		"bne	1f\n"
+		"ld     19, -208(1)\n"
+		"cmpwi  19, 0x1919\n"
+		"bne	1f\n"
+		"ld     20, -216(1)\n"
+		"cmpwi  20, 0x2020\n"
+		"bne	1f\n"
+		"ld     21, -224(1)\n"
+		"cmpwi  21, 0x2121\n"
+		"bne	1f\n"
+		"ld     22, -232(1)\n"
+		"cmpwi  22, 0x2222\n"
+		"bne	1f\n"
+		"ld     23, -240(1)\n"
+		"cmpwi  23, 0x2323\n"
+		"bne	1f\n"
+		"ld     24, -248(1)\n"
+		"cmpwi  24, 0x2424\n"
+		"bne	1f\n"
+		"ld     25, -256(1)\n"
+		"cmpwi  25, 0x2525\n"
+		"bne	1f\n"
+		"ld     26, -264(1)\n"
+		"cmpwi  26, 0x2626\n"
+		"bne	1f\n"
+		"ld     27, -272(1)\n"
+		"cmpwi  27, 0x2727\n"
+		"bne	1f\n"
+		"ld     28, -280(1)\n"
+		"cmpwi  28, 0x2828\n"
+		"bne	1f\n"
+		"ld     29, -288(1)\n"
+		"cmpwi  29, 0x2929\n"
+		"bne	1f\n"
+
+		/* Load 0 (success) to return */
+		"li	0, 0\n"
+
+		"1: 	mr %0, 0\n"
+
+		: "=r" (rc)
+		: /* no inputs */
+		: "3", "4", "5", "6", "7", "8", "9", "10", "11", "14",
+		  "15", "16", "17", "18", "19", "20", "21", "22", "23",
+		   "24", "25", "26", "27", "28", "29", "30", "31",
+		   "memory"
+	);
+
+	return rc;
+}
+
+int core_busy_loop_with_freeze(void)
+{
+	int rc;
+
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_FC);
+	rc = core_busy_loop();
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) |  MMCR0_FC);
+
+	return rc;
+}
+
+int ebb_child(union pipe read_pipe, union pipe write_pipe)
+{
+	struct event event;
+	uint64_t val;
+
+	FAIL_IF(wait_for_parent(read_pipe));
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	ebb_enable_pmc_counting(1);
+	setup_ebb_handler(standard_ebb_callee);
+	ebb_global_enable();
+
+	FAIL_IF(event_enable(&event));
+
+	if (event_read(&event)) {
+		/*
+		 * Some tests expect to fail here, so don't report an error on
+		 * this line, and return a distinguisable error code. Tell the
+		 * parent an error happened.
+		 */
+		notify_parent_of_error(write_pipe);
+		return 2;
+	}
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	FAIL_IF(notify_parent(write_pipe));
+	FAIL_IF(wait_for_parent(read_pipe));
+	FAIL_IF(notify_parent(write_pipe));
+
+	while (ebb_state.stats.ebb_count < 20) {
+		FAIL_IF(core_busy_loop());
+
+		/* To try and hit SIGILL case */
+		val  = mfspr(SPRN_MMCRA);
+		val |= mfspr(SPRN_MMCR2);
+		val |= mfspr(SPRN_MMCR0);
+	}
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+
+	dump_ebb_state();
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+
+	return 0;
+}
+
+static jmp_buf setjmp_env;
+
+static void sigill_handler(int signal)
+{
+	printf("Took sigill\n");
+	longjmp(setjmp_env, 1);
+}
+
+static struct sigaction sigill_action = {
+	.sa_handler = sigill_handler,
+};
+
+int catch_sigill(void (*func)(void))
+{
+	if (sigaction(SIGILL, &sigill_action, NULL)) {
+		perror("sigaction");
+		return 1;
+	}
+
+	if (setjmp(setjmp_env) == 0) {
+		func();
+		return 1;
+	}
+
+	return 0;
+}
+
+void write_pmc1(void)
+{
+	mtspr(SPRN_PMC1, 0);
+}
+
+void write_pmc(int pmc, u64 value)
+{
+	switch (pmc) {
+		case 1: mtspr(SPRN_PMC1, value); break;
+		case 2: mtspr(SPRN_PMC2, value); break;
+		case 3: mtspr(SPRN_PMC3, value); break;
+		case 4: mtspr(SPRN_PMC4, value); break;
+		case 5: mtspr(SPRN_PMC5, value); break;
+		case 6: mtspr(SPRN_PMC6, value); break;
+	}
+}
+
+u64 read_pmc(int pmc)
+{
+	switch (pmc) {
+		case 1: return mfspr(SPRN_PMC1);
+		case 2: return mfspr(SPRN_PMC2);
+		case 3: return mfspr(SPRN_PMC3);
+		case 4: return mfspr(SPRN_PMC4);
+		case 5: return mfspr(SPRN_PMC5);
+		case 6: return mfspr(SPRN_PMC6);
+	}
+
+	return 0;
+}
+
+static void term_handler(int signal)
+{
+	dump_summary_ebb_state();
+	dump_ebb_hw_state();
+	abort();
+}
+
+struct sigaction term_action = {
+	.sa_handler = term_handler,
+};
+
+static void __attribute__((constructor)) ebb_init(void)
+{
+	clear_ebb_stats();
+
+	if (sigaction(SIGTERM, &term_action, NULL))
+		perror("sigaction");
+
+	ebb_state.trace = trace_buffer_allocate(1 * 1024 * 1024);
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.h b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
new file mode 100644
index 0000000..e62bde0
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#ifndef _SELFTESTS_POWERPC_PMU_EBB_EBB_H
+#define _SELFTESTS_POWERPC_PMU_EBB_EBB_H
+
+#include "../event.h"
+#include "../lib.h"
+#include "trace.h"
+#include "reg.h"
+
+#define PMC_INDEX(pmc)	((pmc)-1)
+
+#define NUM_PMC_VALUES	128
+
+struct ebb_state
+{
+	struct {
+		u64 pmc_count[6];
+		volatile int ebb_count;
+		int spurious;
+		int negative;
+		int no_overflow;
+	} stats;
+
+	bool pmc_enable[6];
+	struct trace_buffer *trace;
+};
+
+extern struct ebb_state ebb_state;
+
+#define COUNTER_OVERFLOW 0x80000000ull
+
+static inline uint32_t pmc_sample_period(uint32_t value)
+{
+	return COUNTER_OVERFLOW - value;
+}
+
+static inline void ebb_enable_pmc_counting(int pmc)
+{
+	ebb_state.pmc_enable[PMC_INDEX(pmc)] = true;
+}
+
+bool ebb_check_count(int pmc, u64 sample_period, int fudge);
+void event_leader_ebb_init(struct event *e);
+void event_ebb_init(struct event *e);
+void event_bhrb_init(struct event *e, unsigned ifm);
+void setup_ebb_handler(void (*callee)(void));
+void standard_ebb_callee(void);
+int ebb_event_enable(struct event *e);
+void ebb_global_enable(void);
+void ebb_global_disable(void);
+void ebb_freeze_pmcs(void);
+void ebb_unfreeze_pmcs(void);
+void event_ebb_init(struct event *e);
+void event_leader_ebb_init(struct event *e);
+int count_pmc(int pmc, uint32_t sample_period);
+void dump_ebb_state(void);
+void dump_summary_ebb_state(void);
+void dump_ebb_hw_state(void);
+void clear_ebb_stats(void);
+void write_pmc(int pmc, u64 value);
+u64 read_pmc(int pmc);
+void reset_ebb_with_clear_mask(unsigned long mmcr0_clear_mask);
+void reset_ebb(void);
+int ebb_check_mmcr0(void);
+
+extern u64 sample_period;
+
+int core_busy_loop(void);
+int core_busy_loop_with_freeze(void);
+int ebb_child(union pipe read_pipe, union pipe write_pipe);
+int catch_sigill(void (*func)(void));
+void write_pmc1(void);
+
+#endif /* _SELFTESTS_POWERPC_PMU_EBB_EBB_H */
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_handler.S b/tools/testing/selftests/powerpc/pmu/ebb/ebb_handler.S
new file mode 100644
index 0000000..14274ea
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_handler.S
@@ -0,0 +1,365 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <ppc-asm.h>
+#include "reg.h"
+
+
+/* ppc-asm.h defines most of the reg aliases, but not r1/r2. */
+#define r1 1
+#define r2 2
+
+#define RFEBB   .long 0x4c000924
+
+/* Stack layout:
+ *
+ *                   ^
+ *  User stack       |
+ *  Back chain ------+	<- r1		<-------+
+ *  ...						|
+ *  Red zone / ABI Gap				|
+ *  ...						|
+ *  vr63	<+				|
+ *  vr0		 |				|
+ *  VSCR	 |				|
+ *  FSCR	 |				|
+ *  r31		 | Save area			|
+ *  r0		 |				|
+ *  XER		 |				|
+ *  CTR		 |				|
+ *  LR		 |				|
+ *  CCR		<+				|
+ *  ...		<+				|
+ *  LR		 | Caller frame			|
+ *  CCR		 |				|
+ *  Back chain	<+	<- updated r1	--------+
+ *
+ */
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define ABIGAP		512
+#else
+#define ABIGAP		288
+#endif
+
+#define NR_GPR		32
+#define NR_SPR		6
+#define NR_VSR		64
+
+#define SAVE_AREA	((NR_GPR + NR_SPR) * 8 + (NR_VSR * 16))
+#define CALLER_FRAME	112
+
+#define STACK_FRAME	(ABIGAP + SAVE_AREA + CALLER_FRAME)
+
+#define CCR_SAVE	(CALLER_FRAME)
+#define LR_SAVE		(CCR_SAVE + 8)
+#define CTR_SAVE	(LR_SAVE  + 8)
+#define XER_SAVE	(CTR_SAVE + 8)
+#define GPR_SAVE(n)	(XER_SAVE + 8 + (8 * n))
+#define FSCR_SAVE	(GPR_SAVE(31) + 8)
+#define VSCR_SAVE	(FSCR_SAVE + 8)
+#define VSR_SAVE(n)	(VSCR_SAVE + 8 + (16 * n))
+
+#define SAVE_GPR(n)	std n,GPR_SAVE(n)(r1)
+#define REST_GPR(n)	ld  n,GPR_SAVE(n)(r1)
+#define TRASH_GPR(n)	lis n,0xaaaa
+
+#define SAVE_VSR(n, b)	li b, VSR_SAVE(n); stxvd2x n,b,r1
+#define LOAD_VSR(n, b)	li b, VSR_SAVE(n); lxvd2x  n,b,r1
+
+#define LOAD_REG_IMMEDIATE(reg,expr)	\
+	lis     reg,(expr)@highest;	\
+	ori     reg,reg,(expr)@higher;	\
+	rldicr  reg,reg,32,31;		\
+	oris    reg,reg,(expr)@h;	\
+	ori     reg,reg,(expr)@l;
+
+
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+#define ENTRY_POINT(name) \
+	.type FUNC_NAME(name),@function; \
+	.globl FUNC_NAME(name); \
+	FUNC_NAME(name):
+
+#define RESTORE_TOC(name)	\
+	/* Restore our TOC pointer using our entry point */	\
+	LOAD_REG_IMMEDIATE(r12, name)				\
+0:	addis	r2,r12,(.TOC.-0b)@ha;				\
+	addi	r2,r2,(.TOC.-0b)@l;
+
+#else
+#define ENTRY_POINT(name) FUNC_START(name)
+#define RESTORE_TOC(name)	\
+	/* Restore our TOC pointer via our opd entry */	\
+	LOAD_REG_IMMEDIATE(r2, name)			\
+	ld      r2,8(r2);
+#endif
+
+    .text
+
+ENTRY_POINT(ebb_handler)
+    stdu    r1,-STACK_FRAME(r1)
+    SAVE_GPR(0)
+    mflr    r0
+    std     r0,LR_SAVE(r1)
+    mfcr    r0
+    std     r0,CCR_SAVE(r1)
+    mfctr   r0
+    std     r0,CTR_SAVE(r1)
+    mfxer   r0
+    std     r0,XER_SAVE(r1)
+    SAVE_GPR(2)
+    SAVE_GPR(3)
+    SAVE_GPR(4)
+    SAVE_GPR(5)
+    SAVE_GPR(6)
+    SAVE_GPR(7)
+    SAVE_GPR(8)
+    SAVE_GPR(9)
+    SAVE_GPR(10)
+    SAVE_GPR(11)
+    SAVE_GPR(12)
+    SAVE_GPR(13)
+    SAVE_GPR(14)
+    SAVE_GPR(15)
+    SAVE_GPR(16)
+    SAVE_GPR(17)
+    SAVE_GPR(18)
+    SAVE_GPR(19)
+    SAVE_GPR(20)
+    SAVE_GPR(21)
+    SAVE_GPR(22)
+    SAVE_GPR(23)
+    SAVE_GPR(24)
+    SAVE_GPR(25)
+    SAVE_GPR(26)
+    SAVE_GPR(27)
+    SAVE_GPR(28)
+    SAVE_GPR(29)
+    SAVE_GPR(30)
+    SAVE_GPR(31)
+    SAVE_VSR(0, r3)
+    mffs     f0
+    stfd     f0, FSCR_SAVE(r1)
+    mfvscr   f0
+    stfd     f0, VSCR_SAVE(r1)
+    SAVE_VSR(1,  r3)
+    SAVE_VSR(2,  r3)
+    SAVE_VSR(3,  r3)
+    SAVE_VSR(4,  r3)
+    SAVE_VSR(5,  r3)
+    SAVE_VSR(6,  r3)
+    SAVE_VSR(7,  r3)
+    SAVE_VSR(8,  r3)
+    SAVE_VSR(9,  r3)
+    SAVE_VSR(10, r3)
+    SAVE_VSR(11, r3)
+    SAVE_VSR(12, r3)
+    SAVE_VSR(13, r3)
+    SAVE_VSR(14, r3)
+    SAVE_VSR(15, r3)
+    SAVE_VSR(16, r3)
+    SAVE_VSR(17, r3)
+    SAVE_VSR(18, r3)
+    SAVE_VSR(19, r3)
+    SAVE_VSR(20, r3)
+    SAVE_VSR(21, r3)
+    SAVE_VSR(22, r3)
+    SAVE_VSR(23, r3)
+    SAVE_VSR(24, r3)
+    SAVE_VSR(25, r3)
+    SAVE_VSR(26, r3)
+    SAVE_VSR(27, r3)
+    SAVE_VSR(28, r3)
+    SAVE_VSR(29, r3)
+    SAVE_VSR(30, r3)
+    SAVE_VSR(31, r3)
+    SAVE_VSR(32, r3)
+    SAVE_VSR(33, r3)
+    SAVE_VSR(34, r3)
+    SAVE_VSR(35, r3)
+    SAVE_VSR(36, r3)
+    SAVE_VSR(37, r3)
+    SAVE_VSR(38, r3)
+    SAVE_VSR(39, r3)
+    SAVE_VSR(40, r3)
+    SAVE_VSR(41, r3)
+    SAVE_VSR(42, r3)
+    SAVE_VSR(43, r3)
+    SAVE_VSR(44, r3)
+    SAVE_VSR(45, r3)
+    SAVE_VSR(46, r3)
+    SAVE_VSR(47, r3)
+    SAVE_VSR(48, r3)
+    SAVE_VSR(49, r3)
+    SAVE_VSR(50, r3)
+    SAVE_VSR(51, r3)
+    SAVE_VSR(52, r3)
+    SAVE_VSR(53, r3)
+    SAVE_VSR(54, r3)
+    SAVE_VSR(55, r3)
+    SAVE_VSR(56, r3)
+    SAVE_VSR(57, r3)
+    SAVE_VSR(58, r3)
+    SAVE_VSR(59, r3)
+    SAVE_VSR(60, r3)
+    SAVE_VSR(61, r3)
+    SAVE_VSR(62, r3)
+    SAVE_VSR(63, r3)
+
+    TRASH_GPR(2)
+    TRASH_GPR(3)
+    TRASH_GPR(4)
+    TRASH_GPR(5)
+    TRASH_GPR(6)
+    TRASH_GPR(7)
+    TRASH_GPR(8)
+    TRASH_GPR(9)
+    TRASH_GPR(10)
+    TRASH_GPR(11)
+    TRASH_GPR(12)
+    TRASH_GPR(14)
+    TRASH_GPR(15)
+    TRASH_GPR(16)
+    TRASH_GPR(17)
+    TRASH_GPR(18)
+    TRASH_GPR(19)
+    TRASH_GPR(20)
+    TRASH_GPR(21)
+    TRASH_GPR(22)
+    TRASH_GPR(23)
+    TRASH_GPR(24)
+    TRASH_GPR(25)
+    TRASH_GPR(26)
+    TRASH_GPR(27)
+    TRASH_GPR(28)
+    TRASH_GPR(29)
+    TRASH_GPR(30)
+    TRASH_GPR(31)
+
+    RESTORE_TOC(ebb_handler)
+
+    /*
+     * r13 is our TLS pointer. We leave whatever value was in there when the
+     * EBB fired. That seems to be OK because once set the TLS pointer is not
+     * changed - but presumably that could change in future.
+     */
+
+    bl      ebb_hook
+    nop
+
+    /* r2 may be changed here but we don't care */
+
+    lfd      f0, FSCR_SAVE(r1)
+    mtfsf    0xff,f0
+    lfd      f0, VSCR_SAVE(r1)
+    mtvscr   f0
+    LOAD_VSR(0, r3)
+    LOAD_VSR(1,  r3)
+    LOAD_VSR(2,  r3)
+    LOAD_VSR(3,  r3)
+    LOAD_VSR(4,  r3)
+    LOAD_VSR(5,  r3)
+    LOAD_VSR(6,  r3)
+    LOAD_VSR(7,  r3)
+    LOAD_VSR(8,  r3)
+    LOAD_VSR(9,  r3)
+    LOAD_VSR(10, r3)
+    LOAD_VSR(11, r3)
+    LOAD_VSR(12, r3)
+    LOAD_VSR(13, r3)
+    LOAD_VSR(14, r3)
+    LOAD_VSR(15, r3)
+    LOAD_VSR(16, r3)
+    LOAD_VSR(17, r3)
+    LOAD_VSR(18, r3)
+    LOAD_VSR(19, r3)
+    LOAD_VSR(20, r3)
+    LOAD_VSR(21, r3)
+    LOAD_VSR(22, r3)
+    LOAD_VSR(23, r3)
+    LOAD_VSR(24, r3)
+    LOAD_VSR(25, r3)
+    LOAD_VSR(26, r3)
+    LOAD_VSR(27, r3)
+    LOAD_VSR(28, r3)
+    LOAD_VSR(29, r3)
+    LOAD_VSR(30, r3)
+    LOAD_VSR(31, r3)
+    LOAD_VSR(32, r3)
+    LOAD_VSR(33, r3)
+    LOAD_VSR(34, r3)
+    LOAD_VSR(35, r3)
+    LOAD_VSR(36, r3)
+    LOAD_VSR(37, r3)
+    LOAD_VSR(38, r3)
+    LOAD_VSR(39, r3)
+    LOAD_VSR(40, r3)
+    LOAD_VSR(41, r3)
+    LOAD_VSR(42, r3)
+    LOAD_VSR(43, r3)
+    LOAD_VSR(44, r3)
+    LOAD_VSR(45, r3)
+    LOAD_VSR(46, r3)
+    LOAD_VSR(47, r3)
+    LOAD_VSR(48, r3)
+    LOAD_VSR(49, r3)
+    LOAD_VSR(50, r3)
+    LOAD_VSR(51, r3)
+    LOAD_VSR(52, r3)
+    LOAD_VSR(53, r3)
+    LOAD_VSR(54, r3)
+    LOAD_VSR(55, r3)
+    LOAD_VSR(56, r3)
+    LOAD_VSR(57, r3)
+    LOAD_VSR(58, r3)
+    LOAD_VSR(59, r3)
+    LOAD_VSR(60, r3)
+    LOAD_VSR(61, r3)
+    LOAD_VSR(62, r3)
+    LOAD_VSR(63, r3)
+
+    ld      r0,XER_SAVE(r1)
+    mtxer   r0
+    ld      r0,CTR_SAVE(r1)
+    mtctr   r0
+    ld      r0,LR_SAVE(r1)
+    mtlr    r0
+    ld      r0,CCR_SAVE(r1)
+    mtcr    r0
+    REST_GPR(0)
+    REST_GPR(2)
+    REST_GPR(3)
+    REST_GPR(4)
+    REST_GPR(5)
+    REST_GPR(6)
+    REST_GPR(7)
+    REST_GPR(8)
+    REST_GPR(9)
+    REST_GPR(10)
+    REST_GPR(11)
+    REST_GPR(12)
+    REST_GPR(13)
+    REST_GPR(14)
+    REST_GPR(15)
+    REST_GPR(16)
+    REST_GPR(17)
+    REST_GPR(18)
+    REST_GPR(19)
+    REST_GPR(20)
+    REST_GPR(21)
+    REST_GPR(22)
+    REST_GPR(23)
+    REST_GPR(24)
+    REST_GPR(25)
+    REST_GPR(26)
+    REST_GPR(27)
+    REST_GPR(28)
+    REST_GPR(29)
+    REST_GPR(30)
+    REST_GPR(31)
+    addi    r1,r1,STACK_FRAME
+    RFEBB
+FUNC_END(ebb_handler)
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c
new file mode 100644
index 0000000..c45f948
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c
@@ -0,0 +1,86 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "ebb.h"
+
+
+/*
+ * Tests we can setup an EBB on our child. Nothing interesting happens, because
+ * even though the event is enabled and running the child hasn't enabled the
+ * actual delivery of the EBBs.
+ */
+
+static int victim_child(union pipe read_pipe, union pipe write_pipe)
+{
+	int i;
+
+	FAIL_IF(wait_for_parent(read_pipe));
+	FAIL_IF(notify_parent(write_pipe));
+
+	/* Parent creates EBB event */
+
+	FAIL_IF(wait_for_parent(read_pipe));
+	FAIL_IF(notify_parent(write_pipe));
+
+	/* Check the EBB is enabled by writing PMC1 */
+	write_pmc1();
+
+	/* EBB event is enabled here */
+	for (i = 0; i < 1000000; i++) ;
+
+	return 0;
+}
+
+int ebb_on_child(void)
+{
+	union pipe read_pipe, write_pipe;
+	struct event event;
+	pid_t pid;
+
+	FAIL_IF(pipe(read_pipe.fds) == -1);
+	FAIL_IF(pipe(write_pipe.fds) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		/* NB order of pipes looks reversed */
+		exit(victim_child(write_pipe, read_pipe));
+	}
+
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+	/* Child is running now */
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open_with_pid(&event, pid));
+	FAIL_IF(ebb_event_enable(&event));
+
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+	/* Child should just exit happily */
+	FAIL_IF(wait_for_child(pid));
+
+	event_close(&event);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(ebb_on_child, "ebb_on_child");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
new file mode 100644
index 0000000..11acf1d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "ebb.h"
+
+
+/*
+ * Tests we can setup an EBB on our child. The child expects this and enables
+ * EBBs, which are then delivered to the child, even though the event is
+ * created by the parent.
+ */
+
+static int victim_child(union pipe read_pipe, union pipe write_pipe)
+{
+	FAIL_IF(wait_for_parent(read_pipe));
+
+	/* Setup our EBB handler, before the EBB event is created */
+	ebb_enable_pmc_counting(1);
+	setup_ebb_handler(standard_ebb_callee);
+	ebb_global_enable();
+
+	FAIL_IF(notify_parent(write_pipe));
+
+	while (ebb_state.stats.ebb_count < 20) {
+		FAIL_IF(core_busy_loop());
+	}
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+
+	dump_ebb_state();
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+
+	return 0;
+}
+
+/* Tests we can setup an EBB on our child - if it's expecting it */
+int ebb_on_willing_child(void)
+{
+	union pipe read_pipe, write_pipe;
+	struct event event;
+	pid_t pid;
+
+	FAIL_IF(pipe(read_pipe.fds) == -1);
+	FAIL_IF(pipe(write_pipe.fds) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		/* NB order of pipes looks reversed */
+		exit(victim_child(write_pipe, read_pipe));
+	}
+
+	/* Signal the child to setup its EBB handler */
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+	/* Child is running now */
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open_with_pid(&event, pid));
+	FAIL_IF(ebb_event_enable(&event));
+
+	/* Child show now take EBBs and then exit */
+	FAIL_IF(wait_for_child(pid));
+
+	event_close(&event);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(ebb_on_willing_child, "ebb_on_willing_child");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c
new file mode 100644
index 0000000..be4dd5a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c
@@ -0,0 +1,86 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "ebb.h"
+
+
+/*
+ * Tests an EBB vs a cpu event - in that order. The EBB should force the cpu
+ * event off the PMU.
+ */
+
+static int setup_cpu_event(struct event *event, int cpu)
+{
+	event_init_named(event, 0x400FA, "PM_RUN_INST_CMPL");
+
+	event->attr.exclude_kernel = 1;
+	event->attr.exclude_hv = 1;
+	event->attr.exclude_idle = 1;
+
+	SKIP_IF(require_paranoia_below(1));
+	FAIL_IF(event_open_with_cpu(event, cpu));
+	FAIL_IF(event_enable(event));
+
+	return 0;
+}
+
+int ebb_vs_cpu_event(void)
+{
+	union pipe read_pipe, write_pipe;
+	struct event event;
+	int cpu, rc;
+	pid_t pid;
+
+	cpu = pick_online_cpu();
+	FAIL_IF(cpu < 0);
+	FAIL_IF(bind_to_cpu(cpu));
+
+	FAIL_IF(pipe(read_pipe.fds) == -1);
+	FAIL_IF(pipe(write_pipe.fds) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		/* NB order of pipes looks reversed */
+		exit(ebb_child(write_pipe, read_pipe));
+	}
+
+	/* Signal the child to install its EBB event and wait */
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+	/* Now try to install our CPU event */
+	rc = setup_cpu_event(&event, cpu);
+	if (rc) {
+		kill_child_and_wait(pid);
+		return rc;
+	}
+
+	/* Signal the child to run */
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+	/* .. and wait for it to complete */
+	FAIL_IF(wait_for_child(pid));
+	FAIL_IF(event_disable(&event));
+	FAIL_IF(event_read(&event));
+
+	event_report(&event);
+
+	/* The cpu event may have run, but we don't expect 100% */
+	FAIL_IF(event.result.enabled >= event.result.running);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(ebb_vs_cpu_event, "ebb_vs_cpu_event");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/event_attributes_test.c b/tools/testing/selftests/powerpc/pmu/ebb/event_attributes_test.c
new file mode 100644
index 0000000..7e78153
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/event_attributes_test.c
@@ -0,0 +1,131 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test various attributes of the EBB event are enforced.
+ */
+int event_attributes(void)
+{
+	struct event event, leader;
+
+	event_init(&event, 0x1001e);
+	event_leader_ebb_init(&event);
+	/* Expected to succeed */
+	FAIL_IF(event_open(&event));
+	event_close(&event);
+
+
+	event_init(&event, 0x001e); /* CYCLES - no PMC specified */
+	event_leader_ebb_init(&event);
+	/* Expected to fail, no PMC specified */
+	FAIL_IF(event_open(&event) == 0);
+
+
+	event_init(&event, 0x2001e);
+	event_leader_ebb_init(&event);
+	event.attr.exclusive = 0;
+	/* Expected to fail, not exclusive */
+	FAIL_IF(event_open(&event) == 0);
+
+
+	event_init(&event, 0x3001e);
+	event_leader_ebb_init(&event);
+	event.attr.freq = 1;
+	/* Expected to fail, sets freq */
+	FAIL_IF(event_open(&event) == 0);
+
+
+	event_init(&event, 0x4001e);
+	event_leader_ebb_init(&event);
+	event.attr.sample_period = 1;
+	/* Expected to fail, sets sample_period */
+	FAIL_IF(event_open(&event) == 0);
+
+
+	event_init(&event, 0x1001e);
+	event_leader_ebb_init(&event);
+	event.attr.enable_on_exec = 1;
+	/* Expected to fail, sets enable_on_exec */
+	FAIL_IF(event_open(&event) == 0);
+
+
+	event_init(&event, 0x1001e);
+	event_leader_ebb_init(&event);
+	event.attr.inherit = 1;
+	/* Expected to fail, sets inherit */
+	FAIL_IF(event_open(&event) == 0);
+
+
+	event_init(&leader, 0x1001e);
+	event_leader_ebb_init(&leader);
+	FAIL_IF(event_open(&leader));
+
+	event_init(&event, 0x20002);
+	event_ebb_init(&event);
+
+	/* Expected to succeed */
+	FAIL_IF(event_open_with_group(&event, leader.fd));
+	event_close(&leader);
+	event_close(&event);
+
+
+	event_init(&leader, 0x1001e);
+	event_leader_ebb_init(&leader);
+	FAIL_IF(event_open(&leader));
+
+	event_init(&event, 0x20002);
+
+	/* Expected to fail, event doesn't request EBB, leader does */
+	FAIL_IF(event_open_with_group(&event, leader.fd) == 0);
+	event_close(&leader);
+
+
+	event_init(&leader, 0x1001e);
+	event_leader_ebb_init(&leader);
+	/* Clear the EBB flag */
+	leader.attr.config &= ~(1ull << 63);
+
+	FAIL_IF(event_open(&leader));
+
+	event_init(&event, 0x20002);
+	event_ebb_init(&event);
+
+	/* Expected to fail, leader doesn't request EBB */
+	FAIL_IF(event_open_with_group(&event, leader.fd) == 0);
+	event_close(&leader);
+
+
+	event_init(&leader, 0x1001e);
+	event_leader_ebb_init(&leader);
+	leader.attr.exclusive = 0;
+	/* Expected to fail, leader isn't exclusive */
+	FAIL_IF(event_open(&leader) == 0);
+
+
+	event_init(&leader, 0x1001e);
+	event_leader_ebb_init(&leader);
+	leader.attr.pinned = 0;
+	/* Expected to fail, leader isn't pinned */
+	FAIL_IF(event_open(&leader) == 0);
+
+	event_init(&event, 0x1001e);
+	event_leader_ebb_init(&event);
+	/* Expected to fail, not a task event */
+	SKIP_IF(require_paranoia_below(1));
+	FAIL_IF(event_open_with_cpu(&event, 0) == 0);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(event_attributes, "event_attributes");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fixed_instruction_loop.S b/tools/testing/selftests/powerpc/pmu/ebb/fixed_instruction_loop.S
new file mode 100644
index 0000000..b866a05
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/fixed_instruction_loop.S
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <ppc-asm.h>
+
+	.text
+
+FUNC_START(thirty_two_instruction_loop)
+	cmpwi	r3,0
+	beqlr
+	addi	r4,r3,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1	# 28 addi's
+	subi	r3,r3,1
+	b	FUNC_NAME(thirty_two_instruction_loop)
+FUNC_END(thirty_two_instruction_loop)
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
new file mode 100644
index 0000000..9e7af6e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <setjmp.h>
+#include <signal.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test that a fork clears the PMU state of the child. eg. BESCR/EBBHR/EBBRR
+ * are cleared, and MMCR0_PMCC is reset, preventing the child from accessing
+ * the PMU.
+ */
+
+static struct event event;
+
+static int child(void)
+{
+	/* Even though we have EBE=0 we can still see the EBB regs */
+	FAIL_IF(mfspr(SPRN_BESCR) != 0);
+	FAIL_IF(mfspr(SPRN_EBBHR) != 0);
+	FAIL_IF(mfspr(SPRN_EBBRR) != 0);
+
+	FAIL_IF(catch_sigill(write_pmc1));
+
+	/* We can still read from the event, though it is on our parent */
+	FAIL_IF(event_read(&event));
+
+	return 0;
+}
+
+/* Tests that fork clears EBB state */
+int fork_cleanup(void)
+{
+	pid_t pid;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	FAIL_IF(event_open(&event));
+
+	ebb_enable_pmc_counting(1);
+	setup_ebb_handler(standard_ebb_callee);
+	ebb_global_enable();
+
+	FAIL_IF(ebb_event_enable(&event));
+
+	mtspr(SPRN_MMCR0, MMCR0_FC);
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	/* Don't need to actually take any EBBs */
+
+	pid = fork();
+	if (pid == 0)
+		exit(child());
+
+	/* Child does the actual testing */
+	FAIL_IF(wait_for_child(pid));
+
+	/* After fork */
+	event_close(&event);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(fork_cleanup, "fork_cleanup");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
new file mode 100644
index 0000000..f8190fa
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
@@ -0,0 +1,164 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#define _GNU_SOURCE
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/prctl.h>
+
+#include "ebb.h"
+
+
+/*
+ * Run a calibrated instruction loop and count instructions executed using
+ * EBBs. Make sure the counts look right.
+ */
+
+extern void thirty_two_instruction_loop(uint64_t loops);
+
+static bool counters_frozen = true;
+
+static int do_count_loop(struct event *event, uint64_t instructions,
+			 uint64_t overhead, bool report)
+{
+	int64_t difference, expected;
+	double percentage;
+
+	clear_ebb_stats();
+
+	counters_frozen = false;
+	mb();
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_FC);
+
+	thirty_two_instruction_loop(instructions >> 5);
+
+	counters_frozen = true;
+	mb();
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) | MMCR0_FC);
+
+	count_pmc(4, sample_period);
+
+	event->result.value = ebb_state.stats.pmc_count[4-1];
+	expected = instructions + overhead;
+	difference = event->result.value - expected;
+	percentage = (double)difference / event->result.value * 100;
+
+	if (report) {
+		printf("Looped for %lu instructions, overhead %lu\n", instructions, overhead);
+		printf("Expected %lu\n", expected);
+		printf("Actual   %llu\n", event->result.value);
+		printf("Error    %ld, %f%%\n", difference, percentage);
+		printf("Took %d EBBs\n", ebb_state.stats.ebb_count);
+	}
+
+	if (difference < 0)
+		difference = -difference;
+
+	/* Tolerate a difference of up to 0.0001 % */
+	difference *= 10000 * 100;
+	if (difference / event->result.value)
+		return -1;
+
+	return 0;
+}
+
+/* Count how many instructions it takes to do a null loop */
+static uint64_t determine_overhead(struct event *event)
+{
+	uint64_t current, overhead;
+	int i;
+
+	do_count_loop(event, 0, 0, false);
+	overhead = event->result.value;
+
+	for (i = 0; i < 100; i++) {
+		do_count_loop(event, 0, 0, false);
+		current = event->result.value;
+		if (current < overhead) {
+			printf("Replacing overhead %lu with %lu\n", overhead, current);
+			overhead = current;
+		}
+	}
+
+	return overhead;
+}
+
+static void pmc4_ebb_callee(void)
+{
+	uint64_t val;
+
+	val = mfspr(SPRN_BESCR);
+	if (!(val & BESCR_PMEO)) {
+		ebb_state.stats.spurious++;
+		goto out;
+	}
+
+	ebb_state.stats.ebb_count++;
+	count_pmc(4, sample_period);
+out:
+	if (counters_frozen)
+		reset_ebb_with_clear_mask(MMCR0_PMAO);
+	else
+		reset_ebb();
+}
+
+int instruction_count(void)
+{
+	struct event event;
+	uint64_t overhead;
+
+	event_init_named(&event, 0x400FA, "PM_RUN_INST_CMPL");
+	event_leader_ebb_init(&event);
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+	FAIL_IF(ebb_event_enable(&event));
+
+	sample_period = COUNTER_OVERFLOW;
+
+	setup_ebb_handler(pmc4_ebb_callee);
+	mtspr(SPRN_MMCR0, mfspr(SPRN_MMCR0) & ~MMCR0_FC);
+	ebb_global_enable();
+
+	overhead = determine_overhead(&event);
+	printf("Overhead of null loop: %lu instructions\n", overhead);
+
+	/* Run for 1M instructions */
+	FAIL_IF(do_count_loop(&event, 0x100000, overhead, true));
+
+	/* Run for 10M instructions */
+	FAIL_IF(do_count_loop(&event, 0xa00000, overhead, true));
+
+	/* Run for 100M instructions */
+	FAIL_IF(do_count_loop(&event, 0x6400000, overhead, true));
+
+	/* Run for 1G instructions */
+	FAIL_IF(do_count_loop(&event, 0x40000000, overhead, true));
+
+	/* Run for 16G instructions */
+	FAIL_IF(do_count_loop(&event, 0x400000000, overhead, true));
+
+	/* Run for 64G instructions */
+	FAIL_IF(do_count_loop(&event, 0x1000000000, overhead, true));
+
+	/* Run for 128G instructions */
+	FAIL_IF(do_count_loop(&event, 0x2000000000, overhead, true));
+
+	ebb_global_disable();
+	event_close(&event);
+
+	printf("Finished OK\n");
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(instruction_count, "instruction_count");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
new file mode 100644
index 0000000..0c9dd9b
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test that tries to trigger CPU_FTR_PMAO_BUG. Which is a hardware defect
+ * where an exception triggers but we context switch before it is delivered and
+ * lose the exception.
+ */
+
+static int test_body(void)
+{
+	int i, orig_period, max_period;
+	struct event event;
+
+	/* We use PMC4 to make sure the kernel switches all counters correctly */
+	event_init_named(&event, 0x40002, "instructions");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	ebb_enable_pmc_counting(4);
+	setup_ebb_handler(standard_ebb_callee);
+	ebb_global_enable();
+	FAIL_IF(ebb_event_enable(&event));
+
+	/*
+	 * We want a low sample period, but we also want to get out of the EBB
+	 * handler without tripping up again.
+	 *
+	 * This value picked after much experimentation.
+	 */
+	orig_period = max_period = sample_period = 400;
+
+	mtspr(SPRN_PMC4, pmc_sample_period(sample_period));
+
+	while (ebb_state.stats.ebb_count < 1000000) {
+		/*
+		 * We are trying to get the EBB exception to race exactly with
+		 * us entering the kernel to do the syscall. We then need the
+		 * kernel to decide our timeslice is up and context switch to
+		 * the other thread. When we come back our EBB will have been
+		 * lost and we'll spin in this while loop forever.
+		 */
+
+		for (i = 0; i < 100000; i++)
+			sched_yield();
+
+		/* Change the sample period slightly to try and hit the race */
+		if (sample_period >= (orig_period + 200))
+			sample_period = orig_period;
+		else
+			sample_period++;
+
+		if (sample_period > max_period)
+			max_period = sample_period;
+	}
+
+	ebb_freeze_pmcs();
+	ebb_global_disable();
+
+	count_pmc(4, sample_period);
+	mtspr(SPRN_PMC4, 0xdead);
+
+	dump_summary_ebb_state();
+	dump_ebb_hw_state();
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+
+	/* We vary our sample period so we need extra fudge here */
+	FAIL_IF(!ebb_check_count(4, orig_period, 2 * (max_period - orig_period)));
+
+	return 0;
+}
+
+static int lost_exception(void)
+{
+	return eat_cpu(test_body);
+}
+
+int main(void)
+{
+	return test_harness(lost_exception, "lost_exception");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c b/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
new file mode 100644
index 0000000..67d78af
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/ioctl.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test counting multiple events using EBBs.
+ */
+int multi_counter(void)
+{
+	struct event events[6];
+	int i, group_fd;
+
+	event_init_named(&events[0], 0x1001C, "PM_CMPLU_STALL_THRD");
+	event_init_named(&events[1], 0x2D016, "PM_CMPLU_STALL_FXU");
+	event_init_named(&events[2], 0x30006, "PM_CMPLU_STALL_OTHER_CMPL");
+	event_init_named(&events[3], 0x4000A, "PM_CMPLU_STALL");
+	event_init_named(&events[4], 0x600f4, "PM_RUN_CYC");
+	event_init_named(&events[5], 0x500fa, "PM_RUN_INST_CMPL");
+
+	event_leader_ebb_init(&events[0]);
+	for (i = 1; i < 6; i++)
+		event_ebb_init(&events[i]);
+
+	group_fd = -1;
+	for (i = 0; i < 6; i++) {
+		events[i].attr.exclude_kernel = 1;
+		events[i].attr.exclude_hv = 1;
+		events[i].attr.exclude_idle = 1;
+
+		FAIL_IF(event_open_with_group(&events[i], group_fd));
+		if (group_fd == -1)
+			group_fd = events[0].fd;
+	}
+
+	ebb_enable_pmc_counting(1);
+	ebb_enable_pmc_counting(2);
+	ebb_enable_pmc_counting(3);
+	ebb_enable_pmc_counting(4);
+	ebb_enable_pmc_counting(5);
+	ebb_enable_pmc_counting(6);
+	setup_ebb_handler(standard_ebb_callee);
+
+	FAIL_IF(ioctl(events[0].fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP));
+	FAIL_IF(event_read(&events[0]));
+
+	ebb_global_enable();
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+	mtspr(SPRN_PMC2, pmc_sample_period(sample_period));
+	mtspr(SPRN_PMC3, pmc_sample_period(sample_period));
+	mtspr(SPRN_PMC4, pmc_sample_period(sample_period));
+	mtspr(SPRN_PMC5, pmc_sample_period(sample_period));
+	mtspr(SPRN_PMC6, pmc_sample_period(sample_period));
+
+	while (ebb_state.stats.ebb_count < 50) {
+		FAIL_IF(core_busy_loop());
+		FAIL_IF(ebb_check_mmcr0());
+	}
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+	count_pmc(2, sample_period);
+	count_pmc(3, sample_period);
+	count_pmc(4, sample_period);
+	count_pmc(5, sample_period);
+	count_pmc(6, sample_period);
+
+	dump_ebb_state();
+
+	for (i = 0; i < 6; i++)
+		event_close(&events[i]);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(multi_counter, "multi_counter");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c b/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
new file mode 100644
index 0000000..b8dc371
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
@@ -0,0 +1,109 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test running multiple EBB using processes at once on a single CPU. They
+ * should all run happily without interfering with each other.
+ */
+
+static bool child_should_exit;
+
+static void sigint_handler(int signal)
+{
+	child_should_exit = true;
+}
+
+struct sigaction sigint_action = {
+	.sa_handler = sigint_handler,
+};
+
+static int cycles_child(void)
+{
+	struct event event;
+
+	if (sigaction(SIGINT, &sigint_action, NULL)) {
+		perror("sigaction");
+		return 1;
+	}
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	ebb_enable_pmc_counting(1);
+	setup_ebb_handler(standard_ebb_callee);
+	ebb_global_enable();
+
+	FAIL_IF(ebb_event_enable(&event));
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	while (!child_should_exit) {
+		FAIL_IF(core_busy_loop());
+		FAIL_IF(ebb_check_mmcr0());
+	}
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+
+	dump_summary_ebb_state();
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+
+	return 0;
+}
+
+#define NR_CHILDREN	4
+
+int multi_ebb_procs(void)
+{
+	pid_t pids[NR_CHILDREN];
+	int cpu, rc, i;
+
+	cpu = pick_online_cpu();
+	FAIL_IF(cpu < 0);
+	FAIL_IF(bind_to_cpu(cpu));
+
+	for (i = 0; i < NR_CHILDREN; i++) {
+		pids[i] = fork();
+		if (pids[i] == 0)
+			exit(cycles_child());
+	}
+
+	/* Have them all run for "a while" */
+	sleep(10);
+
+	rc = 0;
+	for (i = 0; i < NR_CHILDREN; i++) {
+		/* Tell them to stop */
+		kill(pids[i], SIGINT);
+		/* And wait */
+		rc |= wait_for_child(pids[i]);
+	}
+
+	return rc;
+}
+
+int main(void)
+{
+	return test_harness(multi_ebb_procs, "multi_ebb_procs");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c b/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
new file mode 100644
index 0000000..2f9bf8e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
@@ -0,0 +1,61 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <signal.h>
+
+#include "ebb.h"
+
+
+/* Test that things work sanely if we have no handler */
+
+static int no_handler_test(void)
+{
+	struct event event;
+	u64 val;
+	int i;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+	FAIL_IF(ebb_event_enable(&event));
+
+	val = mfspr(SPRN_EBBHR);
+	FAIL_IF(val != 0);
+
+	/* Make sure it overflows quickly */
+	sample_period = 1000;
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	/* Spin to make sure the event has time to overflow */
+	for (i = 0; i < 1000; i++)
+		mb();
+
+	dump_ebb_state();
+
+	/* We expect to see the PMU frozen & PMAO set */
+	val = mfspr(SPRN_MMCR0);
+	FAIL_IF(val != 0x0000000080000080);
+
+	event_close(&event);
+
+	dump_ebb_state();
+
+	/* The real test is that we never took an EBB at 0x0 */
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(no_handler_test,"no_handler_test");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c b/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
new file mode 100644
index 0000000..986500f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
@@ -0,0 +1,106 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test that the kernel properly handles PMAE across context switches.
+ *
+ * We test this by calling into the kernel inside our EBB handler, where PMAE
+ * is clear. A cpu eater companion thread is running on the same CPU as us to
+ * encourage the scheduler to switch us.
+ *
+ * The kernel must make sure that when it context switches us back in, it
+ * honours the fact that we had PMAE clear.
+ *
+ * Observed to hit the failing case on the first EBB with a broken kernel.
+ */
+
+static bool mmcr0_mismatch;
+static uint64_t before, after;
+
+static void syscall_ebb_callee(void)
+{
+	uint64_t val;
+
+	val = mfspr(SPRN_BESCR);
+	if (!(val & BESCR_PMEO)) {
+		ebb_state.stats.spurious++;
+		goto out;
+	}
+
+	ebb_state.stats.ebb_count++;
+	count_pmc(1, sample_period);
+
+	before = mfspr(SPRN_MMCR0);
+
+	/* Try and get ourselves scheduled, to force a PMU context switch */
+	sched_yield();
+
+	after = mfspr(SPRN_MMCR0);
+	if (before != after)
+		mmcr0_mismatch = true;
+
+out:
+	reset_ebb();
+}
+
+static int test_body(void)
+{
+	struct event event;
+
+	event_init_named(&event, 0x1001e, "cycles");
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	setup_ebb_handler(syscall_ebb_callee);
+	ebb_global_enable();
+
+	FAIL_IF(ebb_event_enable(&event));
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+
+	while (ebb_state.stats.ebb_count < 20 && !mmcr0_mismatch)
+		FAIL_IF(core_busy_loop());
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(1, sample_period);
+
+	dump_ebb_state();
+
+	if (mmcr0_mismatch)
+		printf("Saw MMCR0 before 0x%lx after 0x%lx\n", before, after);
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0);
+	FAIL_IF(mmcr0_mismatch);
+
+	return 0;
+}
+
+int pmae_handling(void)
+{
+	return eat_cpu(test_body);
+}
+
+int main(void)
+{
+	return test_harness(pmae_handling, "pmae_handling");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c b/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
new file mode 100644
index 0000000..a503fa7
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
@@ -0,0 +1,93 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "ebb.h"
+
+
+/*
+ * Test that PMC5 & 6 are frozen (ie. don't overflow) when they are not being
+ * used. Tests the MMCR0_FC56 logic in the kernel.
+ */
+
+static int pmc56_overflowed;
+
+static void ebb_callee(void)
+{
+	uint64_t val;
+
+	val = mfspr(SPRN_BESCR);
+	if (!(val & BESCR_PMEO)) {
+		ebb_state.stats.spurious++;
+		goto out;
+	}
+
+	ebb_state.stats.ebb_count++;
+	count_pmc(2, sample_period);
+
+	val = mfspr(SPRN_PMC5);
+	if (val >= COUNTER_OVERFLOW)
+		pmc56_overflowed++;
+
+	count_pmc(5, COUNTER_OVERFLOW);
+
+	val = mfspr(SPRN_PMC6);
+	if (val >= COUNTER_OVERFLOW)
+		pmc56_overflowed++;
+
+	count_pmc(6, COUNTER_OVERFLOW);
+
+out:
+	reset_ebb();
+}
+
+int pmc56_overflow(void)
+{
+	struct event event;
+
+	/* Use PMC2 so we set PMCjCE, which enables PMC5/6 */
+	event_init(&event, 0x2001e);
+	event_leader_ebb_init(&event);
+
+	event.attr.exclude_kernel = 1;
+	event.attr.exclude_hv = 1;
+	event.attr.exclude_idle = 1;
+
+	FAIL_IF(event_open(&event));
+
+	setup_ebb_handler(ebb_callee);
+	ebb_global_enable();
+
+	FAIL_IF(ebb_event_enable(&event));
+
+	mtspr(SPRN_PMC1, pmc_sample_period(sample_period));
+	mtspr(SPRN_PMC5, 0);
+	mtspr(SPRN_PMC6, 0);
+
+	while (ebb_state.stats.ebb_count < 10)
+		FAIL_IF(core_busy_loop());
+
+	ebb_global_disable();
+	ebb_freeze_pmcs();
+
+	count_pmc(2, sample_period);
+
+	dump_ebb_state();
+
+	printf("PMC5/6 overflow %d\n", pmc56_overflowed);
+
+	event_close(&event);
+
+	FAIL_IF(ebb_state.stats.ebb_count == 0 || pmc56_overflowed != 0);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(pmc56_overflow, "pmc56_overflow");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/reg.h b/tools/testing/selftests/powerpc/pmu/ebb/reg.h
new file mode 100644
index 0000000..5921b0d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/reg.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#ifndef _SELFTESTS_POWERPC_REG_H
+#define _SELFTESTS_POWERPC_REG_H
+
+#define __stringify_1(x)        #x
+#define __stringify(x)          __stringify_1(x)
+
+#define mfspr(rn)       ({unsigned long rval; \
+                         asm volatile("mfspr %0," __stringify(rn) \
+                                 : "=r" (rval)); rval; })
+#define mtspr(rn, v)    asm volatile("mtspr " __stringify(rn) ",%0" : \
+                                    : "r" ((unsigned long)(v)) \
+                                    : "memory")
+
+#define mb()		asm volatile("sync" : : : "memory");
+
+#define SPRN_MMCR2     769
+#define SPRN_MMCRA     770
+#define SPRN_MMCR0     779
+#define   MMCR0_PMAO   0x00000080
+#define   MMCR0_PMAE   0x04000000
+#define   MMCR0_FC     0x80000000
+#define SPRN_EBBHR     804
+#define SPRN_EBBRR     805
+#define SPRN_BESCR     806     /* Branch event status & control register */
+#define SPRN_BESCRS    800     /* Branch event status & control set (1 bits set to 1) */
+#define SPRN_BESCRSU   801     /* Branch event status & control set upper */
+#define SPRN_BESCRR    802     /* Branch event status & control REset (1 bits set to 0) */
+#define SPRN_BESCRRU   803     /* Branch event status & control REset upper */
+
+#define BESCR_PMEO     0x1     /* PMU Event-based exception Occurred */
+#define BESCR_PME      (0x1ul << 32) /* PMU Event-based exception Enable */
+
+#define SPRN_PMC1      771
+#define SPRN_PMC2      772
+#define SPRN_PMC3      773
+#define SPRN_PMC4      774
+#define SPRN_PMC5      775
+#define SPRN_PMC6      776
+
+#define SPRN_SIAR      780
+#define SPRN_SDAR      781
+#define SPRN_SIER      768
+
+#endif /* _SELFTESTS_POWERPC_REG_H */
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c b/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
new file mode 100644
index 0000000..0cae66f
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
@@ -0,0 +1,39 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "ebb.h"
+#include "reg.h"
+
+
+/*
+ * Test basic access to the EBB regs, they should be user accessible with no
+ * kernel interaction required.
+ */
+int reg_access(void)
+{
+	uint64_t val, expected;
+
+	expected = 0x8000000100000000ull;
+	mtspr(SPRN_BESCR, expected);
+	val = mfspr(SPRN_BESCR);
+
+	FAIL_IF(val != expected);
+
+	expected = 0x0000000001000000ull;
+	mtspr(SPRN_EBBHR, expected);
+	val = mfspr(SPRN_EBBHR);
+
+	FAIL_IF(val != expected);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(reg_access, "reg_access");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c b/tools/testing/selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c
new file mode 100644
index 0000000..d56607e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c
@@ -0,0 +1,91 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "ebb.h"
+
+
+/*
+ * Tests a pinned per-task event vs an EBB - in that order. The pinned per-task
+ * event should prevent the EBB event from being enabled.
+ */
+
+static int setup_child_event(struct event *event, pid_t child_pid)
+{
+	event_init_named(event, 0x400FA, "PM_RUN_INST_CMPL");
+
+	event->attr.pinned = 1;
+
+	event->attr.exclude_kernel = 1;
+	event->attr.exclude_hv = 1;
+	event->attr.exclude_idle = 1;
+
+	FAIL_IF(event_open_with_pid(event, child_pid));
+	FAIL_IF(event_enable(event));
+
+	return 0;
+}
+
+int task_event_pinned_vs_ebb(void)
+{
+	union pipe read_pipe, write_pipe;
+	struct event event;
+	pid_t pid;
+	int rc;
+
+	FAIL_IF(pipe(read_pipe.fds) == -1);
+	FAIL_IF(pipe(write_pipe.fds) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		/* NB order of pipes looks reversed */
+		exit(ebb_child(write_pipe, read_pipe));
+	}
+
+	/* We setup the task event first */
+	rc = setup_child_event(&event, pid);
+	if (rc) {
+		kill_child_and_wait(pid);
+		return rc;
+	}
+
+	/* Signal the child to install its EBB event and wait */
+	if (sync_with_child(read_pipe, write_pipe))
+		/* If it fails, wait for it to exit */
+		goto wait;
+
+	/* Signal the child to run */
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+wait:
+	/* We expect it to fail to read the event */
+	FAIL_IF(wait_for_child(pid) != 2);
+	FAIL_IF(event_disable(&event));
+	FAIL_IF(event_read(&event));
+
+	event_report(&event);
+
+	FAIL_IF(event.result.value == 0);
+	/*
+	 * For reasons I don't understand enabled is usually just slightly
+	 * lower than running. Would be good to confirm why.
+	 */
+	FAIL_IF(event.result.enabled == 0);
+	FAIL_IF(event.result.running == 0);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(task_event_pinned_vs_ebb, "task_event_pinned_vs_ebb");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c b/tools/testing/selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c
new file mode 100644
index 0000000..eba3219
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c
@@ -0,0 +1,83 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "ebb.h"
+
+
+/*
+ * Tests a per-task event vs an EBB - in that order. The EBB should push the
+ * per-task event off the PMU.
+ */
+
+static int setup_child_event(struct event *event, pid_t child_pid)
+{
+	event_init_named(event, 0x400FA, "PM_RUN_INST_CMPL");
+
+	event->attr.exclude_kernel = 1;
+	event->attr.exclude_hv = 1;
+	event->attr.exclude_idle = 1;
+
+	FAIL_IF(event_open_with_pid(event, child_pid));
+	FAIL_IF(event_enable(event));
+
+	return 0;
+}
+
+int task_event_vs_ebb(void)
+{
+	union pipe read_pipe, write_pipe;
+	struct event event;
+	pid_t pid;
+	int rc;
+
+	FAIL_IF(pipe(read_pipe.fds) == -1);
+	FAIL_IF(pipe(write_pipe.fds) == -1);
+
+	pid = fork();
+	if (pid == 0) {
+		/* NB order of pipes looks reversed */
+		exit(ebb_child(write_pipe, read_pipe));
+	}
+
+	/* We setup the task event first */
+	rc = setup_child_event(&event, pid);
+	if (rc) {
+		kill_child_and_wait(pid);
+		return rc;
+	}
+
+	/* Signal the child to install its EBB event and wait */
+	if (sync_with_child(read_pipe, write_pipe))
+		/* If it fails, wait for it to exit */
+		goto wait;
+
+	/* Signal the child to run */
+	FAIL_IF(sync_with_child(read_pipe, write_pipe));
+
+wait:
+	/* The EBB event should push the task event off so the child should succeed */
+	FAIL_IF(wait_for_child(pid));
+	FAIL_IF(event_disable(&event));
+	FAIL_IF(event_read(&event));
+
+	event_report(&event);
+
+	/* The task event may have run, or not so we can't assert anything about it */
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(task_event_vs_ebb, "task_event_vs_ebb");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/trace.c b/tools/testing/selftests/powerpc/pmu/ebb/trace.c
new file mode 100644
index 0000000..251e66a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/trace.c
@@ -0,0 +1,300 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+
+#include "trace.h"
+
+
+struct trace_buffer *trace_buffer_allocate(u64 size)
+{
+	struct trace_buffer *tb;
+
+	if (size < sizeof(*tb)) {
+		fprintf(stderr, "Error: trace buffer too small\n");
+		return NULL;
+	}
+
+	tb = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		  MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (tb == MAP_FAILED) {
+		perror("mmap");
+		return NULL;
+	}
+
+	tb->size = size;
+	tb->tail = tb->data;
+	tb->overflow = false;
+
+	return tb;
+}
+
+static bool trace_check_bounds(struct trace_buffer *tb, void *p)
+{
+	return p < ((void *)tb + tb->size);
+}
+
+static bool trace_check_alloc(struct trace_buffer *tb, void *p)
+{
+	/*
+	 * If we ever overflowed don't allow any more input. This prevents us
+	 * from dropping a large item and then later logging a small one. The
+	 * buffer should just stop when overflow happened, not be patchy. If
+	 * you're overflowing, make your buffer bigger.
+	 */
+	if (tb->overflow)
+		return false;
+
+	if (!trace_check_bounds(tb, p)) {
+		tb->overflow = true;
+		return false;
+	}
+
+	return true;
+}
+
+static void *trace_alloc(struct trace_buffer *tb, int bytes)
+{
+	void *p, *newtail;
+
+	p = tb->tail;
+	newtail = tb->tail + bytes;
+	if (!trace_check_alloc(tb, newtail))
+		return NULL;
+
+	tb->tail = newtail;
+
+	return p;
+}
+
+static struct trace_entry *trace_alloc_entry(struct trace_buffer *tb, int payload_size)
+{
+	struct trace_entry *e;
+
+	e = trace_alloc(tb, sizeof(*e) + payload_size);
+	if (e)
+		e->length = payload_size;
+
+	return e;
+}
+
+int trace_log_reg(struct trace_buffer *tb, u64 reg, u64 value)
+{
+	struct trace_entry *e;
+	u64 *p;
+
+	e = trace_alloc_entry(tb, sizeof(reg) + sizeof(value));
+	if (!e)
+		return -ENOSPC;
+
+	e->type = TRACE_TYPE_REG;
+	p = (u64 *)e->data;
+	*p++ = reg;
+	*p++ = value;
+
+	return 0;
+}
+
+int trace_log_counter(struct trace_buffer *tb, u64 value)
+{
+	struct trace_entry *e;
+	u64 *p;
+
+	e = trace_alloc_entry(tb, sizeof(value));
+	if (!e)
+		return -ENOSPC;
+
+	e->type = TRACE_TYPE_COUNTER;
+	p = (u64 *)e->data;
+	*p++ = value;
+
+	return 0;
+}
+
+int trace_log_string(struct trace_buffer *tb, char *str)
+{
+	struct trace_entry *e;
+	char *p;
+	int len;
+
+	len = strlen(str);
+
+	/* We NULL terminate to make printing easier */
+	e = trace_alloc_entry(tb, len + 1);
+	if (!e)
+		return -ENOSPC;
+
+	e->type = TRACE_TYPE_STRING;
+	p = (char *)e->data;
+	memcpy(p, str, len);
+	p += len;
+	*p = '\0';
+
+	return 0;
+}
+
+int trace_log_indent(struct trace_buffer *tb)
+{
+	struct trace_entry *e;
+
+	e = trace_alloc_entry(tb, 0);
+	if (!e)
+		return -ENOSPC;
+
+	e->type = TRACE_TYPE_INDENT;
+
+	return 0;
+}
+
+int trace_log_outdent(struct trace_buffer *tb)
+{
+	struct trace_entry *e;
+
+	e = trace_alloc_entry(tb, 0);
+	if (!e)
+		return -ENOSPC;
+
+	e->type = TRACE_TYPE_OUTDENT;
+
+	return 0;
+}
+
+static void trace_print_header(int seq, int prefix)
+{
+	printf("%*s[%d]: ", prefix, "", seq);
+}
+
+static char *trace_decode_reg(int reg)
+{
+	switch (reg) {
+		case 769: return "SPRN_MMCR2"; break;
+		case 770: return "SPRN_MMCRA"; break;
+		case 779: return "SPRN_MMCR0"; break;
+		case 804: return "SPRN_EBBHR"; break;
+		case 805: return "SPRN_EBBRR"; break;
+		case 806: return "SPRN_BESCR"; break;
+		case 800: return "SPRN_BESCRS"; break;
+		case 801: return "SPRN_BESCRSU"; break;
+		case 802: return "SPRN_BESCRR"; break;
+		case 803: return "SPRN_BESCRRU"; break;
+		case 771: return "SPRN_PMC1"; break;
+		case 772: return "SPRN_PMC2"; break;
+		case 773: return "SPRN_PMC3"; break;
+		case 774: return "SPRN_PMC4"; break;
+		case 775: return "SPRN_PMC5"; break;
+		case 776: return "SPRN_PMC6"; break;
+		case 780: return "SPRN_SIAR"; break;
+		case 781: return "SPRN_SDAR"; break;
+		case 768: return "SPRN_SIER"; break;
+	}
+
+	return NULL;
+}
+
+static void trace_print_reg(struct trace_entry *e)
+{
+	u64 *p, *reg, *value;
+	char *name;
+
+	p = (u64 *)e->data;
+	reg = p++;
+	value = p;
+
+	name = trace_decode_reg(*reg);
+	if (name)
+		printf("register %-10s = 0x%016llx\n", name, *value);
+	else
+		printf("register %lld = 0x%016llx\n", *reg, *value);
+}
+
+static void trace_print_counter(struct trace_entry *e)
+{
+	u64 *value;
+
+	value = (u64 *)e->data;
+	printf("counter = %lld\n", *value);
+}
+
+static void trace_print_string(struct trace_entry *e)
+{
+	char *str;
+
+	str = (char *)e->data;
+	puts(str);
+}
+
+#define BASE_PREFIX	2
+#define PREFIX_DELTA	8
+
+static void trace_print_entry(struct trace_entry *e, int seq, int *prefix)
+{
+	switch (e->type) {
+	case TRACE_TYPE_REG:
+		trace_print_header(seq, *prefix);
+		trace_print_reg(e);
+		break;
+	case TRACE_TYPE_COUNTER:
+		trace_print_header(seq, *prefix);
+		trace_print_counter(e);
+		break;
+	case TRACE_TYPE_STRING:
+		trace_print_header(seq, *prefix);
+		trace_print_string(e);
+		break;
+	case TRACE_TYPE_INDENT:
+		trace_print_header(seq, *prefix);
+		puts("{");
+		*prefix += PREFIX_DELTA;
+		break;
+	case TRACE_TYPE_OUTDENT:
+		*prefix -= PREFIX_DELTA;
+		if (*prefix < BASE_PREFIX)
+			*prefix = BASE_PREFIX;
+		trace_print_header(seq, *prefix);
+		puts("}");
+		break;
+	default:
+		trace_print_header(seq, *prefix);
+		printf("entry @ %p type %d\n", e, e->type);
+		break;
+	}
+}
+
+void trace_buffer_print(struct trace_buffer *tb)
+{
+	struct trace_entry *e;
+	int i, prefix;
+	void *p;
+
+	printf("Trace buffer dump:\n");
+	printf("  address  %p \n", tb);
+	printf("  tail     %p\n", tb->tail);
+	printf("  size     %llu\n", tb->size);
+	printf("  overflow %s\n", tb->overflow ? "TRUE" : "false");
+	printf("  Content:\n");
+
+	p = tb->data;
+
+	i = 0;
+	prefix = BASE_PREFIX;
+
+	while (trace_check_bounds(tb, p) && p < tb->tail) {
+		e = p;
+
+		trace_print_entry(e, i, &prefix);
+
+		i++;
+		p = (void *)e + sizeof(*e) + e->length;
+	}
+}
+
+void trace_print_location(struct trace_buffer *tb)
+{
+	printf("Trace buffer 0x%llx bytes @ %p\n", tb->size, tb);
+}
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/trace.h b/tools/testing/selftests/powerpc/pmu/ebb/trace.h
new file mode 100644
index 0000000..926458e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/ebb/trace.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#ifndef _SELFTESTS_POWERPC_PMU_EBB_TRACE_H
+#define _SELFTESTS_POWERPC_PMU_EBB_TRACE_H
+
+#include "utils.h"
+
+#define TRACE_TYPE_REG		1
+#define TRACE_TYPE_COUNTER	2
+#define TRACE_TYPE_STRING	3
+#define TRACE_TYPE_INDENT	4
+#define TRACE_TYPE_OUTDENT	5
+
+struct trace_entry
+{
+	u8 type;
+	u8 length;
+	u8 data[0];
+};
+
+struct trace_buffer
+{
+	u64  size;
+	bool overflow;
+	void *tail;
+	u8   data[0];
+};
+
+struct trace_buffer *trace_buffer_allocate(u64 size);
+int trace_log_reg(struct trace_buffer *tb, u64 reg, u64 value);
+int trace_log_counter(struct trace_buffer *tb, u64 value);
+int trace_log_string(struct trace_buffer *tb, char *str);
+int trace_log_indent(struct trace_buffer *tb);
+int trace_log_outdent(struct trace_buffer *tb);
+void trace_buffer_print(struct trace_buffer *tb);
+void trace_print_location(struct trace_buffer *tb);
+
+#endif /* _SELFTESTS_POWERPC_PMU_EBB_TRACE_H */
diff --git a/tools/testing/selftests/powerpc/pmu/event.c b/tools/testing/selftests/powerpc/pmu/event.c
index 2b2d11d..184b368 100644
--- a/tools/testing/selftests/powerpc/pmu/event.c
+++ b/tools/testing/selftests/powerpc/pmu/event.c
@@ -39,7 +39,13 @@ void event_init_named(struct event *e, u64 config, char *name)
 	event_init_opts(e, config, PERF_TYPE_RAW, name);
 }
 
+void event_init(struct event *e, u64 config)
+{
+	event_init_opts(e, config, PERF_TYPE_RAW, "event");
+}
+
 #define PERF_CURRENT_PID	0
+#define PERF_NO_PID		-1
 #define PERF_NO_CPU		-1
 #define PERF_NO_GROUP		-1
 
@@ -59,6 +65,16 @@ int event_open_with_group(struct event *e, int group_fd)
 	return event_open_with_options(e, PERF_CURRENT_PID, PERF_NO_CPU, group_fd);
 }
 
+int event_open_with_pid(struct event *e, pid_t pid)
+{
+	return event_open_with_options(e, pid, PERF_NO_CPU, PERF_NO_GROUP);
+}
+
+int event_open_with_cpu(struct event *e, int cpu)
+{
+	return event_open_with_options(e, PERF_NO_PID, cpu, PERF_NO_GROUP);
+}
+
 int event_open(struct event *e)
 {
 	return event_open_with_options(e, PERF_CURRENT_PID, PERF_NO_CPU, PERF_NO_GROUP);
@@ -69,6 +85,16 @@ void event_close(struct event *e)
 	close(e->fd);
 }
 
+int event_enable(struct event *e)
+{
+	return ioctl(e->fd, PERF_EVENT_IOC_ENABLE);
+}
+
+int event_disable(struct event *e)
+{
+	return ioctl(e->fd, PERF_EVENT_IOC_DISABLE);
+}
+
 int event_reset(struct event *e)
 {
 	return ioctl(e->fd, PERF_EVENT_IOC_RESET);
diff --git a/tools/testing/selftests/powerpc/pmu/event.h b/tools/testing/selftests/powerpc/pmu/event.h
index e699319..a0ea6b1 100644
--- a/tools/testing/selftests/powerpc/pmu/event.h
+++ b/tools/testing/selftests/powerpc/pmu/event.h
@@ -29,8 +29,12 @@ void event_init_named(struct event *e, u64 config, char *name);
 void event_init_opts(struct event *e, u64 config, int type, char *name);
 int event_open_with_options(struct event *e, pid_t pid, int cpu, int group_fd);
 int event_open_with_group(struct event *e, int group_fd);
+int event_open_with_pid(struct event *e, pid_t pid);
+int event_open_with_cpu(struct event *e, int cpu);
 int event_open(struct event *e);
 void event_close(struct event *e);
+int event_enable(struct event *e);
+int event_disable(struct event *e);
 int event_reset(struct event *e);
 int event_read(struct event *e);
 void event_report_justified(struct event *e, int name_width, int result_width);
diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
new file mode 100644
index 0000000..0f6a473
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/lib.c
@@ -0,0 +1,252 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#define _GNU_SOURCE	/* For CPU_ZERO etc. */
+
+#include <errno.h>
+#include <sched.h>
+#include <setjmp.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#include "utils.h"
+#include "lib.h"
+
+
+int pick_online_cpu(void)
+{
+	cpu_set_t mask;
+	int cpu;
+
+	CPU_ZERO(&mask);
+
+	if (sched_getaffinity(0, sizeof(mask), &mask)) {
+		perror("sched_getaffinity");
+		return -1;
+	}
+
+	/* We prefer a primary thread, but skip 0 */
+	for (cpu = 8; cpu < CPU_SETSIZE; cpu += 8)
+		if (CPU_ISSET(cpu, &mask))
+			return cpu;
+
+	/* Search for anything, but in reverse */
+	for (cpu = CPU_SETSIZE - 1; cpu >= 0; cpu--)
+		if (CPU_ISSET(cpu, &mask))
+			return cpu;
+
+	printf("No cpus in affinity mask?!\n");
+	return -1;
+}
+
+int bind_to_cpu(int cpu)
+{
+	cpu_set_t mask;
+
+	printf("Binding to cpu %d\n", cpu);
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+
+	return sched_setaffinity(0, sizeof(mask), &mask);
+}
+
+#define PARENT_TOKEN	0xAA
+#define CHILD_TOKEN	0x55
+
+int sync_with_child(union pipe read_pipe, union pipe write_pipe)
+{
+	char c = PARENT_TOKEN;
+
+	FAIL_IF(write(write_pipe.write_fd, &c, 1) != 1);
+	FAIL_IF(read(read_pipe.read_fd, &c, 1) != 1);
+	if (c != CHILD_TOKEN) /* sometimes expected */
+		return 1;
+
+	return 0;
+}
+
+int wait_for_parent(union pipe read_pipe)
+{
+	char c;
+
+	FAIL_IF(read(read_pipe.read_fd, &c, 1) != 1);
+	FAIL_IF(c != PARENT_TOKEN);
+
+	return 0;
+}
+
+int notify_parent(union pipe write_pipe)
+{
+	char c = CHILD_TOKEN;
+
+	FAIL_IF(write(write_pipe.write_fd, &c, 1) != 1);
+
+	return 0;
+}
+
+int notify_parent_of_error(union pipe write_pipe)
+{
+	char c = ~CHILD_TOKEN;
+
+	FAIL_IF(write(write_pipe.write_fd, &c, 1) != 1);
+
+	return 0;
+}
+
+int wait_for_child(pid_t child_pid)
+{
+	int rc;
+
+	if (waitpid(child_pid, &rc, 0) == -1) {
+		perror("waitpid");
+		return 1;
+	}
+
+	if (WIFEXITED(rc))
+		rc = WEXITSTATUS(rc);
+	else
+		rc = 1; /* Signal or other */
+
+	return rc;
+}
+
+int kill_child_and_wait(pid_t child_pid)
+{
+	kill(child_pid, SIGTERM);
+
+	return wait_for_child(child_pid);
+}
+
+static int eat_cpu_child(union pipe read_pipe, union pipe write_pipe)
+{
+	volatile int i = 0;
+
+	/*
+	 * We are just here to eat cpu and die. So make sure we can be killed,
+	 * and also don't do any custom SIGTERM handling.
+	 */
+	signal(SIGTERM, SIG_DFL);
+
+	notify_parent(write_pipe);
+	wait_for_parent(read_pipe);
+
+	/* Soak up cpu forever */
+	while (1) i++;
+
+	return 0;
+}
+
+pid_t eat_cpu(int (test_function)(void))
+{
+	union pipe read_pipe, write_pipe;
+	int cpu, rc;
+	pid_t pid;
+
+	cpu = pick_online_cpu();
+	FAIL_IF(cpu < 0);
+	FAIL_IF(bind_to_cpu(cpu));
+
+	if (pipe(read_pipe.fds) == -1)
+		return -1;
+
+	if (pipe(write_pipe.fds) == -1)
+		return -1;
+
+	pid = fork();
+	if (pid == 0)
+		exit(eat_cpu_child(write_pipe, read_pipe));
+
+	if (sync_with_child(read_pipe, write_pipe)) {
+		rc = -1;
+		goto out;
+	}
+
+	printf("main test running as pid %d\n", getpid());
+
+	rc = test_function();
+out:
+	kill(pid, SIGKILL);
+
+	return rc;
+}
+
+struct addr_range libc, vdso;
+
+int parse_proc_maps(void)
+{
+	char execute, name[128];
+	uint64_t start, end;
+	FILE *f;
+	int rc;
+
+	f = fopen("/proc/self/maps", "r");
+	if (!f) {
+		perror("fopen");
+		return -1;
+	}
+
+	do {
+		/* This skips line with no executable which is what we want */
+		rc = fscanf(f, "%lx-%lx %*c%*c%c%*c %*x %*d:%*d %*d %127s\n",
+			    &start, &end, &execute, name);
+		if (rc <= 0)
+			break;
+
+		if (execute != 'x')
+			continue;
+
+		if (strstr(name, "libc")) {
+			libc.first = start;
+			libc.last = end - 1;
+		} else if (strstr(name, "[vdso]")) {
+			vdso.first = start;
+			vdso.last = end - 1;
+		}
+	} while(1);
+
+	fclose(f);
+
+	return 0;
+}
+
+#define PARANOID_PATH	"/proc/sys/kernel/perf_event_paranoid"
+
+bool require_paranoia_below(int level)
+{
+	unsigned long current;
+	char *end, buf[16];
+	FILE *f;
+	int rc;
+
+	rc = -1;
+
+	f = fopen(PARANOID_PATH, "r");
+	if (!f) {
+		perror("fopen");
+		goto out;
+	}
+
+	if (!fgets(buf, sizeof(buf), f)) {
+		printf("Couldn't read " PARANOID_PATH "?\n");
+		goto out_close;
+	}
+
+	current = strtoul(buf, &end, 10);
+
+	if (end == buf) {
+		printf("Couldn't parse " PARANOID_PATH "?\n");
+		goto out_close;
+	}
+
+	if (current >= level)
+		goto out;
+
+	rc = 0;
+out_close:
+	fclose(f);
+out:
+	return rc;
+}
diff --git a/tools/testing/selftests/powerpc/pmu/lib.h b/tools/testing/selftests/powerpc/pmu/lib.h
new file mode 100644
index 0000000..ca5d72a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/lib.h
@@ -0,0 +1,41 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#ifndef __SELFTESTS_POWERPC_PMU_LIB_H
+#define __SELFTESTS_POWERPC_PMU_LIB_H
+
+#include <stdio.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+
+union pipe {
+	struct {
+		int read_fd;
+		int write_fd;
+	};
+	int fds[2];
+};
+
+extern int pick_online_cpu(void);
+extern int bind_to_cpu(int cpu);
+extern int kill_child_and_wait(pid_t child_pid);
+extern int wait_for_child(pid_t child_pid);
+extern int sync_with_child(union pipe read_pipe, union pipe write_pipe);
+extern int wait_for_parent(union pipe read_pipe);
+extern int notify_parent(union pipe write_pipe);
+extern int notify_parent_of_error(union pipe write_pipe);
+extern pid_t eat_cpu(int (test_function)(void));
+extern bool require_paranoia_below(int level);
+
+struct addr_range {
+	uint64_t first, last;
+};
+
+extern struct addr_range libc, vdso;
+
+int parse_proc_maps(void);
+
+#endif /* __SELFTESTS_POWERPC_PMU_LIB_H */
-- 
1.9.1
