Return-Path: <linuxppc-dev+bounces-22147-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991A1CD6E7B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Jun 2026 00:35:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gXK8Y6d6Wz2yMn;
	Sat, 06 Jun 2026 10:35:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780706125;
	cv=none; b=iZt7+YEpIzYYtXSgYnfOew05HU0rlfDdm/+M3DN0e1mPpcVL8Q2QKGkKkLjYwfY7tCVk1EK/yu1mbGmk/d4zvMmRR72tiVXz1m7J0BDHbbjXoIiq41kxlG7umv6+B4rValSQ6TPPjPFVYuTscwsSbKVeIEobIXNIzHgEmE72SppDt63WqTB7E2+23bd6R5cLDF+4bbC9QBjW1LvWMD+uf4oEvDFA/3uXOukYiiZ3KE6P3IoJf67+1Ya+0cIhR55O+GBbyJyQHBblW/weIhzAG5OES0bqji3ozkTyQQMCXRNeiwfiN+j4MIcHGRQFFn9puNe5bykoiv0aGC7xMGd8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780706125; c=relaxed/relaxed;
	bh=10R7bpEJTdOdzVayFD9Q6l+SCZSwLyUlb7ZztL7dxms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHK1+rhS9EImEJr0XSjIalDOuyOXy4H15kkO6O6lZ2QKSI3qBtKmEVSSZRJALo7HWpg6ZaO9r0/NnjJJY02PquJrJ4T2CC+VAdCAPCAG/tLIWDylFi/jwGPbVqcLrsZ2X5gsAY6LVE24yAM7BDdZKGLBmUb5XDIXmo9Y+Td+5jwlKmr2GKngnurQm9YG2HvK9xIYJlyYKL0BcJwG2/Bzz24KPywkiDs2EsBMzT5SpdAKc+RPn2g7l8LYME/puoOA39ai8s4IA6Ck+n1YmT9eQBjRVSV5p8erCDVBqb5MSOkdR5QEkht6nHtZ5LJGEk8+ZVbIA6OO2wKWdB00vyEOSg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RoUHrZSB; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jhkim@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RoUHrZSB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=jhkim@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gXK8Y08BNz2xMW
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2026 10:35:24 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655KPGLH3165334;
	Sat, 6 Jun 2026 00:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=10R7bp
	EJTdOdzVayFD9Q6l+SCZSwLyUlb7ZztL7dxms=; b=RoUHrZSBgzuGWiJYOobbkB
	/uQkABo/YV4/wSRYGiwn9Ynd3JL66r4IQeDQvzBMEgK3kIX0ZxDPjx2aNkSaTOVs
	gTquWUfkdJp4D41f8WqPwCGXecmnbTJYjOSAkisQRTD5eWdvIlADCk0h+ymg9sqe
	ytafL6jBkxQn3Y+qxgVP9e42FMaX1eCiCBRPx1sy0V7uItqD3CJWavhEiEclAYIN
	4+mS9hCXrkzBjH0VZP3xbY4y4HCfp9bXE2sYFBWify0bxsKhFP/TJoNtj1tuq+VE
	4ytyKsZpXDnSEN1FkNsq/pCg6+k3ih0UWLoz7Bz8L5CZGjM0/fACZpgM+qBmTn5w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaep0sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 00:34:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6560O6gk027834;
	Sat, 6 Jun 2026 00:34:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qv6fn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 06 Jun 2026 00:34:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6560YlZk30933536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 6 Jun 2026 00:34:47 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8FA95804B;
	Sat,  6 Jun 2026 00:34:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 147E058063;
	Sat,  6 Jun 2026 00:34:45 +0000 (GMT)
Received: from [9.61.255.106] (unknown [9.61.255.106])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  6 Jun 2026 00:34:44 +0000 (GMT)
Message-ID: <fbf37e22-8698-4688-9fe2-9e38658920cb@linux.ibm.com>
Date: Fri, 5 Jun 2026 19:34:43 -0500
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
Subject: Re: [PATCH v6 01/20] s390: Expose protected virtualization through
 cc_platform_has()
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mostafa Saleh <smostafa@google.com>, Petr Tesarik <ptesarik@suse.com>,
        Alexey Kardashevskiy <aik@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260604083959.1265923-1-aneesh.kumar@kernel.org>
 <20260604083959.1265923-2-aneesh.kumar@kernel.org>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <20260604083959.1265923-2-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a236b29 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=blRdvrxeXnuE--CKtYQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ggpQfBSPHMe1E8vMi3W1YAcBxeGqHkU7
