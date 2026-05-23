Return-Path: <linuxppc-dev+bounces-21434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AF7CD5BB8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 17:41:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN8ZL65gGz3bpJ;
	Sun, 24 May 2026 03:40:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779558058;
	cv=none; b=FGGK2oJqze8yICFtKSijkrNrvAuK/D2zgqpFSo5gPY1Ktv3dOpdImLyLZJkeNd1BTi8Tlv29c/uGm3sdWZ5seLDhhTQd8y6zGAnT4WSykvKywiz0EanVV3Y4EKkozWOzOT1pnIShIXpPC1b5XfPD9VkMW1w8mpzasjrlI43NhHlTjg7sXcxZTU9juIhlu/GBj0AUNQFq4p+1er9kXdVi5b22oESOtp3FK7qi76ewPBOJn1BbeQEG/ggzx2Orv+0Z9IyctuRvfGnHjTMvlNrVzZlWjIELxEiDMUwruavLyjgFf1PsZfCFtmixhVPI2wDEDFoj0Le+yasN9HWMxlQ4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779558058; c=relaxed/relaxed;
	bh=U26ljf0vw4RAPiu2ZYO2s1FROKl1S18MXj3Ka8MPkjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V11GTWVmVBTNX9XeGmbCh/DkZRpqOlVxPBY89qPznZBOKSHThlK3wHwUyXyHyHZSOXkcU0m2j6qUxGQAjjokiBbaEd7k7xm8cE1FqroBW5v8TvY+OXTGv0Mou91NyLgFm/D9AxUo3Kv/Y1Twq/NvhdndmiASLZ5xOjvkCa3hytBW1DUh1E9JfT/IocfRK89KAG8RiGT7eosqxGxeppWy2vwbMLMj7FeyA3qSQ5byNylOE/4hCb6zwma82xPpTI5nyF+QGzOXB1PTBsXrdm0cuBjqlhejPIsYp0OxcCvf4cbfyD0btGYejBdx7hYNTVPFJtofIVBxxM75aeKMOC1NtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RKk6ElGQ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RKk6ElGQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN8ZK4HtRz3bs0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 03:40:57 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N5EIhh1015074;
	Sat, 23 May 2026 17:40:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=U26ljf0vw4RAPiu2Z
	YO2s1FROKl1S18MXj3Ka8MPkjM=; b=RKk6ElGQK2uAHs9NSVfRqGPPrmh/rmqWX
	j+k+hlcsadPloOW9mYapyYLBhyy+kOwNnNtQYFZZFkgemJnZhuFC03xaRsKTyREh
	sXB+lEXrbaSgxhkNRHR4fuCb1M40IomS8Lj9XmJYhWlJ463J1ejOSbAdAVJ3W0f5
	f1kyUH2ue7fKF6B3uwVsSvcsL2hzvlf+af08/4hrpJlcLAzAEAtxQkRiPm3IeHMf
	cb2wiSZSHv9FYW57HS10n5dSrnG8eE+5O5+0n02jZImGY/qbj9f52hgJvj8vwOf2
	3z6I7VB1AZRi8TBFvwN3d+WVvbKtX4rkZb+EyvpE6oyFBhIpWYgUQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s21pnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 17:40:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NHd5Ta026008;
	Sat, 23 May 2026 17:40:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eb46nhyas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 17:40:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64NHefPb56492312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 17:40:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A07E20043;
	Sat, 23 May 2026 17:40:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B66EC20040;
	Sat, 23 May 2026 17:40:39 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.18.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 23 May 2026 17:40:39 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] powerpc/irq: Make irqstats array based
Date: Sat, 23 May 2026 23:10:15 +0530
Message-ID: <20260523174016.999456-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260523174016.999456-1-sshegde@linux.ibm.com>
References: <20260523174016.999456-1-sshegde@linux.ibm.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rjvz7_ANmWO5yh2KoXZBAMmSQrWQEZNw
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a11e69e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Nt6gJGhAC5hH5tf_ggoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE4MCBTYWx0ZWRfX/p+pVFfKMlu5
 3CsjgEN7JKd1yjdiRCe+qY/egSg9YcnQlb+CIKTrZk/NaJPcvAUhnIKNTeBZ8bZhB0hKmGAZM+F
 eGK7soxf9QROmKKnqQhKpi20yptlkB67nUn/J1DFzgnuDCuPJF6xethAt+W0kX1ngXXeHTa/loq
 WYFD75k18FCaWEACAPeZWxw+sop+poC1J9Kdv2EQBs1Ip30sB/+wUrBSxzoUUVY2QBWvmwtHNZq
 hRMeM/Ph+PsReztkD/PcyqhuZJw3JF++SZxOOf3EaggKp4q0Drfe+aTeN0AXsR+3pLgolGeW7Hq
 HiRWw660Iyh1Sm9P1DbOLgDOLYo45wyuy0s3yHyIsv0i0+fQ4J4hs9A/oujQOpbce2VqPOz2hjU
 uGqgndANzoFLbfGjT9zJK6fNaVvQjSRwEhQA/97Js8B1TxUqsd8kw+drGKTsU8Qlg/LZQ8AKerN
 xasiby7m//YRxlGn6UQ==
