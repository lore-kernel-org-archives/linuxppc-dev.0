Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A6BC48260
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Feb 2024 17:35:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TW3zg4qQDz3cCx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Feb 2024 04:35:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=mark.rutland@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TW3zB2yWxz3bv3
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2024 04:35:15 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC798DA7;
	Thu,  8 Feb 2024 09:35:24 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.33.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6E443F64C;
	Thu,  8 Feb 2024 09:34:38 -0800 (PST)
Date: Thu, 8 Feb 2024 17:34:33 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH v5 00/25] Transparent Contiguous PTEs for User Mappings
Message-ID: <ZcUQqfg39zCS2BAv@FVFF77S0Q05N.cambridge.arm.com>
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202080756.1453939-1-ryan.roberts@arm.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, x86@kernel.org, David Hildenbrand <david@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Yang Shi <shy828301@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org, Andrey Ryabinin <ryabinin.a.a@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Alistair Popple <apopple@nvidia.com>, Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Ingo Molnar <mingo@redhat.com>, Zi Yan <ziy@nvidia.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, John Hubbard <jhubbard@nvidia.com>, Nicholas Piggin <npiggin@gmail.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 02, 2024 at 08:07:31AM +0000, Ryan Roberts wrote:
> Hi All,

Hi Ryan,

I assume this is the same as your 'features/granule_perf/contpte-lkml_v' branch
on https://gitlab.arm.com/linux-arm/linux-rr/

I've taken a quick look, and I have a few initial/superficial comments before
digging into the detail on the important changes.

> Patch Layout
> ============
> 
> In this version, I've split the patches to better show each optimization:
> 
>   - 1-2:    mm prep: misc code and docs cleanups

I'm not confident enough to comment on patch 2, but these look reasonable to
me.

>   - 3-8:    mm,arm,arm64,powerpc,x86 prep: Replace pte_next_pfn() with more
>             general pte_advance_pfn()

These look fine to me.

>   - 9-18:   arm64 prep: Refactor ptep helpers into new layer

The result of patches 9-17 looks good to me, but the intermediate stages where
some functions are converted is a bit odd, and it's a bit painful for review
since you need to skip ahead a few patches to see the end result to tell that
the conversions are consistent and complete.

IMO it'd be easier for review if that were three patches:

1) Convert READ_ONCE() -> ptep_get()
2) Convert set_pte_at() -> set_ptes()
3) All the "New layer" renames and addition of the trivial wrappers

Patch 18 looks fine to me.

>   - 19:     functional contpte implementation
>   - 20-25:  various optimizations on top of the contpte implementation

I'll try to dig into these over the next few days.

Mark.