X-Proofpoint-ORIG-GUID: R-cCnVSeKSEuXI4kZncs7oFO8xtbizvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDIzOCBTYWx0ZWRfX9CWxwkp73QOf
 ZCH4PcwFj7hkSywfl53gPqnUYZONt+fisFvoWdZOYTyT/hiKmJ9eU+cj3qU6bOdD1JUJjUTnFwa
 ucoZ3M+XIX/H7cgV5kPBdBK5BaKIZSeRJbxRpdepy5t8VxGknQ853KyhwMtTE/YQ2FN+AFuAGWL
 d9i4B/tfPrel1DUWKv+3FV71IZJI4IX6EyXoSz/8AnFWX1hASHDLUA/+OpTgKTnZkjMBBvWY4az
 ooWmu/2NwO95b7RZWbB5O/Pj1qgGuwwJZtlZkf6UxLW9lLcU9vvHHM201Mu0ZikAVCd0fMGCHHp
 9ns2dJJMnWbtvb2lhH1iR2pZGU73I+zgWWuTpgupFrYDkoYrbQCdgou2J4ENmDyinF5Jimv+1Yl
 JX76uXu3wzudOrj/Ql4gsBnWAA+lAuSIXm00ffyXp7fu1ZI0zbiwzHJS/MepnwU8HYqA7viDiba
 mDkSbz2OSX92hxN+c4w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050238

On 6/4/2026 3:39 AM, Aneesh Kumar K.V (Arm) wrote:
> Protected virtualization guests use memory encryption, so advertise that to
> the rest of the kernel through cc_platform_has(CC_ATTR_MEM_ENCRYPT).
>
> s390 already forces DMA mappings to be unencrypted for protected
> virtualization guests through force_dma_unencrypted(). Add
> ARCH_HAS_CC_PLATFORM and provide the matching cc_platform_has()
> implementation
>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

Tested-by: Jaehoon Kim <jhkim@linux.ibm.com>

Tested on s390 PV guest with swiotlb_dynamic configuration. SWIOTLB
bounce buffer allocation and dynamic pool management work correctly.
Also concurrent I/O stress completed successfully.

Thanks,
Jaehoon.

> ---
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Cc: Jaehoon  Kim <jhkim@linux.ibm.com>
> ---
>   arch/s390/Kconfig   |  1 +
>   arch/s390/mm/init.c | 14 ++++++++++++++
>   2 files changed, 15 insertions(+)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40..9b5e6029e043 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -87,6 +87,7 @@ config S390
>   	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
>   	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
>   	select ARCH_HAS_CC_CAN_LINK
> +	select ARCH_HAS_CC_PLATFORM
>   	select ARCH_HAS_CPU_FINALIZE_INIT
>   	select ARCH_HAS_CURRENT_STACK_POINTER
>   	select ARCH_HAS_DEBUG_VIRTUAL
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 1f72efc2a579..ad3c6d92b801 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -50,6 +50,7 @@
>   #include <linux/virtio_anchor.h>
>   #include <linux/virtio_config.h>
>   #include <linux/execmem.h>
> +#include <linux/cc_platform.h>
>   
>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(".bss..swapper_pg_dir");
>   pgd_t invalid_pg_dir[PTRS_PER_PGD] __section(".bss..invalid_pg_dir");
> @@ -140,6 +141,19 @@ bool force_dma_unencrypted(struct device *dev)
>   	return is_prot_virt_guest();
>   }
>   
> +
> +bool cc_platform_has(enum cc_attr attr)
> +{
> +	switch (attr) {
> +	case CC_ATTR_MEM_ENCRYPT:
> +		return is_prot_virt_guest();
> +
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(cc_platform_has);
> +
>   /* protected virtualization */
>   static void __init pv_init(void)
>   {



