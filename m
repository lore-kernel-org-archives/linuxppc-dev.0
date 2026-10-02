Return-Path: <linuxppc-dev+bounces-28765-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1251CA5FD4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 16:47:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxF7D1bK6z30RN;
	Sat, 03 Oct 2026 02:47:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790959624;
	cv=none; b=VlSedocc9as06iJQLbcf89Kyl2DKdeFHgu3E0LI8V1JFCp6G5IydfW+Mo/YaXOJamO52Zutw3J5KvgH3sgK0vManYRnBhcJJdhBmaHQjbucmbwxRAh/T/FXps95hs5M0gl+3Lt13/uV/ugFH5VQv8Xqfhgs0WIXjPEe2MaYo3rCFA3slRsbEuqGEXDnLVdGsbGHzxUpAAJJDs501/+8wnEz8+DXvvR89PzyZZPkLE2i8d22s82CWZYQEEvADp36MLoKQC/MewQdfXJWngiYUu+8xLOrMfu+Qdp404ikTeaUSe76FUjvYCP3S7BaAgKGvDwUQWphlqm5n1/YMj73qLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790959624; c=relaxed/relaxed;
	bh=m9724MKFgNawNIlNtVy8DG1j4KX7YeVJIB+ubVH2nLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrzB2BKIglzJSyvtXEw5PSEvUNt0XdYkv/4EwR/UK78wyopJoxRfYUlpWfD7vie9VBy8pOgnxsoMwxP5EPtURbRRAfrIX0DEgVGcWCW344x2Io4TWPr3A2KTiUcn1CUZ37mspFbHKfBnf6zv+DDgXn2Am52j2arrKmEajL5416wWggC7D7/zdKn17SeT+v3e9Arvdp9I/rpDNtG9gZncPoR3RWdzI07KSeifmdnVqMbxL9uMVk1QSJ+RUGDNE8SaPALq4m4T6VGQiQPU9lktKHly3fxqDIMTUXpW682W6jrPQCi1YNkqqlDNMSnn5OzaWIvE3uT2llpTNUZxwA4LIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SCsvJURM; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SCsvJURM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxF7C1y9Yz30DK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 02:47:02 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 692FZlqt3837663;
	Fri, 2 Oct 2026 16:46:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=m9724MKFgNawNIlNt
	Vy8DG1j4KX7YeVJIB+ubVH2nLU=; b=SCsvJURMtFVWcbIdGY/NifTpY6PYJzSEz
	qE1lkrmYfX4zx5/lMe21t5ZT9EUoP0VneLoAb7Yl33sbg+LJEqYXErfhGJD7mqDs
	y7PBCYSPDDcz1DDhhGG3cTCz0pkNsorx/ODRzG2/jfHlJY0bpk/VmmUkq5gjF31V
	7CDYv3EnIBxwnKXiNd5HVW5VqzEx6QI1jOnv9PRbA7BtirCinE1vIowRgcdzUBld
	9fl5nsk+/bqwriq8fWsyEEo71+qZW9t6TVHIVuZzbYKiYacNIA4ENWf+MzjsRf9a
	TwKFeJbmvYcz60vVtLDwQ9ZnHMoPdzjMCiU0AMuefhZClmnu/VxVA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fery49-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 16:46:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692FHWJ62737421;
	Fri, 2 Oct 2026 16:46:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1aa80jv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 16:46:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 692GkbIN48431470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 16:46:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32F1E20043;
	Fri,  2 Oct 2026 16:46:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E56420040;
	Fri,  2 Oct 2026 16:46:33 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.216.180])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 16:46:33 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        ritesh.list@gmail.com, peterz@infradead.org, boqun@kernel.org,
        will@kernel.org, jhladky@redhat.com, paulmck@kernel.org
Subject: [RFC 1/3] powerpc64: move preempt count to paca
Date: Fri,  2 Oct 2026 22:16:17 +0530
Message-ID: <20261002164619.1455143-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002164619.1455143-1-sshegde@linux.ibm.com>
References: <20261002164619.1455143-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abfdff2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=WTI5rqN0pd3NQrxTgdQA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfX7SfIXY9EuU+G
 IK5/+Zn2GPcZ0hv7+K4WdcXd+P/s1sdaf1VKA/DKe/9tpl2VVaPIsJkeiy9Thf76tcJ83uBHKIV
 O9WbP7QPunp7YGcsJC/A9iq0OJD5M2g=
