Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvM2n162LzDrn2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Mar 2018 22:56:48 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w24BrsEV086937
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 4 Mar 2018 06:56:47 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gfs4krt2t-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Mar 2018 06:56:46 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 4 Mar 2018 11:56:44 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/perf: Add blacklisted events for power9 dd2.1
Date: Sun,  4 Mar 2018 17:26:27 +0530
In-Reply-To: <1520164588-19167-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1520164588-19167-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1520164588-19167-2-git-send-email-maddy@linux.vnet.ibm.com>
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
 arch/powerpc/perf/power9-events-list.h | 13 +++++++++++++
 arch/powerpc/perf/power9-pmu.c         | 26 ++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index e99c6bf4d391..9d7a16a943a8 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -69,3 +69,16 @@ EVENT(PM_BR_CMPL_ALT,				0x10012)
 EVENT(PM_BR_2PATH,				0x20036)
 /* ALternate branch event that are not strongly biased */
 EVENT(PM_BR_2PATH_ALT,				0x40036)
+
+/* Blacklisted events */
+EVENT(PM_MRK_ST_DONE_L2,			0x10134)
+EVENT(PM_RADIX_PWC_L1_HIT,			0x1f056)
+EVENT(PM_FLOP_CMPL,				0x100f4)
+EVENT(PM_MRK_NTF_FIN,				0x20112)
+EVENT(PM_RADIX_PWC_L2_HIT,			0x2d024)
+EVENT(PM_IFETCH_THROTTLE,			0x3405e)
+EVENT(PM_MRK_L2_TM_ST_ABORT_SISTER,		0x3e15c)
+EVENT(PM_RADIX_PWC_L3_HIT,			0x3f056)
+EVENT(PM_RUN_CYC_SMT2_MODE,			0x3006c)
+EVENT(PM_TM_TX_PASS_RUN_INST,			0x4e014)
+EVENT(PM_DISP_HELD_SYNC_HOLD,			0x4003c)
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 24b5b5b7a206..3847607c16f0 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -101,9 +101,26 @@ enum {
 #define POWER9_MMCRA_IFM2		0x0000000080000000UL
 #define POWER9_MMCRA_IFM3		0x00000000C0000000UL
 
+/* Nasty Power9 specific hack */
+#define PVR_POWER9_CUMULUS		0x00002000
+
 /* PowerISA v2.07 format attribute structure*/
 extern struct attribute_group isa207_pmu_format_group;
 
+int p9_dd21_bl_ev[] = {
+	PM_MRK_ST_DONE_L2,
+	PM_RADIX_PWC_L1_HIT,
+	PM_FLOP_CMPL,
+	PM_MRK_NTF_FIN,
+	PM_RADIX_PWC_L2_HIT,
+	PM_IFETCH_THROTTLE,
+	PM_MRK_L2_TM_ST_ABORT_SISTER,
+	PM_RADIX_PWC_L3_HIT,
+	PM_RUN_CYC_SMT2_MODE,
+	PM_TM_TX_PASS_RUN_INST,
+	PM_DISP_HELD_SYNC_HOLD,
+};
+
 /* Table of alternatives, sorted by column 0 */
 static const unsigned int power9_event_alternatives[][MAX_ALT] = {
 	{ PM_INST_DISP,			PM_INST_DISP_ALT },
@@ -446,12 +463,21 @@ static struct power_pmu power9_pmu = {
 static int __init init_power9_pmu(void)
 {
 	int rc = 0;
+	unsigned int pvr = mfspr(SPRN_PVR);
 
 	/* Comes from cpu_specs[] */
 	if (!cur_cpu_spec->oprofile_cpu_type ||
 	    strcmp(cur_cpu_spec->oprofile_cpu_type, "ppc64/power9"))
 		return -ENODEV;
 
+	/* Blacklist events */
+	if (!(pvr & PVR_POWER9_CUMULUS)) {
+		if ((PVR_CFG(pvr) == 2) && (PVR_MIN(pvr) == 1)) {
+			power9_pmu.blacklist_ev = p9_dd21_bl_ev;
+			power9_pmu.n_blacklist_ev = ARRAY_SIZE(p9_dd21_bl_ev);
+		}
+	}
+
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
 		/*
 		 * Since PM_INST_CMPL may not provide right counts in all
-- 
2.7.4
