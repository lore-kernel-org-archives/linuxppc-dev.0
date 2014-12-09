Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FADB1A02F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 17:14:39 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 9 Dec 2014 11:44:36 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id DB683E005A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 11:45:08 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB96F49w54460454
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 11:45:05 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB96EQdA022738
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Dec 2014 11:44:27 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] selftest/ppc: Add subpage protection self test.
Date: Tue,  9 Dec 2014 11:44:07 +0530
Message-Id: <1418105647-1954-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/mm/Makefile       |   2 +-
 tools/testing/selftests/powerpc/mm/subpage_prot.c | 201 ++++++++++++++++++++++
 2 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/subpage_prot.c

diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index 357ccbd6bad9..fb00c6f7d675 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -1,7 +1,7 @@
 noarg:
 	$(MAKE) -C ../
 
-PROGS := hugetlb_vs_thp_test
+PROGS := hugetlb_vs_thp_test subpage_prot
 
 all: $(PROGS)
 
diff --git a/tools/testing/selftests/powerpc/mm/subpage_prot.c b/tools/testing/selftests/powerpc/mm/subpage_prot.c
new file mode 100644
index 000000000000..62f0db3e3fb2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/subpage_prot.c
@@ -0,0 +1,201 @@
+/*
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <signal.h>
+#include <stdarg.h>
+#include <sys/ptrace.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <ucontext.h>
+#include <assert.h>
+#include <fcntl.h>
+
+#include "utils.h"
+
+void *mallocblock;
+unsigned long mallocsize;
+char *file_name;
+void *fileblock;
+off_t filesize;
+
+int in_test;
+volatile int faulted;
+volatile void *dar;
+int errors;
+
+static void segv(int signum, siginfo_t *info, void *ctxt_v)
+{
+	ucontext_t *ctxt = (ucontext_t *)ctxt_v;
+	struct pt_regs *regs = ctxt->uc_mcontext.regs;
+
+	if (!in_test) {
+		fprintf(stderr, "Segfault outside of test !\n");
+		exit(1);
+	}
+	faulted = 1;
+	dar = (void *)regs->dar;
+	regs->nip += 4;
+}
+
+static inline void do_read(const volatile void *addr)
+{
+	int ret;
+
+	asm volatile("lwz %0,0(%1); twi 0,%0,0; isync;\n"
+		     : "=r" (ret) : "r" (addr) : "memory");
+}
+
+static inline void do_write(const volatile void *addr)
+{
+	int val = 0x1234567;
+
+	asm volatile("stw %0,0(%1); sync; \n"
+		     : : "r" (val), "r" (addr) : "memory");
+}
+
+static inline void check_faulted(void *addr, long page, long subpage, int write)
+{
+	int want_fault = (subpage == ((page + 3) % 16));
+
+	if (write)
+		want_fault |= (subpage == ((page + 1) % 16));
+
+	if (faulted != want_fault) {
+		printf("Failed at 0x%p (p=%ld,sp=%ld,w=%d), want=%s, got=%s !\n",
+		       addr, page, subpage, write,
+		       want_fault ? "fault" : "pass",
+		       faulted ? "fault" : "pass");
+		++errors;
+	}
+	if (faulted) {
+		if (dar != addr) {
+			printf("Fault expected at 0x%p and happened at 0x%p !\n",
+			       addr, dar);
+		}
+		faulted = 0;
+		asm volatile("sync" : : : "memory");
+	}
+}
+
+static int run_test(void *addr, unsigned long size)
+{
+	unsigned int *map;
+	long i, j, pages, err;
+
+	pages = size / 0x10000;
+	map = malloc(pages * 4);
+	assert(map);
+
+	/* for each page, mark subpage i % 16 read only and subpage
+	 * (i + 3) % 16 inaccessible
+	 */
+	for (i = 0; i < pages; i++)
+		map[i] = (0x40000000 >> (((i + 1) * 2) % 32)) |
+			(0xc0000000 >> (((i + 3) * 2) % 32));
+	err = syscall(310, addr, size, map);
+	if (err) {
+		perror("subpage_perm");
+		return 1;
+	}
+	free(map);
+
+	in_test = 1;
+	errors = 0;
+	for (i = 0; i < pages; i++)
+		for (j = 0; j < 16; j++, addr += 0x1000) {
+			do_read(addr);
+			check_faulted(addr, i, j, 0);
+			do_write(addr);
+			check_faulted(addr, i, j, 1);
+		}
+	in_test = 0;
+	if (errors) {
+		printf("%d errors detected\n", errors);
+		return 1;
+	}
+	return 0;
+}
+
+int test_anon(void)
+{
+	unsigned long align;
+
+	if (getpagesize() != 0x10000) {
+		fprintf(stderr, "Kernel page size must be 64K!\n");
+		return 1;
+	}
+
+	struct sigaction act = {
+		.sa_sigaction = segv,
+		.sa_flags = SA_SIGINFO
+	};
+	sigaction(SIGSEGV, &act, NULL);
+
+	mallocsize = 4*16*1024*1024;
+	posix_memalign(&mallocblock, 64*1024, mallocsize);
+	assert(mallocblock);
+	align = (unsigned long)mallocblock;
+	if (align & 0xffff)
+		align = (align | 0xffff) + 1;
+	mallocblock = (void *)align;
+
+	printf("allocated malloc block of 0x%lx bytes at 0x%p\n",
+	       mallocsize, mallocblock);
+
+	printf("testing malloc block...\n");
+	return run_test(mallocblock, mallocsize);
+}
+
+int test_file(void)
+{
+	struct sigaction act = {
+		.sa_sigaction = segv,
+		.sa_flags = SA_SIGINFO
+	};
+	int fd = open(file_name, O_RDWR);
+
+	if (fd == -1) {
+		perror("failed to open file");
+		return 1;
+	}
+	sigaction(SIGSEGV, &act, NULL);
+
+
+	filesize = lseek(fd, 0, SEEK_END);
+	if (filesize & 0xffff)
+		filesize &= ~0xfffful;
+	fileblock = mmap(NULL, filesize, PROT_READ | PROT_WRITE,
+			 MAP_SHARED, fd, 0);
+	if (fileblock == MAP_FAILED) {
+		perror("failed to map file");
+		return 1;
+	}
+	printf("allocated %s for 0x%lx bytes at 0x%p\n",
+	       file_name, filesize, fileblock);
+
+	printf("testing file map...\n");
+	return run_test(fileblock, filesize);
+}
+
+int main(int argc, char *argv[])
+{
+	test_harness(test_anon, "subpage_prot_anon");
+	if (argc > 1) {
+		file_name = argv[1];
+		test_harness(test_file, "subpage_prot_file");
+	}
+	return 0;
+}
-- 
2.1.0
