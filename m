Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: check crash_base for relocatable kernel
From: Michael Ellerman <michael@ellerman.id.au>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <f378ca9151a64ea3cead1b7354e8153c@bga.com>
References: <kexec-29-1-7.miltonm@bga.com> <1231285442.8292.10.camel@localhost>
	<f378ca9151a64ea3cead1b7354e8153c@bga.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-ei1B4Pbj01XjDAXLlbNQ"
Date: Thu, 08 Jan 2009 14:35:42 +1100
Message-Id: <1231385742.8294.31.camel@localhost>
Mime-Version: 1.0
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ei1B4Pbj01XjDAXLlbNQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 08:57 -0600, Milton Miller wrote:
> [removed Paul from cc and fixed Mohan's email]
>=20
> On Jan 6, 2009, at 5:44 PM, Michael Ellerman wrote:
>=20
> > On Fri, 2009-01-02 at 14:46 -0600, Milton Miller wrote:
> >> @@ -94,10 +95,35 @@ void __init reserve_crashkernel(void)
> >>  				KDUMP_KERNELBASE);
> >>
> >>  	crashk_res.start =3D KDUMP_KERNELBASE;
> >> +#else
> >> +	if (!crashk_res.start) {
> >> +		/*
> >> +		 * unspecified address, choose a region of specified size
> >> +		 * can overlap with initrd (ignoring corruption when retained)
> >> +		 * ppc64 requires kernel and some stacks to be in first segemnt
> >> +		 */
> >> +		crashk_res.start =3D KDUMP_KERNELBASE;
> >> +	}
> >> +
> >> +	crash_base =3D PAGE_ALIGN(crashk_res.start);
> >> +	if (crash_base !=3D crashk_res.start) {
> >> +		printk("Crash kernel base must be aligned to 0x%lx\n",
> >> +				PAGE_SIZE);
> >> +		crashk_res.start =3D crash_base;
> >> +	}
> >> +
> >>  #endif
> >>  	crash_size =3D PAGE_ALIGN(crash_size);
> >>  	crashk_res.end =3D crashk_res.start + crash_size - 1;
> >>
> >> +	/* The crash region must not overlap the current kernel */
> >> +	if (overlaps_crashkernel(__pa(_stext), _end - _stext)) {
> >> +		printk(KERN_WARNING
> >> +			"Crash kernel can not overlap current kernel\n");
> >> +		crashk_res.start =3D crashk_res.end =3D 0;
> >> +		return;
> >> +	}
> >
> > I think we can be smarter here. Why don't we adjust the crash kernel
> > region so that it doesn't overlap the first kernel? ie. move it up a
> > bit.
>=20
> How much?   In addition to the size of the kernel, we have to allocate=20
> (1) the emergeency stacks as we use them to bring up secondary cpus (2)=20
> the irq stacks in the first segment.   While the second could be met=20
> easier on systems with 1TB slbs we don't take advantage of that yet.

Hmm, we could try and work it out though. I guess we don't know how many
CPUs we have at that point, which makes it a little trickier.

So we have the emergency stack and the hard & soft irq stacks per cpu,
which is 48KB AFAICT. So for a 256-way system that would be 12MB.

I don't think I've seen an RMO smaller than 128MB, though I notice our
RPA note specifies 64M as the minimum we'll accept. That would probably
be a bit tight.

How about something like:

min_space =3D _end + 16MB		(16 to be safe?)

if min_space < rmo_size / 2:
	min_space =3D rmo_size / 2

if crash_base < min_space:
	crash_base =3D min_space

> > There's also the issue of the RMO, I'm not sure what we should do=20
> > there,
> > but I think the kernel needs some smarts otherwise users are going to
> > shoot themselves in the foot.
>=20
> I was looking at the code in kexec-tools for the rmo, and it seems=20
> extremely broken (ie it sets rmo_top on every memory block instead of=20
> the lowest; the clamp to 768M is the savior for systems with multiple=20
> blocks).

Oh surprise.

> Do we care about loading a kernel below a relocated kernel (between the=20
> interrupt vectors and the new kernel)?   I ignored that for now,=20
> arguing that we always run the first kernel at 0.

No I don't think so.

> > We could ignore the @x setting and split the RMO between both kernels
> > somewhat intelligently.
> >
> > What might work is multiple crash regions, that way we could have some
> > space in the RMO for the second kernel (say 32MB?), but the rest=20
> > outside
> > - leaving some RMO for the first kernel. But I think that would require
> > some serious surgery.
> >
>=20
> Other archs have this, i guess because they read the memory out of=20
> /proc/iomem.   The trick is knowing what has to be put in real space=20
> and what can go abvoe the rmo.   Also, we have those horrible hard-code=20
> rmo to 768M max because some platform (one of the cell ones?) didn't=20
> make the device tree to show it.  Maybe we can track it down and add=20
> linux,usable-mem-ranges to fix it up?

Dunno about the cell, but some of the early blades did have crufty
firmware.

> Does the generic code support loading into the split regions, or is it=20
> just for giving the kernel room to run?

I don't think so. I don't see any logic that deals with gaps in the
crashk region.

> So while all of these are nice, what do you think about merging this as=20
> an interm measure, especially for backporting to 2.6.28 stable (and any=20
> distro that wants to pick up relocatable kdump)?

I guess. I'd rather do something smarter, like I suggested above.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ei1B4Pbj01XjDAXLlbNQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklldI4ACgkQdSjSd0sB4dK7HQCfVDlZejJGWzUNY/zKc0ro0XCD
dbsAn3uFwzuYr3uexrqNjotqjSPxCQDL
=lqY4
-----END PGP SIGNATURE-----

--=-ei1B4Pbj01XjDAXLlbNQ--
