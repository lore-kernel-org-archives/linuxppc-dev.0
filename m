Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7214B1A0C46
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:15 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 13 Jan 2015 20:23:15 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 61AC52BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:12 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0DANCEd39846140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:12 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0DANBgi021927
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:11 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/12] selftests,
 powerpc: Add test for all DSCR sysfs interfaces
Date: Tue, 13 Jan 2015 15:52:39 +0530
Message-Id: <1421144560-15901-12-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1421144560-15901-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
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

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/dscr/Makefile      |  3 +-
 .../selftests/powerpc/dscr/dscr_sysfs_test.c       | 89 ++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletion(-)
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
index 0000000..3d11439
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
@@ -0,0 +1,89 @@
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
