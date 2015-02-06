Return-Path: <tom.huynh@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0115.outbound.protection.outlook.com [157.56.110.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 80E591A0A3E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Feb 2015 10:00:05 +1100 (AEDT)
From: Tom Huynh <tom.huynh@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <a.p.zijlstra@chello.nl>, <mingo@redhat.com>, <acme@kernel.org>
Subject: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Date: Fri, 6 Feb 2015 16:43:54 -0600
Message-ID: <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
In-Reply-To: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tom Huynh <tom.huynh@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the perf events in e6500 available via sysfs.

	$ ls /sys/devices/cpu/events/
	branch-instructions
	branch-misses
	cache-misses
	cpu-cycles
	instructions
	FSL_0_INST_CMPL
	FSL_1_INST_CMPL
	...

	$ cat /sys/devices/cpu/events/cpu-cycles
	event=0x01

Similar to the following commits:
- 1c53a270724d ("perf/POWER7: Make generic event translations
  available in sysfs").
- 886c3b2d677f ("perf/POWER7: Make some POWER7 events available
  in sysfs")
- cfe0d8ba14a1 ("perf tools: Make Power7 events available for perf")

Signed-off-by: Tom Huynh <tom.huynh@freescale.com>
---
 arch/powerpc/include/asm/perf_event_fsl_emb.h |  20 +-
 arch/powerpc/perf/core-fsl-emb.c              |  12 ++
 arch/powerpc/perf/e6500-events-list.h         | 289 ++++++++++++++++++++++++++
 arch/powerpc/perf/e6500-pmu.c                 |  50 ++++-
 4 files changed, 365 insertions(+), 6 deletions(-)
 create mode 100644 arch/powerpc/perf/e6500-events-list.h

diff --git a/arch/powerpc/include/asm/perf_event_fsl_emb.h b/arch/powerpc/include/asm/perf_event_fsl_emb.h
index a581654..d76124f 100644
--- a/arch/powerpc/include/asm/perf_event_fsl_emb.h
+++ b/arch/powerpc/include/asm/perf_event_fsl_emb.h
@@ -11,6 +11,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/device.h>
 #include <asm/hw_irq.h>
 
 #define MAX_HWEVENTS 6
@@ -39,7 +40,7 @@ struct fsl_emb_pmu {
 
 	/* Returns event flags and PMLCb (FSL_EMB_EVENT_*) */
 	u64		(*xlate_event)(u64 event_id);
-
+	const struct attribute_group    **attr_groups;
 	int		n_generic;
 	int		*generic_events;
 	int		(*cache_events)[PERF_COUNT_HW_CACHE_MAX]
@@ -48,3 +49,20 @@ struct fsl_emb_pmu {
 };
 
 int register_fsl_emb_pmu(struct fsl_emb_pmu *);
+
+extern ssize_t fsl_emb_events_sysfs_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *page);
+
+#define EVENT_VAR(_id, _suffix)         event_attr_##_id##_suffix
+#define EVENT_PTR(_id, _suffix)         (&event_attr_##_id##_suffix.attr.attr)
+
+#define EVENT_ATTR(_name, _id, _suffix)                           \
+	PMU_EVENT_ATTR(_name, EVENT_VAR(_id, _suffix), PME_##_id, \
+			fsl_emb_events_sysfs_show)
+
+#define GENERIC_EVENT_ATTR(_name, _id)  EVENT_ATTR(_name, _id, _g)
+#define GENERIC_EVENT_PTR(_id)          EVENT_PTR(_id, _g)
+
+#define FSL_EMB_EVENT_ATTR(_name, _id)	EVENT_ATTR(_name, _id, _p)
+#define FSL_EMB_EVENT_PTR(_id)		EVENT_PTR(_id, _p)
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index 4acaea0..d4af2f3 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -581,6 +581,16 @@ static int fsl_emb_pmu_event_init(struct perf_event *event)
 	return err;
 }
 
+ssize_t fsl_emb_events_sysfs_show(struct device *dev,
+				  struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+
+	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
 static struct pmu fsl_emb_pmu = {
 	.pmu_enable	= fsl_emb_pmu_enable,
 	.pmu_disable	= fsl_emb_pmu_disable,
@@ -711,6 +721,8 @@ int register_fsl_emb_pmu(struct fsl_emb_pmu *pmu)
 	pr_info("%s performance monitor hardware support registered\n",
 		pmu->name);
 
+	fsl_emb_pmu.attr_groups = ppmu->attr_groups;
+
 	perf_pmu_register(&fsl_emb_pmu, "cpu", PERF_TYPE_RAW);
 
 	return 0;
diff --git a/arch/powerpc/perf/e6500-events-list.h b/arch/powerpc/perf/e6500-events-list.h
new file mode 100644
index 0000000..27be38a
--- /dev/null
+++ b/arch/powerpc/perf/e6500-events-list.h
@@ -0,0 +1,289 @@
+/*
+ * Performance counter support for e6500 family processors.
+ *
+ * Copyright 2015 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+EVENT(FSL_CYC,					1)
+EVENT(FSL_INST_CMPL,				2)
+EVENT(FSL_UOPS_CMPL,				3)
+EVENT(FSL_UOPS_DECODED,				5)
+EVENT(FSL_PM_EV_TRANS,				6)
+EVENT(FSL_PM_EV_CYC,				7)
+EVENT(FSL_BR_CMPL,				8)
+EVENT(FSL_BR_TKN,				67)
+EVENT(FSL_BLR_TKN,				68)
+EVENT(FSL_NUM_CQ_REDIR,				11)
+EVENT(FSL_LD_UOPS_CMPL,				9)
+EVENT(FSL_ST_UOPS_CMPL,				10)
+EVENT(FSL_LSU_UOPS_CMPL,			181)
+EVENT(FSL_GPR_LD_CMPL,				182)
+EVENT(FSL_GPR_ST_CMPL,				183)
+EVENT(FSL_CACHE_OPS_CMPL,			184)
+EVENT(FSL_MEM_BAR_CMPL,				185)
+EVENT(FSL_SFX_UOPS_CMPL,			186)
+EVENT(FSL_SFX_SINGLE_CYC_UOPS_CMPL,		187)
+EVENT(FSL_SFX_DOUBLE_CYC_UOPS_CMPL,		188)
+EVENT(FSL_CFX_INST_CMPL,			190)
+EVENT(FSL_SFX_CFX_INST_CMPL,			191)
+EVENT(FSL_FPU_INST_CMPL,			192)
+EVENT(FSL_FPR_LD_CMPL,				193)
+EVENT(FSL_FPR_ST_CMPL,				194)
+EVENT(FSL_FPR_LD_ST_CMPL,			195)
+EVENT(FSL_FPR_SINGLE_PRE_LD_ST_CMPL,		196)
+EVENT(FSL_FPR_DOUBLE_PRE_LD_ST_CMPL,		197)
+EVENT(FSL_ALTIV_INST_CMPL,			198)
+EVENT(FSL_ALTIV_VSFX_INST_CMPL,			199)
+EVENT(FSL_ALTIV_VCFX_INST_CMPL,			200)
+EVENT(FSL_ALTIV_VPU_INST_CMPL,			201)
+EVENT(FSL_ALTIV_VFPU_INST_CMPL,			202)
+EVENT(FSL_VR_LD_CMPL,				203)
+EVENT(FSL_VR_ST_CMPL,				204)
+EVENT(FSL_VSCR_SAT_SET,				205)
+EVENT(FSL_BR_FIN,                               12)
+EVENT(FSL_TKN_BR_FIN,				13)
+EVENT(FSL_UNCON_BR_NO_BTB_FIN,			14)
+EVENT(FSL_BR_MPRED,				15)
+EVENT(FSL_BR_BTB_DIR_MPRED,			16)
+EVENT(FSL_TARGET_MPRED_BTB,			69)
+EVENT(FSL_TARGET_MPRED_LINK_STACK,		70)
+EVENT(FSL_BTB_ALLOC,				71)
+EVENT(FSL_BTB_HIT_PHANTOM_BR,			72)
+EVENT(FSL_BTB_HIT_PSEUDO_HIT,			17)
+/* Pipelne Stalls */
+EVENT(FSL_DECODE_STALL,				18)
+EVENT(FSL_SFX_CFX_STALL,			19)
+EVENT(FSL_LSU_STALL,				110)
+EVENT(FSL_BR_STALL,				20)
+EVENT(FSL_FPU_STALL,				111)
+EVENT(FSL_ALTIV_STALL,				112)
+EVENT(FSL_SFX0_SCHED_STALL,			21)
+EVENT(FSL_SFX1_SCHED_STALL,			22)
+EVENT(FSL_CFX_SCHED_STALL,			23)
+EVENT(FSL_LSU_SCHED_STALL,			24)
+EVENT(FSL_BU_SCHED_STALL,			25)
+EVENT(FSL_FPU_SCHED_STALL,			113)
+EVENT(FSL_VPERM_SCHED_STALL,			114)
+EVENT(FSL_VGEN_SCHED_STALL,			115)
+EVENT(FSL_VPU_INST_WAIT_OPD,			116)
+EVENT(FSL_VFPU_INST_WAIT_OPD,			117)
+EVENT(FSL_VSFX_INST_WAIT_OPD,			118)
+EVENT(FSL_VCFX_INST_WAIT_OPD,			119)
+EVENT(FSL_IB_EMPTY,				122)
+EVENT(FSL_IB_FULL,				123)
+EVENT(FSL_CB_EMPTY,				124)
+EVENT(FSL_CB_FULL,				125)
+EVENT(FSL_0_INST_CMPL,				127)
+EVENT(FSL_1_INST_CMPL,				128)
+EVENT(FSL_2_INST_CMPL,				129)
+/* Execution Unit Idle Events */
+EVENT(FSL_SFX0_IDL,				210)
+EVENT(FSL_SFX1_IDL,				211)
+EVENT(FSL_CFX_IDL,				212)
+EVENT(FSL_LSU_IDL,				213)
+EVENT(FSL_BU_IDL,				214)
+EVENT(FSL_FPU_IDL,				215)
+EVENT(FSL_VPU_IDL,				216)
+EVENT(FSL_VFPU_IDL,				217)
+EVENT(FSL_VSFX_IDL,				218)
+EVENT(FSL_VCFX_IDL,				219)
+/* Load/Store and Data Cache Events */
+EVENT(FSL_TOTL_TRANS,				26)
+EVENT(FSL_LD_TRANS,				27)
+EVENT(FSL_ST_TRANS,				28)
+EVENT(FSL_TOUCH_TRANS,				29)
+EVENT(FSL_CACHE_OPS_TRANS,			30)
+EVENT(FSL_CACHE_INHIB_TRANS,			31)
+EVENT(FSL_GUARD_LD_TRANS,			32)
+EVENT(FSL_WR_TH_ST_TRANS,			33)
+EVENT(FSL_MISALIGN_LD_ST_TRANS,			34)
+EVENT(FSL_L1D_MIS,				221)
+EVENT(FSL_L1D_LD_MIS,				222)
+EVENT(FSL_L1D_ST_MIS,				223)
+EVENT(FSL_L1D_RELD,				41)
+EVENT(FSL_LD_ALLOC_LMQ,				224)
+EVENT(FSL_LD_THRD_MIS_COLL,			225)
+EVENT(FSL_INTER_THRD_STAT_ARY_COLL,		226)
+EVENT(FSL_SGB_ALLOC,				227)
+EVENT(FSL_SGB_GATHER,				228)
+EVENT(FSL_SGB_OV,				229)
+EVENT(FSL_SGB_PROMO,				230)
+EVENT(FSL_SGB_IN_ORD_PROMO,			231)
+EVENT(FSL_SGB_OUT_ORD_PROMO,			232)
+EVENT(FSL_SGB_HI_PRI_PROMO,			233)
+EVENT(FSL_SGB_MISO_PROMO,			234)
+EVENT(FSL_SGB_WTMRK_PROMO,			235)
+EVENT(FSL_SGB_OV_PROMO,				236)
+EVENT(FSL_DLAQ_FUL_CYC,				237)
+EVENT(FSL_DLAQ_FUL_TIME,			238)
+EVENT(FSL_LRSAQ_FUL_CYC,			239)
+EVENT(FSL_LRSAQ_FUL_TIME,			240)
+EVENT(FSL_FWDAQ_FUL_CYC,			241)
+EVENT(FSL_FWDAQ_FUL_TIME,			242)
+EVENT(FSL_LD_MIS_LD_Q_FUL,			44)
+EVENT(FSL_LD_GUARD_MIS_TIME,			45)
+EVENT(FSL_TRANS_ST_FUL_ST_Q,			46)
+EVENT(FSL_LD_ON_ST_TIME,			47)
+EVENT(FSL_STQ_COLL_FWD,				243)
+EVENT(FSL_STQ_COLL_FWD_DATA_RDY,		244)
+EVENT(FSL_STQ_COLL_FW_TIME,			242)
+EVENT(FSL_STQ_COLL_FWD_TIME_DATA_NOT_RDY,	245)
+EVENT(FSL_STQ_COLL_NOT_FWD_TIME,		246)
+EVENT(FSL_STQ_COLL_FWD_CYC,			247)
+EVENT(FSL_STQ_COLL_FWD_CYC_DATA_RDY,		248)
+EVENT(FSL_STQ_COLL_FWD_CYC_DATA_NOT_RDY,	249)
+EVENT(FSL_STQ_COLL_NOT_FWD_CYC,			250)
+EVENT(FSL_FALSE_LD_ON_ST_COLL,			251)
+EVENT(FSL_DTLB_MIS_TIME,			48)
+EVENT(FSL_DTLB_BUSY_TIME,			49)
+EVENT(FSL_2ND_MISALIGN_1ST_MIS_TIME,		50)
+EVENT(FSL_LD_MIS_LD_Q_FULL,			52)
+EVENT(FSL_LD_GUARD_MIS_CYC,			53)
+EVENT(FSL_LS0_BUS_COLL,				252)
+EVENT(FSL_INTER_THRD_DB_WD_BANK_COLL,		253)
+EVENT(FSL_TRANS_ST_ST_Q_FULL_CYC,		54)
+EVENT(FSL_LD_ON_ST_CYC,				55)
+EVENT(FSL_DTLB_MIS_CYC,				56)
+EVENT(FSL_DTLB_BUSY_CYC,			57)
+EVENT(FSL_2ND_MISALIGN_1ST_MIS_CYC,		58)
+/* Fetch and Instruction Cache Events */
+EVENT(FSL_L1I_MIS,				254)
+EVENT(FSL_L1I_RELD,				60)
+EVENT(FSL_L1I_FET,				61)
+EVENT(FSL_FET_2X4_HIT,				35)
+EVENT(FSL_FET_HIT_ON_PREFET,			36)
+EVENT(FSL_FET_PREFET_GEN,			37)
+/* Instruction MMU, Data MMU and L2 MMU Events */
+EVENT(FSL_IMMU_TLB_4K_RELD,			62)
+EVENT(FSL_IMMU_VSP_RELD,			63)
+EVENT(FSL_IMMU_MIS,				256)
+EVENT(FSL_IMMU_TLB_4K_HIT,			257)
+EVENT(FSL_IMMU_VSP_HIT,				258)
+EVENT(FSL_IMMU_CYC_HW_TB_WALK,			259)
+EVENT(FSL_DMMU_TLB_4K_RELD,			64)
+EVENT(FSL_DMMU_VSP_RELD,			65)
+EVENT(FSL_DMMU_MIS,				260)
+EVENT(FSL_DMMU_TLB_4K_HIT,			261)
+EVENT(FSL_DMMU_VSO_HIT,				262)
+EVENT(FSL_DMMU_CYC_HW_TB_WALK,			263)
+EVENT(FSL_L2MMU_MIS,				264)
+EVENT(FSL_L2MMU_HIT_L2MMU_4K,			265)
+EVENT(FSL_L2MMU_HIT_L2MMU_VSP,			266)
+EVENT(FSL_L2MMU_ERR_MIS,			66)
+EVENT(FSL_L2MMU_INDIR_MIS,			267)
+EVENT(FSL_L2MMU_INDIR_VALID_MIS,		268)
+EVENT(FSL_LRAT_MIS,				269)
+/* Chaining Events */
+EVENT(FSL_PMC0_OV,				82)
+EVENT(FSL_PMC1_OV,				83)
+EVENT(FSL_PMC2_OV,				84)
+EVENT(FSL_PMC3_OV,				85)
+EVENT(FSL_PMC4_OV,				91)
+EVENT(FSL_PMC5_OV,				92)
+/* Interrupt Events */
+EVENT(FSL_INT_TKN,				86)
+EVENT(FSL_EXT_IN_INT_TKN,			87)
+EVENT(FSL_CRI_IN_INT_TKN,			88)
+EVENT(FSL_SYSCAL_TRAP_INT,			89)
+/* Misc Events */
+EVENT(FSL_TRANS_TBL_PMGC0_TBSEL,		90)
+/* L1 Stashing Events */
+EVENT(FSL_STASH_HIT_L1D,			97)
+EVENT(FSL_STASH_REQ_L1D,			99)
+/* Thread Events */
+EVENT(FSL_LSU_THRD_PRI_SWITCH_TIME,		100)
+EVENT(FSL_THRD_FPU_REQ_DENY_CYC,		101)
+EVENT(FSL_THRD_VPERM_REQ_DENY_CYC,		102)
+EVENT(FSL_THRD_VGEN_REQ_DENY_CYC,		103)
+EVENT(FSL_THRD_CFX_REQ_DENY_CYC,		104)
+EVENT(FSL_THRD_FET_REQ_DENY_CYC,		105)
+/* IAC and DAQ Events */
+EVENT(FSL_IAC1,					140)
+EVENT(FSL_IAC2,					141)
+EVENT(FSL_IAC3,					142)
+EVENT(FSL_IAC4,					143)
+EVENT(FSL_IAC5,					136)
+EVENT(FSL_IAC6,					137)
+EVENT(FSL_IAC7,					138)
+EVENT(FSL_IAC8,					139)
+EVENT(FSL_DAC1,					144)
+EVENT(FSL_DAC2,					145)
+/* DVT Events */
+EVENT(FSL_DVT0,					148)
+EVENT(FSL_DVT1,					149)
+EVENT(FSL_DVT2,					150)
+EVENT(FSL_DVT3,					151)
+EVENT(FSL_DVT4,					152)
+EVENT(FSL_DVT5,					153)
+EVENT(FSL_DVT6,					154)
+EVENT(FSL_DVT7,					155)
+EVENT(FSL_CMPL_CYC_STALL_NEXUS,			156)
+/* FPU Events */
+EVENT(FSL_FPU_FIN,				161)
+EVENT(FSL_FPU_DIV_CYC,				162)
+EVENT(FSL_FPU_DENORM_IN,			163)
+EVENT(FSL_FPU_DENORM_OUT,			164)
+EVENT(FSL_FPU_FPSCR_FULL_STALL,			165)
+EVENT(FSL_FPU_PIPE_SYNC_STALL,			166)
+EVENT(FSL_FPU_IN_DATA_STALL,			167)
+EVENT(FSL_INST_GEN_FLAG,			168)
+/* Power Management Events */
+EVENT(FSL_PW20,					172)
+/* Extended Load Store Events */
+EVENT(FSL_DECOR_LD,				176)
+EVENT(FSL_DECOR_ST,				177)
+EVENT(FSL_STCX_SUCCESS,				179)
+EVENT(FSL_STCX_NOT_SUCCESS,			180)
+EVENT(FSL_CYC_LMQ_LOSE_DLINK_ARB_SGB,		272)
+EVENT(FSL_CYC_SGB_LOSE_DLINK_ARB_LMQ,		273)
+EVENT(FSL_CYC_THRD_LOSE_DLINK_ARB_OTHER_THRD,	274)
+/* eLink Events */
+EVENT(FSL_DLINK_REQ,				443)
+EVENT(FSL_ILINK_REQ,				444)
+EVENT(FSL_RLINK_REQ,				445)
+EVENT(FSL_BLINK_REQ,				446)
+EVENT(FSL_CLINK_REQ,				447)
+/* Shared L2 Events */
+EVENT(FSL_L2_HIT,				456)
+EVENT(FSL_L2_MIS,				457)
+EVENT(FSL_L2_DEMAND_ACCESS,			458)
+EVENT(FSL_L2_ACCESS,				459)
+EVENT(FSL_L2_ST_ALLOC,				460)
+EVENT(FSL_L2I_ACCESS,				461)
+EVENT(FSL_L2D_ACCESS,				462)
+EVENT(FSL_L2I_MIS,				463)
+EVENT(FSL_L2D_MIS,				464)
+EVENT(FSL_L2_HIT_PER_THRD,			465)
+EVENT(FSL_L2_MIS_PER_THRD,			466)
+EVENT(FSL_L2_DEMAND_ACCESS_PER_THRD,		467)
+EVENT(FSL_L2_ST_ALLOC_PER_THRD,			468)
+EVENT(FSL_L2I_ACCESS_PER_THRD,			469)
+EVENT(FSL_L2D_ACCESS_PER_THRD,			470)
+EVENT(FSL_L2I_MIS_PER_THRD,			471)
+EVENT(FSL_L2D_MIS_PER_THRD,			472)
+EVENT(FSL_L2_RELD_CORENET,			473)
+EVENT(FSL_L2_STASH_REQ,				474)
+EVENT(FSL_L2_STASH_REQ_TO_SNOOP,		475)
+EVENT(FSL_L2_SNOOP_HIT,				476)
+EVENT(FSL_L2_SNOOP_MINT,			477)
+EVENT(FSL_L2_SNOOP_SINT,			478)
+EVENT(FSL_L2_SNOOP_PUSH,			479)
+EVENT(FSL_STALL_BIB_CYC,			480)
+EVENT(FSL_STALL_RLT_CYC,			482)
+EVENT(FSL_STALL_RLFQ_CYC,			484)
+EVENT(FSL_STALL_DTQ_CYC,			486)
+EVENT(FSL_STALL_COB_CYC,			488)
+EVENT(FSL_STALL_WDB_490,			490)
+EVENT(FSL_STALL_RLDB_CYC,			492)
+EVENT(FSL_STALL_SNPQ,				494)
+/* BIU Events */
+EVENT(FSL_BIU_MASTER_REQ,			506)
+EVENT(FSL_BIU_MASTER_GLOBAL_REQ,		507)
+EVENT(FSL_BIU_MASTER_DATA_REQ,			508)
+EVENT(FSL_BIU_MASTER_INST_REQ,			509)
+EVENT(FSL_STASH_REQ,				510)
+EVENT(FSL_SNOOP_REQ,				511)
diff --git a/arch/powerpc/perf/e6500-pmu.c b/arch/powerpc/perf/e6500-pmu.c
index 3d877aa..abaa6d7 100644
--- a/arch/powerpc/perf/e6500-pmu.c
+++ b/arch/powerpc/perf/e6500-pmu.c
@@ -17,16 +17,23 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 
+#define EVENT(_name, _code) \
+	PME_##_name = _code,
+enum {
+#include "e6500-events-list.h"
+};
+#undef EVENT
+
 /*
  * Map of generic hardware event types to hardware events
  * Zero if unsupported
  */
 static int e6500_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = 1,
-	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
-	[PERF_COUNT_HW_CACHE_MISSES] = 221,
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 12,
-	[PERF_COUNT_HW_BRANCH_MISSES] = 15,
+	[PERF_COUNT_HW_CPU_CYCLES] =		PME_FSL_CYC,
+	[PERF_COUNT_HW_INSTRUCTIONS] =		PME_FSL_INST_CMPL,
+	[PERF_COUNT_HW_CACHE_MISSES] =		PME_FSL_L1D_MIS,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =	PME_FSL_BR_FIN,
+	[PERF_COUNT_HW_BRANCH_MISSES] =		PME_FSL_BR_MPRED,
 };
 
 #define C(x)	PERF_COUNT_HW_CACHE_##x
@@ -99,11 +106,44 @@ static u64 e6500_xlate_event(u64 event_id)
 	return FSL_EMB_EVENT_VALID;
 }
 
+GENERIC_EVENT_ATTR(cycles,		FSL_CYC);
+GENERIC_EVENT_ATTR(instructions,	FSL_INST_CMPL);
+GENERIC_EVENT_ATTR(cache-misses,	FSL_L1D_MIS);
+GENERIC_EVENT_ATTR(branch-instructions,	FSL_BR_FIN);
+GENERIC_EVENT_ATTR(branch-misses,	FSL_BR_MPRED);
+#define EVENT(_name, _code)	FSL_EMB_EVENT_ATTR(_name, _name);
+#include "e6500-events-list.h"
+#undef EVENT
+
+#define EVENT(_name, _code)	FSL_EMB_EVENT_PTR(_name),
+
+static struct attribute *e6500_events_attr[] = {
+	GENERIC_EVENT_PTR(FSL_CYC),
+	GENERIC_EVENT_PTR(FSL_INST_CMPL),
+	GENERIC_EVENT_PTR(FSL_L1D_MIS),
+	GENERIC_EVENT_PTR(FSL_BR_FIN),
+	GENERIC_EVENT_PTR(FSL_BR_MPRED),
+	#include "e6500-events-list.h"
+	#undef EVENT
+	NULL,
+};
+
+static struct attribute_group e6500_pmu_events_group = {
+	.name = "events",
+	.attrs = e6500_events_attr,
+};
+
+static const struct attribute_group *e6500_pmu_attr_groups[] = {
+	&e6500_pmu_events_group,
+	NULL,
+};
+
 static struct fsl_emb_pmu e6500_pmu = {
 	.name			= "e6500 family",
 	.n_counter		= 6,
 	.n_restricted		= 0,
 	.xlate_event		= e6500_xlate_event,
+	.attr_groups            = e6500_pmu_attr_groups,
 	.n_generic		= ARRAY_SIZE(e6500_generic_events),
 	.generic_events		= e6500_generic_events,
 	.cache_events		= &e6500_cache_events,
-- 
1.9.1
