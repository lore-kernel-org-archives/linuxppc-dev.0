Return-Path: <linuxppc-dev+bounces-24590-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE10C44529
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:47:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4CGx5s6nz2xjd;
	Tue, 21 Jul 2026 19:47:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784627257;
	cv=none; b=U+NYZzvSWKfm8p0EpwGHjARHp1+2P/7gWugGq52QgHMFPFNjRm2WZPeq9KJzqn3Ss/BXD06/80WkwUu0DZgi/FAw1JsQ0qgZ+De3Nxwgn+r7JbLj7JX9UxJxBXIMnJFClqeWTVSwun+Sfes6NbRN7qtkpr0f0WRsAkECQUtWciRWvyiTIGU3xmn2hycfFF1jlun/aJCd+09LPpE3AewrO+mN3mf8Sexc6Jzutpftb1XfqDrNTeqP0N10rXnsIbnUf0JnCvoUUlNu6qT5w0VSLhJlD1vMrNPvdLqRuMJuJwkSZHoI6GBJFaWMKVupX9zT+Xnx26vPy6FBkj8ae298Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784627257; c=relaxed/relaxed;
	bh=UhnE6Itv8D3siCQSqpSl+3N+7Rh4y5kXDVFqTUKXc3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B/+Lqwf1FlLTRJzmayIq0ggdVpAJerhESonFW/iVL51b7wxNGO0szRNyP7stS65m+GrYmdyazBGfAFzISfpdz6CZRXrnoHYzTZkP8pO4RWgmKOIORfRcu89cg7hSKmh66rrOnREFUS2FMhZ6pyaudFg99Vsyu+maZVfX2Bz2yvoPA94FddO0dPAuyC9ZuUgru80fL+W44cGBDkYSmsSInnrky6xAJr0ijudlFVzo7IOu2uMhQICzdOREZRjYREC1M76ls4Uc+Rz7OJCYXgt3xbLJQUfFIPXuMfdC8C5tIx9tcTDESsr1YG7rtdgQ7OZezOc4Y2k9xTjJKI1txQGN1A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zxvd5AS/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Zxvd5AS/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4CGx0b7Cz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 19:47:36 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCl5h3563406;
	Tue, 21 Jul 2026 08:15:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UhnE6I
	tv8D3siCQSqpSl+3N+7Rh4y5kXDVFqTUKXc3g=; b=Zxvd5AS/UrGOYy4wZgaoYz
	fxgOT1KLqYqrduWOtAk9Jf/uufo3nhUqfC6b7whBagcN2u3mhEafuCnpxRQQXkQv
	kJkFEUDe84kELOFyhoi19E4Y++WIqgecERS6PsA650Kw3DhlCOakDh4AXziznqgJ
	gTYaQw5m1MVnO2LO1RIld9VUuF3z7VazQzURQKhNMe1Uf1GnCeIHmh7aY4clx+i6
	2jPRZSguS20EBR2uzpxBiUpOSCViz1ei2zN86MiUB4XdBAlDfkG4sMQTTCrze8k8
	9PZeeEKSAkRpVfXeff6SqTRF3psvXUKY34S2k/XxfvjrepBErQwXnlVJ47AdJSCg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790ujft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84aoG000939;
	Tue, 21 Jul 2026 08:15:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6w1g5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8FHGA28967234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A86B2004F;
	Tue, 21 Jul 2026 08:15:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258DD20043;
	Tue, 21 Jul 2026 08:15:15 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:14 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Rosen Penev <rosenp@gmail.com>
Cc: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/85xx: Add fsl,ifc to common device ids
Date: Tue, 21 Jul 2026 13:45:14 +0530
Message-ID: <178462153935.1974055.12925432520615660526.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260604043309.91280-1-rosenp@gmail.com>
References: <20260604043309.91280-1-rosenp@gmail.com>
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
X-Proofpoint-ORIG-GUID: 6rZLaO4pIFL7ueu8Tqujhjlzn2y9C5sH
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5f2a99 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=xxqtat_AZO2NtkILAQAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX2z3Y0/nCs8qN
 whmzEfMOgxt2As8t9ac2h9C4/KBu4H6tnrE48hdEEx6FX/GR7JvKGmMpYqtVYjPh3uqjtJLJkbb
 tXhBAjiBlQaZfDSwiFNFs+cOUljDAi0=
X-Proofpoint-GUID: oYOwp1Aklahsjjv6bFaPaGoxjnJoWldi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfXwHEpU2ethnfX
 IWwMubFh43Gls1d1S8AyC7BOtRQDhF2M8JDdZLRTfvTClz8QA1aNyTYeqQjrbXzm1x5o3MCsztT
 4mAPRHwxd39WqSV2Y2ApOggxIESdS3S2YYfyg58zc5prx06LCoeRbTuo/71Gtg5hPJz8xLWoa7y
 r7DqdnA4LuJlH4vmCMgdNdSSKS08lL30OwnZj4SbWG5v4HHytAEaGogiI+sN5eReNIP1VWpIPIm
 15BdUP+fxsQJUjiIsTCNsyrZClIXX+wyzpzhX1Ml2RWJ1nVwL2Df7+RYefI2jDndfUGvZTlgXJ+
 S3pQEQJEEGL9mL4K/I4mK8w+kSY0DMy4zw77qBoWJEhQBTupRuQ2aI5nQDZt1wzOMuPubgfNkhU
 oKCodncdesz/EL+IuH0XMe4AC0DuYqpCbWxDACo+4U2x29vqN/Iu95xrut8B4kdYgfe5wog5xW+
 mmWeCIVL8/fdEVy+YGQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1011
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210085

On Wed, 03 Jun 2026 21:33:09 -0700, Rosen Penev wrote:
> Add fsl,ifc to mpc85xx_common_ids so that of_platform_bus_probe
> creates a platform device for the IFC node even without 'simple-bus'
> in its compatible property. On P1010 and similar platforms the IFC
> node is a direct child of the root, so it must be explicitly matched
> to be populated.
> 
> Fixes: 0bf51cc9e9e5 ("powerpc: dts: mpc85xx: remove simple-bus compatible from ifc node")
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/85xx: Add fsl,ifc to common device ids
      https://git.kernel.org/powerpc/c/25957f7c3dac3265332d766b71233e3622f17e14

cheers

