Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3CVQ0djRzDqNJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 14:43:09 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0I3d9sc113619
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 22:43:06 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 281xc2bxkb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 22:43:05 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 18 Jan 2017 09:13:02 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D91821258026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 09:14:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0I3g8D227132040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 09:12:08 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0I3gwUN030722
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 09:12:58 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2] powerpc/perf: use MSR to report privilege level on P9 DD1
Date: Wed, 18 Jan 2017 09:12:56 +0530
Message-Id: <1484710976-7711-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since SIER and SIAR updates are not valid for some
samples, patch forces the use of MSR and regs->nip instead
for misc_flag updates. This is done by adding a new ppmu
flag and updating user_siar value in perf_read_regs() accordingly.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog:
1)Added a new ppmu flag
2)Added the new flag to the check in perf_read_regs()
3)Made changes to commit message

 arch/powerpc/include/asm/perf_event_server.h | 1 +
 arch/powerpc/perf/core-book3s.c              | 2 ++
 arch/powerpc/perf/power9-pmu.c               | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index e157489ee7a1..acab0ff4e7a3 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -65,6 +65,7 @@ struct power_pmu {
 #define PPMU_HAS_SSLOT		0x00000020 /* Has sampled slot in MMCRA */
 #define PPMU_HAS_SIER		0x00000040 /* Has SIER */
 #define PPMU_ARCH_207S		0x00000080 /* PMC is architecture v2.07S */
+#define PPMU_DISABLE_USE_SIAR	0x00000100 /* Do not use SIER and SIAR */
 
 /*
  * Values for flags to get_alternatives()
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index fd3e4034c04d..8827bea50b91 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -295,6 +295,8 @@ static inline void perf_read_regs(struct pt_regs *regs)
 	 */
 	if (TRAP(regs) != 0xf00)
 		use_siar = 0;
+	else if ((ppmu->flags & PPMU_DISABLE_USE_SIAR))
+		use_siar = 0;
 	else if (marked)
 		use_siar = 1;
 	else if ((ppmu->flags & PPMU_NO_CONT_SAMPLING))
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 346010e8d463..4eec7ad9f187 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -384,7 +384,7 @@ static struct power_pmu power9_isa207_pmu = {
 	.bhrb_filter_map	= power9_bhrb_filter_map,
 	.get_constraint		= isa207_get_constraint,
 	.disable_pmc		= isa207_disable_pmc,
-	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
+	.flags			= PPMU_DISABLE_USE_SIAR | PPMU_HAS_SIER | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power9_generic_events),
 	.generic_events		= power9_generic_events,
 	.cache_events		= &power9_cache_events,
-- 
2.7.4
