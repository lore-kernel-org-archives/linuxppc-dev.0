Return-Path: <linuxppc-dev+bounces-27893-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD36C982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 06:57:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hprW968Qtz2ygK;
	Tue, 22 Sep 2026 16:57:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790060229;
	cv=none; b=hZPEDHCHZ5uXvMHIm4ThoVJUcsohle3seTEfKXWskZdSxmaaDecM9T2LIjAlBveGc6YmM57G0/ciRPpBU4c0PrsTZrKvYUR1JfoojSKhhKAMoapbOz/DWW2gHrERVr5P8qHLw367sc85ah2gs14ivQbst72431lUCToazcIf+dfPUi1KObyoRG2O0PpV4l9ReZXkRtJpqaxgGUSJ0HMK/7ylPZ4//Bml8UybFJiWppuvvPKtpeoMpFtwnyblgDRvJiGf1BmOoQyj5IYrDFRJyte/a9BB7oB5N5jcri2G9lBJm3Qm9hD5AoIDWjVMav6gXB+XogkeUupkPj/0Qr/12A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790060229; c=relaxed/relaxed;
	bh=VVgL/uzz137uMRzSkpFduyYcDsPNmDrSlT5+2SBHXpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JzIzTAXDB2voUDHMf449bjFGRobzKzYquWYSpe9KOosi76lePJehlYb4IO/xHq01D+LkTrPaXpnYRNAP91cXBi84aOFnNZvFtY4nY44cws0AP+Sk8CX+Xwkq34ba6+An0iuO8Ty4XonvP8G2j0iaPfatoyyUZCODMUynZFt1enfedtjMsc83WMkNl0GWqO4nnapXySGiYDjmPh1WE8eYebmR9S+KQeCVzspLuFMc/w7T1QHr7E3Pp3cv9Z/YtQQQg2rRMAQBKKXgAz5KLrLf2+voqaFnHjEvgRk5/4qHappQHBnO39Ki57sSt2z81F3PEnMF+TBJ55x71nZjhnahtA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNB44/zw; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BNB44/zw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=aneesh.kumar@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hprW847Bvz2yfy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 16:57:08 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 275BE6053E;
	Tue, 22 Sep 2026 06:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602FD1F000FF;
	Tue, 22 Sep 2026 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790060224;
	bh=VVgL/uzz137uMRzSkpFduyYcDsPNmDrSlT5+2SBHXpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=BNB44/zwKoNMc0NnM2KjlJD0Vr/OZo7eRyriJNlJby7xV70V9sHGh4ZUo3N6FgJ5t
	 AjPqJib9IFHuoqfPh8SyGVJoAHqxb/F0KmSrGipZ3+Sm+r/lDNT/XUTs7nFCcT2DhH
	 g5WR1jq4muLh7CxgYUjUANWn3iQ3FgYkWa6NZWbaJ6BOFWumg9ZQKJ956iEpeA81PA
	 hzTJ4cfSvz4m1vsEf2dZ4qKH6nXJpbMvl69nqyp+3sqrQFniFXCfQhmD8wTBwEdZc/
	 /Yq6Bnpzrc3VVAujAQyozn9bvn0jHEZpnABRRKd4QSAfltWAjXL8kiHAK+SmBrRSWB
	 c5nlXGg/IquUw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v5 3/6] dma: swiotlb: Centralize minimal pool sizing
In-Reply-To: <21180ec6-b9ad-43fd-9e52-51df644e1b93@arm.com>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-4-aneesh.kumar@kernel.org>
 <21180ec6-b9ad-43fd-9e52-51df644e1b93@arm.com>
Date: Tue, 22 Sep 2026 12:26:47 +0530
Message-ID: <yq5apky53hao.fsf@kernel.org>
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
Content-Type: text/plain

Robin Murphy <robin.murphy@arm.com> writes:

> On 21/09/2026 7:36 am, Aneesh Kumar K.V (Arm) wrote:
>> A default SWIOTLB pool used only for unaligned kmalloc bouncing can be

 [ ... 54 lines skipped ... ] 

>>   
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 8f86deb25be2..f368a73f4ed0 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -483,9 +483,18 @@ static bool __init swiotlb_kmalloc_needs_bounce(void)
>>   static void __init
>>   swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
>>   {
>> +	if (swiotlb_default_size_changed())
>> +		return;
>> +
>
> This appears to be entirely redundant, as ultimately the point of this 
> function is to call swiotlb_adjust_size() (if it does anything at all), 
> and the first thing that does is this same exact check. We hardly need 
> to micro-optimise short-circuiting a handful of arithmetic in a one-off 
> setup path, and it's convoluted enough as it is, so please try to avoid 
> redundancy that makes it even more confusing to follow.
>

OK, I'll drop this.

>
>>   	switch (policy) {
>> -	case SWIOTLB_POOL_MINIMAL:
>> +	case SWIOTLB_POOL_MINIMAL: {
>> +		unsigned long size;
>> +
>> +		/* Use 1MB per 1GB of RAM for kmalloc() bouncing. */
>> +		size = DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
>> +		swiotlb_adjust_size(min(swiotlb_size_or_default(), size));
>>   		break;
>
> Similarly I think it would be clearer if we had a common 
> swiotlb_adjust_size() call at the end of the function, and then either 
> calculate a size or return early in each switch case as appropriate.
>
> Furthermore, swiotlb_size_or_default() is awful IMO - and in fact after 
> this series we could perhaps clean it up entirely by making the size 
> implicit in swiotlb_init_late() - not to mention misleadingly redundant. 
> I'd say just open-code "default_nslabs << IO_TLB_SHIFT" like elsewhere 
> in the file, but in fact it may as well just be IO_TLB_DEFAULT_SIZE 
> (think about it...)
>

How about we rename swiotlb_size_or_default to

unsigned long swiotlb_default_pool_size(void)
{
	return default_nslabs << IO_TLB_SHIFT;
}

We still need a helper because arch/arm/xen/mm.c also uses it. I also
updated swiotlb_adjust_pool_size() as suggested.

static void __init
swiotlb_adjust_pool_size(enum swiotlb_pool_policy policy)
{
	unsigned long size;

	switch (policy) {
	case SWIOTLB_POOL_MINIMAL:
		/* Use 1MB per 1GB of RAM for kmalloc() bouncing. */
		size = DIV_ROUND_UP(memblock_phys_mem_size(), 1024);
		size = min(swiotlb_size_or_default(), size);
		break;
	case SWIOTLB_POOL_CC_GUEST:
		size = swiotlb_adjusted_size();
		break;
	case SWIOTLB_POOL_NONE:
		WARN(true, "Cannot adjust SWIOTLB size without a pool\n");
		return;
	case SWIOTLB_POOL_DEFAULT:
	default:
		return;
	}

	swiotlb_adjust_size(size);
}


-aneesh

