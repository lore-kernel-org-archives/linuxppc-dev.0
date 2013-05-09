Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4C61C2C00E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 20:41:48 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id lj1so2033408pab.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 May 2013 03:41:45 -0700 (PDT)
Date: Thu, 9 May 2013 18:41:37 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Minghuan Lian <Minghuan.Lian@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add property 'reg' to pcie@0 node
Message-ID: <20130509104137.GG2263@pek-khao-d1.corp.ad.wrs.com>
References: <1368004641-12405-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ahP6B03r4gLOj5uD"
In-Reply-To: <1368004641-12405-1-git-send-email-Minghuan.Lian@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ahP6B03r4gLOj5uD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2013 at 05:17:21PM +0800, Minghuan Lian wrote:
> The property 'reg' is used to identify the PCIe device. if there is
> no 'reg' the PCI driver can not find PCI device node corresponding
> to PCI controller, and can not map the interrupts. So all the INTx
> interrupts can not be used.

The fix for this issue has already been merged into upstream kernel.
commit 9e2ecdbba3b0745f9ed454ab86961e3ccf9dc224
Author: Kevin Hao <haokexin@gmail.com>
Date:   Sun Apr 14 13:40:13 2013 +0800

    powerpc/fsl-booke: add the reg prop for pci bridge device node for T4/B4
   =20
    The reg property in the pci bridge device node is used to bind this
    device node to the pci bridge device. Then all the pci devices under
    this bridge could use the interrupt maps defined in this device node
    to do the irq translation. So if this property is missed, the pci
    traditional irq mechanism will not work.
   =20
    Signed-off-by: Kevin Hao <haokexin@gmail.com>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Thanks,
Kevin

>=20
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 1 +
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 ++++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot=
/dts/fsl/b4si-post.dtsi
> index 7399154..d82c8da 100644
> --- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
> @@ -49,6 +49,7 @@
>  	interrupts =3D <20 2 0 0>;
>  	fsl,iommu-parent =3D <&pamu0>;
>  	pcie@0 {
> +		reg =3D <0 0 0 0 0>;
>  		#interrupt-cells =3D <1>;
>  		#size-cells =3D <2>;
>  		#address-cells =3D <3>;
> diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/b=
oot/dts/fsl/t4240si-post.dtsi
> index bd611a9..3a6179f 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> @@ -48,6 +48,7 @@
>  	bus-range =3D <0x0 0xff>;
>  	interrupts =3D <20 2 0 0>;
>  	pcie@0 {
> +		reg =3D <0 0 0 0 0>;
>  		#interrupt-cells =3D <1>;
>  		#size-cells =3D <2>;
>  		#address-cells =3D <3>;
> @@ -74,6 +75,7 @@
>  	bus-range =3D <0 0xff>;
>  	interrupts =3D <21 2 0 0>;
>  	pcie@0 {
> +		reg =3D <0 0 0 0 0>;
>  		#interrupt-cells =3D <1>;
>  		#size-cells =3D <2>;
>  		#address-cells =3D <3>;
> @@ -100,6 +102,7 @@
>  	bus-range =3D <0x0 0xff>;
>  	interrupts =3D <22 2 0 0>;
>  	pcie@0 {
> +		reg =3D <0 0 0 0 0>;
>  		#interrupt-cells =3D <1>;
>  		#size-cells =3D <2>;
>  		#address-cells =3D <3>;
> @@ -126,6 +129,7 @@
>  	bus-range =3D <0x0 0xff>;
>  	interrupts =3D <23 2 0 0>;
>  	pcie@0 {
> +		reg =3D <0 0 0 0 0>;
>  		#interrupt-cells =3D <1>;
>  		#size-cells =3D <2>;
>  		#address-cells =3D <3>;
> --=20
> 1.8.1.2
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

--ahP6B03r4gLOj5uD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJRi31hAAoJEJNY7TDerrFxYI0H/iRQGv7UnRjQsgFIU8NnKdsz
XB1fURZiHmlGpZqtKPIjogiYoCugKUVir9EyQ+icpuuftOr4C37Epqr+7RkA/d87
UHj3UQUt8lmO8V+GfRy+W1VT1D8eniDfMbkzV1DSDd7Z0JKqaExQGlfdCNC04ssP
4VCy2Jm3fWZF5T8Yc80nYRHj8VgBrFbQGk90fE0o+y3x/d74YaUdGZKKiy3eQp/B
rN4Ev5fjty69zSkGlijboxQ+h21qQb21bDlslNltDd/rrRa3sdocxRYJ7pLkfPUX
oqeUc7veh5CVUfuRpPp08v/evCRu5lObFtmyg2qyzJVEX/o06tHLshBoyPu3F/c=
=bQmN
-----END PGP SIGNATURE-----

--ahP6B03r4gLOj5uD--
