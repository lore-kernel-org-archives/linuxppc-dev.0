Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E42C10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:02:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2685A213F2
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 13:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2685A213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44d9Yn2KZFzDqD3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 23:02:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44d9Vw5WxgzDqKj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Apr 2019 22:59:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44d9Vv6HdRz9sPd; Mon,  8 Apr 2019 22:59:51 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44d9Vv56yJz9sQq; Mon,  8 Apr 2019 22:59:51 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: Add a test of bad (out-of-range) accesses
Date: Mon,  8 Apr 2019 22:59:37 +1000
Message-Id: <20190408125937.4284-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Userspace isn't allowed to access certain address ranges, make sure we
actually test that to at least some degree.

This would have caught the recent bug where the SLB fault handler was
incorrectly called on an out-of-range access when using the Radix MMU.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/mm/.gitignore |  3 +-
 tools/testing/selftests/powerpc/mm/Makefile   |  3 +-
 .../selftests/powerpc/mm/bad_accesses.c       | 68 +++++++++++++++++++
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/bad_accesses.c

diff --git a/tools/testing/selftests/powerpc/mm/.gitignore b/tools/testing/selftests/powerpc/mm/.gitignore
index ba919308fe30..c189170ba041 100644
--- a/tools/testing/selftests/powerpc/mm/.gitignore
+++ b/tools/testing/selftests/powerpc/mm/.gitignore
@@ -3,4 +3,5 @@ subpage_prot
 tempfile
 prot_sao
 segv_errors
-wild_bctr
\ No newline at end of file
+wild_bctr
+bad_accesses
\ No newline at end of file
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index 43d68420e363..683047d66b72 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -2,7 +2,8 @@
 noarg:
 	$(MAKE) -C ../
 
-TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr
+TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors \
+		  wild_bctr bad_accesses
 TEST_GEN_FILES := tempfile
 
 top_srcdir = ../../../../..
diff --git a/tools/testing/selftests/powerpc/mm/bad_accesses.c b/tools/testing/selftests/powerpc/mm/bad_accesses.c
new file mode 100644
index 000000000000..86717c39e696
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/bad_accesses.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019, Michael Ellerman, IBM Corp.
+ *
+ * Test that out-of-bounds reads/writes behave as expected.
+ */
+
+#include <setjmp.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <ucontext.h>
+#include <unistd.h>
+
+#include "utils.h"
+
+
+static jmp_buf setjmp_env;
+
+static void segv_handler(int signum)
+{
+	siglongjmp(setjmp_env, 1);
+}
+
+int bad_access(char *p, bool write)
+{
+	char x;
+
+	if (sigsetjmp(setjmp_env, 1) == 0) {
+		if (write)
+			*p = 1;
+		else
+			x = *p;
+
+		printf("Bad - no SEGV! (%c)\n", x);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int test(void)
+{
+	unsigned long addr, i, j;
+
+	FAIL_IF(signal(SIGSEGV, segv_handler));
+
+	for (i = 1; i < 0x10; i++) {
+		for (j = 11; j < 60; j++) {
+			addr = (i << 60) | (1ul << j);
+
+			printf("Attempting bad access of 0x%16lx\n", addr);
+			FAIL_IF(bad_access((char *)addr, false));
+			FAIL_IF(bad_access((char *)addr, true));
+		}
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test, "test_bad_accesses");
+}
-- 
2.20.1

