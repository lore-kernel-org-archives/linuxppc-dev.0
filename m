Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tt7YT43jNzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 20:14:21 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v039EDSk020738
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 04:14:19 -0500
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27r4y5gu51-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 04:14:18 -0500
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 3 Jan 2017 14:43:28 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 947D0394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2017 14:43:26 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v039Cf7V26869882
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 14:42:41 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v039DOv9008326
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 14:43:25 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: use MSR to report privilege level on P9 DD1
Date: Tue,  3 Jan 2017 14:43:13 +0530
Message-Id: <1483434793-1814-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"use_siar" variable is primarily used for deciding the sampled address
and the privilege level to be reported for a sample. perf_read_regs()
function updates the "use_siar" and "regs->result" based on the pmu
flags along with other checks. To force the use of MSR to report the
privilege level and to use "regs->nip" to report the instruction pointer,
set "PPMU_NO_CONT_SAMPLING" flag and remove "PPMU_HAS_SIER" from the
ppmu->flags.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index a46ef29e50e7..06b7e8ebd29a 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -403,7 +403,7 @@ static struct power_pmu power9_isa207_pmu = {
 	.bhrb_filter_map	= power9_bhrb_filter_map,
 	.get_constraint		= isa207_get_constraint,
 	.disable_pmc		= isa207_disable_pmc,
-	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
+	.flags			= PPMU_NO_CONT_SAMPLING | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power9_generic_events),
 	.generic_events		= power9_generic_events,
 	.cache_events		= &power9_cache_events,
-- 
2.7.4
