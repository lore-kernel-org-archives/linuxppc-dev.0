Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 80E752C0091
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 17:05:06 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 19 Nov 2012 16:00:58 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAJ5sNmT60358750
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 16:54:23 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAJ650Ge007125
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 17:05:00 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc,
 perf: Change PMU flag representation from decimal to hex
Date: Mon, 19 Nov 2012 11:33:43 +0530
Message-Id: <1353305023-7511-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: michael.neuling@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the representation of the PMU flags from decimal to hex since they
are bitfields which are easier to read in hex.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 9710be3..c77bb4e 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -45,11 +45,21 @@ struct power_pmu {
 /*
  * Values for power_pmu.flags
  */
-#define PPMU_LIMITED_PMC5_6	1	/* PMC5/6 have limited function */
-#define PPMU_ALT_SIPR		2	/* uses alternate posn for SIPR/HV */
-#define PPMU_NO_SIPR		4	/* no SIPR/HV in MMCRA at all */
-#define PPMU_NO_CONT_SAMPLING	8	/* no continuous sampling */
-#define PPMU_SIAR_VALID		16	/* Processor has SIAR Valid bit */
+
+#define PPMU_LIMITED_PMC5_6 \
+	0x0000000000000001UL /* PMC5/6 have limited function */
+
+#define PPMU_ALT_SIPR \
+	0x0000000000000002UL /* uses alternate posn for SIPR/HV */
+
+#define PPMU_NO_SIPR \
+	0x0000000000000004UL /* no SIPR/HV in MMCRA at all */
+
+#define PPMU_NO_CONT_SAMPLING \
+	0x0000000000000008UL /* no continuous sampling */
+
+#define PPMU_SIAR_VALID \
+	0x0000000000000010UL /* Processor has SIAR Valid bit */
 
 /*
  * Values for flags to get_alternatives()
-- 
1.7.11.7
