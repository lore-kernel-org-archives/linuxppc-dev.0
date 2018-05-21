Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40qMkg53bxzF1Cr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 01:14:19 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4LF8np1050151
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:14:17 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j3wcnsnj3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 May 2018 11:14:17 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 21 May 2018 16:14:14 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] selftests/powerpc: Add test to verify rfi flush across
 a system call
Date: Mon, 21 May 2018 20:43:57 +0530
In-Reply-To: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <5777d4ff6a9216b189f349f98217d47b38278661.1526915409.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a test to verify proper functioning of the rfi flush
capability implemented to mitigate meltdown. The test works by measuring
the number of L1d cache misses encountered while loading data from
memory. Across a system call, since the L1d cache is flushed when
rfi_flush is enabled, the number of cache misses is expected to be
relative to the number of cachelines corresponding to the data being
loaded.

The current system setting is reflected via powerpc/rfi_flush under
debugfs (assumed to be /sys/kernel/debug/). This test verifies the
expected result with rfi_flush enabled as well as when it is disabled.

Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/Makefile      |   3 +-
 .../testing/selftests/powerpc/include/utils.h |  10 ++
 .../selftests/powerpc/security/Makefile       |   7 +
 .../selftests/powerpc/security/rfi_flush.c    | 132 +++++++++++++++
 tools/testing/selftests/powerpc/utils.c       | 153 ++++++++++++++++++
 5 files changed, 304 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/security/Makefile
 create mode 100644 tools/testing/selftests/powerpc/security/rfi_flush.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 201b598558b9..b3ad909aefbc 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -28,7 +28,8 @@ SUB_DIRS = alignment		\
 	   tm			\
 	   vphn         \
 	   math		\
-	   ptrace
+	   ptrace	\
+	   security
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/include/utils.h b/tools/testing/selftests/powerpc/include/utils.h
index b8f9cc6c9ff2..684b9d554639 100644
--- a/tools/testing/selftests/powerpc/include/utils.h
+++ b/tools/testing/selftests/powerpc/include/utils.h
@@ -11,6 +11,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <linux/auxvec.h>
+#include <linux/perf_event.h>
 #include "reg.h"
 
 /* Avoid headaches with PRI?64 - just use %ll? always */
@@ -31,6 +32,15 @@ void *get_auxv_entry(int type);
 
 int pick_online_cpu(void);
 
