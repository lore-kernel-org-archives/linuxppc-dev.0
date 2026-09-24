Return-Path: <linuxppc-dev+bounces-28082-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9C7C982FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 04:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hr1Hk5jkSz30RN;
	Thu, 24 Sep 2026 14:36:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790224578;
	cv=none; b=fbVuPJNBi2RydLowH/K+HKnoK5MGEcM9sUa0VlecH6gPXAlgzznf41slxg1LbVYzNONcUHRct8tgpZD3HxCqKLS7QboSJu0H1ipvGN5DjXjuVCCFghVoqbXcj5v+EVY8cxgMbkrR1R8f6mGNbxZ7kV9b7m4kqykHZxH9Kd3lnTIIOyfwa7zObIi4m3qH8h3UTVPgv8GydIDkAuakQh6WPPCMaSaTUf0J3wAnU5NhuYYHY8fRAhdv04zdX5+lVHoCocaP3Ij9t+t38ELaoVqOi/8FcOR/wiuci3zNa6VY0u33w4tYAdlINnAZUBufZpKvdNh1tW+03kBJcTEaLcB8Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790224578; c=relaxed/relaxed;
	bh=Wkx09ArgQbBrGDdby2EpT8h4/sVyyelgvk2OmocbWU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh3UGdee3eBLJWfu3wxJ81qCJoV8wzZjtBxLz6EK2uyWBsMZYgEg2Oq5WXLzG0nY7GqTna6dEOMWi67hOzaijqMfDz1VnzPqNABMJLbyA8t+yCndy1lyoMpejaOiL1mAjf1/L+LfXANIFBeHehGlDVVHKKwuxUQmH/W2haKuvnRdNt7rjzUqxBnqw2eKSQlXuc3Mo2CfqtaJXr/DT96R0LMFvYMub1xMwMgd94+3KwffWHxm2trUqBWEJgdtyaLDBEbfdDCJ9nRg1EzlySFVWXqOe/h6wyv9TeB6K2IOS/j2ePAHipiKHxMX9TsDFnfMmp6hpQjDmmw/NZsR1HcEHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AyFjk+fo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AyFjk+fo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hr1Hj4MLPz2y1W
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 14:36:16 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2Zs023958520;
	Thu, 24 Sep 2026 04:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wkx09A
	rgQbBrGDdby2EpT8h4/sVyyelgvk2OmocbWU0=; b=AyFjk+fo9kGjCabQqtg+mq
	ZNEuB0W++JmMEyXsORIyA2FWma61DOwr759b0Xnx3sca8Ihy/+4/RPQ59nlWF+hu
	GLxTjdpZC2Y9GUjod6G4Xunc6qeNtgYOqMn4Xp8kew4BE2LDJqpDejLRbtoaTm+m
	nGRWX6kTDDSVZcAvyG6o+XyVkO4y+tBV0I2ll+0ef8njhEYxoRRPJB+2RDQ1g74I
	IgY7h0W9zGgJzCktzH8z+JMRrUVUn19whcuUaLdbX3spQNsOzYkmKfhx9SnAjLgE
	CUs0uXR/Kye8Gr9V6BDpO8IDh5pHdVFVHTYgNBRzdp/S3JgyMB3btoBQknqHJShg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqpagh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 04:35:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68O2ItGL1279566;
	Thu, 24 Sep 2026 04:35:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2v01n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 04:35:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68O4ZqhF29557120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 04:35:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 596372004B;
	Thu, 24 Sep 2026 04:35:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4601D20043;
	Thu, 24 Sep 2026 04:35:49 +0000 (GMT)
