Return-Path: <linuxppc-dev+bounces-28246-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD13DC98321
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 20:36:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hs2Y60N5jz2yMm;
	Sat, 26 Sep 2026 06:36:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790368585;
	cv=none; b=PF8oaLBkSpEOPQJYJpBlQRGfUE6vvHdjdsMbYyDncyRQ4mD0437bVGqBS4iCjVMQJQAbTO7pXiO+DjiYrAJUh2z9H5jcEElxwqVs4JRpfrkRrGeTLLbXkDY/Yvl3jQ7BQXnaGFFYfwwX6vzYs5zhWY/Hdkd5XM4kZp7MX0+CHxmo9uxeLjtL7h6C+tup0XbiPxiZU7ZJ7gpz8axhY5zIQFppH0B4c7CXZ7GLWb9c54FGypKaAI732XwPlAAVS7tEfs1dsQBeZuDbmSb9YZwyYTBj4FQ/s1S6yp3pXP7+AONHcZwqjlb4icN3TyTkIRwdUSoieFQ3VW4qIO/IOSDBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790368585; c=relaxed/relaxed;
	bh=JPbDZVkHkHveuVIklk/lqenZFJcP6dLwpKqAT/JIlqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FKpAyUTki/b9DpKmHLCFQxD+nnLA+hnSoTf+k7OJ2R/xaHU/JPDzJpZQMSr4lXCTz02YteXX4T8+XMRisBoL4mMbn4/to/VzqEH6NyjUWy/Nhbr+M8RAI3JJniGTwFl1B1GrP6rs8r+XW39ULU6ss9ZhI3eUEjS9MRmLasHFVOTrpHm1TAeZnMMEcZksBg8DrMxqqCIBL0hImn8JrnT48j5cXS+X9hrKeCYTvYJpZ9h2T2TTpmhNlwQidsnDNoVrnNwPwmvfs9fXY023ypPwZDrojMWxacyq4VRR8l3Hhm00isILFHhq3VZiFXAFfn2Bd5p2fWtOGJBZGMXliIy7uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BQ2mTr7x; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BQ2mTr7x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hs2Y52f8lz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 06:36:24 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PJ5N1i031036;
	Fri, 25 Sep 2026 20:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JPbDZV
	kHkHveuVIklk/lqenZFJcP6dLwpKqAT/JIlqc=; b=BQ2mTr7xALEUua0Mhudyjx
	uPnMu1NKiz76BrUpZffOZpXL1uPSC3RkOQsxzYrrwYb9R8oRhWdDKT5n8BQt97r0
	RaUibVb4pbUhDgbgJzsy8DScz/j2NEHieQCy4pmtz2j3fd8RsaFla+pw3QazuuA/
	OqvlZU66P9f3cMTkWOVNZDLIybiz1VMFg1OibAqn+ixCnkqyYSEoVoTGaHghfP99
	6QVa10AiJ0kehfYdNg54Nueg1yyOxn6u6WF4jnyhHvMVPIsmaP/+lUWzxGUDcMpM
	5jQA08Kbmw7zS5clLtvkGcuwc0n0MeKJtLrmTMk1+C5V147vcXHttH4WA4VRYRrA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske294yp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 20:36:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PImAvm130353;
	Fri, 25 Sep 2026 20:36:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu93v5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 20:36:14 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PKa4KY27460330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 20:36:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED4425805E;
	Fri, 25 Sep 2026 20:36:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C6E358054;
	Fri, 25 Sep 2026 20:36:03 +0000 (GMT)
Received: from d (unknown [9.61.165.251])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 25 Sep 2026 20:36:03 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: mingming cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ibmveth: h_free logical LAN on open-fail after
 register
In-Reply-To: <b2116532-c9d2-46d9-85e1-28d829e1b1f2@linux.ibm.com> (mingming
	cao's message of "Fri, 25 Sep 2026 12:48:54 -0700")
References: <cover.1790357373.git.mmc@linux.ibm.com>
	<7a56fbfb9e0674f011f4e310fbd7dfd8e67c30aa.1790357373.git.mmc@linux.ibm.com>
	<87jyo917gv.fsf@linux.ibm.com>
	<b2116532-c9d2-46d9-85e1-28d829e1b1f2@linux.ibm.com>
Date: Fri, 25 Sep 2026 15:36:02 -0500
Message-ID: <87bj9l132l.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: fzPdm23rj8wL-WaU15_8er85TtjkUSGS
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab6db40 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=nKwSdBsyh74nXFs96kUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA4MiBTYWx0ZWRfX8i3lrld8EEeX
 CZWUXR1WHPIwudfQuAX7zHzeKxM3uAcCL8PJt80SLJUUkB92ED3kwOJaSa1pV2945DA6bBKrkRG
 +Q3DTw0n4Zb7UhiTHQC3nM94B2Tv45k=
X-Proofpoint-GUID: hec-NSCBgVNHqD0Ku_6ASDvZ5kwwIdqU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA4MiBTYWx0ZWRfXyTCHVYtT5CWT
 b3w+wam0H4HcR4odwdRLkrKioav0zaXhIunq0RfXt8o9UeTqCiWD3p6kV9H+Vs0ousYPU8hphiV
 nGbMEMMzCBDH+UHFinqjwfNhlLEI4qRAJHDnbQk+K+jqbp3gRcJZq/8M+hzKc04pXPcXMXVFn9R
 92BFlCIDkaXwpVRP+xugixW9GsllZIXaqDP0LkR6ax6bLUoh20TjsMhDxC8LmxvrRvvZ5rdeoE4
 Q+b6CIEZXNJRLwgUZS27bEY+kzXlkYvCr/4Zbq9sL8j7rPR6ChAtWXnAIYS5vD0Pffjrkvl5Bz6
 p24xjKCHFAribWeI/LGkUbzH6Xv2tvMAUfvmULWuO7DY2/VFj9+rhXu6gXlGIn+ryYfr0Ux5WVz
 BUZ2pjVoKawqT2BK5axXT7KFEUCIpehSRmfoWMGsQJFW5u7a9JV+cCn/PUmwAN3XtnrbJ+c+9fp
 zolIkSSXflrsAiXrW7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250082

mingming cao <mmc@linux.ibm.com> writes:

> On 9/25/26 12:01 PM, Dave Marquardt wrote:
>> This code change is good. But I noticed another thing that's a pretty
>> minor bug of useless code just after this:
>>
>> 	rc =3D -ENOMEM;
>>
>> rc isn't used in that code path after it is set. Is there some reason I
>> do not understand to have this here?
>
> Yeah, that |rc =3D -ENOMEM| at line 728 is dead =E2=80=94 set right before
> |return 0| and never read again. Pre-existing junk. |d43732| set it
> for the bounce alloc that used to run next. |d6832| moved the TX LTB
> earlier and dropped the bounce, but left the line. After |request_irq|
> succeeds we replenish, start TX, and return 0.
>
> It's harmless (not user-visible) =E2=80=94 I prefer leaving it out of this
> Fixes and letting the MQ series clean it up naturally when it rewrites
> that whole open() path. But fine to respin a new version if desired.

Agreed.

-Dave

