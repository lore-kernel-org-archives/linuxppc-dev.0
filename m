Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F106214008C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Mar 2014 00:26:47 +1100 (EST)
Date: Thu, 27 Mar 2014 13:26:27 +0000
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140327132626.GN30768@sirena.org.uk>
References: <1395918419-20739-1-git-send-email-Guangyu.Chen@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="U6leaJ20qZQc29iB"
In-Reply-To: <1395918419-20739-1-git-send-email-Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Add isr to deal with error flag
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, timur@tabi.org,
 Li.Xiubo@freescale.com, David.Laight@ACULAB.COM, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--U6leaJ20qZQc29iB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 07:06:59PM +0800, Nicolin Chen wrote:
> It's quite cricial to clear error flags because SAI might hang if getting
> FIFO underrun during playback (I haven't confirmed the same issue on Rx
> overflow though).
>=20
> So this patch enables those irq and adds isr() to clear the flags so as to
> keep playback entirely safe.

So, I've applied this since we're (hopefully!) very near the merge
window opening and it seems like it should be an improvement overall.
However a few things below:

> +	/* Only handle those what we enabled */
> +	mask =3D (FSL_SAI_FLAGS >> FSL_SAI_CSR_xIE_SHIFT) << FSL_SAI_CSR_xF_SHI=
FT;

The shifting here could use a comment.

> +	regmap_update_bits(sai->regmap, FSL_SAI_RCSR,
> +			   FSL_SAI_CSR_xF_W_MASK | FSL_SAI_CSR_FR, xcsr);

Using update_bits() is going to do an extra read, better to do this as:

	if (xcsr)
		regmap_write(sai->regmap, FSL_SAI_RCSR, xcsr);

otherwise we might be ignoring any of the bits that are actually clear
on read (it seems like there are some?).

> +	return IRQ_HANDLED;

I'd expect to see IRQ_NONE if we didn't actually see an interrupt
source.

--U6leaJ20qZQc29iB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNCb/AAoJELSic+t+oim94iIQAII157fGozbgumNEgl6Gz7fz
M1dRUCoWrUz630B1uCMuRLgdw2TW9fAdLrN7x+LXp2H+VxfufymllYT7m49P/HxT
arHZ1/Wo3FO5VJJL1FeNfTnRn/9xk4QSQ0WOOhKDWT463tZKkFOTlEADFBmYMu/J
vr2xPllFMLQIZENW3SLBn+ABc40zqFlMNRobnUuUpRXdtQPh8bwjIw8KKTnVPJpu
1rPPH/Tts0m+WSwB8584X5eYtzt+C++HbsUjsFQtqVYGJE0Jh3rmLlGlcUwsKvDc
4jqSxTDY0lByDF7tEcPimB+dveKm7LNxaAD36LGgOOhrxKpDkYkkl9YXTNLwPgSs
TfmAXN0d1UnAIw4v01YehS+E1064amfMILmi46O3sYbxrBcqv9C1RJZCzCOwjJ6t
KNEJVUVuEYyfQpK0gMUd5T5iU5a63p1IkSargGiuLDMw7cxe7UBsVBOOloyun/FO
jMCnVL42UZUQFZ7iNsmZuV0CuQxWi5DqCl8pNiYZZFoSinMCthYUB2Ll4wMlVLh2
6gx4ve0qG8xANJKDMBuHaNmRCL0bkhlqyqM4+rrIeTM9huwJ7jOuZbbiIHa2Th4G
ANBvvlIgOSDt3qh2bkA5CxpqZ3VfiZtVY2M0trBvfVyymRVRipgg/qWYh8Zsrfjh
oREufYGLQzoUPA/+XBSK
=TIA3
-----END PGP SIGNATURE-----

--U6leaJ20qZQc29iB--
