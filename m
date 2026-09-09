Return-Path: <linuxppc-dev+bounces-26913-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEC8C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:45:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfyB74v4sz2ynZ;
	Wed, 09 Sep 2026 20:45:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788950703;
	cv=none; b=Rlw2F3lUdXZATq/7Iab3N9/GZaVgLV+vY76Y3YF+pyCjkWKLq070FnckGSy8xwfFrRIb00G2cTmg9U+qLg7tjfl9/CXDqa6xaUJCjBVxWtErZOuYioB1PBj/04ZO6BYbm1gAgYWKw9wGnPSTQoio/P0QHa2X3uzavNeHWR3wQqKoVtSDwVczzEdhCe78b3uLvYFm4zspwvm5K5hTL8fTq5psu+9yLABYYbWHtTnXBKOQNzcDS5HHogxCoMq/vnt5bk1z11IKPRe3jxbsd4CY6TXDmGXC3xUuKr28WMRIDS0HUANCqN+s8rkbjohE1sqHEJWL3mZLvJzs/6HKA1k8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788950703; c=relaxed/relaxed;
	bh=RNsLRg7xaLn+8QayF87gKyUo1RFQQl1tXb9Nf+7rbOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TVWyJyCkKyotZZaWrw7eNjTW9sls2Ie3HqwgL7rWXrIKTTc1QL+BYHHWyWPXpzvxn9+wJKQ2cYXVOXK4Isxxpsoc+fOu6YESgfw5ngO9/icA33/jYq4ZaVGuCoCRAR2vRAHcF2HjIZwDwCQH77mq3yk4VHOOpOLz48Tfq3VzVm0qo5iYIcfKIIt3HJTpA393+qhAcgl9T6jQrXQZzMu00vQkdImouhgv+NHRgzdsPigRm9+AkixeiPziFjop0A8tFlxN5oLb26He3JtNINn3yz9+2R6hauaI0SzTh1UeUCgwa6Eye3IB2wok74FpiqRhUS2i59oCq1FTvskSdOpR1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kzqBW1W7; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kzqBW1W7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=tshah@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfyB45ss5z2xrL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 20:44:59 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6899uOab2126130;
	Wed, 9 Sep 2026 10:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RNsLRg
	7xaLn+8QayF87gKyUo1RFQQl1tXb9Nf+7rbOg=; b=kzqBW1W7VVZnypEt3gA2y+
	eNyNPUB032ipgbHCZQULKwaCeh0jc0AibzDRH6Z2BOifeYzYrKu+qImKFxTGJFA/
	j29VETNpG5MXkl5wtIHYjueKJ1RTZNp/IHNOwARtdHE5d+hPEGBX3KGpZxGWFtz2
	qVQoYQ8bsFiK98GIHts5xTNLwCf20VHMUMaQJgdK+2g9UzXqKWcu7St5cYX+q9nx
	yPP5ungbigzNt+76llT7v68IMngWTJBlm9pm2jVkXr/vqRHU/pxSPztdUyM+nc6G
	6z8T+pzYs8ts6Z5pHPz7aWCo+iWhLrXV84dlvrwFE/sEL7QGMeZ0wfBTLEojXTjw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj8cx5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 10:44:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689AfEIh023026;
	Wed, 9 Sep 2026 10:44:49 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdk1s4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 10:44:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689AimiM4326016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 10:44:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8E4F5805C;
	Wed,  9 Sep 2026 10:44:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1255D5805F;
	Wed,  9 Sep 2026 10:44:47 +0000 (GMT)
Received: from [9.39.16.79] (unknown [9.39.16.79])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 10:44:46 +0000 (GMT)
Message-ID: <29eac5eb-1078-4297-8058-0bbf4133235c@linux.ibm.com>
Date: Wed, 9 Sep 2026 16:14:45 +0530
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
Subject: Re: [PATCH] Documentation/ABI: hv_24x7: Fix the catalog_len attribute
 name
To: Karl Mehltretter <kmehltretter@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <20260905103027.43239-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Tanushree Shah <tshah@linux.ibm.com>
In-Reply-To: <20260905103027.43239-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vsL-yIJk9MyGbn0fPx0U5TbWbg-ziDf7
X-Proofpoint-ORIG-GUID: uHhvALLW3F8vpWxTQr2B_ObCVVL7MJ1o
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa138a2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=CVqDjNkvAAAA:20
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=9UeR2yiycm2xdZ_IzNAA:9
 a=QEXdDO2ut3YA:10 a=IC2XNlieTeVoXbcui8wp:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDExNyBTYWx0ZWRfX7RL35BcdZc3B
 4Q3vgz0NM5s1T0cvmP5Icpg70sJwsjIif0dB9XNQBtPLbdD1fKelfsLLTCHGEuuzSHCEe3UM6np
 +YwomCxROCCE9R/iGw6wekpbBk0NBMc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDExNyBTYWx0ZWRfX+hjLkJYP+np4
 96lHWyGSKZB+EAJ3PGN1Qfe7iuQykos/aocTrvwqcpwO0/S9c2KZpGbsWpQPGS1jeihNjJ7Tfcy
 CUFj8E6j6+26pI3mDHpOxFMqKOs1zMOFqUkxDLVIqlglDbQtZ7Y1cm/gsnEnXxU0akPzHSI1o5p
 jWbUnVSJ0osdXE/X0/B/doQeAyr+fo0Srga5WDuNHXlRyMVLnPc597d4V28c14ctFnGcAYJYKDM
 mvS+qx3dpF44r2i5fUSV2ifGqfs2q1rmTK/bsYpnMkvkeoQ7dLAjuUlyTcTSOxqark1/6SKtwPq
 a1hx822TDBhCumwQDQKUC1sPfg69XU6XmlDmNji20pk0OJJdZAtE1PfmtIA0Bka/4Khk99Y0nBS
 NJ/S7zPfjDsK4+xa0CAD0caNcT0dZRM+0N9G5nIDOaJ5yd7Idck2+AQvnH0N5PL5s+vIsNi3K5O
 sHYj5hoJLxi2wQwIC6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090117


On 05/09/26 16:00, Karl Mehltretter wrote:
> arch/powerpc/perf/hv-24x7.c creates the attribute as catalog_len
> (PAGE_0_ATTR(catalog_len, ...)); the ABI file has documented it as
> catalog_length since it was written.
> 
> Use catalog_len.

Checked against arch/powerpc/perf/hv-24x7.c - the attribute is indeed
registered via PAGE_0_ATTR(catalog_len, ...), which means the sysfs file 
has always been catalog_len. The ABI documentation's use of 
catalog_length has been incorrect since the original commit ad0a02b83477 
and has never matched the actual code.

The rename to catalog_len looks correct.

Reviewed-by: Tanushree Shah <tshah@linux.ibm.com>


Thanks
Tanushree Shah
> 
> Fixes: ad0a02b83477 ("powerpc/perf/hv_{gpci, 24x7}: Add documentation of device attributes")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>   .../ABI/testing/sysfs-bus-event_source-devices-hv_24x7          | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> index de390a010af8..9b231c80ea66 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> @@ -33,7 +33,7 @@ Description:
>   		documented here:
>   		https://raw.githubusercontent.com/jmesmon/catalog-24x7/master/hv-24x7-catalog.h
>   
> -What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog_length
> +What:		/sys/bus/event_source/devices/hv_24x7/interface/catalog_len
>   Date:		February 2014
>   Contact:	Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
>   Description:


