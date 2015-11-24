Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C93B1A00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 13:05:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>
Subject: [PATCH 3/4] selftests/powerpc: Move TM helpers into tm.h
Date: Tue, 24 Nov 2015 13:05:40 +1100
Message-Id: <1448330741-4804-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1448330741-4804-1-git-send-email-mpe@ellerman.id.au>
References: <1448330741-4804-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move have_htm_nosc() into a new tm.h, and add a new helper, have_htm()
which we'll use in the next patch.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/tm-syscall.c | 12 +--------
 tools/testing/selftests/powerpc/tm/tm.h         | 34 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm.h

diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index d7256b79ec4c..60560cb20e38 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -13,11 +13,11 @@
 #include <unistd.h>
 #include <sys/syscall.h>
 #include <asm/tm.h>
-#include <asm/cputable.h>
 #include <sys/time.h>
 #include <stdlib.h>
 
 #include "utils.h"
+#include "tm.h"
 
 extern int getppid_tm_active(void);
 extern int getppid_tm_suspended(void);
@@ -76,16 +76,6 @@ pid_t getppid_tm(bool suspend)
 	exit(-1);
 }
 
-static inline bool have_htm_nosc(void)
-{
-#ifdef PPC_FEATURE2_HTM_NOSC
-	return have_hwcap2(PPC_FEATURE2_HTM_NOSC);
-#else
-	printf("PPC_FEATURE2_HTM_NOSC not defined, can't check AT_HWCAP2\n");
-	return false;
-#endif
-}
-
 int tm_syscall(void)
 {
 	unsigned count = 0;
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
new file mode 100644
index 000000000000..24144b25772c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2015, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#ifndef _SELFTESTS_POWERPC_TM_TM_H
+#define _SELFTESTS_POWERPC_TM_TM_H
+
+#include <stdbool.h>
+#include <asm/cputable.h>
+
+#include "../utils.h"
+
+static inline bool have_htm(void)
+{
+#ifdef PPC_FEATURE2_HTM
+	return have_hwcap2(PPC_FEATURE2_HTM);
+#else
+	printf("PPC_FEATURE2_HTM not defined, can't check AT_HWCAP2\n");
+	return false;
+#endif
+}
+
+static inline bool have_htm_nosc(void)
+{
+#ifdef PPC_FEATURE2_HTM_NOSC
+	return have_hwcap2(PPC_FEATURE2_HTM_NOSC);
+#else
+	printf("PPC_FEATURE2_HTM_NOSC not defined, can't check AT_HWCAP2\n");
+	return false;
+#endif
+}
+
+#endif /* _SELFTESTS_POWERPC_TM_TM_H */
-- 
2.5.0
