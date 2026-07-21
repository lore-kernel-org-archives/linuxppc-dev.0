Return-Path: <linuxppc-dev+bounces-24579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCBAC44529
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:15:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h49DX2Dhdz2xlb;
	Tue, 21 Jul 2026 18:15:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784621724;
	cv=none; b=iih9k1xgtD4dPXJ52e+U4q74WuU8sU1ENhlYvVpyaB/IaJNlizQw1O2+2cfuCLsult6bGG4dptnk3ApZPl/JH+B0QJ5sCysLJbYRPDx4UshIBd2CI2bHI+tsYOOgSiPKzB7UP2yvvWSvW1T2t8W48X6QXb8XS90cw8kWA3rU/GAEWTXdsk3+x+qhcJHISRqhaQiaPQRN4r9dDCt5K/2SCJkplQfiTbuNdl/aWPX5bzKw1x9DyVPWkBAATt4hBicnSRUd1a7d6R7ptSjdnONbUHQxXGTO4ufQZWlBHBEBg/2nAcd3PrVjtJnkTdMHf7KwkJIGnkjsF5YAC7FDVMOdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784621724; c=relaxed/relaxed;
	bh=7L2AcwfZ5wvgiUMWtQFvRkqijh/dth/4ePk6svpL5uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVxjw+0CdQ/7LYlkQgJYOOkfoy6ssBKeSHqP58ltfhLzi0C41r1xrD+iIUwe3ik0tYCLUlJ8ionc9U/wDptJU6Ndpwtg5GyhZml7Wx4quAu4ld90biDblmAjNlN3in904uS1RHSVhQ4TLduVfFkslZvYT1bt3PPaK+K6xK9KCyL9su1eUf6BaVA3UphmrosTVTZWwoYgWv7xs5Pqbcd40It0z/c4NTSxnfr+gXYeSHkc7xBlwTyh33+z4PlrRCgAnwRdTDZx4wmJv3bo/qsy12IfX4ggnqVYRIVwK5RUmquOvUcf4S2bZXzKHjscDl4TVviuKVyHoagM1wuOFY0u6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SITRuRC/; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SITRuRC/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h49DW1yrtz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 18:15:23 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDOCf3480175;
	Tue, 21 Jul 2026 08:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7L2Acw
	fZ5wvgiUMWtQFvRkqijh/dth/4ePk6svpL5uI=; b=SITRuRC/seZ/ZnoiKXTsKJ
	5fNep/N2T2BHdsrAuFnNK3jJn3LVLCmSTosPtVV2Nwc3CnW0YwWh9ITTZCoc74F0
	OfRl/CnkARX0P2h4BQ7t9Tlh2rLflVUR6HWcowHiRk2LgxLrisg4JY/DIITHJtqF
	IkFHNTX84bbbdJzGpG/HyIbtycYx4rMcxVb0l+/8sFQsAPFoppfKgQ6tqUCR2EhI
	FwPvUNLQeUqlWsGmjqiQ/Dl8J/H7xVmfSjqHgfmCXzb5PJbpS43hG8hAmw3GWC8s
	PorZtIOxhZFzRoSvpZjk7SAvhp3LxJ5tXCcHVXBnJc+xjXF7Y6q2UQLQhb/FXU0Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k37v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84aGg013933;
	Tue, 21 Jul 2026 08:15:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy948v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8F3Ha31195412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:03 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A4CF20040;
	Tue, 21 Jul 2026 08:15:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 506E320043;
	Tue, 21 Jul 2026 08:15:01 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:01 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Remove dead non-preemption code
Date: Tue, 21 Jul 2026 13:45:00 +0530
Message-ID: <178462153942.1974055.17022625606231660439.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2bf10a0afffefb6aca44bf2f864cc17471a80e31.1781870889.git.chleroy@kernel.org>
References: <2bf10a0afffefb6aca44bf2f864cc17471a80e31.1781870889.git.chleroy@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5f2a8a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=LP5bZYcy8nYlRubvx0gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX9R7A9Yt5a6Hk
 fi6i5c1s5MGrXTF45MxgAksl0jzXqPk6wEiZpdtivmPHsVzXFfrTT8rggRM89YxUrWzK3TTJErC
 oxcu/lSyy+6s+4PRW6cRYi47bA6mf1qNlOD35rYdnSctqodOd31PUNN/NUnxjDszdVr2sIz0AlD
 Kd6ayEiYtCEyUb62lLtQZG4moLLQs48HFE/IzCBCFiH6ewV7EsGZ5ogHa7WpQ9yFEnhvtlR5+aC
 pooYcAapUnK7VcemvJ1AhCJrHY3Hbro+8ddHzuMnhGML7dslGZf3Z7UiG4kg2z93m6emHh2znev
 qxNcHT+H4MIYHJlvWmdk9DdQoNHkmqNGim5CtgSL1hOGmPUKKm5B+lnzm6TSk0zt9TMOvDEKGey
 K0Gcmji5Cw50rEq+Taxki7ewPVJ7C62Xur3i6owTTPqqx5epTqJPVbLgfCR62rKhzQNoHVHJ5LM
 RfRtcfS5UFzjz3Noomg==
X-Proofpoint-ORIG-GUID: 4StdiGplpbm65_LTLY9Dk0BGeSKXPr1S
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX1v/UW2NxWfpF
 hkhqcNpjxW3qCfuTgBgY6gKRSGFXzvLOCDJsAoKqiMXJpXerbxKwNFwA/97y31ok1LDRKzrtlgo
 +VhZOgEhGmlCz30CVltiDHkX/SXU/vs=
X-Proofpoint-GUID: -eUBpUq0rgSRK5gY3zAuWvvJe3n7oxR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210085

On Fri, 19 Jun 2026 14:08:28 +0200, Christophe Leroy (CS GROUP) wrote:
> Since commit 7dadeaa6e851 ("sched: Further restrict the preemption
> modes"), powerpc always has CONFIG_PREEMPTION because only
> CONFIG_PREEMPT and CONFIG_PREEMPT_LAZY are possible, even in
> dynamic preemption mode (see sched_dynamic_mode).
> 
> As a consequence, need_irq_preemption() is always true and can be
> removed.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Remove dead non-preemption code
      https://git.kernel.org/powerpc/c/a2c02aa0c6ca3ec9fab6f1c99912a440c7b8bfdb

cheers

