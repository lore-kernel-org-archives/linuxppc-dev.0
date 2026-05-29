Return-Path: <linuxppc-dev+bounces-21718-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2035ECD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 12:41:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRjdf1j7Rz3br2;
	Fri, 29 May 2026 22:41:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780058470;
	cv=none; b=FbM/UFPQMEnsHHakSaBNwCzZRFmlP8hf9yt8RfbQVw+I9Xj/TvyzPTTV0kR+6cWG8LchxQy4UsIFqmbttAY4MhVehFaRvve5EzXJuLYOu97AKcVnNXSqHTey2Z19QrugZwZFV/yW2F3kSH6NORUosU1n1e45zMhXpR5E1UwS1NHamnYA3cbPf/HZFFoezTZGlsIjgcnzw1Ct82pJhiOTetvKxq/wbwAHpNd60Kz2+QAYKSnT0D3n11EZ+61eOajIQJhxIYtJ83WaIgvcgnXdKWUVOHTTiFELlsAyg9HDBpFZO+XIecpnEHs7EBW7IIp2FtpwvHc1rOq6Fc3FsxDnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780058470; c=relaxed/relaxed;
	bh=YU5lUSO2/RzWbFB82+LUZ7LUD5/dK4LtprR/6hPghzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y16C0F2VifxCqAh36l10C0xHdca0piDAlNt0NBGZ3cUpgGAaTbGqva0oNY+kQ4Rdp2caYI2bFpCFbA8+ixVz8doryRuY9/7Ho8eA9/0MQNssN3cUEU+gt08+GzyJTVxW127ECIOYvP6ero68IYkzJGv9HCCLtmZ7oCRveFYboDH5mwezH8vS539Rqbazo6rvLMmWfGLmyMzFFeFGSfmpK0Z4B/+AfvwIUtU5eTHFuS8Muq3GfQWjaY6ZVtF++J6yVQJdFnTazzud81aMoDlu/b9xTTj4F5TDx0Ib3TfV2V24vaDGcx1JBSKGZzzOe6Ba/W/34BHKQHPZxzhcJXbxSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CTCj+lTF; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CTCj+lTF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRjdd4FqPz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 22:41:09 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TAhwiJ2418247;
	Fri, 29 May 2026 12:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YU5lUSO2/RzWbFB82
	+LUZ7LUD5/dK4LtprR/6hPghzc=; b=CTCj+lTFrXmdK8HxAROOjbS2fX32HSNzO
	XhEAn2eMKOc/cQCDl2loYcmCCa01IL3JOiFHnGawbcwsQGt+jNkYIRI3bzFm2oNY
	M7QpJZ3vr3aeELDfvK+nHenXvcAGabn368VUAJbG49dWgt+B3E4eUd8ljUU5eAkB
	B2kXB3RsBz97FXLCHw1heLs3rmZ9FpyEcoXSYSj7pTl4aOdlPm82ueGsuKahSaBd
	+t6l6TdSXx0kimFI16KkMwQitxWQGoSsrSimek7SXwNlkN+GAZmIP2ZOHQvLzgSv
	rJBq5Q7kVBbFJ8K6lDW8sSWC5huGoUHOA5Nb0dUBz257v2oAvf8jQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884rp2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 12:41:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TCdBgU016770;
	Fri, 29 May 2026 12:41:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbwjt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 12:41:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TCexFL26607912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 12:40:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C31A20043;
	Fri, 29 May 2026 12:40:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C1CE20040;
	Fri, 29 May 2026 12:40:57 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.221.69])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 12:40:57 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: sshegde@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] powerpc/irq: Suppress unlikely interrupt stats by default
Date: Fri, 29 May 2026 18:10:45 +0530
Message-ID: <20260529124045.1208539-4-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a198960 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HwhMAjjRhnxDVlPREfwA:9
X-Proofpoint-ORIG-GUID: PAV-6-Ot_Aw9KfM20SDoMXTYyojfAlk0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEyNiBTYWx0ZWRfX45AGDvuIbZf0
 2Ul7z2VANi5/wtqM5gfLpSphbjt/K5tb7iPfwa+y1Y2kbXq79yMZpB56/KEi1Qkft6zOyiiA5sw
 B+lZZviPlumFnyq6cC2Ioiz5sfCanF6WmmBZQkyUhDYCIqCAW9j1ScoocfV9XcVNm8JDqw+8/Yu
 c0w2/VjH0MJtZjOWb9fP6uaYAv20gbfN/DIXNXTca5cs3G/EkucK42cfcN9vRJqHUWBlN70Cz6U
 YYjz08SPJwipestScjO+lyX6U8i+6aybeBROmvXx1fF0EydlViuLzQcIABHkC/sQJ2n9xSFvFbS
 Mcag/tcTmu1UVxhP98t8Qqz7+BvhZ4cZqjz0ugBPp7wO8Ht1Rwra6qTe30e0XRvESs559Urb/fn
 VsKoQdZjcdKcTKv8YPMh2jFoXB5M4hSvxQpHV4LjGKrpAOhPx/QjcRG1LHSM/AnHB/ubiXwBi0F
 YW9kWpFTIYLUWyiTZ0Q==
X-Proofpoint-GUID: PAV-6-Ot_Aw9KfM20SDoMXTYyojfAlk0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290126

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
index e67a18f62142..0a6a0e707fe8 100644
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


