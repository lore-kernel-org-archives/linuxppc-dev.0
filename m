Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A9AA1A1E24
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:31 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 10 Apr 2015 18:31:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A3F6B2CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:27 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A8VJqv20906110
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:31:27 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A8UsT6026267
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 18:30:54 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 11/13] selftests,
 powerpc: Add test for all DSCR sysfs interfaces
Date: Fri, 10 Apr 2015 14:00:10 +0530
Message-Id: <1428654612-23539-12-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1428654612-23539-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This test continuously updates the system wide DSCR default value
in the sysfs interface and makes sure that the same is reflected
across all the sysfs interfaces for each individual CPUs present
on the system.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/dscr/Makefile      |  3 +-
 .../selftests/powerpc/dscr/dscr_sysfs_test.c       | 92 ++++++++++++++++++++++
 2 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c

diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index 4e84309..fada526 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -1,5 +1,6 @@
 PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
-	 dscr_inherit_test dscr_inherit_exec_test
+	 dscr_inherit_test dscr_inherit_exec_test		\
+	 dscr_sysfs_test
 
 CFLAGS := $(CFLAGS) -lpthread
 
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
new file mode 100644
index 0000000..d5ab4b2
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
@@ -0,0 +1,92 @@
+/*
+ * POWER Data Stream Control Register (DSCR) sysfs interface test
+ *
+ * This test updates to system wide DSCR default through the sysfs interface
+ * and then verifies that all the CPU specific DSCR defaults are updated as
+ * well verified from their sysfs interfaces.
+ *
+ * Copyright (C) 2015 Anshuman Khandual <khandual@linux.vnet.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "dscr.h"
+
+static int check_cpu_dscr_default(char *file, unsigned long val)
+{
+	char buf[10];
+	int fd, rc;
+
+	fd = open(file, O_RDWR);
+	if (fd == -1) {
+		perror("open() failed\n");
+		return 1;
+	}
+
+	rc = read(fd, buf, sizeof(buf));
+	if (rc == -1) {
+		perror("read() failed\n");
+		return 1;
+	}
+	close(fd);
+
+	buf[rc] = '\0';
+	if (strtol(buf, NULL, 16) != val) {
+		printf("DSCR match failed: %ld (system) %ld (cpu)\n",
+					val, strtol(buf, NULL, 16));
+		return 1;
+	}
+	return 0;
+}
+
+static int check_all_cpu_dscr_defaults(unsigned long val)
+{
+	DIR *sysfs;
+	struct dirent *dp;
+	char file[LEN_MAX];
+
+	sysfs = opendir(CPU_PATH);
+	if (!sysfs) {
+		perror("opendir() failed\n");
+		return 1;
+	}
+
+	while ((dp = readdir(sysfs))) {
+		if (!(dp->d_type & DT_DIR))
+			continue;
+		if (!strcmp(dp->d_name, "cpuidle"))
+			continue;
+		if (!strstr(dp->d_name, "cpu"))
+			continue;
+
+		sprintf(file, "%s%s/dscr", CPU_PATH, dp->d_name);
+		if (access(file, F_OK))
+			continue;
+
+		if (check_cpu_dscr_default(file, val))
+			return 1;
+	}
+	closedir(sysfs);
+	return 0;
+}
+
+int test_body(void)
+{
+	int i, j;
+
+	for (i = 0; i < COUNT; i++) {
+		for (j = 0; j < DSCR_MAX; j++) {
+			set_default_dscr(j);
+			if (check_all_cpu_dscr_defaults(j))
+				return 1;
+		}
+	}
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(test_body, "dscr_sysfs_test");
+}
-- 
1.9.3
