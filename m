Return-Path: <linuxppc-dev+bounces-21717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A280CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 12:41:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRjdb5kKcz2yQL;
	Fri, 29 May 2026 22:41:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780058467;
	cv=none; b=Ejj+yyCtap0pveW/u6L+83O8nDcaTvSH2G/YtDph8BGI0m6BUe9uF+zwJt+XckyjbjRBVBPkAwtoiqVVqCXzbEAbRiz8ojTQZs1BqDCvHTotQlOo3DTEFlYNahVKFx9OmqjwCp/YxH9xOGosNUMBC5PVuY8vT0gaVoXT7StA+mzOsKEP1LHG02zgMZwYKRrduHr+zaanbnvn6/XUVm8mgTQuy8/E2aoX5eD83JjD3z47hAf+NzpOFDBSHRpCiyIEZUWPavgTbiTQ/4j/tgEqUiDkVyRM1jCYBgQKusimX/c6jn3ONos5nS4l1jcjh0GT7MkENFB34OzQUFirCzJHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780058467; c=relaxed/relaxed;
	bh=10wEjxb/3eCHVCavXPjmux72EYEyL2u7FlboiX34A+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XoZHuRbdiHkhWaKKYW2IScFETKwwcuBpVFw30QKMmx8el7EpcVaEhioncMh3o/75x1JBd01ldodGUXOMXzPBW3Zu3PweaHjKZbol90hyELL8nt6X5YZTaebypLarAuJnoOS0iRms6SnVpWc9vP3bxv91H7r3CoYr5U/NspMD1dx2Uh4C2l4Ez/y6d855Lcqcx1GN7JIZuhkqwoImQfmUuO96EpyixBhuxXVl1BywYowsDIhQcAZLb5A0Sib2j0/bxBRIj63UyJwtRvznfBlaiBX4e08J7vSeNI6PZzTR/1PYiDQAv/E62lcaeNIyhyRAthggTNKc9oBcSvlldX7rLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hio5bIz5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hio5bIz5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRjdZ68vcz2ytj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 22:41:06 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TBaP5A1467859;
	Fri, 29 May 2026 12:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=10wEjxb/3eCHVCavX
	Pjmux72EYEyL2u7FlboiX34A+w=; b=hio5bIz5JdwYrHGrYxcLMsAHtSYw1q5dl
	hYJGzVPsmTqLPfnLEKyaUVzvqJQ4885WgW7Ts1GywthhwvQpPX0k00hl1jrx2xAt
	R2Kvbjg72tyL6dIwLsXpdYuYmFRMOVHl4RXA6x6NQJaZlIRJaUC8Xl9KW7f8xYRX
	KOGc3gW/oqGpDEg5J/GVHDt28h5nmQHU0bSLRuvEd42GWYSmwwypkAOOmaNJaVvW
	WG+p/LtqjKqAgBh16Lp4nBqNwwR5Mo7D1sdS2V6c5VJUXI2/6bgA2NbJ7GZ4puIi
	1S84FktxboHsBcpM1oP6jUtqQW0gBwv9bPNBLC9In5X9/2k3E+0/g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee886gnbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 12:40:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TCdCu5021891;
	Fri, 29 May 2026 12:40:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc5jb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 12:40:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TCesZg40567294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 12:40:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F65020043;
	Fri, 29 May 2026 12:40:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A33220040;
	Fri, 29 May 2026 12:40:52 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.221.69])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 12:40:52 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: sshegde@linux.ibm.com, linux-kernel@vger.kernel.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH v2 1/3] powerpc/irq: Move __softirq_pending out of irq_stat
Date: Fri, 29 May 2026 18:10:43 +0530
Message-ID: <20260529124045.1208539-2-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: hsRpgoWojZGJXdh_iL2ff081RmoIG608
X-Authority-Analysis: v=2.4 cv=Z8Dc2nRA c=1 sm=1 tr=0 ts=6a19895b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=C94dUP7i7d1QJr0i2-sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEyNiBTYWx0ZWRfX0JssiNn09OC4
 eske5VSmW/c7nhXIKV4S212jLdFFbDP+6tiEJrr0W/K4fdJDsI7lDZzPtoVdRkW054q51+xrsg6
 7ulAk9P1HB7Frayjlha5cVZVmBF7gwu+i2nCUY5FD5ss1ZrVrlZU4G3JLr5pg6uT28Nju9m7Z2z
 34JMfbM9cKBPbLjfO913Isxg7fLcp22ruzkajEs/sMDrWvKygZinN5Jm5KP2mjFxDYPhYrAEsiT
 UcDNE2P+4I0A0WfQTFH9KnxmixQxj8d4ie5BZdvJv6HCq0PZM4HFWeehpiZHOMFm5swtupnctWk
 3sPZ8cU2PPvEuxveAWHnYGlVQL7FNFW1Tie3qyNJ0TKNYVM3gH4RG1jIXjDHy4lFzCSRbOY/GRZ
 aHe0MixgaxVY7KaLEsCHx45uWPNSipY513d4ILCRvS5AJ4dKawrX7LgUBiaaqJSUS9xmukrE+fS
 zX/BZ78QhBkWZbk8wVw==
X-Proofpoint-ORIG-GUID: hsRpgoWojZGJXdh_iL2ff081RmoIG608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290126

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
index a0e8b998c9b5..f33df5e5c23f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -73,6 +73,7 @@
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
+DEFINE_PER_CPU(unsigned int, __softirq_pending);
 
 #ifdef CONFIG_PPC32
 atomic_t ppc_n_lost_interrupts;
-- 
2.47.3


