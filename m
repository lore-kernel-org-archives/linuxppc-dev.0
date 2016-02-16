Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02C051A01DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 17:38:10 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 12:08:08 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G6bpvC40697970
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:07:52 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G6c4sg031153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 12:08:04 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V11_RESEND 10/10] selftests/powerpc: Add test for BHRB branch
 filters (HW & SW)
Date: Tue, 16 Feb 2016 12:07:10 +0530
Message-Id: <1455604630-16214-11-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455604630-16214-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455604630-16214-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a test for verifying that all the branch stack
sampling filters supported on powerpc work correctly. It also
adds some assembly helper functions in this regard. This patch
extends the generic event description to handle kernel mapped
ring buffers.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/pmu/Makefile       |  11 +-
 .../testing/selftests/powerpc/pmu/bhrb/.gitignore  |   1 +
 tools/testing/selftests/powerpc/pmu/bhrb/Makefile  |  13 +
 .../selftests/powerpc/pmu/bhrb/bhrb_filters.c      | 539 +++++++++++++++++++++
 .../selftests/powerpc/pmu/bhrb/bhrb_filters.h      |  15 +
 .../selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S  | 257 ++++++++++
 tools/testing/selftests/powerpc/pmu/event.h        |   5 +
 7 files changed, 839 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/Makefile
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
 create mode 100644 tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S

diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index ac41a71..37f0556 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -4,7 +4,7 @@ noarg:
 TEST_PROGS := count_instructions l3_bank_test per_event_excludes
 EXTRA_SOURCES := ../harness.c event.c lib.c ../utils.c
 
-all: $(TEST_PROGS) ebb
+all: $(TEST_PROGS) ebb bhrb
 
 $(TEST_PROGS): $(EXTRA_SOURCES)
 
@@ -20,25 +20,32 @@ DEFAULT_RUN_TESTS := $(RUN_TESTS)
 override define RUN_TESTS
 	$(DEFAULT_RUN_TESTS)
 	$(MAKE) -C ebb run_tests
+	$(MAKE) -C bhrb run_tests
 endef
 
 DEFAULT_EMIT_TESTS := $(EMIT_TESTS)
 override define EMIT_TESTS
 	$(DEFAULT_EMIT_TESTS)
 	$(MAKE) -s -C ebb emit_tests
+	$(MAKE) -s -C bhrb emit_tests
 endef
 
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
 	$(MAKE) -C ebb install
+	$(MAKE) -C bhrb install
 endef
 
 clean:
 	rm -f $(TEST_PROGS) loop.o
 	$(MAKE) -C ebb clean
+	$(MAKE) -C bhrb clean
 
 ebb:
 	$(MAKE) -k -C $@ all
 
