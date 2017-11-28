Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymH8N0SVdzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 19:36:51 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAS8YOr0019813
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 03:36:50 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2eh1hgf2hs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 03:36:49 -0500
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Nov 2017 03:36:48 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] selftest/powerpc: Add additional option to mmap_bench test
Date: Tue, 28 Nov 2017 14:06:39 +0530
Message-Id: <20171128083639.20561-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds --pgfault and --iterations options to mmap_bench test. With
--pgfault we touch every page mapped. This helps in measuring impact in the
page fault path with a patch series.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 .../selftests/powerpc/benchmarks/mmap_bench.c      | 53 ++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c b/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
index 8d084a2d6e74..7a0a462a2272 100644
--- a/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
+++ b/tools/testing/selftests/powerpc/benchmarks/mmap_bench.c
@@ -7,17 +7,34 @@
 #include <stdlib.h>
 #include <sys/mman.h>
 #include <time.h>
+#include <getopt.h>
 
 #include "utils.h"
 
 #define ITERATIONS 5000000
 
-#define MEMSIZE (128 * 1024 * 1024)
+#define MEMSIZE (1UL << 27)
+#define PAGE_SIZE (1UL << 16)
+#define CHUNK_COUNT (MEMSIZE/PAGE_SIZE)
+
+static int pg_fault;
+static int iterations = ITERATIONS;
+
+static struct option options[] = {
+	{ "pgfault", no_argument, &pg_fault, 1 },
+	{ "iterations", required_argument, 0, 'i' },
+	{ 0, },
+};
+
+static void usage(void)
+{
+	printf("mmap_bench <--pgfault> <--iterations count>\n");
+}
 
 int test_mmap(void)
 {
 	struct timespec ts_start, ts_end;
-	unsigned long i = ITERATIONS;
+	unsigned long i = iterations;
 
 	clock_gettime(CLOCK_MONOTONIC, &ts_start);
 
@@ -25,6 +42,11 @@ int test_mmap(void)
 		char *c = mmap(NULL, MEMSIZE, PROT_READ|PROT_WRITE,
 			       MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
 		FAIL_IF(c == MAP_FAILED);
+		if (pg_fault) {
+			int count;
+			for (count = 0; count < CHUNK_COUNT; count++)
+				c[count << 16] = 'c';
+		}
 		munmap(c, MEMSIZE);
 	}
 
@@ -35,7 +57,32 @@ int test_mmap(void)
 	return 0;
 }
 
-int main(void)
+int main(int argc, char *argv[])
 {
+	signed char c;
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
+		case 'i':
+			iterations = atoi(optarg);
+			break;
+		default:
+			usage();
+			exit(1);
+		}
+	}
 	return test_harness(test_mmap, "mmap_bench");
 }
-- 
2.14.3
