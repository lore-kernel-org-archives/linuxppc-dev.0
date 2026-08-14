Return-Path: <linuxppc-dev+bounces-25837-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8B9C5B572
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 07:09:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLtcw5CPdz2yQH;
	Fri, 14 Aug 2026 17:09:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786691344;
	cv=none; b=gI5taAg0QwhRPzwye98HD1hyXW1Ee+IC58z4TDf0Wzp+pII4mmHP7n9mMJd8wN1ZqXfZ02KpZSVUY2hV8Y/fF6LMJGSzWxZ7A3OCsrDdvU18ITQXSSZ5BS95p4MZOnwNukCtdQN9+SBmBtLjqCr/g73XUSBQf6A48QeBKPtddkajrTsPkGx4fKvSHfD2TBB7nS4xokQGDNFT8rgKsVpHkWdPFleflvinR99xw/QPjsiZTqs2N10kP4Kvn+vdDg1bfwAq5YYi3VXp20Ah38i7fFN1KxoCjuTIfctjQlU0d76NXyL8WTFEL6oEZJsuCtVeb9pvoADTKzihngzXx5+rMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786691344; c=relaxed/relaxed;
	bh=9JwlBuMq8aFK6CuuLr9F6ZHKz8oh4YzfzcNnm8tFJaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnCgwHrJG+AiHrnUVtmCkdNgQps0nC/Wv5R+MqzdKg5NYCMYe3fFRQYEMNgMMcBJZzZUH5V/N095e03iywg4gi64GuFUnmMMM3B1Bwae1Z72I5l40xe4aSQcsZVfKH3drtJSuFj7ONazBoawuNK+vmUCrJv+oMgXT8VCPhm6EM5Kmk1Zdd83TFLBosheE0OZ1KZhbvnRySw81vmUbT49KAIp3/OoAT5fISHHuVpHrY8xBo26/9obOdYRivRmdxSSWQiYELxlQL2KlnjXkLzsOKfY7gOUPJCBrN8BvuCIZxY+sMfeUOrhz2f/ManicJmLcq+Xdn8paN9ZOAVtqrBA7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NjDYxFlS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NjDYxFlS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLtcv4rgwz2xnv
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 17:09:02 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4W6Sl3237725;
	Fri, 14 Aug 2026 07:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9JwlBu
	Mq8aFK6CuuLr9F6ZHKz8oh4YzfzcNnm8tFJaE=; b=NjDYxFlSzm2PSGTMROWPCM
	RqFKnvgymgJ2IscMXyjbF5/gGcXhBscCSdixQpRJuqTvyhUfNPgmwp4MfeEeO7fd
	Aw1puLIdH3y4YF15ARlytxpi1QByZ27utFMScNdEtIV9gD+RfnT8AU9VxKwvy4Yt
	NBffvVl9qMBllncB497rve8AtWxa6HnTVhJwklo0ti8Jyxhwvt6IHIRA//SEcIvU
	rfKSwgemjL9M0mz5ISB+C7YhxEBjIww3gOYQwPHLfddljo3zfGo2fKuG1LLbja4k
	k9tPDz3Q14ccGa3qlmq1ADc0w6fREZICd4gmlCIjp+Ssf+CZEUql86NRyw9WMcBQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb243vxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:08:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67E6uNn2030574;
	Fri, 14 Aug 2026 07:08:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9he86a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 07:08:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67E78YRX42467754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 07:08:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D5B820043;
	Fri, 14 Aug 2026 07:08:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C463B20040;
	Fri, 14 Aug 2026 07:08:30 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 07:08:30 +0000 (GMT)
Message-ID: <014a7724-4955-4fb5-b331-ab5fc9abf806@linux.ibm.com>
Date: Fri, 14 Aug 2026 12:38:29 +0530
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
Subject: Re: [PATCH v2 1/3] ARM: locomo: use put_device() on device_register()
 failure
To: Tarun Sahu <tarunsahu@google.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, djeffery@redhat.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, dmatlack@google.com,
        Pasha Tatashin <pasha.tatashin@soleen.com>, souravsgl@google.com,
        skhawaja@google.com, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org
References: <20260813095421.1700945-1-tarunsahu@google.com>
 <20260813095421.1700945-2-tarunsahu@google.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260813095421.1700945-2-tarunsahu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7ebef5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8
 a=VnNF1IyMAAAA:8 a=uCD4N2YI4OkgVMcWFWUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1NCBTYWx0ZWRfX9eL7khLqTpsz
 H9mU347g0+6t8AubXsC+IdnMzvGvVj1JPyVoc6bwspDLgyykecXW4jbXAPLrfHYrL7L0psDid/L
 gyZMu2eDW5worrAuTf9zUqhvxY/3rEIEkHlLBoyJzRIDXWGsj1/ppziMcszWeLu1z/mtQEts0Dd
 iDd5WTlgxKxUS31IbkwuzkjhA7x/ICpCWzWLfKnazv5tQf0URxxnrya1ZaHxZIKf74ecUA2zJol
 Lc5AwNwtxW47dg5M0tzrB4MIupmKStXDVbzkrVP8uKUqldnigCU45b/X752wU9GHaccuMWiGW1f
 S6ZmkFuZAZ92tybdKK3mE4GGsQoFv0NoRd4DEDyYRCANysqBGXodyFmp7MRvjV2R4Yu+D//SUXt
 fru7HByrpfNqvM6ZrDhx8CFVodgT6hQ8BxFSsULJcJyKtd6+ONOhkxFqS/Ma4e8oe4esnviFhro
 Y+T+OEizBLfyUj3fpjw==
X-Proofpoint-ORIG-GUID: oqNk42v34wyTHQGK2XQV_4jNpEaF25LA
X-Proofpoint-GUID: yVKkax5Z7IlTCXG2MEVswgh_oYrze_6h
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1NCBTYWx0ZWRfX2Dp5/Q+fZtPN
 /Dy2Ldcv0ZmgEmPeJH/1/wChuuXbPg/tV7+NuZcfI/y6R7yxPHtnJ0hKQA9appoZsVRYjOblJ3d
 l0yxHm3G4bCFC1+rTmr2837fRr7wzQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140054



On 13/08/26 15:24, Tarun Sahu wrote:
> When device_register() fails, calling kfree(dev) directly bypasses the
> device_release() callback (locomo_dev_release) and leaks internal driver
> core structures allocated during device initialization.
>
> Fix this by replacing direct kfree(dev) with put_device(&dev->dev) when
> device_register() returns an error, ensuring proper refcount decrement
> and cleanup via locomo_dev_release().
>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>   arch/arm/common/locomo.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
> index 55e360452828..0f6689d343b0 100644
> --- a/arch/arm/common/locomo.c
> +++ b/arch/arm/common/locomo.c
> @@ -223,10 +223,8 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>   	int ret;
>   
>   	dev = kzalloc_obj(struct locomo_dev);
> -	if (!dev) {
> -		ret = -ENOMEM;
> -		goto out;
> -	}
> +	if (!dev)
> +		return -ENOMEM;
>   
>   	/*
>   	 * If the parent device has a DMA mask associated with it,
> @@ -255,10 +253,11 @@ locomo_init_one_child(struct locomo *lchip, struct locomo_dev_info *info)
>   
>   	ret = device_register(&dev->dev);
>   	if (ret) {
> - out:
> -		kfree(dev);
> +		put_device(&dev->dev);
> +		return ret;
>   	}
> -	return ret;
> +
> +	return 0;
>   }

Changes look good to me. Feel free to add:
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

>   
>   #ifdef CONFIG_PM


