Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D48DB2C01E5
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Apr 2013 22:26:49 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Thu, 18 Apr 2013 17:53:11 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CD00C394005A
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Apr 2013 17:56:32 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3ICQQvd21758014
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Apr 2013 17:56:26 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3ICQV62008575
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Apr 2013 22:26:31 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/5] powerpc,
 perf: Add basic assembly code to read BHRB entries on POWER8
Date: Thu, 18 Apr 2013 17:56:13 +0530
Message-Id: <1366287976-3900-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1366287976-3900-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1366287976-3900-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the basic assembly code to read BHRB buffer. BHRB entries
are valid only after a PMU interrupt has happened (when MMCR0[PMAO]=1)
and BHRB has been freezed. BHRB read should not be attempted when it is
still enabled (MMCR0[PMAE]=1) and getting updated, as this can produce
non-deterministic results.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/Makefile |  2 +-
 arch/powerpc/perf/bhrb.S   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/perf/bhrb.S

diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
index 472db18..510fae1 100644
--- a/arch/powerpc/perf/Makefile
+++ b/arch/powerpc/perf/Makefile
@@ -2,7 +2,7 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 obj-$(CONFIG_PERF_EVENTS)	+= callchain.o
 
-obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o
+obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
 obj64-$(CONFIG_PPC_PERF_CTRS)	+= power4-pmu.o ppc970-pmu.o power5-pmu.o \
 				   power5+-pmu.o power6-pmu.o power7-pmu.o \
 				   power8-pmu.o
diff --git a/arch/powerpc/perf/bhrb.S b/arch/powerpc/perf/bhrb.S
new file mode 100644
index 0000000..d85f9a5
--- /dev/null
+++ b/arch/powerpc/perf/bhrb.S
@@ -0,0 +1,44 @@
+/*
+ * Basic assembly code to read BHRB entries
+ *
+ * Copyright 2013 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <asm/ppc_asm.h>
+#include <asm/ppc-opcode.h>
+
+	.text
+
+.balign 8
+
+/* r3 = n  (where n = [0-31])
+ * The maximum number of BHRB entries supported with PPC_MFBHRBE instruction
+ * is 1024. We have limited number of table entries here as POWER8 implements
+ * 32 BHRB entries.
+ */
+
+/* .global read_bhrb */
+_GLOBAL(read_bhrb)
+	cmpldi	r3,31
+	bgt	1f
+	ld	r4,bhrb_table@got(r2)
+	sldi	r3,r3,3
+	add	r3,r4,r3
+	mtctr	r3
+	bctr
+1:	li	r3,0
+	blr
+
+#define MFBHRB_TABLE1(n) PPC_MFBHRBE(R3,n); blr
+#define MFBHRB_TABLE2(n) MFBHRB_TABLE1(n); MFBHRB_TABLE1(n+1)
+#define MFBHRB_TABLE4(n) MFBHRB_TABLE2(n); MFBHRB_TABLE2(n+2)
+#define MFBHRB_TABLE8(n) MFBHRB_TABLE4(n); MFBHRB_TABLE4(n+4)
+#define MFBHRB_TABLE16(n) MFBHRB_TABLE8(n); MFBHRB_TABLE8(n+8)
+#define MFBHRB_TABLE32(n) MFBHRB_TABLE16(n); MFBHRB_TABLE16(n+16)
+
+bhrb_table:
+	MFBHRB_TABLE32(0)
-- 
1.7.11.7
