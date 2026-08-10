Return-Path: <linuxppc-dev+bounces-25672-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA40C5AE49
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Aug 2026 13:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJZyB16blz2ysb;
	Mon, 10 Aug 2026 23:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786367762;
	cv=none; b=Voy1egaJ835qpu/1AFHny5/lUoHWQcozye/nvg8DKXg6zzLDiGmR0AY6O/m+fqdkMf3IVGNKddziukRTAJoD+fLxLVnEeCJ6wUHUnXoeZASG6etRDwZmPPnrXWShQHVeWUfOWRlZgy+uXl0EEMWyFlw9On8ErDlsWXox09emrtx9XwMs4amUFD7yCXeyEtp/JeSIzFqj93hwMVOIDvivOMtBR3xVTN879ZOSenGErpKRcpiWWMShZci2fNu188xQv6eA6q+i/SVVs155cRAKocuqXxEZeFpNQwUS595lUCB9MMdNjqxsWJn5zIv624CFRZ6L/dkNDy/JbOQYq1p9zw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786367762; c=relaxed/relaxed;
	bh=X4USx5lpd5xGkWozOwTXqXRz443jHgZxzpuvUiugvFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjz/gnS/+hbu/fzMIRYr4UR5tZsOHk4SpRuIhFX54olyg1ZmsWP5h4dRpPp5N5nJQquce7jSC0aWbfC2e//3UEqKRZtqfpiELT5Xr6vVd9VE5OVApQJ277UEIV3tvb/ERTnWshfbyltSlro39A3nborsJe29FnOaZQ3ov9IwgZttBEJ985JDfXUQOFZNcc9ldfNfr8bMoCOLUR89gzDYbwkkmPEi5ykh6XAf0HwacSN2HOZ6sDzvA5r6QGLrdxmvX6Z34/8PLslmgi8yvg/WDLI+f8rWeJ7yQaX272l3vd/AAGNb3Fmcc71WIFH5juKQ3V1TXydJe10RvacleULRHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UIG0VKRV; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=UIG0VKRV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=robin.murphy@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJZy71Cm9z2xRs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2026 23:15:57 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6411477;
	Mon, 10 Aug 2026 06:15:20 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7D193F632;
	Mon, 10 Aug 2026 06:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786367724; bh=08CNSczzlMqJLfhVP4oR0gP5UnNIku1FbqhnKdMgNJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UIG0VKRVpcnQsntb8X+MUw+Rl1RmKSYUuGIobrr6tKs0/KwrfxLsM0TWwGDOfumFm
	 6LNootm9c7LoakxRkMKnwDln+V6lL05lHro61O8CO3txcH2RBRl/GFDkKz44saVCkc
	 dgt/4K30gMdQMt+9zq0K3hFK4pldKbqC/7ig2Aqk=
Message-ID: <850675b8-1858-4314-85cf-b174daf8693e@arm.com>
Date: Mon, 10 Aug 2026 14:15:18 +0100
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
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
To: Michael Kelley <mhklinux@outlook.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Marc Zyngier <maz@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jiri Pirko <jiri@resnulli.us>,
 Petr Tesarik <ptesarik@suse.com>, Alexey Kardashevskiy <aik@amd.com>,
 Dan Williams <dan.j.williams@intel.com>, Xu Yilun
 <yilun.xu@linux.intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "x86@kernel.org" <x86@kernel.org>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck> <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck> <20260807135810.GA200537@ziepe.ca>
 <yq5awlu1yfn0.fsf@kernel.org>
 <SN6PR02MB4157484EFDE3315744021D5BD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <SN6PR02MB4157484EFDE3315744021D5BD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 6:00 am, Michael Kelley wrote:
> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org> Sent: Friday, August 7, 2026 11:01 AM
>>
>> Jason Gunthorpe <jgg@ziepe.ca> writes:
>>
>>> On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
>>>
>>>>> I was under the impression that there is a possibility of using swiotlb
>>>>> instead of restricted-dma-pool with pKVM.
>>>>
>>>> Yes, that patch enables swiotlb as a possibility for protected guests
>>>> but with your patch we avoid shrinking the swiotlb buffer even when
>>>> restricted dma pools are being used and that's a waste of memory.
>>>
>>> I also thought we switched pkvm to use CC-like swiotlb as part of the
>>> alignment in this rework? Mostafa ?
>>>
>>>>> If that is not the case, then we could change:
>>>>>
>>>>> !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
>>>>>
>>>>> to
>>>>>
>>>>> !is_realm_world() &&
>>>>
>>>> Perhaps, or you could just pass the swiotlb= option if the defaults don't
>>>> work for you. Can you give more details about the slots exhaustion you're
>>>> seeing under CCA?
>>>
>>> We see badness with swiotlb too, it basically doesn't work out of the
>>> box if you have to use it 100% for real devices. It easily runs out
>>> of memory.
>>>
>>> Auto tuning to higher levels makes sense to me, but I'd rather the
>>> core code handled adjusting its size to the estimated need, not arch
>>> code.
>>
>> Agreed
> 
> Nobody has mentioned it on this thread, but arch code under x86 has
> a heuristic for sizing the swiotlb for SEV-SNP and TDX. The heuristic is 6%
> of guest memory, with a max of 1 GiB. See mem_encrypt_setup_arch().
> The heuristic originally went into the 5.11 kernel nearly 6 years ago for
> the original SEV support and hasn't changed since. See commit
> e998879d4fb79, which doesn't give much of an explanation. I don't
> think this is necessarily a good heuristic -- it tends to waste a lot of
> memory, but there are also a few cases where it isn't enough memory.
> After a few years of experience with SEV and TDX, nobody seems to
> have tried to come up with something better, so maybe it's not all that
> bad.
> 
> No doubt the heuristic should move into common code so CCA, SEV,
> and TDX all use the same one.

Indeed that would probably make sense as a future refactoring, as I 
would assume the general expectations of CoCo environments should be 
largely independent from the specific technology of either "Co" :)

However, note that currently the arch checks are effectively serving 
opposite purposes - x86 is specifically *increasing* the default SWIOTLB 
size for SEV/TDX, while the arm64 check (and RISC-V copy), is about 
*reducing* the default size if we think we (mostly) don't need it.

Thanks,
Robin.

