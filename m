Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C5571A0D7C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 11:53:45 +1000 (EST)
Date: Thu, 2 Oct 2014 11:53:38 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 3/4] sound/radeon: Move 64-bit MSI quirk from arch to
 driver
Message-ID: <20141002115338.3a0ae11f@canb.auug.org.au>
In-Reply-To: <1412210082.10667.2.camel@pasglop>
References: <1412210082.10667.2.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/c=QZ8QV/xwUIs48KR6IIKHx"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Yijing Wang <wangyijing@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/c=QZ8QV/xwUIs48KR6IIKHx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 02 Oct 2014 10:34:42 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index aa302fb..f91ba7f 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -296,7 +296,8 @@ enum {
> =20
>  /* quirks for ATI/AMD HDMI */
>  #define AZX_DCAPS_PRESET_ATI_HDMI \
> -	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB)
> +	(AZX_DCAPS_NO_TCSEL | AZX_DCAPS_SYNC_WRITE | AZX_DCAPS_POSFIX_LPIB|\
> +	 AZX_DCAPS_NO_MSI64)
> =20
>  /* quirks for Nvidia */
>  #define AZX_DCAPS_PRESET_NVIDIA \
> @@ -1505,9 +1506,14 @@ static int azx_first_init(struct azx *chip)
>  		return -ENXIO;
>  	}
> =20
> -	if (chip->msi)
> +	if (chip->msi) {
> +		if (chip->driver_caps & AZX_DCAPS_NO_MSI64) {
> +			dev_dbg(card->dev, "Disabling 64bit MSI\n");
> +			pci->no_64bit_msi =3D true;

You get the idea :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/c=QZ8QV/xwUIs48KR6IIKHx
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJULLAnAAoJEMDTa8Ir7ZwVzG0P/isbB7zvLZqybONzSR850tGb
8TsJpbXTzxrXiGJJIYwGubHJYUiOm+9lLcjMxTxILplkMd1vJ1rqB4YSVHSGe97A
f1m2B3E3ufQiqkM5fHSAOwxpZAE8kVD/7LdqPzH3Ac/VQCibEVeci5mDNJ5sUvAp
9SczWcTRFhcd9nwvs6/kX3WDEUVfb4vhl+pjsf7sg3AJU9C6xG6rHDTbkwpbGWMc
pTp6mJ/NiinnK0GFfaFiWZ1ZYBlWUVs4cKEntgr2ReztWwFRkwkydeW8mZVs55W9
RftHVoQMAms4G0wjvDAmks3PU1wjkRRvaa3SDW6jDZvd3uHOeLE2unMnBdw44Nde
IO5+RNLYWnyH+9sYg0DFwQJbA4w3USrboJFe3zgHhNiC3I99/aRUgEaUfAmgphBz
EGq4r7u1KxXS0pDYF8C52BBIbPnrE9/tQYFskEQlodKR14tcZupFGlHfXPE3eiUp
+KvKjTJnYfzfHr7EkdXqhYbbenQqNM0o9qKCcfZy7537EK0Cgo9WKrYroAXj1zwk
Z8yJgVsc3P3OYLTShI6i8Wasw/dqwJWP0q+MLhj8lhDQ7U48c96knUirEdqm8ZHE
5GBgq3/AMcNBLd5P/XW9ItST1cJ7whyhzypYbECbvwC3RVGgNHksodjg54jEGuEh
JekybX5Su1IrvqT1iDms
=1SgU
-----END PGP SIGNATURE-----

--Sig_/c=QZ8QV/xwUIs48KR6IIKHx--
