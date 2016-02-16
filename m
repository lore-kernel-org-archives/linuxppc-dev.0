Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 395FF1A0316
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:02:38 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EFC731409B7
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:37 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:02:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 475952CE8059
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:34 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G92QiT65011860
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:34 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G91tuA020653
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:01 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 palves@redhat.com, oleg@redhat.com, dhowells@redhat.com,
 davej@redhat.com, davem@davemloft.net, mikey@neuling.org,
 benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com,
 mpe@ellerman.id.au, sam.bobroff@au1.ibm.com, kirjanov@gmail.com,
 shuahkh@osg.samsung.com, Ulrich.Weigand@de.ibm.com,
 emachado@linux.vnet.ibm.com
Subject: [PATCH V10 15/28] selftests,
 powerpc: Move 'reg.h' file outside of 'ebb' sub directory
Date: Tue, 16 Feb 2016 14:29:45 +0530
Message-Id: <1455613198-5113-16-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves 'reg.h' file from pmu 'ebb' sub directory
to the powerpc root directory to make all the register
definitions and instructions available for tests present
in other subsystems.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      |  2 +-
 tools/testing/selftests/powerpc/pmu/ebb/ebb.h      |  2 +-
 .../selftests/powerpc/pmu/ebb/ebb_handler.S        |  2 +-
 tools/testing/selftests/powerpc/pmu/ebb/reg.h      | 49 ----------------------
 .../selftests/powerpc/pmu/ebb/reg_access_test.c    |  2 +-
 tools/testing/selftests/powerpc/reg.h              | 49 ++++++++++++++++++++++
 6 files changed, 53 insertions(+), 53 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/reg.h
 create mode 100644 tools/testing/selftests/powerpc/reg.h

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
index e67452f..346749b 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -15,7 +15,7 @@
 #include <sys/ioctl.h>
 
 #include "trace.h"
-#include "reg.h"
+#include "../../reg.h"
 #include "ebb.h"
 
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.h b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
index f87e761..db7103d 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
@@ -9,7 +9,7 @@
 #include "../event.h"
 #include "../lib.h"
 #include "trace.h"
-#include "reg.h"
+#include "../../reg.h"
 
 #define PMC_INDEX(pmc)	((pmc)-1)
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb_handler.S b/tools/testing/selftests/powerpc/pmu/ebb/ebb_handler.S
index 14274ea..42cd367 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb_handler.S
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb_handler.S
@@ -4,7 +4,7 @@
  */
 
 #include <ppc-asm.h>
-#include "reg.h"
+#include "../../reg.h"
 
 
 /* ppc-asm.h defines most of the reg aliases, but not r1/r2. */
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/reg.h b/tools/testing/selftests/powerpc/pmu/ebb/reg.h
deleted file mode 100644
index 5921b0d..0000000
--- a/tools/testing/selftests/powerpc/pmu/ebb/reg.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- * Copyright 2014, Michael Ellerman, IBM Corp.
- * Licensed under GPLv2.
- */
-
-#ifndef _SELFTESTS_POWERPC_REG_H
-#define _SELFTESTS_POWERPC_REG_H
-
-#define __stringify_1(x)        #x
-#define __stringify(x)          __stringify_1(x)
-
-#define mfspr(rn)       ({unsigned long rval; \
-                         asm volatile("mfspr %0," __stringify(rn) \
-                                 : "=r" (rval)); rval; })
-#define mtspr(rn, v)    asm volatile("mtspr " __stringify(rn) ",%0" : \
-                                    : "r" ((unsigned long)(v)) \
-                                    : "memory")
-
-#define mb()		asm volatile("sync" : : : "memory");
-
-#define SPRN_MMCR2     769
-#define SPRN_MMCRA     770
-#define SPRN_MMCR0     779
-#define   MMCR0_PMAO   0x00000080
-#define   MMCR0_PMAE   0x04000000
-#define   MMCR0_FC     0x80000000
-#define SPRN_EBBHR     804
-#define SPRN_EBBRR     805
-#define SPRN_BESCR     806     /* Branch event status & control register */
-#define SPRN_BESCRS    800     /* Branch event status & control set (1 bits set to 1) */
-#define SPRN_BESCRSU   801     /* Branch event status & control set upper */
-#define SPRN_BESCRR    802     /* Branch event status & control REset (1 bits set to 0) */
-#define SPRN_BESCRRU   803     /* Branch event status & control REset upper */
-
-#define BESCR_PMEO     0x1     /* PMU Event-based exception Occurred */
-#define BESCR_PME      (0x1ul << 32) /* PMU Event-based exception Enable */
-
-#define SPRN_PMC1      771
-#define SPRN_PMC2      772
-#define SPRN_PMC3      773
-#define SPRN_PMC4      774
-#define SPRN_PMC5      775
-#define SPRN_PMC6      776
-
-#define SPRN_SIAR      780
-#define SPRN_SDAR      781
-#define SPRN_SIER      768
-
-#endif /* _SELFTESTS_POWERPC_REG_H */
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c b/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
index 5b1188f..b209c6b 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
@@ -7,7 +7,7 @@
 #include <stdlib.h>
 
 #include "ebb.h"
-#include "reg.h"
+#include "../../reg.h"
 
 
 /*
diff --git a/tools/testing/selftests/powerpc/reg.h b/tools/testing/selftests/powerpc/reg.h
new file mode 100644
index 0000000..5921b0d
--- /dev/null
+++ b/tools/testing/selftests/powerpc/reg.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2014, Michael Ellerman, IBM Corp.
+ * Licensed under GPLv2.
+ */
+
+#ifndef _SELFTESTS_POWERPC_REG_H
+#define _SELFTESTS_POWERPC_REG_H
+
+#define __stringify_1(x)        #x
+#define __stringify(x)          __stringify_1(x)
+
+#define mfspr(rn)       ({unsigned long rval; \
+                         asm volatile("mfspr %0," __stringify(rn) \
+                                 : "=r" (rval)); rval; })
+#define mtspr(rn, v)    asm volatile("mtspr " __stringify(rn) ",%0" : \
+                                    : "r" ((unsigned long)(v)) \
+                                    : "memory")
+
+#define mb()		asm volatile("sync" : : : "memory");
+
+#define SPRN_MMCR2     769
+#define SPRN_MMCRA     770
+#define SPRN_MMCR0     779
+#define   MMCR0_PMAO   0x00000080
+#define   MMCR0_PMAE   0x04000000
+#define   MMCR0_FC     0x80000000
+#define SPRN_EBBHR     804
+#define SPRN_EBBRR     805
+#define SPRN_BESCR     806     /* Branch event status & control register */
+#define SPRN_BESCRS    800     /* Branch event status & control set (1 bits set to 1) */
+#define SPRN_BESCRSU   801     /* Branch event status & control set upper */
+#define SPRN_BESCRR    802     /* Branch event status & control REset (1 bits set to 0) */
+#define SPRN_BESCRRU   803     /* Branch event status & control REset upper */
+
+#define BESCR_PMEO     0x1     /* PMU Event-based exception Occurred */
+#define BESCR_PME      (0x1ul << 32) /* PMU Event-based exception Enable */
+
+#define SPRN_PMC1      771
+#define SPRN_PMC2      772
+#define SPRN_PMC3      773
+#define SPRN_PMC4      774
+#define SPRN_PMC5      775
+#define SPRN_PMC6      776
+
+#define SPRN_SIAR      780
+#define SPRN_SDAR      781
+#define SPRN_SIER      768
+
+#endif /* _SELFTESTS_POWERPC_REG_H */
-- 
2.1.0
