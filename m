Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91BCC1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:47 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C3F6E140DD6
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:46 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:45 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7C558E0063
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:41:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8ZOU6160796
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:35 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8UBZ028443
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 15/28] selftests,
 powerpc: Move 'reg.h' file outside of 'ebb' sub directory
Date: Tue, 19 May 2015 20:38:11 +0530
Message-Id: <1432048104-4695-16-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
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
index d7a72ce..f98eda0 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -15,7 +15,7 @@
 #include <sys/ioctl.h>
 
 #include "trace.h"
-#include "reg.h"
+#include "../../reg.h"
 #include "ebb.h"
 
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.h b/tools/testing/selftests/powerpc/pmu/ebb/ebb.h
index e44eee5..7b38c3d 100644
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
index 0cae66f..ebdc595 100644
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
