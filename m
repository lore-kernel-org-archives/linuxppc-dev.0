Return-Path: <linuxppc-dev+bounces-27860-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E901C982ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:46:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpSJP0Qd2z2yfH;
	Tue, 22 Sep 2026 01:46:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790005588;
	cv=none; b=nL0l6AF+w43wwBImW+B+xH9Kpzks8cnuSkPtMUJbmLH+DZPGinYx6nCs1MDMvWfA3rv+e93BSoGIVhgM1pi6hixYNCIWhd3xp8f9pj2FGwlhqbKsH2z1sWxtr261RTL8kI5Pqdk49HvsqhT1z68zaP1kb/cZvESTIiHF8Pj6bYu3iwXhHaJ5IHKVD0z2kjXfRFNff9qFb9jOjzT6E41E5hrdUJFyoeI+9Z0oKJFnGMCWuvkMOlsn22+TSHOfNz1fu8m77G/T7QpVzFqxdK59vBhzWgtpgBZcy0w0BzBEidBDUhK3mzFo4uxjz141shwuySLucbL9XLYqpxC7oPAXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790005588; c=relaxed/relaxed;
	bh=dSPBjOWn5CsFPyDGmxFlZSgrzmDQuJdpSbhAoe0g5MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXEeKP9QzxkgA0YThl4m+M/t/CDeCupPp2XEsL/ldyJgNoKRF7IesD4GbV2zyBjpM7BAjGOCaN34AQ6mYYOVZT7eWnpDjYCtq2SrkuzZr7aOCAKmrDc/UW/QltA947SkWH/T8+ReFWgPwKL/TfB68Md5QsW6orSVuU3kNOyZg3hBeh9bXKwc1M/bAOmwqxVkikfNASQOrw6UWaLEDEKTmu6HIR6iyUbXQZZePhWPDwWUVoAd80VAt89F8Oj+mA3e5nRlKJWm4m9Kn+Pem1uhDJmrzdgfcdWEirZ89KGY2l9a38FfxzBelYK9p3NxQXQ1r5chTh/9Qy0BwB+ORfQkkA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EoC0cuIQ; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=EoC0cuIQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpSJM5Yqrz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 01:46:27 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CE1C176C;
	Mon, 21 Sep 2026 08:45:52 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5CD83F632;
	Mon, 21 Sep 2026 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790005555; bh=cIKZrmFNDgxQa0qqmau+ZqQxkkl6FQkDRcq1dC9miXU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EoC0cuIQz6hLQwqx0QF1eocGbFHcONiXNcdsw4wKNlOhOiOhVhiSZSeViIz1bFPb7
	 muOHOKkL6n9D40Sc0M8nsRMGJOPM/9pqWCmEHDGay46C0wCozVnJkI6euIIJu4A7eT
	 wCKvl5TAYjrxpCiY2Dw1a5LcGTlG38H10QNCNR8Y=
Message-ID: <94630348-d295-4424-9f6c-0dc3b8704077@arm.com>
Date: Mon, 21 Sep 2026 16:45:36 +0100
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
Subject: Re: [PATCH v5 2/6] dma: swiotlb: Track whether the pool size was
 explicitly set
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon
 <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-3-aneesh.kumar@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260921063628.362078-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
> swiotlb_adjust_size() must not override a pool size supplied through the
> swiotlb= command-line parameter.
> 
> Currently, it determines whether a size was supplied by comparing
> default_nslabs with IO_TLB_DEFAULT_SIZE. This fails when the user
> explicitly requests the compiled-in default size, allowing the request
> to be overwritten by automatic pool sizing.
> 
> Record whether swiotlb= supplied a numeric size and add
> swiotlb_default_size_changed() to query that state.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   kernel/dma/swiotlb.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index aa19e81ae544..8f86deb25be2 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -107,6 +107,7 @@ static struct io_tlb_mem io_tlb_default_mem;
>   
>   static unsigned long default_nslabs = IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT;
>   static unsigned long default_nareas;
> +static bool swiotlb_size_set __initdata;

Nit: there are various ways and reasons that the size is set in general; 
could this please be named something clearer, e.g. 
"swiotlb_cmdline_size_set"?

>   /**
>    * struct io_tlb_area - IO TLB memory area descriptor
> @@ -269,6 +270,7 @@ setup_io_tlb_npages(char *str)
>   		/* avoid tail segment of size < IO_TLB_SEGSIZE */
>   		default_nslabs =
>   			ALIGN(simple_strtoul(str, &str, 0), IO_TLB_SEGSIZE);
> +		swiotlb_size_set = true;
>   	}
>   	if (*str == ',')
>   		++str;
> @@ -304,6 +306,11 @@ unsigned long swiotlb_size_or_default(void)
>   	return default_nslabs << IO_TLB_SHIFT;
>   }
>   
> +static bool __init swiotlb_default_size_changed(void)

...and then do we really need a trivial wrapper function with the exact 
same scope as the variable itself? (Plus the name is similarly confusing 
as the places this is used are themselves potentially changing the 
default size, if you consider "default" to mean "not explicitly 
specified"...)

With the naming improved,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> +{
> +	return swiotlb_size_set;
> +}
> +
>   void __init swiotlb_adjust_size(unsigned long size)
>   {
>   	/*
> @@ -311,7 +318,7 @@ void __init swiotlb_adjust_size(unsigned long size)
>   	 * architectures such as those supporting memory encryption to
>   	 * adjust/expand SWIOTLB size for their use.
>   	 */
> -	if (default_nslabs != IO_TLB_DEFAULT_SIZE >> IO_TLB_SHIFT)
> +	if (swiotlb_default_size_changed())
>   		return;
>   
>   	default_nslabs = swiotlb_aligned_nslabs(size);


