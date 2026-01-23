Return-Path: <linuxppc-dev+bounces-16209-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C1FD72345
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jan 2026 07:40:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dy8wr759hz2xHt;
	Fri, 23 Jan 2026 18:40:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769154028;
	cv=none; b=QqmMGdOOc1QFZtTz5Y6Zus4/E/gqYjca1LYKC8G0koLNawDGiLYh1Bc0R/KsdpTV4jWd4i1xNLgPavSiXiwpzbjQIKDVDopwR5ZpuoOgIJLPRKHH7IYFXFuEGzudJKFb4BYBd5DrScs69aH5qBaHyp0ugQLuuKSpdjkArINRKmKAMNtXYXO2F5BlBQ0tNH53o09WKKloNGKgd7ltDvNqBYXhiAlYZ70+kV1zQ3chwxN6RReCNlSsxtciMm70krm6i7YeMetVe5XaFwrh+11YjEcOKEfPW+3Z+QB/QcEEDMDD2lZdO2OJ4d1GypDYzZjybnpLMFpjRYzp27xfqpyK3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769154028; c=relaxed/relaxed;
	bh=3/4eib+xpLvUzfwQLFLDzDvh/omm20aA/cPzLNpHvRY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tx57fl9DkyVecuBvzvOB4M/nGhJF69reNJgIF17+z/nTQWf5UxJTtoq+w3rLw2nsbndbwX++EkIt1PzuJItSXNa61fw3LNR/iNoUgrfAgCd1rbJ9zw9kiTPcalj4K5NaRtMd0sF2HVLkqZIvBEQsjDqVGwsZQmATfKx5yn7JLJE6nJQeG7zu4K9Fe4Fy9G0ODqGOMSMboyZ1QvmZoo0IOQ2V4lcMgbsviB+mLBb65widBuL6Zz0/athNHjkcS5hO1B/w9oT2oMOv9hdPsl5UTG3UCQK7b1FiK9122EkfdSDyMkr2A7xTeFQXWFo3hEWpcVrxHhgxfW4YSQEFZ7gCjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WbAVleIh; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mkchauras@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WbAVleIh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mkchauras@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dy8wr1PLDz2x9M
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 18:40:27 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N2HhiR021317;
	Fri, 23 Jan 2026 07:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3/4eib
	+xpLvUzfwQLFLDzDvh/omm20aA/cPzLNpHvRY=; b=WbAVleIhFVFJ+1ZRDR7FU9
	io8X01NVigLQDud/EItESpB0u1EWWQ9gwALI3hqbQrm4pzg/OaBEVTQI/gkl/6ic
	r4QjZ6QM3TKqNU4/FZAm5qHiYnn768/f1eLRWLXG+3gx1FltVg37v2fMUAlZLFA4
	ROh0L4Ykcar8wNx/ZP5wc6+p2WVikNpWl13SqZqNWKD5BAdaDsFBBQCDbaVkOO//
	SlcLM+4zDHBr9qcDKQscM6O0oX9cSmnqWVtACIeXu5+fDCWf0SrSoTFOff7FYUcN
	Im3ZGXjh6OdkJ3JpIrjevOFZSrV7b+46oDiFL6qhdWck4vU2AuSv9d942/7yZJJg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612ha38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 07:40:01 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N7e0US011041;
	Fri, 23 Jan 2026 07:40:00 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bt612ha35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 07:40:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N6bXj5027298;
	Fri, 23 Jan 2026 07:39:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnfspa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 07:39:59 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N7dtcj38601128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 07:39:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DF422004B;
	Fri, 23 Jan 2026 07:39:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C594320043;
	Fri, 23 Jan 2026 07:39:49 +0000 (GMT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com (unknown [9.124.222.171])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 07:39:49 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, ryabinin.a.a@gmail.com, glider@google.com,
        andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com,
        oleg@redhat.com, kees@kernel.org, luto@amacapital.net,
        wad@chromium.org, mchauras@linux.ibm.com, thuth@redhat.com,
        ruanjinjie@huawei.com, sshegde@linux.ibm.com,
        akpm@linux-foundation.org, charlie@rivosinc.com, deller@gmx.de,
        ldv@strace.io, macro@orcam.me.uk, segher@kernel.crashing.org,
        peterz@infradead.org, bigeasy@linutronix.de, namcao@linutronix.de,
        tglx@linutronix.de, mark.barnett@arm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v4 2/8] powerpc: Prepare to build with generic entry/exit framework
