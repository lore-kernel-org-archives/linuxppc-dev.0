Return-Path: <linuxppc-dev+bounces-20511-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A0ACD3439
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 09:06:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9Tyg3kscz30BC;
	Wed, 06 May 2026 19:06:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778058395;
	cv=none; b=AXzDlh0xxpw1NzBB3+SD6QI9/uX/PG/bmtBO1L5syaWvhvX/Gph0X32G4dWPdZyLI2gjnvhkhPtvMVhM6aBQ2gZ02Lmee2MC2t8TtGteMtOisBuqjoY64WcUJG7gKyX6KPa+KjWK75yz1sHJiNYbqaE8VIY/a78XZygAr14S4PB98uP+QcpcFtRPfU9Om6peVYPY9kXJAD5XKUJN0dr1MIa6HzF2Z6/PPspvt5UOv66w6MrlTgIuMDtXGX8b3Zsi9fKoV4khm9ATFHnmuCzhMSuQaX/RS9nchV6aVQV6saJDcVk59eStH9x5xFx54rG0Ir9JEkM5ZMLuqIh/gJ+cbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778058395; c=relaxed/relaxed;
	bh=YFcTt2pbZMFoTbce5E0y/0SJHipPDV+HRis6c0vyz5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNdOseJVAPDa4DVcx+dtLTrbuFgHuOeoV8e9ctVGpYroyEx1EcWqeKPbMPQ41EZxNMf8DJQILMPJcq1JU8K/BVcdn/TmMkLMxU1VSzoXpqYzGTQJjqukXsgdCgiQB5MlflDF/lTUfudQOLR13VnwZ3GbXxLDy6O9uq66P5GhxOgTWsX6CHYc++tdx4ZSm1PcGKpoePAp8XOkLPNzID7P6KDQNyyS5VJBqDK/+RJBaYij9GYBzhR6WZYmuJwteingpySSmLTPJ8cCb1oMTHf+/GeNmHQ9G+ZZh9VEq13TcwvRMwxMtyqLuSCcmkPGAmqRPLYHzB68JRHso0cgeE7Mtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KeRsek6q; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KeRsek6q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sayalip@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9Tyf30QFz2xdh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 19:06:33 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Iopvv3267730;
	Wed, 6 May 2026 09:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YFcTt2pbZMFoTbce5E0y/0SJHipPDV+HRis6c0vyz
	5Q=; b=KeRsek6qWCH3y4M+DOnwOWf5hbj/tLkoxuy5nyeW24lFfVyxzNYkX3YVP
	j/Sz98udntKjneyF+PLiLjV/d0b3IXYGd4SRKumGPMIUa5+nLBTn0Sh8dVrfeujR
	G4+s+bqLYyD3+CkFrVn0pgC5FWSfPbeZKA35Nr7VvWTZXCqhajEHNUIkb9HWM/1M
	UqEzsQte3wwNYnGRuAcbIYo4OycDZnVP18tJXVW0uP4VAM2yxoFTrpskjYqXCcX6
	CrMCi/r5Ej4RqiOYty2ad5+xxATcRuv5xxtzE6V5YDWpzBCEk/YhjMAeLF9XbGji
	jorvoTqkEUedwIVL/Zi5eFIbae15w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxq5qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6468t1v7025770;
	Wed, 6 May 2026 09:06:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw5ke1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 09:06:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64696ICG40698334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 09:06:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7178620043;
	Wed,  6 May 2026 09:06:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 194702004E;
	Wed,  6 May 2026 09:06:16 +0000 (GMT)
Received: from li-3f69264c-2ce6-11b2-a85c-c3f414d24014.bl1-in.ibm.com (unknown [9.123.3.209])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 09:06:15 +0000 (GMT)
From: Sayali Patil <sayalip@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>, sshegde@linux.ibm.com,
        chleroy@kernel.org
Subject: [PATCH 0/3] MCE robustness fixes and LKDTM powerpc enhancements
Date: Wed,  6 May 2026 14:36:11 +0530
Message-ID: <cover.1778057685.git.sayalip@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA4OCBTYWx0ZWRfX+9WRqitIvUOr
 AxbttCeFRLjKT6UkSLLQd80KXV9LKxGr6wMAFhfO/e0xD2ru+Irpsap6ApppkvM1L7GkrEtl8fN
 n1ZQX5Gd8anqXReqZxXM3oSAWupHIhAYPKdndA7rEdpN83dytGYDdhJwgQiBCE5PWSknlowKNJC
 0QpF78xtBVBNwLXYZgCD5JLymdUxMZ5E3+anf3zJs9B0HPR7PY0cJPn/E36eyL6sQtZFrDs9z6L
 7w3EGfFgNtSP6B7yUHl52wH4+jkM3Pbw9Ha+RVYZMCg0zcIC4WvKKnk5n1mLWZEwMuCwv7VCwt/
 Bfdc3vbqbs2ffOG/C0GqM8xRFmww5O6oIQL3zTeRCBVhPtf8c6YJ7Rzmi+0hio1dEJPHx77894/
 R3bwJOzKs3LW5gtC2sTKLaaahY0qS63PaIJK/uDXtZ8cKbCKIBOnnaVMotka0751LPW/P4Z0Fpb
 SVyPjcl55pjSt8lFIKg==
X-Proofpoint-ORIG-GUID: sgZyMQBvrbCHfiM67QmXQG3JSN5tCeeP
X-Proofpoint-GUID: 0DiLvGPqNPpeJG3St9KNvRBSTFW8mNFC
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fb048f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=4LFl1V1j6vrMI3_rxnIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060088

Hi all,

This series fixes a panic observed while handling machine check exceptions
(MCEs) from real mode. It also improves the reliability of the
PPC_SLB_MULTIHIT test by adding isync instructions after slbmte operations,
and introduces a new LKDTM trigger (PPC_RADIX_TLBIEL) to validate MCE
behavior on radix MMU.

Please review the patches and provide any feedback or suggestions
for improvement.

Thanks,
Sayali

Sayali Patil (3):
  powerpc/time: remove preempt_disable/enable from arch_irq_work_raise()
  lkdtm/powerpc: add isync after slbmte to enforce SLB update ordering
  lkdtm/powerpc: add PPC_RADIX_TLBIEL test for radix MCE validation

 arch/powerpc/kernel/time.c              |  2 --
 drivers/misc/lkdtm/Makefile             |  2 +-
 drivers/misc/lkdtm/powerpc.c            | 44 +++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 4 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.52.0


