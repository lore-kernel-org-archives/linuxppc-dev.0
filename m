Return-Path: <marcelo.cerri@canonical.com>
Received: from mail-qk0-x229.google.com (mail-qk0-x229.google.com
 [IPv6:2607:f8b0:400d:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skdW63WF9zDrPm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 23:16:02 +1000 (AEST)
Received: by mail-qk0-x229.google.com with SMTP id j129so38169462qkd.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 06:16:02 -0700 (PDT)
Date: Wed, 28 Sep 2016 10:15:51 -0300
From: Marcelo Cerri <marcelo.cerri@canonical.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 George Wilson <gcwilson@us.ibm.com>,
 Claudio Carvalho <cclaudio@br.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@br.ibm.com>,
 joy.latten@canonical.com, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: sha1-powerpc: little-endian support
Message-ID: <20160928131551.GA31082@gallifrey>
References: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
In-Reply-To: <1474659116-4689-1-git-send-email-marcelo.cerri@canonical.com>
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

Hi Herbert,

Any thoughts on this one?

--=20
Regards,
Marcelo

On Fri, Sep 23, 2016 at 04:31:56PM -0300, Marcelo Cerri wrote:
> The driver does not handle endianness properly when loading the input
> data.
>=20
> Signed-off-by: Marcelo Cerri <marcelo.cerri@canonical.com>
> ---
>  arch/powerpc/crypto/sha1-powerpc-asm.S | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/crypto/sha1-powerpc-asm.S b/arch/powerpc/crypto=
/sha1-powerpc-asm.S
> index 125e165..82ddc9b 100644
> --- a/arch/powerpc/crypto/sha1-powerpc-asm.S
> +++ b/arch/powerpc/crypto/sha1-powerpc-asm.S
> @@ -7,6 +7,15 @@
>  #include <asm/ppc_asm.h>
>  #include <asm/asm-offsets.h>
> =20
> +#ifdef __BIG_ENDIAN__
> +#define LWZ(rt, d, ra)	\
> +	lwz	rt,d(ra)
> +#else
> +#define LWZ(rt, d, ra)	\
> +	li	rt,d;	\
> +	lwbrx	rt,rt,ra
> +#endif
> +
>  /*
>   * We roll the registers for T, A, B, C, D, E around on each
>   * iteration; T on iteration t is A on iteration t+1, and so on.
> @@ -23,7 +32,7 @@
>  #define W(t)	(((t)%16)+16)
> =20
>  #define LOADW(t)				\
> -	lwz	W(t),(t)*4(r4)
> +	LWZ(W(t),(t)*4,r4)
> =20
>  #define STEPD0_LOAD(t)				\
>  	andc	r0,RD(t),RB(t);		\
> @@ -33,7 +42,7 @@
>  	add	r0,RE(t),r15;			\
>  	add	RT(t),RT(t),r6;		\
>  	add	r14,r0,W(t);			\
> -	lwz	W((t)+4),((t)+4)*4(r4);	\
> +	LWZ(W((t)+4),((t)+4)*4,r4);	\
>  	rotlwi	RB(t),RB(t),30;			\
>  	add	RT(t),RT(t),r14
> =20
> --=20
> 2.7.4
>=20

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJX68KHAAoJEM8aS8c01e1HXs0H/0u3vNS7zj7uND7AmnkYB8rb
+HgaY/k1PvtlFRTmq5ahsDY5+cQXyJMydAp+ah+qgmRasMi70w37Spwd6PYu8Bkl
aI70HabZDkxoCwADkPVvR5YrPdtYhR8ezl/FNWXGEhXPuy9kg7nCnhmcDLo2Agtj
y9hUKynYqY9G0VrQzd1sSyn4cSPgbBy2YDjPYu9uA26DDcFKXePYrF/Z5CKNuUkk
+Xb+It0fgJNAek4gji6Xr6BUeybohdMQq7glmmY5XJS4cQ58CTjPniCw4OTCpFme
BqbIIFI0dErJduLh8KKpMK0HicWf5tW1MFCkxqLMKmH1JxP+FIjrW4KKzTrV0+4=
=U88n
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
