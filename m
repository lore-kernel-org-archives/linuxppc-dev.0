Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 121C72C02FF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 08:48:24 +1000 (EST)
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1373481426.8183.219@snotra>
Date: Thu, 11 Jul 2013 00:48:19 +0200
Message-Id: <C30A89DD-5D52-4978-9694-ABF89297C4C9@suse.de>
References: <1373481426.8183.219@snotra>
To: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.07.2013, at 20:37, Scott Wood wrote:

> On 07/10/2013 05:18:10 AM, Alexander Graf wrote:
>> On 10.07.2013, at 02:12, Scott Wood wrote:
>> > On 07/09/2013 04:45:10 PM, Alexander Graf wrote:
>> >> On 28.06.2013, at 11:20, Mihai Caraman wrote:
>> >> > +	/* Get page size */
>> >> > +	if (MAS0_GET_TLBSEL(mfspr(SPRN_MAS0)) =3D=3D 0)
>> >> > +		psize_shift =3D PAGE_SHIFT;
>> >> > +	else
>> >> > +		psize_shift =3D MAS1_GET_TSIZE(mas1) + 10;
>> >> > +
>> >> > +	mas7_mas3 =3D (((u64) mfspr(SPRN_MAS7)) << 32) |
>> >> > +		    mfspr(SPRN_MAS3);
>> >> > +	addr =3D (mas7_mas3 & (~0ULL << psize_shift)) |
>> >> > +	       (geaddr & ((1ULL << psize_shift) - 1ULL));
>> >> > +
>> >> > +	/* Map a page and get guest's instruction */
>> >> > +	page =3D pfn_to_page(addr >> PAGE_SHIFT);
>> >> While looking at this I just realized that you're missing a check =
here. What if our IP is in some PCI BAR? Or can't we execute from those?
>> >
>> > We at least need to check pfn_valid() first.  That'll just keep us =
from accessing a bad pointer in the host kernel, though -- it won't make =
the emulation actually work.  If we need that, we'll probably need to =
create a temporary TLB entry manually.
>> ioremap()?
>=20
> That's a bit heavy... also we'd need to deal with cacheability.  This =
code is already engaged in directly creating TLB entries, so it doesn't =
seem like much of a stretch to create one for this.  It should be faster =
than ioremap() or kmap_atomic().

Do we have any guarantees that the TLB entry we create doesn't get =
evicted by another thread by the time we want to use it?


Alex

> The one complication is allocating the virtual address space, but =
maybe we could just use the page that kmap_atomic would have used?  Of =
course, if we want to handle execution from other than normal kernel =
memory, we'll need to make sure that the virtual address space is =
allocated even when highmem is not present (e.g. 64-bit).
>=20
>> However, if we were walking the guest TLB cache instead we would get =
a guest physical address which we can always resolve to a host virtual =
address.
>> I'm not sure how important that whole use case is though. Maybe we =
should just error out to the guest for now.
>=20
> It's not that important, now that we are using hugetlb rather than =
directly mapping a large hunk of reserved memory.  It would be nice to =
handle it though, if we can do without too much hassle.  And I think =
manually creating a TLB entry could be faster than kmap_atomic(), or =
searching the guest TLB and then doing a reverse memslot lookup.
>=20
> -Scott
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
