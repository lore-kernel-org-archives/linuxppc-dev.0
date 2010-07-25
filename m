Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id C602EB6F14
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jul 2010 17:42:45 +1000 (EST)
Received: by gyh4 with SMTP id 4so828921gyh.15
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Jul 2010 00:42:44 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279892973-24110-1-git-send-email-agust@denx.de>
References: <1272882222-12253-1-git-send-email-agust@denx.de>
	<1279892973-24110-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 25 Jul 2010 01:42:23 -0600
Message-ID: <AANLkTi=Ee6HR+Ux0g4V1+81DXUmsO=UDhi6jWsDgGchv@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] powerpc/mpc5121: add initial support for PDM360NG
	board
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org,
	Michael Weiss <michael.weiss@ifm.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 23, 2010 at 7:49 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Adds IFM PDM360NG device tree, and platform code.
>
> Currently following is supported:
> =A0- Spansion S29GL512P 256 MB NOR flash
> =A0- ST Micro NAND 1 GiB flash
> =A0- DIU, please use "fbcon=3Dmap:5 video=3Dfslfb:800x480-32@60"
> =A0 at the kernel command line to enable PrimeView PM070WL3
> =A0 Display support.
> =A0- FEC
> =A0- I2C
> =A0- RTC, EEPROM
> =A0- MSCAN
> =A0- PSC UART, please pass "console=3Dtty0 console=3DttyPSC5,115200"
> =A0 on the kernel command line.
> =A0- SPI, ADS7845 Touchscreen
> =A0- USB0/1 Host
> =A0- USB0 OTG Host/Device
> =A0- VIU, Overlay/Capture support
>
> Signed-off-by: Markus Fischer <markus.fischer.ec@ifm.com>
> Signed-off-by: Wolfgang Grandegger <wg@denx.de>
> Signed-off-by: Michael Weiss <michael.weiss@ifm.com>
> Signed-off-by: Detlev Zundel <dzu@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: Grant Likely <grant.likely@secretlab.ca>

Hi Anatolij,

Finally got some time tonight to properly dig into this patch.  Comments be=
low.

> ---
> v3:
> =A0- uncomment and correct .irq_flags field of touchscreen
> =A0 platform data struct as proposed extension to this
> =A0 data struct has been accepted and merged via input tree
> =A0 a short while ago
>
> v1 -> v2:
> =A0- fix interrupt-parent property in nfc node
> =A0- drop #address-cells in ipic node
> =A0- remove device_type from ethernet-phy sub-node
> =A0- remove device_type from ethernet node
> =A0- add aliases node for eth0, needed for MAC address
> =A0 update by U-Boot
> =A0- removed spaces around &ipic
>
> =A0arch/powerpc/boot/dts/pdm360ng.dts =A0 =A0 | =A0432 ++++++++++++++++++=
++++++++++++++
> =A0arch/powerpc/platforms/512x/Kconfig =A0 =A0| =A0 =A07 +
> =A0arch/powerpc/platforms/512x/Makefile =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/512x/pdm360ng.c | =A0158 ++++++++++++
> =A04 files changed, 598 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/boot/dts/pdm360ng.dts
> =A0create mode 100644 arch/powerpc/platforms/512x/pdm360ng.c
>
> diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/p=
dm360ng.dts
> new file mode 100644
> index 0000000..7dc42e9
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/pdm360ng.dts
> @@ -0,0 +1,432 @@
> +/*
> + * Device Tree Source for IFM PDM360NG.
> + *
> + * Copyright 2009 - 2010 DENX Software Engineering.
> + * Anatolij Gustschin <agust@denx.de>
> + *
> + * Based on MPC5121E ADS dts.
> + * Copyright 2008 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at you=
r
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> + =A0 =A0 =A0 model =3D "pdm360ng";
> + =A0 =A0 =A0 compatible =3D "ifm,pdm360ng";
> + =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 #size-cells =3D <1>;
> +
> + =A0 =A0 =A0 aliases {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ethernet0 =3D &eth0;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 cpus {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 PowerPC,5121@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "cpu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-line-size =3D <0x20=
>; =A0 =A0 // 32 bytes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-line-size =3D <0x20=
>; =A0 =A0 // 32 bytes
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 d-cache-size =3D <0x8000>; =
=A0 =A0 =A0 =A0// L1, 32K
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i-cache-size =3D <0x8000>; =
=A0 =A0 =A0 =A0// L1, 32K
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timebase-frequency =3D <495=
00000>;// 49.5 MHz (csb/4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <19800000=
0>; =A0 =A0// 198 MHz csb bus
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <396000=
000>; =A0// 396 MHz ppc core
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 memory {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000 0x20000000>; =A0// 512M=
B at 0
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 nfc@40000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-nfc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x40000000 0x100000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0x6 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic>;

This device tree can be less verbose if you remove the
interrupt-parent property from all the nodes, and have a single
interrupt-parent =3D <&ipic>; in the root node.  Nodes inherit the
interrupt-parent from their (grand-)parents.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0x1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0x1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <0x1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chips =3D <0x1>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "nand0";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x0 0x40000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 sram@50000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-sram";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x50000000 0x20000>; =A0 =A0 // 12=
8K at 0x50000000
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 localbus@80000020 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-localbus";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x80000020 0x40>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x0 0x0 0xf0000000 0x10000000 =
=A0 /* Flash */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x2 0x0 0x50040000 0x00=
020000>; /* CS2: MRAM */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flash@0,0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "amd,s29gl01=
gp", "cfi-flash";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0 0x00000000 0x080=
00000
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 0x08000000=
 0x08000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device-width =3D <2>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "=
