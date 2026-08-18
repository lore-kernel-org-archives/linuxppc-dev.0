Return-Path: <linuxppc-dev+bounces-25933-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F40C5DF67
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 03:50:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPG2V2BYBz2xrL;
	Tue, 18 Aug 2026 13:50:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787025058;
	cv=none; b=VSOaA4uiblSdIrhW6NrKOISkRr3x7iIUZZaXsVRnuyeD68HteRGbK7GNqCt8kFQTt6xEhZj0ZGstuEHPthto+YnO8p1XpX7kxavATcEzU52dT7EMd3zrF+FSoAhpOKcgyH0pti9PMqFXjN2JCI7f16SpumGg/CFGa8OB2EAX1wobYQ/rD+uW8NBJsBmFTDqdW2X3S9/f72Clhq7tjyVnpPDIUQIEx/m9cNKufS03zZr7iu5+iyD0LHPUv6Qs3VH7eSUWzMJMliRpY1pCE6C1qWUoQW28DvxRRq8wK+3Y041mVmShLuNo4IfmNy5uns5AjmFikgOFD4FWsefX5rrI3w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787025058; c=relaxed/relaxed;
	bh=RjaWBZZl87cJICmoIj4PNiQc5Awncdwjf/c3xGJu9TE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BS5PVQRy6D4Igc+vfeqbO13ZJ2xrwZ5TrGE84mPEmzTJHrz9jhHI3a+lqTvq49RnaL2XXx+45TYcxKynnkD11ScsA/03ijgoo2ISb3B4Q9aJFDdHzgH8qyxbo8SIsRTk/NFmpE5iVfs+FPjyf+iY4zsrd1qOZoMcKbLJQYOmHYGTgaSI7U+BnPk0eMDDxB0RkIvx6HM0LFWsD9zE29JoC0cK7e9VcUE8kwUnSGyJVz3RTW/dTclVyyhSqumj2K4cWJPfyePkXDwbe4wxwzwawdiiigwSW3TPpPV1GOYFtyh1fNjTpENiK2EKi0/JnrRVyvyg17pX71g7a4x0pB9XMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i9LQ7oae; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i9LQ7oae;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPG2S6Kqkz2xpv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 13:50:56 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1iLQ759187;
	Tue, 18 Aug 2026 03:50:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=RjaWBZZl87cJICmoIj4PNiQc5Awncdwjf/c3xGJu9
	TE=; b=i9LQ7oaeEc2sSdBJ1HGkhtKwYY3738pC2RCooMyBpZt7CA9fBbzxq83ug
	u9o09LDCm61gZbk7iG2oYFiNvSflf6ttmBenOxIItjzWCBFN0K8MgCSE9Y6GQxHf
	gEP45TfHnx/kT+kp3V0buul3SVvuUgIIK9K5ZuoxAxN8PhXvfvxh7ortkt//QEdi
	vUc8+o44szagF0qAKku9xqRAOsaG3NuZq3vnewmTFiNIG8gCc5DHsj5aApWWViGF
	K8JLzsViWdS3pMolIdKfXXqeiTe9IAUN0gN7KRxczbZheCwkhPKjbGBxw/djAgqj
	RKeVryInBauqswFOnAwS7mbqiXArA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqnua2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 03:50:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I3QPP3005927;
	Tue, 18 Aug 2026 03:50:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq1bef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 03:50:43 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I3ofGE46530902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 03:50:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A60B620043;
	Tue, 18 Aug 2026 03:50:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DB8520040;
	Tue, 18 Aug 2026 03:50:40 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.14.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 03:50:40 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH] MAINTAINERS: powerpc: Add Ritesh and Shrikanth
Date: Tue, 18 Aug 2026 09:20:37 +0530
Message-ID: <20260818035037.613186-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX/pz3LwxMx/Sw
 uef3sw3bWSJA71q5eJrC8zW10VBGfi0DRKPcD/nv9pACyXtiobAPDb1fcJuBgsCjUuKu3bic3IY
 KFdAyVbaH3GtTGzwgxcF0at5uxsVLTamNPdNa2BdvKGvuJv0xPqIvO4tPpafGvHodQBaEVRAsvf
 F4bkVzNxvN0M6pLKP1XipMK/0nQvWiJbPsU7a7NA5dLXsjvC10PhrMRRjpx/Y9NLf8ucUgkpJjT
 szJCHw5EQ0o+5iW6+h1HBQB7+UXVfos9I4Qtl4dUkhHdZtQYy7fEhwBeNyDOjE0Vh/ntIrujkD/
 cy7GRlt4sTW05a6rlmnnRrfV6WPXy4LqHZvVqutICKIXcHnjoXII0dcsliy07FDIPHetWak/DUk
 eqYPpyaC13p8P0ZxoQCP1gWJYFIbfY09LAROkYuHA1YF3El0Vj1GO8/JpKhXgs5xSVsZMViSYSI
 gG+9orf9wP67qZ/+uPQ==
X-Proofpoint-ORIG-GUID: cRLHVoMd0q10gFNvMXCYccPSluQT1I6u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAyNCBTYWx0ZWRfX1OZzbjPkrjMo
 RFCLcaFfWEnUaDuQ9/XdxtDvdnfy+MbFs2kVjI2qWqed+DrJDcYb0ur6y/EWx4P3NquhoYx5BJf
 5KZE2RW9wD2LMRfuaegoRRYSb39QYo8=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a83d694 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=voM4FWlXAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: piZGyRrteVicLsCH7a3L9f82CuNn-LkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180024

Ritesh and Shrikanth has been helping in the powerpc mailing list
patch reviews, adding them as reviewers.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7094a616afd..e1c5e6ed5ed0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14876,6 +14876,8 @@ M:	Madhavan Srinivasan <maddy@linux.ibm.com>
 R:	Michael Ellerman <mpe@ellerman.id.au>
 R:	Nicholas Piggin <npiggin@gmail.com>
 R:	Christophe Leroy (CS GROUP) <chleroy@kernel.org>
+R:	Ritesh Harjani (IBM) <ritesh.list@gmail.com>
+R:	Shrikanth Hegde <sshegde@linux.ibm.com>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 W:	https://github.com/linuxppc/wiki/wiki
-- 
2.55.0


