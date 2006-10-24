Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3F9A467A39
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 13:01:01 +1000 (EST)
Message-ID: <453D81E2.1060004@am.sony.com>
Date: Mon, 23 Oct 2006 20:00:50 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC]: map 4K iommu pages even on 64K largepage systems.
References: <20061024002540.GA6360@austin.ibm.com>
	<1161656545.10524.524.camel@localhost.localdomain>
In-Reply-To: <1161656545.10524.524.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Mon, 2006-10-23 at 19:25 -0500, Linas Vepstas wrote:
>> Subject: [RFC]: map 4K iommu pages even on 64K largepage systems.
>> 
>> The 10Gigabit ethernet device drivers appear to be able to chew
>> up all 256MB of TCE mappings on pSeries systems, as evidenced by
>> numerous error messages:
>> 
>>  iommu_alloc failed, tbl c0000000010d5c48 vaddr c0000000d875eff0 npages 1
>> 
>> Some experimentaiton indicates that this is essentially because
>> one 1500 byte ethernet MTU gets mapped as a 64K DMA region when
>> the large 64K pages are enabled. Thus, it doesn't take much to
>> exhaust all of the available DMA mappings for a high-speed card.
> 
> There is much to be said about using a 1500MTU and no TSO on a 10G
> link :) But appart from that, I agree, we have a problem.
>  
>> This patch changes the iommu allocator to work with its own 
>> unique, distinct page size. Although the patch is long, its
>> actually quite simple: it just #defines  distinct IOMMU_PAGE_SIZE
>> and then uses this in al the places tha matter.
>> 
>> The patch boots on pseries, untested in other places.
>> 
>> Haven't yet thought if this is a good long-term solution or not,
>> whether this kind of thing is desirable or not.  That's why its 
>> an RFC.  Comments?
> 
> It's probably a good enough solution for RHEL, but we should do
> something different long term. There are a few things I have in mind:
> 
>  - We could have a page size field in the iommu_table and have the iommu
> allocator use that. Thus we can have a per iommu table instance page
> size. That would allow Geoff to deal with his crazy hypervisor by
> basically having one iommu table instance per device. It would also
> allow us to keep using large iommu page sizes on platform where the
> system gives us more than a pinhole for iommu space :)


Actually, its not so important for me, since for performance, most users
will just want to map the whole of ram for every device and essentially
not use iommu pages.

For those that want to use per-device dynamic mapping, I believe there
are enough entries to support 4K io pages.

-Geoff
