Return-Path: <DusharaJ@optiscan.com>
Received: from mail.optiscan.com (mail.optiscan.com [203.26.112.1])
	by ozlabs.org (Postfix) with ESMTP id 9A8B6DDF02
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 15:11:25 +1100 (EST)
From: Dushara Jayasinghe <DusharaJ@optiscan.com>
To: "'avorontsov@ru.mvista.com'" <avorontsov@ru.mvista.com>
Date: Tue, 3 Mar 2009 15:11:23 +1100
Subject: RE: Can't load module spi_mpc83xx : No such device
Message-ID: <DE0CCFFBFF707949BEABD4537A14ACBA0C083C19F8@mailsvr>
References: <DE0CCFFBFF707949BEABD4537A14ACBA0C04B40564@mailsvr>
	<20090227125456.GA21435@oksana.dev.rtsoft.ru>
In-Reply-To: <20090227125456.GA21435@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All,

> Linus' tree is still lacking few patches for spi_mpc83xx driver, the
> patches makes spi_mpc83xx work with the device tree directly.

I modified the spi_mpc83xx to work with the device tree using mpc52xx_psc_s=
pi.c as a guide.=20
However, the device->dev->platform_data member is NULL (I thought the child=
 node would provide that).=20
What am I missing?

I'm trying to create the SPI driver as a loadable module which will be used=
 by the m25p80 chip driver (drivers/mtd/devices) which also will be a loada=
ble module. Am I on the right track?

> [...]
> > Part of my device tree is as follows:
> >
> > 	soc8349@e0000000 {
> > 		...
> > 		spi@7000 {
> > 			#address-cells =3D <1>;
> > 			#size-cells =3D <0>;
> > 			compatible =3D "fsl,spi";
> > 			reg =3D <0x7000 0x1000>;
> > 			interrupts =3D <0x10 0x8>;
> > 			interrupt-parent =3D < &ipic >;
>=20
> You don't seem to have any chip-selects (i.e. gpios =3D <>) specified.

Could you elaborate on this point please? I couldn't find any examples of g=
pios defined within SPI nodes.

[...]

> >
> > 			m25p40@2 {
> > 				compatible =3D "m25p80";
> > 				spi-max-frequency =3D <25000000>;
> > 				reg =3D <2>;

Thanks again.
D
