Return-Path: <st@iss.tu-darmstadt.de>
Received: from lnx500.hrz.tu-darmstadt.de (lnx500.hrz.tu-darmstadt.de
	[130.83.156.225])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0256AB7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Apr 2010 08:29:17 +1000 (EST)
Received: from mailserver3.hrz.tu-darmstadt.de (lnx505.hrz.tu-darmstadt.de
	[130.83.156.234])
	by lnx500.hrz.tu-darmstadt.de (8.14.2/8.14.2/HRZ/PMX) with ESMTP id
	o34MTCWv018634
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Apr 2010 00:29:12 +0200
	(envelope-from st@iss.tu-darmstadt.de)
Received: from [213.188.117.234] (helo=ligeia.localnet)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <st@iss.tu-darmstadt.de>)
	id 1NyYJc-0007Fk-B0
	for linuxppc-dev@lists.ozlabs.org; Mon, 05 Apr 2010 00:29:12 +0200
From: ST <st@iss.tu-darmstadt.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: dts,i2c,pcf8574 on Xilinx XUP
Date: Mon, 5 Apr 2010 00:28:31 +0200
References: <201004012250.33877.st@iss.tu-darmstadt.de>
	<201004020042.08010.st@iss.tu-darmstadt.de>
	<20100401230809.GB13989@pengutronix.de>
In-Reply-To: <20100401230809.GB13989@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201004050028.31634.st@iss.tu-darmstadt.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi
> (BTW your full name in the mail header would be appreciated)
If the internet would be forgetting more...
=20
> > [2797861247.810511] i2c /dev entries driver
> > [2797861247.817952] Device Tree Probing 'i2c'
> > [2797861247.830658]  #0 at 0x81600000 mapped to 0xD10C0000, irq=3D20
> > [2797861247.838743] pcf857x: probe of 0-0020 failed with error -22
>=20
> Doesn't look good here. Do you have the latest version of the driver?
> (CCing i2c)
Mh, i just saw that the i2c-xii.h file is now in 2.6.34. I copied them to m=
y=20
2.6.32-xlnx tree. So i think this is the most recent driver (albeit not the=
 most
recent kernel 2.6.32 due to the fact that vanilla doesn't boot on my machin=
e).

> > 		xps_iic_0: i2c@81600000 {
> > 			compatible =3D "xlnx,xps-iic-2.00.a";
> > 			interrupt-parent =3D <&xps_intc_0>;
> > 			interrupts =3D < 1 2 >;
> > 			reg =3D < 0x81600000 0x10000 >;
> > 			xlnx,clk-freq =3D <0x17d7840>;
> > 			xlnx,family =3D "virtex2p";
> > 			xlnx,gpo-width =3D <0x1>;
> > 			xlnx,iic-freq =3D <0x186a0>;
> > 			xlnx,scl-inertial-delay =3D <0x0>;
> > 			xlnx,sda-inertial-delay =3D <0x0>;
> > 			xlnx,ten-bit-adr =3D <0x0>;
>=20
> Have you checked the values? There is surely
>=20
>                         #address-cells =3D <1>;
>                         #size-cells =3D <0>;
>=20
> missing here, but that shouldn't cause your problems IMHO. I probably can=
't
> help any further, never used Xilinx so far (you have the newest version of
>  the dts-generator?).
The messages come from dts-v1.1.0 included in ptxdist-2010.03.0. The warnin=
gs are gone
after inserting your suggested lines into the dts file. Thanks for that hin=
t! However the error=20
that no PCF devices are found on the bus still persists. However there is a=
bsolutly no i2c traffic=20
on the i2c pins while it probes for the pcf device, so there clearly is s.t=
=2E amiss.
Reconfiguring the pins to gpio pins works as expected, so the raw hardware =
(not the "soft" hw)
is working.=20

Possible causes i see:
* i did an error when backporting these changes. But since there was only a=
 kconfig entry besides=20
  adding the c and header file, this would be still possible.
* I did some error in building the hardware.
* The i2c-xii driver is not working on powerpc hardware (only =B5blaze).
If anybody has some suggestions or knows that the i2c-xii driver
works on powerpc would be really happy to know.

Concerning the xilinx xup board, i am kind of frustrated: There is no suppo=
rt for newer=20
design tools than 10.1 [1]. Then there had been a regression in the systhes=
is tools which=20
couldn't handle 512 Mb memory sticks anymore (works with 256Mb). Then
the git tree is only sometimes online? There is no i2c (compiling) driver f=
or their stuff=20
which is then added by Intel? So Wolfram you can probably consider yourself=
 lucky ;-).

Thanks
ST

[1] http://www.digilentinc.com/Products/Detail.cfm?NavPath=3D2,400,794&Prod=
=3DXUPV2P
