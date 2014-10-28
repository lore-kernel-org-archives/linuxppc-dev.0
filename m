Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D6D31A000C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 21:48:18 +1100 (AEDT)
Date: Tue, 28 Oct 2014 10:47:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Message-ID: <20141028104742.GP18557@sirena.org.uk>
References: <1414202637-18929-1-git-send-email-nicoleotsuka@gmail.com>
 <20141028001904.GH18557@sirena.org.uk>
 <20141028042603.GA5548@Asurada>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="scYsJfBjqkrBfg1Z"
In-Reply-To: <20141028042603.GA5548@Asurada>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add reg_defaults for regmap to fix
 kernel dump
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--scYsJfBjqkrBfg1Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 27, 2014 at 09:26:26PM -0700, Nicolin Chen wrote:
> On Tue, Oct 28, 2014 at 12:19:04AM +0000, Mark Brown wrote:

> > It's not a bug, it's not reasonable to default allocations to atomic and
> > we can't really tell what context we're in.  Anything used inside a
> > heavily locked path should either have a default provided or arrange for
> > a prior write to set up the cache.

> I've a little trouble to understand the prior write over here. Inside my
> probe() there's a register_init() call which has a set of regmap_write().
> And then the first regmap_write() results the dump. Does that mean this
> regmap_write() isn't prior write? If so, how should I do if not setting

Oh, bother.  We fixed things so that we're now always running with the
spinlock held...  never mind.

> default values here -- Some IPs may have default value 0 for registers.
> And this would make reg_defaults tedious since there's nothing special
> to assign.

Write a small script then, or a little bit of code to create the
defaults dynamically.

> And actually I remember I haven't seen any dump when I sent the initial
> patch for the whole ASRC driver but it manifested last month. I thought
> it might be a partially-merging issue and it would be fixed after merge
> window's done.....

Nothing has changed here for a while as far as I remember.

--scYsJfBjqkrBfg1Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUT3RNAAoJECTWi3JdVIfQ6dgH/31xUY+Mj0t8ZJ640hvt2+hz
02CP6IhL9gVdQ0/K6+AupVIIln9sbR5Ys9PWnZShGmcULb99c4wcwuo0pQhI3He8
00TCixzko3Q3rFo3Hbs5GaxlmUpUOlki3n5O34rZ4whOHqWuBk7MVEB/crrJHANS
M3FzS0IB5wymEWPnr2PYXwQi52JNcSYhXOHVqmhnJJJPiFut1otsqo4qAaSjLmxz
MRw0qSFWwuT0YdRK8ku0jvpZgOsyC2uyRR9ZIRvX4sufNDXgv18spfATbk5DtxSy
1vbZETpugd6Bu/B3Tn97rv/M2NIDEtNN5txJEZpmG277LPjiq1ujx1vuGpUogVs=
=YnuJ
-----END PGP SIGNATURE-----

--scYsJfBjqkrBfg1Z--