Date: Fri, 23 Jan 2026 13:09:10 +0530
Message-ID: <20260123073916.956498-3-mkchauras@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123073916.956498-1-mkchauras@linux.ibm.com>
References: <20260123073916.956498-1-mkchauras@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QFzIB8v5osvdoZ0BbGLVSG0g9IifkH2n
X-Authority-Analysis: v=2.4 cv=LaIxKzfi c=1 sm=1 tr=0 ts=697325d1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=-TJU0OSysTv48yDGXSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: uIZUXHrmeQnPdbkQ9oHd1eIwYKWxfSrG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA1NSBTYWx0ZWRfXwLKASYox5Xxp
 ccGuhy2n0WNj6J8qhjlvJpsqOUcVsjlqDLzuPJLxMnBfMeWZrf0By6bnRUIHAKeYRoaAUyGR+N8
 z+/Xy8i7zKNY8f1eUHbFPmxeVabMJWQaHY/dxidcSi30ZcFux3rLrG+o6p9TbYbcdD5KT3NN/1b
 QOXD5KaG84ZuDMBDROu8MFrvI9+D0NwJ8boFYIbUeA7KkEwBEpSfynV8PAYhTOBtZVTd6bN9P27
 l1V5llOXYHzYHl/7YGNqt0MHkNbhmwnKIgoLshJM3DyrLqcamqIrAQTuBsdqq0DCnWUcLEQI5HE
 zfahrRrcJZTx58DCAmD4skBsw9bDkSB4FiDcgif9sAH6jv6c0MhDwokn6CxvzyYA3YsMkO8pqda
 ncOta2GZN3iJJeqd4T9ZWeqppkpPmuKYbuJxMTAbTVG9rwWmn78FbBGD1AGQevxGhsPRZJrm4ht
 YBMCd4MfQexvGOnnGRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230055

From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>

This patch introduces preparatory changes needed to support building
PowerPC with the generic entry/exit (irqentry) framework.

The following infrastructure updates are added:
 - Add a syscall_work field to struct thread_info to hold SYSCALL_WORK_* flags.
 - Provide a stub implementation of arch_syscall_is_vdso_sigreturn(),
   returning false for now.
 - Introduce on_thread_stack() helper to detect if the current stack pointer
   lies within the task’s kernel stack.

These additions enable later integration with the generic entry/exit
infrastructure while keeping existing PowerPC behavior unchanged.

No functional change is intended in this patch.

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
---
 arch/powerpc/include/asm/entry-common.h | 8 ++++++++
 arch/powerpc/include/asm/stacktrace.h   | 6 ++++++
 arch/powerpc/include/asm/syscall.h      | 5 +++++
 arch/powerpc/include/asm/thread_info.h  | 1 +
 4 files changed, 20 insertions(+)
 create mode 100644 arch/powerpc/include/asm/entry-common.h

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
new file mode 100644
index 000000000000..05ce0583b600
--- /dev/null
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_PPC_ENTRY_COMMON_H
+#define _ASM_PPC_ENTRY_COMMON_H
+
+#include <asm/stacktrace.h>
+
+#endif /* _ASM_PPC_ENTRY_COMMON_H */
diff --git a/arch/powerpc/include/asm/stacktrace.h b/arch/powerpc/include/asm/stacktrace.h
index 6149b53b3bc8..987f2e996262 100644
--- a/arch/powerpc/include/asm/stacktrace.h
+++ b/arch/powerpc/include/asm/stacktrace.h
@@ -10,4 +10,10 @@
 
 void show_user_instructions(struct pt_regs *regs);
 
+static __always_inline bool on_thread_stack(void)
+{
+	return !(((unsigned long)(current->stack) ^ current_stack_pointer)
+			& ~(THREAD_SIZE - 1));
+}
+
 #endif /* _ASM_POWERPC_STACKTRACE_H */
diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 4b3c52ed6e9d..834fcc4f7b54 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -139,4 +139,9 @@ static inline int syscall_get_arch(struct task_struct *task)
 	else
 		return AUDIT_ARCH_PPC64;
 }
+
+static inline bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
+{
+	return false;
+}
 #endif	/* _ASM_SYSCALL_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index b0f200aba2b3..9c8270354f0b 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -57,6 +57,7 @@ struct thread_info {
 #ifdef CONFIG_SMP
 	unsigned int	cpu;
 #endif
+	unsigned long	syscall_work;		/* SYSCALL_WORK_ flags */
 	unsigned long	local_flags;		/* private flags for thread */
 #ifdef CONFIG_LIVEPATCH_64
 	unsigned long *livepatch_sp;
-- 
2.52.0


