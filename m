Return-Path: <vitb@kernel.crashing.org>
Date: Mon, 27 Aug 2007 10:31:36 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/3] [POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Message-ID: <20070827103136.4e0ffc43@localhost.localdomain>
In-Reply-To: <20070827011515.GA12804@localhost.localdomain>
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070825092947.4087.68187.stgit@localhost.localdomain>
	<20070827011515.GA12804@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 27 Aug 2007 11:15:16 +1000
David Gibson wrote:

> On Sat, Aug 25, 2007 at 01:29:47PM +0400, Vitaly Bordug wrote:
> >=20
> > We are having 2 different instances of
> > pci_process_bridge_OF_ranges(), which makes describing 64-bit
> > physical addresses in non PPC64 case impossible.
> >=20
> > This approach inherits pci space parsing, but has a new way to
> > behave equally good in both 32bit and 64bit environments. Currently
> > validated with 440EPx (sequoia) and mpc8349-eitx.
> >=20
> > Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> > Signed-off-by: Stefan Roese <sr@denx.de>
>=20
> I like the idea, but I don't think this implementation is adequate
> yet.

OK, I'll try to address notes below, thanks for looking at it.
>=20
> > diff --git a/arch/powerpc/kernel/pci-common.c
> > b/arch/powerpc/kernel/pci-common.c index 083cfbd..57cd039 100644
> > --- a/arch/powerpc/kernel/pci-common.c
> > +++ b/arch/powerpc/kernel/pci-common.c
> > @@ -478,3 +478,162 @@ void pci_resource_to_user(const struct
> > pci_dev *dev, int bar, *start =3D rsrc->start - offset;
> >  	*end =3D rsrc->end - offset;
> >  }
> > +
> > +void __devinit pci_process_bridge_OF_ranges(struct pci_controller
> > *hose,
> > +					    struct device_node
> > *dev, int prim) +{
> > +	static unsigned int static_lc_ranges[256];
> > +	const unsigned int *ranges;
> > +	unsigned int *lc_ranges;
> > +	unsigned int pci_space;
> > +	unsigned long size =3D 0;
>=20
> size can be 64-bit on 32-bit systems, at least in theory.
>=20
hm, well, but later, we'll call ioremap (at least for IO region) that has s=
ize passed as ulong type. And,  such a size could be consumed by the code,o=
nly if resource_size_t is 64bit too. I'll look at it further.
> > +	int rlen =3D 0;
> > +	int orig_rlen, ranges_amnt, i;
> > +	int memno =3D 0;
> > +	struct resource *res;
> > +	int np, na =3D of_n_addr_cells(dev);
> > +	struct ranges_pci64_sz64 *ranges64 =3D NULL;
> > +	struct ranges_pci32_sz64 *ranges32 =3D NULL;
> > +	phys_addr_t pci_addr,=20
>=20
> This is wrong: the PCI binding defines the PCI addresses to be 64-bit,
> even if the CPU has 32-bit physical addresses.
>=20
hmm, ok
> cpu_phys_addr;
> > +
> > +	np =3D na + 5;
> > +
> > +	/* From "PCI Binding to 1275"
> z> +	 * The ranges property is laid out as an array of
> z> elements,
> > +	 * each of which comprises:
> > +	 *   cells 0 - 2:       a PCI address
> > +	 *   cells 3 or 3+4:    a CPU physical address
> > +	 *                      (size depending on
> > dev->n_addr_cells)
> > +	 *   cells 4+5 or 5+6:  the size of the range
> > +	 */
> > +	ranges =3D of_get_property(dev, "ranges", &rlen);
> > +	if (ranges =3D=3D NULL)
> > +		return;
>=20
> if (!ranges) would be the usual idiom here.
>=20
ok
> > +	/* Sanity check, though hopefully that never happens */
> > +	if (rlen > sizeof(static_lc_ranges)) {
> > +		printk(KERN_WARNING "OF ranges property too
> > large !\n");
> > +		rlen =3D sizeof(static_lc_ranges);
> > +	}
> > +
> > +	/* Let's work on a copy of the "ranges" property instead
> > +	 * of damaging the device-tree image in memory
> > +	 */
> > +	lc_ranges =3D static_lc_ranges;
> > +	memcpy(lc_ranges, ranges, rlen);
> > +	orig_rlen =3D rlen;
> > +
> > +	ranges =3D lc_ranges;
>=20
> You don't ever actually touch the ranges property in place, so there's
> no need for this copy stuff.
>=20
ok
> > +	/* Map ranges to struct according to spec. */
> > +	if (na >=3D 2) {
> > +		ranges64 =3D (void *)ranges;
> > +		ranges_amnt =3D rlen / sizeof(*ranges64);
> > +	} else {
> > +		ranges32 =3D (void *)ranges;
> > +		ranges_amnt =3D rlen / sizeof(*ranges32);
> > +	}
> > +
> > +	hose->io_base_phys =3D 0;
> > +	for (i =3D 0; i < ranges_amnt; i++) {
> > +		res =3D NULL;
> > +		if (ranges64) {
> > +			if (ranges64[i].pci_space =3D=3D 0)
> > +				continue;
> > +
> > +			pci_space =3D ranges64[i].pci_space;
> > +			pci_addr =3D
> > +			    (u64) ranges64[i].pci_addr[0] << 32 |
> > ranges64[i].
> > +			    pci_addr[1];
>=20
> Why not just define the pci_addr field in your structures as u64?  You
> would have to define the structure with attribute((packed)), I guess.
>=20
that was in the first approach, but it gets really interesting numbers (and=
 with contents nothing to do with real stuff),
on platforms that are pure 32bit. I mean,=20

u32 foo, foo1;
u64 foo64;

foo =3D bar[1];
foo1 =3D bar[2];
foo64 =3D ((u64)foo << 32) | foo1;

does not seem to work on 32bit board. I may need to write a clear testcase =
and submit it here, maybe I'm missing something
very obvious.

> > +			cpu_phys_addr =3D
> > +			    of_translate_address(dev,
> > ranges64[i].phys_addr);
> > +			/*
> > +			 * I haven't observed 2 significant size
> > cells in kernel
> > +			 * code, so we're accounting only LSB of
> > size part
> > +			 * from ranges. -vitb
> > +			 */
> > +			size =3D ranges64[i].size[1];
> > +#ifdef CONFIG_PPC64
> > +			if (ranges64[i].size[0])
> > +				size |=3D ranges64[i].size[0]<<32;
> > +#endif
> > +			DBG("Observed: pci %llx phys %llx size
> > %x\n", pci_addr,
> > +			    cpu_phys_addr, size);
> > +		} else {
> > +			if (ranges32[i].pci_space =3D=3D 0)
> > +				continue;
> > +
> > +			pci_space =3D (unsigned
> > int)ranges32[i].pci_space;
> > +			pci_addr =3D (unsigned
> > int)ranges32[i].pci_addr[1];
> > +			cpu_phys_addr =3D (unsigned
> > int)ranges32[i].phys_addr[0];
>=20
>=20
> We should really be using of_translate_address() in all cases - that's
> what it's for, after all.
>=20
being called, it gives 0 in 32bit branch of  if () {. Since, iirc,
32bit range parsing does not have it in original, variant,
I have it put as is. worths a brief investigation...
> > +			size =3D ranges32[i].size[1];
> > +
> > +			DBG("Observed: pci %x phys %x size %x\n",
> > +			    (u32) pci_addr, (u32) cpu_phys_addr,
> > size);
> > +		}
>=20
> You don't have any equivalent of the code that exists in both
> pre-existing versions to coalesce contiguous ranges.  You probably
> want to use the 64-bit version, since that doesn't need a local copy
> of the ranges.
>=20
correct. yet, the whole aim of the upper seems to use summary size of
contiguous block and that's it.
How would we recognize IORESOURCE_PREFETCH then? (I know, my code is missin=
g that prefetch regions so far, but anyway).
=46rom the code, it seems to declare each resource that is part of contiguous=
 block, with the size of entire block.

That's prolly from binding, but can you please elaborate the logic for bett=
er understanding?
> > +
> > +		switch ((pci_space >> 24) & 0x3) {
> > +		case 1:	/* I/O space */
> > +#ifdef CONFIG_PPC32
> > +			/*
> > +			 * check from ppc32 pci implementation.
> > +			 * not sure if it is needed. -vitb
> > +			 */
> > +			if (pci_addr !=3D 0)
> > +				break;
> > +#endif
> > +			/* limit I/O space to 16MB */
> > +			if (size > 0x01000000)
> > +				size =3D 0x01000000;
> > +
> > +			hose->io_base_phys =3D cpu_phys_addr -
> > pci_addr;
> > +			/* handle from 0 to top of I/O window */
> > +#ifdef CONFIG_PPC64
> > +			hose->pci_io_size =3D pci_addr + size;
> > +#endif
> > +			hose->io_base_virt =3D
> > ioremap(hose->io_base_phys, size); +
> > +			if (prim)
> > +				isa_io_base =3D (unsigned
> > long)hose->io_base_virt;
>=20
> The old 64-bit versions don't presently ioremap() or set isa_io_base.
> I'd be worried about changing this semantic, at least without a rather
> more widespread consolidation of the 32/64 bit PCI code.
>=20
Will ifdef it out.
> > +
> > +			res =3D &hose->io_resource;
> > +			res->flags =3D IORESOURCE_IO;
[snip]
--=20
Sincerely, Vitaly
