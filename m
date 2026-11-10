Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60952606A326
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 05:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PtMtKhp1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNwKZ44nQz2xjN;
	Tue, 10 Nov 2026 16:33:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794288786;
	cv=none; b=mUQwETdQc8JhnH4CuLJnIPpbB1Rtm48SL8jYjEoOs7AnGzde28vStLgEGJIg2oHwE0ZHb89aSGl+EXl47X9zIalPLUV7tPSnoq1TLf1J24K4+b+ZHK4CLMbzRf6pmCEGqQPloA9ewpT7XVatczplvetAUKX2xAglbzxv3PuWS0DMtHjuNTQs0HXu5T7fxO6X41UNJyoDgggB+EyHK39bOAQuOxRPXoryqtuGWlhyEvwJSopJJ147i0LqIwS82ZOoXwxHYF3ZjErabgTzH4AEY4SPeN/OtTGpGEeqn8o/nm3SJfe7sKdval7Tpqn1IO3v6epxYnT0TmuANV+DJ1+AkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794288786; c=relaxed/relaxed;
	bh=RxjhOJPtxGXRPBiXJrXVTTCA/1rPniNzH2vown9X2+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAgsaT1uR4jwMLvJhlcmYP1rAiwj9cVgJsbDoyL6Gda5ku+QwzIbFXevsDCF4m4GaOQVDeAiZokcVycEOy3CEVv7f4pBTaOHPvLAtoGPLPA5t6JqXpdbWT0esxjhsbz19UwTQf52EExvJbmGCR+zV/AJ9D8S/TuH2uNgH//B3K1xLfQXgvv3cjciWVtvfrYvXMeFNwBoGEtbVokFqi00VAbFzmuHQcWGcy9dopoTX6264VLflAzJJUj2ePUfMxKem44K8nancXOV9Llz4WPWSUwCxJe92d9zy7s5Rl6qCT5BS3nQ6bMzHF8nfVgfu0kk5VReNqu9bGdV79y3AVSWKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PtMtKhp1; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PtMtKhp1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNwKY3h0Wz2xf8
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 16:33:04 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA528Yi3985620;
	Tue, 10 Nov 2026 05:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RxjhOJPtxGXRPBiXJrXVTTCA/1rPniNzH2vown9X2
	+g=; b=PtMtKhp1c/5WGhG+2g3IgaLhqbGawJu8TtpVb4yOUiIctgVijKQWkDKZv
	USk2K5MUz/YYH9yxNZ+r/pcRLI1J9z92mJUvSgM/SMov9WVcLYTcSQr7G1VcCJ20
	2gcr/arMrEjL/uuGIeqnMYjlIWL+weJ2LiLOIEoEQYsJNbv0ae/4mo6p05taMnrp
	b5m8bFBnfEmgU3aMa3rQ8nyEzUIYxuYx1Ltd/8/T5nq4qqZoFyNeyjOYjxA1l28A
	cP1m6qeGi0t8WdhEEvDf1emraviqFqg+ZE+zmIR1vUw98hCvSDtvCSR+Xo0dIM2O
	DMcY7Bs41qW7I21iXF/8czf0hhrTw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt3c40-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 05:32:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4JtQJ099306;
	Tue, 10 Nov 2026 05:32:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghg50rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 05:32:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA5WmhU38142326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 05:32:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E17620043;
	Tue, 10 Nov 2026 05:32:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB23C20040;
	Tue, 10 Nov 2026 05:32:43 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.31.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 05:32:43 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v2 0/3] KVM: PPC: BookE: Fix boot hang on preemptible kernels
Date: Tue, 10 Nov 2026 11:02:35 +0530
Message-ID: <20261110053238.3794500-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAyMCBTYWx0ZWRfX7SmTiYpQVO83
 O9A8IiS+gqxsaxHalo5K93/qSsnbNm1bdPk4HQlUksoPQkyIi+ShV558a1mLaRsozpeb3PmW9j/
 z6PpW7Ff8YwclZY9XRHGjJAKcg+RtAvgOMvRZjpHEzsbz+l5DuX1Abec9FI0gLCMWdBJfmv56fj
 dT1IyiDJXOWoZovX28u8e5zsxupx4sqdIrmlKwdY6InhN3wcSit6WUvvfhckU9jz54CDM9qvCqv
 XmG68XYvmEHxkxV4RwYYzwkvg0tLnblCmuhqcoln+5K7HO7LPUsJFB8NE36iSa4OyOh+qk8WSLR
 uG6KOVEXB4oidN9lkajsZYMuoVhbBCZh10NN9aqL+h2MiTrUxlETur4oYf4fpUQfa07MMn/vJl7
 K45qDVwd5injYJVIXprADUZl0irdEn3xAJ5Cd+4kBRBsQDD3HijkeBqDCdFxDjVjMJv3CmATlHg
 Z/WrPb/MszLe6I/yweg==
X-Proofpoint-ORIG-GUID: ur6jOE1MD5IweUcx091tEt4NmVkk4y-p
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAyMCBTYWx0ZWRfX94sWsxKMSIVs
 a6rdFnryC2jFks4f1wGwp7xXas5hFd+QZSNAo/B7nC8/GPmi27srhs1ZGT3ZJ63aUaAMoMmY4+N
 EUU1oi5rZBmZiJ2UXqSVVR48tHDeeNM=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af2ac85 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TP6vnLs4_apDoI4o4IoA:9
X-Proofpoint-GUID: zblinZSGDM_-FHEVuZgq4qMDHW1n05Ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100020
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

After 7.0, there is only preempt=full/lazy which removed the
preempt=none/voluntary workaround used to mask the issue. There was
challenge is getting the console logs which made the fixes difficult since
one couldn't know where the issue is.

Thanks to Michal for helping in getting the logs. That pointed at few
places where the issue could be. This series is an attempt at fixing
those.

Christian, I haven't taken the tested-by tag since patches have
changed quite a bit.
Please help in *testing* the patches again.

v1->v2:
- Re-order to avoid preempt count dance (Narayana Murty N)
- Do only hard_irq_disable on PPC64 to avoid second warning. On PPC32
  use local_irq_disable to acheive the same. (Ritesh Harjani)

v1: https://lore.kernel.org/all/20260928110411.844582-1-sshegde@linux.ibm.com/

New API ppc_hard_irq_disable could potentially be used in other places.
There is similar pattern of doing both local and hard irq disable and
likely not all callsites need both. But it is a larger effort and due to
my time limit, it will be taken up subsequently.

Shrikanth Hegde (3):
  powerpc/irq: Add ppc_hard_irq_disable()
  KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
  KVM: PPC: Use ppc_hard_irq_disable before guest entry

 arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
 arch/powerpc/kvm/booke.c          |  7 +++++--
 arch/powerpc/kvm/powerpc.c        | 14 +++-----------
 3 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.52.0


