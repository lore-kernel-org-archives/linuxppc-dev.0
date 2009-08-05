Return-Path: <Matthias.Lange@beissbarth.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2B37CB707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 00:59:38 +1000 (EST)
Received: from smtp2-v.fe.bosch.de (smtp2-v.fe.bosch.de [139.15.237.6])
	by ozlabs.org (Postfix) with ESMTP id 51F5CDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 00:59:36 +1000 (EST)
Received: from vsmta3.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta5.fe.bosch.de (Postfix) with ESMTP id C4E62140074
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 16:59:22 +0200 (CEST)
Received: from fe-imc01.de.bosch.com (vsgw1.fe.internet.bosch.com [10.4.98.15])
	by vsmta3.fe.internet.bosch.com (Postfix) with ESMTP id 843EA158185
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 16:59:31 +0200 (CEST)
From: "EXTERNAL Lange Matthias (AA-DGW/ENG1)" <Matthias.Lange@beissbarth.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Date: Wed, 5 Aug 2009 16:59:29 +0200
Subject: RE: Spansion S25FL128-Flash and MTD
Message-ID: <44C5CFA72BC0E242A53B64DC1E67DEB80FB98D011D@SI-MBX10.de.bosch.com>
References: <44C5CFA72BC0E242A53B64DC1E67DEB80FB989659B@SI-MBX10.de.bosch.com>
In-Reply-To: <44C5CFA72BC0E242A53B64DC1E67DEB80FB989659B@SI-MBX10.de.bosch.com>
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

I solved part of my problem. The flash now gets detected during boot up. I =
had to change the compatible property from ""amd,s25sl12800", "jedec-flash"=
" to ""amd,m25p80", "jedec-flash"".

What remains is creating the mtd partitions which are specified in the devi=
ce tree as follows

partition@0 {
        label =3D "firmware";
        reg =3D <0x0 0x800000>;
};
partition@800000 {
        label =3D "rootfs";
        reg =3D <0x800000 0x800000>;
};

During boot no partitions are created and "cat /proc/mtd" just gives me

dev:    size   erasesize  name
mtd0: 01000000 00010000 "spi32766.0"

Any ideas?

Regards,
Matthias.

> -----Original Message-----
> From:
> linuxppc-dev-bounces+matthias.lange=3Dbeissbarth.com@lists.ozlab
> s.org
> [mailto:linuxppc-dev-bounces+matthias.lange=3Dbeissbarth.com@lis
ts.ozlabs.org] On Behalf Of EXTERNAL Lange Matthias (AA-DGW/ENG1)
> Sent: Wednesday, August 05, 2009 9:17 AM
> To: linuxppc-dev@ozlabs.org
> Subject: Spansion S25FL128-Flash and MTD
>
> Hi,
>
> I am trying to get a MTD running on my embedded PowerPC
> board. I am using a Xilinx Virtex4 with an embedded PowerPC
> 405. In the FPGA there is a Xilinx SPI controller implemented
> to which a Spansion S25FL128 SPI-flash (16MB) is connected.
>
> The problem is that with my setup the flash chips gets not
> detected and the MTD partitions won't be setup.
>
> In the kernel config I have configured the following options:
>
> In the device drivers section:
> [x] SPI support
>         [x] Xilinx SPI controller
> [x] Memory Technology Device (MTD) support
>         [x] MTD partitioning support
>         [x] Flash partition map based on OF description
>         RAM/ROM/Flash chip drivers
>                 [x] Detect non-CFI AMD/JEDEC-compatible flash chips
>         Self-contained MTD device drivers
>                 [x] Support most SPI Flash chips (AT26DF,
> M25P, W25X, ...)
>
> As filesystem I have configured JFFS2.
>
> In my device tree I have declared the SPI controller and the
> connected flash as follows:
>
> SPI_Flash: xps-spi@83400000 {
>         compatible =3D "xlnx,xps-spi-2.00.b";
>         interrupt-parent =3D <&int_ctrl>;
>         interrupts =3D < 3 2 >;
>         reg =3D < 0x83400000 0x10000 >;
>         xlnx,family =3D "virtex4";
>         xlnx,fifo-exist =3D <0x0>;
>         xlnx,num-offchip-ss-bits =3D <0x1>;
>         xlnx,num-ss-bits =3D <0x1>;
>         xlnx,sck-ratio =3D <0x20>;
>         #address-cells =3D <1>;
>         #size-cells =3D <1>;
>         nor_flash@0,1000000 {
>                 compatible =3D "amd,s25sl12800", "jedec-flash";
>                 reg =3D <0x0 0x1000000>;
>                 spi-max-frequency =3D <25000000>;
>                 bank-width =3D <1>;
>                 device-width =3D <1>;
>                 #address-cells =3D <1>;
>                 #size-cells =3D <1>;
>                 rootfs@800000 {
>                         label =3D "rootfs";
>                         reg =3D <0x800000 0x800000>;
>                 };
>         };
> };
>
> When the kernel boots I can see from the console that the
> drivers for JFFS2 and the SPI controller get successfully loaded:
>
> ...
> JFFS2 version 2.2. (NAND) (c) 2001-2006 Red Hat, Inc.
> ...
> xilinx-xps-spi 83400000.xps-spi: at 0x83400000 mapped to
> 0xC9060000, irq=3D17
> ...
>
> While debugging the boot process I couldn't see any calls to
> jedec_probe() resp. m25p_probe() from m25p80.c which to my
> understanding should be called in result to a successfull
> match of my compatible property (jedec-flash).
>
> The question is: What am I missing? Is there a problem with
> my device tree definition? What else am I doing wrong?
>
> Any help is appreciated. Regards,
> Matthias.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
