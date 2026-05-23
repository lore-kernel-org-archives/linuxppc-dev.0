Return-Path: <linuxppc-dev+bounces-21431-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBB9CD5BB8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 May 2026 17:40:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gN8ZF3zxWz2yH3;
	Sun, 24 May 2026 03:40:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779558053;
	cv=none; b=Twzt/EcK8BpwtdP7BnOP6/ZBhWeVdnEHUgrAB+GsJ3C8J6Mkvr0Fb8fQVjTRjEX+i+7RCidi+Iml5n0UectMb8UmvWw/ZGmIeOKjVCUMzAaREu65RyQZb/xrvzTAOcsK9j0rLYTvJ/xeu6PrtR7noAAPYWSI+m0Z+WSAu+20C+CbdUQ+EKstxaGIHC3MMPx622PsJvsaJ0f4t+ZDXnguffSjJMO2dJX0clw4HAvTZoGBsX+Rd/Ew4S5ZTzdujvwHx/P7E4eojD3WpQf7BZgq8IEFHNGoO1E4UU/PTRuupbWdAPt2qsnFeXlz15znl6kUORxJ+GSiGJKUCXsWksucFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779558053; c=relaxed/relaxed;
	bh=ZbxDH40rz6mpWxjdfzWTtSCOuAdoPUNo8un4bsQPEYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUHFeVHGNbalSDb6PVJhAdLX5AzjnS31MnNZhESHXiMh/ge0/RQhlC139+ykCTZKSjzQ7vfspEi1eDcX6CdlaJ8f8OX6xoiJagoQHrm2WIKLR7poPNdLpyDteyn8dZf1H7wUiwGS8xj5AoH5PqLr30SceQHV4r3A2wIkdukSqoKufDd0J5IcCa/6SigRCZ2dOSdUbqbmkfENe2F3ErR04zlwKr1L3dbAuZ82Kt72Y7XMjJ8iZSamC/R9za/okUPbcVbFuoYvGmBVuKEqkpfoOKLN/m0RDulZLWgXTz2J+2GAYva5Ykxvk5pNCWzh2ry7URx+a9sINJFurXdr+NU+QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LLe0dQO+; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LLe0dQO+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gN8ZD1JVPz2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 May 2026 03:40:51 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N3mebo2452222;
	Sat, 23 May 2026 17:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZbxDH40rz6mpWxjdf
	zWTtSCOuAdoPUNo8un4bsQPEYQ=; b=LLe0dQO+RsUGukSAnALxGukPNWwoe5vBX
	n2NvCcPVaS59sVKB4jRNCXZjZVvStCO7VsM/OTep6VPb55wYE6VPv3K0naBMqGPE
	GzQu8S/ZzZGR3E2Hqc0N/XU+jCjGzZjNhu0OCdal9oCygGU5NusbxibHfkKMggG6
	+RwesbfTr+D+Ln9YPOkOVnun5YyX+6cQqtFH0rSqgYtfZEjBAkjg4y1HGHBHXWvh
	VA+lSTORSTbCL1Ftydt8gdEf+qCjO3RN0nSpxNpT3cvXg1o4wj4eQOkFb5D4bNrW
	yZEeVdQjWEiz6MACowo9TjjrfsyfWeIOojMk1XYWDmDJPNTULqEew==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nbshaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 17:40:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NHd8Mq026028;
	Sat, 23 May 2026 17:40:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eb46nhyap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 17:40:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64NHedQa57344356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 17:40:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5241E20043;
	Sat, 23 May 2026 17:40:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3DDC20040;
	Sat, 23 May 2026 17:40:37 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.18.40])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 23 May 2026 17:40:37 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: sshegde@linux.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] powerpc/irq: Move __softirq_pending out of irq_stat
Date: Sat, 23 May 2026 23:10:14 +0530
Message-ID: <20260523174016.999456-2-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a11e69b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=C94dUP7i7d1QJr0i2-sA:9
X-Proofpoint-ORIG-GUID: tUlOoTi2SuESh5xW1gaEqK_Z1vRfi8QV
X-Proofpoint-GUID: tUlOoTi2SuESh5xW1gaEqK_Z1vRfi8QV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE4MCBTYWx0ZWRfX5kcRR6UTnzKv
 e60oD4p5Kia6HSIWOnrCwh5WqEYj/LtH1/mOmX5QKBjW8oMYfeh+cnVZh01EVS3fR2PsWPlotA2
 yyGimbp0A4mv++uZlzgBvg1zJwj7ubSzUq26Llv36H98xm5nfSyQ+VTH/Hxu//DhQMhXfCe71el
 rkpcRz3FRPiJFQ4iUVVPyd0Pu7b0esqKX3WS/UAeRvjHCMTAfVqD91HohKyLTzP1AY1K9aLRblr
 HkwjzUIhqmVga5vGSaldYm0Du6J/RLDp6qzhBu7WhEyH9poj30RcF+Z/6WqtRNNMNIEfoGHfw26
 E+mVApWa6U9TVIff9L2Cvwbs8hjI9tAwaPp0AGtN3UhIXIj8dlej/BWOcoIv+U+CraqoAiYOIto
 XYLaupy+0V60QawrLQy1qLgyj/a/chle4TZS5VdFFOodtXhYfbywa6YZMhyNHCcOtmzvPDd6oBB
 CPwP7ZRC2JEg+XzkCMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605230180

__softirq_pending isn't part of arch specific irq_stats. It is used
by softirq core for various decision making such as whether to kick off
ksoftirqd. 

Move it out of irq_cpustat_t. This makes it simple to make irq_cpustat_t
array based approach.

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


