Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00EBD1A007F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 08:10:31 +1100 (AEDT)
Date: Mon, 1 Feb 2016 21:10:17 +0000
From: Mark Brown <broonie@kernel.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabio Estevam <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20160201211017.GG4455@sirena.org.uk>
References: <569D3800.2040801@maciej.szmigiero.name>
 <CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>
 <56AF4A9F.4060401@maciej.szmigiero.name>
 <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
 <56AF4ED0.7030801@maciej.szmigiero.name>
 <56AF8E9E.5000100@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
In-Reply-To: <56AF8E9E.5000100@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 05:58:06PM +0100, Maciej S. Szmigiero wrote:

> Looks like a possible solution would be to change
> regmap_raw_read() to do read using _regmap_read in
> case the cache is bypassed and there is no ->read
> callback defined for regmap implementation.

No, that's completely broken.  We can't do a raw read from a regmap that
doesn't offer raw access and we shouldn't pretend to do so.  If the
caller is capable of substituting a register by register read the caller
should take responsibility for that.

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWr8m4AAoJECTWi3JdVIfQ7Z4H/Reu/R+eh43RZfjK7y+WNdlV
IkRkqAp3l86gX/zwpxxzqmWz5fjf8gG0vdENxSXUfAzylLPoLw162KD/+oW9UeD2
4tJBNzitCISauuAnZmH81llShMCV6qfhgPaZPJmygzHDwaXYGJDS0LZNejUNYK+3
/sBx+BPbIoPOewBZg1w5Mpu/rxxaiWhFGwOD2ntBUrmCgwpv6SthkV+c2CcdHT7d
78q8RwAi9lEbetsASwOFGa1J6ZSUKBA8vWHEjsggroboR+Lni6Zvl+Nq3DHnge6w
ExlQ95cwLh8eZ5lwOcrI7xoZiZrV/IjquyOSl3mddq3gFOoeLMQFuuCoGcG1CY4=
=8Tfw
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
