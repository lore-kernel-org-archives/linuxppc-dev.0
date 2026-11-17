Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1B606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QTY3Sx7l
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTQHC5VCgz2xnZ;
	Wed, 18 Nov 2026 00:16:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794921399;
	cv=none; b=BICb9NnmqsHR0LCE6r+IfVsJ8uOXppbQFHKtZINIfU3eut3aKobnL+i3JEc0B6L466AyBa4Xz4I4oDB7r8XwUyYDbEo5FrAhZlx8uVV00z+e7Tc5QPXH+KDOTue04XzWHMr3VTXUuY82BFN1bYLXzs+CIjmCVVFP010cRY02DSQGDAGgvp6Se7D62/VBv0UpEo4zU7dxvishr/tD5zxFDnLy73E/4mt81ez9fqhlpHrdEhXZ26rSaTJdwJmn23UqDsJUYMXuU1VvI75uRUL2YTELPevTRh1/YHBAfuNB3nN77bL1KsqW9D05i7YRBmCWtMw8rQo5ruwpyaEsVjl+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794921399; c=relaxed/relaxed;
	bh=cm6R1R2vCEewkg/KNH92sifk6exBKeKqAth5N7vwZdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oHK77NAGngFFLKgvqT82KKimgKJmczWJwixyeV92eS52HznWOaGzOahElnPoU6MOt+MlwAQf59S+3JqjFUdRpNfj00MBee2rfeeOnSRKH/1LYgpjkt2613/Y6rL96rb+CAKxbXGW2FBx8ZGbNDazPjctYEDjPgjRK5pVbvnW5rmWLkX5LPifhjb/nMRZcS3XijzJZnyVWNdOHzNLXVu55I0cX5lqap5hmweiCa9XSCnRrZFGske0llqSrf/TA/gD7WmEPmEui9fHNmtMihzvzhj7PU2V5nHBpGrRoZll+XpMMTsqhytHh7QvXOdPpSTM8GwJ+gr5P4U0sWtd/JCjgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QTY3Sx7l; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QTY3Sx7l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTQHB69myz2xlY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 00:16:38 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHBwNio1089481;
	Tue, 17 Nov 2026 13:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cm6R1R2vCEewkg/KNH92sifk6exBKeKqAth5N7vwZ
	dI=; b=QTY3Sx7lM362dgTnv+x6ODXGK324D605IrJ58RvqrjucVq1P7FA7KOSM9
	nSaA5xxRnhaNoz/hR4cYectUKMjDDQdmppJ8ElsN93D9/onmnDrhA+gruDelgA7D
	ICDYrITN9ZHeF03NT4rAKE8jY0mafEsHyj5udn9nXmjXxFcMIxPDXhDXCjsoi225
	aU6buMUcOMrw4qyI/YNk6mpFWlW+U3vlBzJmE2Ml6nmtLc/uB8l48hsrVmopecJn
	QuDdMVZ0NEKQkcIijs7J+YUYUh3saJioNhF8/4qMASvz8dhywzIsAA5qCTkoqpfI
	Wlt3szaKToP47ZlaaLO/KJT8HICOg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hxe2darsc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:16:26 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHC4r9j1803088;
	Tue, 17 Nov 2026 13:16:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt4cc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Nov 2026 13:16:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AHDGLHh16581058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Nov 2026 13:16:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7464420043;
	Tue, 17 Nov 2026 13:16:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56B6220040;
	Tue, 17 Nov 2026 13:16:16 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.217.181])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Nov 2026 13:16:16 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v4 0/3] KVM: PPC: BookE: Fix boot hang on preemptible kernels
Date: Tue, 17 Nov 2026 18:46:09 +0530
Message-ID: <20261117131612.707038-1-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX29ndNyD08frC
 Sd/NfS93s/eEo3jO9mSU7Bgz6A/ouUDwuOvv2Pw2wkRNDH5cqDtbWpdL8b/VQCS7elpiAGz0g5z
 7hwWh3fi9Wapb4b+MjAMVFHhdo3Gpl4=
X-Proofpoint-GUID: QQnBVqfmxoKEvc9MdzhG-bGMlsrdn-lY
X-Proofpoint-ORIG-GUID: iumkmghRL_LaQpdYex5rimoqsJ6LOjR2
X-Authority-Analysis: v=2.4 cv=IruL47/g c=1 sm=1 tr=0 ts=6afc53aa cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TEUKsyddKFnqGGVLVlYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA1MSBTYWx0ZWRfX1bMC8Clidaln
 B/eIkHFVXOCMy+YhK+uOIYAFe96ST3G/qBwB1DUieRx0TWIGbKW9V9j9yXRf5sgDf16/HhfTfZe
 HQXe4d1cpdBMewXl+0QotnxRZC1KwqN0AVEtEF2px5dhhTu+DcnYo7Gz6KZnqn50IxqU7y/3Qc6
 2GnmAeWC3tevLHcD7qOgm1D9Otoczfr4q//AzSAAU82YSaRmw9498WccaRxGTAhlRxrDiInFpP8
 y7PSMquAMHdBp2GJx5kte669IXTxMRc/ZxV3up9RoeIDR0LtQyKQNvpfWB0GpulT6YROQTXGCPz
 J5pro1aonLXWP66hL+TvKOwCEe9nTmshtPmsDrULYTGBv8M9zDm0ZqmWdHXG/cSthRk3fb1ibd2
 JX6DsgWL7404uGoa+NkjborVBZF1nCVm+udhQuQWgve1yQ8a5heQeuZVXp9vbLqmx/FKOB1R/NU
 AIisbtyhiJBaxpEIs4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170051
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Christian Zigotzky had reported that preemptible kernels don't boot on
his FSL Cyrus+ board. The board freezes on running either full/lazy
preemption and has been an issue for a while now (years!).

https://lore.kernel.org/all/b897b0fd-90f2-4215-bcd4-3714e497d773@xenosoft.de/#t
More details in cover-letter of v2[1]

v3->v4:
- Modify hard_irq_disable for PPC32 to simply call
  local_irq_disable which does tracing/lockdep in addition
  to actually disabling the EE bit. (Ritesh Harjani)
- Modify the guest entry code to use the above (Ritesh Harjani)
- Collected tags. Thanks to Ritesh Harjani, Narayana Murty N.

v2->v3:
- Comment removal (Mukesh Kumar Chaurasiya)
- Add missing booke change (Sashiko)
- Collect tags (Thanks to Mukesh Kumar Chaurasiya, Christian Zigotzky)

v1->v2:
- Re-order to avoid preempt count dance (Narayana Murty N)
- Do only hard_irq_disable on PPC64 to avoid second warning. On PPC32
  use local_irq_disable to acheive the same. (Ritesh Harjani)

v2: https://lore.kernel.org/all/20261110053238.3794500-1-sshegde@linux.ibm.com/#t [1]

Apologies in case any nitpicks are missed.
I'm surviving on half a night's sleep these days.

As said in v2, remaining usecases of hard_irq_disable will be taken up
later, which are in:
arch/powerpc/kexec/core_64.c
arch/powerpc/kvm/book3s_hv.c
arch/powerpc/platforms/85xx/smp.c

Shrikanth Hegde (3):
  PPC32: Fix hard_irq_disable to follow tracing and lockdep state
  KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
  KVM: PPC: Hard disable interrupts before guest entry

 arch/powerpc/include/asm/hw_irq.h | 2 +-
 arch/powerpc/kvm/booke.c          | 4 +---
 arch/powerpc/kvm/powerpc.c        | 8 --------
 3 files changed, 2 insertions(+), 12 deletions(-)

-- 
2.54.0


