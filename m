Return-Path: <linuxppc-dev+bounces-20325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B635AFF8875
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 03:38:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5fzQ2jgpz2xNT;
	Thu, 30 Apr 2026 13:38:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777520338;
	cv=none; b=DHKlg5yjmEQHyuuyg+P1iPsda438HwLt/iu8SzyCmlmr6xsZvsZOJ4eqzo/jsqoPDbhUrvizc3FVKr+ofzo/ZNI0vw82s+0GUPdQfAwx6C+Mz1tSkVznZW3qXnZzOpGeAkjGEgI5QtClGjCjrFtuM8T801W93eFiWF2jD9UYPRgGcNUHR2Qdi51uk0EK8g8I8tRv1Tye+610drHb5KIkpFEf8kVsnNZM6223Mev0Pc1N+c9FeNNVbQUgmiQ5MNVBDDJsptFyuAId5V5QSQ3+Tr3XpOyJy/kX3Xt/Ii2IIYgon/wYfLKpwhhWslaWJ85AF5mJcTWY0gG4nwYItM5q0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777520338; c=relaxed/relaxed;
	bh=pO8mcxKDRYMKKHttTXUcxSdtULZ3xjIGbHMmmS5djkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UbGuxLMYplJRzLw/bSyBPb4VC6sHx+R+hbcbfNZBPJnsRHv/kOK9YgxdhQZUC8YN4uyFpkJVZThWbozDda0sSXC/MVJFGSz7nl5ueVmvWxfApFllyb3BkuouUlMbeSH44mWEdWHywxDlKDh+Nn8LCN6Nem+uT/a0WsIwuqgckkloNTmY9tcv2fbb+9g0F/qj/3penvreok88DpCtuFM14LQeIzkaxgaUgbuFNgP02z11SxfLh6fSkLdY4V9eLj6+0e5vYVHp00NQDa6Ye5k9hA7uuk6y1twmFPRJkf+obyzrO9NYKSjrMphaqPY8AeDb9Fs38RiX8xq2aI3K5VYBPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h4HscEAR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h4HscEAR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5fzP16G6z2xMY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2026 13:38:56 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TEP1Px1684395;
	Thu, 30 Apr 2026 03:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pO8mcx
	KDRYMKKHttTXUcxSdtULZ3xjIGbHMmmS5djkw=; b=h4HscEARxzgBxCye8ow9vv
	RHAK/BK8q5CMfK2/2VleYSbDkN/qipwFuSJRDR3pEF+HNKA//naRxxIZPTKNFRmp
	LQVgG3QDLzbQeL50EM3r28gEWTbRWKBfw1DclgAGHLivJG89EKYsvuXRRURBxsdS
	xNxJw5C5lFFnx0kgN7qEgXdtIS2zYPqQ8ncXwbUmSwcVTKpgpwFBgOLZxKXjWSJI
	VOUKxDCikgUa5WqcprSxngJIQC+Mfe/c/wCwinkNdKXAE8ETJ/efVHpQa3gkt3hS
	Cwb/rDkXnhwS4fq2EjKHOezTMXXrVDGIQZ8B/Vf3UNoqyg8WN8rJrXPDHfff8nYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5dphg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 03:38:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63U3NnGN017785;
	Thu, 30 Apr 2026 03:38:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqhcj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 03:38:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63U3cZuF27001444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 03:38:35 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 135175804E;
	Thu, 30 Apr 2026 03:38:35 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D84B05803F;
	Thu, 30 Apr 2026 03:38:30 +0000 (GMT)
Received: from [9.123.2.213] (unknown [9.123.2.213])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 03:38:30 +0000 (GMT)
Message-ID: <fe9e092f-4e38-4f1a-9af3-649fef95ee28@linux.ibm.com>
Date: Thu, 30 Apr 2026 09:08:29 +0530
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
Subject: Re: [PATCH RESEND 1/2] powerpc/ps3: Drop redundant result assignment
To: Michael Ellerman <mpe@ellerman.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Geoff Levand <geoff@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20260317130823.240279-3-krzysztof.kozlowski@oss.qualcomm.com>
 <90c122bc-3067-4e3d-8083-dd94844c31f2@oss.qualcomm.com>
 <946b79c2-ae4c-40ed-997b-ac654e148d47@ellerman.id.au>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <946b79c2-ae4c-40ed-997b-ac654e148d47@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f2cebd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=EUspDBNiAAAA:8
 a=9-q73Pn_6tbH8AxS9DkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDAzMSBTYWx0ZWRfX/28iLYFVbcvc
 8VlBNaDoOwhCIv3sKGPoL7vKUXSObBm9csJE06D/NaSUxTEFpd+5+oF/jPHXBXkGNOzzcWuK9Ul
 9yDBGDVQLlEqsMC+5NHEtDqQ1tqRXsXIIIgYADK76UXqxQscv2aF/zK0Q9yn0Mc+PQfQGxerVbw
 R4uRMU84CPF/a5wBHedm5i6JTzbxyT49Eruuspayt9EZxI/2zjNt0zcDZ6TXNKarv0iI99EgzGd
 O/QDsIiQ2dkAUv1hrweGoXgAhsWWSA6b0+6ZGoBHxEz0slRF4FfuvGMD1tvn6bi8PMLJWtqFSCc
 Lx4CR+BpsOA0EUtMRNpe5qC71GAbP3k5ZOg8r4tD29VWSX7R60D47CqXzfLwbiKKSGJDqfNZTK/
 qqaz+YR1WuZY9XDZBGaLD1SB7L4KCPYy0N7kG36tTEUBDTwx3/QfGrTDBhRZ3cxYiz5OdPr6NoE
 Xr4fIO/+HtRp53h/R0Q==
X-Proofpoint-GUID: NZelHy-82CvrztAqBX1pT-aoncFTrmPz
X-Proofpoint-ORIG-GUID: 3xo6NRUxW_4prS3RUXfXTxxpB9Wsqwi9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300031


On 4/29/26 11:33 AM, Michael Ellerman wrote:
> On 28/4/2026 23:22, Krzysztof Kozlowski wrote:
>> On 17/03/2026 14:08, Krzysztof Kozlowski wrote:
>>> Return value of ps3_start_probe_thread() is not used, so code can be
>>> simplified to fix W=1 clang warnings:
>>>
>>>    arch/powerpc/platforms/ps3/device-init.c:953:6: error: variable 
>>> 'result' set but not used [-Werror,-Wunused-but-set-variable]
>>>
>>> Signed-off-by: Krzysztof Kozlowski 
>>> <krzysztof.kozlowski@oss.qualcomm.com>
>>> ---
>>>
>>> Resend after ~2.5 months
>>>
>>>   arch/powerpc/platforms/ps3/device-init.c | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> Ping. This also got a review.
>>
>> I do not plan to resend second time... And I also understand if this is
>> somehow legacy and fixing warnings is not desired, but then it would be
>> great if you just responded "don't send such patches" and I would not
>> waste my time.
>
> Thanks for the patch, sorry it hasn't been picked up.
>
> I have been AWOL, and I suspect Maddy is not sure about taking PS3 
> patches directly without hearing from Geoff.
>
> Maddy this is fine to pick up for next.
>
Yep will pick it my in the -rc cycle.

Thanks


> cheers

