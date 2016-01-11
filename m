Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DD91D1A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 03:12:38 +1100 (AEDT)
Date: Mon, 11 Jan 2016 16:12:25 +0000
From: Mark Brown <broonie@kernel.org>
To: Timur Tabi <timur@tabi.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabio Estevam <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20160111161225.GJ6588@sirena.org.uk>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <20160111140038.GC6588@sirena.org.uk>
 <5693B7CC.8000905@maciej.szmigiero.name>
 <20160111145430.GE6588@sirena.org.uk> <5693CE21.8010009@tabi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="JhY86nTAwD/oWhC3"
In-Reply-To: <5693CE21.8010009@tabi.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--JhY86nTAwD/oWhC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2016 at 09:45:37AM -0600, Timur Tabi wrote:

> Ok, I'm confused.  Granted, all of this regcache stuff was added after I
> stopped working on this driver, so I'm out of the loop.  But it appears that
> the regcache cannot properly handle an uninitialized cache.  I would expect
> it to know to perform hard reads of any registers that are uninitialized.

regcache handles this fine, it's perfectly happy to just go and allocate
the cache as registers get used (this is why the code that's doing the
allocation exists...).  What is causing problems here is that the first
access to the register is happening in interrupt context so we can't do
a GFP_KERNEL allocation for it.  Most users don't do anything at all in
interrupt context so it's not an issue for them, drivers that want to
use regmap in interrupt context need to handle this.

We can't rely on knowing which registers are valid and which registers
can be read without side effects, it's optional for drivers to provide
that information.  Even with that information it's not always clear that
we want to stop and read every single value when we are initialising the
device, that might be excessively slow (remember a lot of regmap devices
are I2C or SPI connected, some with large register maps).  We should
have a helper to do that though for drivers where it does make sense.

--JhY86nTAwD/oWhC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWk9RpAAoJECTWi3JdVIfQEPAH/jIOBJmZ1/Z2SFx81KB5qmQH
QcGhPJaDgyxMz21DsqXKX7hxg6NNYWVh7yE51QPSDk8nzygvtl/fHNqMXth9blOO
2/7S9BOY3CfYxXQZ9qfu/2Uy4cTgDRauF6TvoH510LQqgu0f6dq8OBfGGngPRsOZ
8wfQCM8k9jaO1L512EULIDiKP29mGmHhHN33tzfPrCDfcXWkoQkAP8/vG/P+xu/p
lsrvnCq5hNGMXJi4T8mvykE/JDNKBS1b22A8501j0WYmG6oKO2U3P6/sEYaRAa6B
p/qdtrxNM2pKjhJHLavJSSfWFVZdQ6Rl2IwI86G1EFBShyWgnV2OO3p20BwephY=
=E/U9
-----END PGP SIGNATURE-----

--JhY86nTAwD/oWhC3--
