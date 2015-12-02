Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DBD591A000C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Dec 2015 20:44:16 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>
Subject: [PATCH 3/4] selftests/powerpc: Make context_switch do something with
 no args
Date: Wed,  2 Dec 2015 20:44:10 +1100
Message-Id: <1449049451-31373-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1449049451-31373-1-git-send-email-mpe@ellerman.id.au>
References: <1449049451-31373-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For ease of use make the context_switch test do something useful when
called with no arguments.

Default to a 30 second run, using threads, doing yield, and use any
online cpu. Make it print out what it's doing to avoid confusion.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Anton Blanchard <anton@samba.org>
---
 .../testing/selftests/powerpc/benchmarks/Makefile  |  1 +
 .../selftests/powerpc/benchmarks/context_switch.c  | 32 ++++++++++++++++------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index 8cb7415c55aa..912445ff7ce7 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -6,6 +6,7 @@ all: $(TEST_PROGS)
 
 $(TEST_PROGS): ../harness.c
 
+context_switch: ../utils.c
 context_switch: LDLIBS += -lpthread
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/benchmarks/context_switch.c b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
index ed21a83a0f99..d8b6d10f36a6 100644
--- a/tools/testing/selftests/powerpc/benchmarks/context_switch.c
+++ b/tools/testing/selftests/powerpc/benchmarks/context_switch.c
@@ -26,7 +26,9 @@
 #include <sys/shm.h>
 #include <linux/futex.h>
 
-static unsigned int timeout = INT_MAX;
+#include "../utils.h"
+
+static unsigned int timeout = 30;
 
 static int touch_vdso;
 struct timeval tv;
@@ -363,9 +365,9 @@ static struct option options[] = {
 static void usage(void)
 {
 	fprintf(stderr, "Usage: context_switch2 <options> CPU1 CPU2\n\n");
-	fprintf(stderr, "\t\t--test=X\tpipe, futex or yield\n");
+	fprintf(stderr, "\t\t--test=X\tpipe, futex or yield (default)\n");
 	fprintf(stderr, "\t\t--process\tUse processes (default threads)\n");
-	fprintf(stderr, "\t\t--timeout=X\tDuration in seconds to run\n");
+	fprintf(stderr, "\t\t--timeout=X\tDuration in seconds to run (default 30)\n");
 	fprintf(stderr, "\t\t--vdso\t\ttouch VDSO\n");
 	fprintf(stderr, "\t\t--fp\t\ttouch FP\n");
 #ifdef __powerpc__
@@ -377,7 +379,7 @@ static void usage(void)
 int main(int argc, char *argv[])
 {
 	signed char c;
-	struct actions *actions = &pipe_actions;
+	struct actions *actions = &yield_actions;
 	int cpu1;
 	int cpu2;
 	static void (*start_fn)(void *(*fn)(void *), void *arg, unsigned long cpu);
@@ -428,18 +430,30 @@ int main(int argc, char *argv[])
 		start_fn = start_thread_on;
 
 	if (((argc - optind) != 2)) {
-		usage();
-		exit(1);
+		cpu1 = cpu2 = pick_online_cpu();
+	} else {
+		cpu1 = atoi(argv[optind++]);
+		cpu2 = atoi(argv[optind++]);
 	}
 
+	printf("Using %s with ", processes ? "processes" : "threads");
+
+	if (actions == &pipe_actions)
+		printf("pipe");
+	else if (actions == &yield_actions)
+		printf("yield");
+	else
+		printf("futex");
+
+	printf(" on cpus %d/%d touching FP:%s altivec:%s vector:%s vdso:%s\n",
+	       cpu1, cpu2, touch_fp ?  "yes" : "no", touch_altivec ? "yes" : "no",
+	       touch_vector ? "yes" : "no", touch_vdso ? "yes" : "no");
+
 	/* Create a new process group so we can signal everyone for exit */
 	setpgid(getpid(), getpid());
 
 	signal(SIGUSR1, sigusr1_handler);
 
-	cpu1 = atoi(argv[optind++]);
-	cpu2 = atoi(argv[optind++]);
-
 	actions->setup(cpu1, cpu2);
 
 	start_fn(actions->thread1, NULL, cpu1);
-- 
2.5.0
