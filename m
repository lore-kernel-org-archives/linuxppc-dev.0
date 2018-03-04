Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvM2q4LG6zF09n
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 22:56:51 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w24BrrHc107260
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Mar 2018 06:56:49 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gga2j15jh-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 06:56:48 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 4 Mar 2018 11:56:47 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/perf: Add blacklisted events for power9 dd2.2
Date: Sun,  4 Mar 2018 17:26:28 +0530
In-Reply-To: <1520164588-19167-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1520164588-19167-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1520164588-19167-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-events-list.h | 15 +++++++++++++++
 arch/powerpc/perf/power9-pmu.c         | 22 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index 9d7a16a943a8..7de344b7d9cc 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -82,3 +82,18 @@ EVENT(PM_RADIX_PWC_L3_HIT,			0x3f056)
 EVENT(PM_RUN_CYC_SMT2_MODE,			0x3006c)
 EVENT(PM_TM_TX_PASS_RUN_INST,			0x4e014)
 EVENT(PM_DISP_HELD_SYNC_HOLD,			0x4003c)
+EVENT(PM_DTLB_MISS_16G,				0x1c058)
+EVENT(PM_DERAT_MISS_2M,				0x1c05a)
+EVENT(PM_DTLB_MISS_2M,				0x1c05c)
+EVENT(PM_MRK_DTLB_MISS_1G,			0x1d15c)
+EVENT(PM_DTLB_MISS_4K,				0x2c056)
+EVENT(PM_DERAT_MISS_1G,				0x2c05a)
+EVENT(PM_MRK_DERAT_MISS_2M,			0x2d152)
+EVENT(PM_MRK_DTLB_MISS_4K,			0x2d156)
+EVENT(PM_MRK_DTLB_MISS_16G,			0x2d15e)
+EVENT(PM_DTLB_MISS_64K,				0x3c056)
+EVENT(PM_MRK_DERAT_MISS_1G,			0x3d152)
+EVENT(PM_MRK_DTLB_MISS_64K,			0x3d156)
+EVENT(PM_DTLB_MISS_16M,				0x4c056)
+EVENT(PM_DTLB_MISS_1G,				0x4c05a)
+EVENT(PM_MRK_DTLB_MISS_16M,			0x4c15e)
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 3847607c16f0..2ca0b33b4efb 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -121,6 +121,25 @@ int p9_dd21_bl_ev[] = {
 	PM_DISP_HELD_SYNC_HOLD,
 };
 
+int p9_dd22_bl_ev[] = {
+	PM_DTLB_MISS_16G,
+	PM_DERAT_MISS_2M,
+	PM_DTLB_MISS_2M,
+	PM_MRK_DTLB_MISS_1G,
+	PM_DTLB_MISS_4K,
+	PM_DERAT_MISS_1G,
+	PM_MRK_DERAT_MISS_2M,
+	PM_MRK_DTLB_MISS_4K,
+	PM_MRK_DTLB_MISS_16G,
+	PM_DTLB_MISS_64K,
+	PM_MRK_DERAT_MISS_1G,
+	PM_MRK_DTLB_MISS_64K,
+	PM_DISP_HELD_SYNC_HOLD,
+	PM_DTLB_MISS_16M,
+	PM_DTLB_MISS_1G,
+	PM_MRK_DTLB_MISS_16M,
+};
+
 /* Table of alternatives, sorted by column 0 */
 static const unsigned int power9_event_alternatives[][MAX_ALT] = {
 	{ PM_INST_DISP,			PM_INST_DISP_ALT },
@@ -475,6 +494,9 @@ static int __init init_power9_pmu(void)
 		if ((PVR_CFG(pvr) == 2) && (PVR_MIN(pvr) == 1)) {
 			power9_pmu.blacklist_ev = p9_dd21_bl_ev;
 			power9_pmu.n_blacklist_ev = ARRAY_SIZE(p9_dd21_bl_ev);
+		} else if ((PVR_CFG(pvr) == 2) && (PVR_MIN(pvr) == 2)) {
+			power9_pmu.blacklist_ev = p9_dd22_bl_ev;
+			power9_pmu.n_blacklist_ev = ARRAY_SIZE(p9_dd22_bl_ev);
 		}
 	}
 
-- 
2.7.4
