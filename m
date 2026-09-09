Return-Path: <linuxppc-dev+bounces-26906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AD6C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 09:13:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfw7w3gMWz2yql;
	Wed, 09 Sep 2026 19:13:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788945180;
	cv=none; b=BsdJov7SashR7k4gL+if+zkFknR9l9Vk9jO5ZhwMeU7B+XxQg+9kWeOLe56Mj2ca2CFWjhgEMxkYyeZKxKytuftYkPr0E1dxbmgizx7APpGXfbKpGhMTTCJsc3gTHCvBIfwM7qnaeqBYV0uoNUmV9a+N9aGOl1WqG0Non+x2H/vrDV89rE3Z1jiBup9hqP2NXYvVlvNqu+Q5vu8Ok2BmsRqBgiz7g5CilH/IswhSeP9UijtyH/aldhfkPP40V45E7ocQkxKYfoS+psbQ58vBCxIAJTtZc6meCFal97OIH9spAp0J44H6+SyKIlrSihrOn7pCGOefkG+0yyKliUfI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788945180; c=relaxed/relaxed;
	bh=aL44NMlEmnP0cOhxvq016XuarvBF4/7Bfud/MccEELs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OHcZNHUtX+hb/X/7zKESykMjWHhlpQu61Lo9ukZoS8yJbVCFYM7ycJ2O0YfDYP3margLRpY6/jlWh/Hm+OYUjRJgj+o0lNRKjkCZ7hoeyH0ZvkKybTaHqqRc12ZEpqzQJMswozqjfAuvdo/lg+LDXfr/Nkxs/G5ZukDsblthH7OqSOlFHeibrQg78NnqutFLSKbptFA0rfmo9w4j6VWnaThethhpwR/UVph1FH9oK6ci8FETwQqS60Hlr3n77wJEnhdDbInTMXlkQ7o+lOOnJQOHRF6fGttuT7+0U/HxaFKP8iif4FamjgAyYbbXHpgeRHkXlo5ZiQ8a7s8yB8eDnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JLI8ZcmE; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JLI8ZcmE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfw7v1mNZz2yqf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 19:12:58 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1mKu1116891;
	Wed, 9 Sep 2026 09:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=aL44NMlEmnP0cOhxvq016XuarvBF4/7Bfud/MccEE
	Ls=; b=JLI8ZcmEUnlHAI30T7UZWnIfFOs3J+QnZZBcCJ2wIoQIR4lJDHo6ugDem
	O0AfgPGGNDvI4Hpo85r3ZxBlgX6bwi4UiAgLHt4CU29dQRL7Ocf65iPQWuFdzcn/
	yLhN0aNCpTyVpikxP58dWrkc9ni5Azc/4S3lDuZaOp/e00ncJE0eZXENyuLRvhiL
	VfI30NB+2+gclFBrXwK1s7VKqgD0yl3EiYWw9mCVZyACiI/zH6FGRwSOBjkywFNi
	ojeyLVWYP/ELXXadUkyo4kIbMdUzEYan0RFgKY5gv1WyaD2rfDTTbdYjJkQWCHq0
	CzMoOAbAsNeZ/LR0YngpTOAFMjriQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrvhn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:12:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6899BHDo002988;
	Wed, 9 Sep 2026 09:12:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwh9ann-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 09:12:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6899CSUJ35455376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 09:12:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9068F20043;
	Wed,  9 Sep 2026 09:12:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B613D2004F;
	Wed,  9 Sep 2026 09:12:25 +0000 (GMT)
Received: from dhcp-9-123-0-173.bl1-in.ibm.com (unknown [9.123.0.173])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 09:12:25 +0000 (GMT)
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, mkchauras@linux.ibm.com, mkchauras@gmail.com,
        sshegde@linux.ibm.com, ruanjinjie@huawei.com, ritesh.list@gmail.com,
        riteshh@linux.ibm.com, venkat88@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/interrupt: Use early_radix_enabled() in NMI real-mode guard
