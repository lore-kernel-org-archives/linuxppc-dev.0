Return-Path: <linuxppc-dev+bounces-21710-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E555FCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 11:19:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRgqw1nXxz2yQL;
	Fri, 29 May 2026 21:19:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780053596;
	cv=none; b=nlRUhmZ6lgDQqw/FT/t5cTu9/T/Tw/ANJsDlSA1YX7KrOzuSM5509e0oz3DQZl6/Z+FkfmXbv6oARjYMP+pNapZYaZ11UWEmCLpLYR3EMf9b0bpCj5EJQohOMTKzCKrR1DgkpCQg1UA+VEjqPDR29PhjOUUxLb8mAB7YbrP07efZW00EH68vKLtlz4NFUnUXRMJgwIHNMolAKxONa/sTG0akTpsPW0qw//1JLyNAwUpCcEGKWmKkbjZkMuWLOIF/qOzh2KF/LK9RUMq8KOwFa6s47ag4BPGraDpUF5mZUqVL1lcRyeOLFO58l+iuxxIBsR1V2vPhkOTlcyEArtYlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780053596; c=relaxed/relaxed;
	bh=xtH8EAmvqZSbaipGcXqbfvMaLUl7NiYH5Y5wqwunt3g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h84b4SuyAwLz/U7wPQL26jglLlcV8kfhz7wyV/P8BjnHRCYo1DlPCaJaT2PDwiM4VWb8cEHQve2JoKtx6bd8ozfNMuybhV3setS+sV8GCqWY3Lv6jiAZXlZWcuO/hGpP3sOTnnPmaepBr0CVkdRzYiV2n1fQfKIucIljObQLOVL8L4aOGOCb9GRgwuF4XfE4gJGio6X+HlUYZI3TshfYzQp1cZXcyqcBVTpSATC8xSXmn+yEU5VX4jEhK7b1IQ+V1HtfIAzAv896XJ8LCxYN6LDLhVx/R9CgwY4ZAdbayJXYvNUs2k32tqXWA2JnLIDIg6TfwYdpzMOg1XeMaKGQtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmEQNF8A; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmEQNF8A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRgqv15mcz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 21:19:55 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B20D06012A;
	Fri, 29 May 2026 11:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5841F00898;
	Fri, 29 May 2026 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053591;
	bh=xtH8EAmvqZSbaipGcXqbfvMaLUl7NiYH5Y5wqwunt3g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=VmEQNF8A0z8+1KzIlCnBSO2nUEjqvajOvCGEzAL61RGw93MGpbxmK5hJDcK4X+hgg
	 UZKxfoV+OrLA00JLpRYVuEnk2+zG0EcpjagS5/KmFt0OlhLC2p/e7meFVlfDWD7qGs
	 nXTLDmbcXuJ39EZkHnlth4IqaeCi/xiYBJKbRQwcygEsAdh9ylf/Ou+VU97yLvZ9Cs
	 KUHV7496Qj6cK1kjLuE0clbEqRyZChdum1FkQtJgv1XKb+hiJafgFN/nxu3gSZRMV6
	 cHZPnxD8vXnSD0ap3nn/GVB5hOYSMxIec2bGVi+edJ+wzEHCTm2BRGVHuY+7qP1zKL
	 Hwp9v0rR9TS9A==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id ED4F7F40074;
	Fri, 29 May 2026 07:19:49 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Fri, 29 May 2026 07:19:49 -0400
X-ME-Sender: <xms:VXYZakI5lWrnjge3izJfszwDrLDqJlPb7nZ0fT2HU7TYrL3TCplw0g>
    <xme:VXYZau-AYVOUF9zWLtiR3lm77FNmKJDLXiNWTgXWm9kM2PbUtk5JH_BTb9XckEQOf
    IM6xKd0uVlGv-Af0EaHgCLAEeZ07MDo1zAmw0HyV4We9otTLxNO-NQ>
