Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0AEDC67A3B
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 12:22:38 +1000 (EST)
Subject: Re: [RFC]: map 4K iommu pages even on 64K largepage systems.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20061024002540.GA6360@austin.ibm.com>
References: <20061024002540.GA6360@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 12:22:25 +1000
Message-Id: <1161656545.10524.524.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-10-23 at 19:25 -0500, Linas Vepstas wrote:
> Subject: [RFC]: map 4K iommu pages even on 64K largepage systems.
> 
> The 10Gigabit ethernet device drivers appear to be able to chew
> up all 256MB of TCE mappings on pSeries systems, as evidenced by
> numerous error messages:
> 
>  iommu_alloc failed, tbl c0000000010d5c48 vaddr c0000000d875eff0 npages 1
> 
> Some experimentaiton indicates that this is essentially because
> one 1500 byte ethernet MTU gets mapped as a 64K DMA region when
> the large 64K pages are enabled. Thus, it doesn't take much to
> exhaust all of the available DMA mappings for a high-speed card.

There is much to be said about using a 1500MTU and no TSO on a 10G
link :) But appart from that, I agree, we have a problem.
 
> This patch changes the iommu allocator to work with its own 
> unique, distinct page size. Although the patch is long, its
> actually quite simple: it just #defines  distinct IOMMU_PAGE_SIZE
> and then uses this in al the places tha matter.
> 
> The patch boots on pseries, untested in other places.
> 
> Haven't yet thought if this is a good long-term solution or not,
> whether this kind of thing is desirable or not.  That's why its 
> an RFC.  Comments?

It's probably a good enough solution for RHEL, but we should do
something different long term. There are a few things I have in mind:

 - We could have a page size field in the iommu_table and have the iommu
allocator use that. Thus we can have a per iommu table instance page
size. That would allow Geoff to deal with his crazy hypervisor by
basically having one iommu table instance per device. It would also
allow us to keep using large iommu page sizes on platform where the
system gives us more than a pinhole for iommu space :)

 - In the long run, I'm thinking about the interest in supporting two
page sizes for the fine and coarse allocation regions of the table. We
would need to get a bit more infos from the HW backend to do that, but
for example, on native Cell, we can have a page size per 256Mb region,
thus we could have the iommu space dividied in 4k pages for small
mappings and 64k pages for full page or more mappings.

So I reckon we should first audit and make sure your current patch works
fine on everything as a crash-fix for 2.6.19 and backportable to RHEL. 

Then, we can implement my first option for 2.6.20 and possibly debate
about the interest of my second option, unless somebody else comes up
with better ideas of course :)

Ben.
