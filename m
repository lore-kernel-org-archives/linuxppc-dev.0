Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcGf61RlTzDqZH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:45:34 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26ASsmB058500
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 05:45:21 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28ytm4ruyx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 05:45:20 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 20:45:18 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4B26E3578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:45:16 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26Aj8hZ32637106
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:45:16 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26AigTk031082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:44:43 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 Daniel Axtens <dja@axtens.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v2 3/6] powerpc/perf: Support to export MMCRA[TEC*] field to
 userspace
Date: Mon,  6 Mar 2017 16:13:10 +0530
In-Reply-To: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1488796993-25495-4-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Threshold feature when used with MMCRA [Threshold Event Counter Event],
MMCRA[Threshold Start event] and MMCRA[Threshold End event] will update
MMCRA[Threashold Event Counter Exponent] and MMCRA[Threshold Event
Counter Multiplier] with the corresponding threshold event count values.
Patch to export MMCRA[TECX/TECM] to userspace in 'weight' field of
struct perf_sample_data.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |  1 +
 arch/powerpc/perf/core-book3s.c              |  4 ++++
 arch/powerpc/perf/isa207-common.c            |  8 ++++++++
 arch/powerpc/perf/isa207-common.h            | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 446cdcd9b7f5..723bf48e7494 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -40,6 +40,7 @@ struct power_pmu {
 				u64 alt[]);
 	void		(*get_mem_data_src)(union perf_mem_data_src *dsrc,
 				u32 flags, struct pt_regs *regs);
+	void		(*get_mem_weight)(u64 *weight);
 	u64             (*bhrb_filter_map)(u64 branch_sample_type);
 	void            (*config_bhrb)(u64 pmu_bhrb_filter);
 	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index d644c5ab4d2f..a6b265e31663 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2051,6 +2051,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 						ppmu->get_mem_data_src)
 			ppmu->get_mem_data_src(&data.data_src, ppmu->flags, regs);
 
+		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT &&
+						ppmu->get_mem_weight)
+			ppmu->get_mem_weight(&data.weight);
+
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
 	}
diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 08bb62454a2e..42e999da934e 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -196,6 +196,14 @@ void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
 	}
 }
 
+void isa207_get_mem_weight(u64 *weight)
+{
+	u64 mmcra = mfspr(SPRN_MMCRA);
+	u64 exp = MMCRA_THR_CTR_EXP(mmcra);
+	u64 mantissa = MMCRA_THR_CTR_MANT(mmcra);
+
+	*weight = mantissa << (2 * exp);
+}
 
 int isa207_get_constraint(u64 event, unsigned long *maskp, unsigned long *valp)
 {
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 982542cce991..b4d02ae3a6e0 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -247,6 +247,15 @@
 #define MMCRA_SDAR_MODE_SHIFT		42
 #define MMCRA_SDAR_MODE_TLB		(1ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_IFM_SHIFT			30
+#define MMCRA_THR_CTR_MANT_SHIFT	19
+#define MMCRA_THR_CTR_MANT_MASK		0x7Ful
+#define MMCRA_THR_CTR_MANT(v)		(((v) >> MMCRA_THR_CTR_MANT_SHIFT) &\
+						MMCRA_THR_CTR_MANT_MASK)
+
+#define MMCRA_THR_CTR_EXP_SHIFT		27
+#define MMCRA_THR_CTR_EXP_MASK		0x7ul
+#define MMCRA_THR_CTR_EXP(v)		(((v) >> MMCRA_THR_CTR_EXP_SHIFT) &\
+						MMCRA_THR_CTR_EXP_MASK)
 
 /* MMCR1 Threshold Compare bit constant for power9 */
 #define p9_MMCRA_THR_CMP_SHIFT	45
@@ -281,5 +290,6 @@ int isa207_get_alternatives(u64 event, u64 alt[],
 				const unsigned int ev_alt[][MAX_ALT], int size);
 void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
 							struct pt_regs *regs);
+void isa207_get_mem_weight(u64 *weight);
 
 #endif
-- 
2.7.4
