Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D54606A32A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Oct 2026 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=LgpaH7wC
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j91K82JFqz2xwM;
	Thu, 22 Oct 2026 07:36:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=130.117.225.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792614988;
	cv=none; b=NVtGVpfuVWmDSr+VGxLvhV7IkD9qicyF6M3a2li0Q6Rlsm9EYXobhc4WBEBditrAe+3lQm8Q2mzDI4hQpK5iY2AIeDq8pE98NFlb17LySYstKbA0xxqJZ2Qk0M+07nuYKBqz47VsDSLdbNt4R7EmuFnSIAMoEHyUvX2BevI9wVUUrg5DW32zHrEK2Gr/DdhSAMfoKPCAZKO9CVW9cC10WKm0CaTDkJ7RGhYnuH6TRnq1g8Wfz6TM0XcjafUEQU8wCKOhWlXGL/PVMOPdMxsSKCZDK2uirPdItEhbXReGCqsO/gw7e61uTsDN1WCuwoeO5sc4rQY979yFad0JKxkRQg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792614988; c=relaxed/relaxed;
	bh=VOyDX5dEPNERoauSrbofATI5mXA9FSAKRwTu8vDD23U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqZvl+TcLXbxmhQfeHA+jvVI+H2m5QE69jmhHn2fMTJsKoVTXAgdpZjrF1wH0Xtm+nXJADKThBw71dAZiOI6MmJeAsxk9rkUwZhRDdopOqWhV8rzWe7+uNFsVUj/X44paYeIEWRH4iH45u5qAw0JR9YcyapjL9P/r+fbDl4HJlBnBlm1dlccmTe+gL5sfrKMppXUUoDN4NIjadOVv4rYiKOm8nbHxleXBnrjg1KBVJDmLcSppnD3fEt09FwApQugDSIeXczks4CPVJ8mXODvHOc+0NwcqnNs2D6KnaooXVOUb55NeUmza4joSD6GXfX8AFVhiUBpazkgYTDr2acUWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=LgpaH7wC; dkim-atps=neutral; spf=pass (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org) smtp.mailfrom=virtuozzo.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=virtuozzo.com header.i=@virtuozzo.com header.a=rsa-sha256 header.s=relay header.b=LgpaH7wC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=virtuozzo.com (client-ip=130.117.225.111; helo=relay.virtuozzo.com; envelope-from=khorenko@virtuozzo.com; receiver=lists.ozlabs.org)
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j91K64Snkz2xH7
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 07:36:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=VOyDX5dEPNERoauSrbofATI5mXA9FSAKRwTu8vDD23U=; b=LgpaH7wCs81cWgHanKg
	5J7NT3T9Ku7YbxYV6keyUmIzuvv9Sju6TLJC3TUsVTysOv65ijD0Lt/Z3qHiUA87oCj7g7eJAaITQ
	ScOBnUS3nizelnJeFFA8djEOFd5M+AoBhcqxzASY7Kc0xhQz6fkd6gxsgD2WCsToxTxSD34aAeoZL
	9DHJOuYB307Sdho5gGK5e/PdA3IHRME1WMrygQ2yt1dDc7AvqaCHuZBoWoEwtinwXgQ+qeMndkh9e
	C9ztzyer6EJ5Qrtv43MHSwsePC84JaBhL76qVv0PgnfnoUpS3gfCaJ86YNW5F1f9PMIMFIxBBJ6Fm
	dT6QElY5MBLvXaA==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xJcz7-00D9zC-15;
	Wed, 21 Oct 2026 22:36:12 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 21 Oct 2026 22:36:03 +0200
