Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EBBA41A0202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 01:54:46 +1100 (AEDT)
Date: Mon, 11 Jan 2016 14:54:30 +0000
From: Mark Brown <broonie@kernel.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabio Estevam <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20160111145430.GE6588@sirena.org.uk>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <20160111140038.GC6588@sirena.org.uk>
 <5693B7CC.8000905@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="afaOoWBOIwPZGAW2"
In-Reply-To: <5693B7CC.8000905@maciej.szmigiero.name>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--afaOoWBOIwPZGAW2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2016 at 03:10:20PM +0100, Maciej S. Szmigiero wrote:
> On 11.01.2016 15:00, Mark Brown wrote:

> > I suspect not, it looks like the driver is using the cache for
> > suspend/resume handling.  I've dropped the patch for now.  Either the
> > driver should explicitly write to the relevant registers outside of
> > interrupt context to ensure the cache entry exists or it should keep the
> > defaults and explicitly write them to hardware at startup to ensure
> > sync (the former is more likely to be safe).

> Is it acceptable to switch it to flat cache instead to not keep the register
> defaults in driver?

That's possibly problematic because the flat cache will of necessity end
up with defaults (of 0 from the kzalloc()) for all the registers.
You'll still have default values in the cache, though some of the
behaviour around optimising syncs does change without them explicitly
given.  It does deal with the allocation issue but given that the issue
was incorrect defaults I'd be a bit concerned.

--afaOoWBOIwPZGAW2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWk8ImAAoJECTWi3JdVIfQtbwH/Rj4YZZjRlI6a3XFpGZnHQFg
MB6Kqu0NLWiwareNiaiCL+0HEI2H6AU4qmGrEiaEDsptiC7Tmn0H9cS1ureQFkvX
pWyyBvjBiegDeAbQ54H69CJ3Kidqyq3Y1TN6uX4mRS1nTFHf9YK4hi7FlVBnIfME
pmvBVykU8DUd53CglRa3IaTGdj7F5ULbnWbK4R0FRDGXf8l73VbxfuNoGXJZUtWj
qydpBvul5ErCw/bLEnGy81RLSi82TvjjnZA+s+sR5pjWtOlWnP8orX5y1E9qQ0Op
mzleOfl48qmMQtAEvxJBuWrkuzqUzKDYRp+zsZAgQ9BJR5sS8agi+k4m5YsNLzs=
=h5cq
-----END PGP SIGNATURE-----

--afaOoWBOIwPZGAW2--
