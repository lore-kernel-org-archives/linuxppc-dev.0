Return-Path: <linuxppc-dev+bounces-28794-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C25CDCA5FE3
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 02:11:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxTfW2SQrz2xnn;
	Sat, 03 Oct 2026 12:11:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790993491;
	cv=none; b=YpOBtiQKmeycX3Nhdc54vRTvOS3ld4288XRJg6w8N2W+qsgNod/goonJP2UZugotTKErdkFaGu0Fma/++/yf8SG7cgI4sxG+fJosS7fcN3Q9ylBHtlVNsq3Wv1DtxOQFLiF+HWs5gptkZg7pVHz1jw5KO2d8gWkpUVYWvMgSvZuyCm1MehJrlBUS4s37l3mmX5hBbf2yY3kO3zTHVlk048e/eDEgMKW8N/TZoFcGFloV7Qn73bEoODa+s/3zc1vtMKpx8EknVB+oO8pSlCCaoQH9x3bW9sppHT/7NSN/KhrGi9hmfVVKLjTyunNG0tL0/Gt1zeZdF8WFwfFMcWC13w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790993491; c=relaxed/relaxed;
	bh=klVEewLrAW86Oep1CCUBMAi3DOy6RkhrYcZ8soryEgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NgtL7D6fYCfJ9o4153DEmj2IfxXe8tkWXjeTJbvXVZUq+raJZgJ+GyDexhtTxwWDGrf21LF6fCeFFG8H7BpyiRl05FC2E9PSE/q6BwcrvNXNFKIvK6r+EyX8/DAn31Wo+mypKdKAMMLfp8jRShqNj8aTfRUyaHtpk2o2OOHk3eUWcOG6kV+YJuNNMJY59Kn8J71iywyT/lZmmc0zAuH+Xf19EGibQeNOO4SrJvQmsh/amzHNfQttHBeRdyjDRoXod9LWX5aUMexEozQe7kGhzlKa/jMsh3UhAcHySJKmxg8Lo2jiAvPOk7m2qIWf0W65SgfEPCZLuIU6LvnRAP1HaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BjGBjx2B; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BjGBjx2B;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxTfT58SQz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 12:11:29 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69305viL074471;
	Sat, 3 Oct 2026 02:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=klVEew
	LrAW86Oep1CCUBMAi3DOy6RkhrYcZ8soryEgM=; b=BjGBjx2BaxWSxJ4gM0N/p1
	c9fkMbWZRBmJzkU7liLKd3554YQWkLcjzZSvE2DJsDSGcSJ/pI4Rs3eQbbUrKK/y
	x1HYBvf8jxNqb1SQ6ErP8xYC5SqiIDg2j8whoILepVTaxXig/e3/0sDKNzXhakQM
	BqJjdYEn92Ede6p9vNFBe+zdQLr1Qg2PQiAQMJ4El9hDYDeRUWNCZfL1lJXgk3Ze
	8SXSjswF0cKPn02SEOHWe9r25//BtCZG0nKvI3vhhK5fLkgY5Ni7cyT8iEHdgn5F
	AySA5OcvEXnbY6h1fVyBnNzV3wh2LyqIlmkNE+4tSsAxJKBsQN1JNsaO5hUgRFFg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrvj0x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 02:11:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 692Nm6Fl3271580;
	Sat, 3 Oct 2026 02:11:19 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h21nu4mbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Oct 2026 02:11:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6932BGk242402160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Oct 2026 02:11:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E20958059;
	Sat,  3 Oct 2026 02:11:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 429DE5804B;
	Sat,  3 Oct 2026 02:11:14 +0000 (GMT)