X-Proofpoint-ORIG-GUID: 8WybwyaidbTcvt2ZJ5Y0YhAYCiZt3oge
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2NiBTYWx0ZWRfXzeGZL9AWYhBH
 4BF1ziRVzjsoLVjPzRY3snN9sRtXhuFjmKT5byfFiyLtKxTwq4Fx/V7NLszHCKUC6igP3F+zdTc
 qQBewOksO8KJJ3YlJuKOZtkVxYvxDzijvKjFCmmpf8QWkOMPigGXKylDHJcMWnNCRkxpch54YNF
 qTcsFeVMWkIDB1LzrLRsgv8E7ZVDBwRyrjoE6f29pgKbPfD036NV5GqiGUUMakHd4g/vF/10lnv
 0MnQBNXh1SPso7ZJYWYp+EWeA9EoB6o4a/lxob1A128EP6PvaLQ6ZCysazFouQMwyDtQWM8XYat
 vw4ujx0nszUe/V3LIDGdDq+omQuAgYQ4P0R/SCRo1SJt3jRBGNd7suAyUAE8/fIytD4tPqpq78B
 ILw2ZchwIIuqs2e7uUcSphBCIh1HsPwO/ah7UTc+Nnug5CFHZsiazoQ9hRdpvWNMInubJ0l+i17
 ZG749UR30V8EgfJ5CUg==
X-Proofpoint-GUID: jFbN0zwHf0tP2DwZvsUdQ5YeTp9GDdle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020066

PowerPC uses generic implementation of preempt as of now.
That means preempt count in embedded in thread_info.

preempt_count = current_thread_info->preempt_count.

Current is first obtained from PACA. So this involves multiple
cachelines/pointers access. But preempt count is a per cpu storage
attribute indicating whether preemption can happen on
this CPU. per cpu storage has been used in other archs such
x86 already.

Powerpc64 architecture using PACA instead seems to be a more natural
fit. r13 is local paca pointer and it is always cacheline hot.

So getting preempt_count from paca means avoiding two deferrences.
It is worth doing that since preempt count is very high frequency
operation involved in various kernel primitives.

Given that after 7.0 powerpc has only preemptible kernels, makes it
even more relevant.

