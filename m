Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x234.google.com (mail-pd0-x234.google.com
 [IPv6:2607:f8b0:400e:c02::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D2B0B2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Aug 2013 10:38:26 +1000 (EST)
Received: by mail-pd0-f180.google.com with SMTP id 15so1928039pdi.25
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Aug 2013 17:38:24 -0700 (PDT)
Date: Sun, 4 Aug 2013 08:38:11 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 3/8] powerpc: enable the relocatable support for the
 fsl booke 32bit kernel
Message-ID: <20130804003811.GB19141@pek-khao-d1.corp.ad.wrs.com>
References: <1372942454-25191-4-git-send-email-haokexin@gmail.com>
 <1374881326.30721.37@snotra>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
In-Reply-To: <1374881326.30721.37@snotra>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 26, 2013 at 06:28:46PM -0500, Scott Wood wrote:
> On 07/04/2013 07:54:09 AM, Kevin Hao wrote:
> >This is based on the codes in the head_44x.S. Since we always align to
> >256M before mapping the PAGE_OFFSET for a relocatable kernel, we also
> >change the init tlb map to 256M size.
> >
> >Signed-off-by: Kevin Hao <haokexin@gmail.com>
> >---
> >v2: Move the code to set kernstart_addr and virt_phys_offset to a
> >c function.
> >    So we can expand it easily later.
> >
> >Hi Scott,
> >
> >I still use the 256M align for the init tlb as in v1 for the
> >following reasons:
> >  * This should be the most possible case in reality.
>=20
> There is no "most possible case".  It's either possible (and
> supported) or not.  And having less than 256M is definitely
> possible.  The 8540 reference board has 64M.
>=20
> AMP scenarios that start on a 64M-aligned but not 256M-aligned
> address are also something I've done.
>=20
> >  * This is just for very early booting code and should not be a
> >big issue
> >    if the first tlb entry shrink to a less size later.
>=20
> "We can probably get away with it most of the time" is not a very
> good justification.  What's wrong with the suggestion I made last
> time, of basing the size on the alignment of the address?

OK, I will use the 64M align.

>=20
> >+	/*
> >+	 * We have the runtime (virutal) address of our base.
> >+	 * We calculate our shift of offset from a 256M page.
> >+	 * We could map the 256M page we belong to at PAGE_OFFSET and
> >+	 * get going from there.
> >+	 */
> >+	lis	r4,KERNELBASE@h
> >+	ori	r4,r4,KERNELBASE@l
> >+	rlwinm	r6,r25,0,0xfffffff		/* r6 =3D PHYS_START % 256M */
> >+	rlwinm	r5,r4,0,0xfffffff		/* r5 =3D KERNELBASE % 256M */
> >+	subf	r3,r5,r6			/* r3 =3D r6 - r5 */
> >+	add	r3,r4,r3			/* Required Virutal Address */
>=20
> s/Virutal/Virtual/

Fixed.

Thanks,
Kevin
>=20
> -Scott

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJR/aJzAAoJEJNY7TDerrFxyRsH/1BR+gmzmD1+XxnSQ3ghJ7gm
XulMzV/eqYnN4lj6QU7iHe4Uw0ez6LLFJ2FWhNEVMOq4NLzgvJnKAXQFiWPAgOxy
tZI2+5J5iBRR2FUumnqvbCMEbIjlEYkDSn+98ttj5qe4fOy+Fypdfu0ZbW4WNPoH
SzsBktQi/kaQbPRuC1cr5YVwDWr7JnEYkYAWtwOzuh174H2FqMsJk3Oipix3HgGW
Ng0QEHx2B5pusgV9BdSMJ+G47IbjS9iyZoZ3e2mCaZhnDp2t5R2bZtlf9MWM7B/d
m/qW5NqrSn+Mfv0VFxdAsFmLNBziSDxYh7sL870RgqJjxRh5PdAZwkfADKVrhxc=
=mDfp
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
