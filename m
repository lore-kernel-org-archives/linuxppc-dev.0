Return-Path: <linuxppc-dev+bounces-25177-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF152C54F54
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 11:55:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBPfG2t3fz2yY1;
	Fri, 31 Jul 2026 21:55:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785498950;
	cv=none; b=MghFYkyAh1j0S+O+c9Gmn/HJPD2tgeLLV0KHHW7Rck3qqaWh0nWmCK4Tn+VrJw8XKejKwLTdekwxhC14hIEsiftrxvwjHm2xjei8pJHHXe3iK/m8sCdjYqA0/8fcDebGZvEASZ6xZwEFd6RbvgNE1Xo6uFEmEh2ecfrrZnyrikz7B6xawVLJtwNwObKohEc+QodsiOdA2Nzo5h82wFHFFSMsvOS0GLkki9D+TEJsaJecUSuXjdGKGbvMWellzqI4VjJoLfJ9E8eiU4+41p8tL7fF/FKQrHch1/M3cYnBXNPe2LDjcABf6ZcjC82cuUGJJOcXrDezrYnXdZfDrb6piA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785498950; c=relaxed/relaxed;
	bh=8HnNS7DGbIPC9jgNm0qrjfJUjZ6NgR4yBw+0KzPt2uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjSRICW3RHCNUBCr/fWS7tDPGhCqlVzIQDnXelKkQp/ku331ati4YpnVDbR151/5JFi3P3VeFf/vgayc45r/N6OfYFjrGzwHXNnybgt9bpRHvXhvYvF6oV1zyxL/WaSlJirZ7eE5mk2kIzJ7nIAutePfu3qfJqD16AVFL2FQ4ccWQhispsNMJAj/l4iKoOchgqgmEE+/BIvM8Wa9LmOsBD96KWPezKV4gAdDS2ch7zrEIFAyLAu2IEYsAqy1w3TogiOnsq+AqG3oQoRGXuYFXH4x7dsKYeK7pRIJYTWIkDSeAv9nuafXu+EpgCxH74lPQa4fgbN1XoqqF1roah6qbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q2du2God; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Q2du2God;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBPfF33H2z2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 21:55:48 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm60R4073772;
	Fri, 31 Jul 2026 11:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8HnNS7
	DGbIPC9jgNm0qrjfJUjZ6NgR4yBw+0KzPt2uc=; b=Q2du2GodkpGTOFTRRdLxOg
	A/u7456kOeBVvMf1AjElTZtUWP7+ClZ/otKVqLnxPSPA+eULDkx7MJvGBUmQ1T9A
	Aty8EDca+GY6qLpR/G/G3TtMr+Sh7ZRYAzMJiqANn/BF+PoELFEZEosWrtxcBwqD
	zWzMLVVEuJ/F62RK8GOo7WVW+x3vyhZzUJgpTTOLt+YMWIC429r5Q3qc44njm0zm
	CyPiePNSeUSLPpeAPa4xRm4qnAUhCHGDlQhtiyAbEFulGuggPZGipyGpowug+Hr8
	ak5i9LiukRlrTHeReVSxkqxEVIbZqZhJ1ox0TjFGNEhxkth8FDI7LVUHrOUyepWw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycvrpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:55:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VBfH3v007646;
	Fri, 31 Jul 2026 11:55:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgqjfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 11:55:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VBtbud6816416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 11:55:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 148D45805E;
	Fri, 31 Jul 2026 11:55:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2003358052;
	Fri, 31 Jul 2026 11:55:34 +0000 (GMT)
