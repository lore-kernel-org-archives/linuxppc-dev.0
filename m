Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C58CD1A0BC7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 13:44:39 +1100 (AEDT)
Date: Sun, 1 Feb 2015 13:44:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH 05/15] fbdev: imsttfb: remove the dependency on PPC_OF
Message-ID: <20150201134433.729a2389@canb.auug.org.au>
In-Reply-To: <1422712065-9403-6-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-6-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AuC0a9gaWfBbfYfGjq41TyU"; protocol="application/pgp-signature"
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/AuC0a9gaWfBbfYfGjq41TyU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

On Sat, 31 Jan 2015 21:47:35 +0800 Kevin Hao <haokexin@gmail.com> wrote:
>
> The OF functionality has moved to a common place and be used by many
> archs. So we don't need to depend on PPC_OF option any more. This is
> a preparation for killing PPC_OF.

I suspect that you want to do the PPC_OF -> PPC conversion on this file
rather than just removing PPC_OF uses.

> diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
> index aae10ce74f14..91a80bb8f988 100644
> --- a/drivers/video/fbdev/imsttfb.c
> +++ b/drivers/video/fbdev/imsttfb.c
> @@ -1470,7 +1470,6 @@ static int imsttfb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>  	unsigned long addr, size;
>  	struct imstt_par *par;
>  	struct fb_info *info;
> -#ifdef CONFIG_PPC_OF
>  	struct device_node *dp;

I see no way in this file for struct device_node to be defined
(especially if CONFIG_PPC is not set).  of.h may be included
implicitly, but that is very dependent on the architecture and CONFIG_
options.

>  	dp =3D pci_device_to_OF_node(pdev);
> @@ -1478,7 +1477,6 @@ static int imsttfb_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *ent)
>  		printk(KERN_INFO "%s: OF name %s\n",__func__, dp->name);
>  	else
>  		printk(KERN_ERR "imsttfb: no OF node for pci device\n");
> -#endif /* CONFIG_PPC_OF */

This will emit the above error if CONFIG_OF is not set whereas in the
past it would not.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/AuC0a9gaWfBbfYfGjq41TyU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJUzZMWAAoJEMDTa8Ir7ZwVxEcP/005yHkV0y6U9/sVv8UyGfKw
vbe3zU/VLbYMK0VMBEdpkizPxme6me++6l/DA/tHLw9+agZea6iu5tobe5W2TiP+
u7YxopuGln/vPIMTwLjkqlANlO13DBzsHrqydZHMS49lpEpD2wSzw8D+A9xZgvk+
LOWPMXnb546kriuL2uiG9rsVq3fTXhRAIY6vp5kMIvGNaacwHBmzoCBtosYMbnOG
+1PSTx4OzwU46lpgrqA+3R1brOT3Dgqq7fuMnvCkwPK5vgwGc75euVZRSePEG6OI
KzVOSsNGMRrlnRQRSslzfKOJKuwCwLeNK4yOQdimTes7skBQSfKn6yRniCT1rvgb
hv8Z8CanYzqL9hOAwa7CfUOn2c5HHOFfuyCuh03xWDYMvd6LEHOWij0kZrBYvZIb
k+nc4y0aSbSsdTV+lCA5P/Q/hN7XCetLRsTxu6VbPfMOj7oEvYLSK2s64cWBEqGG
pQgeCvJiEJYWDVYCl8JKU9Bm0qmm1a3YtaRslEbKJLO9iA0rNM5QAK/R22bDrViA
POK+Pck7JR0n0EGUoCg+Qh5jHt3BYuO5bHx37ieIIZFaGPg3ZWmH6WB2wDfJ27Wl
JLvxod3LAtnlIBFm3nWWLjt/2Sqr5fXANAMw/nY5wuFhyUnfYXCkqL+Cq6ajTYzV
r4TX7JHoB2FWf9o68dCv
=Xg8K
-----END PGP SIGNATURE-----

--Sig_/AuC0a9gaWfBbfYfGjq41TyU--
