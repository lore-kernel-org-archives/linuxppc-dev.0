Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTTK15jnFzDr2q
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 01:22:45 +1000 (AEST)
Date: Fri, 11 Aug 2017 17:22:41 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, kasan-dev@googlegroups.com, borntraeger@de.ibm.com,
 heiko.carstens@de.ibm.com, davem@davemloft.net, willy@infradead.org,
 ard.biesheuvel@linaro.org, will.deacon@arm.com,
 catalin.marinas@arm.com, sam@ravnborg.org
Subject: Re: [v6 00/15] complete deferred page initialization
Message-ID: <20170811152240.GQ30811@dhcp22.suse.cz>
References: <1502138329-123460-1-git-send-email-pasha.tatashin@oracle.com>
 <20170811075826.GB30811@dhcp22.suse.cz>
 <23e22449-89f0-507d-e92a-9ee947a7c363@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <23e22449-89f0-507d-e92a-9ee947a7c363@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 11-08-17 11:13:07, Pasha Tatashin wrote:
> On 08/11/2017 03:58 AM, Michal Hocko wrote:
> >[I am sorry I didn't get to your previous versions]
> 
> Thank you for reviewing this work. I will address your comments, and
> send-out a new patches.
> 
> >>
> >>In this work we do the following:
> >>- Never read access struct page until it was initialized
> >
> >How is this enforced? What about pfn walkers? E.g. page_ext
> >initialization code (page owner in particular)
> 
> This is hard to enforce 100%. But, because we have a patch in this series
> that sets all memory that was allocated by memblock_virt_alloc_try_nid_raw()
> to ones with debug options enabled, and because Linux has a good set of
> asserts in place that check struct pages to be sane, especially the ones
> that are enabled with this config: CONFIG_DEBUG_VM_PGFLAGS. I was able to
> find many places in linux which accessed struct pages before
> __init_single_page() is performed, and fix them. Most of these places happen
> only when deferred struct page initialization code is enabled.

Yes, I am very well aware of how hard is this to guarantee. I was merely
pointing out that the changelog should be more verbose about your
testing and assumptions so that we can revalidate them.
-- 
Michal Hocko
SUSE Labs