Received: from [9.43.104.204] (unknown [9.43.104.204])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 11:55:33 +0000 (GMT)
Message-ID: <fd3d2963-3e42-45c9-8d36-1cea78453194@linux.ibm.com>
Date: Fri, 31 Jul 2026 17:25:31 +0530
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
Subject: Re: [PATCHv2] powerpc/44x: Set GPIO chip parent
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Rosen Penev <rosenp@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Linus Walleij <linusw@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20260517063754.21819-1-rosenp@gmail.com>
 <CAKxU2N-i02g0jJaiJ+GzX1iQ8_W=uX0iMpmeNw=0=u-xU7tkLg@mail.gmail.com>
 <1062ee0c-cf44-479e-a442-3dfda7d7614f@kernel.org>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <1062ee0c-cf44-479e-a442-3dfda7d7614f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: BzetAm09BFE8vka1Gr8QvYbJzoUhKobq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5MCBTYWx0ZWRfX0aticTbQrLW6
 UL+4rhJAX8/2IG7FJoX9MRGAQUxkogAbUsSlpA6GazV22vB1Ve1eZGvAHVlYZ+lQdmdTD0xLNRg
 bZSCVTNXPPoE6+cYcgjnWVlBDQ3+UETTlBN1/CEZLNjDsHRWwhqoGjrBnfifxH+0eS9cJUqezlN
 EJKEUeyGGzYDQSfGnl+TrwOIT9BAyaFrFAE5tGeIBl+7GxYCdoJ+LX4x6ZAWJct+32SAB4xQZg1
 91wyYV2k/zIFIN4qXsgOCyKMTQZPnBAxOsFRRURYTi66Fr5GWRISykDyQeGNc1FtYUIvyrWNF7b
 dd8i8F12lbBiB4TUFiaf7HrwZhETS1J5ZZ+daXi45ue9a8rxq/hnEKTW/RKHlA2LiEGU6n8PSbB
 iKahmhQQ00LImunoPh4k4kJLWLV8hVIscgqW8DUs3MN+d5SDxtU9dUNEqGjxYI5bSnlpmUeD4VV
 GCL1FU9ykQkqfl683Ng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5MCBTYWx0ZWRfXzNyWSl7EKHMw
 hr3JE4HWid7vVXuoG1+PhEj/Fu2T1UXn2pBo7kp+67bZsVplmleJ6O+khN+3g7QTNGLn8sWl0TT
 6cCQX/K3RuKS00TtaGnvugmCAbdIhq8=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c8d3a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=voM4FWlXAAAA:8
 a=pGLkceISAAAA:8 a=lQdpcnZ2sh4bLRxID2MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: CIGAHYmZxS0uOAvzEv0KTCdaPeAVw9v-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310090


On 7/30/26 11:15 AM, Christophe Leroy (CS GROUP) wrote:
>
>
> Le 17/07/2026 à 21:05, Rosen Penev a écrit :
>> On Sat, May 16, 2026 at 11:38 PM Rosen Penev <rosenp@gmail.com> wrote:
>>>
>>> The PPC4xx GPIO driver stopped assigning an explicit parent
>>> to the gpio_chip when it moved away from of_mm_gpiochip_add_data().
>>>
>>> Restore that association from the platform device so OF GPIO lookup
>>> can match phandles to the registered gpiochip.
>>>
>>> Tested on: Cisco MX60W. No more probe deferral.
>>>
>>> Assisted-by: Codex:GPT-5.5
>>> Fixes: 1044dbaf2a77 ("powerpc/44x: Change GPIO driver to a proper 
>>> platform driver")
>> Did I forget to ping someone?
>
> Probably not, but afterwards you sent your series which moves the 
> driver into drivers/gpio/ and which does the same, so this one was 
> flagged "superseeded" in Patchwork 
> (https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20260517063754.21819-1-rosenp@gmail.com/)
>
> I put it back to 'new'. Maddy, can you pick it up ?
yes, i have added this to my next-test
Maddy

>
> Christophe
>
>
>>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>> ---
>>>   arch/powerpc/platforms/44x/gpio.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/powerpc/platforms/44x/gpio.c 
>>> b/arch/powerpc/platforms/44x/gpio.c
>>> index aea0d913b59d..4413a94cf7a6 100644
>>> --- a/arch/powerpc/platforms/44x/gpio.c
>>> +++ b/arch/powerpc/platforms/44x/gpio.c
>>> @@ -169,6 +169,7 @@ static int ppc4xx_gpio_probe(struct 
>>> platform_device *ofdev)
>>>
>>>          gc = &chip->gc;
>>>
>>> +       gc->parent = dev;
>>>          gc->base = -1;
>>>          gc->ngpio = 32;
>>>          gc->direction_input = ppc4xx_gpio_dir_in;
>>> -- 
>>> 2.54.0
>>>
>

