Return-Path: <linuxppc-dev+bounces-21698-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87B4CD6E4C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:35:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRcB03pvPz2xnZ;
	Fri, 29 May 2026 18:35:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780043720;
	cv=none; b=SWVcN7DvcK2O7MpqzhSm9WpjslIkyJIGgsLoEH3TbDYPdIc5zmCwj/TlDnuyYQ+Xg7DzKLi7bcvqIBlrgZgsC5EpRG9D/Tnw4lNzTqthocoNWjq8F/gzYZhoUoegwPXnJYSTrKGN74nkadsj7tXPkd6v4gCrHKJSqQXvKnjivUBH3NydQTpk+r23v7C789oLA+Xp4mDoLLdAQsQsKzSgijAJ4ByVwK6LWspG9FessJO8IVYJQcIHCJBxavr7bM2x0/YEJSZNWcFpeCAe8lGuY89U4M4aXyIt1US/7I6e4A0iCi67WXfRUDUq4dMn6bbSjVnwkdaOYJCA7itfjSuKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780043720; c=relaxed/relaxed;
	bh=pb8hRl9aeM4TyobxS9yOnAKjXiRrSGZc3kFIWxU6xN8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=h7I8DoM4h46wi8N2HWvsmSSc/Dl6huQLO7dpI5FlQN0Hhr1voW0PEwAvlVeiBrLcFga7ympTrGEL0ku783onoeJUAOyql1XVfv7dO280ihARFhUTzFVHItzXg2u+Dn/yqD5/Z/BrHE6nGAC0IQkvYp2/jaiafsMnHtNzaC+QeiJcH1QDT9mYx+jaS+VGm5AIDPT7al8E6L0sMnId98tBRa3nzaBxmURzuH3zsHOE32p+ivQK1a8FLWcf4dpwY45fGtUVAJoUF1z6K7RhEPmI5jWxVE32N9pCfGvyoIEGKBBuXJ41FrJjV3Vnr/8y8SyRq9e9u1Wpx8UryQUOdhnlVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHiWA6Jm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eHiWA6Jm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ardb@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRc9z48QVz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:35:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 17F37419C5;
	Fri, 29 May 2026 08:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A871F00899;
	Fri, 29 May 2026 08:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780043717;
	bh=pb8hRl9aeM4TyobxS9yOnAKjXiRrSGZc3kFIWxU6xN8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=eHiWA6JmmhYrHhKFbvxiZTW2xJNbosNU9RTUq54HJ9qxC8j3R64ua2CiUQZSUqrGR
	 E4C4UAZoPRV+CsP2askx3paA4itfF9NPWE1l5jJvDfGPFPkEGz3bxaowNb98jVhwYd
	 sIzZwjUPwcgBigvncsDX4VRpDg0Tb6nhoOntqVSjMBnwzxSdSiLFK6FJIf15NU1oue
	 2e06gPFOVDKImLo61ENrTCqi0Vur53PFnTt+HyeKotfWsgoxzzM/t3v5FSFnxqJZ1x
	 5vkt06vWKXTJUvw6Aip6rqRQinfTHQ/h0Ol1LDsXkJDGByoWsG4GKZzw2U9VgRPNk4
	 X+1bHuoen9KnQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id BFDBEF40071;
	Fri, 29 May 2026 04:35:15 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-01.internal (MEProxy); Fri, 29 May 2026 04:35:15 -0400
X-ME-Sender: <xms:w08ZakpiqlRdTFy9M8HRTgnxe37LK5skX4bkamkDB8ZQY6J_BXof0g>
    <xme:w08ZalcpocRSklO6G3o4eP1S-C7Au03jLquVqT3dZ5DscMRpjm2bm4i_76NXPzOYq
    8m4qP5eSsmGjQA1h8D2q0tixCicp_xLKZTHbImZhneyxQr7DFoP86w>
X-ME-Proxy-Cause: dmFkZTEQkc69D4Zmkpn7XYQpl901Rkrrlg7dZ91u0M7kyZwKWzkp8pPC3OUm3GoeIl8ZEa
    YfWBmvqFv7f873bL+J6awk4ALyVkWsyPN8hSWHWjLy526VQi+F7vLkb0Se4dJsA0+9AZhC
    mbOE8Rse92D/zIxqfxjhk+KGvVsWFXzvhiWzaNvH5HcjXMs97MFy2Ahat6AJXkgvUokmXr
    /Gu6KLlQhkZMYy3mWkvL+fDWGnmRPKdBsaBtjexICmnhLEzeFMUm63gl1KF4NntnTnrGCZ
    5uP9Ng/N2EwYovqYva2VTXsDVpCTseypQ4wv1F7Roh5FxvMHGn/c9ZuTyDPXb5H5cYd9OF
    ouUVMrrrUvOBF+JwFSgKrNDT1DaZWGqGqIruNwSE/opEQSzIQ9zrw0wSLqFYazgl+kiQ2Y
    sOA6HQbJZ1rsrjuuE8457H8E9j+gYAMNvf2x/vyO3yPcSYsc6/o4Qv5NP528gMTHdvJaAm
    67pp6LKTMNBnVUl5+cMWaa7+cdgW/ehxUAOYaKGkKA+PbVR4+3EA/jVGZ6CQAJR+U55MP8
    RJ3nfWIh5Zcdgam/v5JKyDfCEfILxKZWGoRhtzNLhOLpeh2LqHMVG6TV6WbGBbiSYPAVd9
    5RD+D/lju40uQTEYWt1/7jLvi8oS4Hu5DB5XqNd+rkUXwkCvApYca1SMpU/Q
