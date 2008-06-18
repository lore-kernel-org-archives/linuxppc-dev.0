Return-Path: <mark.ware@senetas.com>
Received: from mail.senetas.com (mail.senetas.com [203.174.147.20])
	by ozlabs.org (Postfix) with ESMTP id A182DDDED2
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 22:33:29 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: CPM2 mii-bitbang: Allowing mdio on port pins other than port C
Date: Wed, 18 Jun 2008 22:21:25 +1000
Message-ID: <49B96DF39F2CDD499DA8B9C7753A060D25B387@stamp.senetas.com>
In-Reply-To: <200806161052.53268.laurentp@cse-semaphore.com>
References: <49B96DF39F2CDD499DA8B9C7753A060D2275FC@stamp.senetas.com>
	<200806161052.53268.laurentp@cse-semaphore.com>
From: "Mark Ware" <mark.ware@senetas.com>
To: "Laurent Pinchart" <laurentp@cse-semaphore.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Laurent,


> -----Original Message-----
> From: Laurent Pinchart [mailto:laurentp@cse-semaphore.com]=20
> Sent: Monday, 16 June 2008 18:53
> To: linuxppc-dev@ozlabs.org
> Cc: Mark Ware
> Subject: Re: CPM2 mii-bitbang: Allowing mdio on port pins=20
> other than port C
>=20
> Hi Mark,
>=20
> On Monday 16 June 2008 08:19, Mark Ware wrote:
> > Hello,
> >=20
> > I am preparing a board port (from 2.4.18!) for a proprietary board=20
> > which has it's mdio on a different port than mdc.  The current=20
> > mii-bitbang driver in fs_enet assumes both pins are=20
> connected to port=20
> > C.  I have created a fairly simple patch to make this more=20
> flexible,=20
> > but I'm new to device trees and am unsure how best to describe the=20
> > situation in the dts.
> >=20
> > The current mdio node for CPM2 looks something like:
> >=20
> > mdio@10d40 {
> >   device_type =3D "mdio";
> >   compatible =3D "fsl,cpm2-mdio-bitbang";
> >   #address-cells =3D <1>;
> >   #size-cells =3D <0>
> >   reg =3D <0x10d40 0x14>;
> >   fsl,mdio-pin =3D <12>;
> >   fsl,mdc-pin =3D <15>;
> > }
> >=20
> > I have made mdio work on our board by adding a second reg range and=20
> > using the first one for mdc and the second one for mdio:
> >=20
> >   reg =3D <0x10d40 0x14 0x10d60 0x14>;  // mdc=3Dport D, mdio=3Dport =
A
> >   fsl,mdio-pin =3D <12>;    		  // PD12
> >   fsl,mdc-pin =3D <15>;     		  // PC15
> >=20
> > The code remains backwards compatible, in that if only one=20
> reg range=20
> > is present it is used for both.
> >=20
> > Is this a valid (and acceptable) way to extend the reg property?
>=20
> It is. Sergej Stepanov submitted similar patches some times=20
> ago. You can find them at
>=20
> http://www.spinics.net/lists/netdev/msg45778.html
> http://www.spinics.net/lists/netdev/msg47159.html
>=20
> > Is their a cleaner way I should look at?
>=20
> Using the GPIO lib might be cleaner. Have a look at=20
> http://www.nabble.com/-PATCH-0-2--MDIO-on-GPIO-support-for-the
> -fs_enet-driver-ts17468958.html
> for a patch.
>=20

Thanks for the links.  It looks like I should have been searching in
netdev not powerpc for this.

I will look at Sergej's patch and perhaps submit a merged version, but
with the GPIO version likely to be merged is there much point?  The GPIO
lib method appears to be a more generic replacement.

Regards,
Mark
