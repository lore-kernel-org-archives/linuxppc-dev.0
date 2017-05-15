Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRW8b49F0zDqNs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 05:38:23 +1000 (AEST)
Date: Mon, 15 May 2017 21:38:18 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net
Subject: Re: [v3 0/9] parallelized "struct page" zeroing
Message-ID: <20170515193817.GC7551@dhcp22.suse.cz>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
 <20170509181234.GA4397@dhcp22.suse.cz>
 <e19b241d-be27-3c9a-8984-2fb20211e2e1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e19b241d-be27-3c9a-8984-2fb20211e2e1@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon 15-05-17 14:12:10, Pasha Tatashin wrote:
> Hi Michal,
> 
> After looking at your suggested memblock_virt_alloc_core() change again, I
> decided to keep what I have. I do not want to inline
> memblock_virt_alloc_internal(), because it is not a performance critical
> path, and by inlining it we will unnecessarily increase the text size on all
> platforms.

I do not insist but I would really _prefer_ if the bool zero argument
didn't proliferate all over the memblock API.
 
> Also, because it will be very hard to make sure that no platform regresses
> by making memset() default in _memblock_virt_alloc_core() (as I already
> showed last week at least sun4v SPARC64 will require special changes in
> order for this to work), I decided to make it available only for "deferred
> struct page init" case. As, what is already in the patch.

I do not think this is the right approach. Your measurements just show
that sparc could have a more optimized memset for small sizes. If you
keep the same memset only for the parallel initialization then you
just hide this fact. I wouldn't worry about other architectures. All
sane architectures should simply work reasonably well when touching a
single or only few cache lines at the same time. If some arches really
suffer from small memsets then the initialization should be driven by a
specific ARCH_WANT_LARGE_PAGEBLOCK_INIT rather than making this depend
on DEFERRED_INIT. Or if you are too worried then make it opt-in and make
it depend on ARCH_WANT_PER_PAGE_INIT and make it enabled for x86 and
sparc after memset optimization.

-- 
Michal Hocko
SUSE Labs
