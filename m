Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB7F51A00D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 22:23:17 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/4] selftests/powerpc: Add support for skipping tests
Date: Tue, 10 Jun 2014 22:23:09 +1000
Message-Id: <1402402990-31925-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1402402990-31925-1-git-send-email-mpe@ellerman.id.au>
References: <1402402990-31925-1-git-send-email-mpe@ellerman.id.au>
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
 tools/testing/selftests/powerpc/harness.c |  5 ++++-
 tools/testing/selftests/powerpc/subunit.h |  5 +++++
 tools/testing/selftests/powerpc/utils.h   | 12 ++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
index 532ddff..8ebc58a 100644
--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -105,7 +105,10 @@ int test_harness(int (test_function)(void), char *name)
 
 	rc = run_test(test_function, name);
 
-	test_finish(name, rc);
+	if (rc == MAGIC_SKIP_RETURN_VALUE)
+		test_skip(name);
+	else
+		test_finish(name, rc);
 
 	return rc;
 }
diff --git a/tools/testing/selftests/powerpc/subunit.h b/tools/testing/selftests/powerpc/subunit.h
index 98a2292..9c6c4e9 100644
--- a/tools/testing/selftests/powerpc/subunit.h
+++ b/tools/testing/selftests/powerpc/subunit.h
@@ -26,6 +26,11 @@ static inline void test_error(char *name)
 	printf("error: %s\n", name);
 }
 
+static inline void test_skip(char *name)
+{
+	printf("skip: %s\n", name);
+}
+
 static inline void test_success(char *name)
 {
 	printf("success: %s\n", name);
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index 0de0644..a93777a 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -31,6 +31,18 @@ do {								\
 	}							\
 } while (0)
 
+/* The test harness uses this, yes it's gross */
+#define MAGIC_SKIP_RETURN_VALUE	99
+
+#define SKIP_IF(x)						\
+do {								\
+	if ((x)) {						\
+		fprintf(stderr,					\
+		"[SKIP] Test skipped on line %d\n", __LINE__);	\
+		return MAGIC_SKIP_RETURN_VALUE;			\
+	}							\
+} while (0)
+
 #define _str(s) #s
 #define str(s) _str(s)
 
-- 
1.9.1
