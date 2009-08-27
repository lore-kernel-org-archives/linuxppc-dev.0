Return-Path: <Matthias.Lange@beissbarth.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 206E7B7BC7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 02:53:28 +1000 (EST)
Received: from smtp2-v.fe.bosch.de (smtp2-v.fe.bosch.de [139.15.237.6])
	by ozlabs.org (Postfix) with ESMTP id 8CDCFDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 02:53:26 +1000 (EST)
Received: from vsmta4.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta6.fe.bosch.de (Postfix) with ESMTP id 9F43E370061
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 18:53:23 +0200 (CEST)
Received: from fe-imc01.de.bosch.com (vsgw3.fe.internet.bosch.com [10.4.98.16])
	by vsmta4.fe.internet.bosch.com (Postfix) with ESMTP id ED78DC01C3
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2009 18:53:23 +0200 (CEST)
From: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Thu, 27 Aug 2009 18:53:22 +0200
Subject: SPI child devices reg property misused?
Message-ID: <44C5CFA72BC0E242A53B64DC1E67DEB80FBABEB2B7@SI-MBX10.de.bosch.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have a custom spi device connected to a Xilinx spi controller. To map the=
 register space of the controller a reg property is defined in the device t=
ree. Because my custom device also has register space which I want to map i=
n my driver, I also defined a reg property. Because things weren't running =
smooth I started debugging and found in of_spi.c in the function

void of_register_spi_devices(struct spi_master *master, struct device_node =
*np)

the following piece of code (2.6.31)

...
/* Device address */
prop =3D of_get_property(nc, "reg", &len);
if (!prop || len < sizeof(*prop)) {
        dev_err(&master->dev, "%s has no 'reg' property\n",
                  nc->full_name);
        spi_dev_put(spi);
        continue;

}
spi->chip_select =3D *prop;

Why does the reg property value of spi child devices is assigned to the chi=
p_select? Is there another way for spi devices to propagate their register =
space?

The related device tree snippet is as follows

xps-spi@83440000 {
        compatible =3D "xlnx,xps-spi-2.00.b";
        interrupt-parent =3D <&int_ctrl>;
        interrupts =3D < 1 2 >;
        reg =3D < 0x83440000 0x10000 >;
        xlnx,family =3D "virtex4";
        xlnx,fifo-exist =3D <0x0>;
        xlnx,num-offchip-ss-bits =3D <0x0>;
        xlnx,num-ss-bits =3D <0x1>;
        xlnx,sck-ratio =3D <0x40>;
        #address-cells =3D <1>;
        #size-cells =3D <1>;
        device@0,0 {
                compatible =3D "beissbarth,orion_cam";
                reg =3D <0x48 0x8>;
                spi-max-frequency =3D <25000000>;
                interrupt-parent =3D <&int_ctrl>;
                interrupts =3D < 8 2 >;
        };
};

Cheers,
Matthias.
