Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (unknown [24.220.19.6])
	by ozlabs.org (Postfix) with ESMTP id 975B92BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Oct 2004 00:14:26 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Fri, 8 Oct 2004 09:02:08 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB7B@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <alebas@televes.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Bridge, promiscous mode andCPM2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Assuming CPM2 =3D> 82xx or 85xx CPU.

In the old 8260_io/fcc_enet.c	the set_multicast_list=20
function is present, bu has an early return nine lines=20
in. If you delete that return, promiscous mode works great.

I have no idea who or why that early return was put in,=20
but it does disable multicast and promiscous mode=20
on the FCC ethernets.

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of=20
> alebas@televes.com
> Sent: Friday, October 08, 2004 04:29
> To: linuxppc-embedded@ozlabs.org
> Subject: Bridge, promiscous mode andCPM2
>=20
>=20
>=20
> Hi,
>=20
> I would need confirmation on this.
>=20
> As long as I have seen, bridge's stuff in kernel sets=20
> promiscous mode by using dev_set_promiscuity, which arrives=20
> in the execution of fcc_enet's set_multicast_list.
>=20
> But this function is not developed, so the promiscous mode is=20
> never set in the FCC Ethernet Mode Register.
>=20
> Am I right? By now, I only needs the promiscous mode, so,=20
> could it be a solution to implement only this functionality=20
> in the set_multicast_list function? Do I need to consider=20
> anything else?
>=20
> Best regards
>=20
> Alexandre Bastos _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org=20
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20
