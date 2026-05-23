Return-Path: <linuxppc-dev+bounces-21433-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F853CD5BB8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 17:41:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN8ZJ4Zk1z3bpx;
	Sun, 24 May 2026 03:40:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779558056;
	cv=none; b=IC4eiyldZ59zTVsogI+FQzQJhFkFITlmuTuuiCp/u5ONn4oDbWyyYMtyKdSibdtTuenuCfHb2oeKyFyHWz5sjjb72cMMHsbq8en0CQHytRB1Ojj6ntxJwKdo32ksr0+V0Agw+YUirEre4rwOGcmcTv3OGCH/K5hC84TemNx2B8yPnm53c3ezSRuI95jumNIAAAtFVxea8YYFvSh7lisKgBGpEXoLq6Li2xp6DLEtGLjApEF3TiBXnA5HQ5Jd/4SkDHiztyNZAgcgaTrSInd6n4Zo9vtzJ+QDPXMV7x0ZPGxz8CD96r7ahyk8uXwqGvoNLmtcNYjSjXcwCsPKIKlErA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779558056; c=relaxed/relaxed;
	bh=hDFOOcJhSuyizETQf6yoDI1cLDwjEm0v/CRgTa+RZdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiiOiJ2u9jEOYDgiAG7W8EG3r/c4vuH73Rj0xeQnpoqEKKnWSXchdtpWIVlDTkUR7VRg/d9URry8o5oEnQSzKC/Gj3PpS5iaFnRGyRBlihWUWFzKzguZPZuyop7ACloe5j5VVf04FtQRb/dglBexGedh0DTiyJtPidszJCk593tlAN1I6ROer1OhJuLxnlKV2xT6SjWeESxqO1PibUDjXVvZWxUvM4lAQqxb84rphfGEGuVJohxL/b04hqXV0dLmRm9ufC1Mgbr2UgnigQTPvtV7oOJq1Oxwe3VVtiStFvyyUqf8HhnBLYo7dVEWBo4tOEtuxHVC3PwQExwuAWXlng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CQCVg4OL; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CQCVg4OL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN8ZH2lYqz3bpJ
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 03:40:54 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N3mqT51978085;
	Sat, 23 May 2026 17:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hDFOOcJhSuyizETQf
	6yoDI1cLDwjEm0v/CRgTa+RZdU=; b=CQCVg4OLWt984gtMGLXOvYX/G2d3VsVdx
	GJDGOALwt8uWcaLmYgwmuaF9AjVVrhS6f5krO1tcAG4UKfLAy6+vmk4jJhiDlWnN
	hIyJE7R1u2c8YdTTme2H6m7ZM9b2phZD3+TxRSNuvL8wGpH/NeF7kOKelqz2jCEE
	rIF6f3aLzbPAYV8D0fQMXTls5Cz7sGd6VrXXuI/POPu/ZIOTcfaBmCee5f9xHImL
	jaPhVwrbPZV6LSFQkYuTh+5j+WQFQzTTXKgvPosTe6C+ECdBYhYEFb5rqK10EfZa
	3yT7CRO4rvC8KFWZmpssAcVHT1EpxKZgxQNmPbsVd1s1IJZ7RQ8MQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4npshpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 17:40:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NHd9Cn032444;
	Sat, 23 May 2026 17:40:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eb480hxux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 17:40:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64NHehDc23462188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 17:40:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74E6720040;
	Sat, 23 May 2026 17:40:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D723D20043;
	Sat, 23 May 2026 17:40:41 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.18.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 23 May 2026 17:40:41 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] powerpc/irq: Suppress unlikely interrupt stats by default
Date: Sat, 23 May 2026 23:10:16 +0530
Message-ID: <20260523174016.999456-4-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: 7AhSeokbQJrBooYaWg36YY_FAd5ogxgb
X-Proofpoint-ORIG-GUID: 7AhSeokbQJrBooYaWg36YY_FAd5ogxgb
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a11e6a0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=HwhMAjjRhnxDVlPREfwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE4MCBTYWx0ZWRfX4PfUxlg4qNp7
 VC/OcSZinslGHqLAqzkFJ+vMCp0abYpBkyvkcXEsm+9FiUw/bElyZowSdZT2tIQhPZx7v9kGdaS
 yT/4F9Olll5SGIc37vba7/suXesmpJrBxm+XOHkiI9seeTrMxlHKff5Jf32c0UItbOd/USfyq87
 KW5Qr5GJ1H2tFsTsF7uwhRNlabQ8cmlsidfiI9GzCC5eFkoIzmMeZi0wcMTGJPFlEhLJTHDLWiG
 hsH3kGqPCEhyDVGk2hCuXw35mNCHgIsZvtxsprMaK58b1TTYUe1gvkdP2kuDrxXXYDKhJUEuIXw
 WjSCQvXSBkYicjGUUD4EjfpbMOZnvisKVGpybgPuo0vrFbbK+ki4yBrSq0TT4otzCIpDKh4eqJM
 4o+UgSen4HnHG3UgQMH8/Ih8OJvtWUuWusxvIuut6xWwi0dVaMSK8+4lFMhf6+gf/J8063uZsPV
 0waxgMnEP0zSSmCcXRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605230180

