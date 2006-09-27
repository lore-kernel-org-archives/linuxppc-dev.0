Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 0ACF967B6F
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 23:55:02 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 10/11] Add MPC8360EMDS board support
Date: Wed, 27 Sep 2006 15:54:56 +0200
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9399B4A7F@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
	"Vitaly Bordug" <vbordug@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 >=20
> I'm adding MURAM as a new node under QE bus.  Please comment.
>                 muram@10000 {
>                         device_type =3D "memory";
>                         ranges =3D <0 00010000 0000c000>;
>=20
>                         data-only@0{
>                                 reg =3D <0 c000>;
>                         };
>                 };

while you are at it, I think you should add support for the ASSIGN PAGE
command that can relocate
the parameter RAM used by UCC, SPI etc. As it is now the third(8400) and
fourth(100) value
in reg below is ignored.
	ucc@2000 {
		device_type =3D "network";
		compatible =3D "ucc_geth";
		model =3D "UCC";
		device-id =3D <1>;
		reg =3D <2000 200 8400 100>;
MPC832x only has 16KB of parameter RAM and needs to move this to lower
addresses.=20
