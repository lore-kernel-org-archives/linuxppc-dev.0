Return-Path: <linuxppc-dev+bounces-23716-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5960BC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 15:42:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvlpn5pMyz2xKh;
	Wed, 08 Jul 2026 01:42:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783438945;
	cv=none; b=QatUnnovYIHOT8yxVsGu6xRei1+1q2UL4yMe423d4E82Xa66o4cSyoHkD+FOi/di2Jk5px71qyJqfiFMLC1E36WMLoAbpzwqrzVg9B0ufZ8CmBtp0IV20c1+M97IPaMEiDTuz+yZ9USP2zXHu6lK1X/R32Oty6Z96wSXVfNE36+8q1CPa5nOBhNYBkfZQv+cKGSfMnkqFEnBSTYdr4rmtYo4ZJxPylS3x3KDloIFQ6DJUYXJxofZHT4N/x2EtnOQm5DCjBwe5s7cg32FYskvPK8RoPMUWXchudxRreJd7w3fBwNrXZGOP76NImqlxxejO3GrpHD0Xsew/ZLmByB3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783438945; c=relaxed/relaxed;
	bh=wOjWwGv2nw53G+APikUFfBY+ZYUqNzOtt9GdaYYwpvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P5vel+lpi6f7CcIMQrWyZ+AT2n4kG9aTy7OgepAj5X1liev6Zv3Ll4R2ZPtnqP3jqCW79kMzrK55nT8D3RPZSl+hfQ7gjmOyVRUfRXIRc/mWF60z5IqBB3FDimy/ZE3+cD4Wc+I9x4UB37FQaToCWJyiPuQXIKvX6eHn67X1kLtNbX7zc8YPvX8cu5mNDUa22rx6sKbrTQeTdJ7zlYSt1LO5vUUUMOENfL+NOB+lhr4GcXsk+E2wdAP0fK4D+06dlh0wDLEYQUsQB5BUslSpmCfvGvyCe2cuZ1GAP0XJTEu9gyeAwdhW4kh6537xMQXX/4fKRtYaBsfaCSLT6R6CYQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcCuSd4U; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=suzuki.poulose@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcCuSd4U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=suzuki.poulose@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvlpk5N9Tz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:42:20 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EB481AED;
	Tue,  7 Jul 2026 08:41:43 -0700 (PDT)
Received: from [10.57.38.146] (unknown [10.57.38.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F0913F905;
	Tue,  7 Jul 2026 08:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783438907; bh=xMFTUswuraT98QQrkLx1TpVKtw83hgxNIbc8hHyXcSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YcCuSd4USWQ9JvBOwgdQS/XGW7fN5UF5gHXcM0Ogcbv+GMTsGplKLOKCsaQ73/VF8
	 1xuAF2K12iBvJ56gFYBusyY7CPREK4DmWCZ4DbU0txiXaoauL4t7iPzZRJzuP3+6Uq
	 EAUVgOWIKMO2gsIMqcbYolSuec2zbVTSCMm62+CI=
Message-ID: <8d6b24ea-3a63-497e-9ce9-6a8e4d340665@arm.com>
Date: Tue, 7 Jul 2026 16:41:40 +0100
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
Subject: Re: [PATCH v7 08/22] coco: arm64: s390: powerpc: Mark secure guests
 with CC_ATTR_GUEST_MEM_ENCRYPT
Content-Language: en-GB
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-9-aneesh.kumar@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260701054926.825925-9-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/07/2026 06:49, Aneesh Kumar K.V (Arm) wrote:
> arm64 Realms, powerpc secure guests and s390 protected virtualization
> guests currently report CC_ATTR_MEM_ENCRYPT, but not
> CC_ATTR_GUEST_MEM_ENCRYPT.
> 
> These environments are all secure guest configurations. Their
> force_dma_unencrypted() implementations also treat the same secure guest
> state as requiring unencrypted DMA. Report CC_ATTR_GUEST_MEM_ENCRYPT for
> the same condition so generic confidential-computing code can distinguish
> guest memory encryption from host memory encryption instead of relying only
> on CC_ATTR_MEM_ENCRYPT.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>


For arm64 bits:



> ---
>   arch/arm64/kernel/rsi.c                      | 1 +
>   arch/powerpc/platforms/pseries/cc_platform.c | 1 +
>   arch/s390/mm/init.c                          | 1 +
>   3 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 92160f2e57ff..207e36db1e7a 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -27,6 +27,7 @@ bool cc_platform_has(enum cc_attr attr)
>   {
>   	switch (attr) {
>   	case CC_ATTR_MEM_ENCRYPT:
> +	case CC_ATTR_GUEST_MEM_ENCRYPT:
>   		return is_realm_world();
>   	default:
>   		return false;

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


Suzuki

