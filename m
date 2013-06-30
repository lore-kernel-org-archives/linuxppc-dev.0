Return-Path: <haokexin@gmail.com>
Received: from mail-pb0-x232.google.com (mail-pb0-x232.google.com
 [IPv6:2607:f8b0:400e:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3EACC2C02AF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 17:34:28 +1000 (EST)
Received: by mail-pb0-f50.google.com with SMTP id wz7so3732025pbc.37
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 00:34:25 -0700 (PDT)
Date: Sun, 30 Jun 2013 15:34:15 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: enable the relocatable support for the fsl
 booke 32bit kernel
Message-ID: <20130630073415.GB32268@pek-khao-d1.corp.ad.wrs.com>
References: <1372298434-20220-2-git-send-email-haokexin@gmail.com>
 <1372363114.8183.54@snotra>
 <20130628013637.GA3173@pek-khao-d1.corp.ad.wrs.com>
 <1372384340.8183.62@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <1372384340.8183.62@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2013 at 08:52:20PM -0500, Scott Wood wrote:
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
> 0xc0000000 is 1G-aligned, so I don't see why 256M is the maximum
> (after verifying that enough memory is present with the right
> alignment, of course).  The TLB1 savings would probably not be
> enough to justify figuring that out, though.

Sorry, I didn't make myself clear. Yes, the 0xc0000000 is 1G-aligned.
For a 32bit kernel we only have a 1G memory region for the kernel space,
but we can't use all of it for direct map. So we always set the
__max_low_memory to 0x30000000. And for e500 core, it doesn't support
512M page size. So the 256M is the max page size we can use for a
32bit kernel. And since we always cover the boot code in the first
tlb entry, we then use the 256M as the alignment value for the
relocatable kernel.

Thanks,
Kevin

>=20
> -Scott

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRz993AAoJEJNY7TDerrFxgz8H/2FtlcQlXVC9Twyu5Sg/UlnV
xJWpc7OAKtwha4nhs9xq/442Mi9/C5TyRlLO11kdoWvlOEtGGNhA8/MQTHLYDU0H
izSolzeNJ09j1AUoHwyIZTsBdvqCktT+0SCur8myZVuKV9zRmzXpJ2zncTAXj4+o
2LFn+yUY38A7igJgC13ymrG/Wn/vY8L7ztH0K0rDkn/eWEdar8Op7J5y8GKAn/jh
8Vg2EQGBAB9wKEnkTJ+kizxfiJpNEGIFKeK17kLyEvIcUU71/VSGFSNlq2Z3W98/
grYGswZAcKL7VISofGlrNLNTXbY+6og9xzeYz8qrOegiswpoPE3dF4kYyWpjwu0=
=zxxL
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
