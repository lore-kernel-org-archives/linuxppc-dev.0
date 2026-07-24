Return-Path: <linuxppc-dev+bounces-24800-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B35C531FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 16:23:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6CwL2CHbz2xnQ;
	Sat, 25 Jul 2026 02:23:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784910210;
	cv=none; b=lHd8PUPBMEl15xADG2ytzuS4bLT7QyfrTcViqp+3Z/VpcxuRVJYwNCnDlYiZ3NM/7Lf3kYu19btePu3cjPyFv7JSeOe+5SukBpulDR+drof3GsdCgWuRyqgx6NtQ6ivplb/nx9lgASdd3qe8QORqN2/5jx8G+9piymVOgRi/0YwBipGXkPXzeSuy6AQbJ2b8cCvWQuUtk/hNEEPLcEPGQ6vpQsHKOTfdq+F4ikT+s4IH2Nt2ACLtaQyqcB8iRNsG1ukxlouqH7l7NB/wE7OgCsWpZPYkRNZF45RDM7jCcbuYHJgfBSiSZrNUTw0NB5yLITMz9Fo1xxj1ypdqWZBfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784910210; c=relaxed/relaxed;
	bh=R4roeXRjJcUf/JwCqMmQlNS5gCdrtAP9Td7ApgTux+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMbyb1m3sodFc92Z2/1GnCGWQbOHBG5Ss3OSiUaFN0usAA1snpJLQMSGwYqYWhEm0mH6f++meMYpNzshY5ezaeMoPCGx9/OdTjgOfv+eUopHk1uHSEAQ+GXorRNljPFlCGvVVappDK+Q661crAC9nca3ot9uuNjqcvumuiAzjk/nLxmIVnlXmgs0z6irfjYK7jumq1YOfq1+fDhxLM9swKLL5UAt9k/V+c0y8dI4uDtvn+ydoq23tfnclsn3I/6+KsQIhQmeIvK7lfaQ6eWljqVGVmu9t3xG/WEmxv4A2XAjCNZx3YD/Jnxa8ygjG2OfwtibOfIUrFwdI3tLB0nWEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iUC98dpb; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iUC98dpb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6CwK10lRz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 02:23:28 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930E91684;
	Fri, 24 Jul 2026 09:22:52 -0700 (PDT)
Received: from [10.57.0.90] (unknown [10.57.0.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C7F03F66F;
	Fri, 24 Jul 2026 09:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784910176; bh=C02uWs/fpXnABbH43y4jX8fXPGtwBqhc0kWtZDPeayg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iUC98dpbFgd+i9SnSkYL0GKvWGOk7xpTRmX2UXYjyfh9B/6bLE/WuAx7CloLocREN
	 hl9aaz1HKjYAaCZbwP0FbaUIknYs8KANk5nrYXdBG0Da9JXUPnYnhocq3QUWcdY9Et
	 OVQZdbXfa8qUjKcrVhyZR4pIQLBjcpiml/L4ONBo=
Message-ID: <d312f635-7c34-4452-b879-d29137a7f450@arm.com>
Date: Fri, 24 Jul 2026 18:22:40 +0200
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
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
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
 <02565237-d777-4c63-8b17-817df59feac4@arm.com>
 <0d75daa4-a034-4094-bce5-57938d294163@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <0d75daa4-a034-4094-bce5-57938d294163@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2026 17:07, David Hildenbrand (Arm) wrote:
> On 7/16/26 11:35, Kevin Brodsky wrote:
>> On 14/07/2026 16:03, Kevin Brodsky wrote:
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index d5e87624f692..c0244c0b0756 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3394,13 +3394,13 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
>>>  	spinlock_t *ptl;
>>>  
>>>  	if (create) {
>>> - mapped_pte = pte = (mm == &init_mm) ?
>>> + mapped_pte = pte = mm_is_kernel(mm) ?
>>>  			pte_alloc_kernel_track(pmd, addr, mask) :
>>>  			pte_alloc_map_lock(mm, pmd, addr, &ptl);
>> As noted by Sashiko, this is a little problematic because if
>> apply_to_page_range() is called on efi_mm, then we will end up with
>> __pte_alloc_kernel() taking the init_mm lock, since that's hardcoded.
>>
>> That probably means we should pass the mm to __pte_alloc_kernel().
> Agreed.
>
> I guess we have to audit all existing init_mm usage?

Indeed, I looked through comparisons with &init_mm but really all
references to init_mm should be checked. Will do for v2.

- Kevin

