Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B2CFE2C00C3
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 16:54:07 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 16 Oct 2013 11:24:03 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id B5FC3394003F
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:23:41 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9G5ulbb20840642
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:26:47 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9G5rxxX002203
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Oct 2013 11:23:59 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] power8,
 perf: Export raw event codes through sysfs interface
Date: Wed, 16 Oct 2013 11:23:00 +0530
Message-Id: <1381902780-2719-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, sukadev@linux.vnet.ibm.com, michaele@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch exports a set of POWER8 PMU raw event codes through
sysfs interface. Right now the raw event set matches the entire
set of POWER8 events found in libpfm4 library.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-events-list.h | 146 +++++++++++++++++++++++++++++++++
 arch/powerpc/perf/power8-pmu.c         |  30 +++++++
 2 files changed, 176 insertions(+)
 create mode 100644 arch/powerpc/perf/power8-events-list.h

diff --git a/arch/powerpc/perf/power8-events-list.h b/arch/powerpc/perf/power8-events-list.h
new file mode 100644
index 0000000..ee5b40e
--- /dev/null
+++ b/arch/powerpc/perf/power8-events-list.h
@@ -0,0 +1,146 @@
+/*
+ * Performance counter support for POWER8 processors.
+ *
+ * Copyright 2013 Anshuman Khandual, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+EVENT(PM_1PLUS_PPC_CMPL,                      0x04898)
+EVENT(PM_1PLUS_PPC_DISP,                      0x400f2)
+EVENT(PM_ANY_THRD_RUN_CYC,                    0x100fa)
+EVENT(PM_BR_TAKEN_CMPL,                       0x200fa)
+EVENT(PM_DATA_FROM_L2MISS,                    0x200fe)
+EVENT(PM_DATA_FROM_L3MISS,                    0x300fe)
+EVENT(PM_DATA_FROM_MEM,                       0x400fe)
+EVENT(PM_DTLB_MISS,                           0x300fc)
+EVENT(PM_EXT_INT,                             0x200f8)
+EVENT(PM_FLOP,                                0x100f4)
+EVENT(PM_FLUSH,                               0x400f8)
+EVENT(PM_IERAT_MISS,                          0x100f6)
+EVENT(PM_INST_DISP,                           0x200f2)
+EVENT(PM_INST_FROM_L3MISS,                    0x300fa)
+EVENT(PM_ITLB_MISS,                           0x400fc)
+EVENT(PM_L1_DCACHE_RELOAD_VALID,              0x300f6)
+EVENT(PM_L1_ICACHE_MISS,                      0x200fc)
+EVENT(PM_LD_MISS_L1,                          0x400f0)
+EVENT(PM_LSU_DERAT_MISS,                      0x200f6)
+EVENT(PM_MRK_BR_MPRED_CMPL,                   0x300e4)
+EVENT(PM_MRK_BR_TAKEN_CMPL,                   0x100e2)
+EVENT(PM_MRK_DATA_FROM_L2MISS,                0x400e8)
+EVENT(PM_MRK_DATA_FROM_L3MISS,                0x200e4)
+EVENT(PM_MRK_DATA_FROM_MEM,                   0x200e0)
+EVENT(PM_MRK_DERAT_MISS,                      0x300e6)
+EVENT(PM_MRK_DTLB_MISS,                       0x400e4)
+EVENT(PM_MRK_INST_CMPL,                       0x400e0)
+EVENT(PM_MRK_INST_DISP,                       0x100e0)
+EVENT(PM_MRK_INST_FROM_L3MISS,                0x400e6)
+EVENT(PM_MRK_L1_ICACHE_MISS,                  0x100e4)
+EVENT(PM_MRK_L1_RELOAD_VALID,                 0x100ea)
+EVENT(PM_MRK_LD_MISS_L1,                      0x200e2)
+EVENT(PM_MRK_ST_CMPL,                         0x300e2)
+EVENT(PM_RUN_CYC,                             0x600f4)
+EVENT(PM_RUN_INST_CMPL,                       0x500fa)
+EVENT(PM_RUN_PURR,                            0x400f4)
+EVENT(PM_ST_FIN,                              0x200f0)
+EVENT(PM_ST_MISS_L1,                          0x300f0)
+EVENT(PM_TB_BIT_TRANS,                        0x300f8)
+EVENT(PM_THRD_CONC_RUN_INST,                  0x300f4)
+EVENT(PM_THRESH_EXC_1024,                     0x300ea)
+EVENT(PM_THRESH_EXC_128,                      0x400ea)
+EVENT(PM_THRESH_EXC_2048,                     0x400ec)
+EVENT(PM_THRESH_EXC_256,                      0x100e8)
+EVENT(PM_THRESH_EXC_32,                       0x200e6)
+EVENT(PM_THRESH_EXC_4096,                     0x100e6)
+EVENT(PM_THRESH_EXC_512,                      0x200e8)
+EVENT(PM_THRESH_EXC_64,                       0x300e8)
+EVENT(PM_THRESH_MET,                          0x100ec)
+EVENT(PM_BR_2PATH,                            0x40036)
+EVENT(PM_BR_CMPL,                             0x40060)
+EVENT(PM_BR_MRK_2PATH,                        0x40138)
+EVENT(PM_CMPLU_STALL_BRU,                     0x4d018)
+EVENT(PM_CMPLU_STALL_BRU_CRU,                 0x2d018)
+EVENT(PM_CMPLU_STALL_COQ_FULL,                0x30026)
+EVENT(PM_CMPLU_STALL_DCACHE_MISS,             0x2c012)
+EVENT(PM_CMPLU_STALL_DMISS_L21_L31,           0x2c018)
+EVENT(PM_CMPLU_STALL_DMISS_L2L3,              0x2c016)
+EVENT(PM_CMPLU_STALL_DMISS_L2L3_CONFLICT,     0x4c016)
+EVENT(PM_CMPLU_STALL_DMISS_L3MISS,            0x4c01a)
+EVENT(PM_CMPLU_STALL_DMISS_LMEM,              0x4c018)
+EVENT(PM_CMPLU_STALL_DMISS_REMOTE,            0x2c01c)
+EVENT(PM_CMPLU_STALL_ERAT_MISS,               0x4c012)
+EVENT(PM_CMPLU_STALL_FLUSH,                   0x30038)
+EVENT(PM_CMPLU_STALL_FXLONG,                  0x4d016)
+EVENT(PM_CMPLU_STALL_FXU,                     0x2d016)
+EVENT(PM_CMPLU_STALL_HWSYNC,                  0x30036)
+EVENT(PM_CMPLU_STALL_LOAD_FINISH,             0x4d014)
+EVENT(PM_CMPLU_STALL_LSU,                     0x2c010)
+EVENT(PM_CMPLU_STALL_LWSYNC,                  0x10036)
+EVENT(PM_CMPLU_STALL_MEM_ECC_DELAY,           0x30028)
+EVENT(PM_CMPLU_STALL_NTCG_FLUSH,              0x2e01e)
+EVENT(PM_CMPLU_STALL_OTHER_CMPL,              0x30006)
+EVENT(PM_CMPLU_STALL_REJECT,                  0x4c010)
+EVENT(PM_CMPLU_STALL_REJECT_LHS,              0x2c01a)
+EVENT(PM_CMPLU_STALL_REJ_LMQ_FULL,            0x4c014)
+EVENT(PM_CMPLU_STALL_SCALAR,                  0x4d010)
+EVENT(PM_CMPLU_STALL_SCALAR_LONG,             0x2d010)
+EVENT(PM_CMPLU_STALL_STORE,                   0x2c014)
+EVENT(PM_CMPLU_STALL_ST_FWD,                  0x4c01c)
+EVENT(PM_CMPLU_STALL_THRD,                    0x1001c)
+EVENT(PM_CMPLU_STALL_VECTOR,                  0x2d014)
+EVENT(PM_CMPLU_STALL_VECTOR_LONG,             0x4d012)
+EVENT(PM_CMPLU_STALL_VSU,                     0x2d012)
+EVENT(PM_DATA_FROM_L2,                        0x1c042)
+EVENT(PM_DATA_FROM_L2_NO_CONFLICT,            0x1c040)
+EVENT(PM_DATA_FROM_L3,                        0x4c042)
+EVENT(PM_DATA_FROM_L3MISS_MOD,                0x4c04e)
+EVENT(PM_DATA_FROM_L3_NO_CONFLICT,            0x1c044)
+EVENT(PM_DATA_FROM_LMEM,                      0x2c048)
+EVENT(PM_DATA_FROM_MEMORY,                    0x2c04c)
+EVENT(PM_DC_PREF_STREAM_STRIDED_CONF,         0x3e050)
+EVENT(PM_GCT_NOSLOT_BR_MPRED,                 0x4d01e)
+EVENT(PM_GCT_NOSLOT_BR_MPRED_ICMISS,          0x4d01a)
+EVENT(PM_GCT_NOSLOT_DISP_HELD_ISSQ,           0x2d01e)
+EVENT(PM_GCT_NOSLOT_DISP_HELD_OTHER,          0x2e010)
+EVENT(PM_GCT_NOSLOT_DISP_HELD_SRQ,            0x2d01c)
+EVENT(PM_GCT_NOSLOT_IC_L3MISS,                0x4e010)
+EVENT(PM_GCT_NOSLOT_IC_MISS,                  0x2d01a)
+EVENT(PM_GRP_DISP,                            0x3000a)
+EVENT(PM_GRP_MRK,                             0x10130)
+EVENT(PM_HV_CYC,                              0x2000a)
+EVENT(PM_IOPS_CMPL,                           0x10014)
+EVENT(PM_LD_CMPL,                             0x1002e)
+EVENT(PM_LD_L3MISS_PEND_CYC,                  0x10062)
+EVENT(PM_MRK_DATA_FROM_L2,                    0x1d142)
+EVENT(PM_MRK_DATA_FROM_L2MISS_CYC,            0x4c12e)
+EVENT(PM_MRK_DATA_FROM_L2_CYC,                0x4c122)
+EVENT(PM_MRK_DATA_FROM_L2_NO_CONFLICT,        0x1d140)
+EVENT(PM_MRK_DATA_FROM_L2_NO_CONFLICT_CYC,    0x4c120)
+EVENT(PM_MRK_DATA_FROM_L3,                    0x4d142)
+EVENT(PM_MRK_DATA_FROM_L3MISS_CYC,            0x2d12e)
+EVENT(PM_MRK_DATA_FROM_L3_CYC,                0x2d122)
+EVENT(PM_MRK_DATA_FROM_L3_NO_CONFLICT,        0x1d144)
+EVENT(PM_MRK_DATA_FROM_L3_NO_CONFLICT_CYC,    0x4c124)
+EVENT(PM_MRK_DATA_FROM_LL4,                   0x1d14c)
+EVENT(PM_MRK_DATA_FROM_LL4_CYC,               0x4c12c)
+EVENT(PM_MRK_DATA_FROM_LMEM,                  0x2d148)
+EVENT(PM_MRK_DATA_FROM_LMEM_CYC,              0x4d128)
+EVENT(PM_MRK_DATA_FROM_MEMORY,                0x2d14c)
+EVENT(PM_MRK_DATA_FROM_MEMORY_CYC,            0x4d12c)
+EVENT(PM_MRK_GRP_CMPL,                        0x40130)
+EVENT(PM_MRK_INST_DECODED,                    0x20130)
+EVENT(PM_MRK_L2_RC_DISP,                      0x20114)
+EVENT(PM_MRK_LD_MISS_L1_CYC,                  0x4013e)
+EVENT(PM_MRK_STALL_CMPLU_CYC,                 0x3013e)
+EVENT(PM_NEST_REF_CLK,                        0x3006e)
+EVENT(PM_PMC1_OVERFLOW,                       0x20010)
+EVENT(PM_PMC2_OVERFLOW,                       0x30010)
+EVENT(PM_PMC3_OVERFLOW,                       0x40010)
+EVENT(PM_PMC4_OVERFLOW,                       0x10010)
+EVENT(PM_PMC6_OVERFLOW,                       0x30024)
+EVENT(PM_PPC_CMPL,                            0x40002)
+EVENT(PM_THRD_ALL_RUN_CYC,                    0x2000c)
+EVENT(PM_THRESH_NOT_MET,                      0x4016e)
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index a3f7abd..6897cc3 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -25,6 +25,16 @@
 #define PM_BRU_FIN			0x10068
 #define PM_BR_MPRED_CMPL		0x400f6
 
+/*
+ * Power8 event codes.
+ */
+#define EVENT(_name, _code) \
+	PME_##_name = _code,
+enum {
+	#include "power8-events-list.h"
+};
+#undef EVENT
+
 
 /*
  * Raw event encoding for POWER8:
@@ -540,6 +550,25 @@ static struct attribute *power8_pmu_format_attr[] = {
 	NULL,
 };
 
+
+#define EVENT(_name, _code)     POWER_EVENT_ATTR(_name, _name);
+#include "power8-events-list.h"
+#undef EVENT
+
+#define EVENT(_name, _code)     POWER_EVENT_PTR(_name),
+
+static struct attribute *power8_events_attr[] = {
+        #include "power8-events-list.h"
+        #undef EVENT
+        NULL
+};
+
+
+static struct attribute_group power8_pmu_events_group = {
+        .name = "events",
+        .attrs = power8_events_attr,
+};
+
 struct attribute_group power8_pmu_format_group = {
 	.name = "format",
 	.attrs = power8_pmu_format_attr,
@@ -547,6 +576,7 @@ struct attribute_group power8_pmu_format_group = {
 
 static const struct attribute_group *power8_pmu_attr_groups[] = {
 	&power8_pmu_format_group,
+	&power8_pmu_events_group,
 	NULL,
 };
 
-- 
1.7.11.7