-.PHONY: all run_tests clean ebb
+bhrb:
+	$(MAKE) -k -C $@ all
+
+.PHONY: all run_tests clean ebb bhrb
diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/.gitignore b/tools/testing/selftests/powerpc/pmu/bhrb/.gitignore
new file mode 100644
index 0000000..47c1049
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/bhrb/.gitignore
@@ -0,0 +1 @@
+bhrb_filters
diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/Makefile b/tools/testing/selftests/powerpc/pmu/bhrb/Makefile
new file mode 100644
index 0000000..61c032a
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/bhrb/Makefile
@@ -0,0 +1,13 @@
+noarg:
+	$(MAKE) -C ../../
+
+TEST_PROGS := bhrb_filters
+
+all: $(TEST_PROGS)
+
+$(TEST_PROGS): ../../harness.c ../event.c ../lib.c bhrb_filters_asm.S
+
+include ../../../lib.mk
+
+clean:
+	rm -f $(TEST_PROGS)
diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
new file mode 100644
index 0000000..e70444c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.c
@@ -0,0 +1,539 @@
+/*
+ * BHRB filter test (HW & SW)
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <poll.h>
+#include <sys/shm.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+
+#include "bhrb_filters.h"
+#include "utils.h"
+#include "../event.h"
+#include "../lib.h"
+
+/* Memory barriers */
+#define	smp_mb()	{ asm volatile ("sync" : : : "memory"); }
+
+/* Fetched address counts */
+#define ALL_MAX		32
+#define CALL_MAX	12
+#define RET_MAX		10
+#define COND_MAX	8
+#define IND_MAX		4
+
+/* Test tunables */
+#define LOOP_COUNT	10
+#define SAMPLE_PERIOD	10000
+
+static int branch_test_set[] = {
+		PERF_SAMPLE_BRANCH_ANY_CALL,		/* Single filters */
+		PERF_SAMPLE_BRANCH_ANY_RETURN,
+		PERF_SAMPLE_BRANCH_COND,
+		PERF_SAMPLE_BRANCH_IND_CALL,
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |		/* Double filters */
+		PERF_SAMPLE_BRANCH_ANY_RETURN,
+		PERF_SAMPLE_BRANCH_ANY_CALL |
+		PERF_SAMPLE_BRANCH_COND,
+		PERF_SAMPLE_BRANCH_ANY_CALL |
+		PERF_SAMPLE_BRANCH_IND_CALL,
+		PERF_SAMPLE_BRANCH_ANY_CALL |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_COND,
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_IND_CALL,
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_IND_CALL,
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_IND_CALL |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |		/* Triple filters */
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_COND,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_IND_CALL,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_IND_CALL,
+
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_IND_CALL |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |		/* Quadruple filters */
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_IND_CALL,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_IND_CALL |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_IND_CALL |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_IND_CALL |
+		PERF_SAMPLE_BRANCH_ANY,
+
+		PERF_SAMPLE_BRANCH_ANY_CALL |		/* All filters */
+		PERF_SAMPLE_BRANCH_ANY_RETURN |
+		PERF_SAMPLE_BRANCH_COND |
+		PERF_SAMPLE_BRANCH_IND_CALL |
+		PERF_SAMPLE_BRANCH_ANY };
+
+static unsigned int all_set[ALL_MAX], call_set[CALL_MAX];
+static unsigned int ret_set[RET_MAX], cond_set[COND_MAX], ind_set[IND_MAX];
+
+static bool has_failed;
+static unsigned long branch_any_call;
+static unsigned long branch_any_return;
+static unsigned long branch_cond;
+static unsigned long branch_ind_call;
+static unsigned long branch_any;
+static unsigned long branch_total;
+
+static void init_branch_stats(void)
+{
+	branch_any_call = 0;
+	branch_any_return = 0;
+	branch_cond = 0;
+	branch_ind_call = 0;
+	branch_any = 0;
+	branch_total = 0;
+}
+
+static void show_branch_stats(void)
+{
+	printf("BRANCH STATS\n");
+	printf("ANY_CALL:	%ld\n", branch_any_call);
+	printf("ANY_RETURN:	%ld\n", branch_any_return);
+	printf("COND:		%ld\n", branch_cond);
+	printf("IND_CALL:	%ld\n", branch_ind_call);
+	printf("ANY:		%ld\n", branch_any);
+	printf("TOTAL:		%ld\n", branch_total);
+
+}
+
+static void fetch_branches(void)
+{
+	int i;
+
+	/* Clear */
+	memset(all_set, 0, sizeof(all_set));
+	memset(call_set, 0, sizeof(call_set));
+	memset(ret_set, 0, sizeof(ret_set));
+	memset(cond_set, 0, sizeof(cond_set));
+	memset(ind_set, 0, sizeof(ind_set));
+
+	/* Fetch */
+	fetch_all_branches(all_set);
+	fetch_all_calls(call_set);
+	fetch_all_rets(ret_set);
+	fetch_all_conds(cond_set);
+	fetch_all_inds(ind_set);
+
+	/* Display */
+	printf("ANY branches\n");
+	for (i = 0; i < ALL_MAX; i += 2)
+		printf("%x ---> %x\n", all_set[i], all_set[i + 1]);
+
+	printf("ANY_CALL branches\n");
+	for (i = 0; i < CALL_MAX; i += 2)
+		printf("%x ---> %x\n", call_set[i], call_set[i + 1]);
+
+	printf("ANY_RETURN branches\n");
+	for (i = 0; i < RET_MAX; i += 2)
+		printf("%x ---> %x\n", ret_set[i], ret_set[i + 1]);
+
+	printf("COND branches\n");
+	for (i = 0; i < COND_MAX; i += 2)
+		printf("%x ---> %x\n", cond_set[i], cond_set[i + 1]);
+
+	printf("IND_CALL branches\n");
+	for (i = 0; i < IND_MAX; i += 2)
+		printf("%x ---> %x\n", ind_set[i], ind_set[i + 1]);
+
+}
+
+/* Perf mmap stats */
+static unsigned long record_sample;
+static unsigned long record_mmap;
+static unsigned long record_lost;
+static unsigned long record_throttle;
+static unsigned long record_unthrottle;
+static unsigned long record_overlap;
+
+static void init_perf_mmap_stats(void)
+{
+	record_sample = 0;
+	record_mmap = 0;
+	record_lost = 0;
+	record_throttle = 0;
+	record_unthrottle = 0;
+	record_overlap = 0;
+}
+
+static void show_perf_mmap_stats(void)
+{
+	printf("PERF STATS\n");
+	printf("OVERLAP:		%ld\n", record_overlap);
+	printf("RECORD_SAMPLE:		%ld\n", record_sample);
+	printf("RECORD_MAP:		%ld\n", record_mmap);
+	printf("RECORD_LOST:		%ld\n", record_lost);
+	printf("RECORD_THROTTLE:	%ld\n", record_throttle);
+	printf("RECORD_UNTHROTTLE:	%ld\n", record_unthrottle);
+}
+
+static bool search_all_set(unsigned long from, unsigned long to)
+{
+	int i;
+
+	for (i = 0; i < ALL_MAX; i += 2) {
+		if ((all_set[i] == from) && (all_set[i+1] == to))
+			return true;
+	}
+	return false;
+}
+
+static bool search_call_set(unsigned long from, unsigned long to)
+{
+	int i;
+
+	for (i = 0; i < CALL_MAX; i += 2) {
+		if ((call_set[i] == from) && (call_set[i+1] == to))
+			return true;
+	}
+	return false;
+}
+
+static bool search_ret_set(unsigned long from, unsigned long to)
+{
+	int i;
+
+	for (i = 0; i < RET_MAX; i += 2) {
+		if ((ret_set[i] == from) && (ret_set[i+1] == to))
+			return true;
+	}
+	return false;
+}
+
+static bool search_cond_set(unsigned long from, unsigned long to)
+{
+	int i;
+
+	for (i = 0; i < COND_MAX; i += 2) {
+		if ((cond_set[i] == from) && (cond_set[i+1] == to))
+			return true;
+	}
+	return false;
+}
+
+static bool search_ind_set(unsigned long from, unsigned long to)
+{
+	int i;
+
+	for (i = 0; i < IND_MAX; i += 2) {
+		if ((ind_set[i] == from) && (ind_set[i+1] == to))
+			return true;
+	}
+	return false;
+}
+
+static int check_branch(unsigned long from, unsigned long to,
+					int branch_sample_type)
+{
+	bool result = false;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_CALL) {
+		if (search_call_set(from, to)) {
+			branch_any_call++;
+			result = true;
+		}
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY_RETURN) {
+		if (search_ret_set(from, to)) {
+			branch_any_return++;
+			result = true;
+		}
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_COND) {
+		if (search_cond_set(from, to)) {
+			branch_cond++;
+			result = true;
+		}
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_IND_CALL) {
+		if (search_ind_set(from, to)) {
+			branch_ind_call++;
+			result = true;
+		}
+	}
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY) {
+		if (search_all_set(from, to)) {
+			branch_any++;
+			result = true;
+		}
+	}
+
+	branch_total++;
+	return result;
+}
+
+static int64_t *ring_buffer_offset(struct ring_buffer *r, void *p)
+{
+	unsigned long l = (unsigned long)p;
+
+	return (int64_t *)(r->ring_base + ((l - r->ring_base) & r->mask));
+}
+
+static void dump_sample(struct perf_event_header *hdr,
+			struct ring_buffer *r, int branch_sample_type)
+{
+	int64_t from, to, flag;
+	int64_t *v, nr;
+	int i;
+
+	/* NR Branches */
+	v = ring_buffer_offset(r, hdr + 1);
+
+	nr = *v;
+
+	/* Branches */
+	for (i = 0; i < nr; i++) {
+		v = ring_buffer_offset(r, v + 1);
+		from = *v;
+
+		v = ring_buffer_offset(r, v + 1);
+		to = *v;
+
+		v = ring_buffer_offset(r, v + 1);
+		flag = *v;
+
+		/* Skip incomplete branch records */
+		if (!from || !to)
+			continue;
+
+		if (!check_branch(from, to, branch_sample_type)) {
+			has_failed = true;
+			printf("[Filter: %d] From: %lx To: %lx Flags: %lx\n",
+					branch_sample_type, from, to, flag);
+		}
+	}
+}
+
+/*
+ * XXX: Both the memory barriers used here are as per the
+ * directive mentioned in the header include/uapi/linux/
+ * perf_event.h while describing the perf_event_mmap_page
+ * structure.
+ */
+static void read_ring_buffer(struct event *e, int branch_sample_type)
+{
+	struct ring_buffer *r = &e->ring_buffer;
+	struct perf_event_header *hdr;
+	int tail, head;
+
+	head = r->page->data_head & r->mask;
+
+	/* XXX: perf kernel interface requires read barrier */
+	smp_mb();
+
+	tail = r->page->data_tail & r->mask;
+
+	while (tail != head) {
+		hdr = (struct perf_event_header *)(r->ring_base + tail);
+
+		if ((tail & r->mask) + hdr->size !=
+					((tail + hdr->size) & r->mask))
+			++record_overlap;
+
+		if (hdr->type == PERF_RECORD_SAMPLE) {
+			++record_sample;
+			dump_sample(hdr, r, branch_sample_type);
+		}
+
+		if (hdr->type == PERF_RECORD_MMAP)
+			++record_mmap;
+
+		if (hdr->type == PERF_RECORD_LOST)
+			++record_lost;
+
+		if (hdr->type == PERF_RECORD_THROTTLE)
+			++record_throttle;
+
+		if (hdr->type == PERF_RECORD_UNTHROTTLE)
+			++record_unthrottle;
+
+		tail = (tail + hdr->size) & r->mask;
+	}
+
+	/* XXX: perf kernel interface requires read and write barrier */
+	smp_mb();
+	r->page->data_tail = tail;
+}
+
+static void event_mmap(struct event *e)
+{
+	struct ring_buffer *r = &e->ring_buffer;
+
+	r->page = mmap(NULL, 9 * getpagesize(), PROT_READ |
+					PROT_WRITE, MAP_SHARED, e->fd, 0);
+
+	if (r->page == MAP_FAILED) {
+		r->page = NULL;
+		perror("mmap() failed");
+	}
+
+	r->mask = (8 * getpagesize()) - 1;
+	r->ring_base = (unsigned long)r->page + getpagesize();
+
+}
+
+static int filter_test(int branch_sample_type)
+{
+	struct pollfd pollfd;
+	struct event ebhrb;
+	pid_t pid;
+	int ret, loop = 0;
+
+	has_failed = false;
+	pid = fork();
+	if (pid == -1) {
+		perror("fork() failed");
+		return 1;
+	}
+
+	/* Run child */
+	if (pid == 0) {
+		start_loop();
+		exit(0);
+	}
+
+	/* Prepare event */
+	event_init_opts(&ebhrb, PERF_COUNT_HW_INSTRUCTIONS,
+				PERF_TYPE_HARDWARE, "instructions");
+	ebhrb.attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
+	ebhrb.attr.disabled = 1;
+	ebhrb.attr.mmap = 1;
+	ebhrb.attr.mmap_data = 1;
+	ebhrb.attr.sample_period = SAMPLE_PERIOD;
+	ebhrb.attr.exclude_user = 0;
+	ebhrb.attr.exclude_kernel = 1;
+	ebhrb.attr.exclude_hv = 1;
+	ebhrb.attr.branch_sample_type = branch_sample_type;
+
+	/* Open event */
+	event_open_with_pid(&ebhrb, pid);
+
+	/* Mmap ring buffer and enable event */
+	event_mmap(&ebhrb);
+	FAIL_IF(event_enable(&ebhrb));
+
+	/* Prepare polling */
+	pollfd.fd = ebhrb.fd;
+	pollfd.events = POLLIN;
+
+	for (loop = 0; loop < LOOP_COUNT; loop++) {
+		ret = poll(&pollfd, 1, -1);
+		if (ret == -1) {
+			perror("poll() failed");
+			goto error;
+		}
+		if (ret == 0) {
+			perror("poll() timeout");
+			goto error;
+		}
+		read_ring_buffer(&ebhrb, branch_sample_type);
+		if (has_failed)
+			goto error;
+	}
+
+	/* Disable and close event */
+	FAIL_IF(event_disable(&ebhrb));
+	event_close(&ebhrb);
+
+	/* Terminate child */
+	kill(pid, SIGKILL);
+	return 0;
+
+error:
+	/* Disable and close event */
+	FAIL_IF(event_disable(&ebhrb));
+	event_close(&ebhrb);
+
+	/* Terminate child */
+	kill(pid, SIGKILL);
+	return 1;
+}
+
+static int  bhrb_filters_test(void)
+{
+	int branch_sample_type;
+	int i;
+
+	/* Fetch branches */
+	fetch_branches();
+	init_branch_stats();
+	init_perf_mmap_stats();
+
+	for (i = 0; i < sizeof(branch_test_set)/sizeof(int); i++) {
+		branch_sample_type = branch_test_set[i];
+		if (filter_test(branch_sample_type))
+			return 1;
+	}
+
+	/* Show stats */
+	show_branch_stats();
+	show_perf_mmap_stats();
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(bhrb_filters_test, "bhrb_filters");
+}
diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
new file mode 100644
index 0000000..9c12229
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+/* Assembly routines */
+extern void fetch_all_branches(unsigned int *);
+extern void fetch_all_calls(unsigned int *);
+extern void fetch_all_rets(unsigned int *);
+extern void fetch_all_conds(unsigned int *);
+extern void fetch_all_inds(unsigned int *);
+extern void start_loop(void);
diff --git a/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S
new file mode 100644
index 0000000..cdd7bce
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/bhrb/bhrb_filters_asm.S
@@ -0,0 +1,257 @@
+/*
+ * Assembly functions for BHRB test
+ *
+ * Copyright (C) 2015 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ */
+
+#include <ppc-asm.h>
+
+#define LR_SAVE r19
+
+#define LOAD_ADDR(reg, label)			\
+	lis     reg,(label)@highest;		\
+	ori     reg,reg,(label)@higher;		\
+	rldicr  reg,reg,32,31;			\
+	oris    reg,reg,(label)@h;		\
+	ori     reg,reg,(label)@l;		\
+
+#define LOAD_LABEL(reg1, label1, reg2, label2)	\
+	lis     reg1,(label1)@highest;		\
+	ori     reg1,reg1,(label1)@higher;	\
+	rldicr  reg1,reg1,32,31;		\
+	oris    reg1,reg1,(label1)@h;		\
+	ori     reg1,reg1,(label1)@l;		\
+	lis     reg2,(label2)@highest;		\
+	ori     reg2,reg2,(label2)@higher;	\
+	rldicr  reg2,reg2,32,31;		\
+	oris    reg2,reg2,(label2)@h;		\
+	ori     reg2,reg2,(label2)@l;		\
+
+FUNC_START(start_loop)
+label:
+	b label0			/* ANY */
+	blr				/* ANY_RETURN */
+label0:
+	b label1			/* ANY */
+
+label1:
+	b label2			/* ANY */
+
+label2:
+	b label3			/* ANY */
+
+label3:
+	mflr LR_SAVE
+	bl label4			/* ANY | ANY_CALL */
+	mtlr LR_SAVE
+	b start_loop			/* ANY */
+label4:
+	mflr LR_SAVE
+	li r20, 12
+	cmpi r3, r20, 12
+	bcl 12, 4 * cr3+2, label5	/* ANY | ANY_CALL | COND */
+	li r20, 12
+	cmpi r4, r20, 20
+	bcl 12, 4 * cr4+0, label5	/* ANY | ANY_CALL | COND */
+	LOAD_ADDR(r20, label5)
+	mtctr r20
+	li r22, 10
+	cmpi r0, r22, 10
+	bcctrl 12, 4*cr0+2		/* ANY | NY_CALL | IND_CALL | COND */
+	LOAD_ADDR(r20, label5)
+	mtlr r20
+	li      r20, 10
+	cmpi    r0, r20, 10
+	bclrl   12, 4*cr0+2		/* ANY | ANY_CALL | IND_CALL | COND */
+	mtlr LR_SAVE
+	blr				/* ANY | ANY_RETURN */
+
+label5:
+	blr				/* ANY | ANY_RETURN */
+FUNC_END(start_loop)
+
+/* Volatile Registers */
+#define REG1	r4
+#define REG2	r5
+
+FUNC_START(fetch_all_branches)
+	LOAD_LABEL(REG1, label, REG2, label0)
+	st REG1, 0(r3)
+	st REG2, 4(r3)
+
+	LOAD_LABEL(REG1, label0, REG2, label1)
+	st REG1, 8(r3)
+	st REG2, 12(r3)
+
+	LOAD_LABEL(REG1, label1, REG2, label2)
+	st REG1, 16(r3)
+	st REG2, 20(r3)
+
+	LOAD_LABEL(REG1, label2, REG2, label3)
+	st REG1, 24(r3)
+	st REG2, 28(r3)
+
+	LOAD_LABEL(REG1, label3, REG2, label4)
+	addi REG1, REG1, 4
+	st REG1, 32(r3)
+	st REG2, 36(r3)
+
+	LOAD_LABEL(REG1, label3, REG2, label)
+	addi REG1, REG1, 12
+	st REG1, 40(r3)
+	st REG2, 44(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 12
+	st REG1, 48(r3)
+	st REG2, 52(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 24
+	st REG1, 56(r3)
+	st REG2, 60(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 60
+	st REG1, 64(r3)
+	st REG2, 68(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 96
+	st REG1, 72(r3)
+	st REG2, 76(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 104
+	st REG1, 80(r3)
+	st REG2, 84(r3)
+
+	LOAD_LABEL(REG1, label5, REG2, label4)
+	st REG1, 88(r3)
+	addi REG2, REG2, 16
+	st REG2, 92(r3)
+
+	LOAD_LABEL(REG1, label5, REG2, label4)
+	st REG1, 96(r3)
+	addi REG2, REG2, 28
+	st REG2, 100(r3)
+
+	LOAD_LABEL(REG1, label5, REG2, label4)
+	st REG1, 104(r3)
+	addi REG2, REG2, 64
+	st REG2, 108(r3)
+
+	LOAD_LABEL(REG1, label5, REG2, label4)
+	st REG1, 112(r3)
+	addi REG2, REG2, 100
+	st REG2, 116(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label3)
+	addi REG1, REG1, 104
+	st REG1, 120(r3)
+	addi REG2, REG2, 8
+	st REG2, 124(r3)
+	blr
+FUNC_END(fetch_all_branches)
+
+FUNC_START(fetch_all_calls)
+	LOAD_LABEL(REG1, label3, REG2, label4)
+	addi REG1, REG1, 4
+	st REG1, 0(r3)
+	st REG2, 4(r3)
+
+	LOAD_LABEL(REG1, label3, REG2, label4)
+	addi REG1, REG1, 4
+	st REG1, 8(r3)
+	st REG2, 12(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 12
+	st REG1, 16(r3)
+	st REG2, 20(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 24
+	st REG1, 24(r3)
+	st REG2, 28(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 60
+	st REG1, 32(r3)
+	st REG2, 36(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 96
+	st REG1, 40(r3)
+	st REG2, 44(r3)
+	blr
+FUNC_END(fetch_all_calls)
+
+FUNC_START(fetch_all_rets)
+	LOAD_LABEL(REG1, label5, REG2, label4)
+	st REG1, 0(r3)
+	addi REG2, REG2, 16
+	st REG2, 4(r3)
+
+	LOAD_LABEL(REG1, label5, REG2, label4)
+	st REG1, 8(r3)
+	addi REG2, REG2, 28
+	st REG2, 12(r3)
+
+	LOAD_LABEL(REG1, label5, REG2, label4)
+	st REG1, 16(r3)
+	addi REG2, REG2, 64
+	st REG2, 20(r3)
+
+	LOAD_LABEL(REG1, label5, REG2, label4)
+	st REG1, 24(r3)
+	addi REG2, REG2, 100
+	st REG2, 28(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label3)
+	addi REG1, REG1, 104
+	st REG1, 32(r3)
+	addi REG2, REG2, 8
+	st REG2, 36(r3)
+	blr
+FUNC_END(fetch_all_rets)
+
+FUNC_START(fetch_all_conds)
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 12
+	st REG1, 0(r3)
+	st REG2, 4(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 24
+	st REG1, 8(r3)
+	st REG2, 12(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 60
+	st REG1, 16(r3)
+	st REG2, 20(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 96
+	st REG1, 24(r3)
+	st REG2, 28(r3)
+	blr
+FUNC_END(fetch_all_conds)
+
+FUNC_START(fetch_all_inds)
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 60
+	st REG1, 0(r3)
+	st REG2, 4(r3)
+
+	LOAD_LABEL(REG1, label4, REG2, label5)
+	addi REG1, REG1, 96
+	st REG1, 8(r3)
+	st REG2, 12(r3)
+	blr
+FUNC_END(fetch_all_inds)
diff --git a/tools/testing/selftests/powerpc/pmu/event.h b/tools/testing/selftests/powerpc/pmu/event.h
index a0ea6b1..385b1c4 100644
--- a/tools/testing/selftests/powerpc/pmu/event.h
+++ b/tools/testing/selftests/powerpc/pmu/event.h
@@ -11,6 +11,10 @@
 
 #include "utils.h"
 
+struct ring_buffer {
+	struct perf_event_mmap_page *page;
+	unsigned long ring_base, old, mask;
+};
 
 struct event {
 	struct perf_event_attr attr;
@@ -22,6 +26,7 @@ struct event {
 		u64 running;
 		u64 enabled;
 	} result;
+	struct ring_buffer ring_buffer;
 };
 
 void event_init(struct event *e, u64 config);
-- 
2.1.0
