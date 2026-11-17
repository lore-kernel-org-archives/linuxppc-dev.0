Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298F9606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WhIkscXw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTQHJ5t4Lz2yGT;
	Wed, 18 Nov 2026 00:16:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794921404;
	cv=none; b=LUW4zIsSQ31n39r6fGtVoql0HRflYWk9Q9/Q1XgnOYq48B2EeqDtWL8n0GR3hcbwMNrO//hN897wXYVE00g4mpMRdED+auoDGVhIdsjm23hVGfKfFl+e29XMpvV+PbcKtNKyvqAAbi2O1jMuqFzEBvoBL/KCneFafbcTzQf6KfZKB02gGCg5dUTQeHGV7lt5fqXeK2PJhAgM4yoGpkH2q/ujchg9GgIHZvtC+P7kYivvH9XS+YyYecos/iV661Xm6MP4ZWg28/i8rYQlOwAQxXlXu/LesJ/HcLJPp0eZudWwIWkLkSTrtJ2McwMXLJGBZcumzyEWiVUMDTiVMHjsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794921404; c=relaxed/relaxed;
	bh=4o4zHuDiwag70E4bU6LjMjF3md0zDjIwd0+5IY4NeAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIluuJE62oPmGBCQ7FfXB12VYSbYx1wqA3aluL7HMzrYmIR1Wh7i6v+7ELd0H6HG4Grxx7Vd0R4QBClIHMVNsbPNqD80+NdYpX/HUALn7zb8xWwdyPzspvKqnwoZy+kcJ+4Pfa7BEzs04D7gQkea13M6yKROeExOOkFyDJiNCnfM6INln6d2LGhnwTgZxKekJHM1k+Ruq8wvXQvvP4xkM54lKYsIJ03VrJQ9zk9+1WHmyh2rJS2cNtDiiML1pBx+MsvGD5+MjdLXG1ZWJuVrn9a32IzbED4CHiExAoTNezLBMB6HTE2YKumkq+X79Ur5s1O/2+i75lgxVF162k6u8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WhIkscXw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WhIkscXw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTQHH5VWRz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:16:43 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHBw8Ns2270990;
	Tue, 17 Nov 2026 13:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4o4zHuDiwag70E4bU
	6LjMjF3md0zDjIwd0+5IY4NeAY=; b=WhIkscXwZepg1cfqXzvpy0r5rlrtLkJGJ
	kVe6/5j8AxxbII3kikcJx9j/areWnYi+j7FiIUjfVi1Ibs3Fv1H7YP/HE3NNEqgk
	WGtLrzv/Dl6MZr62x2zgYTo+vVxcT3jAofcUZ8FPa2ywbd572o9qv11jnvqTFFTl
	+m3IGqnbjNbohGK0FqEH5PFJaRh2XUowIhPsdw1QD9LPCFa7Ntcv2yB/V8c3narG
	Sx+EoXC1TAcv7Fke5Slum/zXlF7h7/AEVcD/OlqGdB2o86oZrXjvBOD4Ab874dC7
	lH81s8v37DHuhYZaTdwGmSBQTW5SvZRKPpe9TJwqU7peMVdwFA0og==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxd2m2wp3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:16:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4t791514792;
	Tue, 17 Nov 2026 13:16:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j02juc41r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:16:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHDGRQ850987498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 13:16:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F0C020040;
	Tue, 17 Nov 2026 13:16:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158362004B;
	Tue, 17 Nov 2026 13:16:22 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.181])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 13:16:21 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v4 1/3] PPC32: Fix hard_irq_disable to follow tracing and lockdep state
Date: Tue, 17 Nov 2026 18:46:10 +0530
Message-ID: <20261117131612.707038-2-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117131612.707038-1-sshegde@linux.ibm.com>
References: <20261117131612.707038-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=B6UsQ+tM c=1 sm=1 tr=0 ts=6afc53b1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=UTOWjhEXSVwx40Q-rnQA:9
X-Proofpoint-GUID: oMVaW4W2nMcEgFLl8BY3ZwLBWZMwsGfH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX0u1Gk1uCvcay
 GjYVOZR8Wkmxu3PyZ3Ij4+2A2drO1t6yFGC2dPWEv4VgQ/xtHc+GsGUx7ISo0H68xPHordoCxF1
 wV5Y2HXyCdSRfdplfWFL0KTtqixa+4Y=
X-Proofpoint-ORIG-GUID: YhKhRw-R0U_WCb1tHCOx1IShGvgljHHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX+zezlp1Ry2b/
 BAIjh9HaSM9/rNB3uZf83bRCSUV7WX3oActwhNDnUF76K8EGJZ/Y7MXN5JSJzB+TfYCgdkyZ5yQ
 QFasrsESsafcN6j8RDoJTbiPYjEC2EEsbvsGu6lM5HcXJLE2a2kIXw3OqRhKaBbTFXye+CWuc5l
 yvLnIrJr9MC34i++uNzxiQ37zc4Xqj2j/nd+XMD1oa6w93QBC3QVB15W5kCG7Yj1WBO7lWKYHMM
 eVVyOy+9VnQdZNtShiCOWKbz+OrLOMoRJ4k/U9RndSPauVgkeafRDMJUh87JRDOMbeMy/7z39CY
 6NX2F0idefqiUMP+LOOip+B1DQJ16Y5hmr5KSNUihVONsGx0I1IkZu16ZtmwvEDykIy7yVV4Zx6
 ZT6CWVvhtSBF9mowSOg0zO2ZnybB4HCsaoDhRV6uU//Y+wNZmcngn/yon8enc4bHhn5tTAHlRQG
 BugX2AMqv+6+OdKDE8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170051
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

Fixes: 5d38902c4838 ("powerpc: Add irqtrace support for 32-bit powerpc")
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
PS: Fixes tag is based on the historical analysis done by Ritesh.
I haven't got a chance to delve deep into it. Note that it is old
commit and lot of code interleave would have happened since 
including local_irq_disable at some would have added proper
lockdep support.

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


