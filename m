Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AB0606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YRAaMpF2
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQLMX5pb5z2ynW;
	Fri, 13 Nov 2026 00:09:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794488984;
	cv=none; b=H1dhIuyVD8qsI9UCSVnoq48/30ofZBnRI6OM3/IOsaY6SpAb5W11bI136XW1FdV6qGY6zmLAmXcuvJdMj7/fdHuTVYUf7WVadRmZIPgu0knTDyl4bR72Q+yF3FVdFC8hSZWhBUXDbnK78GhuY8Z2MANz53pl1V3iS6iTrktxZI6ynXc9JBp7H/16jmXLhl9ExiChx0wdblkZ2jiAhFqpwKoMyV2ftnnMHPqiND2wFBKz+WVO0dxEEMmABjSy/CgDh1wpE49PjJKGuQA42FGTNMESlCpNwxCAkhkLgZJLOcgXH6BqSmLu6XuqSSFYL5XYM41iosj9UKzuqfKYlePhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794488984; c=relaxed/relaxed;
	bh=rnZ/d0xPhMRt9sEp1D0qZrWF3a3n7SkSWR02u54K31M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyfSx1GxiNeDhdZ+hJerZzysaRVH/f2Pfr+TNNR/vJE23/nJy0BnXZPAK4byevqxZT4GLRN84AF8twM1KT/hrRns2U9i6ihil4s+8cx+tbW0xz0FYeCADjkiO4s3K4W85XdHBxYijjz7oifQbHdVgKQgn5ku4YwgezmE29jv0kbaglb/t7s2NOHT86HHjMXbKWQNHsfMpIp2I2AGfhZZ1ZWlI4YexF9oSPyjGY/0zxWugPvhycSm4guXwpkCVuLcJ3vPjdPrHoVF55iruPKHu5lwDwgIt23rTG9piD5i0/N1t9pKTBSeykJIfvsDXXRCUgMEgQbjzrNBtkAre4bIfA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YRAaMpF2; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YRAaMpF2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQLMX0R4Zz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 00:09:43 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iCIu2854163;
	Thu, 12 Nov 2026 13:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=rnZ/d0xPhMRt9sEp1D0qZrWF3a3n7SkSWR02u54K3
	1M=; b=YRAaMpF20FD1O3ARui0W02IFaS3IdmrCuq2048ehynm35p02CCs+9ciY+
	2mSYzqb1d2hecKsYHrAjQLjKaAonU4JzSybNxxmgwK9gH6DPOtjkgFsdaGReo1oo
	aOpXZVeN15WA+jti2A/qaEZtm20CISLoircLC6jXmth7kMwMXOcYlKuTsRxajA5/
	/A2y6wyD8k+ZycUw4YxU2rL8AoVbOHXS3OiKeLhpXXvWd8Wj4X8SBhna+oefX7NP
	sUpwpT1FArcKw9GbydMYwBPS3wFAaRrE6iKm1ZRCJ+2A7TdIK7Z8cB01/R/QGdSx
	8hSh7DFRcAfYVAdMiCvwKzdSHMmUQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq77ewg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:09:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC8FvlF106626;
	Thu, 12 Nov 2026 13:09:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nt0gh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:09:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACD9LPr45613556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 13:09:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 705EC20040;
	Thu, 12 Nov 2026 13:09:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BFD820043;
	Thu, 12 Nov 2026 13:09:16 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.18.47])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 13:09:16 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        msuchanek@suse.de, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com, mkchauras@gmail.com
Subject: [PATCH v3 0/3] KVM: PPC: BookE: Fix boot hang on preemptible kernels
Date: Thu, 12 Nov 2026 18:39:10 +0530
Message-ID: <20261112130913.4124175-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfXyZzywHB4un0M
 m9wxQECz0fNmX9DwXAipnCuaaUYoVK4mFeDUrFPTJOAf4DczDcJcVUek28q6BDhViEgcBnnexka
 o42+tH1csSd4dakkrrQ4ot2FAgi5s4w=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af5ba86 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TEUKsyddKFnqGGVLVlYA:9
X-Proofpoint-ORIG-GUID: hr7NnMY1O1eU6QKFnmSdsOdh-vKox6yF
X-Proofpoint-GUID: Bru0rrrdTpLPq-rbqYWrAZJiCYoaPy8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MCBTYWx0ZWRfX2Dqz6ivc/Oc9
 you88zDVd2ICI/rRhg0VY+7eO4Yptf4IiHkhHFhtpWxoA80vbolCd30Wn8BqrppvVj9xzILbzMy
 D8U+WKeEqFAuUI253aHS+Qcf8KHfE+K22IbcEXQM3AOS1xIp7cfh7DCPTEi09boFIlT9P2cye7k
 Wu8pRID3SyJiAdizSciv48HVg1sfWJb4DPk8w8N4Wc5jpGFzV1MLboOPv51QwIbmVUEkadnQs8w
 B+fkXACXLOcB5pXE/sItfvyB/QWtDjLuAktt74VltdAOmmL5JFtVlA9TL0HFxHrWXL8yUpSvkTR
 u75XU1SVJnvsYOrFSdQUdoQmW7RaqBFAJWJv8Qzg3p7CVYgZH/ZqML6VPQ5vUPi/5AKrsTdWY9v
 yAd90z29uXqOXVSW/cGCq8I/MBQpMDmYza2opT+vuX311Thw9GLOdaM6CE5XKc64Bmie0Cu8s+P
 6mS5AVxkbtbWp0UrgwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611120050
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
later.

Shrikanth Hegde (3):
  powerpc/irq: Add ppc_hard_irq_disable()
  KVM: PPC: BookE: Load FP and Altivec before enabling the interrupts
  KVM: PPC: Use ppc_hard_irq_disable before guest entry

 arch/powerpc/include/asm/hw_irq.h | 17 +++++++++++++++++
 arch/powerpc/kvm/booke.c          |  6 ++----
 arch/powerpc/kvm/powerpc.c        | 14 +++-----------
 3 files changed, 22 insertions(+), 15 deletions(-)

-- 
2.52.0


