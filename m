Return-Path: <DusharaJ@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 0B02CDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 15:56:44 +1100 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Fri, 27 Feb 2009 15:56:41 +1100
Subject: Can't load module spi_mpc83xx : No such device
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40564@mailsvr>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I'm using linux version 2.6.29-rc5.

I've compiled the SPI diver (spi_mpc83xx.c) as a module, but it fails the l=
oad with a "No such device" error.

I've managed to track it down to platform_driver_probe() in drivers/base/pl=
atform.c=20
which returns -ENODEV because a device list is empty.

Not sure what I'm doing wrong.=20

Part of my device tree is as follows:

	soc8349@e0000000 {
		...
		spi@7000 {
			#address-cells =3D <1>;
			#size-cells =3D <0>;
			compatible =3D "fsl,spi";
			reg =3D <0x7000 0x1000>;
			interrupts =3D <0x10 0x8>;
			interrupt-parent =3D < &ipic >;

			m25p40@2 {
				compatible =3D "m25p80";
				spi-max-frequency =3D <25000000>;
				reg =3D <2>;
			};
		};
		...
	};

Thanks
D
