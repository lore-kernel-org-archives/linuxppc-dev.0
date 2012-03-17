Return-Path: <B10812@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 193E5B6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 16:37:16 +1100 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Chauhan Pankaj-B32944
 <B32944@freescale.com>, Srivastava Rajan-B34330 <B34330@freescale.com>
Subject: RE: [PATCH] p1010rdb: gianfar config does not have queues.
Date: Sat, 17 Mar 2012 05:37:06 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D09D429@039-SN2MPN1-013.039d.mgd.msft.net>
References: <20110811142500.GD4926@sgi.com>
 <22426CFF-79AE-4F2B-86C2-EB90F70630B0@kernel.crashing.org>
In-Reply-To: <22426CFF-79AE-4F2B-86C2-EB90F70630B0@kernel.crashing.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>,
 U Bhaskar-B22300 <B22300@freescale.com>, Robin Holt <holt@sgi.com>,
 Eric Dumazet <eric.dumazet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Pankaj, Rajan

DO you have any comments on the below patch of gianfar?
> > -			fsl,num_rx_queues =3D <0x8>;
> > -			fsl,num_tx_queues =3D <0x8>;
Have been removed from P1010RDB device tree to avoid a kernel panic.

Kumar, as such I see this is the old dts format. Also in the latest sdk tre=
e these properties are defined, not sure it is working on P1010RDB.
I can check on this and get back.


Regards
Poonam

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Friday, March 16, 2012 8:50 PM
> To: Aggrwal Poonam-B10812
> Cc: Robin Holt; U Bhaskar-B22300; PPC list; Eric Dumazet
> Subject: Re: [PATCH] p1010rdb: gianfar config does not have queues.
>=20
>=20
> On Aug 11, 2011, at 9:25 AM, Robin Holt wrote:
>=20
> > If I have the the fsl,num_rx_queues and fsl,num_tx_queues properties
> > defined in the p1010's device tree file, I get a kernel panic very
> > shortly after boot.  The failure indicates we are configuring the
> > gianfar.c driver for a queue depth greater than actual.  Removing the
> > properties got the problem resolved.
> >
> > Signed-off-by: Robin Holt <holt@sgi.com>
> > To: U Bhaskar-B22300 <B22300@freescale.com>
> > Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> > Cc: Eric Dumazet <eric.dumazet@gmail.com>
>=20
> Poonam,
>=20
> Can you comment on this patch, does it look correct?
>=20
> - k
>=20
> >
> > diff --git a/arch/powerpc/boot/dts/p1010si.dtsi
> > b/arch/powerpc/boot/dts/p1010si.dtsi
> > index 7f51104..91566aa 100644
> > --- a/arch/powerpc/boot/dts/p1010si.dtsi
> > +++ b/arch/powerpc/boot/dts/p1010si.dtsi
> > @@ -258,8 +258,6 @@
> > 			device_type =3D "network";
> > 			model =3D "eTSEC";
> > 			compatible =3D "fsl,etsec2";
> > -			fsl,num_rx_queues =3D <0x8>;
> > -			fsl,num_tx_queues =3D <0x8>;
> > 			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > 			interrupt-parent =3D <&mpic>;
> >
> > @@ -280,8 +278,6 @@
> > 			device_type =3D "network";
> > 			model =3D "eTSEC";
> > 			compatible =3D "fsl,etsec2";
> > -			fsl,num_rx_queues =3D <0x8>;
> > -			fsl,num_tx_queues =3D <0x8>;
> > 			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > 			interrupt-parent =3D <&mpic>;
> >
> > @@ -302,8 +298,6 @@
> > 			device_type =3D "network";
> > 			model =3D "eTSEC";
> > 			compatible =3D "fsl,etsec2";
> > -			fsl,num_rx_queues =3D <0x8>;
> > -			fsl,num_tx_queues =3D <0x8>;
> > 			local-mac-address =3D [ 00 00 00 00 00 00 ];
> > 			interrupt-parent =3D <&mpic>;
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
