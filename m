Return-Path: <SRS0=dqXl=QQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236DFC282C4
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:18:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21192084D
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 18:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21192084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43xgJm5p96zDqTm
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Feb 2019 05:18:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43xgDt6XgbzDqSl
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=us.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43xgDt2r0Qz8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2019 05:14:38 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43xgDt1DZdz9sML; Sun, 10 Feb 2019 05:14:38 +1100 (AEDT)
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
 by ozlabs.org (Postfix) with ESMTPS id 43xgDs24s2z9sNH
 for <linuxppc-dev@ozlabs.org>; Sun, 10 Feb 2019 05:14:37 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x19IDPDT062643
 for <linuxppc-dev@ozlabs.org>; Sat, 9 Feb 2019 13:14:35 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qhu2749g3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 09 Feb 2019 13:14:35 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <pc@us.ibm.com>;
 Sat, 9 Feb 2019 18:14:34 -0000
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sat, 9 Feb 2019 18:14:31 -0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x19IEUPi27590716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 9 Feb 2019 18:14:31 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D42847805F;
 Sat,  9 Feb 2019 18:14:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A4BB478060;
 Sat,  9 Feb 2019 18:14:30 +0000 (GMT)
Received: from localhost (unknown [9.114.15.222])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Sat,  9 Feb 2019 18:14:30 +0000 (GMT)
From: Paul Clarke <pc@us.ibm.com>
To: linux-perf-users@vger.kernel.org
Subject: [PATCH 1/4] [powerpc] perf vendor events: Add JSON metrics for POWER9
Date: Sat,  9 Feb 2019 13:14:26 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209181429.23950-1-pc@us.ibm.com>
References: <20190209181429.23950-1-pc@us.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
x-cbid: 19020918-0012-0000-0000-00001707910C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010566; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000279; SDB=6.01158660; UDB=6.00604582; IPR=6.00939195; 
 MB=3.00025508; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-09 18:14:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020918-0013-0000-0000-000056245CF7
Message-Id: <20190209181429.23950-2-pc@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-09_16:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
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
- cpi_breakdown
- estimated_dcache_miss_cpi

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
 .../arch/powerpc/power9/metrics.json          | 577 ++++++++++++++++++
 1 file changed, 577 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/metrics.json

diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
new file mode 100644
index 000000000000..cd46ebb8da6a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
@@ -0,0 +1,577 @@
+[
+    {
+        "BriefDescription": "Completion stall due to a Branch Unit",
+        "MetricExpr": "PM_CMPLU_STALL_BRU/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "bru_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was routed to the crypto execution pipe and was waiting to finish",
+        "MetricExpr": "PM_CMPLU_STALL_CRYPTO/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "crypto_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a load that missed the L1 and was waiting for the data to return from the nest",
+        "MetricExpr": "PM_CMPLU_STALL_DCACHE_MISS/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dcache_miss_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a multi-cycle instruction issued to the Decimal Floating Point execution pipe and waiting to finish.",
+        "MetricExpr": "PM_CMPLU_STALL_DFLONG/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dflong_stall_cpi"
+    },
+    {
+        "BriefDescription": "Stalls due to short latency decimal floating ops.",
+        "MetricExpr": "(PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_DFLONG)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dfu_other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was issued to the Decimal Floating Point execution pipe and waiting to finish.",
+        "MetricExpr": "PM_CMPLU_STALL_DFU/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dfu_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall by Dcache miss which resolved off node memory/cache",
+        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM - PM_CMPLU_STALL_DMISS_REMOTE)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_distant_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall by Dcache miss which resolved on chip ( excluding local L2/L3)",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L21_L31/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_l21_l31_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to cache miss that resolves in the L2 or L3 with a conflict",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L2L3_CONFLICT/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_l2l3_conflict_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to cache miss that resolves in the L2 or L3 without conflict",
+        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L2L3 - PM_CMPLU_STALL_DMISS_L2L3_CONFLICT)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_l2l3_noconflict_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall by Dcache miss which resolved in L2/L3",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L2L3/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_l2l3_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to cache miss resolving missed the L3",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_L3MISS/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_l3miss_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to cache miss that resolves in local memory",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_LMEM/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_lmem_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall by Dcache miss which resolved outside of local memory",
+        "MetricExpr": "(PM_CMPLU_STALL_DMISS_L3MISS - PM_CMPLU_STALL_DMISS_L21_L31 - PM_CMPLU_STALL_DMISS_LMEM)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_non_local_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall by Dcache miss which resolved from remote chip (cache or memory)",
+        "MetricExpr": "PM_CMPLU_STALL_DMISS_REMOTE/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dmiss_remote_stall_cpi"
+    },
+    {
+        "BriefDescription": "Stalls due to short latency double precision ops.",
+        "MetricExpr": "(PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DPLONG)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dp_other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a scalar instruction issued to the Double Precision execution pipe and waiting to finish. Includes binary floating point instructions in 32 and 64 bit binary floating point format.",
+        "MetricExpr": "PM_CMPLU_STALL_DP/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dp_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a scalar multi-cycle instruction issued to the Double Precision execution pipe and waiting to finish. Includes binary floating point instructions in 32 and 64 bit binary floating point format.",
+        "MetricExpr": "PM_CMPLU_STALL_DPLONG/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "dplong_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction is an EIEIO waiting for response from L2",
+        "MetricExpr": "PM_CMPLU_STALL_EIEIO/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "eieio_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the next to finish instruction suffered an ERAT miss and the EMQ was full",
+        "MetricExpr": "PM_CMPLU_STALL_EMQ_FULL/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "emq_full_stall_cpi"
+    },
+    {
+        "MetricExpr": "(PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FULL)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "emq_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a load or store that suffered a translation miss",
+        "MetricExpr": "PM_CMPLU_STALL_ERAT_MISS/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "erat_miss_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles in which the NTC instruction is not allowed to complete because it was interrupted by ANY exception, which has to be serviced before the instruction can complete",
+        "MetricExpr": "PM_CMPLU_STALL_EXCEPTION/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "exception_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to execution units for other reasons.",
+        "MetricExpr": "(PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_FXU - PM_CMPLU_STALL_DP - PM_CMPLU_STALL_DFU - PM_CMPLU_STALL_PM - PM_CMPLU_STALL_CRYPTO - PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VDP)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "exec_unit_other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to execution units (FXU/VSU/CRU)",
+        "MetricExpr": "PM_CMPLU_STALL_EXEC_UNIT/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "exec_unit_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles in which the NTC instruction is not allowed to complete because any of the 4 threads in the same core suffered a flush, which blocks completion",
+        "MetricExpr": "PM_CMPLU_STALL_FLUSH_ANY_THREAD/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "flush_any_thread_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to a long latency scalar fixed point instruction (division, square root)",
+        "MetricExpr": "PM_CMPLU_STALL_FXLONG/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxlong_stall_cpi"
+    },
+    {
+        "BriefDescription": "Stalls due to short latency integer ops",
+        "MetricExpr": "(PM_CMPLU_STALL_FXU - PM_CMPLU_STALL_FXLONG)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxu_other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall due to a scalar fixed point or CR instruction in the execution pipeline. These instructions get routed to the ALU, ALU2, and DIV pipes",
+        "MetricExpr": "PM_CMPLU_STALL_FXU/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "fxu_stall_cpi"
+    },
+    {
+        "MetricExpr": "(PM_NTC_ISSUE_HELD_DARQ_FULL + PM_NTC_ISSUE_HELD_ARB + PM_NTC_ISSUE_HELD_OTHER)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "issue_hold_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a larx waiting to be satisfied",
+        "MetricExpr": "PM_CMPLU_STALL_LARX/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "larx_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a load that hit on an older store and it was waiting for store data",
+        "MetricExpr": "PM_CMPLU_STALL_LHS/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lhs_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a load that missed in the L1 and the LMQ was unable to accept this load miss request because it was full",
+        "MetricExpr": "PM_CMPLU_STALL_LMQ_FULL/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lmq_full_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a load instruction with all its dependencies satisfied just going through the LSU pipe to finish",
+        "MetricExpr": "PM_CMPLU_STALL_LOAD_FINISH/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "load_finish_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a load that was held in LSAQ because the LRQ was full",
+        "MetricExpr": "PM_CMPLU_STALL_LRQ_FULL/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lrq_full_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall due to LRQ miscellaneous reasons, lost arbitration to LMQ slot, bank collisions, set prediction cleanup, set prediction multihit and others",
+        "MetricExpr": "PM_CMPLU_STALL_LRQ_OTHER/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lrq_other_stall_cpi"
+    },
+    {
+        "MetricExpr": "(PM_CMPLU_STALL_LMQ_FULL + PM_CMPLU_STALL_ST_FWD + PM_CMPLU_STALL_LHS + PM_CMPLU_STALL_LSU_MFSPR + PM_CMPLU_STALL_LARX + PM_CMPLU_STALL_LRQ_OTHER)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lrq_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a load or store that was held in LSAQ because an older instruction from SRQ or LRQ won arbitration to the LSU pipe when this instruction tried to launch",
+        "MetricExpr": "PM_CMPLU_STALL_LSAQ_ARB/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsaq_arb_stall_cpi"
+    },
+    {
+        "MetricExpr": "(PM_CMPLU_STALL_LRQ_FULL + PM_CMPLU_STALL_SRQ_FULL + PM_CMPLU_STALL_LSAQ_ARB)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsaq_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was an LSU op (other than a load or a store) with all its dependencies met and just going through the LSU pipe to finish",
+        "MetricExpr": "PM_CMPLU_STALL_LSU_FIN/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_fin_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall of one cycle because the LSU requested to flush the next iop in the sequence. It takes 1 cycle for the ISU to process this request before the LSU instruction is allowed to complete",
+        "MetricExpr": "PM_CMPLU_STALL_LSU_FLUSH_NEXT/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_flush_next_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a mfspr instruction targeting an LSU SPR and it was waiting for the register data to be returned",
+        "MetricExpr": "PM_CMPLU_STALL_LSU_MFSPR/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_mfspr_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion LSU stall for other reasons",
+        "MetricExpr": "(PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_LSU_FIN - PM_CMPLU_STALL_STORE_FINISH - PM_CMPLU_STALL_STORE_DATA - PM_CMPLU_STALL_EIEIO - PM_CMPLU_STALL_STCX - PM_CMPLU_STALL_SLB - PM_CMPLU_STALL_TEND - PM_CMPLU_STALL_PASTE - PM_CMPLU_STALL_TLBIE - PM_CMPLU_STALL_STORE_PIPE_ARB - PM_CMPLU_STALL_STORE_FIN_ARB - PM_CMPLU_STALL_LOAD_FINISH + PM_CMPLU_STALL_DCACHE_MISS - PM_CMPLU_STALL_LMQ_FULL - PM_CMPLU_STALL_ST_FWD - PM_CMPLU_STALL_LHS - PM_CMPLU_STALL_LSU_MFSPR - PM_CMPLU_STALL_LARX - PM_CMPLU_STALL_LRQ_OTHER + PM_CMPLU_STALL_ERAT_MISS + PM_CMPLU_STALL_EMQ_FULL - PM_CMPLU_STALL_LRQ_FULL - PM_CMPLU_STALL_SRQ_FULL - PM_CMPLU_STALL_LSAQ_ARB) / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall by LSU instruction",
+        "MetricExpr": "PM_CMPLU_STALL_LSU/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "lsu_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall because the ISU is updating the register and notifying the Effective Address Table (EAT)",
+        "MetricExpr": "PM_CMPLU_STALL_MTFPSCR/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "mtfpscr_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall because the ISU is updating the TEXASR to keep track of the nested tbegin. This is a short delay, and it includes ROT",
+        "MetricExpr": "PM_CMPLU_STALL_NESTED_TBEGIN/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "nested_tbegin_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall because the ISU is updating the TEXASR to keep track of the nested tend and decrement the TEXASR nested level. This is a short delay",
+        "MetricExpr": "PM_CMPLU_STALL_NESTED_TEND/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "nested_tend_stall_cpi"
+    },
+    {
+        "BriefDescription": "Number of cycles the ICT has no itags assigned to this thread",
+        "MetricExpr": "PM_ICT_NOSLOT_CYC/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "nothing_dispatched_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was one that must finish at dispatch.",
+        "MetricExpr": "PM_CMPLU_STALL_NTC_DISP_FIN/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntc_disp_fin_stall_cpi"
+    },
+    {
+        "BriefDescription": "Cycles in which the oldest instruction in the pipeline (NTC) finishes. This event is used to account for cycles in which work is being completed in the CPI stack",
+        "MetricExpr": "PM_NTC_FIN/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntc_fin_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to ntc flush",
+        "MetricExpr": "PM_CMPLU_STALL_NTC_FLUSH/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntc_flush_stall_cpi"
+    },
+    {
+        "BriefDescription": "The NTC instruction is being held at dispatch because it lost arbitration onto the issue pipe to another instruction (from the same thread or a different thread)",
+        "MetricExpr": "PM_NTC_ISSUE_HELD_ARB/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntc_issue_held_arb_cpi"
+    },
+    {
+        "BriefDescription": "The NTC instruction is being held at dispatch because there are no slots in the DARQ for it",
+        "MetricExpr": "PM_NTC_ISSUE_HELD_DARQ_FULL/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntc_issue_held_darq_full_cpi"
+    },
+    {
+        "BriefDescription": "The NTC instruction is being held at dispatch during regular pipeline cycles, or because the VSU is busy with multi-cycle instructions, or because of a write-back collision with VSU",
+        "MetricExpr": "PM_NTC_ISSUE_HELD_OTHER/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "ntc_issue_held_other_cpi"
+    },
+    {
+        "BriefDescription": "Cycles unaccounted for.",
+        "MetricExpr": "(PM_RUN_CYC - PM_1PLUS_PPC_CMPL - PM_CMPLU_STALL_THRD - PM_CMPLU_STALL - PM_ICT_NOSLOT_CYC)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "other_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall for other reasons",
+        "MetricExpr": "PM_CMPLU_STALL - PM_CMPLU_STALL_NTC_DISP_FIN - PM_CMPLU_STALL_NTC_FLUSH - PM_CMPLU_STALL_LSU - PM_CMPLU_STALL_EXEC_UNIT - PM_CMPLU_STALL_BRU)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a paste waiting for response from L2",
+        "MetricExpr": "PM_CMPLU_STALL_PASTE/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "paste_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was issued to the Permute execution pipe and waiting to finish.",
+        "MetricExpr": "PM_CMPLU_STALL_PM/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "pm_stall_cpi"
+    },
+    {
+        "BriefDescription": "Run cycles per run instruction",
+        "MetricExpr": "PM_RUN_CYC / PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "run_cpi"
+    },
+    {
+        "BriefDescription": "Run_cycles",
+        "MetricExpr": "PM_RUN_CYC/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "run_cyc_cpi"
+    },
+    {
+        "MetricExpr": "(PM_CMPLU_STALL_FXU + PM_CMPLU_STALL_DP + PM_CMPLU_STALL_DFU + PM_CMPLU_STALL_PM + PM_CMPLU_STALL_CRYPTO)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "scalar_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was awaiting L2 response for an SLB",
+        "MetricExpr": "PM_CMPLU_STALL_SLB/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "slb_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall while waiting for the non-speculative finish of either a stcx waiting for its result or a load waiting for non-critical sectors of data and ECC",
+        "MetricExpr": "PM_CMPLU_STALL_SPEC_FINISH/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "spec_finish_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a store that was held in LSAQ because the SRQ was full",
+        "MetricExpr": "PM_CMPLU_STALL_SRQ_FULL/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "srq_full_stall_cpi"
+    },
+    {
+        "MetricExpr": "(PM_CMPLU_STALL_STORE_DATA + PM_CMPLU_STALL_EIEIO + PM_CMPLU_STALL_STCX + PM_CMPLU_STALL_SLB + PM_CMPLU_STALL_TEND + PM_CMPLU_STALL_PASTE + PM_CMPLU_STALL_TLBIE + PM_CMPLU_STALL_STORE_PIPE_ARB + PM_CMPLU_STALL_STORE_FIN_ARB)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "srq_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to store forward",
+        "MetricExpr": "PM_CMPLU_STALL_ST_FWD/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "st_fwd_stall_cpi"
+    },
+    {
+        "BriefDescription": "Nothing completed and ICT not empty",
+        "MetricExpr": "PM_CMPLU_STALL/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a stcx waiting for response from L2",
+        "MetricExpr": "PM_CMPLU_STALL_STCX/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "stcx_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the next to finish instruction was a store waiting on data",
+        "MetricExpr": "PM_CMPLU_STALL_STORE_DATA/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "store_data_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a store waiting for a slot in the store finish pipe. This means the instruction is ready to finish but there are instructions ahead of it, using the finish pipe",
+        "MetricExpr": "PM_CMPLU_STALL_STORE_FIN_ARB/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "store_fin_arb_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a store with all its dependencies met, just waiting to go through the LSU pipe to finish",
+        "MetricExpr": "PM_CMPLU_STALL_STORE_FINISH/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "store_finish_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a store waiting for the next relaunch opportunity after an internal reject. This means the instruction is ready to relaunch and tried once but lost arbitration",
+        "MetricExpr": "PM_CMPLU_STALL_STORE_PIPE_ARB/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "store_pipe_arb_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a tend instruction awaiting response from L2",
+        "MetricExpr": "PM_CMPLU_STALL_TEND/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "tend_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion Stalled because the thread was blocked",
+        "MetricExpr": "PM_CMPLU_STALL_THRD/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "thread_block_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a tlbie waiting for response from L2",
+        "MetricExpr": "PM_CMPLU_STALL_TLBIE/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "tlbie_stall_cpi"
+    },
+    {
+        "BriefDescription": "Vector stalls due to small latency double precision ops",
+        "MetricExpr": "(PM_CMPLU_STALL_VDP - PM_CMPLU_STALL_VDPLONG)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vdp_other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a vector instruction issued to the Double Precision execution pipe and waiting to finish.",
+        "MetricExpr": "PM_CMPLU_STALL_VDP/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vdp_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall because the NTF instruction was a scalar multi-cycle instruction issued to the Double Precision execution pipe and waiting to finish. Includes binary floating point instructions in 32 and 64 bit binary floating point format.",
+        "MetricExpr": "PM_CMPLU_STALL_VDPLONG/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vdplong_stall_cpi"
+    },
+    {
+        "MetricExpr": "(PM_CMPLU_STALL_VFXU + PM_CMPLU_STALL_VDP)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vector_stall_cpi"
+    },
+    {
+        "BriefDescription": "Completion stall due to a long latency vector fixed point instruction (division, square root)",
+        "MetricExpr": "PM_CMPLU_STALL_VFXLONG/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vfxlong_stall_cpi"
+    },
+    {
+        "BriefDescription": "Vector stalls due to small latency integer ops",
+        "MetricExpr": "(PM_CMPLU_STALL_VFXU - PM_CMPLU_STALL_VFXLONG)/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vfxu_other_stall_cpi"
+    },
+    {
+        "BriefDescription": "Finish stall due to a vector fixed point instruction in the execution pipeline. These instructions get routed to the ALU, ALU2, and DIV pipes",
+        "MetricExpr": "PM_CMPLU_STALL_VFXU/PM_RUN_INST_CMPL",
+        "MetricGroup": "cpi_breakdown",
+        "MetricName": "vfxu_stall_cpi"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 distant MOD miss rates with measured DL2L3 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_MOD * PM_MRK_DATA_FROM_DL2L3_MOD_CYC / PM_MRK_DATA_FROM_DL2L3_MOD / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl2l3_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 distant SHR miss rates with measured DL2L3 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_DL2L3_SHR * PM_MRK_DATA_FROM_DL2L3_SHR_CYC / PM_MRK_DATA_FROM_DL2L3_SHR / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl2l3_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of distant L4 miss rates with measured DL4 latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_DL4 * PM_MRK_DATA_FROM_DL4_CYC / PM_MRK_DATA_FROM_DL4 / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dl4_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of distant memory miss rates with measured DMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_DMEM * PM_MRK_DATA_FROM_DMEM_CYC / PM_MRK_DATA_FROM_DMEM / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "dmem_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl21 MOD miss rates with measured L21 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_L21_MOD * PM_MRK_DATA_FROM_L21_MOD_CYC / PM_MRK_DATA_FROM_L21_MOD / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l21_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl21 SHR miss rates with measured L21 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_L21_SHR * PM_MRK_DATA_FROM_L21_SHR_CYC / PM_MRK_DATA_FROM_L21_SHR / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l21_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2 miss rates with measured L2 latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_L2 * PM_MRK_DATA_FROM_L2_CYC / PM_MRK_DATA_FROM_L2 / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l2_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl31 MOD miss rates with measured L31 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_L31_MOD * PM_MRK_DATA_FROM_L31_MOD_CYC / PM_MRK_DATA_FROM_L31_MOD / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l31_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl31 SHR miss rates with measured L31 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_L31_SHR * PM_MRK_DATA_FROM_L31_SHR_CYC / PM_MRK_DATA_FROM_L31_SHR / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l31_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl3 miss rates with measured L3 latency as a % of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_L3 * PM_MRK_DATA_FROM_L3_CYC / PM_MRK_DATA_FROM_L3 / PM_CMPLU_STALL_DCACHE_MISS * 100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "l3_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of Local memory miss rates with measured LMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_LMEM * PM_MRK_DATA_FROM_LMEM_CYC / PM_MRK_DATA_FROM_LMEM / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "lmem_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 remote MOD miss rates with measured RL2L3 MOD latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_MOD * PM_MRK_DATA_FROM_RL2L3_MOD_CYC / PM_MRK_DATA_FROM_RL2L3_MOD / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl2l3_mod_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of dl2l3 shared miss rates with measured RL2L3 SHR latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_RL2L3_SHR * PM_MRK_DATA_FROM_RL2L3_SHR_CYC / PM_MRK_DATA_FROM_RL2L3_SHR / PM_CMPLU_STALL_DCACHE_MISS * 100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl2l3_shr_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of remote L4 miss rates with measured RL4 latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_RL4 * PM_MRK_DATA_FROM_RL4_CYC / PM_MRK_DATA_FROM_RL4 / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rl4_cpi_percent"
+    },
+    {
+        "BriefDescription": "estimate of remote memory miss rates with measured RMEM latency as a %of dcache miss cpi",
+        "MetricExpr": "PM_DATA_FROM_RMEM * PM_MRK_DATA_FROM_RMEM_CYC / PM_MRK_DATA_FROM_RMEM / PM_CMPLU_STALL_DCACHE_MISS *100",
+        "MetricGroup": "estimated_dcache_miss_cpi",
+        "MetricName": "rmem_cpi_percent"
+    }
+]
-- 
2.17.1