X-ME-Proxy-Cause: dmFkZTFogum++9uuClw8cy4SxNf1uWqqkvv8W4zIXBwA82RSASLtxRMehGsMOXMDBhgeWs
    nqlmwZCFKVFfLIVlHXs/McboQpxGj3Pf/Ca9vw5Fnwc460UfhaDDOmaD3qvEx/I9yot16o
    HKbvIb5r5GxP5YIN93FaDmoekYS17nZB9LNN3lQjM9012YeqOgV9t7nikOyyFsfLmoVLay
    2YMvHAVZxPo//ZDllLTAZWgQ4dya84DY5uFQ7jgZWp0nWHWbC6LnXyanKW9V439JwchFGC
    I+7TQCdJ0Aia8Y6Nx/jquUp5kpwJr9SFRPG5NT61F+6w8immYHkB9rO2MG46U9M4rAtks7
    FeYlv48F9dDSBaNVIhgiLyXG0PEVVdSqnyDVJK19Q8VZKEv7FqVxTjyauoS88acTjMpWp/
    wnyx9eq5Q+f5wK4egPUSKqhj7maPxidfHDG1WybBbDoe8hefgi9mzbvN6wOxEvLi4ThE/i
    MCWVLp78FR3MwE532+oBLLfeGjmhf6gZyKHjLuYhzMxUvJnYMpPai18akdXzsdwQK2aSsn
    wpp1RuigsjRmFaaIsnA306F8hDP1J0Fxb+aIo+N2kmBwBA8HAEREHRMnLbSamezdfHC6Ve
    s9QaINOtjR8mBOL8OW8amM7Webdd9NcpxVnF5I+lLv9XwA9CwYgWN6RjMV6w
X-ME-Proxy: <xmx:VXYZanXYdNwCH4CsxKGeZZp6kszaQ63Ocg-v04B-teUHBstDlEmyMg>
    <xmx:VXYZamBp3-MPM4qn2rsNYhHpzsmmVdV5g6OjHCmDaSXkN1v4jHu47w>
    <xmx:VXYZag7SWu0rxSwEDztJtlk8ygBpxPpuf624jcXQ5GC0FR4qM0qwuw>
    <xmx:VXYZaqsRBvAntj4cnVkJkSyhoVKFoo__reIoGcw406RrMsk5tE-WSw>
    <xmx:VXYZagzZ6tepEBQMivW1UkJKqyKitg7wfO0OdNyGrhha1AuEusqO4XPX>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1546182007A; Fri, 29 May 2026 07:19:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
Date: Fri, 29 May 2026 13:19:29 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Kevin Brodsky" <kevin.brodsky@arm.com>,
 "Ard Biesheuvel" <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, "Will Deacon" <will@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Liz Prucka" <lizprucka@google.com>, "Seth Jenkins" <sethjenkins@google.com>,
 "Kees Cook" <kees@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Jann Horn" <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
Message-Id: <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
In-Reply-To: <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-26-ardb+git@google.com>
 <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end of kernel
 image
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Fri, 29 May 2026, at 10:27, Kevin Brodsky wrote:
> On 26/05/2026 19:58, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> Move the fixmap and kasan page tables out of the BSS section, and place
>> them at the end of the image, right before the init_pg_dir section where
>> some of the other statically allocated page tables live.
>>
>> These page tables are currently the only data objects in vmlinux that
>> are meant to be accessed via the kernel image's linear alias, and so
>> placing them together allows the remainder of the data/bss section to be
>> remapped read-only or unmapped entirely.
>>
>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  arch/arm64/include/asm/mmu.h    | 2 ++
>>  arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
>>  arch/arm64/mm/fixmap.c          | 6 +++---
>>  arch/arm64/mm/kasan_init.c      | 2 +-
>>  4 files changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>> index 5e1211c540ab..fb95754f2876 100644
>> --- a/arch/arm64/include/asm/mmu.h
>> +++ b/arch/arm64/include/asm/mmu.h
>> @@ -13,6 +13,8 @@
>>  
>>  #ifndef __ASSEMBLER__
>>  
>> +#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
>> +
>>  #include <linux/refcount.h>
>>  #include <asm/cpufeature.h>
>>  
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index e1ac876200a3..2b0ebfb30c63 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -349,9 +349,15 @@ SECTIONS
>>  	_edata = .;
>>  
>>  	/* start of zero-init region */
>> -	BSS_SECTION(SBSS_ALIGN, 0, 0)
>> +	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
>>  	__pi___bss_start = __bss_start;
>>  
>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>
> Do we actually need the NOLOAD type here?

Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS to be
emitted into Image.


