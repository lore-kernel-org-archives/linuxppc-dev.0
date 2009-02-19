Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 03A1EDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 16:21:51 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n1J5LlQm025431
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 22:21:47 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n1J5LjEi010452
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 23:21:46 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.
Date: Thu, 19 Feb 2009 13:21:43 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
In-Reply-To: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: "Dushara Jayasinghe" <DusharaJ@optiscan.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Dushara Jayasinghe
> Sent: Thursday, February 19, 2009 12:27 PM
> To: 'linuxppc-dev@ozlabs.org'
> Subject: Newby trying to get Ethernet going on MPC83xx series device.
>=20
> Hi I'm having difficulty getting an Ethernet device up on a=20
> dev board with an MPX8349 controller.
> =20
> The contents of my .dts file are as follows (based on=20
> mpc8349emitx.dts):
> =20
>         soc8349@e0000000 {
>                 ...
> =20
>                 mdio@24520 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "fsl,gianfar-mdio";
>                         reg =3D <24520 20>;
> =20
>                         /* Vitesse 8201 */
>                         phy1c: ethernet-phy@1c {
>                                 interrupt-parent =3D <&ipic>;
>                                 interrupts =3D <3 8>;
>                                 reg =3D <0>;
>                                 device_type =3D "ethernet-phy";
>                         };
>                         tbi0: tbi-phy@11 {
>                                 reg =3D <11>;
>                                 device_type =3D "tbi-phy";
>                         };
>                 };
> =20
>                 mdio@25520 {
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>                         compatible =3D "fsl,gianfar-tbi";
>                         reg =3D <25520 20>;
> =20
>                         tbi1: tbi-phy@11 {
>                                 reg =3D <11>;
>                                 device_type =3D "tbi-phy";
>                         };
>                 };
> =20
>                 ethernet@24000 {
>                         cell-index =3D <0>;
>                         device_type =3D "network";
>                         model =3D "TSEC";
>                         compatible =3D "gianfar";
>                         reg =3D <24000 1000>;
>                         local-mac-address =3D [ 00 00 00 00 00 00 ];
>                         interrupts =3D <20 8 21 8 22 8>;
>                         interrupt-parent =3D <&ipic>;
>                         tbi-handle =3D <&tbi0>;
>                         phy-handle =3D <&phy1c>;
>                         linux,network-index =3D <0>;
>                 };
> =20
>                 ethernet@25000 {
>                         cell-index =3D <1>;
>                         device_type =3D "network";
>                         model =3D "TSEC";
>                         compatible =3D "gianfar";
>                         reg =3D <25000 1000>;
>                         local-mac-address =3D [ 00 00 00 00 00 00 ];
>                         interrupts =3D <23 8 24 8 25 8>;
>                         interrupt-parent =3D <&ipic>;
>                         /* Vitesse 7385 isn't on the MDIO bus */
>                         fixed-link =3D <1 1 1000 0 0>;
>                         linux,network-index =3D <1>;
>                         tbi-handle =3D <&tbi1>;
>                         phy-connection-type =3D "gmii";
>                 };
>         };
> =20
> I get the following error during the boot sequence:
> =20
> IP-Config: Device `eth0' not found
> =20
> I also found that both gfar_init (in gianfar.c) and=20
> gfar_mdio_init (in gianfar_mii.c) are called but the probe=20
> handlers of either of these devices are not executed.
> =20
> What am I missing?

Don't find any obvious problem.  I suggest you to debug gfar_of_init()
in arch/powerpc/sysdev/fsl_soc.c to see if it works correctly.

- Leo
