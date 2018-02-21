Return-Path: <j.neuschaefer@gmx.net>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmgFQ5c3bzF12q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 01:42:49 +1100 (AEDT)
Date: Wed, 21 Feb 2018 15:42:40 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 0/6] DISCONTIGMEM support for PPC32
Message-ID: <20180221144240.pfu2run3pixt3pzo@latitude>
References: <20180220161424.5421-1-j.neuschaefer@gmx.net>
 <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sj7gzac6guuidn6w"
In-Reply-To: <193a407d-e6b8-9e29-af47-3d401b6414a0@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sj7gzac6guuidn6w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 21, 2018 at 08:06:10AM +0100, Christophe LEROY wrote:
>=20
>=20
> Le 20/02/2018 =C3=A0 17:14, Jonathan Neusch=C3=A4fer a =C3=A9crit=C2=A0:
> > This patchset adds support for DISCONTIGMEM on 32-bit PowerPC. This is
> > required to properly support the Nintendo Wii's memory layout, in which
> > there are two blocks of RAM and MMIO in the middle.
> >=20
> > Previously, this memory layout was handled by code that joins the two
> > RAM blocks into one, reserves the MMIO hole, and permits allocations of
> > reserved memory in ioremap. This hack didn't work with resource-based
> > allocation (as used for example in the GPIO driver for Wii[1]), however.
> >=20
> > After this patchset, users of the Wii can either select CONFIG_FLATMEM
> > to get the old behaviour, or CONFIG_DISCONTIGMEM to get the new
> > behaviour.
>=20
> My question might me stupid, as I don't know PCC64 in deep, but when look=
ing
> at page_is_ram() in arch/powerpc/mm/mem.c, I have the feeling the PPC64
> implements ram by blocks. Isn't it what you are trying to achieve ? Would=
n't
> it be feasible to map to what's done in PPC64 for PPC32 ?

Using page_is_ram in __ioremap_caller and the same memblock-based
approach that's used on PPC64 on PPC32 *should* work, but I think due to
the following line in initmem_init, it won't:

	memblock_set_node(0, (phys_addr_t)ULLONG_MAX, &memblock.memory, 0);


Thanks,
Jonathan Neusch=C3=A4fer

--sj7gzac6guuidn6w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJajYVWAAoJEAgwRJqO81/bt2YQAJVWrBF/ocJJjhm+aS/UxJkD
QtVPunOENVzUa3TvGRkB+Snlik8tAon75OZBBj0OHllUqiLLVxzUC1OOz8wTzOdP
AFeBcN4KE+OV1iRlEoN6g42kPs+b9pHWnVnWDnLIdPGpUJxkDIoPV1AnhKjdiNMu
2X2ri0/aGzFYFBB8je9vV3b9rD9HVkUgDa4UjC01gVL5J+dX0qlPJ/Qj3xLzIFsf
TFkIQbeU2yuOWxdVk5ngI6J1tW+bzIklqk8ptwtvBMVysU7j4b1Zvx8xu2tZjhmu
F1/QNOZlcQAQdKvRJn+3O8wUyl3dseD/wXHHZkfeQi1bHnCNRWl7+peiNIdNlfWj
FneQf7NFENHRHdnblhmYkJuFNIIjJU/K5dFc4UMuYwOMwtyNSdQqnHfCwYRmjOq/
HynUlOiOSEok411GuOCtd+y2SmTsmdoSB7fqqIZTIrqlqqDUsmAdu/f0WNuPqG2t
yCrm/+8hrmylwloqWK+kQCpcRSkN90dHwQE/ZWiPDsI59qCdMdJSnfFYFbbgzbbK
br2sNx1YHXkwDPqkKLCI9gymCgO4BWJGeevuH4gJbfehBGC9+b2Oij5uP9plM4HC
QPATH4CmOZH7RbBrOaunuHtuva26VpX8f5+IVGzx+ilKFuaBPucsquoDFJu7/SmJ
LBIs6ol1cb/jr268Wlfl
=vWFI
-----END PGP SIGNATURE-----

--sj7gzac6guuidn6w--
