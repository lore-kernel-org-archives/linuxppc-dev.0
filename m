Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwcw844VTzF1Gj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 00:25:28 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id l24so8248673pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 05:25:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 01/10] selftests/powerpc: add process creation benchmark
Date: Tue,  6 Mar 2018 23:24:58 +1000
Message-Id: <20180306132507.10649-2-npiggin@gmail.com>
In-Reply-To: <20180306132507.10649-1-npiggin@gmail.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 .../selftests/powerpc/benchmarks/.gitignore        |   2 +
 .../testing/selftests/powerpc/benchmarks/Makefile  |   8 +-
 .../selftests/powerpc/benchmarks/exec_target.c     |   5 +
 tools/testing/selftests/powerpc/benchmarks/fork.c  | 339 +++++++++++++++++++++
 4 files changed, 353 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/exec_target.c
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/fork.c

diff --git a/tools/testing/selftests/powerpc/benchmarks/.gitignore b/tools/testing/selftests/powerpc/benchmarks/.gitignore
index 04dc1e6ef2ce..9161679b1e1a 100644
--- a/tools/testing/selftests/powerpc/benchmarks/.gitignore
+++ b/tools/testing/selftests/powerpc/benchmarks/.gitignore
@@ -1,5 +1,7 @@
 gettimeofday
 context_switch
+fork
+exec_target
 mmap_bench
 futex_bench
 null_syscall
diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index a35058e3766c..61189a0b8285 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -1,5 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-TEST_GEN_PROGS := gettimeofday context_switch mmap_bench futex_bench null_syscall
+TEST_GEN_PROGS := gettimeofday context_switch fork mmap_bench futex_bench null_syscall
+TEST_GEN_FILES := exec_target
+
+$(OUTPUT)/exec_target: exec_target.c
+	$(CC) -O2 -static -nostartfiles -oexec_target exec_target.c
 
 CFLAGS += -O2
 
@@ -10,3 +14,5 @@ $(TEST_GEN_PROGS): ../harness.c
 $(OUTPUT)/context_switch: ../utils.c
 $(OUTPUT)/context_switch: CFLAGS += -maltivec -mvsx -mabi=altivec
 $(OUTPUT)/context_switch: LDLIBS += -lpthread
