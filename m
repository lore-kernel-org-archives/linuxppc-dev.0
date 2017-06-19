Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrt6f4znlzDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 00:05:46 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5JE4m5k049054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 10:05:44 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b64rsq1va-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 10:05:44 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 20 Jun 2017 00:05:41 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5JE5cu58847622
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 00:05:38 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5JE5Zi8012256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 00:05:36 +1000
Subject: Re: [PATCH] powerpc/perf: Fix POWER9 branch event
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, mikey@neuling.org
Cc: linuxppc-dev@lists.ozlabs.org
References: <20170619035526.7070-1-anton@ozlabs.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 19 Jun 2017 19:35:27 +0530
MIME-Version: 1.0
In-Reply-To: <20170619035526.7070-1-anton@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <adadaf41-5a8b-0632-beff-c942081dbfe6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Monday 19 June 2017 09:25 AM, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
>
> The POWER9 branch event is wrong, and we always get a count of zero:
>
> ...
>                   0      branches
>                3844      branch-misses             #    0.00% of all branches
>
> Replace it with the correct event.
Anton,

How about this patch,  this will force DD1 to use 0x10012 for
branch and later to use 0x4d05e ?

diff --git a/arch/powerpc/perf/power9-events-list.h 
b/arch/powerpc/perf/power9-events-list.h
index 71a6bfee5c02..13bd159db300 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -16,7 +16,7 @@ EVENT(PM_CYC,                    0x0001e)
  EVENT(PM_ICT_NOSLOT_CYC,            0x100f8)
  EVENT(PM_CMPLU_STALL,                0x1e054)
  EVENT(PM_INST_CMPL,                0x00002)
-EVENT(PM_BRU_CMPL,                0x10012)
+EVENT(PM_BR_CMPL,                0x4d05e)
  EVENT(PM_BR_MPRED_CMPL,                0x400f6)

  /* All L1 D cache load references counted at finish, gated by reject */
@@ -56,3 +56,4 @@ EVENT(PM_RUN_CYC,                0x600f4)
  /* Instruction Dispatched */
  EVENT(PM_INST_DISP,                0x200f2)
  EVENT(PM_INST_DISP_ALT,                0x300f2)
+EVENT(PM_BR_CMPL_ALT,                0x10012)
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index bb28e1a41257..485dacf30152 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -123,7 +123,7 @@ GENERIC_EVENT_ATTR(cpu-cycles, PM_CYC);
  GENERIC_EVENT_ATTR(stalled-cycles-frontend,    PM_ICT_NOSLOT_CYC);
  GENERIC_EVENT_ATTR(stalled-cycles-backend,    PM_CMPLU_STALL);
  GENERIC_EVENT_ATTR(instructions,        PM_INST_CMPL);
-GENERIC_EVENT_ATTR(branch-instructions,        PM_BRU_CMPL);
+GENERIC_EVENT_ATTR(branch-instructions,        PM_BR_CMPL);
  GENERIC_EVENT_ATTR(branch-misses,        PM_BR_MPRED_CMPL);
  GENERIC_EVENT_ATTR(cache-references,        PM_LD_REF_L1);
  GENERIC_EVENT_ATTR(cache-misses,        PM_LD_MISS_L1_FIN);
@@ -141,7 +141,7 @@ CACHE_EVENT_ATTR(LLC-prefetches, PM_L3_PREF_ALL);
  CACHE_EVENT_ATTR(LLC-store-misses,        PM_L2_ST_MISS);
  CACHE_EVENT_ATTR(LLC-stores,            PM_L2_ST);
  CACHE_EVENT_ATTR(branch-load-misses,        PM_BR_MPRED_CMPL);
-CACHE_EVENT_ATTR(branch-loads,            PM_BRU_CMPL);
+CACHE_EVENT_ATTR(branch-loads,            PM_BR_CMPL);
  CACHE_EVENT_ATTR(dTLB-load-misses,        PM_DTLB_MISS);
  CACHE_EVENT_ATTR(iTLB-load-misses,        PM_ITLB_MISS);