X-Proofpoint-ORIG-GUID: rjvz7_ANmWO5yh2KoXZBAMmSQrWQEZNw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230180

Current irq_cpustat_t has separate member for handling each arch
specific interrupt type. The same can be achieved with array instead
indexed by corresponding irq counter type.

This helps to,

- Make it easy to integrate into genirq improvements by calling 
  genirq provided irq_proc_emit_counts. That speeds up quite a bit
  by printing all 0's once as much as possible.

- Adding a new vector or software counter only requires to update the table
  and everything just works

- Remove ifdef usage a bit.

- Instead of going through each member, it simply becomes an array
  traversal.

Time taken to read /proc/interrupts 1000 times.
Base and v6 details can be found in cover-letter.
Base		:  103us
v6		:   63us
v6+this_patch	:   57us

A Decent 10% reduction can be seen in a system 240 CPUs. As the system
size increases the gain would be more as emitting 0 would reduce more
and more. 

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/hardirq.h |  27 +++++---
 arch/powerpc/kernel/dbell.c        |   2 +-
 arch/powerpc/kernel/irq.c          | 107 ++++++++++-------------------
 arch/powerpc/kernel/time.c         |   6 +-
 arch/powerpc/kernel/traps.c        |  11 ++-
 arch/powerpc/kernel/watchdog.c     |   2 +-
 6 files changed, 64 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index bf3926a0c69c..38098e35b241 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -5,26 +5,33 @@
 #include <linux/threads.h>
 #include <linux/irq.h>
 
-typedef struct {
-	unsigned int timer_irqs_event;
-	unsigned int broadcast_irqs_event;
-	unsigned int timer_irqs_others;
-	unsigned int pmu_irqs;
-	unsigned int mce_exceptions;
-	unsigned int spurious_irqs;
-	unsigned int sreset_irqs;
+enum irq_stat_counts {
+	IRQ_COUNT_LOC_TIMER,
+	IRQ_COUNT_BCT_TIMER,
+	IRQ_COUNT_OTHER_TIMER,
+	IRQ_COUNT_SPURIOUS,
+	IRQ_COUNT_PMI,
+	IRQ_COUNT_MCE,
+	IRQ_COUNT_NMI_SRESET,
 #ifdef CONFIG_PPC_WATCHDOG
-	unsigned int soft_nmi_irqs;
+	IRQ_COUNT_WATCHDOG,
 #endif
 #ifdef CONFIG_PPC_DOORBELL
-	unsigned int doorbell_irqs;
+	IRQ_COUNT_DOORBELL,
 #endif
+	IRQ_COUNT_MAX,
+};
+
+typedef struct {
+	unsigned int counts[IRQ_COUNT_MAX];
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 DECLARE_PER_CPU(unsigned int, __softirq_pending);
 #define local_softirq_pending_ref       __softirq_pending
 
+#define inc_irq_stat(index)	__this_cpu_inc(irq_stat.counts[IRQ_COUNT_##index])
+
 #define __ARCH_IRQ_STAT
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
 
diff --git a/arch/powerpc/kernel/dbell.c b/arch/powerpc/kernel/dbell.c
index 5712dd846263..f5e298a4c4c0 100644
--- a/arch/powerpc/kernel/dbell.c
+++ b/arch/powerpc/kernel/dbell.c
@@ -31,7 +31,7 @@ DEFINE_INTERRUPT_HANDLER_ASYNC(doorbell_exception)
 		do_hard_irq_enable();
 
 	kvmppc_clear_host_ipi(smp_processor_id());
-	__this_cpu_inc(irq_stat.doorbell_irqs);
+	inc_irq_stat(DOORBELL);
 
 	smp_ipi_demux_relaxed(); /* already performed the barrier */
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f33df5e5c23f..e67a18f62142 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -84,79 +84,57 @@ u32 tau_interrupts(unsigned long cpu);
 #endif
 #endif /* CONFIG_PPC32 */
 
+struct irq_stat_info {
+	const char	*symbol;
+	const char	*text;
+};
+
+#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt}
+
+static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
+	ISE(LOC_TIMER,		"LOC", "  Local timer interrupts for timer event device\n"),
+	ISE(BCT_TIMER,		"BCT", "  Broadcast timer interrupts for timer event device\n"),
+	ISE(OTHER_TIMER,	"LOC", "  Local timer interrupts for others\n"),
+	ISE(SPURIOUS,		"SPU", "  Spurious interrupts\n"),
+	ISE(PMI,		"PMI", "  Performance monitoring interrupts\n"),
+	ISE(MCE,		"MCE", "  Machine check exceptions\n"),
+	ISE(NMI_SRESET,		"NMI", "  System Reset interrupts\n"),
+#ifdef CONFIG_PPC_WATCHDOG
+	ISE(WATCHDOG,		"WDG", "  Watchdog soft-NMI interrupts\n"),
+#endif
+#ifdef CONFIG_PPC_DOORBELL
+	ISE(DOORBELL,		"DBL", "  Doorbell interrupts\n"),
+#endif
+};
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
-	int j;
+	const struct irq_stat_info *info = irq_stat_info;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++, info++) {
+		seq_printf(p, "%*s:", prec, info->symbol);
+		irq_proc_emit_counts(p, &irq_stat.counts[i]);
+		seq_puts(p, info->text);
+	}
 
 #if defined(CONFIG_PPC32) && defined(CONFIG_TAU_INT)
 	if (tau_initialized) {
+		int j;
 		seq_printf(p, "%*s:", prec, "TAU");
 		for_each_online_cpu(j)
 			seq_put_decimal_ull_width(p, " ", tau_interrupts(j), 10);
 		seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
 	}
 #endif /* CONFIG_PPC32 && CONFIG_TAU_INT */
