Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qr4m04R0KzDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 14:00:32 +1000 (AEST)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 21 Apr 2016 09:30:28 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3L40L5Z52035788
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 09:30:22 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3L40KNH015884
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 09:30:21 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH]powerpc/perf: Replace raw event hex values with #def
Date: Thu, 21 Apr 2016 09:30:14 +0530
Message-Id: <1461211214-4705-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Minor cleanup patch to replace the raw event hex values in
power8-pmu.c with #def.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-events-list.h | 42 ++++++++++++++++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c         | 41 +++++++++++++++++----------------
 2 files changed, 63 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
index 741b77edd03e..fc9ff370b199 100644
--- a/arch/powerpc/perf/power8-events-list.h
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -49,3 +49,45 @@ EVENT(PM_L3_PREF_ALL,				0x4e052)
 EVENT(PM_DTLB_MISS,				0x300fc)
 /* ITLB Reloaded */
 EVENT(PM_ITLB_MISS,				0x400fc)
+/* Run_Instructions */
+EVENT(PM_RUN_INST_CMPL,				0x500fa)
+/* Alternate event code for PM_RUN_INST_CMPL */
+EVENT(_PM_RUN_INST_CMPL,			0x400fa)
+/* Run_cycles */
+EVENT(PM_RUN_CYC,				0x600f4)
+/* Alternate event code for Run_cycles */
+EVENT(_PM_RUN_CYC,				0x200f4)
+/* Marked store completed */
+EVENT(PM_MRK_ST_CMPL,				0x10134)
+/* Alternate event code for Marked store completed */
+EVENT(_PM_MRK_ST_CMPL,				0x301e2)
+/* PM_BR_MRK_2PATH */
+EVENT(PM_BR_MRK_2PATH,				0x10138)
+/* Alternate event code for PM_BR_MRK_2PATH */
+EVENT(PM_BR_MRK_2PATH,				0x40138)
+/* PM_L3_CO_MEPF */
+EVENT(PM_L3_CO_MEPF,				0x18082)
+/* Alternate event code for PM_L3_CO_MEPF */
+EVENT(_PM_L3_CO_MEPF,				0x3e05e)
+/* PM_MRK_DATA_FROM_L2MISS */
+EVENT(PM_MRK_DATA_FROM_L2MISS,			0x1d14e)
+/* Alternate event code for PM_MRK_DATA_FROM_L2MISS */
+EVENT(_PM_MRK_DATA_FROM_L2MISS,			0x401e8)
+/* PM_CMPLU_STALL */
+EVENT(PM_CMPLU_STALL,				0x1e054)
+/* Alternate event code for  PM_CMPLU_STALL */
+EVENT(_PM_CMPLU_STALL,				0x4000a)
+/* PM_BR_2PATH */
+EVENT(PM_BR_2PATH,				0x20036)
+/* Alternate event code for PM_BR_2PATH */
+EVENT(_PM_BR_2PATH,				0x40036)
+/* PM_INST_DISP */
+EVENT(PM_INST_DISP,				0x200f2)
+/* Alternate event code for PM_INST_DISP */
+EVENT(_PM_INST_DISP,				0x300f2)
+/* PM_MRK_FILT_MATCH */
+EVENT(PM_MRK_FILT_MATCH,			0x2013c)
+/* Alternate event code for PM_MRK_FILT_MATCH */
+EVENT(_PM_MRK_FILT_MATCH,			0x3012e)
+/* Alternate event code for PM_LD_MISS_L1 */
+EVENT(_PM_LD_MISS_L1,				0x400f0)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 690d9186a855..0d7a176fcd74 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -274,7 +274,8 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 		/* Ignore Linux defined bits when checking event below */
 		base_event = event & ~EVENT_LINUX_MASK;
 
-		if (pmc >= 5 && base_event != 0x500fa && base_event != 0x600f4)
+		if (pmc >= 5 && base_event != PM_RUN_INST_CMPL &&
+				base_event != PM_RUN_CYC)
 			return -1;
 
 		mask  |= CNST_PMC_MASK(pmc);
@@ -488,17 +489,17 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 
 /* Table of alternatives, sorted by column 0 */
 static const unsigned int event_alternatives[][MAX_ALT] = {
-	{ 0x10134, 0x301e2 },		/* PM_MRK_ST_CMPL */
-	{ 0x10138, 0x40138 },		/* PM_BR_MRK_2PATH */
-	{ 0x18082, 0x3e05e },		/* PM_L3_CO_MEPF */
-	{ 0x1d14e, 0x401e8 },		/* PM_MRK_DATA_FROM_L2MISS */
-	{ 0x1e054, 0x4000a },		/* PM_CMPLU_STALL */
-	{ 0x20036, 0x40036 },		/* PM_BR_2PATH */
-	{ 0x200f2, 0x300f2 },		/* PM_INST_DISP */
-	{ 0x200f4, 0x600f4 },		/* PM_RUN_CYC */
-	{ 0x2013c, 0x3012e },		/* PM_MRK_FILT_MATCH */
-	{ 0x3e054, 0x400f0 },		/* PM_LD_MISS_L1 */
-	{ 0x400fa, 0x500fa },		/* PM_RUN_INST_CMPL */
+	{ PM_MRK_ST_CMPL,		_PM_MRK_ST_CMPL },
+	{ PM_BR_MRK_2PATH,		_PM_BR_MRK_2PATH },
+	{ PM_L3_CO_MEPF,		_PM_L3_CO_MEPF },
+	{ PM_MRK_DATA_FROM_L2MISS,	_PM_MRK_DATA_FROM_L2MISS },
+	{ PM_CMPLU_STALL,		_PM_CMPLU_STALL },
+	{ PM_BR_2PATH,			_PM_BR_2PATH },
+	{ PM_INST_DISP,			_PM_INST_DISP },
+	{ _PM_RUN_CYC,			PM_RUN_CYC },
+	{ PM_MRK_FILT_MATCH,		_PM_MRK_FILT_MATCH },
+	{ PM_LD_MISS_L1,		_PM_LD_MISS_L1 },
+	{ _PM_RUN_INST_CMPL,		PM_RUN_INST_CMPL },
 };
 
 /*
@@ -546,17 +547,17 @@ static int power8_get_alternatives(u64 event, unsigned int flags, u64 alt[])
 		j = num_alt;
 		for (i = 0; i < num_alt; ++i) {
 			switch (alt[i]) {
-			case 0x1e:	/* PM_CYC */
-				alt[j++] = 0x600f4;	/* PM_RUN_CYC */
+			case PM_CYC:
+				alt[j++] = PM_RUN_CYC;
 				break;
-			case 0x600f4:	/* PM_RUN_CYC */
-				alt[j++] = 0x1e;
+			case PM_RUN_CYC:
+				alt[j++] = PM_CYC;
 				break;
-			case 0x2:	/* PM_PPC_CMPL */
-				alt[j++] = 0x500fa;	/* PM_RUN_INST_CMPL */
+			case PM_INST_CMPL:
+				alt[j++] = PM_RUN_INST_CMPL;
 				break;
-			case 0x500fa:	/* PM_RUN_INST_CMPL */
-				alt[j++] = 0x2;	/* PM_PPC_CMPL */
+			case PM_RUN_INST_CMPL:
+				alt[j++] = PM_INST_CMPL;
 				break;
 			}
 		}
-- 
1.9.1
