Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC3AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:55:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE17C21934
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 00:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpsWlkIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE17C21934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 440vv15mM0zDqbW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 11:55:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 440vj16mFszDqY2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:46:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="DpsWlkIl"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 440vj14VgYz8wK2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 11:46:45 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 440vj13ZLfz9sDr; Fri, 15 Feb 2019 11:46:45 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=acme@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="DpsWlkIl"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 440vj02NqQz9s9G
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2019 11:46:42 +1100 (AEDT)
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E019222C9;
 Fri, 15 Feb 2019 00:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1550191600;
 bh=/ljUlPUaMBaiEoAWvaXiUeDwU0kApmNle5smb7Ldb/g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DpsWlkIl8TOmoa7e8OXRtgKOcnj0sxaB8NX9h5o03R3NmMF7O5rlbhzjRtOvYoI5s
 K2ajDRxMKPe1Ns5DklbvuBAyfjGIRWrGmDdrGeCzfw6owE/TzMhkPozQvYLfE41WIH
 Al7ar4xeFyBjyQVTqnHiylV/XL3+kguhNbDXe8LY=
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 11/43] perf vendor events power9: General metrics
Date: Thu, 14 Feb 2019 21:45:07 -0300
Message-Id: <20190215004539.23571-12-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Paul Clarke <pc@us.ibm.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Carl Love <cel@us.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Paul Clarke <pc@us.ibm.com>

Descriptions of metrics for POWER9 processors can be found in the
"POWER9 Performance Monitor Unit User’s Guide", which is currently
available on the "IBM Portal for OpenPOWER"
(https://www-355.ibm.com/systems/power/openpower/welcome.xhtml) at
https://www-355.ibm.com/systems/power/openpower/posting.xhtml?postingId=4948CDE1963C9BCA852582F800718190

This patch is for metric groups:
- general

and other metrics not in a metric group.

Signed-off-by: Paul Clarke <pc@us.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Carl Love <cel@us.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Link: http://lkml.kernel.org/r/20190209181429.23950-5-pc@us.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.19.1

