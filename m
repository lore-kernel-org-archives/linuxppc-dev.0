Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 52CDB2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 00:27:13 +1100 (EST)
Date: Fri, 10 Jan 2014 13:26:42 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140110132642.GM29039@sirena.org.uk>
References: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109184453.GP12858@sirena.org.uk>
 <20140110023252.GA16467@MrMyself> <20140110023537.GB16467@MrMyself>
 <20140110120439.GG29039@sirena.org.uk>
 <20140110130338.GA17392@MrMyself>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="x38akuY2VS0PywU3"
In-Reply-To: <20140110130338.GA17392@MrMyself>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Add ESAI CPU DAI driver
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, shawn.guo@linaro.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, timur@tabi.org, lgirdwood@gmail.com,
 robh+dt@kernel.org, rob@landley.net, galak@codeaurora.org,
 grant.likely@linaro.org, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--x38akuY2VS0PywU3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2014 at 09:03:39PM +0800, Nicolin Chen wrote:
> On Fri, Jan 10, 2014 at 12:04:39PM +0000, Mark Brown wrote:

> > This is about what I'd expect but then surely the next step is for the
> > driver to choose a defualt BCLK ratio - that's how most drivers work,
> > they try to generate the exact rate that is needed to clock the data.

> Does that mean I should call set_bclk() once in the startup() when !active
> to set a default bit clock rate to suit a common sample rate like 44100Hz?
> I'm a bit confused if so. Because the driver would call set_bclk() any way
> in the hw_params().

Right, any choice here needs to be deferred to hw_params() as you say.

> But your suggestion just reminds me of the slave mode in SSI driver as
> default mode. And I should patch ESAI to slave mode for default as well,
> shouldn't I?

master/slave selection is kind of orthogonal here - the two bits of
information that are normally needed are the MCLK to use (and its rate)
and the sample rate/format (which give you the BCLK that is needed).
Normally it's then possible to caculate a divider which generates BCLK
=66rom MCLK.  Overriding is normally only needed if there are additional
constraints on BCLK due to something like limitations in one of the
devices or sample rates for the opposite direction if the BCLK is shared
but LRCLK isn't.

> > Are the bit clock shared between playback and capture?

> Only shared in synchronous mode and totally individual in asynchronous mo=
de.
> Each of them can have their own HCK(MCLK) from different sources and deri=
ve
> their own SCK(BCLK).

OK, so in asynchronous mode there should be a good chance of a a default
choice working since it won't restrict the other direction.

--x38akuY2VS0PywU3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSz/UPAAoJELSic+t+oim9+M8QAImXq8LRXn58WvYsyM3+jGlV
2FuqBmOjiDlEyiNIha5E+X5tkBM6ZY7mULBBMx1EV+cJZm4ZiIdpWIyZANp+wv2w
O0+woCXXQ41D+FAdpBE+qVN1HmuESwEkUqufCC2E8aiFEy29mNg3O181fFF25Cbm
0hr26w+9oJDLEDGN2nVCR568ooBuaCF0yY0xhzCZSb/+8eMJUZUTqbjntCLZ07pQ
oCiMQ/JosR9UE4DPOvrqaH/3bssf9GO0fI9VeCTjJk9JFyARIXI1D8m1knYMs47U
5g8xM8VxrBJaoFzv6m7xyCMniHhJwfgCrEkhdp4+vpUUeR1yoXMJ6yVP9QEbZV8j
ScBmE9IoM7PVYCmw2LYNlgtmT+x27trB81JzHxKe60ZXOhmXhDKS+vwq0rqW3SQA
pnvt12qjTAaju88wmyANNPACOgMMr7g+uYiVplFCQmjFPUalEz/3FveyHrnaocwt
WCqDo0stNUyT74pq3YW7DEsWFJFZp8v9B870Xe5DoKeQ3RdaoH2ukF8W/Y61/7uw
BnsA4ZZLFj15roFcJZG7NdvvdRUwdABAdNEu8qxUZ1wzARaX9CsoTfxhGZfVPbfT
DvBZO+CV5zQDKaFBKRS/UY9EuporY5Crx3G3xi0HUEqjzNGgk5cuF5X8G4La/q5t
uiETXXSvhw9g+hGdsBGY
=W7uy
-----END PGP SIGNATURE-----

--x38akuY2VS0PywU3--