Received: from [9.43.57.223] (unknown [9.43.57.223])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 04:35:49 +0000 (GMT)
Message-ID: <280fcec1-4d39-4389-9094-74ca9e89a113@linux.ibm.com>
Date: Thu, 24 Sep 2026 10:05:48 +0530
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
Subject: Re: [PATCH v4 5/5] powerpc/powernv/eeh: Map VFIO EEH error injection
 to OPAL
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        oohall@gmail.com, npiggin@gmail.com, tpearson@raptorengineering.com,
        alex@shazbot.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, harshpb@linux.ibm.com
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
 <20260831065441.48654-6-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260831065441.48654-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab4a8ad cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=_oOO3TeDWnI9k3ZhZWQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfX1lgRZ7GW4nML
 qXRKO6AAdPoJW7HPDMAYCUKgDii4lVzpKltVejRYXr9lki/Kr5kg7h2pYnYkwUaMTuYH6mcrTgq
 GdI63G5EMoMGRwLDd+eObdKcNwE+JJ+hYZKfRL2YbkQelViZMklhZaf7XM0XhN0V6rvrQQrGNJa
 qJ70vzBOrZXNxlb+q9xjG1ncwdkq1JUsfozQOuInfocVKaxsGJ1cDUv9m4RY//CR9kjGBHzI62I
 p0S4LT/3ogg9+h5AV6bcShaYZWOMR4+UY+S0iY7+3ruceHFQlbOhV4BX49hjXFLAXF3+vAYustk
 vHwPFKwueS+Ab8jneyu2XvrZKRNSfU6A2Jjmok92YgztQ0m//QUhch1HJYxCSpPsxklvqNp3U6H
 KiDwtK/5QGlUA8NHaOGmLxPbvyGZVHmAF/3v5soFFnMmt7HIyWDJCJdZHCNhSVRkSlAH2on4Q1M
 6m487XItAxBA9FAhpbg==
X-Proofpoint-ORIG-GUID: KKSKXQlrZ9hLoEj-CW11UcPgpE8ceegS
X-Proofpoint-GUID: 6FQ-V5M2yOxCwgvFYQHBbImce_ba7ami
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAyMCBTYWx0ZWRfX/YiIlPNZS+Tu
 bslAgvkpBEX2LPS01akRgXSmmUy884LcW4PU27tEjAEP6fskOoQ3mBKV4MajXrL3bA+ecnMlj1h
 Op5L0rJLojs7BWor54K0RpWqXOok7aw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240020

Can you update the commit message to explain why and how this
change is needed?


On 31/08/26 12:24, Narayana Murty N wrote:
> VFIO EEH error injection exposes a generic userspace ABI.  pSeries maps
> the generic EEH error types to RTAS ibm,errinjct encodings, while
> PowerNV maps the same generic ABI values to OPAL-specific encodings.
>
> Keep EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 unchanged.  The mapping is
> internal to the platform backend.
>
> Add a switch in pnv_eeh_err_inject() that translates:
>    EEH_ERR_TYPE_32 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR
>    EEH_ERR_TYPE_64 -> OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64
>
> Return -EINVAL for unsupported error types rather than comparing
> directly against OPAL constants.  This decouples the VFIO/EEH
> interface from OPAL implementation details, paralleling the approach
> used on the pSeries RTAS path.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 27 +++++++++++++++-----
>   1 file changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index db3370d1673c..53c4c05aaef2 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1167,13 +1167,28 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   {
>   	struct pci_controller *hose = pe->phb;
>   	struct pnv_phb *phb = hose->private_data;
> +	int opal_type;

opal_type is confusing... How about opal_err_type or just err_type?

>   	s64 rc;
>   
> -	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
> -	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
> -		pr_warn("%s: Invalid error type %d\n",
> -			__func__, type);
> -		return -ERANGE;
> +	/*
> +	 * VFIO EEH error injection exposes a generic userspace ABI.
> +	 * pSeries maps the generic EEH error types to RTAS ibm,errinjct
> +	 * encodings, while PowerNV maps the same generic ABI values to
> +	 * OPAL-specific encodings.
> +	 *
> +	 * Keep EEH_ERR_TYPE_32 and EEH_ERR_TYPE_64 unchanged.  The
> +	 * mapping is internal to the platform backend.
> +	 */
> +	switch (type) {
> +	case EEH_ERR_TYPE_32:
> +		opal_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
> +		break;
> +	case EEH_ERR_TYPE_64:
> +		opal_type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
> +		break;
> +	default:
> +		pr_warn("%s: Invalid error type %d\n", __func__, type);
> +		return -EINVAL;
>   	}
>   
>   	if (func < OPAL_ERR_INJECT_FUNC_IOA_LD_MEM_ADDR ||
> @@ -1192,7 +1207,7 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   
>   	/* Do error injection */
>   	rc = opal_pci_err_inject(phb->opal_id, pe->addr,
> -				 type, func, addr, mask);
> +				 opal_type, func, addr, mask);
>   	if (rc != OPAL_SUCCESS) {
>   		pr_warn("%s: Failure %lld injecting error "
>   			"%d-%d to PHB#%x-PE#%x\n",


