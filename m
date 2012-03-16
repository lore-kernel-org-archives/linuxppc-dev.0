Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4B1A3B70FD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 02:24:44 +1100 (EST)
Subject: Re: [PATCH] p1010rdb: gianfar config does not have queues.
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110811142500.GD4926@sgi.com>
Date: Fri, 16 Mar 2012 10:20:06 -0500
Message-Id: <22426CFF-79AE-4F2B-86C2-EB90F70630B0@kernel.crashing.org>
References: <20110811142500.GD4926@sgi.com>
To: Aggrwal Poonam-B10812 <b10812@freescale.com>
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


On Aug 11, 2011, at 9:25 AM, Robin Holt wrote:

> If I have the the fsl,num_rx_queues and fsl,num_tx_queues properties
> defined in the p1010's device tree file, I get a kernel panic very
> shortly after boot.  The failure indicates we are configuring the
> gianfar.c driver for a queue depth greater than actual.  Removing the
> properties got the problem resolved.
>=20
> Signed-off-by: Robin Holt <holt@sgi.com>
> To: U Bhaskar-B22300 <B22300@freescale.com>
> Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>

Poonam,

Can you comment on this patch, does it look correct?

- k

>=20
> diff --git a/arch/powerpc/boot/dts/p1010si.dtsi =
b/arch/powerpc/boot/dts/p1010si.dtsi
> index 7f51104..91566aa 100644
> --- a/arch/powerpc/boot/dts/p1010si.dtsi
> +++ b/arch/powerpc/boot/dts/p1010si.dtsi
> @@ -258,8 +258,6 @@
> 			device_type =3D "network";
> 			model =3D "eTSEC";
> 			compatible =3D "fsl,etsec2";
> -			fsl,num_rx_queues =3D <0x8>;
> -			fsl,num_tx_queues =3D <0x8>;
> 			local-mac-address =3D [ 00 00 00 00 00 00 ];
> 			interrupt-parent =3D <&mpic>;
>=20
> @@ -280,8 +278,6 @@
> 			device_type =3D "network";
> 			model =3D "eTSEC";
> 			compatible =3D "fsl,etsec2";
> -			fsl,num_rx_queues =3D <0x8>;
> -			fsl,num_tx_queues =3D <0x8>;
> 			local-mac-address =3D [ 00 00 00 00 00 00 ];
> 			interrupt-parent =3D <&mpic>;
>=20
> @@ -302,8 +298,6 @@
> 			device_type =3D "network";
> 			model =3D "eTSEC";
> 			compatible =3D "fsl,etsec2";
> -			fsl,num_rx_queues =3D <0x8>;
> -			fsl,num_tx_queues =3D <0x8>;
> 			local-mac-address =3D [ 00 00 00 00 00 00 ];
> 			interrupt-parent =3D <&mpic>;
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
