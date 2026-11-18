Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67685606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 05:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AaCXAoKJ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTqXr4Gf5z2yLF;
	Wed, 18 Nov 2026 16:14:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794978892;
	cv=none; b=boOVO5/DGO2hYSw8QdeQ9EVn3On17AGppeMbl/rlPQ57tgUNB+sDDBcbqgR6BLU3bfkeJz9HH6JQh/K5y5pFLi9n9GntUMAzXatNPtdFQhdwoQ9npumwFkVG84POmv7wHznA2kKbYNIQywIW1t+cr42ct1IBMvA1+OObVfDnNr7pTlECCXDMjND9bqMV9m/IImKHntqbz/XwD8MqOoHQmU3S4gAV7gtT6xVHWV0DKAQS+htY9YgiVIHdab6q2LXvB4hH5gOE0++VUGP0n1Jc8lgZjMF0GWWI/BfqF+bcbf5Sl5Cr3UaoC6V80gjaF1+EVfOLE6Vr9VfHryFKc8enmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794978892; c=relaxed/relaxed;
	bh=/6KaE7xGisRHQL2pZ5XkTkcDmLT7cT0gvLUNhjy8lPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1cOEHw+pkjhpGFfqNqya/pN4ysHlTEwkgbTcVnlWVOhep+kpEe9qkoifXPOLhf9JX4BY4bGf37+vStaptzLujCP+fRyTasX2NY0qO0Soj+5Gq8K6eOM9W470UvAuYQWwqMi7fs1rWt4DUWQ6AiW2ZH72pDd2+T9aPzRojdr9OCZIk9XUhilY/MEGbdGrJNPWBUdtuvA8z5LDUWZwKYDVXfMqIFPJQ49WFeNpJBFag6IkPnAl7+kFWhCShJV9XwInnYl39RRzzIf31Mzfc9HzSuGEljRdztN4x0Ki/K2uTKVUMwVjB3oHC3HvVJVHtKIJl9wnVaz7+yR+TOb2kGsGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AaCXAoKJ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AaCXAoKJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTqXq5bFLz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 16:14:51 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SHqK4045002;
	Wed, 18 Nov 2026 05:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/6KaE7xGisRHQL2pZ
	5XkTkcDmLT7cT0gvLUNhjy8lPk=; b=AaCXAoKJw4gbH/0NR0Jn5GP/t3hyrYkR+
	bnZiBdRh8gD1m3HUFOrjVfVKcaHxzzOR59cOOmXTp9JfaGUqvx03b4RYdK2DR4eV
	5Jmf3jrS8BL0MkEz8M6QkUu5fmD2o6PmtdTajDfZxnNtPeHREzNwMn5IT30OrqGc
	y9j8B85VAebvJB0U10d4nhLhFvf5yVhk0jdDjvbrcSLEewc36XUpiPZouPMW4wCX
	W3WUrN5loutpc5sFffI6Al0AQB9jONWynS91qcFfxXW++7gY6cDPUeLgufdKRxX2
	ALJCNPw/wUSKQGbPogf9gC2RB29q3+v4+YmzKVPRLzbE/rmvhqhdg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wrxrq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 05:14:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2YtBM1428861;
	Wed, 18 Nov 2026 05:14:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dffwyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 05:14:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI5EYOB49152304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 05:14:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66DB62004B;
	Wed, 18 Nov 2026 05:14:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6361320040;
	Wed, 18 Nov 2026 05:14:29 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.10])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 05:14:29 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com, stable@vger.kernel.org
Subject: [PATCH v5 1/3] PPC32: Fix hard_irq_disable to follow tracing and lockdep state
Date: Wed, 18 Nov 2026 10:44:17 +0530
Message-ID: <20261118051419.783878-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261118051419.783878-1-sshegde@linux.ibm.com>
References: <20261118051419.783878-1-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IGLee--yC3Poim3REU9BzHMxsnhCM6D8
X-Proofpoint-GUID: 41sXIPfRQR4BugZCTOdVkLi2TVB7lRVB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfX02FdU2ZEwabr
 cq27CazAXapoft0c95T2P6nTwxQqFY0QYYjtLDPeOBreSCJEMJAF8Dko/k8ietmMhFYyBl40ZnP
 jMId4+1UgJOjppwiHBMdJHMwShwhLlQahnIRKDzlWlDn6ntgnXH0c5POm33Kb43NhCtv7SeRybK
 MfECpLe+MPXB5+gKP3rJ4mC6e856EEKOq7OQ4YwgM5wLimLYlSSD0c6HOrBoqEGsNaTdnY2DFd+
 Oby8H78xjySNAWYnTzt87A/J5RUkU4/LUpbW8H0B2pZkVQ75OPlQa97d/l6MTFx49m3sb1C3muX
 3Ui+htBuJu027Iw8CbdKoIHUxiKHssNYYOMRmA0tvLdUZdsSM/glfK0nzjkHeu0iQExhdB2/Jk3
 /t/NDFvIBL/w2EJehhHYRqfJSwehows7RdLgBc7qBb1iGBoEwuw+t3WqIBKmuNCMAe1oIrjv4XJ
 Wxo94GSOOIbB2fxjIXw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfXzjaY+llNeAu2
 fU1bN/e0/lcUwE51U8s7Aikoq/0uc9UesKAC3P06JCX+vriVktkNlndZuEMsKw2lMpUWh3Cm7hF
 E+vcexlRK/vGYL60D73KIiHJV4VncV4=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd343f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=UTOWjhEXSVwx40Q-rnQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180019
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On PPC32, the code for hard_irq_disable has diverged and it doesn't
do lockdep/tracing anymore, leading to use of both local_irq_disable
and hard_irq_disable on PPC32 to overcome those.

That is un-necessary, instead simply calling local_irq_disable is
enough. It disables EE bit and does lockdep tracking.

Subsequent patch uses this API in KVM code to avoid the warnings.
Wider use of it is possible, but it will be taken subsequently.

Cc: <stable@vger.kernel.org> # v7.2+
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
PS: New warnings would have started since commit 
12013e3d4695 ("KVM: powerpc: Use generic xfer to guest work function")
which added local_irq_disable for 32 bit. The proper fix may date back
years ago. To avoid backport complications, keeping it backported till
7.2. So removed fixes tag and cc'ed stable.

Also, 32 bit shouldn't need hard_irq_disable. But that can only be taken
up subsequently.

Also, below fix isn't needed anymore.
https://lore.kernel.org/linuxppc-dev/a14571be1897955f43d9994f0e093de3ada6ecde.1793447880.git.ritesh.list@gmail.com/

 arch/powerpc/include/asm/hw_irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index b7eee6385ae5..ddb850e62abd 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -464,7 +464,7 @@ static inline bool arch_irqs_disabled(void)
 	return arch_irqs_disabled_flags(arch_local_save_flags());
 }
 
-#define hard_irq_disable()		arch_local_irq_disable()
+#define hard_irq_disable()		local_irq_disable()
 
 static inline bool regs_irqs_disabled(struct pt_regs *regs)
 {
-- 
2.54.0


