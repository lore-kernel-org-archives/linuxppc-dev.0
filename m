Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E960D1A0BC3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 16:45:34 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 21 May 2015 12:15:33 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 19C3A125805A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:17:47 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L6hhvQ46530730
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 12:15:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L62DYY007958
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 11:32:14 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, anton@samba.org, shuahkh@osg.samsung.com,
 mpe@ellerman.id.au
Subject: [PATCH V5 07/13] selftests,
 powerpc: Add test for explicitly changing DSCR value
Date: Thu, 21 May 2015 12:13:07 +0530
Message-Id: <1432190593-17253-8-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch adds a test which modifies the DSCR using mtspr instruction
and verifies the change using mfspr instruction. It uses both the
privilege state SPR as well as the problem state SPR for the purpose.

Acked-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 tools/testing/selftests/powerpc/dscr/Makefile      |  2 +-
 .../selftests/powerpc/dscr/dscr_explicit_test.c    | 72 ++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c

diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index 0aa90ab..aede453 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -1,4 +1,4 @@
-PROGS := dscr_default_test
+PROGS := dscr_default_test dscr_explicit_test
 
 CFLAGS := $(CFLAGS) -lpthread
 
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c b/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
new file mode 100644
index 0000000..a0fe368
--- /dev/null
+++ b/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
@@ -0,0 +1,72 @@
+/*
+ * POWER Data Stream Control Register (DSCR) explicit test
+ *
+ * This test modifies the DSCR value using mtspr instruction and
+ * verifies the change with mfspr instruction. It uses both the
+ * privilege state SPR and the problem state SPR for this purpose.
+ *
+ * When using the privilege state SPR, the instructions such as
+ * mfspr or mtspr are priviledged and the kernel emulates them
+ * for us. Instructions using problem state SPR can be exuecuted
+ * directly without any emulation if the HW supports them. Else
+ * they also get emulated by the kernel.
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
+int dscr_explicit(void)
+{
+	unsigned long i, dscr = 0;
+
+	srand(getpid());
+	set_dscr(dscr);
+
+	for (i = 0; i < COUNT; i++) {
+		unsigned long cur_dscr, cur_dscr_usr;
+		double ret = uniform_deviate(rand());
+
+		if (ret < 0.001) {
+			dscr++;
+			if (dscr > DSCR_MAX)
+				dscr = 0;
+
+			set_dscr(dscr);
+		}
+
+		cur_dscr = get_dscr();
+		if (cur_dscr != dscr) {
+			fprintf(stderr, "Kernel DSCR should be %ld but "
+					"is %ld\n", dscr, cur_dscr);
+			return 1;
+		}
+
+		ret = uniform_deviate(rand());
+		if (ret < 0.001) {
+			dscr++;
+			if (dscr > DSCR_MAX)
+				dscr = 0;
+
+			set_dscr_usr(dscr);
+		}
+
+		cur_dscr_usr = get_dscr_usr();
+		if (cur_dscr_usr != dscr) {
+			fprintf(stderr, "User DSCR should be %ld but "
+					"is %ld\n", dscr, cur_dscr_usr);
+			return 1;
+		}
+	}
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	return test_harness(dscr_explicit, "dscr_explicit_test");
+}
-- 
2.1.0
