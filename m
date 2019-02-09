Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39DDC282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:22:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C4B20855
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C4B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xgPx42JczDq6j
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 05:22:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xgDx11j4zDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43xgDw5SwCz8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:40 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43xgDw4NgWz9sNM; Sun, 10 Feb 2019 05:14:40 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=us.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=pc@us.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43xgDw05mMz9sNg
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2019 05:14:39 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x19IDh0H107081
 for <linuxppc-dev@ozlabs.org>; Sat, 9 Feb 2019 13:14:38 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qht38xb6m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 09 Feb 2019 13:14:38 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <pc@us.ibm.com>;
 Sat, 9 Feb 2019 18:14:37 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e31.co.us.ibm.com (192.168.1.131) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 9 Feb 2019 18:14:33 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x19IEW6P19071178
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 Feb 2019 18:14:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B04807805E;
 Sat,  9 Feb 2019 18:14:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7C1877805C;
 Sat,  9 Feb 2019 18:14:32 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat,  9 Feb 2019 18:14:32 +0000 (GMT)
From: Paul Clarke <pc@us.ibm.com>
To: linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] [powerpc] perf vendor events: Add JSON metrics for POWER9
Date: Sat,  9 Feb 2019 13:14:29 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209181429.23950-1-pc@us.ibm.com>
References: <20190209181429.23950-1-pc@us.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19020918-8235-0000-0000-00000E59136C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010566; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158660; UDB=6.00604582; IPR=6.00939195; 
 MB=3.00025508; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-09 18:14:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020918-8236-0000-0000-000044677F9F
Message-Id: <20190209181429.23950-5-pc@us.ibm.com>
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
- general

and other metrics not in a metric group.

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power9/metrics.json          | 368 ++++++++++++++++++
 1 file changed, 368 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index c39a922aaf84..811c2a8c1c9e 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -813,6 +813,114 @@
         "MetricGroup": "estimated_dcache_miss_cpi",
         "MetricName": "rmem_cpi_percent"
     },
