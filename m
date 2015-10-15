Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0265B1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 02:46:17 +1100 (AEDT)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 06BD21402D0
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2015 02:46:15 +1100 (AEDT)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 15 Oct 2015 21:16:13 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D7E321258018
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 21:15:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9FFk8EP64291042
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 21:16:08 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9FFk7NM011393
 for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2015 21:16:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] selfttest/powerpc: Add memory page migration tests
Date: Thu, 15 Oct 2015 21:16:07 +0530
Message-Id: <1444923967-22899-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds two tests for memory page migration. One for normal page
migration which works for both 4K or 64K base page size kernel and
the other one is for 16MB huge page migration which will work both
4K or 64K base page sized 16MB huge pages as and when we support
huge page migration.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
- Works for normal page migration on both 64K and 4K base pages
- Works for 16MB huge page migration (64K) on Aneesh's V2 PTE changes

 tools/testing/selftests/powerpc/mm/Makefile        |  14 +-
 .../selftests/powerpc/mm/hugepage-migration.c      |  30 ++++
 tools/testing/selftests/powerpc/mm/migration.h     | 196 +++++++++++++++++++++
 .../testing/selftests/powerpc/mm/page-migration.c  |  33 ++++
 tools/testing/selftests/powerpc/mm/run_mmtests     |  21 +++
 5 files changed, 289 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/hugepage-migration.c
 create mode 100644 tools/testing/selftests/powerpc/mm/migration.h
 create mode 100644 tools/testing/selftests/powerpc/mm/page-migration.c
 create mode 100755 tools/testing/selftests/powerpc/mm/run_mmtests

diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index ee179e2..c482614 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -1,12 +1,16 @@
 noarg:
 	$(MAKE) -C ../
 
-TEST_PROGS := hugetlb_vs_thp_test subpage_prot
-TEST_FILES := tempfile
+TEST_PROGS := run_mmtests
+TEST_FILES := hugetlb_vs_thp_test
+TEST_FILES += subpage_prot
+TEST_FILES += tempfile
+TEST_FILES += hugepage-migration
+TEST_FILES += page-migration
 
-all: $(TEST_PROGS) $(TEST_FILES)
+all: $(TEST_FILES)
 
-$(TEST_PROGS): ../harness.c
+$(TEST_FILES): ../harness.c
 
 include ../../lib.mk
 
@@ -14,4 +18,4 @@ tempfile:
 	dd if=/dev/zero of=tempfile bs=64k count=1
 
 clean:
