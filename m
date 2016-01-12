Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E13C71A06BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:34:36 +1100 (AEDT)
Date: Tue, 12 Jan 2016 01:34:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Timur Tabi <timur@tabi.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabio Estevam <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <20160112013421.GW6588@sirena.org.uk>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <20160111140038.GC6588@sirena.org.uk>
 <5693B7CC.8000905@maciej.szmigiero.name>
 <20160111145430.GE6588@sirena.org.uk> <5693CE21.8010009@tabi.org>
 <20160111161225.GJ6588@sirena.org.uk> <569455AA.4060907@tabi.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3BjoNV5KkjW1cxnK"
In-Reply-To: <569455AA.4060907@tabi.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3BjoNV5KkjW1cxnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2016 at 07:23:54PM -0600, Timur Tabi wrote:
> Mark Brown wrote:

> >regcache handles this fine, it's perfectly happy to just go and allocate
> >the cache as registers get used (this is why the code that's doing the
> >allocation exists...).  What is causing problems here is that the first
> >access to the register is happening in interrupt context so we can't do
> >a GFP_KERNEL allocation for it.

> Considering how small and not-sparse the SSI register space is, would using
> REGCACHE_FLAT be appropriate?

Quite possibly (it'll be more efficient and it's intended for such use
cases) but as I said in my other reply that then has the issue that it
implicitly gives default values to all the registers so I'd expect we
still need to handle the cache initialisation explicitly (or
alternatively the hardware sync with the cache on startup).

--3BjoNV5KkjW1cxnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWlFgcAAoJECTWi3JdVIfQ98IH/09zIC0Ay+fzOlGUIaKvTv2T
+ezl3FG/dpKNjVXXI0Y613tHj8TL+515E6FSNqMAgo97g7Vmkm/vb5t8VFYUbp/U
fbWjeUbklioDO1TmuQfBNQxY2YZ43Jw0Vq6TJk2B+oOY9y/R1WWhzuW/JieSWeJb
mvrOrsroFSLqKQIj3VWYvOZTT1w7Y0df0mTNl8eDqujJubLRwJ6qNXp6HBGBLYj1
67XgL6WhuxqhZqH8aSp/M1aramY7EugEEt+T9Ex81ydzUNGKqgsafKMDJbVEbHtk
5kPgLQfPjfiq2elkeroRC9QF58X3kMqWy5PGzCRU5DNPSedJZS2wwK/rKofBom8=
=dNZF
-----END PGP SIGNATURE-----

--3BjoNV5KkjW1cxnK--
