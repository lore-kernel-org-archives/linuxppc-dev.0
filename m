Return-Path: <rui.teng@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sk2mp537HzDrVT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 00:10:50 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8RE7Xs5054363
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 10:10:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25qr68pwxs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Sep 2016 10:10:47 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rui.teng@linux.vnet.ibm.com>;
 Tue, 27 Sep 2016 08:10:47 -0600
From: Rui Teng <rui.teng@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Shuah Khan <shuah@kernel.org>,
 Anton Blanchard <anton@au1.ibm.com>, Cyril Bur <cyrilbur@gmail.com>,
 Michael Neuling <mikey@neuling.org>, Anton Blanchard <anton@au1.ibm.com>,
 Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: [PATCH] tools/testing/selftests/powerpc: Add Anton's null_syscall
 benchmark to the selftests
Date: Tue, 27 Sep 2016 22:10:16 +0800
Message-Id: <20160927141016.6027-1-rui.teng@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@au.ibm.com>

Pull in a version of Anton's null_syscall benchmark:
http://ozlabs.org/~anton/junkcode/null_syscall.c
Into tools/testing/selftests/powerpc/benchmarks.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Anton Blanchard <anton@au.ibm.com>
Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
---
 .../testing/selftests/powerpc/benchmarks/Makefile  |   2 +-
 .../selftests/powerpc/benchmarks/null_syscall.c    | 157 +++++++++++++++++++++
 2 files changed, 158 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/null_syscall.c

diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
index a9adfb7..545077f 100644
--- a/tools/testing/selftests/powerpc/benchmarks/Makefile
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -1,4 +1,4 @@
-TEST_PROGS := gettimeofday context_switch mmap_bench futex_bench
+TEST_PROGS := gettimeofday context_switch mmap_bench futex_bench null_syscall
 
 CFLAGS += -O2
 
diff --git a/tools/testing/selftests/powerpc/benchmarks/null_syscall.c b/tools/testing/selftests/powerpc/benchmarks/null_syscall.c
new file mode 100644
index 0000000..59c2f45
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/null_syscall.c
@@ -0,0 +1,157 @@
+/*
+ * Test null syscall performance
+ *
+ * Copyright (C) 2009-2015 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#define NR_LOOPS 10000000
+
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <time.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <signal.h>
+
+static volatile int soak_done;
+unsigned long long clock_frequency;
+unsigned long long timebase_frequency;
+double timebase_multiplier;
+
+static inline unsigned long long mftb(void)
+{
+	unsigned long low;
+
+	asm volatile("mftb %0" : "=r" (low));
+
+	return low;
+}
+
+static void sigalrm_handler(int unused)
+{
+	soak_done = 1;
+}
+
+/*
+ * Use a timer instead of busy looping on clock_gettime() so we don't
+ * pollute profiles with glibc and VDSO hits.
+ */
+static void cpu_soak_usecs(unsigned long usecs)
+{
+	struct itimerval val;
+
+	memset(&val, 0, sizeof(val));
+	val.it_value.tv_usec = usecs;
+
+	signal(SIGALRM, sigalrm_handler);
+	setitimer(ITIMER_REAL, &val, NULL);
+
+	while (1) {
+		if (soak_done)
+			break;
+	}
+
+	signal(SIGALRM, SIG_DFL);
+}
+
+/*
+ * This only works with recent kernels where cpufreq modifies
+ * /proc/cpuinfo dynamically.
+ */
+static void get_proc_frequency(void)
+{
+	FILE *f;
+	char line[128];
+	char *p, *end;
+	unsigned long v;
+	double d;
+	char *override;
+
+	/* Try to get out of low power/low frequency mode */
+	cpu_soak_usecs(0.25 * 1000000);
+
+	f = fopen("/proc/cpuinfo", "r");
+	if (f == NULL)
+		return;
+
+	timebase_frequency = 0;
+
+	while (fgets(line, sizeof(line), f) != NULL) {
+		if (strncmp(line, "timebase", 8) == 0) {
+			p = strchr(line, ':');
+			if (p != NULL) {
+				v = strtoull(p + 1, &end, 0);
+				if (end != p + 1)
+					timebase_frequency = v;
+			}
+		}
+
+		if (((strncmp(line, "clock", 5) == 0) ||
+		     (strncmp(line, "cpu MHz", 7) == 0))) {
+			p = strchr(line, ':');
+			if (p != NULL) {
+				d = strtod(p + 1, &end);
+				if (end != p + 1) {
+					/* Find fastest clock frequency */
+					if ((d * 1000000ULL) > clock_frequency)
+						clock_frequency = d * 1000000ULL;
+				}
+			}
+		}
+	}
+
+	fclose(f);
+
+	override = getenv("FREQUENCY");
+	if (override)
+		clock_frequency = strtoull(override, NULL, 10);
+
+	if (timebase_frequency)
+		timebase_multiplier = (double)clock_frequency
+					/ timebase_frequency;
+	else
+		timebase_multiplier = 1;
+}
+
+static void do_null_syscall(unsigned long nr)
+{
+	unsigned long i;
+
+	for (i = 0; i < nr; i++)
+		getppid();
+}
+
+#define TIME(A, STR) \
+
+int main(void)
+{
+	unsigned long tb_start, tb_now;
+	struct timespec tv_start, tv_now;
+	unsigned long long elapsed_ns, elapsed_tb;
+
+	get_proc_frequency();
+
+	clock_gettime(CLOCK_MONOTONIC, &tv_start);
+	tb_start = mftb();
+
+	do_null_syscall(NR_LOOPS);
+
+	clock_gettime(CLOCK_MONOTONIC, &tv_now);
+	tb_now = mftb();
+
+	elapsed_ns = (tv_now.tv_sec - tv_start.tv_sec) * 1000000000ULL +
+			(tv_now.tv_nsec - tv_start.tv_nsec);
+	elapsed_tb = tb_now - tb_start;
+
+	printf("%10.2f ns %10.2f cycles\n", (float)elapsed_ns / NR_LOOPS,
+			(float)elapsed_tb * timebase_multiplier / NR_LOOPS);
+
+	return 0;
+}
-- 
2.7.4