+
+$(OUTPUT)/fork: LDLIBS += -lpthread
diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
new file mode 100644
index 000000000000..5e2a6e917c1a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
@@ -0,0 +1,5 @@
+void _exit(int);
+void _start(void)
+{
+	_exit(0);
+}
diff --git a/tools/testing/selftests/powerpc/benchmarks/fork.c b/tools/testing/selftests/powerpc/benchmarks/fork.c
new file mode 100644
index 000000000000..c68a7c360fd2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/fork.c
@@ -0,0 +1,339 @@
+/*
+ * Context switch microbenchmark.
+ *
+ * Copyright (C) 2018 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <sched.h>
+#include <string.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <getopt.h>
+#include <signal.h>
+#include <assert.h>
+#include <pthread.h>
+#include <limits.h>
+#include <sys/time.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/shm.h>
+#include <sys/wait.h>
+#include <linux/futex.h>
+
+static unsigned int timeout = 30;
+
+static void set_cpu(int cpu)
+{
+	cpu_set_t cpuset;
+
+	if (cpu == -1)
+		return;
+
+	CPU_ZERO(&cpuset);
+	CPU_SET(cpu, &cpuset);
+
+	if (sched_setaffinity(0, sizeof(cpuset), &cpuset)) {
+		perror("sched_setaffinity");
+		exit(1);
+	}
+}
+
+static void start_process_on(void *(*fn)(void *), void *arg, int cpu)
+{
+	int pid;
+
+	pid = fork();
+	if (pid == -1) {
+		perror("fork");
+		exit(1);
+	}
+
+	if (pid)
+		return;
+
+	set_cpu(cpu);
+
+	fn(arg);
+
+	exit(0);
+}
+
+static int cpu;
+static int do_fork = 0;
+static int do_vfork = 0;
+static int do_exec = 0;
+static char *exec_file;
+static int exec_target = 0;
+static unsigned long iterations;
+static unsigned long iterations_prev;
+
+static void run_exec(void)
+{
+#if 0
+	char *const argv[] = { exec_file, "--exec-target", NULL };
+
+	if (execve(exec_file, argv, NULL) == -1) {
+		perror("execve");
+		exit(1);
+	}
+#else
+	char *const argv[] = { "./exec_target", NULL };
+
+	if (execve("./exec_target", argv, NULL) == -1) {
+		perror("execve");
+		exit(1);
+	}
+#endif
+}
+
+static void bench_fork(void)
+{
+	while (1) {
+		pid_t pid = fork();
+		if (pid == -1) {
+			perror("fork");
+			exit(1);
+		}
+		if (pid == 0) {
+			if (do_exec)
+				run_exec();
+			_exit(0);
+		}
+		pid = waitpid(pid, NULL, 0);
+		if (pid	== -1) {
+			perror("waitpid");
+			exit(1);
+		}
+		iterations++;
+	}
+}
+
+static void bench_vfork(void)
+{
+	while (1) {
+		pid_t pid = vfork();
+		if (pid == -1) {
+			perror("fork");
+			exit(1);
+		}
+		if (pid == 0) {
+			if (do_exec)
+				run_exec();
+			_exit(0);
+		}
+		pid = waitpid(pid, NULL, 0);
+		if (pid	== -1) {
+			perror("waitpid");
+			exit(1);
+		}
+		iterations++;
+	}
+}
+
+
+static void *null_fn(void *arg)
+{
+	pthread_exit(NULL);
+}
+
+static void bench_thread(void)
+{
+	pthread_t tid;
+	cpu_set_t cpuset;
+	pthread_attr_t attr;
+	int rc;
+
+	rc = pthread_attr_init(&attr);
+	if (rc) {
+		errno = rc;
+		perror("pthread_attr_init");
+		exit(1);
+	}
+
+	if (cpu != -1) {
+		CPU_ZERO(&cpuset);
+		CPU_SET(cpu, &cpuset);
+
+		rc = pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), &cpuset);
+		if (rc)	{
+			errno = rc;
+			perror("pthread_attr_setaffinity_np");
+			exit(1);
+		}
+	}
+
+	while (1) {
+		rc = pthread_create(&tid, &attr, null_fn, NULL);
+		if (rc) {
+			errno = rc;
+			perror("pthread_create");
+			exit(1);
+		}
+		rc = pthread_join(tid, NULL);
+		if (rc) {
+			errno = rc;
+			perror("pthread_join");
+			exit(1);
+		}
+		iterations++;
+	}
+}
+
+
+static void sigalrm_handler(int junk)
+{
+	unsigned long i = iterations;
+
+	printf("%ld\n", i - iterations_prev);
+	iterations_prev = i;
+
+	if (--timeout == 0)
+		kill(0, SIGUSR1);
+
+	alarm(1);
+}
+
+static void sigusr1_handler(int junk)
+{
+	exit(0);
+}
+
+static void *bench_proc(void *arg)
+{
+	signal(SIGALRM, sigalrm_handler);
+	alarm(1);
+
+	if (do_fork)
+		bench_fork();
+	else if (do_vfork)
+		bench_vfork();
+	else
+		bench_thread();
+
+	return NULL;
+}
+
+static struct option options[] = {
+	{ "fork", no_argument, &do_fork, 1 },
+	{ "vfork", no_argument, &do_vfork, 1 },
+	{ "exec", no_argument, &do_exec, 1 },
+	{ "timeout", required_argument, 0, 's' },
+	{ "exec-target", no_argument, &exec_target, 1 },
+	{ 0, },
+};
+
+static void usage(void)
+{
+	fprintf(stderr, "Usage: fork <options> CPU\n\n");
+	fprintf(stderr, "\t\t--fork\tUse fork() (default threads)\n");
+	fprintf(stderr, "\t\t--vfork\tUse vfork() (default threads)\n");
+	fprintf(stderr, "\t\t--exec\tAlso exec() (default no exec)\n");
+	fprintf(stderr, "\t\t--timeout=X\tDuration in seconds to run (default 30)\n");
+	fprintf(stderr, "\t\t--exec-target\tInternal option for exec workload\n");
+}
+
+int main(int argc, char *argv[])
+{
+	signed char c;
+
+	while (1) {
+		int option_index = 0;
+
+		c = getopt_long(argc, argv, "", options, &option_index);
+
+		if (c == -1)
+			break;
+
+		switch (c) {
+		case 0:
+			if (options[option_index].flag != 0)
+				break;
+
+			usage();
+			exit(1);
+			break;
+
+		case 's':
+			timeout = atoi(optarg);
+			break;
+
+		default:
+			usage();
+			exit(1);
+		}
+	}
+
+	if (do_fork && do_vfork) {
+		usage();
+		exit(1);
+	}
+	if (do_exec && !do_fork && !do_vfork) {
+		usage();
+		exit(1);
+	}
+
+	if (do_exec) {
+		char *dirname = strdup(argv[0]);
+		int i;
+		i = strlen(dirname) - 1;
+		while (i) {
+			if (dirname[i] == '/') {
+				dirname[i] = '\0';
+				if (chdir(dirname) == -1) {
+					perror("chdir");
+					exit(1);
+				}
+				break;
+			}
+			i--;
+		}
+	}
+
+	if (exec_target) {
+		exit(0);
+	}
+
+	if (((argc - optind) != 1)) {
+		cpu = -1;
+	} else {
+		cpu = atoi(argv[optind++]);
+	}
+
+	if (do_exec)
+		exec_file = argv[0];
+
+	set_cpu(cpu);
+
+	printf("Using ");
+	if (do_fork)
+		printf("fork");
+	else if (do_vfork)
+		printf("vfork");
+	else
+		printf("clone");
+
+	if (do_exec)
+		printf(" + exec");
+
+	printf(" on cpu %d\n", cpu);
+
+	/* Create a new process group so we can signal everyone for exit */
+	setpgid(getpid(), getpid());
+
+	signal(SIGUSR1, sigusr1_handler);
+
+	start_process_on(bench_proc, NULL, cpu);
+
+	while (1)
+		sleep(3600);
+
+	return 0;
+}
-- 
2.16.1