Received: from [9.67.102.94] (unknown [9.67.102.94])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  3 Oct 2026 02:11:14 +0000 (GMT)
Message-ID: <7de436b1-82b5-4726-9915-a9a78a20c903@linux.ibm.com>
Date: Fri, 2 Oct 2026 19:11:10 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 00/15] ibmveth: Add multi-queue RX support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com
References: <cover.1790319558.git.mmc@linux.ibm.com>
 <966a8145-421e-4be1-8d46-2cf8e4f9fa2a@linux.ibm.com>
 <20261001155646.5957a373@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20261001155646.5957a373@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwNyBTYWx0ZWRfX7LLk9lnX3waw
 4L4A3tXLp3n8sEBc77YTG+SmGIm1gH/L13Loq0qeq+/iY4yESrbwTEYzZblo59DqomtkvR0VBp3
 2jiwR7jiFok15xY1UhwKoPDAUja6YcTzcaGF1DtVwfdA/3KoJ8EU3VfvDDILTXitGmBbkeo3/E7
 z7ldCAQwYwArwjQ5T9A9KwwHUdViej8ynrsuQQc0LcyjZobENRo8so8gUA+CZbDYhmdJscPtIfd
 88+Hpqrk0n5Nsgus8S7KAkFk77INBwyRNVwo2zw3fmczzqPQ80fnq8U0D9TQNB1LlNSEdobPA3L
 9rlPvuuQ1tH9KQkI8dH1oMZ7hmz6ctCATohvJVkCJaACNqZQ739jzqV55LOcRtM0VOpQLkr2xyY
 pTTZ64aoR8D+K3Pm3X80qLB4tiAkrwp+VbtUHutE++uE6GhZyF9w/nhDNytrMs/GQ/nfV9ev8ra
 ORlKIxxjgKZNsZa+hhg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6ac06448 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iUzFjSLacEydRaroFD8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aMaXooieIFlm3P_LTUXyT-rPmQc5NwwK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwNyBTYWx0ZWRfX5V2e/egiWznx
 39/xalt2OKklK/L7T4cEGuQBXZLHBrKFhI79+ugDplvl6J/4kaYTrO1mnjMR0ahF4Zy7dtahiTz
 XoBnXLk3yhOAa4fhTqw7yqbVQWpmNb0=
X-Proofpoint-GUID: cVczNlVjocztJ2dL7lquGEGPk80PC6Fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610030007


On 10/1/26 3:56 PM, Jakub Kicinski wrote:
> On Sat, 26 Sep 2026 10:40:56 -0700 mingming cao wrote:
>> Hi Jacub,
> There's no c in my name, sir. I wonder why people do that.
Sorry about that, Jakub. Noted, and noted on To: as well.
>> I noticed this v7 series is flagged red on patchwork. The apply failure
>> is due to a dependency on my own [PATCH net 0/2] (Message-ID:
>> cover.1790357373.git.mmc@linux.ibm.com) sent the same day — kept
>> separate per your earlier feedback to peel fixes out of feature series.
>> Both touch ibmveth_open() in the same region, and the net pair is not
>> yet in net-next.
>>
>> The v7 MQ series is based on net-next 161ea2d4f2a7 (2026-09-24). The
>> fixes are already subsumed by MQ patches 3 and 6.
>>
>> Shall I wait and rebase MQ once the net pair lands in net-next, or send
>> a v8 now with the net pair folded in? Happy to do either.
> Sorry for the delay, hint: please put just me in the To: if you want me
> to spot the email sooner. We get 400+ messages to the list every day,
> I'm only reading the list as I review :(
>
> To answer your question - please hold off with reposting until the fixes
> are in net-next. We won't merge the patches if they conflict with fixes.
Will do. Thanks for applying the net pair (af0524bf4ce1, 84bec0bf0352).
I will not repost the multi-queue series until they show up in net-next.
A heads-up so the next series is not a surprise: I posted seven more
ibmveth fixes, split out of this series:

[PATCH net-next 0/7] ibmveth: fix hangs, use-after-frees and
netpoll races
https://lore.kernel.org/netdev/cover.1790991039.git.mmc@linux.ibm.com/ 
<https://lore.kernel.org/netdev/cover.1790991039.git.mmc@linux.ibm.com/>

They fix serious pre-existing bugs in the driver (two hangs, three
use-after-frees and memory corruption), found by AI-assisted review
of this series. They are based on net-next and merge cleanly with
the net pair; they also apply to net if you would rather take them
there.

I am working on v8. My thinking for v8 of the multi-queue series is to 
base it on
net-next once both the net pair and these fixes are in. With the
fixes split out it should be smaller than v7, with the MQ patches
mostly extending that handling per queue, and it would address the

review comments on v7. Hope that works for you. Happy to adjust as needed.

Regards,
Mingming

