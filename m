Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 949471A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:43 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 04/10] selftests/powerpc: Add test of L3 bank handling
Date: Wed, 23 Jul 2014 17:31:34 +1000
Message-Id: <1406100700-9702-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
References: <1406100700-9702-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/Makefile       |  2 +-
 tools/testing/selftests/powerpc/pmu/l3_bank_test.c | 48 ++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/pmu/l3_bank_test.c

diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index cd256277c24e..ebc0e7449cd9 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -1,7 +1,7 @@
 noarg:
 	$(MAKE) -C ../
 
-PROGS := count_instructions
+PROGS := count_instructions l3_bank_test
 EXTRA_SOURCES := ../harness.c event.c
 
 SUB_TARGETS = ebb
diff --git a/tools/testing/selftests/powerpc/pmu/l3_bank_test.c b/tools/testing/selftests/powerpc/pmu/l3_bank_test.c
new file mode 100644
index 000000000000..77472f31441e
--- /dev/null
+++ b/tools/testing/selftests/powerpc/pmu/l3_bank_test.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "event.h"
+#include "utils.h"
+
+#define MALLOC_SIZE     (0x10000 * 10)  /* Ought to be enough .. */
+
+/*
+ * Tests that the L3 bank handling is correct. We fixed it in commit e9aaac1.
+ */
+static int l3_bank_test(void)
+{
+	struct event event;
+	char *p;
+	int i;
+
+	p = malloc(MALLOC_SIZE);
+	FAIL_IF(!p);
+
+	event_init(&event, 0x84918F);
+
+	FAIL_IF(event_open(&event));
+
+	for (i = 0; i < MALLOC_SIZE; i += 0x10000)
+		p[i] = i;
+
+	event_read(&event);
+	event_report(&event);
+
+	FAIL_IF(event.result.running == 0);
+	FAIL_IF(event.result.enabled == 0);
+
+	event_close(&event);
+	free(p);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(l3_bank_test, "l3_bank_test");
+}
-- 
1.9.1
