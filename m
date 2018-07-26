Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41brry0zlszDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 22:25:06 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] selftests/powerpc: Add a helper for checking if we're on
 ppc64le
Date: Thu, 26 Jul 2018 22:24:57 +1000
Message-Id: <20180726122459.9293-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of our selftests have only been tested on ppc64le and crash or
behave weirdly on ppc64/ppc32. So add a helper for checking the UTS
machine.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/include/utils.h |  2 ++
 tools/testing/selftests/powerpc/utils.c         | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/tools/testing/selftests/powerpc/include/utils.h b/tools/testing/selftests/powerpc/include/utils.h
index 735815b3ad7f..c58c370828b4 100644
--- a/tools/testing/selftests/powerpc/include/utils.h
+++ b/tools/testing/selftests/powerpc/include/utils.h
@@ -48,6 +48,8 @@ static inline bool have_hwcap2(unsigned long ftr2)
 }
 #endif
 
+bool is_ppc64le(void);
+
 /* Yes, this is evil */
 #define FAIL_IF(x)						\
 do {								\
diff --git a/tools/testing/selftests/powerpc/utils.c b/tools/testing/selftests/powerpc/utils.c
index d46916867a6f..aa8fc1e6365b 100644
--- a/tools/testing/selftests/powerpc/utils.c
+++ b/tools/testing/selftests/powerpc/utils.c
@@ -11,8 +11,10 @@
 #include <link.h>
 #include <sched.h>
 #include <stdio.h>
+#include <string.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <sys/utsname.h>
 #include <unistd.h>
 
 #include "utils.h"
@@ -104,3 +106,18 @@ int pick_online_cpu(void)
 	printf("No cpus in affinity mask?!\n");
 	return -1;
 }
+
+bool is_ppc64le(void)
+{
+	struct utsname uts;
+	int rc;
+
+	errno = 0;
+	rc = uname(&uts);
+	if (rc) {
+		perror("uname");
+		return false;
+	}
+
+	return strcmp(uts.machine, "ppc64le") == 0;
+}
-- 
2.14.1
