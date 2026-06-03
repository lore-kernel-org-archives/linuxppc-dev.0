Return-Path: <linuxppc-dev+bounces-21962-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F890CD6E69
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 08:58:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVhS84Qcvz2ybQ;
	Wed, 03 Jun 2026 18:58:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780477096;
	cv=none; b=gerdxUvfrUq8zLZDMd51uEakihvY2mFrK+ri1OKDxUXHAkPbZwFpJskf40Qk8ffx0hKsxIIK7aG+cxhZky/DaJ//dloWOxssWCKeC4RBx8lTwN3ixEmicVJui/KgS9C4rPYRcXaQd0hcRKjyboOyQcadUzUH0gplKddsSQe/1GysfmqjJ/PsMDxG5MWcPFYKbQG7HYmksJ1SkHpZtOHkMukpAQvCEWe63N7jRVlQpIWvXEMXxYGW93+Q2fV9YRH8HckYEk2gbPcoFAVhR7tU0MilwMKHT8uq8Utyc8wNHTbBdCEiVMLDuoxU8qTjLvXXtqQw9UBizsbmFs4r7Yn4Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780477096; c=relaxed/relaxed;
	bh=HNO5aQb0rtRKtux/wu+5AcytYSH9RtOlt3U0qrUIzPI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=SQgWR7/y5Ej/0Pu/FJSIGLSEEdhHCgCTIC/t9wEm8O2kwjrbazev23CZHuI8PsXBaY2Z/E2vGywCghf+pRtexUu1b5lKidpVWoV7ukEuKX93zw2FpjkBfs8LXhiVPnCO1vOI689n1iGJw2PFd3e/HGoqw+HT74Pxjtqk01ZarpGWaMiA1R0KJ3rq4t6NNp8o/UMlyhPEexcrMRW4/XFg/DDTbZbxPJb+E3zXWt7vHn019WQJv5E6GoExzty4NiUGbfxMotZkaQE/xBgOIXYTKQ5CfYeJjOhjRsVaTmtOj16mNLXxRHCvsW4xTTrPE4oBhl9H3LeYGR+ormlYoqZBMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnPkKyEg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnPkKyEg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVhS73Km3z2y8W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 18:58:15 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9E82C40B56;
	Wed,  3 Jun 2026 08:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE4A1F00893;
	Wed,  3 Jun 2026 08:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780477092;
	bh=HNO5aQb0rtRKtux/wu+5AcytYSH9RtOlt3U0qrUIzPI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=mnPkKyEgBAoJhHyCjKocF+n+JqkHcWSmPH184p/CrskKjSd4JLPoFSBGrYLKU9Mar
	 B1hI8HW9H+53ks3lghDx4U+J6rNa6f8KquouzDq0+DM7/4ZBRzC0AuXQVPvI5bKqkY
	 NglLbcu+ZBDleA+IgNkKfEKOPcXRhxVfSNk8lTpECqvKoBh+iHSyU2ZFRwFPFE4daX
	 kw0WCczgVzTNS8Nry/XjBs//vr21nJLOAmz9iMERtpe8gUl3WYdzTVYvcHDMtqVnlJ
	 wu/GIoZWa0/6+fA9X2Sm0u6y0MnNMo3tVdcswt4ZtD+mHXcn/QmWy2xNCp5hUrCygR
	 dCBoxrKjfQI+w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9E4CDF40075;
	Wed,  3 Jun 2026 04:58:10 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Wed, 03 Jun 2026 04:58:10 -0400
X-ME-Sender: <xms:ouwfaqCSomCUHn2Pcxt39NzT6QrYDOwoUaHjVutpQNUu0GYFMZl_Ig>
    <xme:ouwfavUBA_wa0-Kl0rwIin5phZ0Xk0GMcV5YCAKgwCXtZX9t6zPJc0f21igxmxdFZ
    el9mEG9Na6KsRXZeOce-ahEOIXmRVtrBYvtLtWGWDsGbs4lRkjjK10>
X-ME-Proxy-Cause: dmFkZTGr2weDGKBa0sUCUcj036iLL5Y1yiuWXtlNLmEI4O4KffGEG7mKCI4rtXP1Kjy/sC
    Vn4JLRDUw3n/LlH/P7ldcJy2f2NLMW7zEwQdl58eFGDw13Gd7uBwZtBFefeubqM57vT7KW
    gxI5DHTPlMa9V7t7GBAVKnyC4disspoUcyOJuYcuXeoXUDa8M5AS9XNNfwK+hXW4k6RRKP
    P+HnepDfV9Ly2SCGeboQtn62xJxY4OofV3op27GBS756vLSUraZsZIubTiRwHvbO7GWFg8
    TN89ZhNEjfm9JCDm1LdV/dDNhv9gsSNYWX/LbCMQhfYJTNEbDdYGKUoqZbehxmbuTXbkFU
    XnaKhsn2lQq7XiJ+YTNPtHlw97iNDWbeNZirflpUY26TpW4YlC0yGx1F2Pdjov4xxyaUZd
    nGZuSrO0ofec6SMf5X9bTikzbc7jU39nUFa8+EDOEs+sLMDgAb7Jfbkdo1r3Pi14q8HECl
    WOyAkHMSoapVwjPlMra4gfnE/Sq1KO70VhXXH61epQ6Rh+aRLmPHQfsv+x4lMOk7iiwpsY
    2Ln1UDislceGN/Gw4GkBXiCXnvOln8phYiq7SJoKkYgBG145jAMq3GJUgudNXhcY+kY+fP
    qpGcyL1cKdvM1YoB3pTqsi5xKVO8SJQEPQQW/+ABFCEXztbk2H+BY/x90g+g
