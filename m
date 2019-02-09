Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337D4C282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:21:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D2420855
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D2420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xgNG3V2wzDqTd
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 05:21:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xgDw2dwbzDqSn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43xgDw0Y90z8wMv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:40 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43xgDv6R06z9sNM; Sun, 10 Feb 2019 05:14:39 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43xgDt6x94z9sML
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2019 05:14:38 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x19IE4ut131278
 for <linuxppc-dev@ozlabs.org>; Sat, 9 Feb 2019 13:14:36 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qhur7tur1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 09 Feb 2019 13:14:36 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <pc@us.ibm.com>;
 Sat, 9 Feb 2019 18:14:35 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 9 Feb 2019 18:14:33 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x19IEV9Y22413350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 Feb 2019 18:14:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F9B67805F;
 Sat,  9 Feb 2019 18:14:31 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4DEFA78063;
 Sat,  9 Feb 2019 18:14:31 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat,  9 Feb 2019 18:14:31 +0000 (GMT)
From: Paul Clarke <pc@us.ibm.com>
To: linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] [powerpc] perf vendor events: Add JSON metrics for POWER9
Date: Sat,  9 Feb 2019 13:14:27 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209181429.23950-1-pc@us.ibm.com>
References: <20190209181429.23950-1-pc@us.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19020918-0036-0000-0000-00000A894F64
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010566; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158660; UDB=6.00604582; IPR=6.00939195; 
 MB=3.00025508; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-09 18:14:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020918-0037-0000-0000-00004AAAC996
Message-Id: <20190209181429.23950-3-pc@us.ibm.com>
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
- dl1_reloads_percent_per_inst
- dl1_reloads_percent_per_ref
- instruction_misses_percent_per_inst
- l2_stats
- l3_stats
- pteg_reloads_percent_per_inst
- pteg_reloads_percent_per_ref

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power9/metrics.json          | 660 ++++++++++++++++++
 1 file changed, 660 insertions(+)

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
index cd46ebb8da6a..166f95518c45 100644
--- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -484,6 +484,210 @@
         "MetricGroup": "cpi_breakdown",
         "MetricName": "vfxu_stall_cpi"
     },
