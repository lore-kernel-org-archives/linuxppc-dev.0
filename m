Return-Path: <linuxppc-dev+bounces-21719-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756E6CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 12:41:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRjdk5TNVz2ybR;
	Fri, 29 May 2026 22:41:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780058474;
	cv=none; b=XOm0i+YeRGa4/UrKBfJ21DPE/0W5Psp1u7xqc1VsBtZiRFUZesg+BB6pSYRFNY2Rznh2PlMJOSgjUEz9f0C6Lcwsa9U1vzv9pe85KoWkwp5kN1PgcoiHWLs00ZVg4lLg8AT9zjMve/iHWjhZGO5dTzZzd+OU0LDg1ysZDxal1vcjggXA54nrGnK5x0g2Apr4x40zhIS7fmsiAL+Q6i2gJGnLgTOCHT38aBjWW2d08Y8B9f9ZQp9zM7kmTncsxq99W07TSaJK08uYFGvBH1loIbiu0J7mjZG1d0qkcxiGPHUA2CsoZmgljtR49dHE/28PpgbOGawvc0X1lLhItqGXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780058474; c=relaxed/relaxed;
	bh=LP+5jBze7U2XVcMEW98Vu9lKHhwwdgz0zWVCWBdi3Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bytA4F9fdB/Yx4+hC6maoWEigJfkecxJnq9av7Prz5TKx5s6Mx9PoBeK5TcmRRW0Y44vuB42Ndx64qW+CHwVPQN8Vmu3htLGbbxilNZSS5+goNRVZRDjPo1Pouk7edNxvsZZZ3IiYVL+d41CkDbTPA0vLEqrUMwfejr1Lh+qdmTz3yY0W2Qf+y75mRAphTidiuEUbx9nIEkJoZEjUmbQwtDjdU6dJATq59vg9tsEvmJUUCzFbbqAOGVqMPtUnwNthc5v4UtKY3vibCfT5C4HN7z4B1oWkerKrCjBmQ7KXVtq5Op59JiV8cvhBxzdg4PQKKPUG44v9PP0XXvpcxSHTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gVUYLs5H; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gVUYLs5H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRjdj5x9Bz2ySg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 22:41:13 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TAQPll2776276;
	Fri, 29 May 2026 12:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LP+5jBze7U2XVcMEW
	98Vu9lKHhwwdgz0zWVCWBdi3Y4=; b=gVUYLs5H/uZ35Bq0qLqSGx+NCnRRificL
	stX5njSvSVJipLo2LoqLUQhFSVTtZywE4TKYWLSRWPHpKw7dKmyuIhX/6kM6g1ok
	Jhib9uSPgNV+sNmVCxUaw1neWNQRoJZQpqPkuiLjf1ZWK6YNQZLeKIPD0RwAUKNV
	fnNQpD+dNsdioEZokKfAvqqn5TxnFdzgjBR2FAfTpwOxpkL3RCPEyX1E04/qhDp+
	fEwZrUDHbKjoM4sBGDtT/l9z/I/4WK8NhCxT78cBHrMspT0CdPlWXkXEdr6gZusm
	kSgvWRqeKDklD5FKw+Jumb99Ne1C5ezDrlLjRKkzLfGMsl2dHUsXA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889g96v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 12:41:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TCd9RN016767;
	Fri, 29 May 2026 12:41:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbwjsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 12:41:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TCev8f13762818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 12:40:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAC3220040;
	Fri, 29 May 2026 12:40:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0462220043;
	Fri, 29 May 2026 12:40:55 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.221.69])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 12:40:54 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: sshegde@linux.ibm.com, linux-kernel@vger.kernel.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH v2 2/3] powerpc/irq: Make irqstats array based
Date: Fri, 29 May 2026 18:10:44 +0530
Message-ID: <20260529124045.1208539-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260529124045.1208539-1-sshegde@linux.ibm.com>
References: <20260529124045.1208539-1-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: mwDugPUT38qW5Oe7Flgl_FowcOdKmEo7
X-Proofpoint-GUID: mwDugPUT38qW5Oe7Flgl_FowcOdKmEo7
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a19895d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Nt6gJGhAC5hH5tf_ggoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEyNiBTYWx0ZWRfXyrIhL2WA7NJu
 eixPNRfhCFuUuzgbud8U4HVd1mKK7rh6PoMCwh33ggTkF5cYlhhgzmveDwpGSHWPrvfaORCURnr
 9rLacZ7MUmyzCpC1H/HhatBbLc6tHcAtZ6RE9//FrOUsAfJPuNbllusGeL4G/7qo2yIWJQouNLM
 a+jKSa4uZTQy+KHrRE4k3hNOXVPoUzPjy0WDspMHk24rTv/s14kzkXbhRWlSgGqeO3fjy+fwFte
 Jyw2qNs+xN/F0WsTPCLlDex5kbC/S6AH+ogPdhYikkMMgiX5GXk0RoOtJ1qj3E/cmHSILO44o8n
 3mPxyhLklcb18LqXMnwWxSXgn2AJBHOIN172H15yz48xJ79ASO4tb+f9YIQB7+bZjSieIK2dwXu
 3WeOoPnN0nZo9S8VlUYiRDxodXoaDaHa3K/Hca1fxV23Bt/E76dUyGFrhwj59W1RjUaw90Elh0r
 Pavz5R8tQgpbHiwgccA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290126

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

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
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
index b4472288e0d4..5794adc2e8df 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -574,13 +574,13 @@ DEFINE_INTERRUPT_HANDLER_ASYNC(timer_interrupt)
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
@@ -593,7 +593,7 @@ EXPORT_SYMBOL(timer_interrupt);
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


