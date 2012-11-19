Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FE762C009A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 22:11:41 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 19 Nov 2012 16:41:37 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qAJBBYMc6094884
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2012 16:41:34 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qAJGfO38012715
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 03:41:25 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc,
 perf: Change PMU flag representation from decimal to hex
Date: Mon, 19 Nov 2012 16:41:46 +0530
Message-Id: <1353323506-17970-1-git-send-email-khandual@linux.vnet.ibm.com>
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
 Changed the 64 bit constants into 32 bit constants as it would apply to
 32 bit variable power_pmu.flags

 arch/powerpc/include/asm/perf_event_server.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 9710be3..d3e9748 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -45,11 +45,11 @@ struct power_pmu {
 /*
  * Values for power_pmu.flags
  */
-#define PPMU_LIMITED_PMC5_6	1	/* PMC5/6 have limited function */
-#define PPMU_ALT_SIPR		2	/* uses alternate posn for SIPR/HV */
-#define PPMU_NO_SIPR		4	/* no SIPR/HV in MMCRA at all */
-#define PPMU_NO_CONT_SAMPLING	8	/* no continuous sampling */
-#define PPMU_SIAR_VALID		16	/* Processor has SIAR Valid bit */
+#define PPMU_LIMITED_PMC5_6	0x00000001 /* PMC5/6 have limited function */
+#define PPMU_ALT_SIPR		0x00000002 /* uses alternate posn for SIPR/HV */
+#define PPMU_NO_SIPR		0x00000004 /* no SIPR/HV in MMCRA at all */
+#define PPMU_NO_CONT_SAMPLING	0x00000008 /* no continuous sampling */
+#define PPMU_SIAR_VALID		0x00000010 /* Processor has SIAR Valid bit */
 
 /*
  * Values for flags to get_alternatives()
-- 
1.7.11.7
