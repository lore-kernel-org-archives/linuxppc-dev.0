Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C97B51A034A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 14:01:52 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: mikey@neuling.org, anton@samba.org, linuxppc-dev@ozlabs.org,
 Aaron Sawdey <sawdey@us.ibm.com>, Denis Kirjanov <kda@linux-powerpc.org>,
 Steve Munroe <sjmunroe@us.ibm.com>
Subject: [PATCH v2 1/2] powerpc/selftest: Add gettimeofday() benchmark
Date: Fri, 25 Sep 2015 14:01:39 +1000
Message-Id: <1443153700-15395-2-git-send-email-mikey@neuling.org>
In-Reply-To: <1443153700-15395-1-git-send-email-mikey@neuling.org>
References: <1443153700-15395-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a benchmark directory to the powerpc selftests and adds a
gettimeofday() benchmark to it.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/Makefile           |  2 +-
 .../testing/selftests/powerpc/benchmarks/Makefile  | 12 +++++++++
 .../selftests/powerpc/benchmarks/gettimeofday.c    | 31 ++++++++++++++++++++++
 3 files changed, 44 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/Makefile
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/gettimeofday.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 03ca2e6..847adf6 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -12,7 +12,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CFLAGS
 
-SUB_DIRS = pmu copyloops mm tm primitives stringloops vphn switch_endian dscr
+SUB_DIRS = pmu copyloops mm tm primitives stringloops vphn switch_endian dscr benchmarks
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/benchmarks/Makefile b/tools/testing/selftests/powerpc/benchmarks/Makefile
new file mode 100644
index 0000000..5fa4870
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/Makefile
@@ -0,0 +1,12 @@
+TEST_PROGS := gettimeofday
+
+CFLAGS += -O2
+
+all: $(TEST_PROGS)
+
+$(TEST_PROGS): ../harness.c
+
+include ../../lib.mk
+
+clean:
+	rm -f $(TEST_PROGS) *.o
diff --git a/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c b/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
new file mode 100644
index 0000000..3af3c21
--- /dev/null
+++ b/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2015, Anton Blanchard, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#include <sys/time.h>
+#include <stdio.h>
+
+#include "utils.h"
+
+static int test_gettimeofday(void)
+{
+	int i;
+
+	struct timeval tv_start, tv_end;
+
+	gettimeofday(&tv_start, NULL);
+
+	for(i = 0; i < 100000000; i++) {
+		gettimeofday(&tv_end, NULL);
+	}
+
+	printf("time = %.6f\n", tv_end.tv_sec - tv_start.tv_sec + (tv_end.tv_usec - tv_start.tv_usec) * 1e-6);
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_gettimeofday, "gettimeofday");
+}
-- 
2.1.4
