Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC3AD1A0C19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:07 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 13 Jan 2015 20:23:07 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F0DBD2BB0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:03 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0DAN3cm47120448
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:03 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0DAN3jv021659
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 21:23:03 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/12] selftests,
 powerpc: Add test for explicitly changing DSCR value
Date: Tue, 13 Jan 2015 15:52:35 +0530
Message-Id: <1421144560-15901-8-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch adds a test which modifies the DSCR using mtspr instruction
and verifies the change using mfspr instruction. It uses both the
privilege state SPR as well as the problem state SPR for the purpose.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
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
index 0000000..5c0b7c1
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
+int test_body(void)
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
+	return test_harness(test_body, "dscr_explicit_test");
+}
-- 
1.9.3
