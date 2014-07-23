Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51A4A1A0653
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 17:31:46 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 09/10] selftests/powerpc: Add a routine for retrieving an AUXV
 entry
Date: Wed, 23 Jul 2014 17:31:39 +1000
Message-Id: <1406100700-9702-9-git-send-email-mpe@ellerman.id.au>
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
 tools/testing/selftests/powerpc/pmu/lib.c | 48 +++++++++++++++++++++++++++++++
 tools/testing/selftests/powerpc/pmu/lib.h |  1 +
 2 files changed, 49 insertions(+)

diff --git a/tools/testing/selftests/powerpc/pmu/lib.c b/tools/testing/selftests/powerpc/pmu/lib.c
index 11e26e8cf33a..9768dea37bf3 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.c
+++ b/tools/testing/selftests/powerpc/pmu/lib.c
@@ -5,10 +5,15 @@
 
 #define _GNU_SOURCE	/* For CPU_ZERO etc. */
 
+#include <elf.h>
 #include <errno.h>
+#include <fcntl.h>
+#include <link.h>
 #include <sched.h>
 #include <setjmp.h>
 #include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/types.h>
 #include <sys/wait.h>
 
 #include "utils.h"
@@ -250,3 +255,46 @@ out_close:
 out:
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
diff --git a/tools/testing/selftests/powerpc/pmu/lib.h b/tools/testing/selftests/powerpc/pmu/lib.h
index ca5d72ae3be6..0f0339c8a6f6 100644
--- a/tools/testing/selftests/powerpc/pmu/lib.h
+++ b/tools/testing/selftests/powerpc/pmu/lib.h
@@ -29,6 +29,7 @@ extern int notify_parent(union pipe write_pipe);
 extern int notify_parent_of_error(union pipe write_pipe);
 extern pid_t eat_cpu(int (test_function)(void));
 extern bool require_paranoia_below(int level);
+extern void *get_auxv_entry(int type);
 
 struct addr_range {
 	uint64_t first, last;
-- 
1.9.1