@@ -150,7 +150,7 @@ static struct attribute *power9_events_attr[] = {
      GENERIC_EVENT_PTR(PM_ICT_NOSLOT_CYC),
      GENERIC_EVENT_PTR(PM_CMPLU_STALL),
      GENERIC_EVENT_PTR(PM_INST_CMPL),
-    GENERIC_EVENT_PTR(PM_BRU_CMPL),
+    GENERIC_EVENT_PTR(PM_BR_CMPL),
      GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
      GENERIC_EVENT_PTR(PM_LD_REF_L1),
      GENERIC_EVENT_PTR(PM_LD_MISS_L1_FIN),
@@ -167,7 +167,7 @@ static struct attribute *power9_events_attr[] = {
      CACHE_EVENT_PTR(PM_L2_ST_MISS),
      CACHE_EVENT_PTR(PM_L2_ST),
      CACHE_EVENT_PTR(PM_BR_MPRED_CMPL),
-    CACHE_EVENT_PTR(PM_BRU_CMPL),
+    CACHE_EVENT_PTR(PM_BR_CMPL),
      CACHE_EVENT_PTR(PM_DTLB_MISS),
      CACHE_EVENT_PTR(PM_ITLB_MISS),
      NULL
@@ -231,7 +231,7 @@ static int power9_generic_events_dd1[] = {
      [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =    PM_ICT_NOSLOT_CYC,
      [PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =    PM_CMPLU_STALL,
      [PERF_COUNT_HW_INSTRUCTIONS] =            PM_INST_DISP,
-    [PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =        PM_BRU_CMPL,
+    [PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =        PM_BR_CMPL_ALT,
      [PERF_COUNT_HW_BRANCH_MISSES] =            PM_BR_MPRED_CMPL,
      [PERF_COUNT_HW_CACHE_REFERENCES] =        PM_LD_REF_L1,
      [PERF_COUNT_HW_CACHE_MISSES] =            PM_LD_MISS_L1_FIN,
@@ -242,7 +242,7 @@ static int power9_generic_events[] = {
      [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =    PM_ICT_NOSLOT_CYC,
      [PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =    PM_CMPLU_STALL,
      [PERF_COUNT_HW_INSTRUCTIONS] =            PM_INST_CMPL,
-    [PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =        PM_BRU_CMPL,
+    [PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =        PM_BR_CMPL,
      [PERF_COUNT_HW_BRANCH_MISSES] =            PM_BR_MPRED_CMPL,
      [PERF_COUNT_HW_CACHE_REFERENCES] =        PM_LD_REF_L1,
      [PERF_COUNT_HW_CACHE_MISSES] =            PM_LD_MISS_L1_FIN,
@@ -368,7 +368,7 @@ static int 
power9_cache_events[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
      },
      [ C(BPU) ] = {
          [ C(OP_READ) ] = {
-            [ C(RESULT_ACCESS) ] = PM_BRU_CMPL,
+            [ C(RESULT_ACCESS) ] = PM_BR_CMPL,
              [ C(RESULT_MISS)   ] = PM_BR_MPRED_CMPL,
          },
          [ C(OP_WRITE) ] = {
@@ -453,6 +453,10 @@ static int __init init_power9_pmu(void)
           * sampling scenarios in power9 DD1, instead use PM_INST_DISP.
           */
          EVENT_VAR(PM_INST_CMPL, _g).id = PM_INST_DISP;
+        /*
+         * This is a hack, but then this is only for DD1
+         */
+        EVENT_VAR(PM_BR_CMPL, _g).id = PM_BR_CMPL_ALT;
          rc = register_power_pmu(&power9_isa207_pmu);
      } else {
          rc = register_power_pmu(&power9_pmu);
