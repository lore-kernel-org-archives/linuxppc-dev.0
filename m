Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75DA51A0F00
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 13:45:05 +1100 (AEDT)
Date: Tue, 8 Dec 2015 13:08:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 2/9] KVM: PPC: Make real_vmalloc_addr() public
Message-ID: <20151208020803.GH20139@voom.fritz.box>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="gKijDXBCEH69PxaN"
In-Reply-To: <1442314179-9706-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gKijDXBCEH69PxaN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2015 at 08:49:32PM +1000, Alexey Kardashevskiy wrote:
> This helper translates vmalloc'd addresses to linear addresses.
> It is only used by the KVM MMU code now and resides in the HV KVM code.
> We will need it further in the TCE code and the DMA memory preregistration
> code called in real mode.
>=20
> This makes real_vmalloc_addr() public and moves it to the powerpc code as
> it does not do anything special for KVM.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Hmm, I have a couple of small concerns.

First, I'm not sure if the name is clear enough for a public function.

Second, I'm not sure if mmu-hash64.h is the right place for it.  This
is still a function with very specific and limited usage, I wonder if
we should have somewhere else for such special real mode helpers.

Paulus, thoughts?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gKijDXBCEH69PxaN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWZjuDAAoJEGw4ysog2bOSEwEQAIhQnTWjbEt1TjuOi8psD6D5
iNtKTfd514HtVSDX4nGSZa/hKQg3XWdVnFM3ljZfOCfrrlTCwQIJMqTvPmoYRD4d
A+63hjzMdLBzZDS0J2CkhyZ2/Skmm+EiySZ25C6PvecMIzJPjedxHzq/7el1pS4k
0DSOKlxWIvwkx8KlwqscUtC6G7pH2SnSzVWyE/SF22h6+2OBo6IHbNKE+69VfjC2
JB9VYtQ3pra400p4ypOqGU5xMsEvOhw1LIvp0H15Jn8wmvyhYoBGBcfMH27U3B+z
SJwgsLtxWxIdbdMDw1qfLz5Z+3/L+Y/JTRbtUoKs3iAr3Af1XTt/1L2Lsy3dBZrz
WvmZjwPzLgy3rn8M99876QIXE9iRqdyjvl9BGutXHiAU/TN36pFMpMREIeIm/Zm9
dRtcEVP6doTxqo+RfMpX5AVoH/v2L6uHdPORwAffEMCw6GrSdskBgQ292xTcyAc6
48lt9rFpElfdiA1UZ5xhMce3JFRSSNz5GTkq+dvT1iU1vfpuE+cy3rE9iQkiYsF7
WGwMRq9qwpVOPYL8UT76DVO2a2cD5NVvEQLYmiWMG3XV1rPOuTVQDtBglPHLZeCZ
h28wAmxX+D3jCDIy6OV+vHJT2oNCaoRdixbxwW2rPgRNViZP8RHbdLtSdt+bVk3K
VMBVl5gYBj1QTFqGjssA
=Ikwh
-----END PGP SIGNATURE-----

--gKijDXBCEH69PxaN--
