Return-Path: <linuxppc-dev+bounces-22158-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077A2CD8C88
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Jun 2026 13:47:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYGgT2FPWz2xlV;
	Sun, 07 Jun 2026 23:47:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780840021;
	cv=none; b=VGFge3kOjT/QwWoN3Qfqn8fkeoLZ1LdXu/KJ7rbtwF1Y9rV/XK9sxFiLXHiXVSz4X9Go6b5AOc1dMu2p6kS16KvIaFVRdyXu2cXo3VnVXwmkeuvyDLBOC8Oz6BuoZlSaoXfIKPdHlmEInwBGUD0M+lV7YthOT/LnfdeB+dwovnT3wf6mi0zu36FlU1u0HyX8hRvcqB01ZDPONTIQC9iguC4wbKjcFGkZzrYvTCBNV1ul5Ok9Ne9zBj5d1WUq7atDbdOS5n9HmvNpjttPnArBbvZNf6Dd+EWs3Ce9kGnJWqlB5Ttbpa1k8xXadeckJ2eZn5757XPmEFJ1Mf0XVguYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780840021; c=relaxed/relaxed;
	bh=OLg+b4qM1sGc3N2vtA/7AvKX2jAg/14y5mNZXDK4KvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDbGHU4qD3B8f5n7GwYAbokdi582gksR6U2E12alvgLbaJCCKotqjw88fPknQUcJxWRYeL8sfMc4Iyikr1zLOJAaMrOBMQYso5l9d8vhx6Ld1Hq0LJLXzi7LsecVxAbRFiZlStKbo1/xHxY3Ppc9VBmbo+SFauvcGC9wym5CLuMEDTJKdqGiN/ifJloHboqmgyc9LKvr83jVUidLLbRAV/uivnoLBqVFyjSIEwdkNNxon5aZusqQ3GW/856AL+8Yhsg0EpOZNY/NGwTaJwa52WPAmxvTYE7zFlaVFE/SnO7DW7i6b58kVH9xhn1e60XesTZIPZ5dILEfhgFqyRDxNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DVY6eeqM; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DVY6eeqM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYGgS1xK7z2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jun 2026 23:46:59 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657Bpf1L1785952;
	Sun, 7 Jun 2026 13:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OLg+b4
	qM1sGc3N2vtA/7AvKX2jAg/14y5mNZXDK4KvY=; b=DVY6eeqMd052hOULNjraUQ
	w501FLosqfSUhd71f7Hl4kjmdv+TOPVkffP+e7pMsSmkq+qUp3wZosrNyTvnQsbC
	j3jKZ00ctBIUvnf4AfvGPQ3AzZXnZJXu+HS1DOL0Kvfy86tf0AiOEQ4Ua5gr9nG7
	z6Fwv5vgemZ7SEvKk50P2UibngDAre6th4cRRI86DWLAeN64ZoJeIEaMBmp65b7f
	pw/lD9Jo8wB3XoSVl/TduUxNoZe2rDQl7KO1B5gEKFM2bQX+W1nfvXIJ+bIoAY9D
	8HdIpFZ1hqVrR8oTISsNVajnC+FxcQ1v4loVE1zqBCxGRrjvF6nIhlphqG9jc2/g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb953tte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 13:46:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657DYbn6025571;
	Sun, 7 Jun 2026 13:46:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgsjc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jun 2026 13:46:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657DkhvQ51446218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 13:46:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8BF820040;
	Sun,  7 Jun 2026 13:46:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9106520043;
	Sun,  7 Jun 2026 13:46:38 +0000 (GMT)
Received: from [9.39.26.1] (unknown [9.39.26.1])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 13:46:38 +0000 (GMT)
Message-ID: <6e1ec392-ad56-4625-9b44-2def6065bbc1@linux.ibm.com>
Date: Sun, 7 Jun 2026 19:16:37 +0530
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
Subject: Re: [PATCH v2 5/5] powerpc/powernv: Map EEH error types to OPAL error
 injection types
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, haren@linux.ibm.com, thuth@redhat.com
References: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
 <20260527072433.94510-6-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20260527072433.94510-6-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a257649 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=EPVWBmRQiJyani0nr4UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: F0qKY5h9FcnMDBbbEfmxaXTznR_Y_jnV
X-Proofpoint-GUID: uDqlPqAIoAJ2DyVXD1iSW8OG1fHUgwlk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEzNSBTYWx0ZWRfX2XNee3Ecr3AM
 0mBbj8y0lrcmrZuEeeGzAlXpL/+8og38/cQN6a530j0cqUIvOSm/9o4rTYPBqnxZ8vccHiGHx04
 7lC8HHNKD/w2l5ryhgXmiF0jhubWDbbmnhSO9MHYOQr6m8aIu8Lf2i/G0MdiBtXKCA84u97L0Zx
 pDKuZjaceGcsW8MWcvRo7aKderRtUI94Sgxw8PCIqx7nN2NTKMGD/9Lvq7tQ+RMc1x1m4ZTDhNl
 gAMWOOUCrHFoKN9rS3e5DP/tbrcwIFkJxVF+eGBaC4yRdbdHk8E9wL3eLaaJVNoofuoyqi2eLXz
 EgsLv8O9+xsKPPAl+eVigOcMwt/9iRNsCl4bOhaa5ZqVb+zEJS+j9AUya1TJaSvWRPS7ghWe2Br
 rwJ+jXE1MJXE9D4Eo57ufxU/PHlD79r+YPlOXgPFqViC5dBvnpAmaKQ9eOpwZ9r/u+m7kY3SBXb
 y8gDKlMsz3BvQ6BzVow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070135

