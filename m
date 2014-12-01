Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95B7C1A09BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 06:24:48 +1100 (AEDT)
Date: Mon, 1 Dec 2014 19:24:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <20141201192422.GL7712@sirena.org.uk>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
 <20141201065046.GB27289@pengutronix.de>
 <547C9C34.9080602@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="YsbR7IM8mFrcghHU"
In-Reply-To: <547C9C34.9080602@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before
 irq_dispose_mapping()
Cc: alsa-devel@alsa-project.org, Jiada Wang <jiada_wang@mentor.com>,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, timur@tabi.org,
 nicoleotsuka@gmail.com, tiwai@suse.de, Li.Xiubo@freescale.com,
 Markus Pargmann <mpa@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YsbR7IM8mFrcghHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 01, 2014 at 05:49:56PM +0100, Lars-Peter Clausen wrote:
> On 12/01/2014 07:50 AM, Markus Pargmann wrote:

> >devm_request_irq() is used by other drivers too, this should not be a
> >problem. Looking at the code it seems that irq_dispose_mapping may not
> >be necessary with devm_request_irq(). So I think it would be better to
> >remove irq_dispose_mapping() instead.

> The driver creates the mapping by calling irq_of_parse_and_map(), so it also
> has to dispose the mapping. But the easy way out is to simply use
> platform_get_irq() instead of irq_of_parse_map(). In this case the mapping
> is not managed by the device but by the of core, so the device has not to
> dispose the mapping.

It also has the advantage of not being DT specific so providing some
chance that future firmware interfaces can be supported without driver
modification.

--YsbR7IM8mFrcghHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfMBmAAoJECTWi3JdVIfQQQIH/iCp85C3j3tZK021HeqxyEwY
1QWrbS+5j6rW3D+UcSC/BYqRF+ClS/1ZOeFgH5b6hP4Jp1ng00iYKOaCkv3EdqRh
DULbFmlBPkEnV8Zrq4yZ64Lmjdfg1JcSZ+iwsqkIU4RuI67BmFLKlcOtapojKSby
SCCjRe1LJBGlb1IgO/5Rnv1Clesu5OBblyL0xMDAp54QWVD2fGtVwhxk3KjC3G0o
oqbhdZ77Y0P97IH8RYBj4xZU5AN32KgE65PvQTYRvwmcknG09gMoELs45XLzcP0w
5fqwPGZvRLGxqkBbHxITRPVYqTD7QmmB1mn7HsamDycHOwMFjdFHmwCcVb0gyn8=
=hd9f
-----END PGP SIGNATURE-----

--YsbR7IM8mFrcghHU--
