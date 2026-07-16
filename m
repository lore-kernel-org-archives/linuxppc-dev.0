Return-Path: <linuxppc-dev+bounces-24317-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBFBC44501
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jul 2026 09:50:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h17ZL39LRz2yXj;
	Thu, 16 Jul 2026 19:50:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784195418;
	cv=none; b=W6TvZG/DeXp6aQ9xjYEk2mEFVFH4vYE5hLbd7ZuEeA1L8V0HFzgjux3wldgaIhd57kqtbIzcs/ESzT8v3V3hQHAGiHYAJnpjFaBVArAktMvRqB31eh/qGVXqNAX7h2R1+2JW8x6CbGknG1TwZc/1Hm7olYS65e4cIGIE6JiH02cQ6ObKWPhgjtju/2K0OCBiQI/cp+Mf/1xg3kQ14jA67krDoFh/Xe8ZAZTXfxkVC5ZxHcXi4WKLPj/TwkGpxqqcCqjzoW7NXP/rtfNQK4PJ135aasmgtF/1vF5dA3nJ7x4AM5u6a5oZfAk91BONoqtJk6thMhLS/WRoc+0y0s/NUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784195418; c=relaxed/relaxed;
	bh=DULupypI0kQO6VR/9Hnm6xvd1I56RK/sZSlBe1w/CWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRNY2SQbGbRqDGbf/QddOd3ylrDr3aiYa6B8MjwI4gVSmxqhM7KvgR0znQcduMgD5/y2R5PFX06fXQYgfbejbBnR1VI09c0Mqlfh4ssgJZynEBhpNh392qmpbiZ9OQf4Zv3+DmfWS46KOrvNAHC+ezDkrvxtMt8/cqkuUeCfxMWMAv38KtUWQH7UvkQ78esTtlyIX7pkAOvp5R89k3Q64dT8l2s4qq5x5AA7e7OSFQF2dtJyb8gUwwMORDKN8U04s2JyGfcqg1ZiU9wzs31pEjFY5pEZxqrdJsIg677eZhE846C8sykeV/ildv4QT5gF3gFKDYKRPygSm1sqnqGS9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=s0WjY92k; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=s0WjY92k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h17ZK1GVTz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2026 19:50:16 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A60E11477;
	Thu, 16 Jul 2026 02:49:40 -0700 (PDT)
Received: from [10.57.83.230] (unknown [10.57.83.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28D693F905;
	Thu, 16 Jul 2026 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784195384; bh=DULupypI0kQO6VR/9Hnm6xvd1I56RK/sZSlBe1w/CWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s0WjY92k6FXXGsVb/uHJpLBIVOYUjUI8eS0BHss4CJRfj+QIoU4lVy2lHkTcCkoLf
	 HXbioh4bhVzyH7KrUz8UAnwAXsoSNPBoK+CXb0kGziyOHBz0wHOsqFAI5ri0j0KaxN
	 AXVBsuWhv1zZICmG2yvm8TKcS7aYUdVdoYT9nYUs=
Message-ID: <f3afa5df-73f3-49da-87a6-d75eb5f3610f@arm.com>
Date: Thu, 16 Jul 2026 11:49:31 +0200
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
Subject: Re: [PATCH 14/22] mm: set page table page type when allocated
To: Vishal Moola <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
 <alZSwAM4pwmMOeaD@fedora>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <alZSwAM4pwmMOeaD@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2026 17:16, Vishal Moola wrote:
> On Tue, Jul 14, 2026 at 03:04:03PM +0100, Kevin Brodsky wrote:
>> As a step towards removing pagetable ctor/dtor calls for kernel
>> mm's, move the page type updates from the ctor/dtor to
>> pagetable_{alloc,free}.
> Thanks for doing this patchset.

Thanks for suggesting it :) It's turning out to be quite a bit more
involved than I expected though! (There are multiple cases where we call
the ctor/dtor without using pagetable_{alloc,free}, see my reply to the
cover letter.)

> We should switch over from __folio_set_pgtable() to __SetPagePgtable()
> in this patch. Ptdescs and folios should be treated as distinctly
> independent of each other.

I sure remember the previous discussion, but my reading of your comments
[1] is that we cannot really change this as long as pagetable_alloc()
can be called with order > 0, right? Multiple archs still rely on that.

> Eventually, we want to replace the memcg accounting as well, but
> there's no existing API for that right now. Lets leave that as is for
> now; this patchset is big enough already ;)

Yep, looks like there was an attempt to improve this but it had to be
reverted [2].

- Kevin

[1] https://lore.kernel.org/all/aha321ndGSdReBJR@fedora/
[2]
https://lore.kernel.org/all/20260225002434.2953895-1-axelrasmussen@google.com/


