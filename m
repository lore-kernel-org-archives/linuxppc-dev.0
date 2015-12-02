Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FC781A000C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 20:44:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>
Subject: [PATCH 1/4] selftests/powerpc: Move pick_online_cpu() up into utils.c
Date: Wed,  2 Dec 2015 20:44:08 +1100
Message-Id: <1449049451-31373-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to use this in another test, so make it available at the top of
the powerpc selftests tree.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/Makefile     |  2 +-
 tools/testing/selftests/powerpc/pmu/ebb/Makefile |  3 ++-
 tools/testing/selftests/powerpc/pmu/lib.c        | 26 ------------------------
 tools/testing/selftests/powerpc/pmu/lib.h        |  1 -
 tools/testing/selftests/powerpc/utils.h          |  1 +
 5 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index a9099d9f8f39..15cbd6d5a463 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -2,7 +2,7 @@ noarg:
 	$(MAKE) -C ../
 
 TEST_PROGS := count_instructions l3_bank_test per_event_excludes
-EXTRA_SOURCES := ../harness.c event.c lib.c
+EXTRA_SOURCES := ../harness.c event.c lib.c ../utils.c
 
 all: $(TEST_PROGS) ebb
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/Makefile b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
index 5cdc9dbf2b27..c18285e9a7b6 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/ebb/Makefile
@@ -18,7 +18,8 @@ TEST_PROGS := reg_access_test event_attributes_test cycles_test	\
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../../harness.c ../event.c ../lib.c ebb.c ebb_handler.S trace.c busy_loop.S
+$(TEST_PROGS): ../../harness.c ../event.c ../lib.c ../../utils.c \
+               ebb.c ebb_handler.S trace.c busy_loop.S
 
 instruction_count_test: ../loop.S
 
diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
index a07104c2afe6..a361ad3334ce 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.c
+++ b/tools/testing/selftests/powerpc/pmu/lib.c
@@ -15,32 +15,6 @@
 #include "lib.h"
 
 
-int pick_online_cpu(void)
-{
-	cpu_set_t mask;
-	int cpu;
-
-	CPU_ZERO(&mask);
-
-	if (sched_getaffinity(0, sizeof(mask), &mask)) {
-		perror("sched_getaffinity");
-		return -1;
-	}
-
-	/* We prefer a primary thread, but skip 0 */
-	for (cpu = 8; cpu < CPU_SETSIZE; cpu += 8)
-		if (CPU_ISSET(cpu, &mask))
-			return cpu;
-
-	/* Search for anything, but in reverse */
-	for (cpu = CPU_SETSIZE - 1; cpu >= 0; cpu--)
-		if (CPU_ISSET(cpu, &mask))
-			return cpu;
-
-	printf("No cpus in affinity mask?!\n");
-	return -1;
-}
-
 int bind_to_cpu(int cpu)
 {
 	cpu_set_t mask;
diff --git a/tools/testing/selftests/powerpc/pmu/lib.h b/tools/testing/selftests/powerpc/pmu/lib.h
index ca5d72ae3be6..0213af4ff332 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.h
+++ b/tools/testing/selftests/powerpc/pmu/lib.h
@@ -19,7 +19,6 @@ union pipe {
 	int fds[2];
 };
 
-extern int pick_online_cpu(void);
 extern int bind_to_cpu(int cpu);
 extern int kill_child_and_wait(pid_t child_pid);
 extern int wait_for_child(pid_t child_pid);
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index b7d41086bb0a..7dd75c39d610 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -21,6 +21,7 @@ typedef uint8_t u8;
 
 int test_harness(int (test_function)(void), char *name);
 extern void *get_auxv_entry(int type);
+int pick_online_cpu(void);
 
 /* Yes, this is evil */
 #define FAIL_IF(x)						\
-- 
2.5.0
