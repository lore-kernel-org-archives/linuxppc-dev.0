Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 323AD2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2012 19:59:46 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 16 Nov 2012 14:29:41 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAG8xaYs27132028
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2012 14:29:36 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAGETSIo024681
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Nov 2012 14:29:28 GMT
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc,
 perf: Change PMU flag values representation from decimal to hex
Date: Fri, 16 Nov 2012 14:29:04 +0530
Message-Id: <1353056344-1392-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: michael.neuling@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 9710be3..e3f10bb 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <asm/hw_irq.h>
+#include <asm/asm-compat.h>
 
 #define MAX_HWEVENTS		8
 #define MAX_EVENT_ALTERNATIVES	8
@@ -45,11 +46,21 @@ struct power_pmu {
 /*
  * Values for power_pmu.flags
  */
-#define PPMU_LIMITED_PMC5_6	1	/* PMC5/6 have limited function */
-#define PPMU_ALT_SIPR		2	/* uses alternate posn for SIPR/HV */
-#define PPMU_NO_SIPR		4	/* no SIPR/HV in MMCRA at all */
-#define PPMU_NO_CONT_SAMPLING	8	/* no continuous sampling */
-#define PPMU_SIAR_VALID		16	/* Processor has SIAR Valid bit */
+
+#define PPMU_LIMITED_PMC5_6	\
+	LONG_ASM_CONST(0x0000000000000001) /* PMC5/6 have limited function */
+
+#define PPMU_ALT_SIPR		\
+	LONG_ASM_CONST(0x0000000000000002) /* uses alternate posn for SIPR/HV */
+
+#define PPMU_NO_SIPR		\
+	LONG_ASM_CONST(0x0000000000000004) /* no SIPR/HV in MMCRA at all */
+
+#define PPMU_NO_CONT_SAMPLING	\
+	LONG_ASM_CONST(0x0000000000000008) /* no continuous sampling */
+
+#define PPMU_SIAR_VALID		\
+	LONG_ASM_CONST(0x0000000000000010) /* Processor has SIAR Valid bit */
 
 /*
  * Values for flags to get_alternatives()
-- 
1.7.11.7
