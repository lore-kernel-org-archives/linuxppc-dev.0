Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 121E21A0018
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:01:49 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 17:01:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8FF512CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:01:45 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H71bCi4194588
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:01:45 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H71Dtf009944
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 18:01:13 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [RFC 2/2] selftests/powerpc: Add tests for various hash page fault
 paths
Date: Wed, 17 Feb 2016 12:30:33 +0530
Message-Id: <1455692433-10975-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455692433-10975-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455692433-10975-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This new test case tries to create virtual memory scenarios to
drive different types of hash page faults. It also uses perf
API to capture the number of times it went through the intended
hash fault paths.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Test result looks like this now. The objective is to auto verify
the count of these traces for various buffer sizes and scenarios.
created.

vm.nr_hugepages = 10
HugeTLB allocation::::::::
[              faults]:          1
[        major-faults]:          0
[        minor-faults]:          1
[         hash_faults]:          2
[     hash_faults_thp]:          0
[     hash_faults_64K]:          0
[      hash_faults_4K]:          0
[ hash_faults_hugetlb]:          1
THP allocation::::::::
[              faults]:          256
[        major-faults]:          0
[        minor-faults]:          256
[         hash_faults]:          256
[     hash_faults_thp]:          0
[     hash_faults_64K]:          256
[      hash_faults_4K]:          0
[ hash_faults_hugetlb]:          0
SUBPAGE protection::::
[              faults]:          0
[        major-faults]:          0
[        minor-faults]:          0
[         hash_faults]:          4096
[     hash_faults_thp]:          0
[     hash_faults_64K]:          0
[      hash_faults_4K]:          4096
[ hash_faults_hugetlb]:          0
PFN flush::::::::::::
[              faults]:          256
[        major-faults]:          0
[        minor-faults]:          256
[         hash_faults]:          4352
[     hash_faults_thp]:          0
[     hash_faults_64K]:          0
[      hash_faults_4K]:          4096
[ hash_faults_hugetlb]:          0
vm.nr_hugepages = 0

THP allocation on a free system is not happening even after a call to
MADVISE_HUGEPAGE. Problem seems to be related to NUMA memory configuration
which I will debug further.

 tools/testing/selftests/powerpc/mm/Makefile     |   2 +-
 tools/testing/selftests/powerpc/mm/mem_perf.c   | 198 ++++++++++++++++++++++++
 tools/testing/selftests/powerpc/mm/run_mem_perf |   3 +
 3 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/mem_perf.c
 create mode 100755 tools/testing/selftests/powerpc/mm/run_mem_perf

diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index ee179e2..13bc5c3 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -1,7 +1,7 @@
 noarg:
 	$(MAKE) -C ../
 
-TEST_PROGS := hugetlb_vs_thp_test subpage_prot
+TEST_PROGS := hugetlb_vs_thp_test subpage_prot mem_perf
 TEST_FILES := tempfile
 
 all: $(TEST_PROGS) $(TEST_FILES)
