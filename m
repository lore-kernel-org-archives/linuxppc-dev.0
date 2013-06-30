Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 977E72C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 17:33:29 +1000 (EST)
Received: by mail-pa0-f44.google.com with SMTP id lj1so3928801pab.17
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 00:33:21 -0700 (PDT)
Date: Sun, 30 Jun 2013 15:33:10 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20130630073310.GA32268@pek-khao-d1.corp.ad.wrs.com>
References: <20130628013637.GA3173@pek-khao-d1.corp.ad.wrs.com>
 <1372384047.8183.61@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <1372384047.8183.61@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 08:47:27PM -0500, Scott Wood wrote:
> On 06/27/2013 08:36:37 PM, Kevin Hao wrote:
> >On Thu, Jun 27, 2013 at 02:58:34PM -0500, Scott Wood wrote:
> >> On 06/26/2013 09:00:33 PM, Kevin Hao wrote:
> >> >This is based on the codes in the head_44x.S. Since we always
> >align to
> >> >256M before mapping the PAGE_OFFSET for a relocatable kernel,
> >we also
> >> >change the init tlb map to 256M size.
> >>
> >> Why 256M?
> >
> >For two reasons:
> >  1. This is the size which both e500v1 and e500v2 support.
> >  2. Since we always use the PAGE_OFFSET as 0xc0000000, the 256M is
> >     max alignment value we can use for this virtual address.
>=20
> Is there any reason why 64M won't continue to work here?

Yes. In general we would map the 0 ~ 256M memory region in the first
tlb1 entry. If we align to 64M, the relocatable kernel would not work
if loaded above 64M memory. For example, if we load a relocatable kernel
at 64M memory, we will relocate it as:
	__pa(PAGE_OFFSET) =3D 0x4000000

But in map_mem_in_cams function, it will create a memory map as:
	__pa(PAGE_OFFSET) =3D 0x0

The kernel will definitely not work in this case.
=09
>=20
> >> This tightens the alignment requirement for dynamic memstart.
> >
> >Yes. But since RELOCATABLE is a superset of DYNAMIC_MEMSTART, we
> >can always
> >use RELOCATABLE instead of DYNAMIC_MEMSTART for fsl booke board in
> >any cases.
>=20
> The extra flexibility of RELOCATABLE may help some use cases, but
> you'd still require the entire 256M naturally aligned region
> containing the kernel to be present and owned by this instance of
> Linux.
>=20
> >So DYNAMIC_MEMSTART will seem not so useful after we enable this
> >feature.
>=20
> Then why doesn't this patch remove it?

According to the Kconfig it is still used by 44x. And maybe someone
still want to use this relocation method.

>=20
> >>  And
> >> what about boards with less than 256 MiB of RAM?
> >
> >It should be fine. We just create the map in the tlb. The MM still use
> >the real size of memory.
>=20
> No, you must not map anything that is not present with a mapping
> that is executable and/or not guarded, or you could get speculative
> accesses to who-knows-what.

Yes, there may be speculative access in this case.

>  Even if RAM is present there but owned
> by some other entity, you could be creating illegal aliases if that
> other entity mapped it cache-inhibited or similar.

Fair enough. So it seems error prone if we map this 256M memory region
blindly. But if we don't do this, it seems that we have to do twice relocat=
ion.
The first time we just align to a predefined value (64M for example), and
then parse the device tree and get the real memstart_addr. After that we
should relocate the kernel to the real start address. It seems a little
complicated. Do you have any better ideas?

Thanks,
Kevin


>=20
> -Scott

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRz982AAoJEJNY7TDerrFx1NkIAKG/OdsaBqNTKnZuAfB6f0NS
7lYoghPuHx9Tugk2TWA0+PFOq3AnOlilRypI13nqDc+bVYpf8h+PkmhDFbMiPLgv
X4ZJ0WGoXqWT2xy/6Lxm2Uy4ms7wz5jnog4hKTcORXSa+n1pKWGJWT0ZsSNYh0+9
vd6sjNEmRJhprJ4Go+yVy0tZzIL0y+hF/9EQkUG9RBuZOYnJWPSQ7XJeoDD0binW
umFX0OFo6jVB23fNldxvKFSoL3WT+YdUJwtuEWTyVsFaY0zT2mrEckLuGtaMs9fM
YnJZcNRLneiBMYuBgZ9HKI/8BAfQa3DRfVTCnZR3+4pBed/Adm0F0TFJYoRISBc=
=MEQv
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
