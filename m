Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtQxn3C59zDqHC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 22:48:13 +1100 (AEDT)
Date: Wed, 29 Mar 2017 12:47:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org,
 Timur Tabi <timur@tabi.org>, Xiubo.Lee@gmail.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
Message-ID: <20170329114752.bpfzkkvbvan3ayn5@sirena.org.uk>
References: <1490691532-2086-1-git-send-email-daniel.baluta@nxp.com>
 <1490691532-2086-3-git-send-email-daniel.baluta@nxp.com>
 <20170328092103.GQ6986@localhost.localdomain>
 <CAEnQRZAx1o9xtbf3u1A_Zun7MSaJjdjunpJm1Q6=ZAA3beoFbA@mail.gmail.com>
 <20170328115306.GR6986@localhost.localdomain>
 <20170328152457.2j5zaxdbdavpuspa@sirena.org.uk>
 <CAEnQRZCiaCfzQRDo-3UupH8fv9BttZBVVXo63FdnrdqG49F1GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vspbhsb2mi47wgbn"
In-Reply-To: <CAEnQRZCiaCfzQRDo-3UupH8fv9BttZBVVXo63FdnrdqG49F1GQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: imx-wm8962: Fix codec_clk
 cleanup
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vspbhsb2mi47wgbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 29, 2017 at 02:38:23PM +0300, Daniel Baluta wrote:

> If I read the code correctly, both machine and codec driver are doing:

> * codec_clk = clk_get(...)

> I guess that the codec driver is the first to be loaded and it will call:

> * __clk_create_clk

> which will do the allocation. Then when machine driver is loaded, it
> will only take a reference to the allocated clock.

> I might be very wrong on this. Can you clarify what does moving allocation
> of the clock into codec driver implies? Machine driver only needs a reference
> to codec_clk to just get the clock's rate.

Oh, so the CODEC is already requesting the clock.  Then what I'm saying
is work out a way to use the handle to the clock that the CODEC driver
created.  In effect the machine driver is telling the CODEC driver to do
things with the input clock.

--vspbhsb2mi47wgbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljbnucACgkQJNaLcl1U
h9DZ6Qf/VAZ2sbMrBxYzJO/3l4uqg/RdBeUQQm5/uC4DM6Uj72lVsDAUJS77YYyH
yhBBXX3B95rDnksxd0rJIC6sVlay6XG7wFG85D+Fuz+ZgzOtcQYKS5zEN6+RW17i
O2FXmmylr+1+ewxqgdtRqS3ix82wY96+Z1Q+YJlrR7RzcAJQjHss/yILbbOULe4v
ox5tI7G5F09NgKkNRslL6RhywqA8l5iT43HWSKwOJMxdKU7xYlPeS+BomZ+ME08e
7Og7Loz/cjumAAJEnr1FKHE2/WG1ku6uOHlcyfYPA/RfPnjBoxLDyJrd+H3DW0ln
C/FcExTx1UZPsmTj2gkLSMqp4gxcBw==
=9xKi
-----END PGP SIGNATURE-----

--vspbhsb2mi47wgbn--