diff --git a/tools/testing/selftests/powerpc/mm/mem_perf.c b/tools/testing/selftests/powerpc/mm/mem_perf.c
new file mode 100644
index 0000000..f5d8348
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/mem_perf.c
@@ -0,0 +1,198 @@
+/*
+ * Copyright 2016, Anshuman Khandual, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+
+#include "../pmu/event.c"
+
+#define ADDR_INPUT	0xa0000000000UL
+#define HPAGE_SIZE	0x1000000
+#define PSIZE_64K	0x10000
+#define PSIZE_4K	0x1000
+
+#define MAX_MM_EVENTS	8
+
+struct event mm_events[MAX_MM_EVENTS];
+
+static void setup_event(struct event *e, u64 config, char *name)
+{
+	event_init_opts(e, config, PERF_TYPE_SOFTWARE, name);
+	e->attr.disabled = 1;
+	e->attr.exclude_kernel = 1;
+	e->attr.exclude_hv = 1;
+	e->attr.exclude_idle = 1;
+}
+
+static void setup_event_tr(struct event *e, u64 config, char *name)
+{
+	memset(e, 0, sizeof(*e));
+
+	e->name = name;
+	e->attr.type = PERF_TYPE_TRACEPOINT;
+	e->attr.config = config;
+	e->attr.size = sizeof(e->attr);
+	e->attr.sample_period = PERF_SAMPLE_IDENTIFIER;
+	e->attr.inherit = 1;
+	e->attr.enable_on_exec = 1;
+	e->attr.exclude_guest = 1;
+
+	/* This has to match the structure layout in the header */
+	e->attr.read_format = PERF_FORMAT_TOTAL_TIME_ENABLED | \
+				PERF_FORMAT_TOTAL_TIME_RUNNING;
+	e->attr.disabled = 1;
+}
+
+
+static void prepare_events(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_MM_EVENTS; i++)
+		event_reset(&mm_events[i]);
+
+	for (i = 0; i < MAX_MM_EVENTS; i++)
+		event_enable(&mm_events[i]);
+}
+
+static void close_events(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_MM_EVENTS; i++)
+		event_close(&mm_events[i]);
+}
+
+static void display_events(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_MM_EVENTS; i++)
+		event_disable(&mm_events[i]);
+
+	for (i = 0; i < MAX_MM_EVENTS; i++)
+		event_read(&mm_events[i]);
+
+	for (i = 0; i < MAX_MM_EVENTS; i++)
+		printf("[%20s]: \t %llu\n", mm_events[i].name, mm_events[i].result.value);
+}
+
+static void setup_events(void)
+{
+	setup_event(&mm_events[0], PERF_COUNT_SW_PAGE_FAULTS, "faults");
+	setup_event(&mm_events[1], PERF_COUNT_SW_PAGE_FAULTS_MAJ, "major-faults");
+	setup_event(&mm_events[2], PERF_COUNT_SW_PAGE_FAULTS_MIN, "minor-faults");
+
+	setup_event_tr(&mm_events[3], 22 , "hash_faults");
+	setup_event_tr(&mm_events[4], 20 , "hash_faults_thp");
+	setup_event_tr(&mm_events[5], 19 , "hash_faults_64K");
+	setup_event_tr(&mm_events[6], 18 , "hash_faults_4K");
+	setup_event_tr(&mm_events[7], 21 , "hash_faults_hugetlb");
+}
+
+static void open_events()
+{
+	int i;
+
+	for (i = 0; i < MAX_MM_EVENTS; i++) {
+		if (event_open(&mm_events[i]))
+			perror("event_open() failed");
+	}
+}
+
+static void subpage_prot_change(char *ptr, unsigned long size)
+{
+	unsigned int *map;
+	unsigned long npages, i, err;
+
+	npages = size / PSIZE_64K;
+	map = malloc(sizeof(unsigned int) * npages);
+	if (!map)  {
+		perror("malloc() failed");
+		exit(-1);
+	}
+
+	for (i = 0; i < npages; i++)
+		map[i] = 0;
+
+	err = syscall(__NR_subpage_prot, ptr, size, map);
+	if (err) {
+		perror("subpage() protection failed");
+		exit(-1);
+	}
+}
+
+static void dont_need_request(char *ptr, unsigned long size)
+{
+	if (madvise(ptr, size, MADV_DONTNEED)){
+		perror("madvise");
+		exit(-1);
+	}
+}
+
+static void thp_request(char *ptr, unsigned long size)
+{
+	if (madvise(ptr, size, MADV_HUGEPAGE)){
+		perror("madvise");
+		exit(-1);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int nr_hp = strtol(argv[1], NULL, 0);
+	char *ptr, *htlb;
+
+	setup_events();
+	open_events();
+
+	do {
+		printf("HugeTLB allocation::::::::\n");
+		htlb = mmap(NULL, nr_hp * HPAGE_SIZE, PROT_READ | PROT_WRITE,MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE | MAP_HUGETLB, -1, 0);
+		if (!htlb) {
+			perror("mmap");
+			exit(-1);
+		}
+
+		prepare_events();
+		memset(htlb, 0, nr_hp * HPAGE_SIZE);
+		display_events();
+
+		printf("THP allocation::::::::\n");
+		ptr = mmap((void *) ADDR_INPUT, nr_hp * HPAGE_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
+		if (ptr != (void *) ADDR_INPUT) {
+			perror("mmap");
+			exit(-1);
+		}
+
+		thp_request(ptr, nr_hp * HPAGE_SIZE);
+		prepare_events();
+		memset(ptr, 0, nr_hp * HPAGE_SIZE);
+		display_events();
+
+		printf("SUBPAGE protection::::\n");
+		subpage_prot_change(ptr, nr_hp * HPAGE_SIZE);
+
+		prepare_events();
+		memset(ptr, 0, nr_hp * HPAGE_SIZE);
+		display_events();
+
+		printf("PFN flush::::::::::::\n");
+		dont_need_request(ptr, nr_hp * HPAGE_SIZE);
+
+		prepare_events();
+		memset(ptr, 0, nr_hp * HPAGE_SIZE);
+		display_events();
+
+		munmap(ptr, nr_hp * HPAGE_SIZE);
+		munmap(htlb, nr_hp * HPAGE_SIZE);
+
+	} while(0);
+	close_events();
+	return 0;
+}
diff --git a/tools/testing/selftests/powerpc/mm/run_mem_perf b/tools/testing/selftests/powerpc/mm/run_mem_perf
new file mode 100755
index 0000000..ee510f5
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/run_mem_perf
@@ -0,0 +1,3 @@
+sysctl vm.nr_hugepages=10
+./mem_perf 1
+sysctl vm.nr_hugepages=0
-- 
2.1.0