-
-	seq_printf(p, "%*s:", prec, "LOC");
-	for_each_online_cpu(j)
-		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).timer_irqs_event, 10);
-        seq_printf(p, "  Local timer interrupts for timer event device\n");
-
-	seq_printf(p, "%*s:", prec, "BCT");
-	for_each_online_cpu(j)
-		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).broadcast_irqs_event, 10);
-	seq_printf(p, "  Broadcast timer interrupts for timer event device\n");
-
-	seq_printf(p, "%*s:", prec, "LOC");
-	for_each_online_cpu(j)
-		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).timer_irqs_others, 10);
-        seq_printf(p, "  Local timer interrupts for others\n");
-
-	seq_printf(p, "%*s:", prec, "SPU");
-	for_each_online_cpu(j)
-		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).spurious_irqs, 10);
-	seq_printf(p, "  Spurious interrupts\n");
-
-	seq_printf(p, "%*s:", prec, "PMI");
-	for_each_online_cpu(j)
-		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).pmu_irqs, 10);
-	seq_printf(p, "  Performance monitoring interrupts\n");
-
-	seq_printf(p, "%*s:", prec, "MCE");
-	for_each_online_cpu(j)
-		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).mce_exceptions, 10);
-	seq_printf(p, "  Machine check exceptions\n");
-
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (cpu_has_feature(CPU_FTR_HVMODE)) {
+		int j;
 		seq_printf(p, "%*s:", prec, "HMI");
 		for_each_online_cpu(j)
 			seq_put_decimal_ull_width(p, " ", paca_ptrs[j]->hmi_irqs, 10);
 		seq_printf(p, "  Hypervisor Maintenance Interrupts\n");
 	}
 #endif
-
-	seq_printf(p, "%*s:", prec, "NMI");
-	for_each_online_cpu(j)
-		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).sreset_irqs, 10);
-	seq_printf(p, "  System Reset interrupts\n");
-
-#ifdef CONFIG_PPC_WATCHDOG
-	seq_printf(p, "%*s:", prec, "WDG");
-	for_each_online_cpu(j)
-		seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).soft_nmi_irqs, 10);
-	seq_printf(p, "  Watchdog soft-NMI interrupts\n");
-#endif
-
-#ifdef CONFIG_PPC_DOORBELL
-	if (cpu_has_feature(CPU_FTR_DBELL)) {
-		seq_printf(p, "%*s:", prec, "DBL");
-		for_each_online_cpu(j)
-			seq_put_decimal_ull_width(p, " ", per_cpu(irq_stat, j).doorbell_irqs, 10);
-		seq_printf(p, "  Doorbell interrupts\n");
-	}
-#endif
-
 	return 0;
 }
 