No functional change is intended.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/paca.h        |   1 +
 arch/powerpc/include/asm/preempt.h     | 103 +++++++++++++++++++++++++
 arch/powerpc/include/asm/thread_info.h |  14 +++-
 arch/powerpc/kernel/paca.c             |   1 +
 arch/powerpc/kexec/core_64.c           |   2 +-
 5 files changed, 117 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/include/asm/preempt.h

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 1d58da946739..0aa729c2faf5 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -164,6 +164,7 @@ struct paca_struct {
 	u64 saved_r1;			/* r1 save for RTAS calls or PM or EE=0 */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u64 exit_save_r1;		/* Syscall/interrupt R1 save */
+	int preempt_count;
 #ifdef CONFIG_PPC_BOOK3E_64
 	u16 trap_save;			/* Used when bad stack is encountered */
 #endif
diff --git a/arch/powerpc/include/asm/preempt.h b/arch/powerpc/include/asm/preempt.h
new file mode 100644
index 000000000000..e2785d5a13e0
--- /dev/null
+++ b/arch/powerpc/include/asm/preempt.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * PPC64 stores preempt count in PACA.
+ * PPC32 stores preempt count in thread_info.
+ */
+
+#ifndef __ASM_POWERPC_PREEMPT_H
+#define __ASM_POWERPC_PREEMPT_H
+
+#ifdef CONFIG_PPC64
+#include <linux/thread_info.h>
+#include <asm/paca.h>
+
+#define PREEMPT_ENABLED	(0)
+
+static __always_inline int preempt_count(void)
+{
+	return READ_ONCE(local_paca->preempt_count);
+}
+
+static __always_inline void preempt_count_set(int pc)
+{
+	WRITE_ONCE(local_paca->preempt_count, pc);
+}
+
+#define init_task_preempt_count(p) do { } while (0)
+#define init_idle_preempt_count(p, cpu) do { } while (0)
+
+static inline void set_preempt_need_resched(void)
+{
+}
+
+static inline void clear_preempt_need_resched(void)
+{
+}
+
+static inline bool test_preempt_need_resched(void)
+{
+	return false;
+}
+
+static __always_inline void __preempt_count_add(int val)
+{
+	int pc = READ_ONCE(local_paca->preempt_count);
+
+	pc += val;
+	WRITE_ONCE(local_paca->preempt_count, pc);
+}
+
+static __always_inline void __preempt_count_sub(int val)
+{
+	int pc = READ_ONCE(local_paca->preempt_count);
+
+	pc -= val;
+	WRITE_ONCE(local_paca->preempt_count, pc);
+}
+
+static inline int __preempt_count_add_return(int val)
+{
+	int pc = READ_ONCE(local_paca->preempt_count);
+
+	pc += val;
+	WRITE_ONCE(local_paca->preempt_count, pc);
+	return pc;
+}
+
+static inline int __preempt_count_sub_return(int val)
+{
+	int pc = READ_ONCE(local_paca->preempt_count);
+
+	pc -= val;
+	WRITE_ONCE(local_paca->preempt_count, pc);
+	return pc;
+}
+
+static inline bool __preempt_count_dec_and_test(void)
+{
+	int pc = READ_ONCE(local_paca->preempt_count);
+
+	WRITE_ONCE(local_paca->preempt_count, --pc);
+	return !pc && tif_need_resched();
+}
+
+static inline bool should_resched(int preempt_offset)
+{
+	int pc = READ_ONCE(local_paca->preempt_count);
+
+	return unlikely(pc == preempt_offset && tif_need_resched());
+}
+
+#ifdef CONFIG_PREEMPTION
+void preempt_schedule(void);
+void preempt_schedule_notrace(void);
+
+#define __preempt_schedule()		preempt_schedule()
+#define __preempt_schedule_notrace()	preempt_schedule_notrace()
+#endif /* CONFIG_PREEMPTION */
+
+#else /* !CONFIG_PPC64 */
+#include <asm-generic/preempt.h>
+#endif
+
+#endif
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 1e069a2e7ce8..89fd63442f7a 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -52,8 +52,9 @@
  * low level task data.
  */
 struct thread_info {
-	int		preempt_count;		/* 0 => preemptable,
-						   <0 => BUG */
+#ifndef CONFIG_PPC64
+	int		preempt_count;
+#endif
 #ifdef CONFIG_SMP
 	unsigned int	cpu;
 #endif
@@ -74,12 +75,19 @@ struct thread_info {
 	unsigned long	flags ____cacheline_aligned_in_smp;
 };
 
+#ifdef CONFIG_PPC64
+#define INIT_THREAD_INFO_PREEMPT_COUNT
+#else
+#define INIT_THREAD_INFO_PREEMPT_COUNT \
+	.preempt_count = INIT_PREEMPT_COUNT,
+#endif
+
 /*
  * macros/functions for gaining access to the thread information structure
  */
 #define INIT_THREAD_INFO(tsk)			\
 {						\
-	.preempt_count = INIT_PREEMPT_COUNT,	\
+	INIT_THREAD_INFO_PREEMPT_COUNT		\
 	.flags =	0,			\
 }
 
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 7502066c3c53..f19d057c37b3 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -200,6 +200,7 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	new_paca->hw_cpu_id = 0xffff;
 	new_paca->kexec_state = KEXEC_STATE_NONE;
 	new_paca->__current = &init_task;
+	new_paca->preempt_count = PREEMPT_DISABLED;
 	new_paca->data_offset = 0xfeeeeeeeeeeeeeeeULL;
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	new_paca->slb_shadow_ptr = NULL;
diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.c
index 58c13a59b93b..f3954695e0b5 100644
--- a/arch/powerpc/kexec/core_64.c
+++ b/arch/powerpc/kexec/core_64.c
@@ -352,7 +352,7 @@ void default_machine_kexec(struct kimage *image)
 	 * XXX: the task struct will likely be invalid once we do the copy!
 	 */
 	current_thread_info()->flags = 0;
-	current_thread_info()->preempt_count = HARDIRQ_OFFSET;
+	WRITE_ONCE(local_paca->preempt_count, HARDIRQ_OFFSET);
 
 	/* We need a static PACA, too; copy this CPU's PACA over and switch to
 	 * it. Also poison per_cpu_offset and NULL lppaca to catch anyone using
-- 
2.52.0


