Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkCwk1PVCzDrnR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 16:03:02 +1000 (AEST)
Date: Tue, 5 Jul 2016 15:51:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: anton@au1.ibm.com, mikey@neuling.org, aik@ozlabs.ru, mpe@ellerman.id.au,
 agraf@suse.de, qemu-devel@nongnu.org, paulus@samba.org,
 qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] spapr: Disable ibm, pa-features HTM bit
Message-ID: <20160705055132.GK2251@voom.fritz.box>
References: <cover.1467695915.git.sam.bobroff@au1.ibm.com>
 <17cc8e9fb2ab41356e207c6a14d5987754fa4da8.1467695915.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="n83H03bbH672hrlY"
In-Reply-To: <17cc8e9fb2ab41356e207c6a14d5987754fa4da8.1467695915.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--n83H03bbH672hrlY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 05, 2016 at 03:19:22PM +1000, Sam Bobroff wrote:
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

I'll hold off on merging until the rest of the series is ready, though.

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

--n83H03bbH672hrlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXe0rkAAoJEGw4ysog2bOS57gQAMrxyrXxJR5s9YH/CS+E/4cp
q3Nj+Nhbu4Onat8i4bYGhuHdJ8Bqcl27IwvloefG0zvXjuvvZeUXPd69iSvhOQFq
6Nt3U2GSwIRywONFq4jomWqnpWR+0kfx6AWhvFIpMF934V5pvm4ihv9OHJYHV/Y5
K0xU3Mg3HS4SZu6fmDoXsk8WWWbz/VWf2gWHnv3RIdUzqcff1pHA8n3g2F1NJVkC
CTei8Y+kPfcZtqbqdoOCSrBPL/t4zmo4KJ+QtAACsiZiZP7v9XHhLa1Y5HjJjouL
hyjww0CvpRJhZRuUhOXAV5WrHqFdwzVzyKWwmA3IX0ItHwU1udJjfEBpFn/Hipsy
Azjci+C4dlgOL9304eisnwhXPr9I8SQPbbP8f2tc6IMrrBk2bhUuzxpbk8Mu2Wf1
kPX722xSJezqsL10rj+8WZ4ZISPTSx/Kgvz7mpmACxOJSrux7XCY64OOIIFuQZsy
CAsKMelSGIudM7cnwP46ggZFCeC9/T8zCvcSMj8T+Qll67J+cF6vHuW/fy3O/7K3
QpNFGY0asOncajiLhDW4Dk83Wy6Ig95laAXs2PyPaDnfhvPQPmjS9PyNQibz3IZ/
tZhBAE2IyDx7y5cVhyzdDyh/wSsOkhfkCMSwv5A9iiHEqtthBPc1eFkAxhGOMe35
tgTf4AqQkXiKks+qE8xP
=Xz6R
-----END PGP SIGNATURE-----

--n83H03bbH672hrlY--
