Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA51606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 05:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=on/4JbEu
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTqXm3VWHz2y2B;
	Wed, 18 Nov 2026 16:14:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794978888;
	cv=none; b=EnO+UbDAgxXtbwepZjXxwQmmprGRdFOk4IexmCRqhXPHEEVsAxsERsvzViyAJHluWpop7kxgzah8si8chdsOPFTwnqnXEwUq1xT/tZKBsQnnIOEPtsf/aMYEJSsslpe6V+Rvm+oG5Yq/mhe9mlfci+v3gonnx5zgVwMW5e1MHhroL3Zika2Wktybbp9ZxMONCyOtPttzH1muevjfSZbeElHf9GXTMiOwxEu0IYhxp4KRDBAcsGaGLFhaqqIDLkXueAYersl8S5ZdmowLt/pZFK9qHvXkxRmGOh03jYWfgz4J/i31aXJhvkqFf7tM7YSM0NbZNCv0ek0Whx1xDf2duw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794978888; c=relaxed/relaxed;
	bh=ComRRml0ZzynV3ARoUry0O9EESmxNStjxfOKpHuXfew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLKvx4oXXV8CEUrRuRG9PUhLWGpH6CG2sqBqZtMZjMrQ6JZQq7YtKbV90646/JDrIULEW4fscLw5IqRLy+M5relVRZlG5tnJov8kdpc4zGHbC6XjOS6cJKMGHIau7rdQTWt/mJF+3p2t5jTA4PGE8HTTxisZM5iZUTaREa39MgPTHH5PtVN8shM93rQO3Rouspu4JVgcV8mNijOI436uvZoAQwo0C5JmVkZzUkztxlMtMDhiJT/iMH212z5ejo8EeLvvNfA20QtR0KJ1t8hSie8YRMKmc3DhtrbMmu/4MKVaAlxD/NzVuNIIInkbmxDKeaZHaNVoGPnXEdYxmX4a3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=on/4JbEu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=on/4JbEu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTqXl48dJz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 16:14:47 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2RuAW4062985;
	Wed, 18 Nov 2026 05:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ComRRml0ZzynV3ARoUry0O9EESmxNStjxfOKpHuXf
	ew=; b=on/4JbEuoL/+CjWlEo00BA0nJGe7N0+ZWo3zhzBU6ObdwxoHmv+sks8I0
	gUW/4jVNnK6l98F/UFyXOVaUeALJ8uN/nPnL42/uJNIWycugL7BwU67sIJ8NdVuf
	xcsjCb875XAS225Jlu3wHLYJMSyXdAfI193vV274rv8F9oqkaZ3eR5NNA8lMDGTM
	LHFDqjphg+OPk62C2WbwHf7+sR4yC1RyIk8847p/ufL5NCPI/BthrN0NPg3jJ/5+
	e/lXIl3zGEXlKYlZEQOvJs6SmdRvJpmUlqJskF3mqz8+oLz1OfQ3FXtzesm2Oxhy
	VGImPISD/Z/S3Zsp8RwNPoZPFr6fg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t0yp1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 05:14:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2nt6M680839;
	Wed, 18 Nov 2026 05:14:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvgugx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 05:14:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI5ESLC39059904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 05:14:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D10AB20043;
	Wed, 18 Nov 2026 05:14:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB59120040;
	Wed, 18 Nov 2026 05:14:23 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.20.10])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 05:14:23 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v5 0/3] KVM: PPC: BookE: Fix boot hang on preemptible kernels
Date: Wed, 18 Nov 2026 10:44:16 +0530
Message-ID: <20261118051419.783878-1-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afd343a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4M4rjlPIC_omUXLxwSAA:9
X-Proofpoint-ORIG-GUID: _FAZnjFIzeN-a8vdkVqegOlU-Q2ZS0UB
X-Proofpoint-GUID: AWPUZCe4tdD6RDAW4nXxPz1YetxgyF0d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfX/4cOi/7WqLDI
 DoA813Z8croph3KK8Po1k4KC32DNEpAx9sACtFZW6unOpdg8XCyKEFpggIm2VINjNF4xmzP0wIr
 yJuR3+UGs8H94ZNBrvXMcJXwBPaL6Swb25PDrd6QHJGxkuwr4X61MuQdtVsWqbB8PzJGae4+C2v
 ECoGWVAubGV5TwqebemkXhNWhu1CG/fkJYuxCRckPb8ltkj++NGnQ1vudBf+QOpqTcVXDsyJWwR
 p3n/by5ADr1vgUT9KgfarwkSSJD/20p2qE6ObJekRzmsobm3bd9hvkEe+qNMb3PAs1Bq9Nx2jgl
 SXNd2nH/5oB7og0BPLjBKS9GzWr5RID334oL0Lvszx/Dlt92cNWbCM/fd1t/LqIng7B8nYt5pCU
 prAgSrHpdT7/Ga2L5nPP6EpxjE+L114UYE1tAZmjTRJhMnm5oylBz1At+hlrHKJPSlhfK+g2nBH
 r2H4sZV+WEKFTpbvtsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfX2vs4yp0Hw8Gy
 tmc7RygorD/sn3Tgt7fmSsxUXmQHGOqzqmRIA8zm7MkypBIkh9wF85KZDjpOHBh0Y4PvxhetJIL
 LwfDTy7kl5bvox1urOIe/sBvp8TZlK4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180019
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

v4->v5:
- Removed fixes tag for patch 1 as backports could be
  complicated and added stable instead.
- Collected tags.

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
v4: https://lore.kernel.org/all/20261117131612.707038-1-sshegde@linux.ibm.com/

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


