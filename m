Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vmlMb4y70zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 16:47:23 +1100 (AEDT)
Date: Mon, 20 Mar 2017 15:20:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] KVM: PPC: Book3S HV: check for kmalloc errors in ioctl
Message-ID: <20170320042047.GA29814@umbus.fritz.box>
References: <20170317204113.GA16505@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
In-Reply-To: <20170317204113.GA16505@mwanda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 17, 2017 at 11:41:14PM +0300, Dan Carpenter wrote:
> kzalloc() won't actually fail because sizeof(*resize) is small, but
> static checkers complain.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Oops, that's an embarrassing mistake.

Acked-by: David Gibson <david@gibson.dropbear.id.au>

>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3=
s_64_mmu_hv.c
> index 8c68145ba1bd..710e491206ed 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1487,6 +1487,10 @@ long kvm_vm_ioctl_resize_hpt_prepare(struct kvm *k=
vm,
>  	/* start new resize */
> =20
>  	resize =3D kzalloc(sizeof(*resize), GFP_KERNEL);
> +	if (!resize) {
> +		ret =3D -ENOMEM;
> +		goto out;
> +	}
>  	resize->order =3D shift;
>  	resize->kvm =3D kvm;
>  	INIT_WORK(&resize->work, resize_hpt_prepare_work);
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYz1ifAAoJEGw4ysog2bOSOK4P/0zlK94qbq9Gv7yTILBz1WJ8
kstXaRRN1Es1UoJrfoNqT8eTO5L6/l5nAepFs8T4TL5FdrdcGA3YNEvs2jyxHFQA
Ehqe1dS6yJiABrjdJnv+aqjJSzKUAhGSlncv/Bywi5TJuo5va2GcTj1+sMgjHz4T
ZUA59A6CAx5OLprilsEQR+/RHFt6ChcZoZAA8eSt7MQtuWm8L1GvtRYuoA00Wzzf
CYrn8e3Tm/qwQSLeLMc+7YJvAh74k9EY5mFrLTOC9YpPePZT6Z9vipdaOwaKki1+
V3c7jZ74GM7wFMh5wRxMThz4UcYpQZ7ShR/GUEZ89wVXSqkAPKsIzXSw3Izsmmu0
YaldZoyvRyAOz+RDWth3r6TVbblfXnq1m5StsK4vF6CFsQ6P/yC5LYrfmOX04zXn
VtDiBRnMAhkM2zfH0llba0gpTJVnsL6GbHNzEfhfWMzeZCzIYfcYfq/eLhKF4SIJ
hHU09X/2uWd5o7lELP6oBc+aKDXHhhRlyx9TCAvaSOl+pQa91q9ABPxP35uHVstY
t+O4XDvwbjiysYEcI50u2Qj5qaGOHGBdjSzprw7fApAeL6j2L0r3VNFQrKoa3vjx
9rvVYyZR+59HGs53v1SVJJ817N8bUYUeZRa+lDw+IaKM1pQxK4Cv+QsXupgzZvKB
rBtMakb+vnjLOBVQpncH
=1Kzi
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
