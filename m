Return-Path: <linuxppc-dev+bounces-18863-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6494C10A62D1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 02:17:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhklv2RJ3z2yr0;
	Fri, 27 Mar 2026 13:16:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b9"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774577787;
	cv=none; b=gYelwuu1Czvwpb/UI06ltI2sUycWYwP5i1dMiRNXbmMZYdcsEovRT30wy1B6Z3roRCjeX9U71fdZ489b6/lBDOdb1f7SRRLZjZd8aS9BU2iwgu11tdOu43eBlhBd7G3UBk60GGsOOyS0mbllCYMprjNc1T45MlfD2fXbHdBaKfJX0nTfSwAkmkXId6npPZACJ3VuAivk3hgnTDS3F0lRDlw4kO1mJfCP7/i5lsQTbs77pybmw8/GrKXvSI8xxyBkl5YSvHVO9XxvXe+5BM95nCFHbVmcza7fOnuBr1I2bsBymB/w1WmyaG9sq0FSKgzV6uEbQWG4K8hAjIm6UTlQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774577787; c=relaxed/relaxed;
	bh=/WGDRJcAglr5vqEySbz/Q1Ok3+d9N6t6n4ui+xS3iNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5e7MqYMNcZFzaa4oH3K4Nv1JSHc5txvs1pQqRFbcWzLjUCTixPNvXjePo9a81hhe3Z2otiHUG6TT8Fhr47eXIrPDGXxmD2P0MWkRKEkQBw7kC+Me8lU5w9V6Fkx20PCtgBA/I0QjRw0RkRiUjWRj1B1wJTI9Y5KCGTqqaEhHA3R9nolh9Prs/vEt4VZ3vJOmubTSNoAAKQJnZTYXv8bOuRj7QQYI/fJowynuy/SwdUKsYEunxo/4vZ8QJwcptaq2jA4xj9LzDILKVMfrJRZOEcbsNMN+Bv+zxGbLas4Vqrl5mZ4ThTwBD7ild774dK08GL5x879AM2y+n3a3miFuw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BagS9qBG; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BagS9qBG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b9; helo=out-185.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhklt4gzKz2yqt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 13:16:26 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/WGDRJcAglr5vqEySbz/Q1Ok3+d9N6t6n4ui+xS3iNE=;
	b=BagS9qBGxnoN00/4kt2N0AtuZZ0wHRFPSolgBLBK2CrXSufkJDyuYyYuIvQyVjVaCsdhJK
	wMV0Y9lJGKZkNTSKhtRR7ZUnol1AuKxUSsHZsq9u78XkEixDlTJT5maiQxf53+lpNUY7rn
	n0Eq0GZTwR6gzj24aFATrdiHFUVLBU0=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [v3 20/24] selftests/mm: add THP PMD split test infrastructure
Date: Thu, 26 Mar 2026 19:09:02 -0700
Message-ID: <20260327021403.214713-21-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test infrastructure for verifying THP PMD split behavior with lazy
PTE allocation. This includes:

- Test fixture with PMD-aligned memory allocation
- Helper functions for reading vmstat counters
- log_and_check_pmd_split() macro for logging counters and checking
  if thp_split_pmd has incremented and thp_split_pmd_failed hasn't.
- THP allocation helper with verification

Also add a test to check if partial unmap of a THP splits the PMD.
This exercises zap_pmd_range part of split.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/thp_pmd_split_test.c | 149 ++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/mm/thp_pmd_split_test.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index cd24596cdd27e..4b4610c9b693d 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -95,6 +95,7 @@ TEST_GEN_FILES += uffd-stress
 TEST_GEN_FILES += uffd-unit-tests
 TEST_GEN_FILES += uffd-wp-mremap
 TEST_GEN_FILES += split_huge_page_test
+TEST_GEN_FILES += thp_pmd_split_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
 TEST_GEN_FILES += mdwe_test
diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
new file mode 100644
index 0000000000000..0f54ac04760d5
--- /dev/null
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests various kernel code paths that handle THP PMD splitting.
+ *
+ * Prerequisites:
+ * - THP enabled (always or madvise mode):
+ *   echo always > /sys/kernel/mm/transparent_hugepage/enabled
+ *   or
+ *   echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdint.h>
+
+#include "kselftest_harness.h"
+#include "thp_settings.h"
+#include "vm_util.h"
+
+/* Read vmstat counter */
+static unsigned long read_vmstat(const char *name)
+{
+	FILE *fp;
+	char line[256];
+	unsigned long value = 0;
+
+	fp = fopen("/proc/vmstat", "r");
+	if (!fp)
+		return 0;
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (strncmp(line, name, strlen(name)) == 0 &&
+		    line[strlen(name)] == ' ') {
+			sscanf(line + strlen(name), " %lu", &value);
+			break;
+		}
+	}
+	fclose(fp);
+	return value;
+}
+
+/*
+ * Log vmstat counters for split_pmd_after/split_pmd_failed_after,
+ * check if split_pmd_after is greater than before and split_pmd_failed_after
+ * hasn't incremented.
+ */
+static void log_and_check_pmd_split(struct __test_metadata *const _metadata,
+	unsigned long split_pmd_before, unsigned long split_pmd_failed_before)
+{
+	unsigned long split_pmd_after = read_vmstat("thp_split_pmd");
+	unsigned long split_pmd_failed_after = read_vmstat("thp_split_pmd_failed");
+
+	TH_LOG("thp_split_pmd: %lu -> %lu", \
+	       split_pmd_before, split_pmd_after);
+	TH_LOG("thp_split_pmd_failed: %lu -> %lu", \
+	       split_pmd_failed_before, split_pmd_failed_after);
+	ASSERT_GT(split_pmd_after, split_pmd_before);
+	ASSERT_EQ(split_pmd_failed_after, split_pmd_failed_before);
+}
+
+/* Allocate a THP at the given aligned address */
+static int allocate_thp(void *aligned, size_t pmdsize)
+{
+	int ret;
+
+	ret = madvise(aligned, pmdsize, MADV_HUGEPAGE);
+	if (ret)
+		return -1;
+
+	/* Touch all pages to allocate the THP */
+	memset(aligned, 0xAA, pmdsize);
+
+	/* Verify we got a THP */
+	if (!check_huge_anon(aligned, 1, pmdsize))
+		return -1;
+
+	return 0;
+}
+
+FIXTURE(thp_pmd_split)
+{
+	void *mem;		/* Base mmap allocation */
+	void *aligned;		/* PMD-aligned pointer within mem */
+	size_t pmdsize;		/* PMD size from sysfs */
+	size_t pagesize;	/* Base page size */
+	size_t mmap_size;	/* Total mmap size for alignment */
+	unsigned long split_pmd_before;
+	unsigned long split_pmd_failed_before;
+};
+
+FIXTURE_SETUP(thp_pmd_split)
+{
+	if (!thp_available())
+		SKIP(return, "THP not available");
+
+	self->pmdsize = read_pmd_pagesize();
+	if (!self->pmdsize)
+		SKIP(return, "Unable to read PMD size");
+
+	self->pagesize = getpagesize();
+	self->mmap_size = 4 * self->pmdsize;
+
+	self->split_pmd_before = read_vmstat("thp_split_pmd");
+	self->split_pmd_failed_before = read_vmstat("thp_split_pmd_failed");
+
+	self->mem = mmap(NULL, self->mmap_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(self->mem, MAP_FAILED);
+
+	/* Align to PMD boundary */
+	self->aligned = (void *)(((unsigned long)self->mem + self->pmdsize - 1) &
+				 ~(self->pmdsize - 1));
+}
+
+FIXTURE_TEARDOWN(thp_pmd_split)
+{
+	if (self->mem && self->mem != MAP_FAILED)
+		munmap(self->mem, self->mmap_size);
+}
+
+/*
+ * Partial munmap on THP (zap_pmd_range)
+ *
+ * Tests that partial munmap of a THP correctly splits the PMD.
+ * This exercises zap_pmd_range part of split.
+ */
+TEST_F(thp_pmd_split, partial_munmap)
+{
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	ret = munmap((char *)self->aligned + self->pagesize, self->pagesize);
+	ASSERT_EQ(ret, 0);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
+TEST_HARNESS_MAIN
-- 
2.52.0


