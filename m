Return-Path: <linuxppc-dev+bounces-21780-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F691CD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 08:37:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTS5T5zT9z2ydQ;
	Mon, 01 Jun 2026 18:37:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780303069;
	cv=none; b=KTpyZnYmTD8uDvCywrN/TD7XqkudWvAN2T5Q8Vl49LF5FLTfr1DxxxCahWZ+Q60L3ZlJ21u1XKbwev2a1fNJbLsO/uOecO6RKI22F4QBr2bgOlOHjhqU2DPN2KTnt08sl3CjM0YU0zshVYvw6raXsSiEKjCFpvJML5G2wW8ckF3cHTwfwFEpsbYT8Dycl9EPuUN05A5UZiSy3FRzyvu+Ww972dq6DIMo92hEQirq/FaSp5HDeHtVYhEr0oC2pdi+B20TCznoo5xFGTH6vRhKsDUkwlNxw85m4Uh/ERKZf9MgFEmETwyyFUuXsT93QCmi6PZ0B6Dlu9k88swSpqeTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780303069; c=relaxed/relaxed;
	bh=VvDYhItoRkSY+VDYaOrv7BbQfnd5C296YbD9BNrMnV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nocLJyNE0rOGW0ZICyV839o4Cf5842TtWP3L7Npnbbyg7DuvO49X5tbwla0JkHchROksSDIeWO5Budm8Jmt4QoVKhzsKbc+mir9nH+NKsgz/emmQ5e6BxEYVwqg3ERS4dyhpiwTgSEfT0xQspmWYY9hffxgYQOmLr/CMB5wu8I4cdw2irX/VyQlAJ0OX9P5xtJAbCEDu7t1Y4xycrWeOtIN+pMQgBw4Z/rUiIoCPTsSkNWrdpgXqMM1BSfTx48XwHWUfyibxn7EjVxLAFIkJ8luJxpCbZ+FmiQp7xn1bNinMKI8JzVWDoy7l+PsGShFksekT0Yh8Wxyrb+z/VLWJHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PZxls1oX; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=PZxls1oX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTS5R1zl2z2xqn
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 18:37:45 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6BEF1E8D;
	Mon,  1 Jun 2026 01:37:07 -0700 (PDT)
Received: from [10.57.94.8] (unknown [10.57.94.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 367EE3F93E;
	Mon,  1 Jun 2026 01:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780303032; bh=KhZVl+Vwqx0OaCH6S7jXIByk6u8k8lh7Uhiuy+3SVi0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PZxls1oXIsr6hApf9XohwV3WTI1Qo/Er1dviSU6itCMJmAKDxMZHODtjuGAfErgJl
	 6867qR2HsryNZcylx+G0a/AX10BCLvlvPK4pBvuCBYe/sz6hhDG0C2A1TIs2eBczWC
	 E1gn7G1PE54lFFInYxUKOqbSvwpx/gKLHzFd0Yb4=
Message-ID: <69488547-cf2a-4aa0-bca7-0cb65aa01914@arm.com>
Date: Mon, 1 Jun 2026 10:37:03 +0200
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
 <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
 <feab72b8-2961-4145-ac5c-80e820bf1ce9@app.fastmail.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <feab72b8-2961-4145-ac5c-80e820bf1ce9@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29/05/2026 16:47, Ard Biesheuvel wrote:
>>>>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
>>>>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>>>> Do we actually need the NOLOAD type here?
>>> Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS to be
>>> emitted into Image.
>> That's rather strange, aren't the .pgdir.bss input sections already
>> NOBITS since __pgtbl_bss is only used on default-initialised globals?
> Not sure why, but the section was PROGBITS not NOBITS before I added the (NOLOAD)

I've had a closer look into this. Similar sections in other
architectures are all named .bss..<something>. If I rename this section
to .bss..pgdir, then indeed the compiler does emit an object file with
that section marked NOBITS:

$ readelf -e out/arch/arm64/mm/fixmap.o | grep bss
  [ 4] .bss              NOBITS          0000000000000000 0002ac 000000
00  WA  0   0  1
  [18] .bss..pgdir       NOBITS          0000000000000000 000750 005000
00  WA  0   0 4096

And then the linker does the right thing without having to use NOLOAD.

I was concerned that .bss..pgdir might get caught by BSS_SECTION(), but
it seems that the double dots are meant to prevent exactly that.

- Kevin

