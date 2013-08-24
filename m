Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 944492C007A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 10:20:22 +1000 (EST)
Date: Sat, 24 Aug 2013 01:20:00 +0100
From: Mark Brown <broonie@kernel.org>
To: Mike Turquette <mturquette@linaro.org>
Message-ID: <20130824002000.GA7601@sirena.org.uk>
References: <cover.1376565456.git.b42378@freescale.com>
 <20130822210035.GB31036@pengutronix.de>
 <20130822224331.8231.75743@quantum> <34430785.ApIqfgatMc@flatron>
 <20130823063421.GF31036@pengutronix.de>
 <20130823125815.GG25856@e106331-lin.cambridge.arm.com>
 <20130823140128.GI31036@pengutronix.de>
 <20130823214144.8231.2039@quantum>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
In-Reply-To: <20130823214144.8231.2039@quantum>
Subject: Re: [alsa-devel] [PATCH v5 1/2] ASoC: fsl: Add S/PDIF CPU DAI driver
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Nicolin Chen <b42378@freescale.com>,
 Tomasz Figa <tomasz.figa@gmail.com>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "timur@tabi.org" <timur@tabi.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "festevam@gmail.com" <festevam@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2013 at 02:41:44PM -0700, Mike Turquette wrote:

> Seems like the regulator framework is solving this with the new
> regulator_get_optional() call. This leaves the
> optional-versus-not-optional logic up to the driver.

That is possibly for a slightly different case but perhaps not...

The problem we've got with the regulator API is that an awful lot of
regulators are always on and people generally don't want to go and hook
everything up, especially when drivers don't yet have regulator support.
This means that we end up with lots of complaints about having to add
regultors and lots of pain adding regulator support to widely used
devices, or drivers that just ignore errors which is not awesome.

We don't want to provide dummies since if the driver genuinely does have
optional regulators they tend to break them so we're adding that call to
allow the core to know if it can just provide a stub and assume the
board data was lazy.

My impression with clocks on most platforms is that there are fewer of
this sort of always on clock, though that said I know there has been a
bit of an issue with some of the IP clocks when IPs are used in SoCs
=66rom less power sensitive environments that don't bother implementing
gating even in hardware.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSF/wmAAoJELSic+t+oim9LLgQAJRAXD8FZQaKYmr0KBRCICo5
t5rRGW6tudQ224Zhp8kQHpEs06NDFMRmZVsFDhbkMAVvslj/+LIZE9OQzIVgBX32
X5MAnGcDrwTA8PMrE24ATlIgnrKJeWmAYR2FnjHpCdT8OhFmRb58zwgPreUD4/gg
y6vAKCX+Y5L3lbE7HdGpVn8PLWtE5IxSIGP7cEemXN0/rXXaitGXifZRnmVrjiCi
fY5ScNwMle5uyEuLs8Q/pcrB5PtSKUQrPpir2h7xMP/4KoqGR24MdexF9LsHM/XA
zFlnzFUw/dWrGZGuj1cFlzDw9wtXpiYltJ2lHETaODlZH1FPCwHlFlS47xNcvlc1
c8QaxAzVnUyUZqV8Jc6D5qRN+3OOKuqsE/cDBESWVBCALhWLp60fyqLjzPXB5spe
0TEDL+O+eb73BmB9oy1Ueh8Luwn3aaarobAxSBFHMsLwrnxUwAA/EywLZt55d3tX
FdY4fQf+WNeWsuShQo/JzDIgjAQXoG4KJHjYvTlno9xV1eXrLYA+B3S9jdFszwVi
jpwxQfaaAnvpyNzMSQ4HtwbavQ50hxsrG3lf6/8x96fW4Ix6yCiVYdxlj6w2t2ao
1EY5iQgxgCezR9L4iwVcAC6Z+b+xDoxbMObFHalQl4z6pFWcMqWL+7/IREdzPqGL
R8J8OSNrpmBxItL9zHlI
=dFln
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
