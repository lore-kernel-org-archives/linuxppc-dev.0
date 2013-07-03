Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E8E82C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jul 2013 13:00:57 +1000 (EST)
Received: by mail-pd0-f181.google.com with SMTP id 14so4149827pdj.26
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jul 2013 20:00:54 -0700 (PDT)
Date: Wed, 3 Jul 2013 11:00:44 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20130703030044.GA25190@pek-khao-d1.corp.ad.wrs.com>
References: <20130702032447.GA26391@pek-khao-d1.corp.ad.wrs.com>
 <1372804758.8183.124@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <1372804758.8183.124@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2013 at 05:39:18PM -0500, Scott Wood wrote:
> On 07/01/2013 10:24:47 PM, Kevin Hao wrote:
> >On Mon, Jul 01, 2013 at 07:30:45PM -0500, Scott Wood wrote:
> >> On 06/30/2013 02:33:10 AM, Kevin Hao wrote:
> >> >On Thu, Jun 27, 2013 at 08:47:27PM -0500, Scott Wood wrote:
> >> >> On 06/27/2013 08:36:37 PM, Kevin Hao wrote:
> >> >> >On Thu, Jun 27, 2013 at 02:58:34PM -0500, Scott Wood wrote:
> >> >> >> On 06/26/2013 09:00:33 PM, Kevin Hao wrote:
> >> >> >> >This is based on the codes in the head_44x.S. Since we always
> >> >> >align to
> >> >> >> >256M before mapping the PAGE_OFFSET for a relocatable kernel,
> >> >> >we also
> >> >> >> >change the init tlb map to 256M size.
> >> >> >>
> >> >> >> Why 256M?
> >> >> >
> >> >> >For two reasons:
> >> >> >  1. This is the size which both e500v1 and e500v2 support.
> >> >> >  2. Since we always use the PAGE_OFFSET as 0xc0000000, the
> >256M is
> >> >> >     max alignment value we can use for this virtual address.
> >> >>
> >> >> Is there any reason why 64M won't continue to work here?
> >> >
> >> >Yes. In general we would map the 0 ~ 256M memory region in the
> >first
> >> >tlb1 entry. If we align to 64M, the relocatable kernel would
> >not work
> >> >if loaded above 64M memory. For example, if we load a relocatable
> >> >kernel
> >> >at 64M memory, we will relocate it as:
> >> >	__pa(PAGE_OFFSET) =3D 0x4000000
> >> >
> >> >But in map_mem_in_cams function, it will create a memory map as:
> >> >	__pa(PAGE_OFFSET) =3D 0x0
> >> >
> >> >The kernel will definitely not work in this case.
> >>
> >> That's a problem with map_mem_in_cams(), as discussed in the thread
> >> on other patch.  Perhaps fully solving those problems is not
> >> worthwhile at this time, but we should at least be able to determine
> >> the TLB size automatically based on the alignment of the address
> >> you're trying to map.  64M would be used unless (address & (256M -
> >> 1)) >=3D 64M.  I hope we can continue to assume the kernel won't cross
> >> a 64M boundary.
> >
> >No. The problem is we don't know the physical address of the start of
> >lowmem at booting. So we have to align to physical address (phys1)
> >blindly
> >and map the PAGE_OFFSET from there. Then once we get the physical
> >address
> >(phys2) of the start of lowmem from the device tree later, we will
> >map the
> >PAGE_OFFSET to the start of lowmem. If the phys1 is not equal to
> >phys2,
> >we get a problem.
>=20
> How would you get phys1 !=3D phys2, unless the kernel begins in a
> 256M-aligned region other than the first (which you said is already
> not supported)?

Yes, this is the only case which phys1 !=3D phys2 if we align to 256M.
I plan to also fix this in the next version.

>=20
> If (phys1 & (256M - 1)) < 64M, then you'd get the same phys2
> regardless of whether you align it to 64M or 256M.
> Otherwise, we use a 256M page which is what you're already doing.

Yes, you are right. I am just trying to say we will run into problem
when loading a kernel between 64M ~ 256M if we don't align to 256M.

>=20
> >> >And maybe someone still want to use this relocation method.
> >>
> >> Then you don't get to dismiss claims that you're changing
> >> DYNAMIC_MEMSTART alignment requirements by saying that RELOCATABLE
> >> is a strict superset. :-)  Given the requirement that the kernel be
> >> in the first TLB entry, though, using RELOCATABLE rather than
> >> DYNAMIC_MEMSTART doesn't fix the alignment problem.
> >>
> >> I don't think it makes sense to keep both mechanisms around unless
> >> there's some obvious reason to prefer DYNAMIC_MEMSTART.
> >
> >The DYNAMIC_MEMSTART still can be used for such as AMP kernel. It
> >does have
> >a more small footprint than RELOCATABLE and also doesn't have the
> >overhead
> >of the relocation. So I don't want to drop it in a rush.
>=20
> How much overhead (space and time) is this really?

The following is the additional sections when relocatable is enabled for
a p2020rdb board.
   section        size
  .dynsym       000007f0
  .dynstr       00000926
  .dynamic      00000080
  .hash         00000388
  .interp       00000011
  .rela.dyn     00215250

The time for the relocation is about 32ms on a p2020rdb board.

>=20
> It will keep the code (and especially the diff) simpler to have this
> replace DYNAMIC_MEMSTART rather than add to it.

OK. If you think that the above overhead is acceptable, I can drop the
DYNAMIC_MEMSTART in the next version.

Thanks,
Kevin
>=20
> -Scott

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR05PcAAoJEJNY7TDerrFxoHQH/A5eh5HoP/c6mJlA1o9tUMh3
PM1vHeLeyop3wd+3NVbj6p2+6ecFVy0hK9yUieVErXnwA813GIGs6vRw7K1BHzf4
UnN3XjzIGNFkhfz7qTzYMRBulerD/w4lJNhbOojhLYhaYWKgWjsqYNdCitRyPkLR
RumG5oYXEUPweMwm2pEoxAEHLplhJIAgaZ+U63vD+sdJhxl1coAtYnGWojE+KFA5
t5+fN7kfeJz7uSmbvUvK2W9SmvSBSx9swvNuHyebSmEjnHJ2znpaBM4T5hboSXKD
MLK0uli2bmGJN3M4Zh6yeqTP9TYSo0dVINzftIxtTHC9iYpZECOBnjsFH9fI0N8=
=xLh/
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