Date: Wed,  9 Sep 2026 14:42:19 +0530
Message-ID: <20260909091219.55380-1-venkat88@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
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
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa12301 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=892i79BrHumYIT41z2MA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDEwMCBTYWx0ZWRfX4N+xm7YWwftk
 31QcUHydXjC+aq3sbf3J0vlKbwIQHxRFcIXpjLJnGERWukPVjk6fhoE36ccNtFwDn9er1S8QpTB
 ugKqeS/p572it2L5UVJ4v6IOger4L7k=
X-Proofpoint-ORIG-GUID: YuZCjM40QeBJpw_CYZ7QTbsLfznDubbG
X-Proofpoint-GUID: 31FHbtT2ZcS-8dmLjpFXMBCuNG81LI0t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDEwMCBTYWx0ZWRfX9dcMqGGHI+ts
 zMgZV7u+j7vrTid4sBc0GpkG7lcvgsWGv2mhExAfOeL4ecQZ93uTLmVAfC9tWD8wVM6oiP0HCX7
 d7wrxnqfMQaGJjFfTI2iptnaAi0ZiznDtGmWwgSgUla7PIQBReT//SH0ym10Cvr3D51/MBAMu07
 Mt7tuJ8x954ySPrELUhni/BwFdBHqCzIeByPuzfnzz+EfMhA/G1TQf01R8qfHuCq50ummYFBi3S
 /lKCNS1kJYAmLWR+dazOR26y+onIFtY5kCTWwuuQr2Z2THtzoCnS62DbtBA6RsE7SGdkI6DF1ix
 CvUlAZASc+86QdS5dPoQtnVWgzO1EaqtIj0exaZ84R3cJVPEM6EuW9rffVRYA1pTVm183ILuioV
 F61PzDW6WcQpr5655A+aZXhtKkZzS9cMy6xNAKBtnV8JBVf4YeuZo/DmqCZ9nQxp0hujF7IEXQm
 1Ptyb1ZDD2fkZqhkOCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090100

radix_enabled() uses a jump label which is only valid after
mmu_feature_keys_init() is called. Before that point, on a pSeries
hash guest, early_check_vec5() clears MMU_FTR_TYPE_RADIX in
cur_cpu_spec->mmu_features but the jump label has not yet been patched,
so radix_enabled() incorrectly returns true.

Replace radix_enabled() with early_radix_enabled() which does a plain
bitmask check against cur_cpu_spec->mmu_features and is correct at all
times, including before jump label initialization.

Add the missing #include <asm/mmu.h> since early_radix_enabled() is
declared there.

Fixes: 8d0e21012743 ("powerpc/mce: Avoid nmi_enter/exit in real mode on pseries hash")
Signed-off-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Reviewed-by: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
---
v2:
 - Added Fixes: tag referencing commit 8d0e21012743.
 - Included <asm/mmu.h> in alphabetical order.
 - Added Reviewed-by tag from Mukesh.

 arch/powerpc/include/asm/interrupt.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index 1b45a49e9bed..355f6bbf9894 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -70,6 +70,7 @@
 #include <linux/irq-entry-common.h>
 
 #include <asm/kprobes.h>
+#include <asm/mmu.h>
 #include <asm/runlatch.h>
 
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
@@ -290,7 +291,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
 		state = irqentry_nmi_enter(regs);			\
 	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
 		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
-		   !radix_enabled()) {					\
+		   !early_radix_enabled()) {				\
 		/* no nmi_entry for a pseries hash guest		\
 		 * taking a real mode exception */			\
 	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
@@ -307,7 +308,7 @@ interrupt_handler long func(struct pt_regs *regs)			\
 		irqentry_nmi_exit(regs, state);				\
 	} else if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&			\
 		   firmware_has_feature(FW_FEATURE_LPAR) &&		\
-		   !radix_enabled()) {					\
+		   !early_radix_enabled()) {				\
 		/* no nmi_exit for a pseries hash guest			\
 		 * taking a real mode exception */			\
 	} else if (IS_ENABLED(CONFIG_KASAN)) {				\
-- 
2.45.2


