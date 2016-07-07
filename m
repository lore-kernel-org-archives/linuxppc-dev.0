Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlPxR1tVJzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jul 2016 14:37:47 +1000 (AEST)
Date: Thu, 7 Jul 2016 14:38:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] spapr: Disable ibm, pa-features HTM bit
Message-ID: <20160707043808.GP14675@voom.fritz.box>
References: <cover.1467783317.git.sam.bobroff@au1.ibm.com>
 <70a13eeab01913de030d9848aaea04a6acea37b4.1467783317.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iq/fWD14IMVFWBCD"
In-Reply-To: <70a13eeab01913de030d9848aaea04a6acea37b4.1467783317.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iq/fWD14IMVFWBCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2016 at 03:35:21PM +1000, Sam Bobroff wrote:
> There are a few issues with our handling of the ibm,pa-features
> HTM bit:
>=20
> - We don't support transactional memory in PR KVM, so don't tell
>   the OS that we do.
>=20
> - In full emulation we have a minimal implementation of HTM that always
>   fails, so for performance reasons lets not tell the OS that we
>   support it either.
>=20
> - In HV KVM mode, we should mirror the host HTM enabled state by
>   checking a KVM capability or looking at the AT_HWCAP2 bit.
>=20
> For now unconditionally disable it by removing HTM from the
> pa-features bits.  It will be re-enabled in a subsequent patch
> specifically for HV KVM.
>=20
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

But I won't merge it until the rest of the series is ready to go.


> ---
>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 78ebd9e..704aae7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -635,7 +635,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void =
*fdt, int offset,
>          0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
>          0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
>          0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
> -        0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
> +        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
>      uint8_t *pa_features;
>      size_t pa_size;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iq/fWD14IMVFWBCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXfdywAAoJEGw4ysog2bOSbeYP/jVhIbvouYvtuudyx5rRhxBG
Yw44vSnjFCeWhg/HV1nbe3/XJ/E8Hi80mrJhwg+X9wkDHW1kpjOTLALCiooUoMng
AMV9E7lvK8cOyCnDpKlYFr0mr3kMqTd3RIAHBpTHefFNpC3XgfAtZqDklHkAjssg
p4J49IaPfJ+PyKDVB+vQ+0af0rs75BlhTDFHvt8qgcn7F35rP7cUpuBZwxSda0tj
bTy0VIsYnvpDvpxApwNSy6SoX7VUv/jIKwYAiK5Re3M7vqeSmslTK+jb3Qr/cvRU
EmJyMLua3P+F8tmkLUam3hmhOBlY9hOIcrt/J0+ge6vUod7atjPkNtjSAi/+0SEb
TtfYG/zcfnVXwLwofgrVQ941TIGUSNUZA0InTzqkjRyLXbwLRn1vqskfGqqs4T8/
kxkcGfmjjbK0R8DWOIPqj7d8ORw0pItvsdMGMKtuXrrQM4oAv0X6NnqLy7xdYqjU
dhlFXlJqqVlesi+ysOMNKS0UrOu4moaWyFPfRmuZUSwJNlHqoS6WZoJMT/xfavjr
QkqKFaF3XMasU2BUIZTNXWBrUZ9XJG6U2Ov54yzkki6KPtD5TFmBPW8YfRsLBMnC
neOFoCQBs6Jkt68WwhNh46mvC4WLesimEklQrl3hRPuhA/YAEdHsjpnBb9Cu2j5+
J25zvOHoaHPccyMAd2Ma
=JCS5
-----END PGP SIGNATURE-----

--iq/fWD14IMVFWBCD--
