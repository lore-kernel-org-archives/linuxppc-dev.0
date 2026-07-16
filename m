Return-Path: <linuxppc-dev+bounces-24316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8567DC44501
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 09:35:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h17Fm5kXqz2yYs;
	Thu, 16 Jul 2026 19:35:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784194556;
	cv=none; b=KoMy9HBLbAtPsN51oFr0XuGKY91xLUwbQuniBw147J58tKGLW5RcUqaeHAd8JwZ3T2VqVao2XnrK7qr1gx8sgpD/Ic7Nhi85Yk6qHNjnigoN6QoUvww0uA4cWpkSEX8E1/13CXn8bN0JdJGHOJJTLGZ4gYQBjPMrZ7xrWvuMiljGCT1HH39hoGtz/i0wdZgpfOm3AlfGZ2ZFcQHEy1Z45crqQNB7dvk0su+uQnDvxab955csqYOfrkEPrrn4UweT19amsPNupDcLrBBnhCaFHxtFqfnXUdqRd8qA+2sokzsmVpuh0XkPrXyyJeHygUCoKO4cnrIUSdvPRwIku2txLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784194556; c=relaxed/relaxed;
	bh=PSf5NVNQU/qg/WZaziEf6MJsCA+xP66TswCfDndguR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV1O9Z/XQSnDD05UkDHDWoL1aufsBMVF5+q8zEaFUA74FHioCQ3szoB1wCJez1t/YVS9MWgTLQVADXPL8eCziBN8zPRNIHib287bQkrdUfeoD3bbeQdhUsFbE6n+nCMRXDckEq7IC9Z/snjovY3YIMcZfKQCnHU6pvu0dnE1SsCk/TEco/zFHNeUTFkArq420VmdTOzU8E6XJkV/dwGBwU/wRiHzJ4bMfVNuAlps3KkR0NMohGfsCzP9R/7ZL4LLBIaIuML60XYNm/gpRwz1KsFjHn1neZjDH9eJows0zmVZVM0Nf4LL1dRZGjNPuAk50W32du6+WzzyesYUJWMnqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WfF+qmdk; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WfF+qmdk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h17Fl61YDz2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 19:35:55 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0BC1477;
	Thu, 16 Jul 2026 02:35:20 -0700 (PDT)
Received: from [10.57.83.230] (unknown [10.57.83.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48693F905;
	Thu, 16 Jul 2026 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784194524; bh=1BVLyLaF1qecs+fgW08zdSlsqUZduOIGJBU1ULHtkjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WfF+qmdktWvhJyvXuGhu5iu7o0FWtOqQ5I0g8heoED31AV02y/qkTuaH5oKdQgNVz
	 Zk0OME+7E85ZuIaQ7/UmrEgiZGtJ9Onp9GZygZefACK6bIgVDye7nneuzPpsC+bgGq
	 OEE0LznhDFEX6R7AoNIGyWQ01U2Y9n4+8Xjc5eLI=
Message-ID: <02565237-d777-4c63-8b17-817df59feac4@arm.com>
Date: Thu, 16 Jul 2026 11:35:10 +0200
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
Subject: Re: [PATCH 04/22] mm: use mm_is_kernel() in generic page table code
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>,
 x86@kernel.org, tboot-devel@lists.sourceforge.net,
 Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org,
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-4-44be8a7685d7@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-4-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2026 16:03, Kevin Brodsky wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index d5e87624f692..c0244c0b0756 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3394,13 +3394,13 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
>  	spinlock_t *ptl;
>  
>  	if (create) {
> - mapped_pte = pte = (mm == &init_mm) ?
> + mapped_pte = pte = mm_is_kernel(mm) ?
>  			pte_alloc_kernel_track(pmd, addr, mask) :
>  			pte_alloc_map_lock(mm, pmd, addr, &ptl);

As noted by Sashiko, this is a little problematic because if
apply_to_page_range() is called on efi_mm, then we will end up with
__pte_alloc_kernel() taking the init_mm lock, since that's hardcoded.

That probably means we should pass the mm to __pte_alloc_kernel().

FWIW calling the kernel alloc function for efi_mm is the correct thing
to do: this ensures we use pmd_populate_kernel() and therefore kernel
page table attributes (just like efi_create_mapping()). This path is
currently never hit because EFI regions whose permissions are modified
are PTE-mapped, but it is clearly more correct to use the kernel path
for such mm's.

- Kevin

