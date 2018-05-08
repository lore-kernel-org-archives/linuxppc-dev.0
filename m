Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40g6kg1JnJzF1nY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 May 2018 15:00:42 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w484melm092071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 May 2018 01:00:38 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hu216xh2x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2018 01:00:38 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 8 May 2018 06:00:36 +0100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Update raw-event code encoding comment for
 power8
Date: Tue,  8 May 2018 10:30:24 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1525755624-9802-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Comment explanning the raw event code encoding for Power8 was
moved to isa207_common.h file when re-factoring the code to
support power9. But then Power9 pmu branched out due to changes
specific to power9. So move the encoding comment back to power8-pmu.c
Just comment movement and no logic change.

Fixes: 4d3576b20716 ('powerpc/perf: factor out power8 pmu macros and defines')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.h | 64 ---------------------------------------
 arch/powerpc/perf/power8-pmu.c    | 64 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 6c737d675792..6a0b586c935a 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -17,70 +17,6 @@
 #include <asm/firmware.h>
 #include <asm/cputable.h>
 
-/*
- * Raw event encoding for PowerISA v2.07:
- *
- *        60        56        52        48        44        40        36        32
- * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
- *   | | [ ]                           [      thresh_cmp     ]   [  thresh_ctl   ]
- *   | |  |                                                              |
- *   | |  *- IFM (Linux)                 thresh start/stop OR FAB match -*
- *   | *- BHRB (Linux)
- *   *- EBB (Linux)
- *
- *        28        24        20        16        12         8         4         0
- * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
- *   [   ] [  sample ]   [cache]   [ pmc ]   [unit ]   c     m   [    pmcxsel    ]
- *     |        |           |                          |     |
- *     |        |           |                          |     *- mark
- *     |        |           *- L1/L2/L3 cache_sel      |
- *     |        |                                      |
- *     |        *- sampling mode for marked events     *- combine
- *     |
- *     *- thresh_sel
- *
- * Below uses IBM bit numbering.
- *
- * MMCR1[x:y] = unit    (PMCxUNIT)
- * MMCR1[x]   = combine (PMCxCOMB)
- *
- * if pmc == 3 and unit == 0 and pmcxsel[0:6] == 0b0101011
- *	# PM_MRK_FAB_RSP_MATCH
- *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
- * else if pmc == 4 and unit == 0xf and pmcxsel[0:6] == 0b0101001
- *	# PM_MRK_FAB_RSP_MATCH_CYC
- *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
- * else
- *	MMCRA[48:55] = thresh_ctl   (THRESH START/END)
- *
- * if thresh_sel:
- *	MMCRA[45:47] = thresh_sel
- *
- * if thresh_cmp:
- *	MMCRA[22:24] = thresh_cmp[0:2]
- *	MMCRA[25:31] = thresh_cmp[3:9]
- *
- * if unit == 6 or unit == 7
- *	MMCRC[53:55] = cache_sel[1:3]      (L2EVENT_SEL)
- * else if unit == 8 or unit == 9:
- *	if cache_sel[0] == 0: # L3 bank
- *		MMCRC[47:49] = cache_sel[1:3]  (L3EVENT_SEL0)
- *	else if cache_sel[0] == 1:
- *		MMCRC[50:51] = cache_sel[2:3]  (L3EVENT_SEL1)
- * else if cache_sel[1]: # L1 event
- *	MMCR1[16] = cache_sel[2]
- *	MMCR1[17] = cache_sel[3]
- *
- * if mark:
- *	MMCRA[63]    = 1		(SAMPLE_ENABLE)
- *	MMCRA[57:59] = sample[0:2]	(RAND_SAMP_ELIG)
- *	MMCRA[61:62] = sample[3:4]	(RAND_SAMP_MODE)
- *
- * if EBB and BHRB:
- *	MMCRA[32:33] = IFM
- *
- */
-
 #define EVENT_EBB_MASK		1ull
 #define EVENT_EBB_SHIFT		PERF_EVENT_CONFIG_EBB_SHIFT
 #define EVENT_BHRB_MASK		1ull
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index c9356955cab4..d12a2db26353 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -30,6 +30,70 @@ enum {
 #define	POWER8_MMCRA_IFM2		0x0000000080000000UL
 #define	POWER8_MMCRA_IFM3		0x00000000C0000000UL
 
+/*
+ * Raw event encoding for PowerISA v2.07 (Power8):
+ *
+ *        60        56        52        48        44        40        36        32
+ * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
+ *   | | [ ]                           [      thresh_cmp     ]   [  thresh_ctl   ]
+ *   | |  |                                                              |
+ *   | |  *- IFM (Linux)                 thresh start/stop OR FAB match -*
+ *   | *- BHRB (Linux)
+ *   *- EBB (Linux)
+ *
+ *        28        24        20        16        12         8         4         0
+ * | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - | - - - - |
+ *   [   ] [  sample ]   [cache]   [ pmc ]   [unit ]   c     m   [    pmcxsel    ]
+ *     |        |           |                          |     |
+ *     |        |           |                          |     *- mark
+ *     |        |           *- L1/L2/L3 cache_sel      |
+ *     |        |                                      |
+ *     |        *- sampling mode for marked events     *- combine
+ *     |
+ *     *- thresh_sel
+ *
+ * Below uses IBM bit numbering.
+ *
+ * MMCR1[x:y] = unit    (PMCxUNIT)
+ * MMCR1[x]   = combine (PMCxCOMB)
+ *
+ * if pmc == 3 and unit == 0 and pmcxsel[0:6] == 0b0101011
+ *	# PM_MRK_FAB_RSP_MATCH
+ *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
+ * else if pmc == 4 and unit == 0xf and pmcxsel[0:6] == 0b0101001
+ *	# PM_MRK_FAB_RSP_MATCH_CYC
+ *	MMCR1[20:27] = thresh_ctl   (FAB_CRESP_MATCH / FAB_TYPE_MATCH)
+ * else
+ *	MMCRA[48:55] = thresh_ctl   (THRESH START/END)
+ *
+ * if thresh_sel:
+ *	MMCRA[45:47] = thresh_sel
+ *
+ * if thresh_cmp:
+ *	MMCRA[22:24] = thresh_cmp[0:2]
+ *	MMCRA[25:31] = thresh_cmp[3:9]
+ *
+ * if unit == 6 or unit == 7
+ *	MMCRC[53:55] = cache_sel[1:3]      (L2EVENT_SEL)
+ * else if unit == 8 or unit == 9:
+ *	if cache_sel[0] == 0: # L3 bank
+ *		MMCRC[47:49] = cache_sel[1:3]  (L3EVENT_SEL0)
+ *	else if cache_sel[0] == 1:
+ *		MMCRC[50:51] = cache_sel[2:3]  (L3EVENT_SEL1)
+ * else if cache_sel[1]: # L1 event
+ *	MMCR1[16] = cache_sel[2]
+ *	MMCR1[17] = cache_sel[3]
+ *
+ * if mark:
+ *	MMCRA[63]    = 1		(SAMPLE_ENABLE)
+ *	MMCRA[57:59] = sample[0:2]	(RAND_SAMP_ELIG)
+ *	MMCRA[61:62] = sample[3:4]	(RAND_SAMP_MODE)
+ *
+ * if EBB and BHRB:
+ *	MMCRA[32:33] = IFM
+ *
+ */
+
 /* PowerISA v2.07 format attribute structure*/
 extern struct attribute_group isa207_pmu_format_group;
 
-- 
2.7.4
