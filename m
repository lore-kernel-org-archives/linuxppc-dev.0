Return-Path: <SRS0=SmZj=WM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47259C3A59D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 17:52:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3DC920665
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Aug 2019 17:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3DC920665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4699rq3fC6zDrQs
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Aug 2019 03:52:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=mark.rutland@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 4698sh3LFYzDrqZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2019 03:08:22 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 074A928;
 Fri, 16 Aug 2019 10:08:20 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 700803F694;
 Fri, 16 Aug 2019 10:08:18 -0700 (PDT)
Date: Fri, 16 Aug 2019 18:08:13 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v4 1/3] kasan: support backing vmalloc space with real
 shadow memory
Message-ID: <20190816170813.GA7417@lakrids.cambridge.arm.com>
References: <20190815001636.12235-1-dja@axtens.net>
 <20190815001636.12235-2-dja@axtens.net>
 <15c6110a-9e6e-495c-122e-acbde6e698d9@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15c6110a-9e6e-495c-122e-acbde6e698d9@c-s.fr>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
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
Cc: gor@linux.ibm.com, x86@kernel.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, glider@google.com,
 luto@kernel.org, aryabinin@virtuozzo.com, linuxppc-dev@lists.ozlabs.org,
 dvyukov@google.com, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

On Fri, Aug 16, 2019 at 09:47:00AM +0200, Christophe Leroy wrote:
> Le 15/08/2019 à 02:16, Daniel Axtens a écrit :
> > Hook into vmalloc and vmap, and dynamically allocate real shadow
> > memory to back the mappings.
> > 
> > Most mappings in vmalloc space are small, requiring less than a full
> > page of shadow space. Allocating a full shadow page per mapping would
> > therefore be wasteful. Furthermore, to ensure that different mappings
> > use different shadow pages, mappings would have to be aligned to
> > KASAN_SHADOW_SCALE_SIZE * PAGE_SIZE.
> > 
> > Instead, share backing space across multiple mappings. Allocate
> > a backing page the first time a mapping in vmalloc space uses a
> > particular page of the shadow region. Keep this page around
> > regardless of whether the mapping is later freed - in the mean time
> > the page could have become shared by another vmalloc mapping.
> > 
> > This can in theory lead to unbounded memory growth, but the vmalloc
> > allocator is pretty good at reusing addresses, so the practical memory
> > usage grows at first but then stays fairly stable.
> 
> I guess people having gigabytes of memory don't mind, but I'm concerned
> about tiny targets with very little amount of memory. I have boards with as
> little as 32Mbytes of RAM. The shadow region for the linear space already
> takes one eighth of the RAM. I'd rather avoid keeping unused shadow pages
> busy.

I think this depends on how much shadow would be in constant use vs what
would get left unused. If the amount in constant use is sufficiently
large (or the residue is sufficiently small), then it may not be
worthwhile to support KASAN_VMALLOC on such small systems.

> Each page of shadow memory represent 8 pages of real memory. Could we use
> page_ref to count how many pieces of a shadow page are used so that we can
> free it when the ref count decreases to 0.
> 
> > This requires architecture support to actually use: arches must stop
> > mapping the read-only zero page over portion of the shadow region that
> > covers the vmalloc space and instead leave it unmapped.
> 
> Why 'must' ? Couldn't we switch back and forth from the zero page to real
> page on demand ?
>
> If the zero page is not mapped for unused vmalloc space, bad memory accesses
> will Oops on the shadow memory access instead of Oopsing on the real bad
> access, making it more difficult to locate and identify the issue.

I agree this isn't nice, though FWIW this can already happen today for
bad addresses that fall outside of the usual kernel address space. We
could make the !KASAN_INLINE checks resilient to this by using
probe_kernel_read() to check the shadow, and treating unmapped shadow as
poison.

It's also worth noting that flipping back and forth isn't generally safe
unless going via an invalid table entry, so there'd still be windows
where a bad access might not have shadow mapped.

We'd need to reuse the common p4d/pud/pmd/pte tables for unallocated
regions, or the tables alone would consume significant amounts of memory
(e..g ~32GiB for arm64 defconfig), and thus we'd need to be able to
switch all levels between pgd and pte, which is much more complicated.

I strongly suspect that the additional complexity will outweigh the
benefit.

[...]

> > +#ifdef CONFIG_KASAN_VMALLOC
> > +static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
> > +				      void *unused)
> > +{
> > +	unsigned long page;
> > +	pte_t pte;
> > +
> > +	if (likely(!pte_none(*ptep)))
> > +		return 0;
> 
> Prior to this, the zero shadow area should be mapped, and the test should
> be:
> 
> if (likely(pte_pfn(*ptep) != PHYS_PFN(__pa(kasan_early_shadow_page))))
> 	return 0;

As above, this would need a more comprehensive redesign, so I don't
think it's worth going into that level of nit here. :)

If we do try to use common shadow for unallocate VA ranges, it probably
makes sense to have a common poison page that we can use, so that we can
report vmalloc-out-of-bounfds.

Thanks,
Mark.
