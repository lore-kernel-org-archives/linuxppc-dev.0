Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC5C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 22:37:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F6560EB4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 22:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E6F6560EB4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDbst2hwYz304x
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 08:37:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linkmauve.fr (client-ip=2a01:e0a:828:c7c0:49:5ff:fe41:d261;
 helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr;
 receiver=<UNKNOWN>)
Received: from luna.linkmauve.fr (unknown
 [IPv6:2a01:e0a:828:c7c0:49:5ff:fe41:d261])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDbsP3fqcz2xVt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 08:37:29 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
 id 3274DF40B6D; Wed, 22 Sep 2021 00:37:25 +0200 (CEST)
Date: Wed, 22 Sep 2021 00:37:24 +0200
From: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/4] crypto: nintendo-aes - add a new AES driver
Message-ID: <20210921223724.ocxpdef6ptquprgz@luna>
Jabber-ID: linkmauve@linkmauve.fr
References: <20210921213930.10366-1-linkmauve@linkmauve.fr>
 <YUpVyTN7MQbMShdf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jii3ybjni5untti4"
Content-Disposition: inline
In-Reply-To: <YUpVyTN7MQbMShdf@gmail.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Ash Logan <ash@heyquark.com>, Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linux-crypto@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.ne@posteo.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--jii3ybjni5untti4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 21, 2021 at 02:59:37PM -0700, Eric Biggers wrote:
> On Tue, Sep 21, 2021 at 11:39:26PM +0200, Emmanuel Gil Peyrot wrote:
> > This engine implements AES in CBC mode, using 128-bit keys only.  It is
> > present on both the Wii and the Wii=C2=A0U, and is apparently identical=
 in
> > both consoles.
> >=20
> > The hardware is capable of firing an interrupt when the operation is
> > done, but this driver currently uses a busy loop, I=E2=80=99m not too s=
ure
> > whether it would be preferable to switch, nor how to achieve that.
> >=20
> > It also supports a mode where no operation is done, and thus could be
> > used as a DMA copy engine, but I don=E2=80=99t know how to expose that =
to the
> > kernel or whether it would even be useful.
> >=20
> > In my testing, on a Wii=C2=A0U, this driver reaches 80.7 MiB/s, while t=
he
> > aes-generic driver only reaches 30.9 MiB/s, so it is a quite welcome
> > speedup.
> >=20
> > This driver was written based on reversed documentation, see:
> > https://wiibrew.org/wiki/Hardware/AES
> >=20
> > Emmanuel Gil Peyrot (4):
> >   crypto: nintendo-aes - add a new AES driver
> >   dt-bindings: nintendo-aes: Document the Wii and Wii U AES support
> >   powerpc: wii.dts: Expose the AES engine on this platform
> >   powerpc: wii_defconfig: Enable AES by default
>=20
> Does this pass the self-tests, including the fuzz tests which are enabled=
 by
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy?

I wasn=E2=80=99t aware of those, and indeed it doesn=E2=80=99t pass them ye=
t:
[    0.680164] alg: skcipher: cbc-aes-nintendo encryption overran dst buffe=
r on test vector 0, cfg=3D"out-of-place"
[    0.680201] fbcon: Taking over console
[    0.680219] ------------[ cut here ]------------
[    0.680222] alg: self-tests for cbc-aes-nintendo (cbc(aes)) failed (rc=
=3D-75)

I=E2=80=99ll try to figure out how to debug this and I=E2=80=99ll send a v2=
, thanks for
the hint!

>=20
> - Eric

--=20
Emmanuel Gil Peyrot

--jii3ybjni5untti4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEjrVT1SzTln43kCLJOWgfYkb2LpAFAmFKXqIACgkQOWgfYkb2
LpCJcgf+IMfEy9fNYpEki4K7BmX/f4kKVOek3gLVkG3rrgZOTElYH5C9uOsdxHZ9
27PsYcESnj9tI3G9t9RLmyPmxuMVPCVKTc0KaFbacwx1UMmQMBFa5s0WZMVHgZC9
L7/JnU4G1rRPIxXaaYKnqBBYNzO2LuwVBd7V/0m9WBToXEWEtxabaGO6QuiKFAYX
rv6T3ajdk40w8XQo3I031M3OxSq9prJBNCtkdkPPmqB4ZtP/E8uGM6ukTMYgR/ZU
NA3w3V8BX95KNPt/uDKbZ3vdbsSH1PcFVgfPs7aqBKU+zddkdwcoEKfoyg8c4wUi
cU30fGOI9fLKgdx83YZrWeu8x9Ty7w==
=IlCT
-----END PGP SIGNATURE-----

--jii3ybjni5untti4--
