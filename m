Return-Path: <B21284@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by ozlabs.org (Postfix) with ESMTP id 11D25B70A5
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 17:39:46 +1000 (EST)
Received: from mail115-tx2 (localhost.localdomain [127.0.0.1])	by
	mail115-tx2-R.bigfish.com (Postfix) with ESMTP id 96C5F11E8141	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:39:43 +0000 (UTC)
Received: from TX2EHSMHS042.bigfish.com (unknown [10.9.14.241])	by
	mail115-tx2.bigfish.com (Postfix) with ESMTP id 24C01E0053	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 07:39:43 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o6Q7df47003481	for
	<linuxppc-dev@ozlabs.org>; Mon, 26 Jul 2010 00:39:42 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o6Q7q9VM018444	for <linuxppc-dev@ozlabs.org>;
	Mon, 26 Jul 2010 02:52:10 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: [PATCH 6/6] DTS: add SPI flash(s25fl128p01) support on p4080ds
	and mpc8536ds board
Date: Mon, 26 Jul 2010 15:39:38 +0800
Message-ID: <73839B4A0818E747864426270AC332C30540064C@zmy16exm20.fsl.freescale.net>
In-Reply-To: <20100726003501.GE25419@angua.secretlab.ca>
References: <1279591705-7574-1-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-2-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-3-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-4-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-5-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-6-git-send-email-Mingkai.hu@freescale.com>
	<1279591705-7574-7-git-send-email-Mingkai.hu@freescale.com>
	<20100726003501.GE25419@angua.secretlab.ca>
From: Hu Mingkai-B21284 <B21284@freescale.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, Zang Roy-R61911 <R61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of=20
> Grant Likely
> Sent: Monday, July 26, 2010 8:35 AM
> To: Hu Mingkai-B21284
> Cc: linuxppc-dev@ozlabs.org; galak@kernel.crashing.org; Zang=20
> Roy-R61911
> Subject: Re: [PATCH 6/6] DTS: add SPI flash(s25fl128p01)=20
> support on p4080ds and mpc8536ds board
>=20
> On Tue, Jul 20, 2010 at 10:08:25AM +0800, Mingkai Hu wrote:
> > Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> > ---
> >  arch/powerpc/boot/dts/mpc8536ds.dts |   52=20
> +++++++++++++++++++++++++++++++++++
> >  arch/powerpc/boot/dts/p4080ds.dts   |    9 ++----
> >  2 files changed, 55 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts=20
> > b/arch/powerpc/boot/dts/mpc8536ds.dts
> > index 815cebb..e5d07ec 100644
> > --- a/arch/powerpc/boot/dts/mpc8536ds.dts
> > +++ b/arch/powerpc/boot/dts/mpc8536ds.dts
> > @@ -108,6 +108,58 @@
> >  			};
> >  		};
> > =20
> > +		spi@7000 {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			compatible =3D "fsl,espi";
> > +			reg =3D <0x7000 0x1000>;
> > +			interrupts =3D <59 0x2>;
> > +			interrupt-parent =3D <&mpic>;
> > + 			fsl,espi-num-chipselects =3D <4>;
> > +
> > + 			flash@0 {
> > +				#address-cells =3D <1>;
> > +				#size-cells =3D <1>;
> > + 				compatible =3D "spansion,s25sl12801";
>=20
> whitespace inconsitencies
>=20
> > +				reg =3D <0>;
> > +				spi-max-frequency =3D <40000000>;
> > +				partition@u-boot {
> > +					label =3D "u-boot";
> > +					reg =3D <0x00000000 0x00100000>;
> > +					read-only;
> > +				};
> > +				partition@kernel {
> > +					label =3D "kernel";
> > +					reg =3D <0x00100000 0x00500000>;
> > +					read-only;
> > +				};
> > +				partition@dtb {
> > +					label =3D "dtb";
> > +					reg =3D <0x00600000 0x00100000>;
> > +					read-only;
> > +				};
> > +				partition@fs {
> > +					label =3D "file system";
> > +					reg =3D <0x00700000 0x00900000>;
> > +				};
> > +			};
> > + 			flash@1 {
> > + 				compatible =3D "spansion,s25sl12801";
> > +				reg =3D <1>;
> > +				spi-max-frequency =3D <40000000>;
> > +			};
> > + 			flash@2 {
> > + 				compatible =3D "spansion,s25sl12801";
> > +				reg =3D <2>;
> > +				spi-max-frequency =3D <40000000>;
> > +			};
> > + 			flash@3 {
> > + 				compatible =3D "spansion,s25sl12801";
>=20
> whitespace inconsitencies
>=20
> > +				reg =3D <3>;
> > +				spi-max-frequency =3D <40000000>;
> > +			};
> > +		};
> > +
> >  		dma@21300 {
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <1>;
> > diff --git a/arch/powerpc/boot/dts/p4080ds.dts=20
> > b/arch/powerpc/boot/dts/p4080ds.dts
> > index 6b29eab..ac7dd23 100644
> > --- a/arch/powerpc/boot/dts/p4080ds.dts
> > +++ b/arch/powerpc/boot/dts/p4080ds.dts
> > @@ -236,22 +236,19 @@
> >  		};
> > =20
> >  		spi@110000 {
> > -			cell-index =3D <0>;
> >  			#address-cells =3D <1>;
> >  			#size-cells =3D <0>;
> >  			compatible =3D "fsl,espi";
> >  			reg =3D <0x110000 0x1000>;
> >  			interrupts =3D <53 0x2>;
> >  			interrupt-parent =3D <&mpic>;
> > -			espi,num-ss-bits =3D <4>;
> > -			mode =3D "cpu";
> > + 			fsl,espi-num-chipselects =3D <4>;
> > =20
> > -			fsl_m25p80@0 {
> > + 			flash@0 {
> >  				#address-cells =3D <1>;
> >  				#size-cells =3D <1>;
> > -				compatible =3D "fsl,espi-flash";
> > + 				compatible =3D "spansion,s25sl12801";
>=20
> whitespace inconsistencies
>=20

I use checkpatch to check the patch, but don't find any warnings and
errors.
so what's the whitespace inconsistencies means?

hmk@rock:~/public/linux-2.6$ ./scripts/checkpatch.pl
patch/public/v1/0006-DTS-add-SPI-flash-s25fl128p01-support-on-p4080ds-an
d.patch
total: 0 errors, 0 warnings, 83 lines checked

patch/public/v1/0006-DTS-add-SPI-flash-s25fl128p01-support-on-p4080ds-an
d.patch has no obvious style problems and is ready for submission.

Thanks,
Mingkai