u-boot";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
00000000 0x00080000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read-only;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@80000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "=
environment";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
00080000 0x00080000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read-only;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@100000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "=
splash-image";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
00100000 0x00080000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read-only;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@180000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "=
device-tree";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
00180000 0x00040000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@1c0000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "=
kernel";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
001c0000 0x00500000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 partition@6c0000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 label =3D "=
filesystem";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
006c0000 0x07940000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mram0@2,0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "mtd-ram";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <2 0x00000 0x10000>=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mram1@2,10000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "mtd-ram";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <2 0x010000 0x10000=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bank-width =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 soc@80000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121-immr";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x0 0x80000000 0x400000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x80000000 0x400000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus-frequency =3D <66000000>; =A0 =A0 // 66=
 MHz ips bus
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // IPIC
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // interrupts cell =3D <intr #, sense>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense values match linux IORESOURCE_IRQ_=
* defines:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense =3D=3D 8: Level, low assertion
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // sense =3D=3D 2: Edge, high-to-low change
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 //
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ipic: interrupt-controller@c00 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-ipic", "fsl,ipic";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xc00 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc@a00 { =A0 =A0 =A0 // Real time clock
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-rtc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xa00 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <79 0x8 80 0=
x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reset@e00 { =A0 =A0 // Reset module
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-reset";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xe00 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock@f00 { =A0 =A0 // Clock control
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-clock";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xf00 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pmc@1000{ =A0 =A0 =A0 //Power Management Co=
ntroller
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-pmc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <83 0x2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio@1100 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-gpio";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1100 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <78 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 can@1300 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-mscan";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <12 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1300 0x80>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 can@1380 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-mscan";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <13 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1380 0x80>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c@1700 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1700 0x20>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0x9 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,preserve-clocking;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@50 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "at,24c01";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
50>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc@68 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "stm,m41t00";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
68>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2c@1740 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-i2c";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1740 0x20>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <0xb 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,preserve-clocking;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2ccontrol@1760 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-i2c-ctrl";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x1760 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 axe@2000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-axe";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <42 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 display@2100 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-diu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2100 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <64 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 can@2300 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-mscan";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <90 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2300 0x80>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 can@2380 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-mscan";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <91 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2380 0x80>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 viu@2400 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-viu";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2400 0x400>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <67 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdio@2800 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-fec-mdio";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2800 0x200>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy: ethernet-phy@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x=
1f>;

For completeness, phy should have a compatible property.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eth0: ethernet@2800 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-fec";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x2800 0x200>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local-mac-address =3D [ 00 =
00 00 00 00 00 ];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <4 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy-handle =3D < &phy >;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // USB1 using external ULPI PHY
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb@3000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-usb2-dr";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x3000 0x600>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <43 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dr_mode =3D "host";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_type =3D "ulpi";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // USB0 using internal UTMI PHY
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usb@4000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-usb2-dr";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x4000 0x600>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <44 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dr_mode =3D "otg";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_type =3D "utmi_wide";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,invert-pwr-fault;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // IO control
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioctl@a000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-ioctl";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0xA000 0x1000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 // 512x PSCs are not 52xx PSCs compatible
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@11000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <0>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11000 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@11100 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11100 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@11200 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11200 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@11300 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11300 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@11400 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11400 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@11600 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <6>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11600 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@11800 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11800 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial@11B00 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-uart", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <11>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11B00 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pscfifo@11f00 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-fifo";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11f00 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi@11900 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-psc-spi", "fsl,mpc5121-psc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cell-index =3D <9>;