With the cover letter, this patch series seems to be about RTAS/pseries.

I am not able to understand why powernv changes are part of this
patch series. Could you please explain why they are included here?


On 27/05/26 12:54, Narayana Murty N wrote:
> Add a mapping layer in pnv_eeh_err_inject() to translate generic EEH
> error types to OPAL-specific error injection types. This decouples the
> VFIO error injection interface from OPAL implementation details.
>
> Map EEH_ERR_TYPE_32 to OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR and
> EEH_ERR_TYPE_64 to OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64. Return -EINVAL
> for unsupported error types.
>
> This provides better abstraction between the generic EEH layer and
> platform-specific implementation.
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
>   arch/powerpc/include/uapi/asm/eeh.h          | 20 ++++++++++++++++++--
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 11 +++++++++--
>   2 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/uapi/asm/eeh.h b/arch/powerpc/include/uapi/asm/eeh.h
> index 86645cab2827..d88d82796905 100644
> --- a/arch/powerpc/include/uapi/asm/eeh.h
> +++ b/arch/powerpc/include/uapi/asm/eeh.h
> @@ -16,8 +16,24 @@
>   #define EEH_PE_STATE_UNAVAIL		5	/* Unavailable		*/
>   
>   /* EEH error types and functions */
> -#define EEH_ERR_TYPE_32			0       /* 32-bits error	*/
> -#define EEH_ERR_TYPE_64			1       /* 64-bits error	*/
> +#define EEH_ERR_TYPE_FATAL                  0x1   /* Fatal error */
> +#define EEH_ERR_TYPE_RECOVERED_RANDOM       0x2   /* Recovered random event */
> +#define EEH_ERR_TYPE_RECOVERED_SPECIAL      0x3   /* Recovered special event */
> +#define EEH_ERR_TYPE_CORRUPTED_PAGE         0x4   /* Corrupted page */
> +#define EEH_ERR_TYPE_CORRUPTED_SLB          0x5   /* Corrupted SLB */
> +#define EEH_ERR_TYPE_TRANSLATOR_FAILURE     0x6   /* Translator failure */
> +#define EEH_ERR_TYPE_32                     0x7   /* 32-bit IOA bus error */
> +#define EEH_ERR_TYPE_PLATFORM_SPECIFIC      0x8   /* Platform specific */
> +#define EEH_ERR_TYPE_CORRUPTED_DCACHE_START 0x9   /* Corrupted D-cache start */
> +#define EEH_ERR_TYPE_CORRUPTED_DCACHE_END   0xA   /* Corrupted D-cache end */
> +#define EEH_ERR_TYPE_CORRUPTED_ICACHE_START 0xB   /* Corrupted I-cache start */
> +#define EEH_ERR_TYPE_CORRUPTED_ICACHE_END   0xC   /* Corrupted I-cache end */
> +#define EEH_ERR_TYPE_CORRUPTED_TLB_START    0xD   /* Corrupted TLB start */
> +#define EEH_ERR_TYPE_CORRUPTED_TLB_END      0xE   /* Corrupted TLB end */
> +#define EEH_ERR_TYPE_64                     0xF   /* 64-bit IOA bus error */
> +#define EEH_ERR_TYPE_UPSTREAM_IO_ERROR      0x10  /* Upstream IO error */
> +
> +/* EEH supported function types */
>   #define EEH_ERR_FUNC_MIN		0
>   #define EEH_ERR_FUNC_LD_MEM_ADDR	0	/* Memory load	*/
>   #define EEH_ERR_FUNC_LD_MEM_DATA	1
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index db3370d1673c..ee156d397e93 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1169,8 +1169,15 @@ static int pnv_eeh_err_inject(struct eeh_pe *pe, int type, int func,
>   	struct pnv_phb *phb = hose->private_data;
>   	s64 rc;
>   
> -	if (type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR &&
> -	    type != OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64) {
> +	/* Map generic EEH Type to OPAL Type */
> +	switch (type) {
> +	case EEH_ERR_TYPE_32:
> +		type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR;
> +		break;
> +	case EEH_ERR_TYPE_64:
> +		type = OPAL_ERR_INJECT_TYPE_IOA_BUS_ERR64;
> +		break;
> +	default:
>   		pr_warn("%s: Invalid error type %d\n",
>   			__func__, type);
>   		return -ERANGE;


