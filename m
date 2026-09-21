Return-Path: <linuxppc-dev+bounces-27816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06239C982E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 09:02:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpHKy42zDz2y71;
	Mon, 21 Sep 2026 19:02:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789981334;
	cv=none; b=bD9StObtrYphPtRzIWEP3VB8MWBmZbBZiZ+Ie+W/1h+Afalh7bkXe2JhtfaK7Fsw/6LfrZJwdE978r3AfKC/ZBlhWZUzR+rpOyauEcDIL8Mym+E204iPGCB6purRQjVfFdRVUA7eigPAB5DKACTiX2qTpuWWwHAnPrOgdNNLxLyt9KKe+D0ghycCdEAonNN72EILHOXsWVjITE11gG5QcrgIPzYxpC2W55HcoA4aG/JrcL709D6Ub2b/QoYJ4Aj1rIhorMePINxVtl7FDUOZyEMTEc4m4XjBvWgBBVQxTd09ulh4+IUFAlc+6MsGsallkCPxQ3N+O6iFx4JKOrXjWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789981334; c=relaxed/relaxed;
	bh=lVU5bXNZYPJng82Z+hQ2MJm5a+4tPpGlnygsU8bDr7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS48tgCEMaax/Ufzl4hbpF7cNbF0XjXCdg5A+9mJ37kUu3qhIQhiQGHyaYypdXNzAnKF3mmV1AoVQsZ3st3VzK4Eyk+CIQ85HQ0UtYrzk9H0UIYw9O9nA73o6IZSkvqrb8ltP7uEUJaFtVZFRnp+fs8glm31haWmy8Fh+OidBRXw5BGqlGJ0f1eQ3tRt1BpUlFRudICtHvu8j2s3FBAheGrAllJBeJ1uC4SDSeVolAuNGaNZLFWKvmstHgDuuz2EXTeL/Vo7a/EZtaCHTHtSrQK2n//AXkY+sI46a73jM73MtvIRur3KgujXzDPo9TaVe/VKr5jNHWrauxJLT1wcLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NPUY4DXK; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NPUY4DXK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpHKx4p6rz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2026 19:02:13 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7Zbm0672354;
	Mon, 21 Sep 2026 09:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lVU5bXNZYPJng82Z+
	hQ2MJm5a+4tPpGlnygsU8bDr7U=; b=NPUY4DXKm1TzCFpsuE/d4TZ0lcOfB98c3
	92RGcZiryjHxa7+Uv61h/wHgwMBiodfkKqSd8slDBbKwsCgnmYsyeKFLmoP/9+Z4
	v47t6B0/wjMncf4qrTvJ8WNZVkelQ7IQgr+KJYWyGPJI9c373N95uT6+mAVePXMM
	Vj9GWBrHUaRgMpdpNVZOJOZI9diZl3nFXdLHHQb7CULCEuE+sk+3Cap+zJR1shBX
	ct9Zv7lxIJiSP376uPyP17Z8s5rVtOfxMwsjf/GtU5i3o14oOVXZ3Ic8Hl5rF3El
	kjX0wwz0oFJX0sUezlAka/MzI/eB8D/ivSx0PNcUs0x80Slwu/sWw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske17gpu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:02:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7HaNk1835330;
	Mon, 21 Sep 2026 09:02:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dy4a8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 09:02:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68L9222848431494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 09:02:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6EA72004D;
	Mon, 21 Sep 2026 09:02:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A860920040;
	Mon, 21 Sep 2026 09:01:59 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.199])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 09:01:59 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com, tglx@kernel.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH v3 1/3] powerpc/irq: Move __softirq_pending out of irq_stat
Date: Mon, 21 Sep 2026 14:31:51 +0530
Message-ID: <20260921090153.54745-2-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NAhXtCkvhu0NTz2Jzdn4MIYRn0LXs_sN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfXwS9EPCB4ve2c
 OSozCHFfukbsNcN3fATdtTu48Z7v5ub3RbheMJlVsiF7g8R9/c+6ciXtF9mekIzqv15cHQlhkpc
 mtmqRSLskZhhYlTZGFQ/4UDetGNM8MEvyF5iwhJ/QqU1PeLfEjqPC741jck3B2JGBabf8rD3H7I
 DC8eGOQZ5gY01zg88EuNOW1mbNdPnKsgFAst7mmkpftYkaJgBjMwdxr2GNBV2c0Jkqk+DmmBGr1
 Tbh0pGocq+SSe1/V5nQsH2OTwaIJ2z8+NQ/XplXB/h8iLBvhmXRb7opQS+e6c39H5CB3iJOvJI1
 h5weA2c5Jy/Lt32kTbGR5bApEp/lxOu7J+Tp9VOgRPSqcKjmCGkRx48liRv6H5FgnRTWCMqtCij
 G8mob+QZINsUH7FonZ0Rhv6QlHf/+eftoPJ5+HdbgbA85LJwce3P9LzFEvIBfFuQ+aMibQVnotV
 Y6wmY5k/OWIOmB8fpMQ==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab0f28e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=C94dUP7i7d1QJr0i2-sA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyMyBTYWx0ZWRfX3tJ/M6v+V3hd
 em4LlYawm21IwnJapA2kiE7dbW3cbgZQXWIWl8fmNXuUfWWNhvnkdXnvggZPCmGOD/ypqzjPt2q
 OJzeHZvbw68AFUGjhIjNGr2zSbdaUNE=
X-Proofpoint-GUID: PFyrBRmoRqmHdJWQbDsWQk4AfkbflBau
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210123

__softirq_pending isn't part of arch specific irq_stats. It is used
by softirq core for various decision making such as whether to kick off
ksoftirqd.

Move it out of irq_cpustat_t. This makes it simple to make irq_cpustat_t
array based approach.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/hardirq.h | 3 ++-
 arch/powerpc/kernel/irq.c          | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index f133b5930ae1..bf3926a0c69c 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -6,7 +6,6 @@
 #include <linux/irq.h>
 
 typedef struct {
-	unsigned int __softirq_pending;
 	unsigned int timer_irqs_event;
 	unsigned int broadcast_irqs_event;
 	unsigned int timer_irqs_others;
@@ -23,6 +22,8 @@ typedef struct {
 } ____cacheline_aligned irq_cpustat_t;
 
 DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+DECLARE_PER_CPU(unsigned int, __softirq_pending);
+#define local_softirq_pending_ref       __softirq_pending
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 15a3c3fd8e70..0a4daceee293 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -73,6 +73,7 @@
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
+DEFINE_PER_CPU(unsigned int, __softirq_pending);
 
 #ifdef CONFIG_PPC32
 atomic_t ppc_n_lost_interrupts;
-- 
2.52.0


