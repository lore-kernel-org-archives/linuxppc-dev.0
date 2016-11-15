Return-Path: <tomi.valkeinen@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ5Fm0yL5zDvWr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 22:46:35 +1100 (AEDT)
Subject: Re: [PATCH v2] Fix loading of module radeonfb on PowerMac
To: Mathieu Malaterre <malat@debian.org>, <linux-fbdev@vger.kernel.org>
References: <1479153557-20849-1-git-send-email-malat@debian.org>
CC: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <c447ef6d-adf0-651f-e7a6-5f340e957df5@ti.com>
Date: Tue, 15 Nov 2016 13:46:10 +0200
MIME-Version: 1.0
In-Reply-To: <1479153557-20849-1-git-send-email-malat@debian.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jm4563IB5xILfhwdtXWjFTvcWh01dKk9l"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--jm4563IB5xILfhwdtXWjFTvcWh01dKk9l
Content-Type: multipart/mixed; boundary="iMCSaRpwaLpECA0SNONQadmAxDl9X9uuf";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Mathieu Malaterre <malat@debian.org>, linux-fbdev@vger.kernel.org
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Message-ID: <c447ef6d-adf0-651f-e7a6-5f340e957df5@ti.com>
Subject: Re: [PATCH v2] Fix loading of module radeonfb on PowerMac
References: <1479153557-20849-1-git-send-email-malat@debian.org>
In-Reply-To: <1479153557-20849-1-git-send-email-malat@debian.org>

--iMCSaRpwaLpECA0SNONQadmAxDl9X9uuf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/11/16 21:59, Mathieu Malaterre wrote:
> When the linux kernel is build with (typical kernel ship with Debian
> installer):
>=20
> CONFIG_FB_OF=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_FB_RADEON=3Dm
>=20
> The offb driver takes precedence over module radeonfb. It is then
> impossible to load the module, error reported is:
>=20
> [   96.551486] radeonfb 0000:00:10.0: enabling device (0006 -> 0007)
> [   96.551526] radeonfb 0000:00:10.0: BAR 0: can't reserve [mem 0x98000=
000-0x9fffffff pref]
> [   96.551531] radeonfb (0000:00:10.0): cannot request region 0.
> [   96.551545] radeonfb: probe of 0000:00:10.0 failed with error -16
>=20
> This patch reproduce the behavior of the module radeon, so as to make i=
t
> possible to load radeonfb when offb is first loaded.
>=20
> It should be noticed that `offb_destroy` is never called which explain =
the
> need to skip error detection on the radeon side.
>=20
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Link: https://bugs.debian.org/826629#57
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D119741
> Suggested-by: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
> ---

Please always have a changelog in patch new revisions. For individual
patches, you can insert the changes here.

>  drivers/video/fbdev/aty/radeon_base.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbde=
v/aty/radeon_base.c
> index 218339a..84d634b 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -2259,6 +2259,22 @@ static struct bin_attribute edid2_attr =3D {
>  	.read	=3D radeon_show_edid2,
>  };
> =20
> +static int radeon_kick_out_firmware_fb(struct pci_dev *pdev)
> +{
> +	struct apertures_struct *ap;
> +
> +	ap =3D alloc_apertures(1);
> +	if (!ap)
> +		return -ENOMEM;
> +
> +	ap->ranges[0].base =3D pci_resource_start(pdev, 0);
> +	ap->ranges[0].size =3D pci_resource_len(pdev, 0);
> +
> +	remove_conflicting_framebuffers(ap, KBUILD_MODNAME, false);
> +	kfree(ap);
> +
> +	return 0;
> +}
> =20
>  static int radeonfb_pci_register(struct pci_dev *pdev,
>  				 const struct pci_device_id *ent)
> @@ -2314,19 +2330,27 @@ static int radeonfb_pci_register(struct pci_dev=
 *pdev,
>  	rinfo->fb_base_phys =3D pci_resource_start (pdev, 0);
>  	rinfo->mmio_base_phys =3D pci_resource_start (pdev, 2);
> =20
> +	ret =3D radeon_kick_out_firmware_fb(pdev);
> +	if (ret)
> +		return ret;
> +
>  	/* request the mem regions */
>  	ret =3D pci_request_region(pdev, 0, "radeonfb framebuffer");
>  	if (ret < 0) {
>  		printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
>  			pci_name(rinfo->pdev));
> +#ifndef CONFIG_PPC
>  		goto err_release_fb;
> +#endif

If this is not a problem on PPC, the kernel shouldn't print an error eith=
er.

>  	}
> =20
>  	ret =3D pci_request_region(pdev, 2, "radeonfb mmio");
>  	if (ret < 0) {
>  		printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
>  			pci_name(rinfo->pdev));
> +#ifndef CONFIG_PPC
>  		goto err_release_pci0;
> +#endif

Same here.

>  	}
> =20
>  	/* map the regions */
> @@ -2511,10 +2535,12 @@ static int radeonfb_pci_register(struct pci_dev=
 *pdev,
>  	iounmap(rinfo->mmio_base);
>  err_release_pci2:
>  	pci_release_region(pdev, 2);
> +#ifndef CONFIG_PPC
>  err_release_pci0:
>  	pci_release_region(pdev, 0);
>  err_release_fb:
>          framebuffer_release(info);
> +#endif
>  err_disable:
>  err_out:
>  	return ret;
>=20

So I don't quite follow what's going on here. Why the CONFIG_PPC
conditionals? Is this problem only with OFFB and only with PPC?

And I think the code itself should have comments on this rather strange
behavior: the driver fails to get HW resources, but decides to ignore
the failure on PPC.

 Tomi


--iMCSaRpwaLpECA0SNONQadmAxDl9X9uuf--

--jm4563IB5xILfhwdtXWjFTvcWh01dKk9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYKvWCAAoJEPo9qoy8lh71XiUP/jzJk6QXKvLGydV/QDUYF+aC
mWpZBTJB6ABKJGZG081hWCzEYgy4CIA7Zt7vat94xnIh0GD05JRohXzgWpBwFTXv
250nYqO5ryatbbQmlLbvopSsy6T5W8YQX5P0SBx3GQDssaJ75ji4E/urYposuUig
2KGflFLV1rHw84GbfS2hdAhy/2yLgtoAK8j0WTm345th0chnnumC09SXJawqhzMH
X0DrT0AmsOhmTxZsHvcA7oU2UAC7JHNcODXMk1Fy+DBnySBkTrjgZAuAWZCFJWf3
Ycivrqy6Ecv1vK/SC5RXE7Z62qgQWuDMulrAlNH0eOp2OS9gtvyRhg3yS8acq29a
nuSlfxW9LnlSGDKXz8raAmdU1S1j1NN2K/6iuGygWClL8e15koPOojC8Dj9/T1UF
FA9XQLGIMlcxsCzu7yv+7ukYf/t/Bsr9obS/TpPjhVNDj6ZARMVuiXZVRUM+9JPY
rfgM+SiKDXboeLunlLMtOPSveI0Qd7DWPN+tIJGdbbfqEMjWUhuhNX1L61bttlxp
3qIApsKwK4fSWkfStgw76wwqDsCA3nt3tTNAR0dyvak6Zkd3kqYA18lozfRlYCAM
cVzqfDyM8yqNofbmYra8BWZg6e069Q5HYEfprTDKYGeq/1i7TGIyJVw1Opibhd2J
aOqO7Il3DXESG9bT/Gfe
=RK1v
-----END PGP SIGNATURE-----

--jm4563IB5xILfhwdtXWjFTvcWh01dKk9l--
