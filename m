Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 107402C0178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 04:37:19 +1000 (EST)
Date: Wed, 10 Jul 2013 13:37:06 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] KVM: PPC: Book3E: Get vcpu's last instruction for
 emulation
To: Alexander Graf <agraf@suse.de>
In-Reply-To: <27E6FCB1-322F-410D-A87C-D5410C7374E7@suse.de> (from
 agraf@suse.de on Wed Jul 10 05:18:10 2013)
Message-ID: <1373481426.8183.219@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
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

On 07/10/2013 05:18:10 AM, Alexander Graf wrote:
>=20
> On 10.07.2013, at 02:12, Scott Wood wrote:
>=20
> > On 07/09/2013 04:45:10 PM, Alexander Graf wrote:
> >> On 28.06.2013, at 11:20, Mihai Caraman wrote:
> >> > +	/* Get page size */
> >> > +	if (MAS0_GET_TLBSEL(mfspr(SPRN_MAS0)) =3D=3D 0)
> >> > +		psize_shift =3D PAGE_SHIFT;
> >> > +	else
> >> > +		psize_shift =3D MAS1_GET_TSIZE(mas1) + 10;
> >> > +
> >> > +	mas7_mas3 =3D (((u64) mfspr(SPRN_MAS7)) << 32) |
> >> > +		    mfspr(SPRN_MAS3);
> >> > +	addr =3D (mas7_mas3 & (~0ULL << psize_shift)) |
> >> > +	       (geaddr & ((1ULL << psize_shift) - 1ULL));
> >> > +
> >> > +	/* Map a page and get guest's instruction */
> >> > +	page =3D pfn_to_page(addr >> PAGE_SHIFT);
> >> While looking at this I just realized that you're missing a check =20
> here. What if our IP is in some PCI BAR? Or can't we execute from =20
> those?
> >
> > We at least need to check pfn_valid() first.  That'll just keep us =20
> from accessing a bad pointer in the host kernel, though -- it won't =20
> make the emulation actually work.  If we need that, we'll probably =20
> need to create a temporary TLB entry manually.
>=20
> ioremap()?

That's a bit heavy... also we'd need to deal with cacheability.  This =20
code is already engaged in directly creating TLB entries, so it doesn't =20
seem like much of a stretch to create one for this.  It should be =20
faster than ioremap() or kmap_atomic().

The one complication is allocating the virtual address space, but maybe =20
we could just use the page that kmap_atomic would have used?  Of =20
course, if we want to handle execution from other than normal kernel =20
memory, we'll need to make sure that the virtual address space is =20
allocated even when highmem is not present (e.g. 64-bit).

> However, if we were walking the guest TLB cache instead we would get =20
> a guest physical address which we can always resolve to a host =20
> virtual address.
>=20
> I'm not sure how important that whole use case is though. Maybe we =20
> should just error out to the guest for now.

It's not that important, now that we are using hugetlb rather than =20
directly mapping a large hunk of reserved memory.  It would be nice to =20
handle it though, if we can do without too much hassle.  And I think =20
manually creating a TLB entry could be faster than kmap_atomic(), or =20
searching the guest TLB and then doing a reverse memslot lookup.

-Scott=
