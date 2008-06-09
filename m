Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 58DBFDDF16
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 02:34:08 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Mon, 9 Jun 2008 18:31:24 +0200
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
In-Reply-To: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806091831.25200.jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 08 June 2008 21:08, Jon Smirl wrote:
> What about the flash on the local bus?  Could we use something like
> this, or the same without the partition data?
>
> 	lpb@ff000000 {
> 		compatible =3D "fsl,lpb";
> 		ranges =3D <0 ff000000 01000000>;
>
> 		flash@00000000 {
> 			compatible =3D "cfi-flash";
> 			reg =3D <00000000 01000000>;
> 			bank-width =3D <2>;
> 			#size-cells =3D <1>;
> 			#address-cells =3D <1>;
> 			partition@0 {
> 				label =3D "ubootl";
> 				reg =3D <00000000 00040000>;
> 			};
> 			partition@40000 {
> 				label =3D "kernel";
> 				reg =3D <00040000 001c0000>;
> 			};
> 			partition@200000 {
> 				label =3D "jffs2";
> 				reg =3D <00200000 00D00000>;
> 			};
> 			partition@f00000 {
> 				label =3D "uboot";
> 				reg =3D <00f00000 00040000>;
> 			};
> 			partition@f40000 {
> 				label =3D "oftree";
> 				reg =3D <00f40000 00040000>;
> 			};
> 			partition@f80000 {
> 				label =3D "space";
> 				reg =3D <00f80000 00080000>;
> 			};
> 		};
> 	};

Hmm, I tried with these setting (and many others) to make the flash on my=20
board work again.
But the physmap_of.c driver always fails. It tries to request the region=20
0xfe000000 to 0x00000000 (my flash is 32MiB in size at 0xfe00000 to=20
0xffffffff) and fails badly. What are the correct settings in the OFTree to=
=20
make the physmap_of.c driver work?

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
