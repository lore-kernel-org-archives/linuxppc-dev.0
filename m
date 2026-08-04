Return-Path: <linuxppc-dev+bounces-25390-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F273BC55ABF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 18:31:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hF2FQ1Q2Bz2yH5;
	Wed, 05 Aug 2026 04:31:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785868314;
	cv=none; b=VLSgsZYQ1Nhy/KbgSDIFaJQWlcrB7PqyRdHShK3Uq0YDfr0gUdTXks5PhOlsedLI8c0kzGhEVeeLl/5UIRDHN1y/FrFflOAUHAXrHln81NolYduE78bHQy/MNIbeOcw66oFl3WJHwcFAS8DnLCJSn4MNtkB41tlScbiTIFrGWwnvAUgdfNYN7K1Mh99P37weTjFbiuAeMeXXsALVVFiYiHrcqtAz6lUYl2ic7rs21LZdYCC1MZBtt33fCee98afgzU+V2ZUY5TPqZPEv3XPtS972cMDeIqk2toIPZRcDz6T/jbrA7OAPkpVYjO50STSvQkm/IuMhpnEkEAwdpZ1XSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785868314; c=relaxed/relaxed;
	bh=/AWKT4TwWR/drIdla53c4HCq03ZpsWHFr/QNgTQooFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XESsFeFU0ZUUk1yuUcFjLi9HUGdtrEYFuDq3e3/qdvYKtES2RnVXB0N1lV3WSb2BZCmNWQxU/ZadUKhufu8bZiGC8+KVHn1iOGNBlz5TNoSLr3tPhdoZPo8RKnh+vmbp3WtmND3y4T3dKV0PlQPZbPPkmeBbMGZt9+5vy+f0H9WdoTazlcBPl+4xdQAELX/RbvkU8D8fUZ5atGGOKEZslWOgsZ994VSV5sSCPuS6jH/AQ8qnC19pxNC0r4Gwm3Z5rIv7PtSE3I4fZuE2OFEPuGvs00I6Wawqa+kf32ZmCMfhXahyg5Ggo3Ba8Wi9nvxn4Gw98dZLpxOzJHYGMk2Taw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hHHc+6Yt; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hHHc+6Yt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hF2FP122Gz2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 04:31:52 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Fm70t1193105;
	Tue, 4 Aug 2026 18:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/AWKT4
	TwWR/drIdla53c4HCq03ZpsWHFr/QNgTQooFE=; b=hHHc+6YtUi/FQgH/wJbkAK
	ANIFhadYGPBUkCHURwcxXRZXmO5YYvQ2JeXFcjUstyfhvAWVlkjr04HZnvfvfrA2
	L0ReQrdYhW+Uo9CCYIGn0RH13uPsyScH5F/J9R9DHeqwa5q1NxvptV83XO129BPN
	QG8JF5wmJnFdz+kFEz59FtwZZOrTArJsmQaR9H6KXfU6VXWT472t/PvMi2go0ZKe
	VsjSFM57Dgd/Ks4UAZYxOudR19BDdTEycNS/UHqqXhJkp7wX5INix6N3y/GVWV6u
	HxRWTI1EoNNmUMjaNmI0vddbTzgtT/qe0upBQuM2vRt8f0WW3ZzYxKBQfdbD32AQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hq7dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:31:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674IQK9X015802;
	Tue, 4 Aug 2026 18:31:39 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k389m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 18:31:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674IVYEs32244138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 18:31:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BFD42004B;
	Tue,  4 Aug 2026 18:31:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 063F320040;
	Tue,  4 Aug 2026 18:31:29 +0000 (GMT)
