Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 078221A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 13:05:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>
Subject: [PATCH 2/4] selftests/powerpc: Add have_hwcap2() helper
Date: Tue, 24 Nov 2015 13:05:39 +1100
Message-Id: <1448330741-4804-2-git-send-email-mpe@ellerman.id.au>
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

We already do this twice and want to add another so add a helper.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c   | 3 +--
 tools/testing/selftests/powerpc/tm/tm-syscall.c | 3 +--
 tools/testing/selftests/powerpc/utils.h         | 6 ++++++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
index 9729d9f90218..e67452f1bcff 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -13,7 +13,6 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
-#include <linux/auxvec.h>
 
 #include "trace.h"
 #include "reg.h"
@@ -324,7 +323,7 @@ bool ebb_is_supported(void)
 {
 #ifdef PPC_FEATURE2_EBB
 	/* EBB requires at least POWER8 */
-	return ((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_EBB);
+	return have_hwcap2(PPC_FEATURE2_EBB);
 #else
 	return false;
 #endif
diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index e835bf7ec7ae..d7256b79ec4c 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -14,7 +14,6 @@
 #include <sys/syscall.h>
 #include <asm/tm.h>
 #include <asm/cputable.h>
-#include <linux/auxvec.h>
 #include <sys/time.h>
 #include <stdlib.h>
 
@@ -80,7 +79,7 @@ pid_t getppid_tm(bool suspend)
 static inline bool have_htm_nosc(void)
 {
 #ifdef PPC_FEATURE2_HTM_NOSC
-	return ((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM_NOSC);
+	return have_hwcap2(PPC_FEATURE2_HTM_NOSC);
 #else
 	printf("PPC_FEATURE2_HTM_NOSC not defined, can't check AT_HWCAP2\n");
 	return false;
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index b7d41086bb0a..fbf2bf530e50 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -8,6 +8,7 @@
 
 #include <stdint.h>
 #include <stdbool.h>
+#include <linux/auxvec.h>
 
 /* Avoid headaches with PRI?64 - just use %ll? always */
 typedef unsigned long long u64;
@@ -22,6 +23,11 @@ typedef uint8_t u8;
 int test_harness(int (test_function)(void), char *name);
 extern void *get_auxv_entry(int type);
 
+static inline bool have_hwcap2(unsigned long ftr2)
+{
+	return ((unsigned long)get_auxv_entry(AT_HWCAP2) & ftr2) == ftr2;
+}
+
 /* Yes, this is evil */
 #define FAIL_IF(x)						\
 do {								\
-- 
2.5.0