X-ME-Proxy: <xmx:w08ZalSR2fUKHnUGeophPGZfIoa3FLSiVorE0-OEfUNGV2uLw-_6ZA>
    <xmx:w08Zal3v_7ek3COIKrCDsZfg2jQl0m4Z3rI0TedAf7i9hjoae96Jag>
    <xmx:w08ZaiiajKIvWqZEZyaQI_aMtzFW-TTcZjHXYOCntS4zV902fIzDwQ>
    <xmx:w08ZajZHTB-r0fcFpaVE-YRBz0k-6zzT2wtxgkCJgsY-Wxa2QTmtlg>
    <xmx:w08ZarPj9tOVHrNBAweSV_sZUvum-foitmXNYw4RmHdlg2YpKR9_xRaz>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9B247182007A; Fri, 29 May 2026 04:35:15 -0400 (EDT)
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
Date: Fri, 29 May 2026 10:34:49 +0200
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
Message-Id: <8082b77d-6522-472a-9030-317087ecd7e9@app.fastmail.com>
In-Reply-To: <22042b98-cfcc-428e-bb08-ebcfe785eb69@arm.com>
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-32-ardb+git@google.com>
 <22042b98-cfcc-428e-bb08-ebcfe785eb69@arm.com>
Subject: Re: [PATCH v6 15/15] arm64: mm: Unmap kernel data/bss entirely from the linear
 map
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, 29 May 2026, at 10:29, Kevin Brodsky wrote:
> On 26/05/2026 19:59, Ard Biesheuvel wrote:
>> From: Ard Biesheuvel <ardb@kernel.org>
>>
>> The linear aliases of the kernel text and rodata are mapped read-only in
>> the linear map as well. Given that the contents of these regions are
>> mostly identical to the version in the loadable image, mapping them
>> read-only and leaving their contents visible is a reasonable hardening
>> measure.
>>
>> Data and bss, however, are now also mapped read-only but the contents of
>> these regions are more likely to contain data that we'd rather not leak.
>> So let's unmap these entirely in the linear map when the kernel is
>> running normally.
>>
>> When going into hibernation or waking up from it, these regions need to
>> be mapped, so map the region initially, and toggle the valid bit so
>> map/unmap the region as needed. (While the hibernation snapshot logic
>> seems able to map inaccessible pages as needed, it currently disregards
>> non-present pages entirely.)
>
> I'm not sure I understand this, is there something wrong with the
> kernel_page_present() check in safe_copy_page()?
>

No. If the hibernate code decides to snapshot a page and it is not mapped,
safe_copy_page() will do the right thing and map it on demand.

The problem is that pages belonging to the kernel image are marked as
PageReserved, and so the hibernation logic will not even consider the
pages for snapshotting if they are not mapped.

>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>  arch/arm64/mm/mmu.c | 39 +++++++++++++++++---
>>  1 file changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index e7ca53d20b87..cb00e42abbe1 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/mm.h>
>>  #include <linux/vmalloc.h>
>>  #include <linux/set_memory.h>
>> +#include <linux/suspend.h>
>>  #include <linux/kfence.h>
>>  #include <linux/pkeys.h>
>>  #include <linux/mm_inline.h>
>> @@ -1056,6 +1057,29 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
>>  				 end - start, prot, early_pgtable_alloc, flags);
>>  }
>>  
>> +static void remap_linear_data_alias(bool unmap)
>> +{
>> +	set_memory_valid((unsigned long)lm_alias(__init_end),
>> +			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
>> +			 !unmap);
>> +}
>> +
>> +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
>> +				     unsigned long mode, void *unused)
>> +{
>> +	switch (mode) {
>> +	default:
>> +		break;
>> +	case PM_POST_HIBERNATION:
>> +		remap_linear_data_alias(true);
>> +		break;
>> +	case PM_HIBERNATION_PREPARE:
>> +		remap_linear_data_alias(false);
>> +		break;
>> +	}
>> +	return 0;
>> +}
>> +
>>  void __init mark_linear_text_alias_ro(void)
>>  {
>>  	/*
>> @@ -1064,6 +1088,16 @@ void __init mark_linear_text_alias_ro(void)
>>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>>  			    (unsigned long)__init_begin - (unsigned long)_text,
>>  			    PAGE_KERNEL_RO);
>> +
>> +	remap_linear_data_alias(true);
>
> As suggested on v4, something like mark_linear_data_alias_valid(false)
> would be clearer.
>

Ack.

> Also, is there anything stopping us from doing that directly in map_mem()?
>

Excellent question. I will investigate.


