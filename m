Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 078341A0BDF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 16:43:49 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 21 May 2015 12:13:48 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 07329E004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:16:51 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L6hXqg50069684
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:13:33 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L62C0P007772
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 11:32:12 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, anton@samba.org, shuahkh@osg.samsung.com,
 mpe@ellerman.id.au
Subject: [PATCH V5 06/13] selftests,
 powerpc: Add test for system wide DSCR default
Date: Thu, 21 May 2015 12:13:06 +0530
Message-Id: <1432190593-17253-7-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a test case for the system wide DSCR default
value, which when changed through it's sysfs interface must
be visible to all threads reading DSCR either through the
privilege state SPR or the problem state SPR. The DSCR value
change should be immediate as well.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 tools/testing/selftests/powerpc/Makefile           |   2 +-
 tools/testing/selftests/powerpc/dscr/Makefile      |  17 +++
 tools/testing/selftests/powerpc/dscr/dscr.h        | 128 +++++++++++++++++++++
 .../selftests/powerpc/dscr/dscr_default_test.c     | 128 +++++++++++++++++++++
 4 files changed, 274 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/dscr/Makefile
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr.h
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_default_test.c

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 5ad0423..03ca2e6 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -12,7 +12,7 @@ CFLAGS := -Wall -O2 -flto -Wall -Werror -DGIT_VERSION='"$(GIT_VERSION)"' -I$(CUR
 
 export CFLAGS
 
-SUB_DIRS = pmu copyloops mm tm primitives stringloops vphn switch_endian
+SUB_DIRS = pmu copyloops mm tm primitives stringloops vphn switch_endian dscr
 
 endif
 
diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
new file mode 100644
index 0000000..0aa90ab
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -0,0 +1,17 @@
+PROGS := dscr_default_test
+
+CFLAGS := $(CFLAGS) -lpthread
+
+all: $(PROGS)
+
+$(PROGS): ../harness.c
+
+run_tests: all
+	@-for PROG in $(PROGS); do \
+		./$$PROG; \
+	done;
+
+clean:
+	rm -f $(PROGS) *.o
+
+.PHONY: all run_tests clean
diff --git a/tools/testing/selftests/powerpc/dscr/dscr.h b/tools/testing/selftests/powerpc/dscr/dscr.h
new file mode 100644
index 0000000..c98622c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/dscr.h
@@ -0,0 +1,128 @@
+/*
+ * POWER Data Stream Control Register (DSCR)
+ *
+ * This header file contains helper functions and macros
+ * required for all the DSCR related test cases.
+ *
+ * Copyright (C) 2012 Anton Blanchard <anton@au.ibm.com>, IBM
+ * Copyright (C) 2015 Anshuman Khandual <khandual@linux.vnet.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#ifndef _SELFTESTS_POWERPC_DSCR_DSCR_H
+#define _SELFTESTS_POWERPC_DSCR_DSCR_H
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <fcntl.h>
+#include <dirent.h>
+#include <pthread.h>
+#include <sched.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+
+#include "utils.h"
+
+#define SPRN_DSCR	0x11	/* Privilege state SPR */
+#define SPRN_DSCR_USR	0x03	/* Problem state SPR */
+#define THREADS		100	/* Max threads */
+#define COUNT		100	/* Max iterations */
+#define DSCR_MAX	16	/* Max DSCR value */
+#define LEN_MAX		100	/* Max name length */
+
+#define DSCR_DEFAULT	"/sys/devices/system/cpu/dscr_default"
+#define CPU_PATH	"/sys/devices/system/cpu/"
+
+#define rmb()  asm volatile("lwsync":::"memory")
+#define wmb()  asm volatile("lwsync":::"memory")
+
+#define ACCESS_ONCE(x) (*(volatile typeof(x) *)&(x))
+
+/* Prilvilege state DSCR access */
+inline unsigned long get_dscr(void)
+{
+	unsigned long ret;
+
+	asm volatile("mfspr %0,%1" : "=r" (ret): "i" (SPRN_DSCR));
+
+	return ret;
+}
+
+inline void set_dscr(unsigned long val)
+{
+	asm volatile("mtspr %1,%0" : : "r" (val), "i" (SPRN_DSCR));
+}
+
+/* Problem state DSCR access */
+inline unsigned long get_dscr_usr(void)
+{
+	unsigned long ret;
+
+	asm volatile("mfspr %0,%1" : "=r" (ret): "i" (SPRN_DSCR_USR));
+
+	return ret;
+}
+
+inline void set_dscr_usr(unsigned long val)
+{
+	asm volatile("mtspr %1,%0" : : "r" (val), "i" (SPRN_DSCR_USR));
+}
+
+/* Default DSCR access */
+unsigned long get_default_dscr(void)
+{
+	int fd = -1, ret;
+	char buf[16];
+	unsigned long val;
+
+	if (fd == -1) {
+		fd = open(DSCR_DEFAULT, O_RDONLY);
+		if (fd == -1) {
+			perror("open() failed");
+			exit(1);
+		}
+	}
+	memset(buf, 0, sizeof(buf));
+	lseek(fd, 0, SEEK_SET);
+	ret = read(fd, buf, sizeof(buf));
+	if (ret == -1) {
+		perror("read() failed");
+		exit(1);
+	}
+	sscanf(buf, "%lx", &val);
+	close(fd);
+	return val;
+}
+
+void set_default_dscr(unsigned long val)
+{
+	int fd = -1, ret;
+	char buf[16];
+
+	if (fd == -1) {
+		fd = open(DSCR_DEFAULT, O_RDWR);
+		if (fd == -1) {
+			perror("open() failed");
+			exit(1);
+		}
+	}
+	sprintf(buf, "%lx\n", val);
+	ret = write(fd, buf, strlen(buf));
+	if (ret == -1) {
+		perror("write() failed");
+		exit(1);
+	}
+	close(fd);
+}
+
+double uniform_deviate(int seed)
+{
+	return seed * (1.0 / (RAND_MAX + 1.0));
+}
+#endif	/* _SELFTESTS_POWERPC_DSCR_DSCR_H */
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_default_test.c b/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
new file mode 100644
index 0000000..849b1cde0
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
@@ -0,0 +1,128 @@
+/*
+ * POWER Data Stream Control Register (DSCR) default test
+ *
+ * This test modifies the system wide default DSCR through
+ * it's sysfs interface and then verifies that all threads
+ * see the correct changed DSCR value immediately.
+ *
+ * Copyright (C) 2012 Anton Blanchard <anton@au.ibm.com>, IBM
+ * Copyright (C) 2015 Anshuman Khandual <khandual@linux.vnet.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "dscr.h"
+
+static unsigned long dscr;		/* System DSCR default */
+static unsigned long sequence;
+static unsigned long result[THREADS];
+
+static void *do_test(void *in)
+{
+	unsigned long thread = (unsigned long)in;
+	unsigned long i;
+
+	for (i = 0; i < COUNT; i++) {
+		unsigned long d, cur_dscr, cur_dscr_usr;
+		unsigned long s1, s2;
+
+		s1 = ACCESS_ONCE(sequence);
+		if (s1 & 1)
+			continue;
+		rmb();
+
+		d = dscr;
+		cur_dscr = get_dscr();
+		cur_dscr_usr = get_dscr_usr();
+
+		rmb();
+		s2 = sequence;
+
+		if (s1 != s2)
+			continue;
+
+		if (cur_dscr != d) {
+			fprintf(stderr, "thread %ld kernel DSCR should be %ld "
+				"but is %ld\n", thread, d, cur_dscr);
+			result[thread] = 1;
+			pthread_exit(&result[thread]);
+		}
+
+		if (cur_dscr_usr != d) {
+			fprintf(stderr, "thread %ld user DSCR should be %ld "
+				"but is %ld\n", thread, d, cur_dscr_usr);
+			result[thread] = 1;
+			pthread_exit(&result[thread]);
+		}
+	}
+	result[thread] = 0;
+	pthread_exit(&result[thread]);
+}
+
+int dscr_default(void)
+{
+	pthread_t threads[THREADS];
+	unsigned long i, *status[THREADS];
+	unsigned long orig_dscr_default;
+
+	orig_dscr_default = get_default_dscr();
+
+	/* Initial DSCR default */
+	dscr = 1;
+	set_default_dscr(dscr);
+
+	/* Spawn all testing threads */
+	for (i = 0; i < THREADS; i++) {
+		if (pthread_create(&threads[i], NULL, do_test, (void *)i)) {
+			perror("pthread_create() failed");
+			goto fail;
+		}
+	}
+
+	srand(getpid());
+
+	/* Keep changing the DSCR default */
+	for (i = 0; i < COUNT; i++) {
+		double ret = uniform_deviate(rand());
+
+		if (ret < 0.0001) {
+			sequence++;
+			wmb();
+
+			dscr++;
+			if (dscr > DSCR_MAX)
+				dscr = 0;
+
+			set_default_dscr(dscr);
+
+			wmb();
+			sequence++;
+		}
+	}
+
+	/* Individual testing thread exit status */
+	for (i = 0; i < THREADS; i++) {
+		if (pthread_join(threads[i], (void **)&(status[i]))) {
+			perror("pthread_join() failed");
+			goto fail;
+		}
+
+		if (*status[i]) {
+			printf("%ldth thread failed to join with %ld status\n",
+								i, *status[i]);
+			goto fail;
+		}
+	}
+	set_default_dscr(orig_dscr_default);
+	return 0;
+fail:
+	set_default_dscr(orig_dscr_default);
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(dscr_default, "dscr_default_test");
+}
-- 
2.1.0
