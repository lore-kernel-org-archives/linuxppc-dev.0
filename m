Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C87B1A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 18:44:56 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 14:14:53 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 79403E0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 14:18:06 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t538ilM747775884
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 14:14:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t538ihvl024653
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 14:14:43 +0530
Message-ID: <556EBE7B.20600@linux.vnet.ibm.com>
Date: Wed, 03 Jun 2015 14:14:43 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
CC: mikey@neuling.org, anton@samba.org, shuahkh@osg.samsung.com
Subject: Re: [PATCH V5 12/13] selftests, powerpc: Add thread based stress
 test for DSCR sysfs interfaces
References: <1432190593-17253-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1432190593-17253-13-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432190593-17253-13-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/21/2015 12:13 PM, Anshuman Khandual wrote:
> This patch adds a test to update the system wide DSCR value repeatedly
> and then verifies that any thread on any given CPU on the system must
> be able to see the same DSCR value whether its is being read through
> the problem state based SPR or the privilege state based SPR.

This test can fail on a system if some kind of cpu hotplug activity is
happening when this test is being run at the same time. Then call to
sched_setaffinity() might fail as the test does not check for the CPU
availability/online every time before changing the affinity of the
thread. Here is one changed version of this test which achieves similar
test objective.

Michael,

Please let me know if the patch here would be okay or I need to re-spin
the patch series for this change. Thank you.

----------------------------------------------------------------------------------
[PATCH] selftests, powerpc: Add thread based stress test for DSCR sysfs interfaces

This patch adds a test to update the system wide DSCR value repeatedly
and then verifies that any thread on any given CPU on the system must
be able to see the same DSCR value whether its is being read through
the problem state based SPR or the privilege state based SPR.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/dscr/Makefile      |  2 +-
 .../powerpc/dscr/dscr_sysfs_thread_test.c          | 81 ++++++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c

diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index fada526..834ef88 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -1,6 +1,6 @@
 PROGS := dscr_default_test dscr_explicit_test dscr_user_test	\
 	 dscr_inherit_test dscr_inherit_exec_test		\
-	 dscr_sysfs_test
+	 dscr_sysfs_test dscr_sysfs_thread_test
 
 CFLAGS := $(CFLAGS) -lpthread
 
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
new file mode 100644
index 0000000..9671d52
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
@@ -0,0 +1,81 @@
+/*
+ * POWER Data Stream Control Register (DSCR) sysfs thread test
+ *
+ * This test updates the system wide DSCR default value through
+ * sysfs interface which should then update all the CPU specific
+ * DSCR default values which must also be then visible to threads
+ * executing on individual CPUs on the system.
+ *
+ * Copyright (C) 2015 Anshuman Khandual <khandual@linux.vnet.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#define _GNU_SOURCE
+#include "dscr.h"
+
+static int test_thread_dscr(unsigned long val)
+{
+	unsigned long cur_dscr, cur_dscr_usr;
+
+	cur_dscr = get_dscr();
+	cur_dscr_usr = get_dscr_usr();
+
+	if (val != cur_dscr) {
+		printf("[cpu %d] Kernel DSCR should be %ld but is %ld\n",
+					sched_getcpu(), val, cur_dscr);
+		return 1;
+	}
+
+	if (val != cur_dscr_usr) {
+		printf("[cpu %d] User DSCR should be %ld but is %ld\n",
+					sched_getcpu(), val, cur_dscr_usr);
+		return 1;
+	}
+	return 0;
+}
+
+static int check_cpu_dscr_thread(unsigned long val)
+{
+	cpu_set_t mask;
+	int cpu;
+
+	for (cpu = 0; cpu < CPU_SETSIZE; cpu++) {
+		CPU_ZERO(&mask);
+		CPU_SET(cpu, &mask);
+		if (sched_setaffinity(0, sizeof(mask), &mask))
+			continue;
+
+		if (test_thread_dscr(val))
+			return 1;
+	}
+	return 0;
+
+}
+
+int dscr_sysfs_thread(void)
+{
+	unsigned long orig_dscr_default;
+	int i, j;
+
+	orig_dscr_default = get_default_dscr();
+	for (i = 0; i < COUNT; i++) {
+		for (j = 0; j < DSCR_MAX; j++) {
+			set_default_dscr(j);
+			if (check_cpu_dscr_thread(j))
+				goto fail;
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
+	return test_harness(dscr_sysfs_thread, "dscr_sysfs_thread_test");
+}
-- 
2.1.0