+    {
+        "BriefDescription": "% of DL1 Reloads from Distant L2 or L3 (Modified) per Inst",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_dl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Distant L2 or L3 (Shared) per Inst",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_dl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Distant Memory per Inst",
+        "MetricExpr": "PM_DATA_FROM_DMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_dmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L2, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_L21_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l21_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L2, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_L21_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l21_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L2 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l2_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L2 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3 M state, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_L31_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l31_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3 S tate, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_L31_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l31_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads that came from the L3 and were brought into the L3 by a prefetch, per instruction completed",
+        "MetricExpr": "PM_DATA_FROM_L3_MEPF * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_mepf_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L3 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L3MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from L3 per Inst",
+        "MetricExpr": "PM_DATA_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Local Memory per Inst",
+        "MetricExpr": "PM_DATA_FROM_LMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_lmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_rl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core per Inst",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_rl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from Remote Memory per Inst",
+        "MetricExpr": "PM_DATA_FROM_RMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "dl1_reload_from_rmem_rate_percent"
+    },
+    {
+        "BriefDescription": "Percentage of L1 demand load misses per run instruction",
+        "MetricExpr": "PM_LD_MISS_L1 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "dl1_reloads_percent_per_inst",
+        "MetricName": "l1_ld_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 misses that result in a cache reload",
+        "MetricExpr": "PM_L1_DCACHE_RELOAD_VALID * 100 / PM_LD_MISS_L1",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_miss_reloads_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Distant L2 or L3 (Modified)",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_MOD * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_dl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Distant L2 or L3 (Shared)",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_SHR * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_dl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Distant Memory",
+        "MetricExpr": "PM_DATA_FROM_DMEM * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_dmem_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L2, other core",
+        "MetricExpr": "PM_DATA_FROM_L21_MOD * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l21_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L2, other core",
+        "MetricExpr": "PM_DATA_FROM_L21_SHR * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l21_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from sources beyond the local L2",
+        "MetricExpr": "PM_DATA_FROM_L2MISS * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l2_miss_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from L2",
+        "MetricExpr": "PM_DATA_FROM_L2 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l2_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core",
+        "MetricExpr": "PM_DATA_FROM_L31_MOD * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l31_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 reloads from Private L3, other core",
+        "MetricExpr": "PM_DATA_FROM_L31_SHR * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l31_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads that came from L3 and were brought into the L3 by a prefetch",
+        "MetricExpr": "PM_DATA_FROM_L3_MEPF * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_mepf_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from sources beyond the local L3",
+        "MetricExpr": "PM_DATA_FROM_L3MISS * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_miss_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 Reloads from L3",
+        "MetricExpr": "PM_DATA_FROM_L3 * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_l3_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Local Memory",
+        "MetricExpr": "PM_DATA_FROM_LMEM * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_lmem_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote L2 or L3 (Modified)",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_MOD * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_rl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote L2 or L3 (Shared)",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_SHR * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_rl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DL1 dL1_Reloads from Remote Memory",
+        "MetricExpr": "PM_DATA_FROM_RMEM * 100 / PM_L1_DCACHE_RELOAD_VALID",
+        "MetricGroup": "dl1_reloads_percent_per_ref",
+        "MetricName": "dl1_reload_from_rmem_percent"
+    },
     {
         "BriefDescription": "estimate of dl2l3 distant MOD miss rates with measured DL2L3 MOD latency as a %of dcache miss cpi",
         "MetricExpr": "PM_DATA_FROM_DL2L3_MOD * PM_MRK_DATA_FROM_DL2L3_MOD_CYC / PM_MRK_DATA_FROM_DL2L3_MOD / PM_CMPLU_STALL_DCACHE_MISS *100",
@@ -573,5 +777,461 @@
         "MetricExpr": "PM_DATA_FROM_RMEM * PM_MRK_DATA_FROM_RMEM_CYC / PM_MRK_DATA_FROM_RMEM / PM_CMPLU_STALL_DCACHE_MISS *100",
         "MetricGroup": "estimated_dcache_miss_cpi",
         "MetricName": "rmem_cpi_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Modified) per Inst",
+        "MetricExpr": "PM_INST_FROM_DL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_dl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L2 or L3 (Shared) per Inst",
+        "MetricExpr": "PM_INST_FROM_DL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_dl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant L4 per Inst",
+        "MetricExpr": "PM_INST_FROM_DL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_dl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Distant Memory per Inst",
+        "MetricExpr": "PM_INST_FROM_DMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_dmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core per Inst",
+        "MetricExpr": "PM_INST_FROM_L21_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l21_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L2, other core per Inst",
+        "MetricExpr": "PM_INST_FROM_L21_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l21_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L2 per Inst",
+        "MetricExpr": "PM_INST_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3, other core per Inst",
+        "MetricExpr": "PM_INST_FROM_L31_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l31_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Private L3 other core per Inst",
+        "MetricExpr": "PM_INST_FROM_L31_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l31_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from L3 per Inst",
+        "MetricExpr": "PM_INST_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local L4 per Inst",
+        "MetricExpr": "PM_INST_FROM_LL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_ll4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Local Memory per Inst",
+        "MetricExpr": "PM_INST_FROM_LMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_lmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Modified) per Inst",
+        "MetricExpr": "PM_INST_FROM_RL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_rl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L2 or L3 (Shared) per Inst",
+        "MetricExpr": "PM_INST_FROM_RL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_rl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote L4 per Inst",
+        "MetricExpr": "PM_INST_FROM_RL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_rl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of ICache reloads from Remote Memory per Inst",
+        "MetricExpr": "PM_INST_FROM_RMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "inst_from_rmem_rate_percent"
+    },
+    {
+        "BriefDescription": "Instruction Cache Miss Rate (Per run Instruction)(%)",
+        "MetricExpr": "PM_L1_ICACHE_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "instruction_misses_percent_per_inst",
+        "MetricName": "l1_inst_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "%L2 Modified CO  Cache read Utilization (4 pclks per disp attempt)",
+        "MetricExpr": "((PM_L2_CASTOUT_MOD/2)*4)/ PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_co_m_rd_util"
+    },
+    {
+        "BriefDescription": "L2  dcache invalidates per run inst  (per core)",
+        "MetricExpr": "(PM_L2_DC_INV / 2) / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_dc_inv_rate_percent"
+    },
+    {
+        "BriefDescription": "Demand load misses as a % of L2 LD dispatches (per thread)",
+        "MetricExpr": "PM_L1_DCACHE_RELOAD_VALID / (PM_L2_LD / 2) * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_dem_ld_disp_percent"
+    },
+    {
+        "BriefDescription": "L2  Icache invalidates per run inst  (per core)",
+        "MetricExpr": "(PM_L2_IC_INV / 2) / PM_RUN_INST_CMPL * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ic_inv_rate_percent"
+    },
+    {
+        "BriefDescription": "L2  Inst misses  as a % of total L2  Inst dispatches (per thread)",
+        "MetricExpr": "PM_L2_INST_MISS /  PM_L2_INST * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_inst_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "Average number of cycles between L2 Load hits",
+        "MetricExpr": "(PM_L2_LD_HIT / PM_RUN_CYC) / 2",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ld_hit_frequency"
+    },
+    {
+        "BriefDescription": "Average number of cycles between L2 Load misses",
+        "MetricExpr": "(PM_L2_LD_MISS / PM_RUN_CYC) / 2",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ld_miss_frequency"
+    },
+    {
+        "BriefDescription": "L2 Load misses  as a % of total L2 Load dispatches (per thread)",
+        "MetricExpr": "PM_L2_LD_MISS / PM_L2_LD * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ld_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "% L2 load disp attempts Cache read Utilization (4 pclks per disp attempt)",
+        "MetricExpr": "((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ld_rd_util"
+    },
+    {
+        "BriefDescription": "L2 load misses that require a cache write (4 pclks per disp attempt) % of pclks",
+        "MetricExpr": "((( PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4)/ PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_ldmiss_wr_util"
+    },
+    {
+        "BriefDescription": "L2  local pump prediction success",
+        "MetricExpr": "PM_L2_LOC_GUESS_CORRECT / (PM_L2_LOC_GUESS_CORRECT + PM_L2_LOC_GUESS_WRONG) * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_local_pred_correct_percent"
+    },
+    {
+        "BriefDescription": "L2 COs that were in M,Me,Mu state as a % of all L2 COs",
+        "MetricExpr": "PM_L2_CASTOUT_MOD / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_mod_co_percent"
+    },
+    {
+        "BriefDescription": "% of L2 Load RC dispatch atampts that failed  because of address collisions and cclass conflicts",
+        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR )/ PM_L2_RCLD_DISP * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rc_ld_disp_addr_fail_percent"
+    },
+    {
+        "BriefDescription": "% of L2 Load RC dispatch attempts that failed",
+        "MetricExpr": "(PM_L2_RCLD_DISP_FAIL_ADDR + PM_L2_RCLD_DISP_FAIL_OTHER)/ PM_L2_RCLD_DISP * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rc_ld_disp_fail_percent"
+    },
+    {
+        "BriefDescription": "% of L2 Store RC dispatch atampts that failed  because of address collisions and cclass conflicts",
+        "MetricExpr": "PM_L2_RCST_DISP_FAIL_ADDR / PM_L2_RCST_DISP * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rc_st_disp_addr_fail_percent"
+    },
+    {
+        "BriefDescription": "% of L2 Store RC dispatch attempts that failed",
+        "MetricExpr": "(PM_L2_RCST_DISP_FAIL_ADDR + PM_L2_RCST_DISP_FAIL_OTHER)/ PM_L2_RCST_DISP * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rc_st_disp_fail_percent"
+    },
+    {
+        "BriefDescription": "L2 Cache Read Utilization (per core)",
+        "MetricExpr": "(((PM_L2_RCLD_DISP/2)*4)/ PM_RUN_CYC * 100) + (((PM_L2_RCST_DISP/2)*4)/PM_RUN_CYC * 100) + (((PM_L2_CASTOUT_MOD/2)*4)/PM_RUN_CYC * 100)",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_rd_util_percent"
+    },
+    {
+        "BriefDescription": "L2 COs that were in  T,Te,Si,S  state as a % of all L2 COs",
+        "MetricExpr": "PM_L2_CASTOUT_SHR / (PM_L2_CASTOUT_MOD + PM_L2_CASTOUT_SHR) * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_shr_co_percent"
+    },
+    {
+        "BriefDescription": "L2  Store misses  as a % of total L2  Store dispatches (per thread)",
+        "MetricExpr": "PM_L2_ST_MISS / PM_L2_ST * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_st_miss_ratio_percent"
+    },
+    {
+        "BriefDescription": "% L2 store disp attempts Cache read Utilization (4 pclks per disp attempt)",
+        "MetricExpr": "((PM_L2_RCST_DISP/2)*4) / PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_st_rd_util"
+    },
+    {
+        "BriefDescription": "L2 stores that require a cache write (4 pclks per disp attempt) % of pclks",
+        "MetricExpr": "((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_st_wr_util"
+    },
+    {
+        "BriefDescription": "L2 Cache Write Utilization (per core)",
+        "MetricExpr": "((((PM_L2_LD_DISP - PM_L2_LD_HIT)/2)*4) / PM_RUN_CYC * 100) + (((PM_L2_ST_DISP/2)*4) / PM_RUN_CYC * 100)",
+        "MetricGroup": "l2_stats",
+        "MetricName": "l2_wr_util_percent"
+    },
+    {
+        "BriefDescription": "Average number of cycles between L3 Load hits",
+        "MetricExpr": "(PM_L3_LD_HIT / PM_RUN_CYC) / 2",
+        "MetricGroup": "l3_stats",
+        "MetricName": "l3_ld_hit_frequency"
+    },
+    {
+        "BriefDescription": "Average number of cycles between L3 Load misses",
+        "MetricExpr": "(PM_L3_LD_MISS / PM_RUN_CYC) / 2",
+        "MetricGroup": "l3_stats",
+        "MetricName": "l3_ld_miss_frequency"
+    },
+    {
+        "BriefDescription": "Average number of Write-in machines used.  1 of 8 WI machines is sampled every L3 cycle",
+        "MetricExpr": "(PM_L3_WI_USAGE / PM_RUN_CYC) * 8",
+        "MetricGroup": "l3_stats",
+        "MetricName": "l3_wi_usage"
+    },
+    {
+        "BriefDescription": "DERAT Miss Rate (per run  instruction)(%)",
+        "MetricExpr": "PM_LSU_DERAT_MISS * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "derat_miss_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L2 or L3 (Modified) per inst",
+        "MetricExpr": "PM_DPTEG_FROM_DL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_dl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L2 or L3 (Shared) per inst",
+        "MetricExpr": "PM_DPTEG_FROM_DL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_dl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L4 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_DL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_dl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant Memory per inst",
+        "MetricExpr": "PM_DPTEG_FROM_DMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_dmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L2, other core per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L21_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l21_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L2, other core per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L21_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l21_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from L2 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L2 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l2_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L3, other core per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L31_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l31_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L3, other core per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L31_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l31_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from L3 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_L3 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_l3_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Local L4 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_LL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_ll4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Local Memory per inst",
+        "MetricExpr": "PM_DPTEG_FROM_LMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_lmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L2 or L3 (Modified) per inst",
+        "MetricExpr": "PM_DPTEG_FROM_RL2L3_MOD * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_rl2l3_mod_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L2 or L3 (Shared) per inst",
+        "MetricExpr": "PM_DPTEG_FROM_RL2L3_SHR * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_rl2l3_shr_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L4 per inst",
+        "MetricExpr": "PM_DPTEG_FROM_RL4 * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_rl4_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote Memory per inst",
+        "MetricExpr": "PM_DPTEG_FROM_RMEM * 100 / PM_RUN_INST_CMPL",
+        "MetricGroup": "pteg_reloads_percent_per_inst",
+        "MetricName": "pteg_from_rmem_rate_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT misses that result in an ERAT reload",
+        "MetricExpr": "PM_DTLB_MISS * 100 / PM_LSU_DERAT_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "derat_miss_reload_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L2 or L3 (Modified)",
+        "MetricExpr": "PM_DPTEG_FROM_DL2L3_MOD * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_dl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L2 or L3 (Shared)",
+        "MetricExpr": "PM_DPTEG_FROM_DL2L3_SHR * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_dl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant L4",
+        "MetricExpr": "PM_DPTEG_FROM_DL4 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_dl4_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Distant Memory",
+        "MetricExpr": "PM_DPTEG_FROM_DMEM * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_dmem_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L2, other core",
+        "MetricExpr": "PM_DPTEG_FROM_L21_MOD * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l21_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L2, other core",
+        "MetricExpr": "PM_DPTEG_FROM_L21_SHR * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l21_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from L2",
+        "MetricExpr": "PM_DPTEG_FROM_L2 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l2_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L3, other core",
+        "MetricExpr": "PM_DPTEG_FROM_L31_MOD * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l31_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Private L3, other core",
+        "MetricExpr": "PM_DPTEG_FROM_L31_SHR * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l31_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from L3",
+        "MetricExpr": "PM_DPTEG_FROM_L3 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_l3_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Local L4",
+        "MetricExpr": "PM_DPTEG_FROM_LL4 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_ll4_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Local Memory",
+        "MetricExpr": "PM_DPTEG_FROM_LMEM * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_lmem_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L2 or L3 (Modified)",
+        "MetricExpr": "PM_DPTEG_FROM_RL2L3_MOD * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_rl2l3_mod_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L2 or L3 (Shared)",
+        "MetricExpr": "PM_DPTEG_FROM_RL2L3_SHR * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_rl2l3_shr_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote L4",
+        "MetricExpr": "PM_DPTEG_FROM_RL4 * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_rl4_percent"
+    },
+    {
+        "BriefDescription": "% of DERAT reloads from Remote Memory",
+        "MetricExpr": "PM_DPTEG_FROM_RMEM * 100 / PM_DTLB_MISS",
+        "MetricGroup": "pteg_reloads_percent_per_ref",
+        "MetricName": "pteg_from_rmem_percent"
     }
 ]
-- 
2.17.1

