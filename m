Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B6901DDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 19:05:24 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1K5zn1-0004Lt-O2
	for linuxppc-dev@ozlabs.org; Tue, 10 Jun 2008 11:05:19 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Date: Tue, 10 Jun 2008 11:05:14 +0200
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<9e4733910806091430j56aeb06bpa090b0c8242e2041@mail.gmail.com>
	<200806101020.38788.jbe@pengutronix.de>
In-Reply-To: <200806101020.38788.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806101105.15080.jbe@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maybe everything in this small piece of my dts is wrong. But I don't know h=
ow
the correct way is. All I want is to define a 32MiB flash at the end if the
address space of my MPC5200B based system.

	[...]
        lpb@fe000000 {
                model =3D "fsl,lpb";
                compatible =3D "fsl,lpb";
                ranges =3D <0x0 0xfe000000 0x02000000>;
                flash@0 {
                        compatible =3D "cfi-flash";
                        reg =3D <0x00000000 0x02000000>;
                        bank-width =3D <4>;
		};
	};

The dtc gives me the follwing output:

Warning (reg_format): "reg" property in /lpb@fe000000/flash@0 has invalid l=
ength (8 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
Warning (ranges_format): "ranges" property in /lpb@fe000000 has invalid len=
gth (12 bytes) (parent #address-cells =3D=3D 1, child #address-cells =3D=3D=
 2, #size-cells =3D=3D 1)
Warning (avoid_default_addr_size): Relying on default #address-cells value =
for /lpb@fe000000/flash@0
Warning (avoid_default_addr_size): Relying on default #size-cells value for=
 /lpb@fe000000/flash@0

What does it mean?

At runtime I get:

[...]
of-flash fe000000.flash: of_flash device: fe000000-ffffffff
CFI: Found no fe000000.flash device at location zero
of-flash fe000000.flash: do_map_probe() failed
[...]

What's going wrong? Any hint?

Regards,
Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
