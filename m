Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 62E111A0680
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2015 21:24:43 +1100 (AEDT)
Received: from mail-lf0-f43.google.com (mail-lf0-f43.google.com
 [209.85.215.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3BF46140773
 for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2015 21:24:41 +1100 (AEDT)
Received: by lfaz124 with SMTP id z124so95170295lfa.1
 for <linuxppc-dev@ozlabs.org>; Sun, 18 Oct 2015 03:24:38 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org,
	Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH v2] selftests/powerpc: run eeb tests only on POWER8
Date: Sun, 18 Oct 2015 13:23:53 +0300
Message-Id: <1445163833-10320-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Event Based Branches currenly available on POWER8.
so we can skip them on other CPUs.

I've found that at least one test loops forever
on 970MP (cycles_with_freeze_test).

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

v2 changes:
 - use get_auxv_entry() helper to get supported features
---
 .../selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c        |  2 ++
 .../selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c        |  2 ++
 .../selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c  |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c         |  2 ++
 .../selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c       |  2 ++
 .../selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c        |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c                 | 11 +++++++++++
 tools/testing/selftests/powerpc/pmu/ebb/ebb.h                 |  1 +
 tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c   |  2 ++
 .../selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c     |  2 ++
 .../testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c |  2 ++
 .../testing/selftests/powerpc/pmu/ebb/event_attributes_test.c |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c   |  2 ++
 .../selftests/powerpc/pmu/ebb/instruction_count_test.c        |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c  |  2 ++
 .../testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c  |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c     |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c  |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c |  2 ++
 tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c     |  2 ++
 .../selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c |  2 ++
 .../selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c        |  2 ++
 23 files changed, 54 insertions(+)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c b/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
index 66ea765..94110b1 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/back_to_back_ebbs_test.c
@@ -63,6 +63,8 @@ int back_to_back_ebbs(void)
 {
 	struct event event;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x1001e, "cycles");
 	event_leader_ebb_init(&event);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c b/tools/testing/selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c
index 0f0423d..ac18cf6 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/close_clears_pmcc_test.c
@@ -20,6 +20,8 @@ int close_clears_pmcc(void)
 {
 	struct event event;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x1001e, "cycles");
 	event_leader_ebb_init(&event);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c
index d3ed64d..f0632e7 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cpu_event_pinned_vs_ebb_test.c
@@ -43,6 +43,8 @@ int cpu_event_pinned_vs_ebb(void)
 	int cpu, rc;
 	pid_t pid;
 
+	SKIP_IF(!ebb_is_supported());
+
 	cpu = pick_online_cpu();
 	FAIL_IF(cpu < 0);
 	FAIL_IF(bind_to_cpu(cpu));
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
index 8590fc1..7c57a8d 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_test.c
@@ -16,6 +16,8 @@ int cycles(void)
 {
 	struct event event;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x1001e, "cycles");
 	event_leader_ebb_init(&event);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
index 754b3f2..ecf5ee3 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_freeze_test.c
@@ -56,6 +56,8 @@ int cycles_with_freeze(void)
 	uint64_t val;
 	bool fc_cleared;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x1001e, "cycles");
 	event_leader_ebb_init(&event);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c
index d43029b..c0faba5 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/cycles_with_mmcr2_test.c
@@ -26,6 +26,8 @@ int cycles_with_mmcr2(void)
 	int i;
 	bool bad_mmcr2;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x1001e, "cycles");
 	event_leader_ebb_init(&event);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
index d7a72ce..9729d9f 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <linux/auxvec.h>
 
 #include "trace.h"
 #include "reg.h"
@@ -319,6 +320,16 @@ void ebb_global_disable(void)
 	mb();
 }
 
