Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB6851A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 16:50:25 +1100 (AEDT)
Received: by mail-pa0-x229.google.com with SMTP id q3so107390727pav.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 21:50:25 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	mpe@ellermen.id.au
Subject: [PATCH 1/5] selftests/powerpc: Make reg.h common to all powerpc
 selftests
Date: Wed, 23 Dec 2015 16:49:50 +1100
Message-Id: <1450849794-23174-2-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
References: <1450849794-23174-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently there is a reg.h in pmu/ebb that has defines that are useful in
other powerpc selftests so move this up into selftests/powerpc folder. Also
include in utils.h - as this is often used in self tests. Add in some other
useful register defines.
---
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      |  1 -
 tools/testing/selftests/powerpc/pmu/ebb/reg.h      | 49 ----------------------
 .../selftests/powerpc/pmu/ebb/reg_access_test.c    |  1 -
 tools/testing/selftests/powerpc/reg.h              | 43 +++++++++++++++++++
 tools/testing/selftests/powerpc/utils.h            |  1 +
 5 files changed, 44 insertions(+), 51 deletions(-)
 delete mode 100644 tools/testing/selftests/powerpc/pmu/ebb/reg.h
 create mode 100644 tools/testing/selftests/powerpc/reg.h

diff --git a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
index e67452f1bcff..46681fec549b 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/ebb.c
@@ -15,7 +15,6 @@
 #include <sys/ioctl.h>
 
 #include "trace.h"
-#include "reg.h"
 #include "ebb.h"
 
 
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/reg.h b/tools/testing/selftests/powerpc/pmu/ebb/reg.h
deleted file mode 100644
index 5921b0dfe2e9..000000000000
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
index 5b1188f10c15..f923228bca22 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test.c
@@ -7,7 +7,6 @@
 #include <stdlib.h>
 
 #include "ebb.h"
-#include "reg.h"
 
 
 /*
diff --git a/tools/testing/selftests/powerpc/reg.h b/tools/testing/selftests/powerpc/reg.h
new file mode 100644
index 000000000000..1dacd8916a86
--- /dev/null
+++ b/tools/testing/selftests/powerpc/reg.h
@@ -0,0 +1,43 @@
+#define mfspr(rn)       ({unsigned long rval; \
+		        asm volatile("mfspr %0," _str(rn) \
+			            : "=r" (rval)); rval; })
+#define mtspr(rn, v)    asm volatile("mtspr " _str(rn) ",%0" : \
+		        	    : "r" ((unsigned long)(v)) \
+		                    : "memory")
+
+#define mb()            asm volatile("sync" : : : "memory");
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
+#define SPRN_TEXASR     0x82
+#define SPRN_TFIAR      0x81    /* Transaction Failure Inst Addr    */
+#define SPRN_TFHAR      0x80    /* Transaction Failure Handler Addr */
+#define TEXASR_FS       0x08000000
+#define SPRN_TAR        0x32f
+
diff --git a/tools/testing/selftests/powerpc/utils.h b/tools/testing/selftests/powerpc/utils.h
index 175ac6ad10dd..5231b35c7279 100644
--- a/tools/testing/selftests/powerpc/utils.h
+++ b/tools/testing/selftests/powerpc/utils.h
@@ -9,6 +9,7 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <linux/auxvec.h>
+#include "reg.h"
 
 /* Avoid headaches with PRI?64 - just use %ll? always */
 typedef unsigned long long u64;
-- 
2.5.0
