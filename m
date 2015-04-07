Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 048BD1A0515
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 10:55:53 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 7 Apr 2015 10:55:51 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2E35C2BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 10:55:48 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t370te7t46006414
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 10:55:48 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t370tEZ1002382
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Apr 2015 10:55:14 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v3 2/4] selftests/powerpc: Move get_auxv_entry() to harness.c
Date: Tue,  7 Apr 2015 10:54:48 +1000
Message-Id: <13c5acd8a857ceba3f1bac86bee3c596152f3606.1428368031.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
References: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
In-Reply-To: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
References: <cover.1428368031.git.sam.bobroff@au1.ibm.com>
Cc: mikey@neuling.org, azanella@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, matt@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move get_auxv_entry() from pmu/lib.c up to harness.c in order to make
it available to other tests.

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 tools/testing/selftests/powerpc/harness.c |   47 +++++++++++++++++++++++++++++
 tools/testing/selftests/powerpc/pmu/lib.c |   47 -----------------------------
 tools/testing/selftests/powerpc/pmu/lib.h |    1 -
 tools/testing/selftests/powerpc/utils.h   |    2 +-
 4 files changed, 48 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
index 8ebc58a..f7997af 100644
--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -11,6 +11,10 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <elf.h>
+#include <fcntl.h>
+#include <link.h>
+#include <sys/stat.h>
 
 #include "subunit.h"
 #include "utils.h"
@@ -112,3 +116,46 @@ int test_harness(int (test_function)(void), char *name)
 
 	return rc;
 }
+
+static char auxv[4096];
+
+void *get_auxv_entry(int type)
+{
+	ElfW(auxv_t) *p;
+	void *result;
+	ssize_t num;
+	int fd;
+
+	fd = open("/proc/self/auxv", O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		return NULL;
+	}
+
+	result = NULL;
+
+	num = read(fd, auxv, sizeof(auxv));
+	if (num < 0) {
+		perror("read");
+		goto out;
+	}
+
+	if (num > sizeof(auxv)) {
+		printf("Overflowed auxv buffer\n");
+		goto out;
+	}
+
+	p = (ElfW(auxv_t) *)auxv;
+
+	while (p->a_type != AT_NULL) {
+		if (p->a_type == type) {
+			result = (void *)p->a_un.a_val;
+			break;
+		}
+
+		p++;
+	}
+out:
+	close(fd);
+	return result;
+}
diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
index 9768dea..a07104c 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.c
+++ b/tools/testing/selftests/powerpc/pmu/lib.c
@@ -5,15 +5,10 @@
 
 #define _GNU_SOURCE	/* For CPU_ZERO etc. */
 
-#include <elf.h>
 #include <errno.h>
-#include <fcntl.h>
-#include <link.h>
 #include <sched.h>
 #include <setjmp.h>
 #include <stdlib.h>
-#include <sys/stat.h>
-#include <sys/types.h>
 #include <sys/wait.h>
 
 #include "utils.h"
@@ -256,45 +251,3 @@ out:
 	return rc;
 }
 
-static char auxv[4096];
-
-void *get_auxv_entry(int type)
-{
-	ElfW(auxv_t) *p;
-	void *result;
-	ssize_t num;
-	int fd;
-
-	fd = open("/proc/self/auxv", O_RDONLY);
-	if (fd == -1) {
-		perror("open");
-		return NULL;
-	}
-
-	result = NULL;
-
-	num = read(fd, auxv, sizeof(auxv));
-	if (num < 0) {
-		perror("read");
-		goto out;
-	}
-
-	if (num > sizeof(auxv)) {
-		printf("Overflowed auxv buffer\n");
-		goto out;
-	}
-
-	p = (ElfW(auxv_t) *)auxv;
-
-	while (p->a_type != AT_NULL) {
-		if (p->a_type == type) {
-			result = (void *)p->a_un.a_val;
-			break;
-		}
-
-		p++;
-	}
-out:
-	close(fd);
-	return result;
-}
diff --git a/tools/testing/selftests/powerpc/pmu/lib.h b/tools/testing/selftests/powerpc/pmu/lib.h
index 0f0339c..ca5d72a 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.h
+++ b/tools/testing/selftests/powerpc/pmu/lib.h
@@ -29,7 +29,6 @@ extern int notify_parent(union pipe write_pipe);
 extern int notify_parent_of_error(union pipe write_pipe);
 extern pid_t eat_cpu(int (test_function)(void));
 extern bool require_paranoia_below(int level);
-extern void *get_auxv_entry(int type);
 
 struct addr_range {
 	uint64_t first, last;
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index a93777a..64f53cd 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -19,7 +19,7 @@ typedef uint8_t u8;
 
 
 int test_harness(int (test_function)(void), char *name);
-
+extern void *get_auxv_entry(int type);
 
 /* Yes, this is evil */
 #define FAIL_IF(x)						\
-- 
1.7.10.4