X-ME-Proxy: <xmx:ouwfam3-PZsrAVqqiP-EfVs-0jTgxsPILW5ya_Lkxs4FNvUMV00I3A>
    <xmx:ouwfaqtJQPQRdRGCSDlzv7oyJj2hWevC-qAmYiniqjt8Bubu_25WPg>
    <xmx:ouwfai_l9FuzR3F73C0xJHJLI6BrnbgCXaJCGZTs31csy6qmGWmmEQ>
    <xmx:ouwfauR1k_z1hiMDOUWOdTJsWToATwu--U1XlEgRSm3i3JLjPhl_jg>
    <xmx:ouwfaoCm3jrQTsvC8JSjjw2cVnzpsLJPRFYPY4I2sfuqg_7otMeSlp9g>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 77D33182007A; Wed,  3 Jun 2026 04:58:10 -0400 (EDT)
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
Date: Wed, 03 Jun 2026 10:57:49 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Will Deacon" <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 "Ard Biesheuvel" <ardb+git@google.com>
Cc: "Catalin Marinas" <catalin.marinas@arm.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, "Mark Rutland" <mark.rutland@arm.com>,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Kevin Brodsky" <kevin.brodsky@arm.com>, "Liz Prucka" <lizprucka@google.com>,
 "Seth Jenkins" <sethjenkins@google.com>, "Kees Cook" <kees@kernel.org>,
 "Mike Rapoport" <rppt@kernel.org>, "David Hildenbrand" <david@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>, "Jann Horn" <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, maz@kernel.org
Message-Id: <2c7929d4-6622-475d-af1b-bcd0cd997cd3@app.fastmail.com>
In-Reply-To: <178041415770.4024555.11336437584927054639.b4-ty@kernel.org>
References: <20260529150150.1670604-17-ardb+git@google.com>
 <178041415770.4024555.11336437584927054639.b4-ty@kernel.org>
Subject: Re: [PATCH v7 00/15] arm64: Unmap linear alias of kernel data/bss
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

(cc Marc)

On Tue, 2 Jun 2026, at 22:34, Will Deacon wrote:
> On Fri, 29 May 2026 17:01:51 +0200, Ard Biesheuvel wrote:
>> One of the reasons the lack of randomization of the linear map on arm64
>> is considered problematic is the fact that bootloaders adhering to the
>> original arm64 boot protocol (i.e., a substantial fraction of all
>> Android phones) may place the kernel at the base of DRAM, and therefore
>> at the base of the non-randomized linear map. This puts a writable alias
>> of the kernel's data and bss regions at a predictable location, removing
>> the need for an attacker to guess where KASLR mapped the kernel.
>> 
>> [...]
>
> It would've been nice to hear from the ppc folks on patch 11, but I've
> picked it up on the assumption that they'll love the negative diff stat.
> Worst case, we can drop/revert stuff if they have late objections.
>

Thanks.

There is a de facto ack from Michael Ellerman in the Link:, which is why
I included it.

Note that Sashiko found an issue with KVM+MTE, where a read-only mapping
of the zero page in the linear map may result in issues:

"""
Does moving the zero page to .rodata (or unmapping/read-only mapping its
linear alias) expose a guest-to-host denial of service with KVM and MTE?
When an MTE-enabled KVM guest reads an unmapped memory address, KVM handles
the stage-2 fault by mapping the host's shared zero page. KVM will then
call sanitise_mte_tags() in arch/arm64/kvm/mmu.c.
Since the PG_mte_tagged flag is never set on the zero page, KVM's
try_page_mte_tagging() succeeds, and it calls mte_clear_page_tags().
This executes the STGM instruction using the zero page's linear map alias.
If this alias is read-only or unmapped, won't the STGM instruction trigger
a synchronous permission fault or translation fault in EL1, causing a host
kernel panic?
"""

Marc seems to think it is legit, so I came up with the following (I'll send
it out separately with another pair of tweaks):

-------8<------------
From: Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] arm64: mte: Disregard the zero page explicitly for
 manipulating tags

The zero page is conceptually immutable, and will be moved into .rodata
to prevent inadvertent corruption.

Prepare the MTE code for this, by ensuring that the zero page is never
taken into account for tag manipulation, given that those actions will
no longer be permitted on the read-only alias of .rodata in the linear
map.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
index 7f7b97e09996..093b34944aee 100644
--- a/arch/arm64/include/asm/mte.h
+++ b/arch/arm64/include/asm/mte.h
@@ -80,6 +80,11 @@ static inline bool page_mte_tagged(struct page *page)
  */
 static inline bool try_page_mte_tagging(struct page *page)
 {
+       extern struct page *__zero_page;
+
+       if (page == __zero_page)
+               return false;
+
        VM_WARN_ON_ONCE(folio_test_hugetlb(page_folio(page)));
 
        if (!test_and_set_bit(PG_mte_lock, &page->flags.f))

