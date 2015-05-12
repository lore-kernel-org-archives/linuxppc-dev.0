Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 617371A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 04:42:54 +1000 (AEST)
Date: Tue, 12 May 2015 19:42:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Zidan Wang <zidan.wang@freescale.com>
Message-ID: <20150512184237.GP3066@sirena.org.uk>
References: <cover.1431337606.git.zidan.wang@freescale.com>
 <1431339894-4248-2-git-send-email-zidan.wang@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U+NfgObvpQT1Q9Yq"
In-Reply-To: <1431339894-4248-2-git-send-email-zidan.wang@freescale.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_sai: Add tdm slots operation for SAI
 master mode
Cc: alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com,
 tiwai@suse.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 perex@perex.cz, nicoleotsuka@gmail.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--U+NfgObvpQT1Q9Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 06:24:42PM +0800, Zidan Wang wrote:

>  	if (!sai->is_slave_mode) {
> +		slot_width = sai->slot_width;
>  		ret = fsl_sai_set_bclk(cpu_dai, tx,
> -			2 * word_width * params_rate(params));
> +				sai->slots * slot_width * params_rate(params));
>  		if (ret)

This seems to make TDM configuration mandatory which seems like a step
back - if it's been set up then of course we need to use it but if it's
not been configured we should be able to just infer something from
hw_params as we have been doing.  Checking to see if the relevant values
have been set and falling back to using hw_params seems better.

Otherwise this looks good.

--U+NfgObvpQT1Q9Yq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkmcAAoJECTWi3JdVIfQbUEH+waDqZMrjdtzAac3BmjexrV8
cs0n0GKMJhoSP3ZmB9turr1jqlB/Vr9rb5Ip4IXf2jvsD42kVTTeRyJxKmM2W+43
Tz9hR4ApJpZZi29TGhvOX14xaZ3wTpByoVxDkIOVHXFnZfZKjkX6nth+61LlwWWB
Tk+ihCpVIH5EgikqxQR9ggcBSy0Y2Yl7sVTVi0bI0JFCJzcpsgShVyMJrSzEb02R
qWIBT2CZKJP5WtET/tKHrwsgMiMUhBDBfMna7wXjiI6+nR1dR0KDWtIz5xnRMfX+
hoQxibzqG2ijvxR21/wdAezjNBTeAGPyZaOiSTGuYOi6F6BK9sLUDwyMUCcquSw=
=52TZ
-----END PGP SIGNATURE-----

--U+NfgObvpQT1Q9Yq--
