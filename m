Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcGf96fs1zDqXh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:45:37 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26ASsmU086789
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 05:45:31 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28yu2jqa5h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 05:45:30 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 20:45:28 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EC88A2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:45:25 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26AjHTi36110354
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:45:25 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26Aiq5I031373
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:44:52 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH v2 6/6] powerpc/perf: Add Power8 mem_access event to sysfs
Date: Mon,  6 Mar 2017 16:13:13 +0530
In-Reply-To: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1488796993-25495-7-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch add "mem_access" event to sysfs. This as-is not a raw event
supported by Power8 pmu. Instead, it is formed based on
raw event encoding specificed in isa207-common.h.

Primary PMU event used here is PM_MRK_INST_CMPL.
This event tracks only the completed marked instructions.

Random sampling mode (MMCRA[SM]) with Random Instruction
Sampling (RIS) is enabled to mark type of instructions.

With Random sampling in RLS mode with PM_MRK_INST_CMPL event,
the LDST /DATA_SRC fields in SIER identifies the memory
hierarchy level (eg: L1, L2 etc) statisfied a data-cache
miss for a marked instruction.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-events-list.h | 6 ++++++
 arch/powerpc/perf/power8-pmu.c         | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
index 3a2e6e8ebb92..0f1d184627cc 100644
--- a/arch/powerpc/perf/power8-events-list.h
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -89,3 +89,9 @@ EVENT(PM_MRK_FILT_MATCH,			0x2013c)
 EVENT(PM_MRK_FILT_MATCH_ALT,			0x3012e)
 /* Alternate event code for PM_LD_MISS_L1 */
 EVENT(PM_LD_MISS_L1_ALT,			0x400f0)
+/*
+ * Memory Access Event -- mem_access
+ * Primary PMU event used here is PM_MRK_INST_CMPL, along with
+ * Random Load/Store Facility Sampling (RIS) in Random sampling mode (MMCRA[SM]).
+ */
+EVENT(MEM_ACCESS,				0x10401e0)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 932d7536f0eb..5463516e369b 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -90,6 +90,7 @@ GENERIC_EVENT_ATTR(branch-instructions,		PM_BRU_FIN);
 GENERIC_EVENT_ATTR(branch-misses,		PM_BR_MPRED_CMPL);
 GENERIC_EVENT_ATTR(cache-references,		PM_LD_REF_L1);
 GENERIC_EVENT_ATTR(cache-misses,		PM_LD_MISS_L1);
+GENERIC_EVENT_ATTR(mem_access,			MEM_ACCESS);
 
 CACHE_EVENT_ATTR(L1-dcache-load-misses,		PM_LD_MISS_L1);
 CACHE_EVENT_ATTR(L1-dcache-loads,		PM_LD_REF_L1);
@@ -120,6 +121,7 @@ static struct attribute *power8_events_attr[] = {
 	GENERIC_EVENT_PTR(PM_BR_MPRED_CMPL),
 	GENERIC_EVENT_PTR(PM_LD_REF_L1),
 	GENERIC_EVENT_PTR(PM_LD_MISS_L1),
+	GENERIC_EVENT_PTR(MEM_ACCESS),
 
 	CACHE_EVENT_PTR(PM_LD_MISS_L1),
 	CACHE_EVENT_PTR(PM_LD_REF_L1),
-- 
2.7.4