@@ -165,24 +143,15 @@ int arch_show_interrupts(struct seq_file *p, int prec)
  */
 u64 arch_irq_stat_cpu(unsigned int cpu)
 {
-	u64 sum = per_cpu(irq_stat, cpu).timer_irqs_event;
+	irq_cpustat_t *p = per_cpu_ptr(&irq_stat, cpu);
+	u64 sum = 0;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++)
+		sum += p->counts[i];
 
-	sum += per_cpu(irq_stat, cpu).broadcast_irqs_event;
-	sum += per_cpu(irq_stat, cpu).pmu_irqs;
-	sum += per_cpu(irq_stat, cpu).mce_exceptions;
-	sum += per_cpu(irq_stat, cpu).spurious_irqs;
-	sum += per_cpu(irq_stat, cpu).timer_irqs_others;
 #ifdef CONFIG_PPC_BOOK3S_64
 	sum += paca_ptrs[cpu]->hmi_irqs;
 #endif
-	sum += per_cpu(irq_stat, cpu).sreset_irqs;
-#ifdef CONFIG_PPC_WATCHDOG
-	sum += per_cpu(irq_stat, cpu).soft_nmi_irqs;
-#endif
-#ifdef CONFIG_PPC_DOORBELL
-	sum += per_cpu(irq_stat, cpu).doorbell_irqs;
-#endif
-
 	return sum;
 }
 
@@ -248,7 +217,7 @@ static void __do_irq(struct pt_regs *regs, unsigned long oldsp)
 
 	/* And finally process it */
 	if (unlikely(!irq))
-		__this_cpu_inc(irq_stat.spurious_irqs);
+		inc_irq_stat(SPURIOUS);
 	else
 		generic_handle_irq(irq);
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 4bbeb8644d3d..44da7be36199 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -572,13 +572,13 @@ DEFINE_INTERRUPT_HANDLER_ASYNC(timer_interrupt)
 	now = get_tb();
 	if (now >= *next_tb) {
 		evt->event_handler(evt);
-		__this_cpu_inc(irq_stat.timer_irqs_event);
+		inc_irq_stat(LOC_TIMER);
 	} else {
 		now = *next_tb - now;
 		if (now > decrementer_max)
 			now = decrementer_max;
 		set_dec_or_work(now);
-		__this_cpu_inc(irq_stat.timer_irqs_others);
+		inc_irq_stat(OTHER_TIMER);
 	}
 
 	trace_timer_interrupt_exit(regs);
@@ -591,7 +591,7 @@ EXPORT_SYMBOL(timer_interrupt);
 void timer_broadcast_interrupt(void)
 {
 	tick_receive_broadcast();
-	__this_cpu_inc(irq_stat.broadcast_irqs_event);
+	inc_irq_stat(BCT_TIMER);
 }
 #endif
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index cb8e9357383e..a8f15154bd9a 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -459,8 +459,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(system_reset_exception)
 	}
 
 	hv_nmi_check_nonrecoverable(regs);
-
-	__this_cpu_inc(irq_stat.sreset_irqs);
+	inc_irq_stat(NMI_SRESET);
 
 	/* See if any machine dependent calls */
 	if (ppc_md.system_reset_exception) {
@@ -817,7 +816,7 @@ static void __machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
 
-	__this_cpu_inc(irq_stat.mce_exceptions);
+	inc_irq_stat(MCE);
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
@@ -1932,8 +1931,7 @@ DEFINE_INTERRUPT_HANDLER(vsx_unavailable_tm)
 DECLARE_INTERRUPT_HANDLER_NMI(performance_monitor_exception_nmi);
 DEFINE_INTERRUPT_HANDLER_NMI(performance_monitor_exception_nmi)
 {
-	__this_cpu_inc(irq_stat.pmu_irqs);
-
+	inc_irq_stat(PMI);
 	perf_irq(regs);
 
 	return 0;
@@ -1943,8 +1941,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(performance_monitor_exception_nmi)
 DECLARE_INTERRUPT_HANDLER_ASYNC(performance_monitor_exception_async);
 DEFINE_INTERRUPT_HANDLER_ASYNC(performance_monitor_exception_async)
 {
-	__this_cpu_inc(irq_stat.pmu_irqs);
-
+	inc_irq_stat(PMI);
 	perf_irq(regs);
 }
 
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 764001deb060..f516eeccc9f6 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -381,7 +381,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(soft_nmi_interrupt)
 	if (!cpumask_test_cpu(cpu, &wd_cpus_enabled))
 		return 0;
 
-	__this_cpu_inc(irq_stat.soft_nmi_irqs);
+	inc_irq_stat(WATCHDOG);
 
 	tb = get_tb();
 	if (tb - per_cpu(wd_timer_tb, cpu) >= wd_panic_timeout_tb) {
-- 
2.47.3


