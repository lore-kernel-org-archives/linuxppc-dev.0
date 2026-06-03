Return-Path: <linuxppc-dev+bounces-21976-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23531CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 13:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVp434p6jz2ysW;
	Wed, 03 Jun 2026 23:11:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780492275;
	cv=none; b=Pbt5elk5xjhhCNhvdBABNNuwGc/G1LQTnVQFEItnd88uir9W93R3jjRSVCHvhj8TtBFqT8SuW9LJosyBZcJAXsenThZ2wOZBNONyV/Sk7ZYsbny9qjqXgmrIG9oBXrga86T67xOLz0ECavuCrG/vWCHbwQN8fe/UQN7dhhR3W4ZhYxDSZIuXMmtrDfeBLEzosCJr2nagDNSeMbYuZYD5UdJz800vetbwZYNKhN4ZOq1DyHbJu21FrGdR3ED7mhYFW8MZen3NQg702LtgaJq1oUWAdrBTQu8dcDtchNjsO77Z+ErxNJlstTBceMxsPAzGfFBaIdm3sDwdiyyEvAWO9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780492275; c=relaxed/relaxed;
	bh=J2mj6bQI9UGUxssNJNX+eHlkDMFMpNYCCA0h8F8rE4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eez+NB5pdvUdlcmoIt++ILd0xNPpJvr8eVWtjBOR+ut6lpklud3hmOu6BOyJDU/kVZvM57D0FkKiiUpo1CayxgH4o/peSJggq7WklaXxlLP70G6CWYtdLU2Sxi+gEUNttIkgYo3kVJXs0zQg9teZ4C34VksTcpNO8OgrLAiZ6oH+IN83pC4jrFpof8Axu7B2uSuGK7NJfBDVcaK5SCD8lZQG3t9wYeD2+Y1/gkffk8WOe77dVVChREfmus3VkauBLOLkIwQJXUYGI5F4LDqsffylF9xsuFwRrOaaadWfamR9mtYGIRBfloEs1UVQYAihuEfiCN8KeNw00QFV83eARw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o5Ke5vQO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o5Ke5vQO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVp42731Dz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 23:11:14 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6535pFIs3621258;
	Wed, 3 Jun 2026 13:11:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=J2mj6bQI9UGUxssNJNX+eHlkDMFMpNYCCA0h8F8rE
	4Y=; b=o5Ke5vQO1PNTwwJJbU3tllgoCe33UOCGBWcM/OTNso2O12wm2kuGB54o+
	6JABbEY8//2zEpxX6ifcAqu3MSdcukuW3VtObzFCmziDxolYCVYA/EFEpjXjnh3I
	YCDolBRXolfObf+zCGIjz0APPIjxGpk661/8IjOLEMMSRvJZh7+3vgaRDUpLZlKN
	kL1j9kSeoG82KU0ehS/ohr9wBfVzryn/fS+/GAEfMnw7+cFvv6T+s+Bwq9NKffXY
	Z1fVTDrAplsXrdstoW2+yP5Efbi17DWy4TdxNC4HV6mqjLIL7zLvuX+7K3JOlVwq
	g+UstyQOPvPVuQ4GoKz9ZG6lhtmDA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd4b3fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 13:11:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653D9AAp028272;
	Wed, 3 Jun 2026 13:11:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qgfn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 13:11:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653DAxrE61342026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 13:10:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FE3120043;
	Wed,  3 Jun 2026 13:10:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 484EA20040;
	Wed,  3 Jun 2026 13:10:57 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.223.153])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 13:10:57 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, peterz@infradead.org, tglx@kernel.org,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        venkat88@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v2] powerpc/entry: Disable interrupts before irqentry_exit
Date: Wed,  3 Jun 2026 18:40:54 +0530
Message-ID: <20260603131054.216235-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEyNSBTYWx0ZWRfXznN5+ziC29sr
 Q9qE0JGEunsCP1VVTClf2FqDnzsbT/friMyFSoQp+fsmsMm7WowvNt+doW+gTKrdTh2Srt6ignz
 n9QNMKMVnzgXtMJ+cNRSL+RPmoLcodziQDzknTV6PM/s4G1GmebBc+z1FGBDoxnPjS1WCXYlGTe
 q1mMNdbH/x5M1qBn8zEwSUKtXP+X03T854HQLCX+EHUuUCx0/3vjUQWv6mmaQChdBj3fHRQA4En
 NsWMcWC9QOYgZ8nms1xC+RNXHWRf8qfSQrSmHHAY3dgx8KxKbZebXo9OQxOVkaIyabQs3pV6tp0
 bzhix/Gu9DjuiyLOscjIBhJ6AUsqK6daW2HQl53wCrri9JEPx75uTyoShy1e4jSWTvUXxqPLer+
 n5gt4vVdg+N/UHuGeNbhOEuCIJYPL60gdpEHXPF+bqarKsBZEEvnd4lofEbXiCTEn7VV/NfrFnf
 /RX5hZ4/N85XctiUTVw==
X-Proofpoint-GUID: X5JV2xoUf-lWSbPF707nhmUK_rgfQGoj
X-Proofpoint-ORIG-GUID: xTT3Jc2IBtqAfh1sdFezAD3lrGKENeee
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a2027e8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=1amGyU8xeiUMZXval3kA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030125

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

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/7904105b-9dfa-4efd-a5ef-bc0276ed255d@linux.ibm.com/
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
This applies on top on powerpc/next tree.
base: 6ed60999d33d '("powerpc: Remove unused functions")'

v1->v2:
Leave those BUG_ON alone since they are tracking the register
state of userspace (Peter Zijlstra)
v1: https://lore.kernel.org/all/20260603095521.198267-1-sshegde@linux.ibm.com/

 arch/powerpc/include/asm/entry-common.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/include/asm/entry-common.h
index de5601282755..fc636c42e89a 100644
--- a/arch/powerpc/include/asm/entry-common.h
+++ b/arch/powerpc/include/asm/entry-common.h
@@ -260,9 +260,10 @@ static inline void arch_interrupt_exit_prepare(struct pt_regs *regs)
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


