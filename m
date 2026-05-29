Return-Path: <linuxppc-dev+bounces-21724-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCAADCD6E50
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 14:43:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmM01Yl2z2ySg;
	Sat, 30 May 2026 00:43:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780065820;
	cv=none; b=ZBGgqdbpKkmN4hlUp32WhigPWEkqQt69bSiL7nGx/ElZ9Ok6DHj7g+WL/R1X+0IsLLtpLfsr0pmKM2Im12LMpEIQ10wOtGsvlFIGEPgHQgXbTdAuk6z6Qt04/EqpPTuRp3tjwR+b+nMo7JeksG364mzEhcvFoYvcq5+GQZNk5isgmZuRkXQjkIUCNm4XNtoiKH0snuGiTOrkXhGQcy+wHnS+yhPC0D7pahu3k9Zdb15kf4SI39e+In1XDKdIY1Gfz6dL33z0Cqu+da8kpXrsH7ourr+w3dTvCAQ/YoJiRbvIPXGRKN3dTw+kV/53/C+LwMc83v/ATpQCozhyIDmEOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780065820; c=relaxed/relaxed;
	bh=Elw36BouPUMp0mEeSrBwT8wHQMoNjB+NX8AH+lO18hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrhlN+9cADk89JZmOD+fkOSQmve2LLcJXPvlyGBrfq8iS/cFA5iUfx5bLGlzC111uzj6FeGd/8rMZLWHZ8A3u8sdMWbinwdTi3Kecr2XpbKlOiUDQPYXXWWmGvJno6o9flY1KLExWddxfUTM9crYv4sH696/0LTyaHTtoT+UoFaGoYi6fU+CePeli8YlaXkErbCUPX27/ezurgl8wELEPYLrSFylCmk2ME+b4dyzMEvQ8D/O3CqMADLBkFAuICdl09dqEm8mdOlYz0K6Rlr+TXl4feXMLXIN/MminkU9p8S7rZKz+TyRdxazki0SiJcQ42ZLh9IDbfqlpqg+uRojlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=N9E9N33X; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=N9E9N33X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmLx5tqNz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 00:43:35 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A05B202C;
	Fri, 29 May 2026 07:42:58 -0700 (PDT)
Received: from [10.43.20.82] (e126510-lin.lund.arm.com [10.43.20.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5DC23F905;
	Fri, 29 May 2026 07:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780065783; bh=Jl9VQKojRAgBG12zDuJGeC336Uk4pqmCiAHAf+KoXfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N9E9N33X8n15HQwC5psjF+tcjK3WjyYarbBnqu3nIcNYoMawZ7mbV1yjWd13q7IJv
	 QTsroWS/j20zBbVb7rfEQI+Aiu3SBMqEK641u2iZkJkWxvlTEL5KjcIxaj6t8ojsHY
	 iT1KU9ZTFJfOcdoib6fau3D3/hY79iVtzbs6xxPI=
Message-ID: <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
Date: Fri, 29 May 2026 16:42:55 +0200
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
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end
 of kernel image
To: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-26-ardb+git@google.com>
 <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
 <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2026 13:19, Ard Biesheuvel wrote:
> On Fri, 29 May 2026, at 10:27, Kevin Brodsky wrote:
>> On 26/05/2026 19:58, Ard Biesheuvel wrote:
>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>
>>> Move the fixmap and kasan page tables out of the BSS section, and place
>>> them at the end of the image, right before the init_pg_dir section where
>>> some of the other statically allocated page tables live.
>>>
>>> These page tables are currently the only data objects in vmlinux that
>>> are meant to be accessed via the kernel image's linear alias, and so
>>> placing them together allows the remainder of the data/bss section to be
>>> remapped read-only or unmapped entirely.
>>>
>>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>>  arch/arm64/include/asm/mmu.h    | 2 ++
>>>  arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
>>>  arch/arm64/mm/fixmap.c          | 6 +++---
>>>  arch/arm64/mm/kasan_init.c      | 2 +-
>>>  4 files changed, 13 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>>> index 5e1211c540ab..fb95754f2876 100644
>>> --- a/arch/arm64/include/asm/mmu.h
>>> +++ b/arch/arm64/include/asm/mmu.h
>>> @@ -13,6 +13,8 @@
>>>  
>>>  #ifndef __ASSEMBLER__
>>>  
>>> +#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
>>> +
>>>  #include <linux/refcount.h>
>>>  #include <asm/cpufeature.h>
>>>  
>>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>>> index e1ac876200a3..2b0ebfb30c63 100644
>>> --- a/arch/arm64/kernel/vmlinux.lds.S
>>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>>> @@ -349,9 +349,15 @@ SECTIONS
>>>  	_edata = .;
>>>  
>>>  	/* start of zero-init region */
>>> -	BSS_SECTION(SBSS_ALIGN, 0, 0)
>>> +	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
>>>  	__pi___bss_start = __bss_start;
>>>  
>>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
>>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>> Do we actually need the NOLOAD type here?
> Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS to be
> emitted into Image.

That's rather strange, aren't the .pgdir.bss input sections already
NOBITS since __pgtbl_bss is only used on default-initialised globals?
Also AFAIU NOLOAD does not prevent the output section from being emitted
into the ELF file.

- Kevin

