Return-Path: <christian.hammond@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DBFC5DDE1E
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 22:46:29 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l4LCkNPn023131
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 05:46:23 -0700 (MST)
Received: from zuk35exm20.fsl.freescale.net (zuk35exm20.ea.freescale.net
	[10.210.1.54])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l4LCkMaR005773
	for <linuxppc-dev@ozlabs.org>; Mon, 21 May 2007 07:46:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Fixed PHY problems
Date: Mon, 21 May 2007 13:46:20 +0100
Message-ID: <14B28267C4526A42BA5AC7DAA07B783866B7E7@zuk35exm20.fsl.freescale.net>
In-Reply-To: <1179656221.2714.19.camel@gentoo-jocke.transmode.se>
From: "Hammond Christian-r55079" <christian.hammond@freescale.com>
To: <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks,

Regarding the PHY set-up in the dts once the patch has been applied, how
should it be implemented?

I had edited from...

phy1:	ethernet-phy@01 {
		reg =3D <0>;
		device_type =3D "ethernet-phy";
		interface =3D <6>;
	};=20

To...

phy1:	fixed-phy@64 {
		reg =3D <d#100>;
		device_type =3D "ethernet-phy";
		interface =3D <6>;
	};

When bringing up the fixed phy in ifconfig I get the following recurring
dump and prompt access is lost. Should this implementation not just
ignore the phy set-up?

~ # ifconfig eth1 10.137.32.175 netmask 255.255.255.0 up
read wrong value : mii_id 100,mii_reg 2, base d100c120
read wrong value : mii_id 100,mii_reg 3, base d100c120
eth1: PHY is Generic MII (ffffffff)
~ # read wrong value : mii_id 100,mii_reg 4, base d100c120
read wrong value : mii_id 100,mii_reg 0, base d100c120
read wrong value : mii_id 100,mii_reg 1, base d100c120
read wrong value : mii_id 100,mii_reg 1, base d100c120
read wrong value : mii_id 100,mii_reg 5, base d100c120
eth1: Full Duplex
eth1: Speed 100BT
eth1: Link is up
read wrong value : mii_id 100,mii_reg 1, base d100c120
read wrong value : mii_id 100,mii_reg 1, base d100c120
read wrong value : mii_id 100,mii_reg 5, base d100c120
=20

-----Original Message-----
From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]=20
Sent: 20 May 2007 11:17
To: Hammond Christian-r55079
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Fixed PHY problems

On Sat, 2007-05-19 at 15:42 +0100, Hammond Christian-r55079 wrote:
> Hi Vitaly,
> =20
> I was pointed in the direction of message chain "Fixed PHY problems"
> for interfacing a fixed PHY to a 83xx UEC. Could you please forward on

> the patch you mentioned in the trail?

Vitaly sent me the patch, had to do some minor tweaking to make it
compile. Attaching the patch.

> =20
> Any ideas if the implementation  succeeded in the end?

No, the fixed PHY is on another bus than what ucc_geth expects.
See msg from me titled "Fixed  PHY and MPC832x based boards don't work"
from about a week ago.

 Jocke

> =20
> Christian Hammond
> =20
> NCSG Applications Engineer
> =20
> Tel: +44 1355 355962
> Fax: +44 1355 261790
> =20
> Freescale Semiconductor
> Kelvin Industrial Estate
> East Kilbride
> Glasgow G75 0TG
> United Kingdom