+    {
+        "BriefDescription": "Branch Mispredict flushes per instruction",
+        "MetricExpr": "PM_FLUSH_MPRED / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "general",
+        "MetricName": "br_mpred_flush_rate_percent"
+    },
+    {
+        "BriefDescription": "Cycles per instruction",
+        "MetricExpr": "PM_CYC / PM_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "cpi"
+    },
+    {
+        "BriefDescription": "GCT empty cycles",
+        "MetricExpr": "(PM_FLUSH_DISP / PM_RUN_INST_CMPL) * 100",
+        "MetricGroup": "general",
+        "MetricName": "disp_flush_rate_percent"
+    },
+    {
+        "BriefDescription": "% DTLB miss rate per inst",
+        "MetricExpr": "PM_DTLB_MISS / PM_RUN_INST_CMPL *100",
+        "MetricGroup": "general",
+        "MetricName": "dtlb_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Flush rate (%)",
+        "MetricExpr": "PM_FLUSH * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "flush_rate_percent"
+    },
+    {
+        "BriefDescription": "Instructions per cycles",
+        "MetricExpr": "PM_INST_CMPL / PM_CYC",
+        "MetricGroup": "general",
+        "MetricName": "ipc"
+    },
+    {
+        "BriefDescription": "% ITLB miss rate per inst",
+        "MetricExpr": "PM_ITLB_MISS / PM_RUN_INST_CMPL *100",
+        "MetricGroup": "general",
+        "MetricName": "itlb_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L1 load misses per L1 load ref",
+        "MetricExpr": "PM_LD_MISS_L1 / PM_LD_REF_L1 * 100",
+        "MetricGroup": "general",
+        "MetricName": "l1_ld_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L1 store misses per run instruction",
+        "MetricExpr": "PM_ST_MISS_L1 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l1_st_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L1 store misses per L1 store ref",
+        "MetricExpr": "PM_ST_MISS_L1 / PM_ST_FIN * 100",
+        "MetricGroup": "general",
+        "MetricName": "l1_st_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "L2 Instruction Miss Rate (per instruction)(%)",
+        "MetricExpr": "PM_INST_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l2_inst_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L2 dmand Load Miss Rate (per run instruction)(%)",
+        "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l2_ld_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L2 PTEG Miss Rate (per run instruction)(%)",
+        "MetricExpr": "PM_DPTEG_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l2_pteg_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L3 Instruction Miss Rate (per instruction)(%)",
+        "MetricExpr": "PM_INST_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l3_inst_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L3 demand Load Miss Rate (per run instruction)(%)",
+        "MetricExpr": "PM_DATA_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l3_ld_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "L3 PTEG Miss Rate (per run instruction)(%)",
+        "MetricExpr": "PM_DPTEG_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "l3_pteg_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "Run cycles per cycle",
+        "MetricExpr": "PM_RUN_CYC / PM_CYC*100",
+        "MetricGroup": "general",
+        "MetricName": "run_cycles_percent"
+    },
+    {
+        "BriefDescription": "Instruction dispatch-to-completion ratio",
+        "MetricExpr": "PM_INST_DISP / PM_INST_CMPL",
+        "MetricGroup": "general",
+        "MetricName": "speculation"
+    },
     {
         "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Modified) per Inst",
         "MetricExpr": "PM_INST_FROM_DL2L3_MOD * 100 / PM_RUN_INST_CMPL",
@@ -1610,5 +1718,265 @@
         "MetricExpr": "PM_ISLB_MISS * 100 / PM_RUN_INST_CMPL",
         "MetricGroup": "translation",
         "MetricName": "islb_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "ANY_SYNC_STALL_CPI",
+        "MetricExpr": "PM_CMPLU_STALL_ANY_SYNC / PM_RUN_INST_CMPL",
+        "MetricName": "any_sync_stall_cpi"
+    },
+    {
+        "BriefDescription": "Avg. more than 1 instructions completed",
+        "MetricExpr": "PM_INST_CMPL / PM_1PLUS_PPC_CMPL",
+        "MetricName": "average_completed_instruction_set_size"
+    },
+    {
+        "BriefDescription": "% Branches per instruction",
+        "MetricExpr": "PM_BRU_FIN / PM_RUN_INST_CMPL",
+        "MetricName": "branches_per_inst"
+    },
+    {
+        "BriefDescription": "Cycles in which at least one instruction completes in this thread",
+        "MetricExpr": "PM_1PLUS_PPC_CMPL/PM_RUN_INST_CMPL",
+        "MetricName": "completion_cpi"
+    },
+    {
+        "BriefDescription": "cycles",
+        "MetricExpr": "PM_RUN_CYC",
+        "MetricName": "custom_secs"
+    },
+    {
+        "BriefDescription": "Percentage Cycles atleast one instruction dispatched",
+        "MetricExpr": "PM_1PLUS_PPC_DISP / PM_CYC * 100",
+        "MetricName": "cycles_atleast_one_inst_dispatched_percent"
+    },
+    {
+        "BriefDescription": "Cycles per instruction group",
+        "MetricExpr": "PM_CYC / PM_1PLUS_PPC_CMPL",
+        "MetricName": "cycles_per_completed_instructions_set"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Distant L4",
+        "MetricExpr": "PM_DATA_FROM_DL4 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricName": "dl1_reload_from_dl4_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Distant L4 per Inst",
+        "MetricExpr": "PM_DATA_FROM_DL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dl1_reload_from_dl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core per Inst",
+        "MetricExpr": "(PM_DATA_FROM_L31_MOD + PM_DATA_FROM_L31_SHR) * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dl1_reload_from_l31_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Local L4",
+        "MetricExpr": "PM_DATA_FROM_LL4 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricName": "dl1_reload_from_ll4_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Local L4 per Inst",
+        "MetricExpr": "PM_DATA_FROM_LL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dl1_reload_from_ll4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote L4",
+        "MetricExpr": "PM_DATA_FROM_RL4 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricName": "dl1_reload_from_rl4_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Remote Memory per Inst",
+        "MetricExpr": "PM_DATA_FROM_RL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dl1_reload_from_rl4_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of DERAT reloads from L2",
+        "MetricExpr": "PM_DPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dpteg_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of DERAT reloads from L3",
+        "MetricExpr": "PM_DPTEG_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "dpteg_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "Cycles in which the oldest instruction is finished and ready to complete for waiting to get through the completion pipe",
+        "MetricExpr": "PM_NTC_ALL_FIN / PM_RUN_INST_CMPL",
+        "MetricName": "finish_to_cmpl_cpi"
+    },
+    {
+        "BriefDescription": "Total Fixed point operations",
+        "MetricExpr": "PM_FXU_FIN/PM_RUN_INST_CMPL",
+        "MetricName": "fixed_per_inst"
+    },
+    {
+        "BriefDescription": "All FXU Busy",
+        "MetricExpr": "PM_FXU_BUSY / PM_CYC",
+        "MetricName": "fxu_all_busy"
+    },
+    {
+        "BriefDescription": "All FXU Idle",
+        "MetricExpr": "PM_FXU_IDLE / PM_CYC",
+        "MetricName": "fxu_all_idle"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to branch mispred",
+        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_br_mpred_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to Icache Miss and branch mispred",
+        "MetricExpr": "PM_ICT_NOSLOT_BR_MPRED_ICMISS/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_br_mpred_icmiss_cpi"
+    },
+    {
+        "BriefDescription": "ICT other stalls",
+        "MetricExpr": "(PM_ICT_NOSLOT_CYC - PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_BR_MPRED_ICMISS - PM_ICT_NOSLOT_BR_MPRED - PM_ICT_NOSLOT_DISP_HELD)/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_cyc_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles in which the NTC instruciton is held at dispatch for any reason",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_disp_held_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to dispatch holds because the History Buffer was full. Could be GPR/VSR/VMR/FPR/CR/XVF",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_HB_FULL/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_disp_held_hb_full_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to dispatch hold on this thread due to Issue q full, BRQ full, XVCF Full, Count cache, Link, Tar full",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_ISSQ/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_disp_held_issq_cpi"
+    },
+    {
+        "BriefDescription": "ICT_NOSLOT_DISP_HELD_OTHER_CPI",
+        "MetricExpr": "(PM_ICT_NOSLOT_DISP_HELD - PM_ICT_NOSLOT_DISP_HELD_HB_FULL - PM_ICT_NOSLOT_DISP_HELD_SYNC - PM_ICT_NOSLOT_DISP_HELD_TBEGIN - PM_ICT_NOSLOT_DISP_HELD_ISSQ)/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_disp_held_other_cpi"
+    },
+    {
+        "BriefDescription": "Dispatch held due to a synchronizing instruction at dispatch",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_SYNC/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_disp_held_sync_cpi"
+    },
+    {
+        "BriefDescription": "the NTC instruction is being held at dispatch because it is a tbegin instruction and there is an older tbegin in the pipeline that must complete before the younger tbegin can dispatch",
+        "MetricExpr": "PM_ICT_NOSLOT_DISP_HELD_TBEGIN/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_disp_held_tbegin_cpi"
+    },
+    {
+        "BriefDescription": "ICT_NOSLOT_IC_L2_CPI",
+        "MetricExpr": "(PM_ICT_NOSLOT_IC_MISS - PM_ICT_NOSLOT_IC_L3 - PM_ICT_NOSLOT_IC_L3MISS)/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_ic_l2_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from the local L3",
+        "MetricExpr": "PM_ICT_NOSLOT_IC_L3/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_ic_l3_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to icache misses that were sourced from beyond the local L3. The source could be local/remote/distant memory or another core's cache",
+        "MetricExpr": "PM_ICT_NOSLOT_IC_L3MISS/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_ic_l3miss_cpi"
+    },
+    {
+        "BriefDescription": "Ict empty for this thread due to Icache Miss",
+        "MetricExpr": "PM_ICT_NOSLOT_IC_MISS/PM_RUN_INST_CMPL",
+        "MetricName": "ict_noslot_ic_miss_cpi"
+    },
+    {
+        "BriefDescription": "Rate of IERAT reloads from L2",
+        "MetricExpr": "PM_IPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "ipteg_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of IERAT reloads from L3",
+        "MetricExpr": "PM_IPTEG_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "ipteg_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of IERAT reloads from local memory",
+        "MetricExpr": "PM_IPTEG_FROM_LL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "ipteg_from_ll4_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of IERAT reloads from local memory",
+        "MetricExpr": "PM_IPTEG_FROM_LMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricName": "ipteg_from_lmem_rate_percent"
+    },
+    {
+        "BriefDescription": "Average number of Castout machines used. 1 of 16 CO machines is sampled every L2 cycle",
+        "MetricExpr": "PM_CO_USAGE / PM_RUN_CYC * 16",
+        "MetricName": "l2_co_usage"
+    },
+    {
+        "BriefDescription": "Percent of instruction reads out of all L2 commands",
+        "MetricExpr": "PM_ISIDE_DISP * 100 / (PM_L2_ST + PM_L2_LD + PM_ISIDE_DISP)",
+        "MetricName": "l2_instr_commands_percent"
+    },
+    {
+        "BriefDescription": "Percent of loads out of all L2 commands",
+        "MetricExpr": "PM_L2_LD * 100 / (PM_L2_ST + PM_L2_LD + PM_ISIDE_DISP)",
+        "MetricName": "l2_ld_commands_percent"
+    },
+    {
+        "BriefDescription": "Rate of L2 store dispatches that failed per core",
+        "MetricExpr": "100 * (PM_L2_RCST_DISP_FAIL_ADDR + PM_L2_RCST_DISP_FAIL_OTHER)/2 / PM_RUN_INST_CMPL",
+        "MetricName": "l2_rc_st_disp_fail_rate_percent"
+    },
+    {
+        "BriefDescription": "Average number of Read/Claim machines used. 1 of 16 RC machines is sampled every L2 cycle",
+        "MetricExpr": "PM_RC_USAGE / PM_RUN_CYC * 16",
+        "MetricName": "l2_rc_usage"
+    },
+    {
+        "BriefDescription": "Average number of Snoop machines used. 1 of 8 SN machines is sampled every L2 cycle",
+        "MetricExpr": "PM_SN_USAGE / PM_RUN_CYC * 8",
+        "MetricName": "l2_sn_usage"
+    },
+    {
+        "BriefDescription": "Percent of stores out of all L2 commands",
+        "MetricExpr": "PM_L2_ST * 100 / (PM_L2_ST + PM_L2_LD + PM_ISIDE_DISP)",
+        "MetricName": "l2_st_commands_percent"
+    },
+    {
+        "BriefDescription": "Rate of L2 store dispatches that failed per core",
+        "MetricExpr": "100 * (PM_L2_RCST_DISP_FAIL_ADDR + PM_L2_RCST_DISP_FAIL_OTHER)/2 / PM_RUN_INST_CMPL",
+        "MetricName": "l2_st_disp_fail_rate_percent"
+    },
+    {
+        "BriefDescription": "Rate of L2 dispatches per core",
+        "MetricExpr": "100 * PM_L2_RCST_DISP/2 / PM_RUN_INST_CMPL",
+        "MetricName": "l2_st_disp_rate_percent"
+    },
+    {
+        "BriefDescription": "Marked L31 Load latency",
+        "MetricExpr": "(PM_MRK_DATA_FROM_L31_SHR_CYC + PM_MRK_DATA_FROM_L31_MOD_CYC) / (PM_MRK_DATA_FROM_L31_SHR + PM_MRK_DATA_FROM_L31_MOD)",
+        "MetricName": "l31_latency"
+    },
+    {
+        "BriefDescription": "PCT instruction loads",
+        "MetricExpr": "PM_LD_REF_L1 / PM_RUN_INST_CMPL",
+        "MetricName": "loads_per_inst"
+    },
+    {
+        "BriefDescription": "Cycles stalled by D-Cache Misses",
+        "MetricExpr": "PM_CMPLU_STALL_DCACHE_MISS / PM_RUN_INST_CMPL",
+        "MetricName": "lsu_stall_dcache_miss_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall because a different thread was using the completion pipe",
+        "MetricExpr": "(PM_CMPLU_STALL_THRD - PM_CMPLU_STALL_EXCEPTION - PM_CMPLU_STALL_ANY_SYNC - PM_CMPLU_STALL_SYNC_PMU_INT - PM_CMPLU_STALL_SPEC_FINISH - PM_CMPLU_STALL_FLUSH_ANY_THREAD - PM_CMPLU_STALL_LSU_FLUSH_NEXT - PM_CMPLU_STALL_NESTED_TBEGIN - PM_CMPLU_STALL_NESTED_TEND - PM_CMPLU_STALL_MTFPSCR)/PM_RUN_INST_CMPL",
+        "MetricName": "other_thread_cmpl_stall"
+    },
+    {
+        "BriefDescription": "PCT instruction stores",
+        "MetricExpr": "PM_ST_FIN / PM_RUN_INST_CMPL",
+        "MetricName": "stores_per_inst"
+    },
+    {
+        "BriefDescription": "ANY_SYNC_STALL_CPI",
+        "MetricExpr": "PM_CMPLU_STALL_SYNC_PMU_INT / PM_RUN_INST_CMPL",
+        "MetricName": "sync_pmu_int_stall_cpi"
     }
 ]
-- 
2.17.1

