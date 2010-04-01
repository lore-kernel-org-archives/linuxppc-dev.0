Return-Path: <st@iss.tu-darmstadt.de>
Received: from lnx141.hrz.tu-darmstadt.de (lnx141.hrz.tu-darmstadt.de
	[130.83.156.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21A07B7C8E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  2 Apr 2010 07:57:36 +1100 (EST)
Received: from lnx503.hrz.tu-darmstadt.de (lnx503.hrz.tu-darmstadt.de
	[130.83.156.232])
	by lnx141.hrz.tu-darmstadt.de (8.14.2/8.13.8) with ESMTP id
	o31KuF11008710
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Apr 2010 22:56:15 +0200
	(envelope-from st@iss.tu-darmstadt.de)
Received: from mailserver3.hrz.tu-darmstadt.de (lnx505.hrz.tu-darmstadt.de
	[130.83.156.234])
	by lnx503.hrz.tu-darmstadt.de (8.14.2/8.14.2/HRZ/PMX) with ESMTP id
	o31KpDsE004275
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Apr 2010 22:51:13 +0200
	(envelope-from st@iss.tu-darmstadt.de)
Received: from [213.188.117.234] (helo=ligeia.localnet)
	by mailserver3.hrz.tu-darmstadt.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <st@iss.tu-darmstadt.de>)
	id 1NxRM9-0004ZB-1u
	for linuxppc-dev@lists.ozlabs.org; Thu, 01 Apr 2010 22:51:13 +0200
From: ST <st@iss.tu-darmstadt.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: dts,i2c,pcf8574 on Xilinx XUP
Date: Thu, 1 Apr 2010 22:50:33 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201004012250.33877.st@iss.tu-darmstadt.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

I am currently trying to get the i2c driver from there:
http://www.mail-archive.com/linux-i2c@vger.kernel.org/msg02403.html
working on a full custom toolchain from me based on ptxdist as a
hobby.

Unfortunatly the i2c driver hangs the git://git.xilinx.com/linux-2.6-xlnx
tree hard if i run i2cdetect. Also my pcf device is not listed as a device.

Obviously my device tree is not correct as the dtc compiler complains:
Warning (avoid_default_addr_size): Relying on default #address-cells value =
for /plb@0/i2c@81600000/iexp@20
Warning (avoid_default_addr_size): Relying on default #size-cells value for=
 /plb@0/i2c@81600000/iexp@20
Warning (avoid_default_addr_size): Relying on default #address-cells value =
for /plb@0/xps-spi@81818000/spidev@0
Warning (avoid_default_addr_size): Relying on default #size-cells value for=
 /plb@0/xps-spi@81818000/spidev@0

The dts file comes straight from the xilinx tools with these small addition=
s made by me:
210a211,216
>                         pcf1: iexp@20 {
>                                 #gpio-cells =3D <2>;
>                                 compatible =3D "ti,pcf8574";
>                                 reg =3D <0x20>;
>                                 gpio-controller;
>                         };
228a235,240
>                       spidev@0 {
>                               compatible =3D "spidev";
>                               spi-max-frequency =3D <1000000>;
>                               reg =3D <0>;
>                       } ;
>
I am new to this device tree stuff and it would be really great to get some=
 hints as i am currently stuck.

Also if someone knows if these i2c patches which had been partially in 2.6.=
34 are bigendian/little endian
clean, as i suspect that they are focused on support for the =B5blazes?

Thanks for your attention
ST