Subject: [PATCH v4 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-4-66f00b7a564c@virtuozzo.com>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9737;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=bRhjD9Vo+lw+k222NCBCfPr0t0oTlFMKai2BU8dG86Q=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBq2SI4LMEpHNb0U38oaO6M9JYbWTExQ1/4OjzDl
 qxJYbyiqXGJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCatkiOAAKCRBRlgpH+WFc
 KlxJEADC26pSfjefmw7IIUPxOuf0fsqsAsLVvhvhzEeYqWUcR9OWZvAXaUjOXCgSi1A9YfLALxn
 V5WjHHnLd/FgPV5r2iHOXBCadlLq8c7w7NcyEx8fr5bwmtjTXGy3jEHTVJq82TF3+Gm4z7O4V85
 SMO4cGSe5mDHZrnmKsADj8+vsr68DAvtGjwKgWoXfnCmRMdyGrhyAAbEc/pucSJoHSynzoJ3tL7
 n2N6Kon5wHTREzBZcSQLByuaKaiiCoCjbtcBNWmHdxCvUD8vFlssvsqe2PwFNW3ir1dbnrd7kZx
 nxRNKlpSdzE7aIIl3dA0kBDYg6A7OftrUHu8kS2/V31EtNuLJ6dnCowInQVVCL2GmW8rXw0cXah
 EoE3oGPMKEkwKdUB8DHJL86nGx7k/DIfDl3hwchwiArre/vTuGn/45i4ydRG4k1wL56uPcKd9et
 n8LOL+sgyQ+dWHescqo8GsEMbzgaER+pDoZHZ9yFenZ+HHT3CzrwZDQr/3SJvQKaKulEeOsFdD7
 o7IfRV01WKUNM1cwM8YdyEbnFJcvHEbKpivuI3dhNVWluku0Yef34Wz7DU/NeT58Y5BsBIoNF/s
 2z5U1ocxGg/OXz/pz8Vl0VjpzZgmVQsjiROi0IdO6qHM3YNkh6yAoufjU6qhFhJkj4essCzX9k6
 u05WN/yvHnZP8YA==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fork a process that maps shmem THPs with PMDs, in a VMA whose page
tables fork copies: a private mapping with an anon_vma, and a shared
one with a guard region. The child must find the PMDs before it
touches the mapping, and its exit must leave the parent's mapping and
the system-wide ShmemPmdMapped counter as they were.

With folio_dup_file_rmap_pmd() adding PTE mappings, the child's exit
takes the parent's share off ShmemPmdMapped while the parent still maps
the folios. Closing the file then reports "Bad page cache", or hits a
VM_BUG_ON with CONFIG_DEBUG_VM. A kernel that leaves file THPs to a
refault in the child skips the test.

The test mounts a tmpfs with huge=always over /tmp in a private mount
namespace, so it leaves the THP settings and the host's mounts and
files alone.

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
 MAINTAINERS                                |   1 +
 tools/testing/selftests/mm/Makefile        |   1 +
 tools/testing/selftests/mm/fork_file_thp.c | 227 +++++++++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh  |   1 +
 4 files changed, 230 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5cab72d851b..1b5124e7e2bf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17481,6 +17481,7 @@ F:	include/trace/events/huge_memory.h
 F:	mm/huge_memory.c
 F:	mm/khugepaged.c
 F:	mm/mm_slot.h
+F:	tools/testing/selftests/mm/fork_file_thp.c
 F:	tools/testing/selftests/mm/khugepaged.c
 F:	tools/testing/selftests/mm/split_huge_page_test.c
 F:	tools/testing/selftests/mm/transhuge-stress.c
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 2d5366196e309..33ec3b7f4c048 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -104,6 +104,7 @@ TEST_GEN_FILES += guard-regions
 TEST_GEN_FILES += merge
 TEST_GEN_FILES += rmap
 TEST_GEN_FILES += folio_split_race_test
+TEST_GEN_FILES += fork_file_thp
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/fork_file_thp.c b/tools/testing/selftests/mm/fork_file_thp.c
new file mode 100644
index 0000000000000..76c8d1a0c9792
--- /dev/null
+++ b/tools/testing/selftests/mm/fork_file_thp.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fork() of a process that maps shmem THPs with PMDs, in a VMA whose page
+ * tables fork copies: a private mapping with an anon_vma, and a shared
+ * mapping with a guard region.
+ *
+ * The child must get the PMDs without faulting, and its exit must leave the
+ * parent's mapping and the system-wide ShmemPmdMapped counter as they were.
+ * Kernels that leave file THPs to a refault in the child skip the test.
+ */
+#define _GNU_SOURCE
+#include <asm-generic/mman.h> /* Force the import of the tools version. */
+#include <errno.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sched.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/wait.h>
+
+#include "kselftest.h"
+#include "vm_util.h"
+
+#define NR_PMDS		4
+#define MAX_PMDSIZE	(32UL << 20)
+/* ShmemPmdMapped is system-wide: retry if something else changed it. */
+#define ATTEMPTS	3
+
+static size_t pagesize, pmdsize;
+
+static long meminfo_kb(const char *key)
+{
+	char line[256];
+	long kb = -1;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return -1;
+	while (fgets(line, sizeof(line), f))
+		if (!strncmp(line, key, strlen(key))) {
+			kb = strtol(line + strlen(key), NULL, 10);
+			break;
+		}
+	fclose(f);
+	return kb;
+}
+
+/* Skips the last page, which may be a guard page, and @skip. */
+static bool data_ok(const char *mem, size_t size, size_t skip)
+{
+	size_t off;
+
+	for (off = 0; off < size - pagesize; off += pagesize)
+		if (off != skip && mem[off] != (char)(off / pmdsize + 1))
+			return false;
+	return true;
+}
+
+/* Child exit codes, apart from what kselftest helpers exit with. */
+enum result { PASS, NO_PMDS = 10, FAIL_DATA, FAIL_COUNTER, FAIL_PARENT,
+	      FAIL_KILLED, COUNTER_OFF, CHANGED };
+
+static enum result fork_once(char *mem, size_t size, bool shared,
+			     long *before, long *after)
+{
+	/* The parent alone maps this much with PMDs. */
+	long own = (NR_PMDS - 1) * (pmdsize >> 10);
+	int status;
+	pid_t pid;
+
+	*before = *after = meminfo_kb("ShmemPmdMapped:");
+	if (*before < own)
+		return COUNTER_OFF;
+	fflush(stdout);
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_perror("fork");
+	if (!pid) {
+		/* Look before touching anything: the PMDs must be there. */
+		if (!check_huge_shmem(mem, size - pmdsize, NR_PMDS - 1, pmdsize))
+			_exit(NO_PMDS);
+		/* A shared retry sees the previous child's write. */
+		if (!data_ok(mem, size, pmdsize))
+			_exit(FAIL_DATA);
+		mem[pmdsize] = 'c';
+		_exit(PASS);
+	}
+	if (waitpid(pid, &status, 0) != pid)
+		ksft_exit_fail_perror("waitpid");
+	*after = meminfo_kb("ShmemPmdMapped:");
+
+	if (!WIFEXITED(status))
+		return FAIL_KILLED;
+	if (WEXITSTATUS(status) != PASS)
+		return WEXITSTATUS(status);
+	/* The child's exit took the parent's share off the counter. */
+	if (*after < own || *before - *after >= own)
+		return FAIL_COUNTER;
+	if (*after != *before)
+		return CHANGED;
+	if (mem[pmdsize] != (shared ? 'c' : 2) || !data_ok(mem, size, pmdsize) ||
+	    !check_huge_shmem(mem, size - pmdsize, NR_PMDS - 1, pmdsize))
+		return FAIL_PARENT;
+	return PASS;
+}
+
+static void test_fork(bool shared)
+{
+	size_t size = NR_PMDS * pmdsize, last = size - pagesize, off;
+	const char *desc = shared ? "shared mapping with a guard region" :
+				    "private mapping with an anon_vma";
+	char *buf, *area, *mem;
+	enum result res = FAIL_PARENT;
+	long before, after;
+	int fd, i;
+
+	fd = open("/tmp/fork_file_thp", O_RDWR | O_CREAT | O_TRUNC, 0600);
+	if (fd < 0)
+		ksft_exit_fail_perror("open");
+	unlink("/tmp/fork_file_thp");
+	buf = malloc(pmdsize);
+	if (!buf)
+		ksft_exit_fail_msg("malloc failed\n");
+	for (off = 0; off < size; off += pmdsize) {
+		memset(buf, off / pmdsize + 1, pmdsize);
+		if (pwrite(fd, buf, pmdsize, off) != (ssize_t)pmdsize)
+			ksft_exit_fail_perror("pwrite");
+	}
+	free(buf);
+
+	area = mmap(NULL, size + pmdsize, PROT_NONE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (area == MAP_FAILED)
+		ksft_exit_fail_perror("mmap");
+	mem = (char *)(((unsigned long)area + pmdsize - 1) & ~(pmdsize - 1));
+	mem = mmap(mem, size, PROT_READ | PROT_WRITE,
+		   (shared ? MAP_SHARED : MAP_PRIVATE) | MAP_FIXED, fd, 0);
+	if (mem == MAP_FAILED)
+		ksft_exit_fail_perror("mmap");
+	for (off = 0; off < size; off += pmdsize)
+		FORCE_READ(mem[off]);
+
+	/* Make fork copy the page tables; the last PMD gets zapped. */
+	if (shared) {
+		if (madvise(mem + last, pagesize, MADV_GUARD_INSTALL)) {
+			ksft_test_result_skip("%s: MADV_GUARD_INSTALL: %s\n",
+					      desc, strerror(errno));
+			goto out;
+		}
+	} else {
+		mem[last] = 'p';
+	}
+
+	if (!check_huge_shmem(mem, size - pmdsize, NR_PMDS - 1, pmdsize)) {
+		ksft_test_result_skip("%s: shmem is not mapped with PMDs\n",
+				      desc);
+		goto out;
+	}
+
+	for (i = 0; i < ATTEMPTS; i++) {
+		res = fork_once(mem, size, shared, &before, &after);
+		if (res != CHANGED)
+			break;
+	}
+
+	switch (res) {
+	case PASS:
+		ksft_test_result_pass("%s\n", desc);
+		break;
+	case NO_PMDS:
+		ksft_test_result_skip("%s: fork does not copy file THPs\n", desc);
+		break;
+	case COUNTER_OFF:
+		ksft_test_result_skip("%s: ShmemPmdMapped %ld kB is below what this process maps\n",
+				      desc, before);
+		break;
+	case CHANGED:
+		ksft_test_result_skip("%s: ShmemPmdMapped keeps changing\n", desc);
+		break;
+	case FAIL_DATA:
+		ksft_test_result_fail("%s: child sees wrong data\n", desc);
+		break;
+	case FAIL_COUNTER:
+		ksft_test_result_fail("%s: ShmemPmdMapped %ld kB before fork, %ld kB after\n",
+				      desc, before, after);
+		break;
+	case FAIL_PARENT:
+		ksft_test_result_fail("%s: parent's mapping changed\n", desc);
+		break;
+	case FAIL_KILLED:
+		ksft_test_result_fail("%s: child killed by a signal\n", desc);
+		break;
+	default:
+		ksft_test_result_fail("%s: child error %d\n", desc, res);
+		break;
+	}
+out:
+	munmap(area, size + pmdsize);
+	close(fd);
+}
+
+int main(void)
+{
+	ksft_print_header();
+	pagesize = getpagesize();
+	pmdsize = read_pmd_pagesize();
+	if (!pmdsize)
+		ksft_exit_skip("THP is not supported\n");
+	if (pmdsize > MAX_PMDSIZE)
+		ksft_exit_skip("PMD size %zu MiB is too large\n", pmdsize >> 20);
+	if (geteuid())
+		ksft_exit_skip("needs root to mount tmpfs\n");
+	/* The tmpfs over /tmp lives and dies with a private mount namespace. */
+	if (unshare(CLONE_NEWNS) || mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL))
+		ksft_exit_skip("private mount namespace: %s\n", strerror(errno));
+	if (mount("tmpfs", "/tmp", "tmpfs", 0, "huge=always"))
+		ksft_exit_skip("tmpfs with huge=always: %s\n", strerror(errno));
+
+	ksft_set_plan(2);
+	test_fork(false);
+	test_fork(true);
+	ksft_finished();
+}
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index d09f9f6a384ee..454a8b75a3bf3 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -445,6 +445,7 @@ fi
 CATEGORY="thp" run_test ./transhuge-stress -d 20
 
 CATEGORY="thp" run_test ./folio_split_race_test
+CATEGORY="thp" run_test ./fork_file_thp
 
 CATEGORY="migration" run_test ./migration
 

-- 
2.43.0


