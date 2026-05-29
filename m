Return-Path: <linuxppc-dev+bounces-21725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF87CCD6E51
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 14:48:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRmSP1QL6z2ySg;
	Sat, 30 May 2026 00:48:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780066101;
	cv=none; b=ojsqPPxPN78MSZZn1Zgn3UdQshgqXy/MKS6aHi3+pQQlFR4ltJ3ttVOwyG0q3WgAQyqayoamAr29zLYqz0tY3DKBANwfrDkpu4nmlx+dFj0UoOBSNzVnJufSopbUPwdgj/rwa9qLKn1eTezCwtPTEWWva9gD6rmQM/0XM1pUVRATp6r86i3BES2IxkDdEfCo4SFwvYU1a6OJRuzWL4mppP7Yk0yr2Ggu+OJOZt5yayQA2clx2hIhQVMcoD17wMue9TckzuVY0lo0sO1GT6A7e8H/AHObNLyTHEfkmZqWr/QBcwOWjB2X9lZPM7oXUw1bu5MLHPey94znwXM4pY0QIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780066101; c=relaxed/relaxed;
	bh=rDYAlmQq2lyT0mKI/5jPVDdXiqH331Ok6KPFJGIkolA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AuqyPsF7dLC9b8I/gwfzLYqPa5eVpgybHy3CPST3zS8dUHNZSRvTptu3UgJ6h+w1W6PfgRjGgpgffEV0PhcHzbJ1LnYqgsAtVEHPCdSCnHTikquztNOgWdo/nQRjL2pxpl2vSPUEAjMgXyaiBkaLPu+p/oM+4iVp8s3fGHmCkiP9cTcwFLuVSA5iwYFLJRgMT/+SYrokPBhDZ6h1ETnkbmhbfooYx9pkfvyPCnk4SNvvpffX5It0fQlHt7VGcVmY1jvOqFaJ8BRZcyAxydZVDSEG/S6m8hgkBt+EmcaZe0/6xZzy5GrV5OCgBjr49/GaLqtc729xvXH5G2LjV/Quvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QX53BMvH; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QX53BMvH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRmSN0g1Gz2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 May 2026 00:48:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1487F4444A;
	Fri, 29 May 2026 14:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6541F00899;
	Fri, 29 May 2026 14:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780066097;
	bh=rDYAlmQq2lyT0mKI/5jPVDdXiqH331Ok6KPFJGIkolA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=QX53BMvHmF9Tb016y6OiviqLZpdCcXakEzemQvHAIKHZmDwqrBZ9kKc4eGKH+DM7R
	 m6NOmObiOsgEXE9+ZMADhdk8mZfU87xXkUaBGEAcA4R/n1Q0380J4hxoJ7N0rnzntx
	 pFEysq+iLGkMo4UZG6c2O5zG2qvZnbaM4aRgHF8b7tVhZ0eU4aaL0+tAbGi4TYbB5o
	 Xheulmx2TTK+BQxu8Uw+3F7ThLsqWRwQiQ1T5gSGNdwLENawgUsV9l1gvVhixOS8J1
	 nEYMDyX4++E76AADfsobhXucTV82EArbMolMJmHNQPts4kqOycyQ2QOqeHTZnczoo6
	 2bjirJ6ob0crg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9B26AF4006B;
	Fri, 29 May 2026 10:48:15 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Fri, 29 May 2026 10:48:15 -0400
X-ME-Sender: <xms:L6cZalvqhsB-aHhaRkze_h7UY2ABhSZeFnZ60Q3_IKMDCODR4iuKzA>
    <xme:L6cZapRecgER7059-g_h5SmbR74_rDZdbLKHp8wKImrL7GCvJSuQ-czyG9PRHVNgX
    LodoT-OBe61zEkLfQ414HQKZYu3vF8l4Y7Vj5axhKW3qvVV9XuVlw0>
X-ME-Proxy-Cause: dmFkZTGt+msDe027/QMow7WM2h4XBrXubrUHHx9XVuKXNuewjeECntXEkvpZpwjkpuwWEv
    A+IG7AeFN5owfWzwbPO9CjcB7TRAAsY44WxF7zXFXy6LoVGUAKFH2Bx1eeqBPzIerpvVjv
    ELx4NQx0XG6whtq/UTw90jigQlW4j18Zh0Zt1+paIGSTOJ9ku9oHpPkPFvh0lxBxqNkgBT
    FnRPsw9ol+7BaTbq+VC3GgNlb/hfOhjgLaPfDPKB8smIObxRKijH1R3rHFi8eHD+NkkdLJ
    A7LUeOTltjqUyU3MM5Wv53HhVF64Qimbf03q9/pBfm6OGXhfkEoLOeymapiGYXWuW7kwNp
    ckYNzIG87pXFDqxBpRSEjOxQSObcP/T++yyH1GkG3YItNvgZi8BW7YZJf0oLK1Eiu9ctpj
    e/Qrzm63c6EjvCPOKuUOldqVtQ9ZHP5SjAUyNeaZsq8FP10znmcrDkJjKhmkqvgalMjmqj
    5yI6GJ6yQK3gJ/0sFlH1xfNMM7hLe/tXPVaeY8cRX+7fv6nhbeMCau2aQ4gfKKOCQInygr
    DX9MXYrq5o/uY7i19kTROhADx/RRu9bkIc+kVBeOktIvcQ1AMx9acT0YqOTPMhDzC2jr7R
    qbv5MzK1kh98MwYu6S2aUc5FDL3Tal9kQVrQ86RuzLjlmuBz9HkOhgZjLFug
