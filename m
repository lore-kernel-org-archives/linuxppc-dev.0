Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrW916bS0zDq88
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 09:51:33 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, maddy@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/perf: Add POWER9 alternate PM_RUN_CYC and
 PM_RUN_INST_CMPL events
Date: Mon, 19 Jun 2017 09:51:28 +1000
Message-Id: <20170618235128.20472-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Similar to POWER8, POWER9 can count run cycles and run instructions
completed on more than one PMU.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/perf/power9-events-list.h | 4 ++++
 arch/powerpc/perf/power9-pmu.c         | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/powerpc/perf/power9-events-list.h b/arch/powerpc/perf/power9-events-list.h
index 71a6bfee5c02..e9e417eefa59 100644
--- a/arch/powerpc/perf/power9-events-list.h
+++ b/arch/powerpc/perf/power9-events-list.h
@@ -51,8 +51,12 @@ EVENT(PM_DTLB_MISS,				0x300fc)
 EVENT(PM_ITLB_MISS,				0x400fc)
 /* Run_Instructions */
 EVENT(PM_RUN_INST_CMPL,				0x500fa)
+/* Alternate event code for PM_RUN_INST_CMPL */
+EVENT(PM_RUN_INST_CMPL_ALT,			0x400fa)
 /* Run_cycles */
 EVENT(PM_RUN_CYC,				0x600f4)
+/* Alternate event code for Run_cycles */
+EVENT(PM_RUN_CYC_ALT,				0x200f4)
 /* Instruction Dispatched */
 EVENT(PM_INST_DISP,				0x200f2)
 EVENT(PM_INST_DISP_ALT,				0x300f2)
diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 018f8e90ac35..b9168163b2b2 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -107,6 +107,8 @@ extern struct attribute_group isa207_pmu_format_group;
 /* Table of alternatives, sorted by column 0 */
 static const unsigned int power9_event_alternatives[][MAX_ALT] = {
 	{ PM_INST_DISP,			PM_INST_DISP_ALT },
+	{ PM_RUN_CYC_ALT,		PM_RUN_CYC },
+	{ PM_RUN_INST_CMPL_ALT,		PM_RUN_INST_CMPL },
 };
 
 static int power9_get_alternatives(u64 event, unsigned int flags, u64 alt[])
-- 
2.11.0