Received: from [9.39.27.173] (unknown [9.39.27.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 18:31:28 +0000 (GMT)
Message-ID: <09563f43-9514-4fc2-9e90-f9ad9f528bea@linux.ibm.com>
Date: Wed, 5 Aug 2026 00:01:27 +0530
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
Subject: Re: [PATCH v3 5/5] powerpc/powernv/eeh: Map VFIO EEH error injection
 to OPAL
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <20260721033815.5300-6-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260721033815.5300-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX4kVp/QtEkrLL
 tCnLHc+KqZHaGapgUOjq/U/19Rxs5M8HciBtBZCo8Q/5aAlNIdOjOgKUugsjOBB668B6hSfQI7z
 jr3UexWNgwG0r/a6SYA972Vwu5b2Des=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a72300c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=XOFTBcSqSKUkeO_VsGwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE0OCBTYWx0ZWRfX7P3tfvacq8R1
 QxoSz3mB8N6t5BKHlckK4uklICbIVCMiCN5urwc9xb4Y/HuUcJLTm8SnZZBYV7Wi7ne0SOyJp+y
 b03D/Qw40419hFZzWnj32Q1AO8feN9fd2890LeUC2kK+OobUMKvXCRDeCcuqCi/mAY0cP45L/kd
 QVLQKpnE71LNNwRFq0VKFT6Aa05Q/CPkyogTtmcqLtA1Jj624gKJ8+nSOwpLsf4/WDZp5/6ODsL
 GXVzqqoJqHxMLK0UDmNFxwuzw3TgFY9GD8iJeQFnwvFAIURNeprwIgsGFYVXqTea6MEJAaF/V+z
 PXOqMp0ymDFdWWp7s43UmT0yFaKUPMmz9ymcanUQsZEXl1vDcuaLen1+pNiQ+lYfKVh/dCQ6bnW
 h6wXAmGUKKbCo/oe4XHiFbh3E67qrdPneu4tu8SNb7a4mwky5X/MQfrgecQ9L0vtAu7WRxlqVp1
 81kN6DRvpODU8i7fHwQ==
X-Proofpoint-ORIG-GUID: Dnkt_rFUycSuVSub2dRLazuLXL8hLsb4
X-Proofpoint-GUID: I6XtiO3Z1uYtGdwrHCWJpfpjorHrLFbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040148



As per the title this series is about RTAS-based error injection on pSeries.

Then why do we have powernv/opal patch part of this series?

- Sourabh Jain


On 21/07/26 09:08, Narayana Murty N wrote:
> The EEH error-injection interface passes the generic userspace ABI
> values EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 to the platform backend.
>
> The PowerNV backend currently compares those generic values directly
> with OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64. Although the corresponding values
> are currently numerically identical, this implicitly couples the
> generic EEH ABI to the OPAL firmware encoding.
>
> Explicitly translate the generic EEH error types to their OPAL
> equivalents in pnv_eeh_err_inject(). Keep the platform-specific
> encoding within the PowerNV backend and reject unsupported generic
> types with -EINVAL.
>
> No userspace ABI values are changed.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 36 +++++++++++++++++---
>   1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index db3370d1673c..b0bcd014a133 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1169,11 +1169,39 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   	struct pnv_phb *phb = hose->private_data;
>   	s64 rc;
>   
> -	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
> -	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
> -		pr_warn("%s: Invalid error type %d\n",
> +	/*
> +	 * Map generic EEH error-type ABI values to OPAL-specific type codes.
> +	 * EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 are the only types supported by
> +	 * OPAL.  Additional generic types defined in the UAPI header are valid
> +	 * for pSeries RTAS but unsupported here; return -EOPNOTSUPP for those.
> +	 * Unknown or invalid values return -EINVAL.
> +	 *
> +	 * Note: currently OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR  == 0 ==
> +	 * EEH_ERR_TYPE_32 and OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64 == 1 ==
> +	 * EEH_ERR_TYPE_64, but the explicit switch makes the coupling
> +	 * visible and allows the values to diverge independently.
> +	 */
> +	switch (type) {
> +	case EEH_ERR_TYPE_32:
> +		type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
> +		break;
> +	case EEH_ERR_TYPE_64:
> +		type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
> +		break;
> +	case EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT:
> +	case EEH_ERR_TYPE_CORRUPTED_PAGE:
> +	case EEH_ERR_TYPE_CORRUPTED_DCACHE_START:
> +	case EEH_ERR_TYPE_CORRUPTED_DCACHE_END:
> +	case EEH_ERR_TYPE_CORRUPTED_ICACHE_START:
> +	case EEH_ERR_TYPE_CORRUPTED_ICACHE_END:
> +	case EEH_ERR_TYPE_CORRUPTED_TLB_START:
> +	case EEH_ERR_TYPE_CORRUPTED_TLB_END:
> +		pr_warn("%s: EEH error type %d not supported by OPAL\n",
>   			__func__, type);
> -		return -ERANGE;
> +		return -EOPNOTSUPP;
> +	default:
> +		pr_warn("%s: unsupported EEH error type %d\n", __func__, type);
> +		return -EINVAL;
>   	}
>   
>   	if (func < OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR ||


