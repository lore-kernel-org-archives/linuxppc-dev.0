Return-Path: <linuxppc-dev+bounces-26442-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F46C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 12:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZhzn1x9Vz2xmh;
	Wed, 02 Sep 2026 22:36:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788352581;
	cv=none; b=TYzZZR4BBfXwbZfVlLXTsAhwHBCPRSGNcnJVhJrRRSZoAi1fpfuIv2Xe8pG66HdZO8zKZmpn1SQSnd4mMNmLEGc5TSsvPk3bkB3Vdhzdun1uS/9Pu84guKZ/YEy51EfDyJqwjxS3UtFdrD/uTjx9nvsM1StRTf0cawOltVu1L9QQKAdWrmsCpOkY80k5HcC/V3H0nVZLjP2Yc5efwKg6ef4uQuVafnrkI7KUMyX3bPQjfG2QwO6OWr0ptD4gMp6gmaKhhszzitllvyyIyWI3UJ8YmFL4kTso9VlMGkU1URGs6ywx/wxwJWvKVEUyLipMfWjFB4N2CzDjUp7DOauoyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788352581; c=relaxed/relaxed;
	bh=S52PEYfQUYgz3JBxu1RIQcpP5XjrkOsAMpWVGqFGHEo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URAXTG4zf2PDQmQwKeOTqABkJlrxdwigi3itVPOmBcLFVV+wOcT/c+zg6utgPbsAm1RSvCHc8b63BlP9ZjqxBK7BMOPB3eG/YJU1+C5TiemfJHnaUPKJMHFswmxiSMO6NLR5afOcxQOwWqzn+RJSjidjA7dZgi8DVV+/tSSRh+0qRbM9yltepub+mWiwJpBme/9nulCSUfoGCuk21ix+knrBdO+CfQeoWinhtTJPQdhXhWH9fud9bm7apAXi1WCMrNtamfJOFxFoLxUJY67US8Qm7JrazZSlqxtlm8qnNtPMHzrrxwit+bXWRvqQ6tRuCEnu0Dd1Vhp+u8lCs12+Yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y42gLdip; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y42gLdip;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZhzm2G0Bz2xHK;
	Wed, 02 Sep 2026 22:36:19 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682CW0Cs047467;
	Wed, 2 Sep 2026 12:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=S52PEYfQUYgz3JBxu1RIQcpP5XjrkOsAMpWVGqFGH
	Eo=; b=Y42gLdipooKz4spbsyKxkctcpE+e8o/r6YsOtPbeNYWNr4k9bQN3Xz6e2
	GL9Q1wkBLgsdNmhifyaVJqSIvR7hhPrJGPWMaUGO1ILdAjBLrxVP4dpHnN5vpJC8
	o0H55RB5wi+fmGDb0skg6m65awvtnVHuk9KOQIRGFkFQmYu7w9Y4TtECR422oo4g
	qAivR7fhnraDBiqHjbSiDbzqEE+HZ+R8c9EK5wg/6eoHn1Tn+tTFlKJ0Vu4fIhLZ
	qx1GlH8IRCqK/k3McKWvyZmoIRch0wCJEWtGMBWxFilXAbnBR61raqQQ4QYOAvGY
	PdlYAea/pIxfsOkoHbeNHYPLU6qZQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tdx22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:36:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682CU1Ke024915;
	Wed, 2 Sep 2026 12:36:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjaj05d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 12:36:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682CZuJ648038306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 12:35:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 093A920043;
	Wed,  2 Sep 2026 12:35:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C47420040;
	Wed,  2 Sep 2026 12:35:53 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.111.3.140])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 12:35:53 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>, skiboot@lists.ozlabs.org,
        arbab@linux.ibm.com, mahesh@linux.ibm.com, chleroy@kernel.org,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: [PATCH v3 0/3] powerpc/numa: Enable coregroup support on PowerNV
Date: Wed,  2 Sep 2026 18:04:59 +0530
Message-ID: <20260902123458.340456-5-srikar@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a981831 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=zmxks_ozvLoXZVlZg-wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX7DtkUKoRXjaU
 7FVt6Gsdw4/Pu2XjJf7JL1tlfGAcXOcvusH7p7xN6Pzro2NdNHE3aLEMofwca9TRHmhZyBZ6+ok
 thQUeWFa+a45exwbrBETNnC04WwCSvk=
X-Proofpoint-ORIG-GUID: rG2Wmm0PF4x-Sxk5XZghjsEriJ8v7MNw
X-Proofpoint-GUID: gpY5-v03BsJMUQZYQYrHazjpBxGl6CAr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDExMSBTYWx0ZWRfX+Ic50hZnLAh2
 gqY1OoB5JUGH80xWxeL/4x0GJeToBMkd7d+z5hbyevelo0RDp0M0gtNQqHQa7IT7/+Yx1p0D84+
 kIbPm2XT9FdLk0J3gsSJCXuO922kbzBVyyQmpTZq/y/ZS2f/ybEulRcyAZVhHFCl+auJQKahSrA
 vFIXBTt71buNSddNOtBJgKgLUn9Eyl6TZNAKgr77fQzMxcT7VV68PAvALGudbzhyyZtkn4QkBV6
 y02flRFz0pvWig7zalHKv0PGaaJunFNrC0fl0L+XUHwrCL0Drmn9YeW5BUAYG5Jt7ssLT7JTikA
 Nj9qoxwy3vqSZdxjyVDAJNPdZfJ/bg0aq4wCl62KeEkpB4XghZIvOGaETE0lH35BOWgxJHG5eVI
 JX8+JpgjqUOmZOugskGpk7zOuGC36UyyLp+bm7FBaP5Uf8iH/oh9+1CB/ndrrLgwZzA0dJL2ZeP
 LDerE9ZmZHkUrDzXiyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_03,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020111

This series prepares cpu_to_coregroup_id() for broader use and enables
coregroup support on PowerNV when firmware exposes the required
associativity information.

The first patch cleans up find_primary_domain_index(). The second makes
cpu_to_coregroup_id() available outside PPC_SPLPAR while preserving the
existing fallback behavior. The final patch detects coregroup support
from the associativity hierarchy and uses it on PowerNV systems.

Changelog from v2: https://lkml.kernel.org/r/20260605055242.1757485-5-srikar@linux.ibm.com
- Handle comments from Ritesh (one hunk needed to be moved from patch 2 to
  patch 3 to build correctly)

Changelog from v1: https://lkml.kernel.org/r/20260524010017.140408-1-srikar@linux.ibm.com
- Split into 3 patches
- Handle comments from Christophe Leroy

Srikar Dronamraju (3):
  powerpc/numa: Simplify find_primary_domain_index
  powerpc/numa: Allow cpu_to_coregroup_id without PPC_SPLPAR
  powerpc/numa: Support coregroup on PowerNV

 arch/powerpc/include/asm/topology.h | 15 +++--
 arch/powerpc/mm/numa.c              | 85 ++++++++++++++++++++++-------
 2 files changed, 71 insertions(+), 29 deletions(-)

-- 
2.43.7


