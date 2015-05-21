Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 85BDD1A0BC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 16:44:07 +1000 (AEST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 21 May 2015 12:14:05 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 5E296E0057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:17:06 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L6hlQd47251678
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:13:48 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L62F9V008149
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 11:32:16 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, anton@samba.org, shuahkh@osg.samsung.com,
 mpe@ellerman.id.au
Subject: [PATCH V5 08/13] selftests, powerpc: Add test for DSCR SPR numbers
Date: Thu, 21 May 2015 12:13:08 +0530
Message-Id: <1432190593-17253-9-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch adds a test which verifies that the DSCR privilege and
problem state SPR read & write accesses while making sure that the
results are always the same irrespective of which SPR number is
being used.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 tools/testing/selftests/powerpc/dscr/Makefile      |  2 +-
 .../selftests/powerpc/dscr/dscr_user_test.c        | 62 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_user_test.c

diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index aede453..ae865d8 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -1,4 +1,4 @@
-PROGS := dscr_default_test dscr_explicit_test
+PROGS := dscr_default_test dscr_explicit_test dscr_user_test
 
 CFLAGS := $(CFLAGS) -lpthread
 
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_user_test.c b/tools/testing/selftests/powerpc/dscr/dscr_user_test.c
new file mode 100644
index 0000000..c23c2f3
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/dscr_user_test.c
@@ -0,0 +1,62 @@
+/*
+ * POWER Data Stream Control Register (DSCR) SPR test
+ *
+ * This test modifies the DSCR value through both the SPR number
+ * based mtspr instruction and then makes sure that the same is
+ * reflected through mfspr instruction using either of the SPR
+ * numbers.
+ *
+ * When using the privilege state SPR, the instructions such as
+ * mfspr or mtspr are priviledged and the kernel emulates them
+ * for us. Instructions using problem state SPR can be exuecuted
+ * directly without any emulation if the HW supports them. Else
+ * they also get emulated by the kernel.
+ *
+ * Copyright (C) 2013 Anton Blanchard <anton@au.ibm.com>, IBM
+ * Copyright (C) 2015 Anshuman Khandual <khandual@linux.vnet.ibm.com>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include "dscr.h"
+
+static int check_dscr(char *str)
+{
+	unsigned long cur_dscr, cur_dscr_usr;
+
+	cur_dscr = get_dscr();
+	cur_dscr_usr = get_dscr_usr();
+	if (cur_dscr != cur_dscr_usr) {
+		printf("%s set, kernel get %lx != user get %lx\n",
+					str, cur_dscr, cur_dscr_usr);
+		return 1;
+	}
+	return 0;
+}
+
+int dscr_user(void)
+{
+	int i;
+
+	check_dscr("");
+
+	for (i = 0; i < COUNT; i++) {
+		set_dscr(i);
+		if (check_dscr("kernel"))
+			return 1;
+	}
+
+	for (i = 0; i < COUNT; i++) {
+		set_dscr_usr(i);
+		if (check_dscr("user"))
+			return 1;
+	}
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(dscr_user, "dscr_user_test");
+}
-- 
2.1.0
