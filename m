Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 443A72C0084
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Jan 2014 03:53:04 +1100 (EST)
Date: Fri, 10 Jan 2014 16:52:29 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140110165229.GP29039@sirena.org.uk>
References: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109184453.GP12858@sirena.org.uk>
 <20140110023252.GA16467@MrMyself> <20140110023537.GB16467@MrMyself>
 <20140110120439.GG29039@sirena.org.uk>
 <20140110130338.GA17392@MrMyself>
 <20140110132642.GM29039@sirena.org.uk>
 <20140110154824.GA17609@MrMyself>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="vzUQzca511KWT6Hk"
In-Reply-To: <20140110154824.GA17609@MrMyself>
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


--vzUQzca511KWT6Hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2014 at 11:48:25PM +0800, Nicolin Chen wrote:

> I think I start to understand the point here: If a user only needs to playback
> the default case - 44.1KHz for example, the driver can just configure all the
> dividers once at the beginning, not every time, so that we can save further
> register overriding operation or even complicated clock selection and divisor
> calculation, which obviously makes the procedure clean and reduces the system
> loading even if it might be just in a slight level.

> Is this the reason, or maybe one of the reasons, to the defaults providing?

The main thing is that if the DAI driver does it then it's less code in
the machine drivers using it - what tends to happen otherwise is that
quite a few machine drivers end up replicating the same logic.  Hardware
designers tend to do a lot of cut'n'paste with these things so even if
the CODEC is different the clocking is often very similar.

--vzUQzca511KWT6Hk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS0CVKAAoJELSic+t+oim99IQP/08MHspLPF61FZWnYD7c/ocz
umRR6MfesK+5hChKTM5MjqKhRbORurpimLy3SQgiFHuoJXHUWkDWOFyU7ARsirm4
SE93me6Ug7ARPdKtfdLJpH7xxgBsdV9YvbsZMfilEAjjLCa3UbZt7ZeDDBlOYMVE
AbWOoGFjPrmvAMn5vNIUGZ2whqp9GEEzWCjrcFb2PRWNr8CCiJF+u23bX0CT/17B
kxXqagbocugD3Rqjpo7EVZhaDlh8B/MARkGbnqTp53DpxRJl8xlSuM2GuyV7njhZ
qedOxwUu7prtwID2HvF+xhj2cQstZaA0IXRutEoe2wj0cVBx0btGz/FHPcw85aou
EQburgwdP2e63AcC8m2JcGGZ5y5QLQqMktxwgOr9RNTZj7ksL399KKpsLRiM2ABH
z6gisop7cFr4BHl2H11V8W6telUgNq/TVIYAYfKASZ/3ei8BdPrT8cDm8NCShzBy
aRgmxb6f2rfBwIl1xXlNYV3vP1iWhICO0TzHDKxCQ+hl1cSKB0b6Lez6OmmHzUN3
o86Hz/pfcxzRY6BdwwINgEqdiSyi0YJ91DQ8uvuISSLUVvOqx4ZwB9Mw4mhprAhV
Ezpp0kEIGQuL7OhcPrjSGyJP8SeNjWMsFzZFtO3YbtPdcuw/gFIKzHvTfBL5xNbJ
MBAW15HInlDLOVdc5Yga
=SwMh
-----END PGP SIGNATURE-----

--vzUQzca511KWT6Hk--
