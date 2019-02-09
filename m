Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CBDC282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:19:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DD820855
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DD820855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xgLT3mXwzDqTC
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 05:19:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xgDv5v9SzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43xgDv3LcQz8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43xgDv1fb1z9sNg; Sun, 10 Feb 2019 05:14:39 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=pc@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43xgDt44Cxz9sNM
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2019 05:14:38 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x19IEV6S173060
 for <linuxppc-dev@ozlabs.org>; Sat, 9 Feb 2019 13:14:36 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2qhuxbt5n6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 09 Feb 2019 13:14:35 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <pc@us.ibm.com>;
 Sat, 9 Feb 2019 18:14:35 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 9 Feb 2019 18:14:33 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x19IEW3X19071170
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 Feb 2019 18:14:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12E2578060;
 Sat,  9 Feb 2019 18:14:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D602A78063;
 Sat,  9 Feb 2019 18:14:31 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat,  9 Feb 2019 18:14:31 +0000 (GMT)
From: Paul Clarke <pc@us.ibm.com>
To: linux-perf-users@vger.kernel.org
Subject: [PATCH 3/4] [powerpc] perf vendor events: Add JSON metrics for POWER9
Date: Sat,  9 Feb 2019 13:14:28 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209181429.23950-1-pc@us.ibm.com>
References: <20190209181429.23950-1-pc@us.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19020918-0020-0000-0000-00000EB96B0C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010566; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158660; UDB=6.00604582; IPR=6.00939195; 
 MB=3.00025508; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-09 18:14:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020918-0021-0000-0000-000064BD4883
Message-Id: <20190209181429.23950-4-pc@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-09_16:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902090132
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: maddy@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, naveen.n.rao@linux.vnet.ibm.com,
 sukadev@linux.ibm.com, cel@us.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Descriptions of metrics for POWER9 processors can be found in the
