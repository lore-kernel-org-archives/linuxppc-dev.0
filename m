Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM03-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam03on0046.outbound.protection.outlook.com [104.47.40.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnvY04tWpzDrSN
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 19:00:04 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: UIO memmap of PCi devices not working?
Date: Thu, 7 Sep 2017 08:59:55 +0000
Message-ID: <1504774792.31322.13.camel@infinera.com>
References: <1504711235.27247.110.camel@infinera.com>
 <1504768612.12628.19.camel@kernel.crashing.org>
 <1504768943.27247.149.camel@infinera.com>
 <1504773212.12628.26.camel@kernel.crashing.org>
In-Reply-To: <1504773212.12628.26.camel@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 18:33 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2017-09-07 at 07:22 +0000, Joakim Tjernlund wrote:
> > On Thu, 2017-09-07 at 17:16 +1000, Benjamin Herrenschmidt wrote:
> > > On Wed, 2017-09-06 at 15:20 +0000, Joakim Tjernlund wrote:
> > > > Having problems to mmap PCI UIO devices and stumbeled over this pag=
e:
> > > >  http://billfarrow.blogspot.se/2010/09/userspace-access-to-pci-memo=
ry.html
> > > > it claims some adjustments are needed for UIO mmap over PCI to work=
.
> > > > These are #if 0 ATM and trying to enable them fails build.
> > > >=20
> > > > Can this be fixed to at least build again ?
> > > > The reason for having #if 0 in the first place appears to be old X =
servers,
> > > > is that still true? Can the special casing be removed now?
> > >=20
> > > This article seems out of date... I *think* things should work withou=
t
> > > change by just mmap'ing the appropriate sysfs files. I'm not sure why
> > > the author thought that had to be ifdef'ed out...
> >=20
> > Isn't that what the article is doing(mmaping sysfs files)?
> > And the article author is #ifdefing it back, not out.
>=20
> Yes sorry that's what I meant. It should work as-is.
>=20
> > >=20
> > > Let me know if you have problems.
> >=20
> > Sure, we still are looking=20
> >=20
> > >=20
> > > As far as I know, the generic code will call pci_resource_to_user()
> > > which on powerpc will return a physical address that already includes
> > > the offset, which is why we don't later add it.
> > >=20
> > > Now we could probably tear all that out and use the new generic code
> > > instead as I *think* X has (very) long been fixed but I'd have to spe=
nd
> > > some time triple checking and testing on old HW which I don't have th=
e
> > > bandwidth for right now.=20
> >=20
> > Could you fixup the code which is now #if 0 ? I wan't to test the
> > difference and I not sure how to fix the build problem after changing
> > those two #if 0 to #if 1
> > Even better if they could be a CONFIG option instead.
>=20
> Hrm it's tricky, you shouldn't just turn that ifdef back on without
> also changing pci_resource_to_user().

There are two ifdef to change:
__pci_mmap_make_offset():
#if 0 /* See comment in pci_resource_to_user() for why this is disabled */
		*offset +=3D hose->pci_mem_offset;
#endif

and

pci_resource_to_user()
	/* We pass a fully fixed up address to userland for MMIO instead of
	 * a BAR value because X is lame and expects to be able to use that
	 * to pass to /dev/mem !
	 *
	 * That means that we'll have potentially 64 bits values where some
	 * userland apps only expect 32 (like X itself since it thinks only
	 * Sparc has 64 bits MMIO) but if we don't do that, we break it on
	 * 32 bits CHRPs :-(
	 *
	 * Hopefully, the sysfs insterface is immune to that gunk. Once X
	 * has been fixed (and the fix spread enough), we can re-enable the
	 * 2 lines below and pass down a BAR value to userland. In that case
	 * we'll also have to re-enable the matching code in
	 * __pci_mmap_make_offset().
	 *
	 * BenH.
	 */
#if 0
	else if (rsrc->flags & IORESOURCE_MEM)
		offset =3D hose->pci_mem_offset;
#endif

Problem is that pci_mem_offset is gone, the closed I can find is mem_offset
but that is an array,maybe just mem_offset[0] ?

> I'm not sure exactly what's going
> on in your case, if you have a problem can you add printk to instrument
> ?
Seems to be something else going on in out board. Anyhow, the mem_offset sh=
ould
be fixed to compile, nice to have it behind a CONFIG option. Then
one can start the process to remove the special casing easier.

 Jocke=
