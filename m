Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B11D21A04B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 20:12:23 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F80B1402CD
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:12:23 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 28 Jan 2016 19:12:22 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id AC1FA3578058
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:12:17 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0S9Bk0x45940756
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:11:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0S9BiLI028973
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2016 20:11:45 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH 2/2] selfttest/powerpc: Add memory page migration tests
Date: Thu, 28 Jan 2016 14:41:25 +0530
Message-Id: <1453972285-8822-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1453972285-8822-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1453972285-8822-1-git-send-email-khandual@linux.vnet.ibm.com>
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
Changes in V3:
- Minor changes to the code for considering skipped pages
- Enabled HugeTLB test in the script as it works now

Changes in V2:
- Changed the script to accommodate review comments from Michael
- Disabled huge page migration test till it is supported on POWER

Sample test result
==================
....................
Test HugeTLB vs THP
....................
test: hugetlb_vs_thp
tags: git_version:v4.5-rc1-30-gda30491
success: hugetlb_vs_thp
[PASS]
.........................
Test subpage protection
.........................
test: subpage_prot_anon
tags: git_version:v4.5-rc1-30-gda30491
allocated malloc block of 0x4000000 bytes at 0x0x3fff80720000
testing malloc block...
success: subpage_prot_anon
test: subpage_prot_file
tags: git_version:v4.5-rc1-30-gda30491
allocated tempfile for 0x10000 bytes at 0x0x3fff84720000
testing file map...
success: subpage_prot_file
[PASS]
...........................
Test normal page migration
...........................
test: page_migration
tags: git_version:v4.5-rc1-30-gda30491
Running on base page size 64K
64 moved 0 skipped 0 failed
1024 moved 0 skipped 0 failed
3328 moved 768 skipped 0 failed
4352 moved 3840 skipped 0 failed
8448 moved 7936 skipped 0 failed
16640 moved 16128 skipped 0 failed
success: page_migration
[PASS]
.........................
Test huge page migration
.........................
test: hugepage_migration
tags: git_version:v4.5-rc1-30-gda30491
Running on base page size 64K
1 moved 0 skipped 0 failed
16 moved 0 skipped 0 failed
32 moved 0 skipped 0 failed
success: hugepage_migration
[PASS]



 tools/testing/selftests/powerpc/mm/Makefile        |  14 +-
 .../selftests/powerpc/mm/hugepage-migration.c      |  30 +++
 tools/testing/selftests/powerpc/mm/migration.h     | 204 +++++++++++++++++++++
 .../testing/selftests/powerpc/mm/page-migration.c  |  33 ++++
 tools/testing/selftests/powerpc/mm/run_mmtests     | 104 +++++++++++
 5 files changed, 380 insertions(+), 5 deletions(-)
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
index 0000000..fe35849
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/migration.h
@@ -0,0 +1,204 @@
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
+	unsigned long npages, unsigned long *skipped, unsigned long *failed)
+{
+	unsigned long psize, offset, pfn, paddr, fail, skip, i;
+	void *tmp;
+	int fd1, fd2;
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
+	fail = skip = 0;
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
+		/* Skip if no valid PFN */
+		pfn = pfn & PMAP_PFN;
+		if (!pfn) {
+			skip++;
+			continue;
+		}
+
+		if (psize == PAGE_SIZE_4K)
+			paddr = pfn << PAGE_SHIFT_4K;
+
+		if (psize == PAGE_SIZE_64K)
+			paddr = pfn << PAGE_SHIFT_64K;
+
+		sprintf(buf, "0x%lx\n", paddr);
+
+		if (write(fd2, buf, strlen(buf)) == -1) {
+			perror("write() failed");
+			printf("[%ld] PFN: %lx BUF: %s\n",i, pfn, buf);
+			fail++;
+		}
+
+	}
+
+	if (failed)
+		*failed = fail;
+
+	if (skipped)
+		*skipped = skip;
+
+	close(fd1);
+	close(fd2);
+}
+
+int test_migration(unsigned long length)
+{
+	unsigned long skipped, failed;
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
+	soft_offline_pages(HPAGE_OFF, addr, length/getpagesize(), &skipped, &failed);
+	ret = read_buffer(addr, length);
+
+	printf("%ld moved %ld skipped %ld failed\n", (length/getpagesize() - skipped - failed), skipped, failed);
+
+	munmap(addr, length);
+	return ret;
+}
+
+int test_huge_migration(unsigned long length)
+{
+	unsigned long skipped, failed, npages;
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
+	soft_offline_pages(HPAGE_ON, addr, npages, &skipped, &failed);
+	ret = read_buffer(addr, length);
+
+	printf("%ld moved %ld skipped %ld failed\n", (npages - skipped - failed), skipped, failed);
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
index 0000000..19805ba
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/run_mmtests
@@ -0,0 +1,104 @@
+#!/bin/bash
+
+# Mostly borrowed from tools/testing/selftests/vm/run_vmtests
+
+# Please run this as root
+# Try allocating 2GB of 16MB huge pages, below is the size in kB.
+# Please change this needed memory if the test program changes
+needmem=2097152
+mnt=./huge
+exitcode=0
+
+# Get huge pagesize and freepages from /proc/meminfo
+while read name size unit; do
+	if [ "$name" = "HugePages_Free:" ]; then
+		freepgs=$size
+	fi
+	if [ "$name" = "Hugepagesize:" ]; then
+		pgsize=$size
+	fi
+done < /proc/meminfo
+
+# Set required nr_hugepages
+if [ -n "$freepgs" ] && [ -n "$pgsize" ]; then
+	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
+	needpgs=`expr $needmem / $pgsize`
+	tries=2
+	while [ $tries -gt 0 ] && [ $freepgs -lt $needpgs ]; do
+		lackpgs=$(( $needpgs - $freepgs ))
+		echo 3 > /proc/sys/vm/drop_caches
+		echo $(( $lackpgs + $nr_hugepgs )) > /proc/sys/vm/nr_hugepages
+		if [ $? -ne 0 ]; then
+			echo "Please run this test as root"
+		fi
+		while read name size unit; do
+			if [ "$name" = "HugePages_Free:" ]; then
+				freepgs=$size
+			fi
+		done < /proc/meminfo
+		tries=$((tries - 1))
+	done
+	if [ $freepgs -lt $needpgs ]; then
+		printf "Not enough huge pages available (%d < %d)\n" \
+		       $freepgs $needpgs
+	fi
+else
+	echo "No hugetlbfs support in kernel ? check dmesg"
+fi
+
+mkdir $mnt
+mount -t hugetlbfs none $mnt
+
+# Run the test programs
+echo "...................."
+echo "Test HugeTLB vs THP"
+echo "...................."
+./hugetlb_vs_thp_test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
+echo "........................."
+echo "Test subpage protection"
+echo "........................."
+./subpage_prot
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
+echo "..........................."
+echo "Test normal page migration"
+echo "..........................."
+./page-migration
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
+# Enable this after huge page migration is supported on POWER
+
+echo "........................."
+echo "Test huge page migration"
+echo "........................."
+./hugepage-migration
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
+# Huge pages cleanup
+umount $mnt
+rm -rf $mnt
+echo $nr_hugepgs > /proc/sys/vm/nr_hugepages
+
+exit $exitcode
-- 
2.1.0