"POWER9 Performance Monitor Unit User’s Guide", which is currently
available on the "IBM Portal for OpenPOWER"
(https://www-355.ibm.com/systems/power/openpower/welcome.xhtml) at
https://www-355.ibm.com/systems/power/openpower/posting.xhtml?postingId=4948CDE1963C9BCA852582F800718190

This patch is for metric groups:
- branch_prediction
- instruction_stats_percent_per_ref
- latency
- lsu_rejects
- memory
- prefetch
- translation

Plus, some whitespace changes.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power9/metrics.json          | 403 +++++++++++++++++-
 1 file changed, 390 insertions(+), 13 deletions(-)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index 166f95518c45..c39a922aaf84 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -1,4 +1,39 @@
 [
+    {
+        "MetricExpr": "PM_BR_MPRED_CMPL / PM_BR_PRED * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "br_misprediction_percent"
+    },
+    {
+        "BriefDescription": "Count cache branch misprediction per instruction",
+        "MetricExpr": "PM_BR_MPRED_CCACHE / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ccache_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Count cache branch misprediction",
+        "MetricExpr": "PM_BR_MPRED_CCACHE / PM_BR_PRED_CCACHE * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "ccache_misprediction_percent"
+    },
+    {
+        "BriefDescription": "Link stack branch misprediction",
+        "MetricExpr": "PM_BR_MPRED_LSTACK / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "lstack_mispredict_rate_percent"
+    },
+    {
+        "BriefDescription": "Link stack branch misprediction",
+        "MetricExpr": "PM_BR_MPRED_LSTACK/ PM_BR_PRED_LSTACK * 100",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "lstack_misprediction_percent"
+    },
+    {
+        "BriefDescription": "% Branches Taken",
+        "MetricExpr": "PM_BR_TAKEN_CMPL * 100 / PM_BRU_FIN",
+        "MetricGroup": "branch_prediction",
+        "MetricName": "taken_branches_percent"
+    },
     {
         "BriefDescription": "Completion stall due to a Branch Unit",
         "MetricExpr": "PM_CMPLU_STALL_BRU/PM_RUN_INST_CMPL",
@@ -881,13 +916,121 @@
         "MetricName": "l1_inst_miss_rate_percent"
     },
     {
-        "BriefDescription": "%L2 Modified CO  Cache read Utilization (4 pclks per disp attempt)",
+        "BriefDescription": "Icache Fetchs per Icache Miss",
+        "MetricExpr": "(PM_L1_ICACHE_MISS - PM_IC_PREF_WRITE) / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "icache_miss_reload"
+    },
+    {
+        "BriefDescription": "% of ICache reloads due to prefetch",
+        "MetricExpr": "PM_IC_PREF_WRITE * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "icache_pref_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Modified)",
+        "MetricExpr": "PM_INST_FROM_DL2L3_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Shared)",
+        "MetricExpr": "PM_INST_FROM_DL2L3_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L4",
+        "MetricExpr": "PM_INST_FROM_DL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dl4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant Memory",
+        "MetricExpr": "PM_INST_FROM_DMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_dmem_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core",
+        "MetricExpr": "PM_INST_FROM_L21_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l21_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core",
+        "MetricExpr": "PM_INST_FROM_L21_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l21_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L2",
+        "MetricExpr": "PM_INST_FROM_L2 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l2_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3, other core",
+        "MetricExpr": "PM_INST_FROM_L31_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l31_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3, other core",
+        "MetricExpr": "PM_INST_FROM_L31_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l31_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L3",
+        "MetricExpr": "PM_INST_FROM_L3 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_l3_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local L4",
+        "MetricExpr": "PM_INST_FROM_LL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_ll4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local Memory",
+        "MetricExpr": "PM_INST_FROM_LMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_lmem_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Modified)",
+        "MetricExpr": "PM_INST_FROM_RL2L3_MOD * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Shared)",
+        "MetricExpr": "PM_INST_FROM_RL2L3_SHR * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L4",
+        "MetricExpr": "PM_INST_FROM_RL4 * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rl4_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote Memory",
+        "MetricExpr": "PM_INST_FROM_RMEM * 100 / PM_L1_ICACHE_MISS",
+        "MetricGroup": "instruction_stats_percent_per_ref",
+        "MetricName": "inst_from_rmem_percent"
+    },
+    {
+        "BriefDescription": "%L2 Modified CO Cache read Utilization (4 pclks per disp attempt)",
         "MetricExpr": "((PM_L2_CASTOUT_MOD/2)*4)/ PM_RUN_CYC * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_co_m_rd_util"
     },
     {
-        "BriefDescription": "L2  dcache invalidates per run inst  (per core)",
+        "BriefDescription": "L2 dcache invalidates per run inst (per core)",
         "MetricExpr": "(PM_L2_DC_INV / 2) / PM_RUN_INST_CMPL * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_dc_inv_rate_percent"
@@ -899,14 +1042,14 @@
         "MetricName": "l2_dem_ld_disp_percent"
     },
     {
-        "BriefDescription": "L2  Icache invalidates per run inst  (per core)",
+        "BriefDescription": "L2 Icache invalidates per run inst (per core)",
         "MetricExpr": "(PM_L2_IC_INV / 2) / PM_RUN_INST_CMPL * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_ic_inv_rate_percent"
     },
     {
-        "BriefDescription": "L2  Inst misses  as a % of total L2  Inst dispatches (per thread)",
-        "MetricExpr": "PM_L2_INST_MISS /  PM_L2_INST * 100",
+        "BriefDescription": "L2 Inst misses as a % of total L2 Inst dispatches (per thread)",
+        "MetricExpr": "PM_L2_INST_MISS / PM_L2_INST * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_inst_miss_ratio_percent"
     },
@@ -923,7 +1066,7 @@
         "MetricName": "l2_ld_miss_frequency"
     },
     {
-        "BriefDescription": "L2 Load misses  as a % of total L2 Load dispatches (per thread)",
+        "BriefDescription": "L2 Load misses as a % of total L2 Load dispatches (per thread)",
         "MetricExpr": "PM_L2_LD_MISS / PM_L2_LD * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_ld_miss_ratio_percent"
@@ -941,7 +1084,7 @@
         "MetricName": "l2_ldmiss_wr_util"
     },
     {
-        "BriefDescription": "L2  local pump prediction success",
+        "BriefDescription": "L2 local pump prediction success",
         "MetricExpr": "PM_L2_LOC_GUESS_CORRECT / (PM_L2_LOC_GUESS_CORRECT + PM_L2_LOC_GUESS_WRONG) * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_local_pred_correct_percent"
@@ -953,7 +1096,7 @@
         "MetricName": "l2_mod_co_percent"
     },
     {
-        "BriefDescription": "% of L2 Load RC dispatch atampts that failed  because of address collisions and cclass conflicts",
+        "BriefDescription": "% of L2 Load RC dispatch atampts that failed because of address collisions and cclass conflicts",
         "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR )/ PM_L2_RCLD_DISP * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_rc_ld_disp_addr_fail_percent"
@@ -965,7 +1108,7 @@
         "MetricName": "l2_rc_ld_disp_fail_percent"
     },
     {
-        "BriefDescription": "% of L2 Store RC dispatch atampts that failed  because of address collisions and cclass conflicts",
+        "BriefDescription": "% of L2 Store RC dispatch atampts that failed because of address collisions and cclass conflicts",
         "MetricExpr": "PM_L2_RCST_DISP_FAIL_ADDR / PM_L2_RCST_DISP * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_rc_st_disp_addr_fail_percent"
@@ -983,13 +1126,13 @@
         "MetricName": "l2_rd_util_percent"
     },
     {
-        "BriefDescription": "L2 COs that were in  T,Te,Si,S  state as a % of all L2 COs",
+        "BriefDescription": "L2 COs that were in T,Te,Si,S state as a % of all L2 COs",
         "MetricExpr": "PM_L2_CASTOUT_SHR / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_shr_co_percent"
     },
     {
-        "BriefDescription": "L2  Store misses  as a % of total L2  Store dispatches (per thread)",
+        "BriefDescription": "L2 Store misses as a % of total L2 Store dispatches (per thread)",
         "MetricExpr": "PM_L2_ST_MISS / PM_L2_ST * 100",
         "MetricGroup": "l2_stats",
         "MetricName": "l2_st_miss_ratio_percent"
@@ -1025,13 +1168,205 @@
         "MetricName": "l3_ld_miss_frequency"
     },
     {
-        "BriefDescription": "Average number of Write-in machines used.  1 of 8 WI machines is sampled every L3 cycle",
+        "BriefDescription": "Average number of Write-in machines used. 1 of 8 WI machines is sampled every L3 cycle",
         "MetricExpr": "(PM_L3_WI_USAGE / PM_RUN_CYC) * 8",
         "MetricGroup": "l3_stats",
         "MetricName": "l3_wi_usage"
     },
     {
-        "BriefDescription": "DERAT Miss Rate (per run  instruction)(%)",
+        "BriefDescription": "Average icache miss latency",
+        "MetricExpr": "PM_IC_DEMAND_CYC / PM_IC_DEMAND_REQ",
+        "MetricGroup": "latency",
+        "MetricName": "average_il1_miss_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL2L3_MOD_CYC/ PM_MRK_DATA_FROM_DL2L3_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "dl2l3_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 distant Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL2L3_SHR_CYC/ PM_MRK_DATA_FROM_DL2L3_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "dl2l3_shr_latency"
+    },
+    {
+        "BriefDescription": "Distant L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DL4_CYC/ PM_MRK_DATA_FROM_DL4",
+        "MetricGroup": "latency",
+        "MetricName": "dl4_latency"
+    },
+    {
+        "BriefDescription": "Marked Dmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_DMEM_CYC/ PM_MRK_DATA_FROM_DMEM",
+        "MetricGroup": "latency",
+        "MetricName": "dmem_latency"
+    },
+    {
+        "BriefDescription": "average L1 miss latency using marked events",
+        "MetricExpr": "PM_MRK_LD_MISS_L1_CYC / PM_MRK_LD_MISS_L1",
+        "MetricGroup": "latency",
+        "MetricName": "estimated_dl1miss_latency"
+    },
+    {
+        "BriefDescription": "Marked L21 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L21_MOD_CYC/ PM_MRK_DATA_FROM_L21_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "l21_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L21 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L21_SHR_CYC/ PM_MRK_DATA_FROM_L21_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "l21_shr_latency"
+    },
+    {
+        "BriefDescription": "Marked L2 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L2_CYC/ PM_MRK_DATA_FROM_L2",
+        "MetricGroup": "latency",
+        "MetricName": "l2_latency"
+    },
+    {
+        "BriefDescription": "Marked L31 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L31_MOD_CYC/ PM_MRK_DATA_FROM_L31_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "l31_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L31 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L31_SHR_CYC/ PM_MRK_DATA_FROM_L31_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "l31_shr_latency"
+    },
+    {
+        "BriefDescription": "Marked L3 Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_L3_CYC/ PM_MRK_DATA_FROM_L3",
+        "MetricGroup": "latency",
+        "MetricName": "l3_latency"
+    },
+    {
+        "BriefDescription": "Local L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_LL4_CYC/ PM_MRK_DATA_FROM_LL4",
+        "MetricGroup": "latency",
+        "MetricName": "ll4_latency"
+    },
+    {
+        "BriefDescription": "Marked Lmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_LMEM_CYC/ PM_MRK_DATA_FROM_LMEM",
+        "MetricGroup": "latency",
+        "MetricName": "lmem_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL2L3_MOD_CYC/ PM_MRK_DATA_FROM_RL2L3_MOD",
+        "MetricGroup": "latency",
+        "MetricName": "rl2l3_mod_latency"
+    },
+    {
+        "BriefDescription": "Marked L2L3 remote Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL2L3_SHR_CYC/ PM_MRK_DATA_FROM_RL2L3_SHR",
+        "MetricGroup": "latency",
+        "MetricName": "rl2l3_shr_latency"
+    },
+    {
+        "BriefDescription": "Remote L4 average load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RL4_CYC/ PM_MRK_DATA_FROM_RL4",
+        "MetricGroup": "latency",
+        "MetricName": "rl4_latency"
+    },
+    {
+        "BriefDescription": "Marked Rmem Load latency",
+        "MetricExpr": "PM_MRK_DATA_FROM_RMEM_CYC/ PM_MRK_DATA_FROM_RMEM",
+        "MetricGroup": "latency",
+        "MetricName": "rmem_latency"
+    },
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_ERAT_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "erat_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "LHS reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LHS *100/ PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lhs_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LMQ_FULL * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lmq_full_reject_rate_percent"
+    },
+    {
+        "BriefDescription": "ERAT miss reject ratio",
+        "MetricExpr": "PM_LSU_REJECT_LMQ_FULL * 100 / PM_LD_REF_L1",
+        "MetricGroup": "lsu_rejects",
+        "MetricName": "lmq_full_reject_ratio_percent"
+    },
+    {
+        "BriefDescription": "L4 locality(%)",
+        "MetricExpr": "PM_DATA_FROM_LL4 * 100 / (PM_DATA_FROM_LL4 + PM_DATA_FROM_RL4 + PM_DATA_FROM_DL4)",
+        "MetricGroup": "memory",
+        "MetricName": "l4_locality"
+    },
+    {
+        "BriefDescription": "Ratio of reloads from local L4 to distant L4",
+        "MetricExpr": "PM_DATA_FROM_LL4 / PM_DATA_FROM_DL4",
+        "MetricGroup": "memory",
+        "MetricName": "ld_ll4_per_ld_dmem"
+    },
+    {
+        "BriefDescription": "Ratio of reloads from local L4 to remote+distant L4",
+        "MetricExpr": "PM_DATA_FROM_LL4 / (PM_DATA_FROM_DL4 + PM_DATA_FROM_RL4)",
+        "MetricGroup": "memory",
+        "MetricName": "ld_ll4_per_ld_mem"
+    },
+    {
+        "BriefDescription": "Ratio of reloads from local L4 to remote L4",
+        "MetricExpr": "PM_DATA_FROM_LL4 / PM_DATA_FROM_RL4",
+        "MetricGroup": "memory",
+        "MetricName": "ld_ll4_per_ld_rl4"
+    },
+    {
+        "BriefDescription": "Number of loads from local memory per loads from distant memory",
+        "MetricExpr": "PM_DATA_FROM_LMEM / PM_DATA_FROM_DMEM",
+        "MetricGroup": "memory",
+        "MetricName": "ld_lmem_per_ld_dmem"
+    },
+    {
+        "BriefDescription": "Number of loads from local memory per loads from remote and distant memory",
+        "MetricExpr": "PM_DATA_FROM_LMEM / (PM_DATA_FROM_DMEM + PM_DATA_FROM_RMEM)",
+        "MetricGroup": "memory",
+        "MetricName": "ld_lmem_per_ld_mem"
+    },
+    {
+        "BriefDescription": "Number of loads from local memory per loads from remote memory",
+        "MetricExpr": "PM_DATA_FROM_LMEM / PM_DATA_FROM_RMEM",
+        "MetricGroup": "memory",
+        "MetricName": "ld_lmem_per_ld_rmem"
+    },
+    {
+        "BriefDescription": "Number of loads from remote memory per loads from distant memory",
+        "MetricExpr": "PM_DATA_FROM_RMEM / PM_DATA_FROM_DMEM",
+        "MetricGroup": "memory",
+        "MetricName": "ld_rmem_per_ld_dmem"
+    },
+    {
+        "BriefDescription": "Memory locality",
+        "MetricExpr": "PM_DATA_FROM_LMEM * 100/ (PM_DATA_FROM_LMEM + PM_DATA_FROM_RMEM + PM_DATA_FROM_DMEM)",
+        "MetricGroup": "memory",
+        "MetricName": "mem_locality_percent"
+    },
+    {
+        "BriefDescription": "L1 Prefetches issued by the prefetch machine per instruction (per thread)",
+        "MetricExpr": "PM_L1_PREF / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "prefetch",
+        "MetricName": "l1_prefetch_rate_percent"
+    },
+    {
+        "BriefDescription": "DERAT Miss Rate (per run instruction)(%)",
         "MetricExpr": "PM_LSU_DERAT_MISS * 100 / PM_RUN_INST_CMPL",
         "MetricGroup": "pteg_reloads_percent_per_inst",
         "MetricName": "derat_miss_rate_percent"
@@ -1233,5 +1568,47 @@
         "MetricExpr": "PM_DPTEG_FROM_RMEM * 100 / PM_DTLB_MISS",
         "MetricGroup": "pteg_reloads_percent_per_ref",
         "MetricName": "pteg_from_rmem_percent"
+    },
+    {
+        "BriefDescription": "% DERAT miss rate for 4K page per inst",
+        "MetricExpr": "PM_DERAT_MISS_4K * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "derat_4k_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "DERAT miss ratio for 4K page",
+        "MetricExpr": "PM_DERAT_MISS_4K / PM_LSU_DERAT_MISS",
+        "MetricGroup": "translation",
+        "MetricName": "derat_4k_miss_ratio"
+    },
+    {
+        "BriefDescription": "% DERAT miss ratio for 64K page per inst",
+        "MetricExpr": "PM_DERAT_MISS_64K * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "derat_64k_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "DERAT miss ratio for 64K page",
+        "MetricExpr": "PM_DERAT_MISS_64K / PM_LSU_DERAT_MISS",
+        "MetricGroup": "translation",
+        "MetricName": "derat_64k_miss_ratio"
+    },
+    {
+        "BriefDescription": "DERAT miss ratio",
+        "MetricExpr": "PM_LSU_DERAT_MISS / PM_LSU_DERAT_MISS",
+        "MetricGroup": "translation",
+        "MetricName": "derat_miss_ratio"
+    },
+    {
+        "BriefDescription": "% DSLB_Miss_Rate per inst",
+        "MetricExpr": "PM_DSLB_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "dslb_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% ISLB miss rate per inst",
+        "MetricExpr": "PM_ISLB_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "translation",
+        "MetricName": "islb_miss_rate_percent"
     }
 ]
-- 
2.17.1