X-ME-Proxy: <xmx:L6cZanX74O-bar_jLvxjWKCnp-Ih7O5QrV09suBOhbCd2rIrR9xQeA>
    <xmx:L6cZamrF7UpYic3Pul9sEvDf0nlILb6aAYq-n3JKJgUil7UpBZORtQ>
    <xmx:L6cZarFrHHphMz_k0i3sOdMq0fdtjxTfs29QHz9bIdolxCo5oEEGVA>
    <xmx:L6cZaouUFRbFWAprH-4qWiANOmu1DUXbhNuFie1nlzyqPUFP98ZCWQ>
    <xmx:L6cZauQug8MFn_HvWRIXz9IpPD4mlQQP6iSw5xCI5jVhcTfQZiXZW5o_>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 780D8182007A; Fri, 29 May 2026 10:48:15 -0400 (EDT)
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
Date: Fri, 29 May 2026 16:47:54 +0200
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
Message-Id: <feab72b8-2961-4145-ac5c-80e820bf1ce9@app.fastmail.com>
In-Reply-To: <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-26-ardb+git@google.com>
 <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
 <96a8b6b9-71f2-4550-bbbb-fbfa146f4e6a@app.fastmail.com>
 <b76b327f-612e-494f-b8d3-44108aa73d2a@arm.com>
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end of kernel
 image
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026, at 16:42, Kevin Brodsky wrote:
> On 29/05/2026 13:19, Ard Biesheuvel wrote:
>> On Fri, 29 May 2026, at 10:27, Kevin Brodsky wrote:
>>> On 26/05/2026 19:58, Ard Biesheuvel wrote:
>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>
>>>> Move the fixmap and kasan page tables out of the BSS section, and place
>>>> them at the end of the image, right before the init_pg_dir section where
>>>> some of the other statically allocated page tables live.
>>>>
>>>> These page tables are currently the only data objects in vmlinux that
>>>> are meant to be accessed via the kernel image's linear alias, and so
>>>> placing them together allows the remainder of the data/bss section to be
>>>> remapped read-only or unmapped entirely.
>>>>
>>>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> ---
>>>>  arch/arm64/include/asm/mmu.h    | 2 ++
>>>>  arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
>>>>  arch/arm64/mm/fixmap.c          | 6 +++---
>>>>  arch/arm64/mm/kasan_init.c      | 2 +-
>>>>  4 files changed, 13 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
>>>> index 5e1211c540ab..fb95754f2876 100644
>>>> --- a/arch/arm64/include/asm/mmu.h
>>>> +++ b/arch/arm64/include/asm/mmu.h
>>>> @@ -13,6 +13,8 @@
>>>>  
>>>>  #ifndef __ASSEMBLER__
>>>>  
>>>> +#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
>>>> +
>>>>  #include <linux/refcount.h>
>>>>  #include <asm/cpufeature.h>
>>>>  
>>>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>>>> index e1ac876200a3..2b0ebfb30c63 100644
>>>> --- a/arch/arm64/kernel/vmlinux.lds.S
>>>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>>>> @@ -349,9 +349,15 @@ SECTIONS
>>>>  	_edata = .;
>>>>  
>>>>  	/* start of zero-init region */
>>>> -	BSS_SECTION(SBSS_ALIGN, 0, 0)
>>>> +	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
>>>>  	__pi___bss_start = __bss_start;
>>>>  
>>>> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
>>>> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {
>>> Do we actually need the NOLOAD type here?
>> Yes, otherwise it is emitted as PROGBITS, resulting in all of BSS to be
>> emitted into Image.
>
> That's rather strange, aren't the .pgdir.bss input sections already
> NOBITS since __pgtbl_bss is only used on default-initialised globals?

Not sure why, but the section was PROGBITS not NOBITS before I added the (NOLOAD)

> Also AFAIU NOLOAD does not prevent the output section from being emitted
> into the ELF file.
>

NOLOAD marks it as NOBITS, which means there is no data in the file that should
be used to populate the section in memory.


