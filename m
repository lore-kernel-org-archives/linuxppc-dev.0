Return-Path: <DusharaJ@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id CAA80DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 11:37:01 +1100 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Fri, 20 Feb 2009 11:36:59 +1100
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054D@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40549@mailsvr>
	<3A45394FD742FA419B760BB8D398F9ED246F06@zch01exm26.fsl.freescale.net>
	<FD3D453EC8A8D5479E7E063D31E2FA44268653@zin33exm24.fsl.freescale.net>
	<DE0CCFFBFF707949BEABD4537A14ACBA0C04B4054B@mailsvr>
	<2a27d3730902182319i2c59d68dk98e7975714f80549@mail.gmail.com>
	<FD3D453EC8A8D5479E7E063D31E2FA4426866A@zin33exm24.fsl.freescale.net>
In-Reply-To: <FD3D453EC8A8D5479E7E063D31E2FA4426866A@zin33exm24.fsl.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: 'Aggrwal Poonam-B10812' <Poonam.Aggrwal@freescale.com>,
	'Timur Tabi' <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yes I now base it on mpc834x_mds.c and it works (almost) :-(

The devices are successfully probed, but I'm getting this error on the debu=
g console:

[    7.119389] mdio@24520:00 not found
[    7.161370] eth0: Could not attach to PHY
[    7.209600] IP-Config: Failed to open eth0
[    7.258879] IP-Config: Device `eth0' not found.

My mdio & Ethernet nodes are as follows (commenting out device_type below i=
s an experiment)

		mdio@24520 {
			/*device_type =3D "mdio";*/
			compatible =3D "fsl,gianfar-mdio";
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			reg =3D <24520 20>;

			phy0: ethernet-phy@0 {
				interrupt-parent =3D <&ipic>;
				interrupts =3D <3 8>;
				reg =3D <0>;
				device_type =3D "ethernet-phy";
			};
			phy1: ethernet-phy@1 {
				interrupt-parent =3D <&ipic>;
				interrupts =3D <3 8>;
				reg =3D <1>;
				device_type =3D "ethernet-phy";
			};
		};

		enet0: ethernet@24000 {
			cell-index =3D <0>;
			device_type =3D "network";
			model =3D "TSEC";
			compatible =3D "gianfar";
			reg =3D <24000 1000>;
			local-mac-address =3D [ 00 00 00 00 00 00 ];
			interrupts =3D <20 8 21 8 22 8>;
			interrupt-parent =3D <&ipic>;
			phy-handle =3D <&phy0>;
			linux,network-index =3D <0>;
		};

		enet1: ethernet@25000 {
			cell-index =3D <1>;
			device_type =3D "network";
			model =3D "TSEC";
			compatible =3D "gianfar";
			reg =3D <25000 1000>;
			local-mac-address =3D [ 00 00 00 00 00 00 ];
			interrupts =3D <23 8 24 8 25 8>;
			interrupt-parent =3D <&ipic>;
			phy-handle =3D <&phy1>;
			linux,network-index =3D <1>;
			phy-connection-type =3D "gmii";
		};

Any clues as to where I should start looking?

BTW, I assume CCing all those who replied to me is accepted/expected conduc=
t or should I avoid this and just write to the list?

Also is top posting ok? I haven't figured out how to enable '>' on bloody M=
icrosoft Outlook, for incoming plain text messages.

Thanks again for all your help.
D

-----Original Message-----
From: Aggrwal Poonam-B10812 [mailto:Poonam.Aggrwal@freescale.com]=20
Sent: Thursday, 19 February 2009 6:25 PM
To: Li Yang-R58472; Dushara Jayasinghe
Cc: linuxppc-dev@ozlabs.org
Subject: RE: Newby trying to get Ethernet going on MPC83xx series device.

Probably better would be to check the board file for  mpc834x_mds.c

I mean just cross that you probe all the buses which are on the device.
What is fsl,pq2pro-localbus? Do u have such node in dts as the
mpc8349_itx has.

> -----Original Message-----
> From: pku.leo@gmail.com [mailto:pku.leo@gmail.com] On Behalf=20
> Of Li Yang-R58472
> Sent: Thursday, February 19, 2009 12:50 PM
> To: Dushara Jayasinghe
> Cc: linuxppc-dev@ozlabs.org; Aggrwal Poonam-B10812
> Subject: Re: Newby trying to get Ethernet going on MPC83xx=20
> series device.
>=20
> On Thu, Feb 19, 2009 at 2:58 PM, Dushara Jayasinghe=20
> <DusharaJ@optiscan.com> wrote:
> > That did it.
> >
> >
> >
> > I based my board specific file on mpc834x_itx.c which had
> >
> >
> >
> > static struct of_device_id __initdata mpc834x_itx_ids[] =3D {
> >
> >                 { .compatible =3D "fsl,pq2pro-localbus", },
> >
> >                 { .compatible =3D "simple-bus", },
> >
> >                 {},
> >
> > };
> >
> >
> >
> > Don't know if this is broken?
>=20
> It's not broken as long as you have compatible =3D "simple-bus"=20
> for your soc node.
>=20
> - Leo
>=20
>=20
