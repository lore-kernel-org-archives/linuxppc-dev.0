Return-Path: <linuxppc-dev+bounces-21964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB714CD6E64
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 09:56:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVjkm6N6sz2ybQ;
	Wed, 03 Jun 2026 19:56:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780480560;
	cv=none; b=HF53GNecOCQh39ObWSuEi6V7xNTXybgX7PyRPVS2HvAIK4HKLlFCzKwur6t7L2+COHzpONxDdbS+d2vU4jFpzm0uJ8q+2t/RbbfwxmwC1tHLyam2TIaON+M88aCkQjnW5HF56EIYPkATw2vDZfxo//aNHp6K9GddpvORrg9Yh9ECCoGD9VGsKg5/mWvOdc6t/is3cZT/pC/SQQ5oupD/DTljlbhM/NxlE+K6uJatmwH7l8P1nMd/F+VMBsJNvEpuEDntFA9Nrncks2pEjThlkDLN00NGwmVm9ZVx5kGu9EnBU0L+IpU/MQGX670kp7oQoM2DPY/oZsbOUJQsugt1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780480560; c=relaxed/relaxed;
	bh=8TEqP1Cdjl0Ym7Vnz3eHq0DDUmmsFYCrSXTH1xfg5gE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCMb6kcDx/vm1nyP7TusABsuT+qp+dxcXF9/CH6a2d3I4d/mLvZuJx/TaV2UqheuptT2g3rgplwPwjzX8MWaczViZLB4eygePAuXUXtX1I6n8hfxvN2asAPWz28glglkLTCA3yK2Bhb+32Y7QEGZx+t9sUYYYsHdIDNtfkHeJzefY1hwlqvy9MoaAcAZxMbe/cp/yOlKgwDV6vPbVgYUMbRqDryqjKEYUWUZ2EbyOAhwvGaMM3Txhl2mEFhO071sQXmpxfWbLv5rrtssZoszkYivUAOT8tTDrfKjpJwqDn+KlVS6JAGxn/IRE4yXpZ+CN27syVwSV5/0JDvmqNsUdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oO1v7VkR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oO1v7VkR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVjkl1dGJz2yL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 19:55:58 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65370QHK3707938;
	Wed, 3 Jun 2026 09:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8TEqP1Cdjl0Ym7Vnz3eHq0DDUmmsFYCrSXTH1xfg5
	gE=; b=oO1v7VkR6HVnNXAu1cEVyczhKJzlN+ZNpdgJkv9ss3e30Q0+8utzIoOfr
	5exWimX13pyrdAheH3eDBu3W2/IUkp/Fj2L29eB9qwfsDb8vM/OQtjkqPSbezJM6
	JXYIjIyRjh9kKhvcDzlK8TfM+nMHNU/7fIYsYagNQN1zvvrXAWSlQ+qHvO/9bGIY
	nL0FHnQBofUcVW6nJlRmwOx1//m7X/wK8Qq939y4Bq/kENI9Cu68y/VQSHnA0ZMt
	cN0QnbV6FOAyuEWdnnTLP3cWZqAqSzU1cyoTQu5LJJr7nXNo6YcUCzKlzRN/Bn2v
	OqA0ZlRAGvsRC0yVdQpK5Q9BOM+Vw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae9sj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 09:55:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6539s9jX016257;
	Wed, 3 Jun 2026 09:55:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvypng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 09:55:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6539tgiX39518648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 09:55:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4068F2004D;
	Wed,  3 Jun 2026 09:55:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 79DDD2004E;
	Wed,  3 Jun 2026 09:55:39 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.223.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 09:55:39 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, peterz@infradead.org, tglx@kernel.org,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        venkat88@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH] powerpc/entry: Disable interrupts before irqentry_exit
Date: Wed,  3 Jun 2026 15:25:21 +0530
Message-ID: <20260603095521.198267-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1ffa24 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZcPFttQkb1t9wctH9vwA:9
X-Proofpoint-GUID: 4SRcU2V-rmNWWlu_PJO-ZdMYeSVQnTs9
X-Proofpoint-ORIG-GUID: UrbO6C0mW4RdetaAR0QuhswaWa4j37cT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA5MiBTYWx0ZWRfX7dOtxJV8PCDh
 SHkSKZHqoQfEQ0QNxTD00VV62LJUaklaOcZVaRGYWc9x2o8g4zFqUqvf+fPawqt7to4qTxiWwbK
 VCfuwa/JoP6ulZK2OzvD9x1K6dTJGX5vv0odGq8UTxPKlKdUqcX+MX+khDRGf+7SiLwzljbdsOQ
 L9TG1ZJrS/DtVj5jNjZi0Dcy+eMaa4kiJl0VtrwdeC8+D/qeZQCM95rTHoSn5QXUfyVRpOYhqWL
 yRUs0xm3C8p6roI0itssNsl0e/1Kk4RMmbsKLrNxczOIF4yxK1evSpRuYiIgNUMuABrVNhS9PdA
 6opHeOQn/JQHOOAI+dw5RzirXxtQTJa3YsuQGwdEVEYESthWbAPSMCSYmO6DWDNcCHqoF9ANVxo
 Ca75QW3uIcb0rZ8XgKyeYIBdl3QI8KIF1niQ3IwWSZG3SStC7DySH4NYMpSfVAbl89zq6sNVB5j
 ybA0MpVDKpTY0Mz1lVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030092

Venkat reported a panic on powerpc-next tree where GENERIC_ENTRY has
been enabled.

kernel BUG at kernel/sched/core.c:7512!
NIP  preempt_schedule_irq+0x44/0x118
LR   dynamic_irqentry_exit_cond_resched+0x40/0x1a4
Call Trace:
 dynamic_irqentry_exit_cond_resched+0x40/0x1a4
 do_page_fault+0xc0/0x104
 data_access_common_virt+0x210/0x220

This happens since __do_page_fault ends up enabling the interrupts and
it could take significant time such that need_resched could be set. This
leads to schedule call in irqentry_exit leading to the bug.

There are many such irq handlers which enables the interrupts.
Fix it by disabling the irq before calling irqentry_exit. The same
pattern exists today in interrupt_exit_kernel_prepare.

While there, make those BUG_ON into WARN_ON. Interrupt is disabled right
after so it is not that severe. This will still help to catch the
offending callsites.

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com/
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---

This applies on top on powerpc/next tree.
base: 6ed60999d33d '("powerpc: Remove unused functions")'

 arch/powerpc/include/asm/entry-common.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index de5601282755..7da373a56813 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -253,16 +253,17 @@ static inline void arch_interrupt_enter_prepare(struct pt_regs *regs)
 static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
-		BUG_ON(regs_is_unrecoverable(regs));
-		BUG_ON(regs_irqs_disabled(regs));
+		WARN_ON(regs_is_unrecoverable(regs));
+		WARN_ON(regs_irqs_disabled(regs));
 		/*
 		 * We don't need to restore AMR on the way back to userspace for KUAP.
 		 * AMR can only have been unlocked if we interrupted the kernel.
 		 */
 		kuap_assert_locked();
-
-		local_irq_disable();
 	}
+
+	/* irqentry_exit expects to be called with interrupts disabled */
+	local_irq_disable();
 }
 
 static inline void arch_interrupt_async_enter_prepare(struct pt_regs *regs)
-- 
2.47.3