+int read_debugfs_file(char *debugfs_file, int *result);
+int write_debugfs_file(char *debugfs_file, int result);
+void set_dscr(unsigned long val);
+int perf_event_open_counter(unsigned int type,
+			    unsigned long config, int group_fd);
+int perf_event_enable(int fd);
+int perf_event_disable(int fd);
+int perf_event_reset(int fd);
+
 static inline bool have_hwcap(unsigned long ftr)
 {
 	return ((unsigned long)get_auxv_entry(AT_HWCAP) & ftr) == ftr;
diff --git a/tools/testing/selftests/powerpc/security/Makefile b/tools/testing/selftests/powerpc/security/Makefile
new file mode 100644
index 000000000000..8a472e13950a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/security/Makefile
@@ -0,0 +1,7 @@
+TEST_GEN_PROGS := rfi_flush
+
+CFLAGS += -I../../../../../usr/include
+
+include ../../lib.mk
+
+$(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/security/rfi_flush.c b/tools/testing/selftests/powerpc/security/rfi_flush.c
new file mode 100644
index 000000000000..a20fe8eca161
--- /dev/null
+++ b/tools/testing/selftests/powerpc/security/rfi_flush.c
@@ -0,0 +1,132 @@
+#include <sys/types.h>
+#include <stdint.h>
+#include <malloc.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include "utils.h"
+
+#define CACHELINE_SIZE	128
+
+struct perf_event_read {
+	uint64_t nr;
+	uint64_t l1d_misses;
+};
+
+static inline uint64_t load(void *addr)
+{
+	uint64_t tmp;
+
+	asm volatile("ld %0,0(%1)" : "=r"(tmp) : "b" (addr));
+
+	return tmp;
+}
+
+static void syscall_loop(char *p, unsigned long iterations, unsigned long zero_size)
+{
+	for (unsigned long i = 0; i < iterations; i++) {
+		for (unsigned long j = 0; j < zero_size; j += CACHELINE_SIZE)
+			load(p + j);
+		getppid();
+	}
+}
+
+int rfi_flush_test(void)
+{
+	char *p;
+	int repetitions = 10;
+	int fd, passes = 0, iter, rc = 0;
+	struct perf_event_read v;
+	uint64_t l1d_misses_total = 0;
+	unsigned long iterations = 100000, zero_size = 24*1024;
+	int rfi_flush_org, rfi_flush;
+
+	SKIP_IF(geteuid() != 0);
+
+	if (read_debugfs_file("powerpc/rfi_flush", &rfi_flush_org)) {
+		perror("error reading powerpc/rfi_flush debugfs file");
+	        printf("unable to determine current rfi_flush setting");
+		return 1;
+	}
+
+	rfi_flush = rfi_flush_org;
+
+	FAIL_IF((fd = perf_event_open_counter(PERF_TYPE_RAW,
+					  0x400f0, /* L1d miss */
+					  -1)) < 0);
+
+	p = (char *)memalign(zero_size, CACHELINE_SIZE);
+
+	FAIL_IF(perf_event_enable(fd));
+
+	set_dscr(1);
+
+	iter = repetitions;
+
+again:
+	FAIL_IF(perf_event_reset(fd));
+
+	syscall_loop(p, iterations, zero_size);
+
+	FAIL_IF(read(fd, &v, sizeof(v)) != sizeof(v));
+
+	/* Expect at least zero_size/CACHELINE_SIZE misses per iteration */
+	if (v.l1d_misses >= (iterations * zero_size / CACHELINE_SIZE) &&
+			rfi_flush)
+		passes++;
+	else if (v.l1d_misses < iterations && !rfi_flush)
+		passes++;
+
+	l1d_misses_total += v.l1d_misses;
+
+	while (--iter)
+		goto again;
+
+	if (passes < repetitions) {
+		printf("FAIL (L1D misses with rfi_flush=%d: %lu %c %lu) [%d/%d failures]\n",
+			rfi_flush,
+			l1d_misses_total,
+			rfi_flush ? '<' : '>',
+			rfi_flush ? (repetitions * iterations * zero_size/CACHELINE_SIZE) :
+				iterations,
+			repetitions - passes, repetitions);
+		rc = 1;
+	} else
+		printf("PASS (L1D misses with rfi_flush=%d: %lu %c %lu) [%d/%d pass]\n",
+			rfi_flush,
+			l1d_misses_total,
+			rfi_flush ? '>' : '<',
+			rfi_flush ? (repetitions * iterations * zero_size/CACHELINE_SIZE) :
+				iterations,
+			passes, repetitions);
+
+	if (rfi_flush == rfi_flush_org) {
+		rfi_flush = !rfi_flush_org;
+		if (write_debugfs_file("powerpc/rfi_flush", rfi_flush) < 0) {
+			perror("error writing to powerpc/rfi_flush debugfs file");
+			return 1;
+		}
+		iter = repetitions;
+		l1d_misses_total = 0;
+		passes = 0;
+		goto again;
+	}
+
+	perf_event_disable(fd);
+	close(fd);
+
+	set_dscr(0);
+
+	if (write_debugfs_file("powerpc/rfi_flush", rfi_flush_org) < 0) {
+		perror("unable to restore original value of powerpc/rfi_flush debugfs file");
+		return 1;
+	}
+
+	return rc;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(rfi_flush_test, "rfi_flush_test");
+}
diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
index d46916867a6f..7f8b7de08c75 100644
--- a/tools/testing/selftests/powerpc/utils.c
+++ b/tools/testing/selftests/powerpc/utils.c
@@ -11,13 +11,20 @@
 #include <link.h>
 #include <sched.h>
 #include <stdio.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/ioctl.h>
 #include <unistd.h>
+#include <asm/unistd.h>
+#include <linux/limits.h>
 
 #include "utils.h"
 
 static char auxv[4096];
+extern unsigned int dscr_insn[];
 
 int read_auxv(char *buf, ssize_t buf_size)
 {
@@ -104,3 +111,149 @@ int pick_online_cpu(void)
 	printf("No cpus in affinity mask?!\n");
 	return -1;
 }
+
+int read_debugfs_file(char *debugfs_file, int *result)
+{
+	int rc = -1, fd;
+	char path[PATH_MAX];
+	char value[16];
+
+	strcpy(path, "/sys/kernel/debug/");
+	strncat(path, debugfs_file, PATH_MAX - strlen(path) - 1);
+
+	if ((fd = open(path, O_RDONLY)) < 0)
+		return rc;
+
+	if ((rc = read(fd, value, sizeof(value))) < 0)
+		return rc;
+
+	value[15] = 0;
+	*result = atoi(value);
+	close(fd);
+
+	return 0;
+}
+
+int write_debugfs_file(char *debugfs_file, int result)
+{
+	int rc = -1, fd;
+	char path[PATH_MAX];
+	char value[16];
+
+	strcpy(path, "/sys/kernel/debug/");
+	strncat(path, debugfs_file, PATH_MAX - strlen(path) - 1);
+
+	if ((fd = open(path, O_WRONLY)) < 0)
+		return rc;
+
+	snprintf(value, 16, "%d", result);
+
+	if ((rc = write(fd, value, strlen(value))) < 0)
+		return rc;
+
+	close(fd);
+
+	return 0;
+}
+
+static long perf_event_open(struct perf_event_attr *hw_event, pid_t pid,
+		int cpu, int group_fd, unsigned long flags)
+{
+	return syscall(__NR_perf_event_open, hw_event, pid, cpu,
+		      group_fd, flags);
+}
+
+static void perf_event_attr_init(struct perf_event_attr *event_attr,
+					unsigned int type,
+					unsigned long config)
+{
+	memset(event_attr, 0, sizeof(*event_attr));
+
+	event_attr->type = type;
+	event_attr->size = sizeof(struct perf_event_attr);
+	event_attr->config = config;
+	event_attr->read_format = PERF_FORMAT_GROUP;
+	event_attr->disabled = 1;
+	event_attr->exclude_kernel = 1;
+	event_attr->exclude_hv = 1;
+	event_attr->exclude_guest = 1;
+}
+
+int perf_event_open_counter(unsigned int type,
+			    unsigned long config, int group_fd)
+{
+	int fd;
+	struct perf_event_attr event_attr;
+
+	perf_event_attr_init(&event_attr, type, config);
+
+	fd = perf_event_open(&event_attr, 0, -1, group_fd, 0);
+
+	if (fd < 0)
+		perror("perf_event_open() failed");
+
+	return fd;
+}
+
+int perf_event_enable(int fd)
+{
+	if (ioctl(fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP) == -1) {
+		perror("error while enabling perf events");
+		return -1;
+	}
+
+	return 0;
+}
+
+int perf_event_disable(int fd)
+{
+	if (ioctl(fd, PERF_EVENT_IOC_DISABLE, PERF_IOC_FLAG_GROUP) == -1) {
+		perror("error disabling perf events");
+		return -1;
+	}
+
+	return 0;
+}
+
+int perf_event_reset(int fd)
+{
+	if (ioctl(fd, PERF_EVENT_IOC_RESET, PERF_IOC_FLAG_GROUP) == -1) {
+		perror("error resetting perf events");
+		return -1;
+	}
+
+	return 0;
+}
+
+static void sigill_handler(int signr, siginfo_t *info, void *unused)
+{
+	static int warned = 0;
+	ucontext_t *ctx = (ucontext_t *)unused;
+	unsigned long *pc = &UCONTEXT_NIA(ctx);
+
+	if (*pc == (unsigned long)&dscr_insn) {
+		if (!warned++)
+			printf("WARNING: Skipping over dscr setup. Consider running 'ppc64_cpu --dscr=1' manually.\n");
+		*pc += 4;
+	} else {
+		printf("SIGILL at %p\n", pc);
+		abort();
+	}
+}
+
+void set_dscr(unsigned long val)
+{
+	static int init = 0;
+	struct sigaction sa;
+
+	if (!init) {
+		memset(&sa, 0, sizeof(sa));
+		sa.sa_sigaction = sigill_handler;
+		sa.sa_flags = SA_SIGINFO;
+		if (sigaction(SIGILL, &sa, NULL))
+			perror("sigill_handler");
+		init = 1;
+	}
+
+	asm volatile("dscr_insn: mtspr %1,%0" : : "r" (val), "i" (SPRN_DSCR));
+}
-- 
2.17.0
