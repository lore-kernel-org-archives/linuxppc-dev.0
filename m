Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs4140Z40zDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 17:31:20 +1100 (AEDT)
Date: Mon, 27 Mar 2017 15:25:17 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel] KVM: PPC: Check kzalloc() return
Message-ID: <20170327042517.GV19078@umbus.fritz.box>
References: <20170327031927.18572-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+1d8mk/W7pQzMfc7"
In-Reply-To: <20170327031927.18572-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+1d8mk/W7pQzMfc7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 02:19:27PM +1100, Alexey Kardashevskiy wrote:
> This adds missing check for failed kzalloc().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> This is a followup change for:
> [PATCH kernel v11 10/10] KVM: PPC: VFIO: Add in-kernel acceleration for V=
FIO
>=20
> Please squash it. Thanks!
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_6=
4_vio.c
> index 22c67a47eaab..c3d8a88f1f4e 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -212,6 +212,11 @@ extern long kvm_spapr_tce_attach_iommu_group(struct =
kvm *kvm, int tablefd,
>  	}
> =20
>  	stit =3D kzalloc(sizeof(*stit), GFP_KERNEL);
> +	if (!stit) {
> +		iommu_tce_table_put(tbl);
> +		return -ENOMEM;
> +	}
> +
>  	stit->tbl =3D tbl;
>  	kref_init(&stit->kref);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+1d8mk/W7pQzMfc7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2JQtAAoJEGw4ysog2bOSEWcP/RG2OCAunTQM532IHvRhGgSn
MOFP+Bselm1WfIconCW3Ha+KLBkiSMvKscmojxk5N5vAK3tomkp5CUlevQPnkXDn
rEseTNnCeKL6JKLYfS+UHS5GQ9rcVC2D2s2wveC/o8tXVeMPFT9YRY4tNpiiCkPQ
CNeXWWAFBGxS4TkJYCF+huX/dVFAhobPFb3qub07EusabyuapURqiJfZO3KAM2pW
J7RAaqNn650ImtvQ2dPVZCfWexGMx5AoiRCq0PCRQl+eLUR0gZ52SX1qWL5G09Hw
opKsq+MIOzxRkzWEIbWUj1kRRt79o5JO0a3iqaivVZtay9FUCAddp8b6l9P7lzNF
zogjZK/Nr5BfoPEgqHWFausQ1+mQvLkr6nwbGS6puUAtySwAvzm3BE41iSuEVV0l
SdRewAcWHvFFqvxwTTB0NpscxMic93XLhKolb7qg2PYkdwkTsXumZmaM8mgrhNwk
sCoNoM8eHojDxq1TU31mwYic7F928MvC3UB1XQX4OPskUOTgM/A4OO4LcAHPX7mv
OONB5HFtfEEvXT4RQPXLL4CIx+uA8vMQvP0bRNcb12DsWIGAnV+HHdyp9Qea09X9
6I/Lh0H3x8WRWvDPwDmXHXdvcCIeqCnxBV2Zqk+9a/9Ys/wNaf7ZgFsNe8eSanCL
AUfBBJv2lM2/IQfW2tEh
=nxF0
-----END PGP SIGNATURE-----

--+1d8mk/W7pQzMfc7--
