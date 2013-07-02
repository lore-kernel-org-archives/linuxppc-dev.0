Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x232.google.com (mail-pb0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A6CC12C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 13:24:59 +1000 (EST)
Received: by mail-pb0-f50.google.com with SMTP id wz7so5616620pbc.37
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jul 2013 20:24:57 -0700 (PDT)
Date: Tue, 2 Jul 2013 11:24:47 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20130702032447.GA26391@pek-khao-d1.corp.ad.wrs.com>
References: <20130630073310.GA32268@pek-khao-d1.corp.ad.wrs.com>
 <1372725045.8183.102@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <1372725045.8183.102@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2013 at 07:30:45PM -0500, Scott Wood wrote:
> On 06/30/2013 02:33:10 AM, Kevin Hao wrote:
> >On Thu, Jun 27, 2013 at 08:47:27PM -0500, Scott Wood wrote:
> >> On 06/27/2013 08:36:37 PM, Kevin Hao wrote:
> >> >On Thu, Jun 27, 2013 at 02:58:34PM -0500, Scott Wood wrote:
> >> >> On 06/26/2013 09:00:33 PM, Kevin Hao wrote:
> >> >> >This is based on the codes in the head_44x.S. Since we always
> >> >align to
> >> >> >256M before mapping the PAGE_OFFSET for a relocatable kernel,
> >> >we also
> >> >> >change the init tlb map to 256M size.
> >> >>
> >> >> Why 256M?
> >> >
> >> >For two reasons:
> >> >  1. This is the size which both e500v1 and e500v2 support.
> >> >  2. Since we always use the PAGE_OFFSET as 0xc0000000, the 256M is
> >> >     max alignment value we can use for this virtual address.
> >>
> >> Is there any reason why 64M won't continue to work here?
> >
> >Yes. In general we would map the 0 ~ 256M memory region in the first
> >tlb1 entry. If we align to 64M, the relocatable kernel would not work
> >if loaded above 64M memory. For example, if we load a relocatable
> >kernel
> >at 64M memory, we will relocate it as:
> >	__pa(PAGE_OFFSET) =3D 0x4000000
> >
> >But in map_mem_in_cams function, it will create a memory map as:
> >	__pa(PAGE_OFFSET) =3D 0x0
> >
> >The kernel will definitely not work in this case.
>=20
> That's a problem with map_mem_in_cams(), as discussed in the thread
> on other patch.  Perhaps fully solving those problems is not
> worthwhile at this time, but we should at least be able to determine
> the TLB size automatically based on the alignment of the address
> you're trying to map.  64M would be used unless (address & (256M -
> 1)) >=3D 64M.  I hope we can continue to assume the kernel won't cross
> a 64M boundary.

No. The problem is we don't know the physical address of the start of
lowmem at booting. So we have to align to physical address (phys1) blindly
and map the PAGE_OFFSET from there. Then once we get the physical address
(phys2) of the start of lowmem from the device tree later, we will map the
PAGE_OFFSET to the start of lowmem. If the phys1 is not equal to phys2,
we get a problem. The reasons that we can't still map the PAGE_OFFSET to
phys1 in the map_mem_in_cams() are:
  * if phys1 > phys2, then this will waste the memory between phys2 ~ phys1.
  * if phys1 < phys2, then we map a memory region which don't belong to
    this kernel.
=20
>=20
> >> >> This tightens the alignment requirement for dynamic memstart.
> >> >
> >> >Yes. But since RELOCATABLE is a superset of DYNAMIC_MEMSTART, we
> >> >can always
> >> >use RELOCATABLE instead of DYNAMIC_MEMSTART for fsl booke board in
> >> >any cases.
> >>
> >> The extra flexibility of RELOCATABLE may help some use cases, but
> >> you'd still require the entire 256M naturally aligned region
> >> containing the kernel to be present and owned by this instance of
> >> Linux.
> >>
> >> >So DYNAMIC_MEMSTART will seem not so useful after we enable this
> >> >feature.
> >>
> >> Then why doesn't this patch remove it?
> >
> >According to the Kconfig it is still used by 44x.
>=20
> RELOCATABLE appears to be supported on 44x, and is what CRASH_DUMP
> uses on 44x.

The kdump kernel on 44x also use the RELOCATABLE method.

>=20
> >And maybe someone still want to use this relocation method.
>=20
> Then you don't get to dismiss claims that you're changing
> DYNAMIC_MEMSTART alignment requirements by saying that RELOCATABLE
> is a strict superset. :-)  Given the requirement that the kernel be
> in the first TLB entry, though, using RELOCATABLE rather than
> DYNAMIC_MEMSTART doesn't fix the alignment problem.
>=20
> I don't think it makes sense to keep both mechanisms around unless
> there's some obvious reason to prefer DYNAMIC_MEMSTART.

The DYNAMIC_MEMSTART still can be used for such as AMP kernel. It does have
a more small footprint than RELOCATABLE and also doesn't have the overhead
of the relocation. So I don't want to drop it in a rush.

Thanks,
Kevin

>=20
> >> >>  And
> >> >> what about boards with less than 256 MiB of RAM?
> >> >
> >> >It should be fine. We just create the map in the tlb. The MM
> >still use
> >> >the real size of memory.
> >>
> >> No, you must not map anything that is not present with a mapping
> >> that is executable and/or not guarded, or you could get speculative
> >> accesses to who-knows-what.
> >
> >Yes, there may be speculative access in this case.
> >
> >>  Even if RAM is present there but owned
> >> by some other entity, you could be creating illegal aliases if that
> >> other entity mapped it cache-inhibited or similar.
> >
> >Fair enough. So it seems error prone if we map this 256M memory region
> >blindly. But if we don't do this, it seems that we have to do
> >twice relocation.
> >The first time we just align to a predefined value (64M for
> >example), and
> >then parse the device tree and get the real memstart_addr. After
> >that we
> >should relocate the kernel to the real start address. It seems a
> >little
> >complicated. Do you have any better ideas?
>=20
> This seems like the proper way to address it, assuming we're
> unwilling to map the kernel image somewhere other than the normal
> lowmem mapping (and I think we're unwilling, given how tight the
> address space is on 32-bit, and the intrusiveness of the change).
> The dynamic determination of 64M versus 256M could be an acceptable
> alternative though, if we're OK with not supporting arbitrary
> relocatable scenarios, but just those that are either needed by
> kdump, or supported by current kernels (with DYNAMIC_MEMSTART, or
> just starting at zero with less than 256M of RAM).  If we go that
> route, the limitations should be documented.
>=20
> -Scott

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR0kf/AAoJEJNY7TDerrFxYCUH/RL6pKgDSTGxh2sBNkasd/Xi
lR8uSc8/sqVZboF/puihlvq8JIczrpsbZoXBD2C44SiLJdXJL5L5AJHbXzo/WRrL
5jf5bfvoXyU6vpXMVThvkgQyAo3cA6PgzcApzC0MTFoPCKi7T8M9mx2ka0SNGkPi
hy/UKVzxkfaS700uM7QrK4z2c00JNUgvLD0LSVT8qEEolaJ165HQ9t6wtpWO6R2f
uJzOzaf04Ik2FpMBvGY7A+mad8afo9H9hN4OqGW37QvG4z8cwQUB72m11AM12jVf
bUfuW20QUeG7hciRtZzpEIQ3ivzEy3VAY9DNCmf2CfBeQcbIQDPW18aM3AYnZoc=
=G8kB
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
