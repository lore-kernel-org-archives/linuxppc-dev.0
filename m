Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 629662C0253
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 01:55:06 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 17 Apr 2013 01:52:52 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BC533357804E
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 01:55:03 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3GFf8nN30474318
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 01:41:08 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3GFsXlE027795
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Apr 2013 01:54:33 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] powerpc,
 perf: Add basic assembly code to read BHRB entries on POWER8
Date: Tue, 16 Apr 2013 21:24:07 +0530
Message-Id: <1366127650-1952-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1366127650-1952-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1366127650-1952-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the basic assembly code to read BHRB entries

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
index 0000000..0e8a018
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
+/* r3 = n  (where n = [0-1023])
+ * The maximum number of BHRB entries supported with PPC_MFBHRBE instruction
+ * is 1024. We have limited number of table entries here as POWER8 implements
+ * 32 BHRB entries.
+ */
+
+/* .global read_bhrb */
+_GLOBAL(read_bhrb)
+	cmpldi	r3,1023
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
