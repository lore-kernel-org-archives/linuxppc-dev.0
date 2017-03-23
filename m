Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpX5m0Vm6zDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 14:26:35 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2N3OOKh042183
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 23:26:23 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29bv4j35er-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 23:26:23 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Mar 2017 08:56:20 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2N3QJMt6750324
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 08:56:19 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2N3QEIX006406
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 08:56:18 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 Daniel Axtens <dja@axtens.net>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 3/6] powerpc/perf: Support to export MMCRA[TEC*] field to
 userspace
Date: Thu, 23 Mar 2017 08:56:05 +0530
In-Reply-To: <1490239568-30429-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1490239568-30429-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1490239568-30429-4-git-send-email-maddy@linux.vnet.ibm.com>
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
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
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
index e241ebebab6f..6c2d4168daec 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2053,6 +2053,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
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
index 41cc053ee692..292f6a242bb4 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -227,6 +227,14 @@ void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
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
index 592aa0917cf3..23e0516df4a4 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -248,6 +248,15 @@
 #define MMCRA_SDAR_MODE_TLB		(1ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_SDAR_MODE_NO_UPDATES	~(0x3ull << MMCRA_SDAR_MODE_SHIFT)
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
@@ -282,5 +291,6 @@ int isa207_get_alternatives(u64 event, u64 alt[],
 				const unsigned int ev_alt[][MAX_ALT], int size);
 void isa207_get_mem_data_src(union perf_mem_data_src *dsrc, u32 flags,
 							struct pt_regs *regs);
+void isa207_get_mem_weight(u64 *weight);
 
 #endif
-- 
2.7.4