Try to drop the cell-index properties.  They are almost always misused.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x11900 0x100>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <40 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,rx-fifo-size =3D <16>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fsl,tx-fifo-size =3D <16>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 // 7845 touch screen contro=
ller
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ts@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =
=3D "ti,ads7845";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-p=
arent =3D <&ipic>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 // pen irq =
is GPIO25
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =
=3D <78 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma@14000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-dma";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x14000 0x1800>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <65 0x8>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&ipic=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +};
> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms=
/512x/Kconfig
> index e9dca28..27b0651 100644
> --- a/arch/powerpc/platforms/512x/Kconfig
> +++ b/arch/powerpc/platforms/512x/Kconfig
> @@ -25,3 +25,10 @@ config MPC5121_GENERIC
>
> =A0 =A0 =A0 =A0 =A0Compatible boards include: =A0Protonic LVT base boards=
 (ZANMCU
> =A0 =A0 =A0 =A0 =A0and VICVT2).
> +
> +config PDM360NG
> + =A0 =A0 =A0 bool "ifm PDM360NG board"
> + =A0 =A0 =A0 depends on PPC_MPC512x
> + =A0 =A0 =A0 select DEFAULT_UIMAGE
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 This option enables support for the PDM360NG board.
> diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platform=
s/512x/Makefile
> index 90be2f5..4efc1c4 100644
> --- a/arch/powerpc/platforms/512x/Makefile
> +++ b/arch/powerpc/platforms/512x/Makefile
> @@ -4,3 +4,4 @@
> =A0obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D clock.o =
mpc512x_shared.o
> =A0obj-$(CONFIG_MPC5121_ADS) =A0 =A0 =A0+=3D mpc5121_ads.o mpc5121_ads_cp=
ld.o
> =A0obj-$(CONFIG_MPC5121_GENERIC) =A0+=3D mpc5121_generic.o
> +obj-$(CONFIG_PDM360NG) =A0 =A0 =A0 =A0 +=3D pdm360ng.o
> diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platfo=
rms/512x/pdm360ng.c
> new file mode 100644
> index 0000000..01e6023
> --- /dev/null
> +++ b/arch/powerpc/platforms/512x/pdm360ng.c
> @@ -0,0 +1,158 @@
> +/*
> + * Copyright (C) 2010 DENX Software Engineering
> + *
> + * Anatolij Gustschin, <agust@denx.de>
> + *
> + * PDM360NG board setup
> + *
> + * This is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/io.h>
> +#include <linux/of_platform.h>
> +
> +#include <asm/machdep.h>
> +#include <asm/ipic.h>
> +#include <asm/prom.h>
> +
> +#include "mpc512x.h"
> +
> +#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
> + =A0 =A0defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
> +#include <linux/fsl_devices.h>
> +#include <linux/interrupt.h>
> +#include <linux/spi/ads7846.h>
> +#include <linux/spi/spi.h>
> +
> +static void *pdm360ng_gpio_base;
> +
> +static int pdm360ng_get_pendown_state(void)
> +{
> + =A0 =A0 =A0 u32 reg;
> +
> + =A0 =A0 =A0 reg =3D in_be32((u32 *)(pdm360ng_gpio_base + 0xc));
> + =A0 =A0 =A0 if (reg & 0x40)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 setbits32((u32 *)(pdm360ng_gpio_base + 0xc)=
, 0x40);
> +
> + =A0 =A0 =A0 reg =3D in_be32((u32 *)(pdm360ng_gpio_base + 0x8));

(u32*) casts are unnecessary and can be removed.

> +
> + =A0 =A0 =A0 /* return 1 if pen is down */
> + =A0 =A0 =A0 return reg & 0x40 ? 0 : 1;

return reg & 0x40 =3D=3D 0;