-	rm -f $(TEST_PROGS) tempfile
+	rm -f $(TEST_FILES)
diff --git a/tools/testing/selftests/powerpc/mm/hugepage-migration.c b/tools/testing/selftests/powerpc/mm/hugepage-migration.c
new file mode 100644
index 0000000..b60bc10
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/hugepage-migration.c
@@ -0,0 +1,30 @@
+/*
+ * Copyright (C) 2015, Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+#include "migration.h"
+
+static int hugepage_migration(void)
+{
+	int ret = 0;
+
+	if ((unsigned long)getpagesize() == 0x1000)
+		printf("Running on base page size 4K\n");
+
+	if ((unsigned long)getpagesize() == 0x10000)
+		printf("Running on base page size 64K\n");
+
+	ret = test_huge_migration(16 * MEM_MB);
+	ret = test_huge_migration(256 * MEM_MB);
+	ret = test_huge_migration(512 * MEM_MB);
+
+	return ret;
+}
+
+int main(void)
+{
+	return test_harness(hugepage_migration, "hugepage_migration");
+}
diff --git a/tools/testing/selftests/powerpc/mm/migration.h b/tools/testing/selftests/powerpc/mm/migration.h
new file mode 100644
index 0000000..2f9e3f9
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/migration.h
@@ -0,0 +1,196 @@
+/*
+ * Copyright (C) 2015, Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+
+#include "utils.h"
+
+#define HPAGE_OFF	0
+#define HPAGE_ON	1
+
+#define PAGE_SHIFT_4K	12
+#define PAGE_SHIFT_64K	16
+#define PAGE_SIZE_4K	0x1000
+#define PAGE_SIZE_64K	0x10000
+#define PAGE_SIZE_HUGE	16UL * 1024 * 1024
+
+#define MEM_GB		1024UL * 1024 * 1024
+#define MEM_MB		1024UL * 1024
+#define MME_KB		1024UL
+
+#define PMAP_FILE	"/proc/self/pagemap"
+#define PMAP_PFN	0x007FFFFFFFFFFFFFUL
+#define PMAP_SIZE	8
+
+#define SOFT_OFFLINE	"/sys/devices/system/memory/soft_offline_page"
+#define HARD_OFFLINE	"/sys/devices/system/memory/hard_offline_page"
+
+#define MMAP_LENGTH	(256 * MEM_MB)
+#define MMAP_ADDR	(void *)(0x0UL)
+#define MMAP_PROT	(PROT_READ | PROT_WRITE)
+#define MMAP_FLAGS	(MAP_PRIVATE | MAP_ANONYMOUS)
+#define MMAP_FLAGS_HUGE	(MAP_SHARED)
+
+#define FILE_NAME	"huge/hugepagefile"
+
+static void write_buffer(char *addr, unsigned long length)
+{
+	unsigned long i;
+
+	for (i = 0; i < length; i++)
+		*(addr + i) = (char)i;
+}
+
+static int read_buffer(char *addr, unsigned long length)
+{
+	unsigned long i;
+
+	for (i = 0; i < length; i++) {
+		if (*(addr + i) != (char)i) {
+			printf("Data miscompare at addr[%lu]\n", i);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static unsigned long get_npages(unsigned long length, unsigned long size)
+{
+	unsigned int tmp1 = length, tmp2 = size;
+
+	return tmp1/tmp2;
+}
+
+static void soft_offline_pages(int hugepage, void *addr,
+				unsigned long npages, unsigned long *failed)
+{
+	unsigned long psize, offset, pfn, pa, count;
+	void *tmp;
+	int i, fd1, fd2;
+	char buf[20];
+
+	fd1 = open(PMAP_FILE, O_RDONLY);
+	if (fd1 == -1) {
+		perror("open() failed");
+		exit(-1);
+	}
+
+	fd2 = open(SOFT_OFFLINE, O_WRONLY);
+	if (fd2 == -1) {
+		perror("open() failed");
+		exit(-1);
+	}
+
+	count = 0;
+	psize = getpagesize();
+	for (i = 0; i < npages; i++) {
+		if (hugepage)
+			tmp = addr + i * PAGE_SIZE_HUGE;
+		else
+			tmp = addr + i * psize;
+
+		offset = ((unsigned long) tmp / psize) * PMAP_SIZE;
+
+		if (lseek(fd1, offset, SEEK_SET) == -1) {
+			perror("lseek() failed");
+			exit(-1);
+		}
+
+		if (read(fd1, &pfn, sizeof(pfn)) == -1) {
+			perror("read() failed");
+			exit(-1);
+		}
+
+		pfn = pfn & PMAP_PFN;
+		if (psize == PAGE_SIZE_4K)
+			pa = pfn << PAGE_SHIFT_4K;
+
+		if (psize == PAGE_SIZE_64K)
+			pa = pfn << PAGE_SHIFT_64K;
+
+		sprintf(buf, "0x%lx\n", pa);
+
+		if (write(fd2, buf, strlen(buf)) == -1) {
+			perror("write() failed");
+			printf("%d PFN: %lx BUF: %s\n",i, pfn, buf);
+			count++;
+			exit(-1);
+		}
+
+	}
+
+	if (failed)
+		*failed = count;
+
+	close(fd1);
+	close(fd2);
+}
+
+int test_migration(unsigned long length)
+{
+	unsigned long failed;
+	void *addr;
+	int ret;
+
+	addr = mmap(MMAP_ADDR, length, MMAP_PROT, MMAP_FLAGS, -1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap() failed");
+		exit(-1);
+	}
+
+	write_buffer(addr, length);
+	soft_offline_pages(HPAGE_OFF, addr, length/getpagesize(), &failed);
+	ret = read_buffer(addr, length);
+
+	printf("%ld pages moved, %ld pages failed\n", (length/getpagesize() - failed), failed);
+
+	munmap(addr, length);
+	return ret;
+}
+
+int test_huge_migration(unsigned long length)
+{
+	unsigned long failed, npages;
+	void *addr;
+	int fd, ret;
+
+	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
+	if (fd < 0) {
+		perror("open() failed");
+		exit(-1);
+	}
+
+	addr = mmap(MMAP_ADDR, length, MMAP_PROT, MMAP_FLAGS_HUGE, fd, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap() failed");
+		unlink(FILE_NAME);
+		exit(-1);
+	}
+
+        if (mlock(addr, length) == -1) {
+                perror("mlock() failed");
+		munmap(addr, length);
+                unlink(FILE_NAME);
+                exit(-1);
+        }
+
+	write_buffer(addr, length);
+	npages = get_npages(length, PAGE_SIZE_HUGE);
+	soft_offline_pages(HPAGE_ON, addr, npages, &failed);
+	ret = read_buffer(addr, length);
+
+	printf("%ld pages moved, %ld pages failed\n", (npages - failed), failed);
+
+	munmap(addr, length);
+	unlink(FILE_NAME);
+	return ret;
+}
diff --git a/tools/testing/selftests/powerpc/mm/page-migration.c b/tools/testing/selftests/powerpc/mm/page-migration.c
new file mode 100644
index 0000000..fc6e472
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/page-migration.c
@@ -0,0 +1,33 @@
+/*
+ * Copyright (C) 2015, Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+#include "migration.h"
+
+static int page_migration(void)
+{
+	int ret = 0;
+
+	if ((unsigned long)getpagesize() == 0x1000)
+		printf("Running on base page size 4K\n");
+
+	if ((unsigned long)getpagesize() == 0x10000)
+		printf("Running on base page size 64K\n");
+
+	ret = test_migration(4 * MEM_MB);
+	ret = test_migration(64 * MEM_MB);
+	ret = test_migration(256 * MEM_MB);
+	ret = test_migration(512 * MEM_MB);
+	ret = test_migration(1 * MEM_GB);
+	ret = test_migration(2 * MEM_GB);
+
+	return ret;
+}
+
+int main(void)
+{
+	return test_harness(page_migration, "page_migration");
+}
diff --git a/tools/testing/selftests/powerpc/mm/run_mmtests b/tools/testing/selftests/powerpc/mm/run_mmtests
new file mode 100755
index 0000000..c537f4e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/run_mmtests
@@ -0,0 +1,21 @@
+#!/bin/bash
+mnt=./huge
+mkdir $mnt
+mount -t hugetlbfs none $mnt
+
+echo 256 > /proc/sys/vm/nr_hugepages
+echo "HugeTLB vs THP"
+./hugetlb_vs_thp_test
+
+echo "Subpage Protection"
+./subpage_prot
+
+echo "Test normal page migration"
+./page-migration
+
+echo "Test huge page migration"
+./hugepage-migration
+
+#cleanup
+umount $mnt
+rm -rf $mnt
-- 
2.1.0
