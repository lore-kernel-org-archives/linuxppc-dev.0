Return-Path: <dgibson@ozlabs.org>
Date: Mon, 7 Jul 2008 17:19:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: libhugetlbfs-devel@lists.sourceforge.net
Subject: libbugetlbfs: Test case for powerpc huge_ptep_set_wrprotect() bug
Message-ID: <20080707071955.GA27709@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Until very recently (in fact, even now in mainline) powerpc kernels
had a bug in huge_ptep_set_wrprotect() which meant the 'huge' flag was
not passed down to pte_update() and hpte_need_flush().  This meant the
hash ptes for hugepages would not be correctly flushed on fork(),
allowing the parent to pollute the child's mapping after the fork().

This patch adds a testcase to libhugetlbfs for this behaviour, also
doing some other checking of the COW semantics over a fork().

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: libhugetlbfs/tests/Makefile
===================================================================
--- libhugetlbfs.orig/tests/Makefile	2008-07-03 13:27:18.000000000 +1000
+++ libhugetlbfs/tests/Makefile	2008-07-03 15:27:05.000000000 +1000
@@ -1,7 +1,7 @@
 PREFIX = /usr/local
 
 LIB_TESTS = gethugepagesize test_root find_path unlinked_fd misalign \
-	readback truncate shared private empty_mounts meminfo_nohuge \
+	readback truncate shared private fork-cow empty_mounts meminfo_nohuge \
 	ptrace-write-hugepage icache-hygiene slbpacaflush \
 	chunk-overcommit mprotect alloc-instantiate-race mlock \
 	truncate_reserve_wraparound truncate_sigbus_versus_oom \
Index: libhugetlbfs/tests/fork-cow.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ libhugetlbfs/tests/fork-cow.c	2008-07-07 16:40:17.000000000 +1000
@@ -0,0 +1,159 @@
+/*
+ * libhugetlbfs - Easy use of Linux hugepages
+ * Copyright (C) 2008 David Gibson, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public License
+ * as published by the Free Software Foundation; either version 2.1 of
+ * the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+#define _GNU_SOURCE
+
+#include <sys/types.h>
+#include <sys/shm.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <hugetlbfs.h>
+#include "hugetests.h"
+
+/*
+ * Test rationale:
+ *
+ * This checks copy-on-write semantics, specifically the semantics of
+ * a MAP_PRIVATE mapping across a fork().  Some versions of the
+ * powerpc kernel had a bug in huge_ptep_set_wrprotect() which would
+ * fail to flush the hash table after setting the write protect bit in
+ * the parent's page tables, thus allowing the parent to pollute the
+ * child's mapping.
+ */
+
+#define RANDOM_CONSTANT		0x1234ABCD
+#define OTHER_CONSTANT		0xfeef5678
+
+int main(int argc, char ** argv)
+{
+	int fd, ret, status;
+	void *syncarea;
+	volatile unsigned int *p;
+	volatile unsigned int *trigger, *child_readback;
+	unsigned int parent_readback;
+	long hpage_size;
+	pid_t pid;
+
+	test_init(argc, argv);
+
+	if (argc != 1)
+		CONFIG("Usage: fork-cow\n");
+
+	/* Get a shared normal page for synchronization */
+	verbose_printf("Mapping synchronization area..");
+	syncarea = mmap(NULL, getpagesize(), PROT_READ|PROT_WRITE,
+			MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+	if (syncarea == MAP_FAILED)
+		FAIL("mmap() sync area: %s", strerror(errno));
+	verbose_printf("done\n");
+
+	trigger = syncarea;
+	*trigger = 0;
+
+	child_readback = trigger + 1;
+	*child_readback = 0;
+
+	hpage_size = check_hugepagesize();
+
+	fd = hugetlbfs_unlinked_fd();
+	if (fd < 0)
+		CONFIG("hugetlbfs_unlinked_fd() failed: %s\n",
+		       strerror(errno));
+
+	verbose_printf("Mapping hugepage area...");
+	p = mmap(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+	if (p == MAP_FAILED)
+		FAIL("mmap(): %s", strerror(errno));
+	verbose_printf("mapped at %p\n", p);
+
+	/* Touch the page for write in parent */
+	verbose_printf("Parent writes pre-fork...");
+	*p = RANDOM_CONSTANT;
+	verbose_printf("%x\n", RANDOM_CONSTANT);
+
+	if ((pid = fork()) < 0)
+		FAIL("fork(): %s", strerror(errno));
+
+	if (pid != 0) {
+		/* Parent */
+		verbose_printf("Parent writes post-fork...");
+		*p = ~RANDOM_CONSTANT;
+		verbose_printf("%x\n", ~RANDOM_CONSTANT);
+
+		*trigger = 1;
+
+		while (*trigger != 2)
+			;
+
+		verbose_printf("Parent reads..");
+		parent_readback = *p;
+		verbose_printf("%x\n", parent_readback);
+
+		*trigger = 3;
+	} else {
+		/* Child */
+		verbose_printf("Child starts..\n");
+
+		while (*trigger != 1)
+			;
+
+		verbose_printf("Child reads...");
+		*child_readback = *p;
+		verbose_printf("%x\n", *child_readback);
+
+		verbose_printf("Child writes...");
+		*p = OTHER_CONSTANT;
+		verbose_printf("%x\n", OTHER_CONSTANT);
+
+		*trigger = 2;
+
+		while (*trigger != 3)
+			;
+
+		verbose_printf("Child exits...\n");
+		exit(0);
+	}
+
+	verbose_printf("child_readback = 0x%x, parent_readback = 0x%x\n",
+		       *child_readback, parent_readback);
+
+	if (*child_readback != RANDOM_CONSTANT)
+		FAIL("Child read back 0x%x instead of 0x%x",
+		     *child_readback, RANDOM_CONSTANT);
+	if (parent_readback != ~RANDOM_CONSTANT)
+		FAIL("Parent read back 0x%x instead of 0x%x",
+		     parent_readback, RANDOM_CONSTANT);
+
+	ret = waitpid(pid, &status, 0);
+	if (ret < 0)
+		FAIL("waitpid(): %s", strerror(errno));
+	if (WEXITSTATUS(status) != 0)
+		FAIL("Child failed: %d", WEXITSTATUS(status));
+	if (WIFSIGNALED(status))
+		FAIL("Child recived signal %s", strsignal(WTERMSIG(status)));
+
+	PASS();
+}
Index: libhugetlbfs/tests/run_tests.sh
===================================================================
--- libhugetlbfs.orig/tests/run_tests.sh	2008-07-03 15:15:48.000000000 +1000
+++ libhugetlbfs/tests/run_tests.sh	2008-07-03 15:27:06.000000000 +1000
@@ -207,6 +207,7 @@ functional_tests () {
 
 # Tests requiring an active mount and hugepage COW
     run_test private
+    run_test fork-cow
     run_test direct
     run_test malloc
     preload_test HUGETLB_MORECORE=yes malloc


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
