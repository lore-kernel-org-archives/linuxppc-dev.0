Return-Path: <linuxppc-dev+bounces-27817-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8932FC982DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:02:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHL33V68z30Lw;
	Mon, 21 Sep 2026 19:02:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981339;
	cv=none; b=FJRHmVXyE61AwussTF+0dO7R0wjncgLEvNKNGin9e2vlKKaef5HoxTAiKiokhboj8wl3tLcfUy841LCkZ0/Y1y8BCzILlGaMI7g4Ru1KcPWKcjoDlxY2SwZP8iFygV+ikb92+HwPJFabaVGDX6CUZdb5/BQC9/jdzuQC8lgry3D27J4NUGqF/EkdZFMB4pRIatz8cTduMNDRT6/vSnsfrr89VKAPlpwSCYFWLV2uv2lzhLzCj+5srQTctq3GtV2XMmuaGQ9tiTdme8D8AydCGvZc1TawYy+i8UjRGD3npARF1X9tHOSxjDcPyra+KCOnk2PuvAFmU/8Ii+k7hKAn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981339; c=relaxed/relaxed;
	bh=wsR8i4T/yAVaKBPaf7AfWISz4QNuITwiqJ9gP+aFl8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZLTdnHsVwhDLsSYhvOkhqs4ssC7KiQchtSsho1poDt+tSLyh9g4h8j4NNDBK55G82Hhw8+yaemtl31KeYMPeXRnLijKidI+elPZcGHpeeLHtLtKW42N/JklQMpMKabAI2Jo5Q2SeITxgNPvJ8nnyqyBid7Y4IGqnwEqPmvPbj8piEkBEqaeFKaKhbRv7T5+fpThPLiNJTC/fXDDziK/pFGeAlpmMRBiQhx9C2g5r8i2Je6pv+ZxX7fMOqpEQAokITFCC/apWObl5Q8wfXa3O11QwZgPpM2oE0DZCruheuA02qZLQ3c12czzZELkzELldCOphzMed3tRQl5LVJcrzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JhhnsZaJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JhhnsZaJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHL24nvrz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:02:18 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7ZlNo863477;
	Mon, 21 Sep 2026 09:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wsR8i4T/yAVaKBPaf
	7AfWISz4QNuITwiqJ9gP+aFl8s=; b=JhhnsZaJiWM0epFM2OVOQAEMVfELOUTyi
	9ZXP/gXCjvirJ8luk7Hg6vFI44Ce0RXFobU2YWA+WsjDBiSY1L/xiuqDUtHiQ+Ga
	DoqfCORVrbEgEctTSYdaktQCnivRjoCXXSWKPo0gjvPhAVhs/SqdWdKijp1Iv6Pe
	YrsZIsHq0pCSoNTZfP2z8EXwGxfRtFr4Aj1esm9mSAmejzKmWnJkCDZLnUKuzJ7t
	lLzyLtO7zthl7g33NiR0juC7UWPCBok1Z0cQcF3VeuWkbHO/OzuTSYnAOfAESTVo
	iazpBDqxu4lRGpKN6aDvAhmmbPapDU2h/ux2mukWtyzn/8wSHn4vw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduygga-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:02:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HdUb867852;
	Mon, 21 Sep 2026 09:02:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53vcnw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:02:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L927AC42074608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 09:02:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 102DF20043;
	Mon, 21 Sep 2026 09:02:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02ECC2004D;
	Mon, 21 Sep 2026 09:02:05 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.199])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 09:02:04 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com, tglx@kernel.org
Subject: [PATCH v3 3/3] powerpc/irq: Suppress unlikely interrupt stats by default
Date: Mon, 21 Sep 2026 14:31:53 +0530
Message-ID: <20260921090153.54745-4-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260921090153.54745-1-sshegde@linux.ibm.com>
References: <20260921090153.54745-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qoLIfXWHTEa_n6_c-o5nV5M_lsejku6H
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX8+RHOjlMqwRv
 LXV+McCiumU8t3rAp7jMq1WGGcpMoJCeH7BBm24vjMbXJxXseStnqB7LvJA5OJrVAvnURdneEeg
 rtc1CKNatzTRmfDo15R0RGgsPBajtQY=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab0f293 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=HwhMAjjRhnxDVlPREfwA:9
X-Proofpoint-GUID: 25ebQ2YNnNaIjQtOH07N0uQz3UXBZr0T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX7JgKSFzvqh5H
 rPC634gnAo9Go1plJsXkmTfTur2ABlVEFhZJmL2xrcMbtN6XuoM7hBJXlKt88NO1IS/q3kScnjb
 IK79g9NM+T5YaO3Hu8hNYijDu2QLsawEm5U8bRDoJ/ohzvOH3GC3hpRUSCGekpkLBGCKJlY8iVr
 wgeEYyPh+hzTHpfx6OvqsTlJMCtWFwkgpuCTWoiGPwtCgc0CgyHzu1xl2CIe7NK41u9K0PoB117
 YlJ8Sr+HvfH0ok4Nr+fYtsfWTVN+cz/hE534fpHBdjdMOSRkIJCHcjixQIlEe5GQKzIG8hHjEzW
 QBdo+SEcgqgmTktVeRjASsi+oqcrKi9skuIjvzIvGygHSoYUPYBA9mixCljnZPSfb5wrE8burSu
 mQl6z/aiwjn/T0yeS77OjIQf89aqLkb5AkWCwAVYr7RI6VRa/WzbwP6YSyJePpSc254dyv0fyvi
 WxsJLcRe+T4ztv/mFXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210123

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
index cfbec8363f99..bce546931a13 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -87,9 +87,13 @@ u32 tau_interrupts(unsigned long cpu);
 struct irq_stat_info {
 	const char	*symbol;
 	const char	*text;
+	int		optional;
 };
 
-#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt}
+/* ISE - IRQ STAT ENABLED, ISC - IRQ STAT CONDITIONAL */
+#define ISE(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt, .optional = 0}
+#define ISC(idx, sym, txt)[IRQ_COUNT_##idx] = { .symbol = sym, .text = txt, .optional = 1}
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
+		if (info->optional && !test_bit(i, irq_stat_count_show))
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
+		if (info->optional == 0)
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
index 0d605600dee6..3a8f5416e3f6 100644
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
2.52.0