Some interrupts are always zero and that is expected since they occur
very rarely and are mostly error indications. Don't print them by
default.

"MCE" -  "Machine check exceptions"
"NMI" -  "System Reset interrupts"

Print them if they occur once. Maintain a bitmap to know which
interrupts are to be printed.

Time taken to read /proc/interrupts 1000 times.
Base and v6 details can be found in cover-letter.
Base            :  103us
v6              :   63us
v6+patch 1+2    :   57us
v6+patch 1+2+3  :   54us

Patch 3 shows an additional 5% gain compared to patch 1+2. So it does
make sense to print them only if they are ever set.

Note: Since /proc/interrupts depend on kconfig and arch dependent,
userspace tools don't make explicit assumptions.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/hardirq.h |  1 +
 arch/powerpc/kernel/irq.c          | 37 +++++++++++++++++++++++++++---
 arch/powerpc/kernel/traps.c        |  4 ++--
 3 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 38098e35b241..be6cd5aab016 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -31,6 +31,7 @@ DECLARE_PER_CPU(unsigned int, __softirq_pending);
 #define local_softirq_pending_ref       __softirq_pending
 
 #define inc_irq_stat(index)	__this_cpu_inc(irq_stat.counts[IRQ_COUNT_##index])
+void inc_irq_stat_and_enable(enum irq_stat_counts which);
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index e67a18f62142..048ddfa66fc4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -87,9 +87,13 @@ u32 tau_interrupts(unsigned long cpu);
 struct irq_stat_info {
 	const char	*symbol;
 	const char	*text;
+	int		skip;
 };
 
-#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt}
+/* ISE - IRQ STAT ENABLED, ISC - IRQ STAT CONDITIONAL */
+#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt, .skip = 0}
+#define ISC(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt, .skip = 1}
+
 
 static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
 	ISE(LOC_TIMER,		"LOC", "  Local timer interrupts for timer event device\n"),
@@ -97,8 +101,8 @@ static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
 	ISE(OTHER_TIMER,	"LOC", "  Local timer interrupts for others\n"),
 	ISE(SPURIOUS,		"SPU", "  Spurious interrupts\n"),
 	ISE(PMI,		"PMI", "  Performance monitoring interrupts\n"),
-	ISE(MCE,		"MCE", "  Machine check exceptions\n"),
-	ISE(NMI_SRESET,		"NMI", "  System Reset interrupts\n"),
+	ISC(MCE,		"MCE", "  Machine check exceptions\n"),
+	ISC(NMI_SRESET,		"NMI", "  System Reset interrupts\n"),
 #ifdef CONFIG_PPC_WATCHDOG
 	ISE(WATCHDOG,		"WDG", "  Watchdog soft-NMI interrupts\n"),
 #endif
@@ -107,11 +111,25 @@ static struct irq_stat_info irq_stat_info[IRQ_COUNT_MAX] __ro_after_init = {
 #endif
 };
 
+/*
+ * Used for default disabled counters to increment the stats and to enable the
+ * entry for /proc/interrupts output.
+ */
+static DECLARE_BITMAP(irq_stat_count_show, IRQ_COUNT_MAX) __read_mostly;
+void inc_irq_stat_and_enable(enum irq_stat_counts which)
+{
+	__this_cpu_inc(irq_stat.counts[which]);
+	set_bit(which, irq_stat_count_show);
+}
+
 int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	const struct irq_stat_info *info = irq_stat_info;
 
 	for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++, info++) {
+		if (!test_bit(i, irq_stat_count_show))
+			continue;
+
 		seq_printf(p, "%*s:", prec, info->symbol);
 		irq_proc_emit_counts(p, &irq_stat.counts[i]);
 		seq_puts(p, info->text);
@@ -138,6 +156,19 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	return 0;
 }
 
+static int __init irq_init_stats(void)
+{
+	struct irq_stat_info *info = irq_stat_info;
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(irq_stat_info); i++, info++) {
+		if (info->skip == 0)
+			set_bit(i, irq_stat_count_show);
+	}
+
+	return 0;
+}
+late_initcall(irq_init_stats);
+
 /*
  * /proc/stat helpers
  */
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a8f15154bd9a..3eacbd20fc80 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -459,7 +459,7 @@ DEFINE_INTERRUPT_HANDLER_NMI(system_reset_exception)
 	}
 
 	hv_nmi_check_nonrecoverable(regs);
-	inc_irq_stat(NMI_SRESET);
+	inc_irq_stat_and_enable(IRQ_COUNT_NMI_SRESET);
 
 	/* See if any machine dependent calls */
 	if (ppc_md.system_reset_exception) {
@@ -816,7 +816,7 @@ static void __machine_check_exception(struct pt_regs *regs)
 {
 	int recover = 0;
 
-	inc_irq_stat(MCE);
+	inc_irq_stat_and_enable(IRQ_COUNT_MCE);
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-- 
2.47.3