> +}
> +
> +static struct ads7846_platform_data pdm360ng_ads7846_pdata __initdata =
=3D {
> + =A0 =A0 =A0 .model =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 7845,
> + =A0 =A0 =A0 .get_pendown_state =A0 =A0 =A0=3D pdm360ng_get_pendown_stat=
e,
> + =A0 =A0 =A0 .irq_flags =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D IRQF_TRIGGER_LOW,
> +};
> +
> +static int __init pdm360ng_penirq_init(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 struct resource r;
> +
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-gpi=
o");
> + =A0 =A0 =A0 if (!np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Can't find 'mpc5121-gpio' node\=
n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }

return -ENODEV;

> +
> + =A0 =A0 =A0 if (of_address_to_resource(np, 0, &r)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Invalid gpio address.\n", __fun=
c__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;

ditto

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 pdm360ng_gpio_base =3D ioremap(r.start, resource_size(&r));

Or you could have simply used of_iomap() to eliminate some code.

> + =A0 =A0 =A0 if (!pdm360ng_gpio_base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Can't map gpio regs.\n", __func=
__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;

ditto

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 out_be32((u32 *)pdm360ng_gpio_base + 0xc, 0xffffffff);
> + =A0 =A0 =A0 setbits32((u32 *)(pdm360ng_gpio_base + 0x18), 0x2000);
> + =A0 =A0 =A0 setbits32((u32 *)(pdm360ng_gpio_base + 0x10), 0x40);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int __init pdm360ng_touchscreen_init(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 struct of_device *of_dev;
> + =A0 =A0 =A0 struct spi_board_info info;
> + =A0 =A0 =A0 const u32 *prop;
> + =A0 =A0 =A0 int bus_num =3D -1;
> + =A0 =A0 =A0 int len;
> +
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "ti,ads7845");
> + =A0 =A0 =A0 if (!np)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 memset(&info, 0, sizeof(info));
> + =A0 =A0 =A0 info.irq =3D irq_of_parse_and_map(np, 0);
> + =A0 =A0 =A0 if (info.irq =3D=3D NO_IRQ)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 info.platform_data =3D &pdm360ng_ads7846_pdata;
> + =A0 =A0 =A0 if (strlcpy(info.modalias, "ads7846",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPI_NAME_SIZE) >=3D SPI_NAME_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 np =3D of_get_next_parent(np);
> + =A0 =A0 =A0 if (!np)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 prop =3D of_get_property(np, "cell-index", &len);
> + =A0 =A0 =A0 if (prop && len =3D=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_num =3D *prop;

Blech.  Don't use cell-index for bus enumeration.  In fact, none of
this should be necessary at all (see below).

> +
> + =A0 =A0 =A0 if (bus_num < 0 || bus_num > 11)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 info.bus_num =3D bus_num;
> +
> + =A0 =A0 =A0 of_dev =3D of_find_device_by_node(np);
> + =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 if (of_dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct fsl_spi_platform_data *pdata;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNE=
L);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->bus_num =3D bus_num;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->max_chipselect =3D 1=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_dev->dev.platform_data =
=3D pdata;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (pdm360ng_penirq_init())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 return spi_register_board_info(&info, 1);

This ends up being a lot of code simply to attach a pdata structure to
an spi device.  I've been thinking about this problem, and I think
there is a better way.  Instead, use a bus notifier attached to the
SPI bus to wait for the spi_device to get registered, but before it
gets bound to a driver.  Then you can attach the pdata structure very
simply.  Something like this I think (completely untested, or even
compiled.  Details are left as an exercise to the developer):

static int pdm360ng_touchscreen_notifier_call(struct notifier_block *nb,
					unsigned long event, void *__dev)
{
	struct device *dev =3D __dev;

	if ((event =3D=3D BUS_NOTIFIY_ADD_DEVICE) && (dev->of_node =3D=3D [FOO]))
		dev->platform_data =3D [BAR];
}

static struct notifier_block pdm360ng_touchscreen_nb =3D {
	notifier_call =3D pdm360ng_touchscreen_notifier_call;
};

static int __init pdm360ng_touchscreen_init(void)
{
	bus_register_notifier(&spi_bus_type, pdm360ng_touchscreen_nb);
}


> +}
> +machine_device_initcall(pdm360ng, pdm360ng_touchscreen_init);

This code is *in the same file* as the board setup file.  Don't use an
initcall.  Call it from the init callback instead.

> +#endif
> +
> +static int __init pdm360ng_probe(void)
> +{
> + =A0 =A0 =A0 unsigned long root =3D of_get_flat_dt_root();
> +
> + =A0 =A0 =A0 return of_flat_dt_is_compatible(root, "ifm,pdm360ng");
> +}
> +
> +define_machine(pdm360ng) {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "PDM360NG",
> + =A0 =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D pdm360ng_prob=
e,
> + =A0 =A0 =A0 .setup_arch =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_setup_diu,
> + =A0 =A0 =A0 .init =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init,
> + =A0 =A0 =A0 .init_early =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init_diu,
> + =A0 =A0 =A0 .init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init_IRQ,
> + =A0 =A0 =A0 .get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ipic_get_irq,
> + =A0 =A0 =A0 .calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr,
> + =A0 =A0 =A0 .restart =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mpc512x_restart=
,
> +};
> --
> 1.7.0.4
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