+bool ebb_is_supported(void)
+{
+#ifdef PPC_FEATURE2_EBB
+	/* EBB requires at least POWER8 */
+	return ((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_EBB);
+#else
+	return false;
+#endif
+}
+
 void event_ebb_init(struct event *e)
 {
 	e->attr.config |= (1ull << 63);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.h b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
index e44eee5..f87e761 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
@@ -52,6 +52,7 @@ void standard_ebb_callee(void);
 int ebb_event_enable(struct event *e);
 void ebb_global_enable(void);
 void ebb_global_disable(void);
+bool ebb_is_supported(void);
 void ebb_freeze_pmcs(void);
 void ebb_unfreeze_pmcs(void);
 void event_ebb_init(struct event *e);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c
index c45f948..1e7b7fe 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_child_test.c
@@ -47,6 +47,8 @@ int ebb_on_child(void)
 	struct event event;
 	pid_t pid;
 
+	SKIP_IF(!ebb_is_supported());
+
 	FAIL_IF(pipe(read_pipe.fds) == -1);
 	FAIL_IF(pipe(write_pipe.fds) == -1);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
index 11acf1d..a991d2e 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_on_willing_child_test.c
@@ -54,6 +54,8 @@ int ebb_on_willing_child(void)
 	struct event event;
 	pid_t pid;
 
+	SKIP_IF(!ebb_is_supported());
+
 	FAIL_IF(pipe(read_pipe.fds) == -1);
 	FAIL_IF(pipe(write_pipe.fds) == -1);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c
index be4dd5a..af20a2b 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_vs_cpu_event_test.c
@@ -41,6 +41,8 @@ int ebb_vs_cpu_event(void)
 	int cpu, rc;
 	pid_t pid;
 
+	SKIP_IF(!ebb_is_supported());
+
 	cpu = pick_online_cpu();
 	FAIL_IF(cpu < 0);
 	FAIL_IF(bind_to_cpu(cpu));
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/event_attributes_test.c b/tools/testing/selftests/powerpc/pmu/ebb/event_attributes_test.c
index 7e78153..7762ab2 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/event_attributes_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/event_attributes_test.c
@@ -16,6 +16,8 @@ int event_attributes(void)
 {
 	struct event event, leader;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init(&event, 0x1001e);
 	event_leader_ebb_init(&event);
 	/* Expected to succeed */
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
index 9e7af6e..167135b 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
@@ -44,6 +44,8 @@ int fork_cleanup(void)
 {
 	pid_t pid;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x1001e, "cycles");
 	event_leader_ebb_init(&event);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
index f8190fa..5da3551 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/instruction_count_test.c
@@ -111,6 +111,8 @@ int instruction_count(void)
 	struct event event;
 	uint64_t overhead;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x400FA, "PM_RUN_INST_CMPL");
 	event_leader_ebb_init(&event);
 	event.attr.exclude_kernel = 1;
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
index 0c9dd9b..eb8acb7 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/lost_exception_test.c
@@ -23,6 +23,8 @@ static int test_body(void)
 	int i, orig_period, max_period;
 	struct event event;
 
+	SKIP_IF(!ebb_is_supported());
+
 	/* We use PMC4 to make sure the kernel switches all counters correctly */
 	event_init_named(&event, 0x40002, "instructions");
 	event_leader_ebb_init(&event);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c b/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
index 67d78af..6ff8c8f 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/multi_counter_test.c
@@ -18,6 +18,8 @@ int multi_counter(void)
 	struct event events[6];
 	int i, group_fd;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&events[0], 0x1001C, "PM_CMPLU_STALL_THRD");
 	event_init_named(&events[1], 0x2D016, "PM_CMPLU_STALL_FXU");
 	event_init_named(&events[2], 0x30006, "PM_CMPLU_STALL_OTHER_CMPL");
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c b/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
index b8dc371..037cb61 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/multi_ebb_procs_test.c
@@ -79,6 +79,8 @@ int multi_ebb_procs(void)
 	pid_t pids[NR_CHILDREN];
 	int cpu, rc, i;
 
+	SKIP_IF(!ebb_is_supported());
+
 	cpu = pick_online_cpu();
 	FAIL_IF(cpu < 0);
 	FAIL_IF(bind_to_cpu(cpu));
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c b/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
index 2f9bf8e..8341d77 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/no_handler_test.c
@@ -19,6 +19,8 @@ static int no_handler_test(void)
 	u64 val;
 	int i;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x1001e, "cycles");
 	event_leader_ebb_init(&event);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c b/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
index 986500f..c5fa647 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/pmae_handling_test.c
@@ -58,6 +58,8 @@ static int test_body(void)
 {
 	struct event event;
 
+	SKIP_IF(!ebb_is_supported());
+
 	event_init_named(&event, 0x1001e, "cycles");
 	event_leader_ebb_init(&event);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c b/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
index a503fa7..c22860a 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/pmc56_overflow_test.c
@@ -49,6 +49,8 @@ int pmc56_overflow(void)
 {
 	struct event event;
 
+	SKIP_IF(!ebb_is_supported());
+
 	/* Use PMC2 so we set PMCjCE, which enables PMC5/6 */
 	event_init(&event, 0x2001e);
 	event_leader_ebb_init(&event);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c b/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
index 0cae66f..5b1188f 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
@@ -18,6 +18,8 @@ int reg_access(void)
 {
 	uint64_t val, expected;
 
+	SKIP_IF(!ebb_is_supported());
+
 	expected = 0x8000000100000000ull;
 	mtspr(SPRN_BESCR, expected);
 	val = mfspr(SPRN_BESCR);
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c b/tools/testing/selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c
index d56607e..1846f4e 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/task_event_pinned_vs_ebb_test.c
@@ -42,6 +42,8 @@ int task_event_pinned_vs_ebb(void)
 	pid_t pid;
 	int rc;
 
+	SKIP_IF(!ebb_is_supported());
+
 	FAIL_IF(pipe(read_pipe.fds) == -1);
 	FAIL_IF(pipe(write_pipe.fds) == -1);
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c b/tools/testing/selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c
index eba3219..e3bc6e9 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/task_event_vs_ebb_test.c
@@ -40,6 +40,8 @@ int task_event_vs_ebb(void)
 	pid_t pid;
 	int rc;
 
+	SKIP_IF(!ebb_is_supported());
+
 	FAIL_IF(pipe(read_pipe.fds) == -1);
 	FAIL_IF(pipe(write_pipe.fds) == -1);
 
-- 
2.4.0
