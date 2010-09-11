Return-Path: <leowang1998@yahoo.com.cn>
Received: from web15301.mail.cnb.yahoo.com (web15301.mail.cnb.yahoo.com
	[203.209.230.31]) by ozlabs.org (Postfix) with SMTP id 95EFFB6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 11 Sep 2010 12:30:37 +1000 (EST)
Message-ID: <881565.16140.qm@web15301.mail.cnb.yahoo.com>
Date: Sat, 11 Sep 2010 10:30:34 +0800 (CST)
From: leowang <leowang1998@yahoo.com.cn>
Subject: Re [PATCH v1] APM821xx: Add support for new SoC APM821xx
To: linuxppc-dev@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-2139672385-1284172234=:16140"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0-2139672385-1284172234=:16140
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all
=A0 my company use ARM,amcc CPU for different prouduct. i support to add=A0=
 [PATCH v1] APM821xx: Add support for new SoC APM821xx ,=A0now we do anythi=
ngs for Linux develop and make easier for=A0 ordinary user=A0.=20
=A0
=A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 leowang
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 2010:09:11
=A0=20
Message: 3
Date: Fri, 10 Sep 2010 11:27:37 -0700
From: tmarri@apm.com
To: linuxppc-dev@lists.ozlabs.org
Cc: tmarri@apm.com
Subject: [PATCH v1] APM821xx: Add support for new SoC APM821xx
Message-ID: <1284143257-15993-1-git-send-email-tmarri@apm.com>

From: Tirumala Marri <tmarri@apm.com>

This patch adds CPU, device tree, defconfig and bluestone board
support for APM821xx SoC.

Signed-off-by: Tirumala R Marri <tmarri@apm.com>
---
V1:
=A0 * CPU name changed to 464.
=A0 * defconfig is created using "make savedefconfig".
---
arch/powerpc/boot/dts/bluestone.dts=A0 =A0 =A0 =A0 =A0 |=A0 254 +++++++++++=
+++++++++++++++
arch/powerpc/configs/44x/bluestone_defconfig |=A0=A0=A068 +++++++
arch/powerpc/kernel/cpu_setup_44x.S=A0 =A0 =A0 =A0 =A0 |=A0 =A0 1 +
arch/powerpc/kernel/cputable.c=A0 =A0 =A0 =A0 =A0 =A0 =A0=A0=A0|=A0=A0=A015=
 ++
arch/powerpc/platforms/44x/Kconfig=A0 =A0 =A0 =A0 =A0=A0=A0|=A0=A0=A016 ++
arch/powerpc/platforms/44x/ppc44x_simple.c=A0=A0=A0|=A0 =A0 1 +
6 files changed, 355 insertions(+), 0 deletions(-)
create mode 100644 arch/powerpc/boot/dts/bluestone.dts
create mode 100644 arch/powerpc/configs/44x/bluestone_defconfig

diff --git a/arch/powerpc/boot/dts/bluestone.dts b/arch/powerpc/boot/dts/bl=
uestone.dts
new file mode 100644
index 0000000..bedcb8b
--- /dev/null
+++ b/arch/powerpc/boot/dts/bluestone.dts
@@ -0,0 +1,254 @@
+/*
+ * Device Tree for Bluestone (APM821xx) board.
+ *
+ * Copyright (c) 2010, Applied Micro Circuits Corporation
+ * All rights reserved. Tirumala R Marri <tmarri@apm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=A0 See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ *
+ */
+
+/dts-v1/;
+
+/ {
+=A0=A0=A0 #address-cells =3D <2>;
+=A0=A0=A0 #size-cells =3D <1>;
+=A0=A0=A0 model =3D "apm,bluestone";
+=A0=A0=A0 compatible =3D "apm,bluestone";
+=A0=A0=A0 dcr-parent =3D <&{/cpus/cpu@0}>;
+
+=A0=A0=A0 aliases {
+=A0=A0=A0 =A0=A0=A0 ethernet0 =3D &EMAC0;
+=A0=A0=A0 =A0=A0=A0 serial0 =3D &UART0;
+=A0=A0=A0 =A0=A0=A0 serial1 =3D &UART1;
+=A0=A0=A0 };
+
+=A0=A0=A0 cpus {
+=A0=A0=A0 =A0=A0=A0 #address-cells =3D <1>;
+=A0=A0=A0 =A0=A0=A0 #size-cells =3D <0>;
+
+=A0=A0=A0 =A0=A0=A0 cpu@0 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D "cpu";
+=A0=A0=A0 =A0=A0=A0 model =3D "PowerPC,464";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0x00000000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 clock-frequency =3D <0>; /* Filled in by U-B=
oot */
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 timebase-frequency =3D <0>; /* Filled in by =
U-Boot */
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i-cache-line-size =3D <32>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 d-cache-line-size =3D <32>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 i-cache-size =3D <32768>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 d-cache-size =3D <32768>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dcr-controller;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dcr-access-method =3D "native";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 next-level-cache =3D <&L2C0>;
+=A0=A0=A0 =A0=A0=A0 };
+=A0=A0=A0 };
+
+=A0=A0=A0 memory {
+=A0=A0=A0 =A0=A0=A0 device_type =3D "memory";
+=A0=A0=A0 =A0=A0=A0 reg =3D <0x00000000 0x00000000 0x00000000>; /* Filled =
in by U-Boot */
+=A0=A0=A0 };
+
+=A0=A0=A0 UIC0: interrupt-controller0 {
+=A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,uic";
+=A0=A0=A0 =A0=A0=A0 interrupt-controller;
+=A0=A0=A0 =A0=A0=A0 cell-index =3D <0>;
+=A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x0c0 0x009>;
+=A0=A0=A0 =A0=A0=A0 #address-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 #size-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 #interrupt-cells =3D <2>;
+=A0=A0=A0 };
+
+=A0=A0=A0 UIC1: interrupt-controller1 {
+=A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,uic";
+=A0=A0=A0 =A0=A0=A0 interrupt-controller;
+=A0=A0=A0 =A0=A0=A0 cell-index =3D <1>;
+=A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x0d0 0x009>;
+=A0=A0=A0 =A0=A0=A0 #address-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 #size-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 #interrupt-cells =3D <2>;
+=A0=A0=A0 =A0=A0=A0 interrupts =3D <0x1e 0x4 0x1f 0x4>; /* cascade */
+=A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&UIC0>;
+=A0=A0=A0 };
+
+=A0=A0=A0 UIC2: interrupt-controller2 {
+=A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,uic";
+=A0=A0=A0 =A0=A0=A0 interrupt-controller;
+=A0=A0=A0 =A0=A0=A0 cell-index =3D <2>;
+=A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x0e0 0x009>;
+=A0=A0=A0 =A0=A0=A0 #address-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 #size-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 #interrupt-cells =3D <2>;
+=A0=A0=A0 =A0=A0=A0 interrupts =3D <0xa 0x4 0xb 0x4>; /* cascade */
+=A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&UIC0>;
+=A0=A0=A0 };
+
+=A0=A0=A0 UIC3: interrupt-controller3 {
+=A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,uic";
+=A0=A0=A0 =A0=A0=A0 interrupt-controller;
+=A0=A0=A0 =A0=A0=A0 cell-index =3D <3>;
+=A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x0f0 0x009>;
+=A0=A0=A0 =A0=A0=A0 #address-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 #size-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 #interrupt-cells =3D <2>;
+=A0=A0=A0 =A0=A0=A0 interrupts =3D <0x10 0x4 0x11 0x4>; /* cascade */
+=A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&UIC0>;
+=A0=A0=A0 };
+
+=A0=A0=A0 SDR0: sdr {
+=A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,sdr-apm821xx";
+=A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x00e 0x002>;
+=A0=A0=A0 };
+
+=A0=A0=A0 CPR0: cpr {
+=A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,cpr-apm821xx";
+=A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x00c 0x002>;
+=A0=A0=A0 };
+
+=A0=A0=A0 plb {
+=A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,plb4";
+=A0=A0=A0 =A0=A0=A0 #address-cells =3D <2>;
+=A0=A0=A0 =A0=A0=A0 #size-cells =3D <1>;
+=A0=A0=A0 =A0=A0=A0 ranges;
+=A0=A0=A0 =A0=A0=A0 clock-frequency =3D <0>; /* Filled in by U-Boot */
+
+=A0=A0=A0 =A0=A0=A0 SDRAM0: sdram {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,sdram-apm821xx";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x010 0x002>;
+=A0=A0=A0 =A0=A0=A0 };
+
+=A0=A0=A0 =A0=A0=A0 MAL0: mcmal {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,mcmal2";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 descriptor-memory =3D "ocm";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x180 0x062>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 num-tx-chans =3D <1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 num-rx-chans =3D <1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&UIC2>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D <=A0=A0=A0 /*TXEOB*/ 0x6 0x4
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /*RXEOB*/ 0x7 0x4
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /*SERR*/=A0 0x3 0x4
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /*TXDE*/=A0 0x4 0x4
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /*RXDE*/=A0 0x5 0x4
+=A0=A0=A0 =A0=A0=A0 };
+
+=A0=A0=A0 =A0=A0=A0 POB0: opb {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,opb";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =3D <1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D <1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ranges =3D <0xb0000000 0x00000004 0xb0000000=
 0x50000000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 clock-frequency =3D <0>; /* Filled in by U-B=
oot */
+
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 EBC0: ebc {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,ebc";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 dcr-reg =3D <0x012 0x002>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =3D <2>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D <1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 clock-frequency =3D <0>; /* Filled=
 in by U-Boot */
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 /* ranges property is supplied by =
U-Boot */
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ranges =3D < 0x00000003 0x00000000=
 0xe0000000 0x8000000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D <0x6 0x4>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&UIC1>;
+
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 nor_flash@0,0 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "amd,s29g=
l512n", "cfi-flash";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 bank-width =3D <2>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0x00000000 0x00=
000000 0x00400000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =3D <1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D <1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 partition@0 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 label =3D "ker=
nel";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0x000=
00000 0x00180000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 partition@180000 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 label =3D "env=
";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0x001=
80000 0x00020000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 partition@1a0000 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 label =3D "u-b=
oot";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0x001=
a0000 0x00060000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 }
+
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 UART0: serial@ef600300 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D "serial";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ns16550";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0xef600300 0x00000008>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 virtual-reg =3D <0xef600300>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 clock-frequency =3D <0>; /* Filled=
 in by U-Boot */
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 current-speed =3D <0>; /* Filled i=
n by U-Boot */
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&UIC1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D <0x1 0x4>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 IIC0: i2c@ef600700 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,iic";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0xef600700 0x00000014>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&UIC0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D <0x2 0x4>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 IIC1: i2c@ef600800 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,iic";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0xef600800 0x00000014>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&UIC0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D <0x3 0x4>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 RGMII0: emac-rgmii@ef601500 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,rgmii";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0xef601500 0x00000008>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 has-mdio;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 TAH0: emac-tah@ef601350 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,tah";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0xef601350 0x00000030>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 EMAC0: ethernet@ef600c00 {
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 device_type =3D "network";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 compatible =3D "ibm,emac4sync";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-parent =3D <&EMAC0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupts =3D <0x0 0x1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #interrupt-cells =3D <1>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #address-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 #size-cells =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 interrupt-map =3D </*Status*/ 0x0 =
&UIC2 0x10 0x4
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0=A0/*Wake*/=
=A0=A0=A00x1 &UIC2 0x14 0x4>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg =3D <0xef600c00 0x000000c4>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 local-mac-address =3D [00000000000=
0]; /* Filled in by U-Boot */
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 mal-device =3D <&MAL0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 mal-tx-channel =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 mal-rx-channel =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 cell-index =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 max-frame-size =3D <9000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rx-fifo-size =3D <16384>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tx-fifo-size =3D <2048>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 phy-mode =3D "rgmii";
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 phy-map =3D <0x00000000>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rgmii-device =3D <&RGMII0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 rgmii-channel =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tah-device =3D <&TAH0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 tah-channel =3D <0>;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 has-inverted-stacr-oc;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 has-new-stacr-staopc;
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 };
+=A0=A0=A0 =A0=A0=A0 };
+
+=A0=A0=A0 };
+};
diff --git a/arch/powerpc/configs/44x/bluestone_defconfig b/arch/powerpc/co=
nfigs/44x/bluestone_defconfig
new file mode 100644
index 0000000..ac65b48
--- /dev/null
+++ b/arch/powerpc/configs/44x/bluestone_defconfig
@@ -0,0 +1,68 @@
+CONFIG_44x=3Dy
+CONFIG_EXPERIMENTAL=3Dy
+CONFIG_SYSVIPC=3Dy
+CONFIG_POSIX_MQUEUE=3Dy
+CONFIG_LOG_BUF_SHIFT=3D14
+CONFIG_BLK_DEV_INITRD=3Dy
+CONFIG_EMBEDDED=3Dy
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_PCI_QUIRKS is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_BLUESTONE=3Dy
+# CONFIG_EBONY is not set
+# CONFIG_KVM_GUEST is not set
+CONFIG_NO_HZ=3Dy
+CONFIG_HIGH_RES_TIMERS=3Dy
+CONFIG_SPARSE_IRQ=3Dy
+CONFIG_CMDLINE_BOOL=3Dy
+CONFIG_CMDLINE=3D""
+CONFIG_NET=3Dy
+CONFIG_PACKET=3Dy
+CONFIG_UNIX=3Dy
+CONFIG_INET=3Dy
+CONFIG_IP_PNP=3Dy
+CONFIG_IP_PNP_DHCP=3Dy
+CONFIG_IP_PNP_BOOTP=3Dy
+CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
+CONFIG_CONNECTOR=3Dy
+CONFIG_MTD=3Dy
+CONFIG_MTD_PARTITIONS=3Dy
+CONFIG_MTD_CMDLINE_PARTS=3Dy
+CONFIG_MTD_OF_PARTS=3Dy
+CONFIG_MTD_CHAR=3Dy
+CONFIG_MTD_BLOCK=3Dy
+CONFIG_MTD_CFI=3Dy
+CONFIG_MTD_CFI_AMDSTD=3Dy
+CONFIG_MTD_PHYSMAP_OF=3Dy
+CONFIG_PROC_DEVICETREE=3Dy
+CONFIG_BLK_DEV_RAM=3Dy
+CONFIG_BLK_DEV_RAM_SIZE=3D35000
+CONFIG_NETDEVICES=3Dy
+CONFIG_NET_ETHERNET=3Dy
+CONFIG_IBM_NEW_EMAC=3Dy
+CONFIG_IBM_NEW_EMAC_RXB=3D256
+CONFIG_IBM_NEW_EMAC_TXB=3D256
+CONFIG_SERIAL_8250=3Dy
+CONFIG_SERIAL_8250_CONSOLE=3Dy
+CONFIG_SERIAL_8250_NR_UARTS=3D2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=3D2
+CONFIG_SERIAL_8250_EXTENDED=3Dy
+CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
+CONFIG_SERIAL_OF_PLATFORM=3Dy
+CONFIG_I2C=3Dy
+CONFIG_I2C_CHARDEV=3Dy
+CONFIG_I2C_IBM_IIC=3Dy
+CONFIG_SENSORS_AD7414=3Dy
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+CONFIG_RTC_CLASS=3Dy
+CONFIG_RTC_DRV_M41T80=3Dy
+CONFIG_EXT2_FS=3Dy
+CONFIG_EXT3_FS=3Dy
+CONFIG_PROC_KCORE=3Dy
+CONFIG_TMPFS=3Dy
+CONFIG_CRAMFS=3Dy
+CONFIG_NFS_FS=3Dy
+CONFIG_NFS_V3=3Dy
+CONFIG_ROOT_NFS=3Dy
+CONFIG_NLS=3Dy
diff --git a/arch/powerpc/kernel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_=
setup_44x.S
index 7d606f8..549f482 100644
--- a/arch/powerpc/kernel/cpu_setup_44x.S
+++ b/arch/powerpc/kernel/cpu_setup_44x.S
@@ -35,6 +35,7 @@ _GLOBAL(__setup_cpu_440grx)
_GLOBAL(__setup_cpu_460ex)
_GLOBAL(__setup_cpu_460gt)
_GLOBAL(__setup_cpu_460sx)
+_GLOBAL(__setup_cpu_464)
=A0=A0=A0 mflr=A0=A0=A0 r4
=A0=A0=A0 bl=A0=A0=A0 __init_fpu_44x
=A0=A0=A0 bl=A0=A0=A0 __fixup_440A_mcheck
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.=
c
index 1f9123f..89e55b1 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -48,6 +48,7 @@ extern void __setup_cpu_440x5(unsigned long offset, struc=
t cpu_spec* spec);
extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* spec);
extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* spec);
extern void __setup_cpu_460sx(unsigned long offset, struct cpu_spec *spec);
+extern void __setup_cpu_464(unsigned long offset, struct cpu_spec *spec);
extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
@@ -1805,6 +1806,20 @@ static struct cpu_spec __initdata cpu_specs[] =3D {
=A0=A0=A0 =A0=A0=A0 .machine_check=A0=A0=A0 =A0=A0=A0 =3D machine_check_440=
A,
=A0=A0=A0 =A0=A0=A0 .platform=A0=A0=A0 =A0=A0=A0 =3D "ppc440",
=A0=A0=A0 },
+=A0=A0=A0 { /* 464 in APM821xx */
+=A0=A0=A0 =A0=A0=A0 .pvr_mask=A0=A0=A0 =A0=A0=A0 =3D 0xffffff00,
+=A0=A0=A0 =A0=A0=A0 .pvr_value=A0=A0=A0 =A0=A0=A0 =3D 0x12C41C80,
+=A0=A0=A0 =A0=A0=A0 .cpu_name=A0=A0=A0 =A0=A0=A0 =3D "464 in APM821xx",
+=A0=A0=A0 =A0=A0=A0 .cpu_features=A0=A0=A0 =A0=A0=A0 =3D CPU_FTRS_44X,
+=A0=A0=A0 =A0=A0=A0 .cpu_user_features=A0=A0=A0 =3D COMMON_USER_BOOKE |
+=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 PPC_FEATURE_HAS_FPU,
+=A0=A0=A0 =A0=A0=A0 .mmu_features=A0=A0=A0 =A0=A0=A0 =3D MMU_FTR_TYPE_44x,
+=A0=A0=A0 =A0=A0=A0 .icache_bsize=A0=A0=A0 =A0=A0=A0 =3D 32,
+=A0=A0=A0 =A0=A0=A0 .dcache_bsize=A0=A0=A0 =A0=A0=A0 =3D 32,
+=A0=A0=A0 =A0=A0=A0 .cpu_setup=A0=A0=A0 =A0=A0=A0 =3D __setup_cpu_464,
+=A0=A0=A0 =A0=A0=A0 .machine_check=A0=A0=A0 =A0=A0=A0 =3D machine_check_44=
0A,
+=A0=A0=A0 =A0=A0=A0 .platform=A0=A0=A0 =A0=A0=A0 =3D "ppc440",
+=A0=A0=A0 },
=A0=A0=A0 { /* 476 core */
=A0=A0=A0 =A0=A0=A0 .pvr_mask=A0=A0=A0 =A0=A0=A0 =3D 0xffff0000,
=A0=A0=A0 =A0=A0=A0 .pvr_value=A0=A0=A0 =A0=A0=A0 =3D 0x11a50000,
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44=
x/Kconfig
index 69d668c..0f979c5 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -17,6 +17,16 @@ config BAMBOO
=A0=A0=A0 help
=A0=A0=A0 =A0 This option enables support for the IBM PPC440EP evaluation b=
oard.

+config BLUESTONE
+=A0=A0=A0 bool "Bluestone"
+=A0=A0=A0 depends on 44x
+=A0=A0=A0 default n
+=A0=A0=A0 select PPC44x_SIMPLE
+=A0=A0=A0 select APM821xx
+=A0=A0=A0 select IBM_NEW_EMAC_RGMII
+=A0=A0=A0 help
+=A0=A0=A0 =A0 This option enables support for the APM APM821xx Evaluation =
board.
+
config EBONY
=A0=A0=A0 bool "Ebony"
=A0=A0=A0 depends on 44x
@@ -293,6 +303,12 @@ config 460SX
=A0=A0=A0 select IBM_NEW_EMAC_ZMII
=A0=A0=A0 select IBM_NEW_EMAC_TAH

+config APM821xx
+=A0=A0=A0 bool
+=A0=A0=A0 select PPC_FPU
+=A0=A0=A0 select IBM_NEW_EMAC_EMAC4
+=A0=A0=A0 select IBM_NEW_EMAC_TAH
+
# 44x errata/workaround config symbols, selected by the CPU models above
config IBM440EP_ERR42
=A0=A0=A0 bool
diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c b/arch/powerpc/plat=
forms/44x/ppc44x_simple.c
index 5f7a29d..7ddcba3 100644
--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
@@ -52,6 +52,7 @@ machine_device_initcall(ppc44x_simple, ppc44x_device_prob=
e);
static char *board[] __initdata =3D {
=A0=A0=A0 "amcc,arches",
=A0=A0=A0 "amcc,bamboo",
+=A0=A0=A0 "amcc,bluestone",
=A0=A0=A0 "amcc,canyonlands",
=A0=A0=A0 "amcc,glacier",
=A0=A0=A0 "ibm,ebony",
--=20
1.6.1.rc3





leowang=0A=0A=0A      
--0-2139672385-1284172234=:16140
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;"><DIV>Hello all</DIV>
<DIV>&nbsp; my company use ARM,amcc CPU for different prouduct. i support t=
o add&nbsp; [PATCH v1] APM821xx: Add support for new SoC APM821xx ,&nbsp;no=
w we do anythings for Linux develop and make easier for&nbsp; ordinary user=
&nbsp;. </DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; leowang</DIV>
<DIV>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2010:09:11</DIV=
>
<DIV>&nbsp; </DIV>
<DIV>Message: 3<BR>Date: Fri, 10 Sep 2010 11:27:37 -0700<BR>From: <A href=
=3D"http://cn.mc153.mail.yahoo.com/mc/compose?to=3Dtmarri@apm.com" ymailto=
=3D"mailto:tmarri@apm.com">tmarri@apm.com</A><BR>To: <A href=3D"http://cn.m=
c153.mail.yahoo.com/mc/compose?to=3Dlinuxppc-dev@lists.ozlabs.org" ymailto=
=3D"mailto:linuxppc-dev@lists.ozlabs.org">linuxppc-dev@lists.ozlabs.org</A>=
<BR>Cc: <A href=3D"http://cn.mc153.mail.yahoo.com/mc/compose?to=3Dtmarri@ap=
m.com" ymailto=3D"mailto:tmarri@apm.com">tmarri@apm.com</A><BR>Subject: [PA=
TCH v1] APM821xx: Add support for new SoC APM821xx<BR>Message-ID: &lt;<A hr=
ef=3D"http://cn.mc153.mail.yahoo.com/mc/compose?to=3D1284143257-15993-1-git=
-send-email-tmarri@apm.com" ymailto=3D"mailto:1284143257-15993-1-git-send-e=
mail-tmarri@apm.com">1284143257-15993-1-git-send-email-tmarri@apm.com</A>&g=
t;<BR><BR>From: Tirumala Marri &lt;<A href=3D"http://cn.mc153.mail.yahoo.co=
m/mc/compose?to=3Dtmarri@apm.com" ymailto=3D"mailto:tmarri@apm.com">tmarri@=
apm.com</A>&gt;<BR><BR>This
 patch adds CPU, device tree, defconfig and bluestone board<BR>support for =
APM821xx SoC.<BR><BR>Signed-off-by: Tirumala R Marri &lt;<A href=3D"http://=
cn.mc153.mail.yahoo.com/mc/compose?to=3Dtmarri@apm.com" ymailto=3D"mailto:t=
marri@apm.com">tmarri@apm.com</A>&gt;<BR>---<BR>V1:<BR>&nbsp; * CPU name ch=
anged to 464.<BR>&nbsp; * defconfig is created using "make savedefconfig".<=
BR>---<BR>arch/powerpc/boot/dts/bluestone.dts&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; |&nbsp; 254 ++++++++++++++++++++++++++<BR>arch/powerpc/configs/44x/blu=
estone_defconfig |&nbsp;&nbsp;&nbsp;68 +++++++<BR>arch/powerpc/kernel/cpu_s=
etup_44x.S&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; &nbsp; 1 +<BR>arch/pow=
erpc/kernel/cputable.c&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp=
;&nbsp;|&nbsp;&nbsp;&nbsp;15 ++<BR>arch/powerpc/platforms/44x/Kconfig&nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;16 ++<BR>arch/po=
werpc/platforms/44x/ppc44x_simple.c&nbsp;&nbsp;&nbsp;|&nbsp; &nbsp; 1
 +<BR>6 files changed, 355 insertions(+), 0 deletions(-)<BR>create mode 100=
644 arch/powerpc/boot/dts/bluestone.dts<BR>create mode 100644 arch/powerpc/=
configs/44x/bluestone_defconfig<BR><BR>diff --git a/arch/powerpc/boot/dts/b=
luestone.dts b/arch/powerpc/boot/dts/bluestone.dts<BR>new file mode 100644<=
BR>index 0000000..bedcb8b<BR>--- /dev/null<BR>+++ b/arch/powerpc/boot/dts/b=
luestone.dts<BR>@@ -0,0 +1,254 @@<BR>+/*<BR>+ * Device Tree for Bluestone (=
APM821xx) board.<BR>+ *<BR>+ * Copyright (c) 2010, Applied Micro Circuits C=
orporation<BR>+ * All rights reserved. Tirumala R Marri &lt;<A href=3D"http=
://cn.mc153.mail.yahoo.com/mc/compose?to=3Dtmarri@apm.com" ymailto=3D"mailt=
o:tmarri@apm.com">tmarri@apm.com</A>&gt;<BR>+ *<BR>+ * This program is free=
 software; you can redistribute it and/or<BR>+ * modify it under the terms =
of the GNU General Public License as<BR>+ * published by the Free Software =
Foundation; either version 2 of<BR>+ * the License, or (at your option)
 any later version.<BR>+ *<BR>+ * This program is distributed in the hope t=
hat it will be useful,<BR>+ * but WITHOUT ANY WARRANTY; without even the im=
plied warranty of<BR>+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.&nbsp; See the<BR>+ * GNU General Public License for more details.<BR>+ *=
<BR>+ * You should have received a copy of the GNU General Public License<B=
R>+ * along with this program; if not, write to the Free Software<BR>+ * Fo=
undation, Inc., 59 Temple Place, Suite 330, Boston,<BR>+ * MA 02111-1307 US=
A<BR>+ *<BR>+ */<BR>+<BR>+/dts-v1/;<BR>+<BR>+/ {<BR>+&nbsp;&nbsp;&nbsp; #ad=
dress-cells =3D &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;=
;<BR>+&nbsp;&nbsp;&nbsp; model =3D "apm,bluestone";<BR>+&nbsp;&nbsp;&nbsp; =
compatible =3D "apm,bluestone";<BR>+&nbsp;&nbsp;&nbsp; dcr-parent =3D &lt;&=
amp;{/cpus/cpu@0}&gt;;<BR>+<BR>+&nbsp;&nbsp;&nbsp; aliases {<BR>+&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; ethernet0 =3D &amp;EMAC0;<BR>+&nbsp;&nbsp;&nbsp=
;
 &nbsp;&nbsp;&nbsp; serial0 =3D &amp;UART0;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; serial1 =3D &amp;UART1;<BR>+&nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp=
;&nbsp;&nbsp; cpus {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cel=
ls =3D &lt;1&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D=
 &lt;0&gt;;<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cpu@0 {<BR>+&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D "cpu";=
<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; model =3D "PowerPC,464";<BR>+&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x0000000=
0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-f=
requency =3D &lt;0&gt;; /* Filled in by U-Boot */<BR>+&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; timebase-frequency =3D &lt;0&gt;; /* Fi=
lled in by U-Boot */<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; i-cache-line-size =3D &lt;32&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp;
 &nbsp;&nbsp;&nbsp; d-cache-line-size =3D &lt;32&gt;;<BR>+&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i-cache-size =3D &lt;32768&gt;;<BR>=
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; d-cache-size =3D =
&lt;32768&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 dcr-controller;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; dcr-access-method =3D "native";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; next-level-cache =3D &lt;&amp;L2C0&gt;;<BR>+&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+&nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp;&nb=
sp;&nbsp; memory {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =
=3D "memory";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x00000=
000 0x00000000 0x00000000&gt;; /* Filled in by U-Boot */<BR>+&nbsp;&nbsp;&n=
bsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp; UIC0: interrupt-controller0 {<BR>+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "ibm,uic";<BR>+&nbsp;&nbsp;=
&nbsp;
 &nbsp;&nbsp;&nbsp; interrupt-controller;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; cell-index =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; dcr-reg =3D &lt;0x0c0 0x009&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; #address-cells =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #=
size-cells =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interr=
upt-cells =3D &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp;&nbsp;&nb=
sp; UIC1: interrupt-controller1 {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 compatible =3D "ibm,uic";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interr=
upt-controller;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cell-index =3D &l=
t;1&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dcr-reg =3D &lt;0x0d0 0x=
009&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =3D &lt;0=
&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;<=
BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells =3D
 &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;0x=
1e 0x4 0x1f 0x4&gt;; /* cascade */<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; interrupt-parent =3D &lt;&amp;UIC0&gt;;<BR>+&nbsp;&nbsp;&nbsp; };<BR>+<BR=
>+&nbsp;&nbsp;&nbsp; UIC2: interrupt-controller2 {<BR>+&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; compatible =3D "ibm,uic";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; interrupt-controller;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
cell-index =3D &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dcr-reg=
 =3D &lt;0x0e0 0x009&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #addres=
s-cells =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cell=
s =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells=
 =3D &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &l=
t;0xa 0x4 0xb 0x4&gt;; /* cascade */<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; interrupt-parent =3D &lt;&amp;UIC0&gt;;<BR>+&nbsp;&nbsp;&nbsp;
 };<BR>+<BR>+&nbsp;&nbsp;&nbsp; UIC3: interrupt-controller3 {<BR>+&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "ibm,uic";<BR>+&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; interrupt-controller;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; cell-index =3D &lt;3&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; dcr-reg =3D &lt;0x0f0 0x009&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; #address-cells =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 #size-cells =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #inte=
rrupt-cells =3D &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interr=
upts =3D &lt;0x10 0x4 0x11 0x4&gt;; /* cascade */<BR>+&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;UIC0&gt;;<BR>+&nbsp;&nbsp;&n=
bsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp; SDR0: sdr {<BR>+&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; compatible =3D "ibm,sdr-apm821xx";<BR>+&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; dcr-reg =3D &lt;0x00e 0x002&gt;;<BR>+&nbsp;&nbsp;&nbsp;
 };<BR>+<BR>+&nbsp;&nbsp;&nbsp; CPR0: cpr {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; compatible =3D "ibm,cpr-apm821xx";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; dcr-reg =3D &lt;0x00c 0x002&gt;;<BR>+&nbsp;&nbsp;&nbsp; };<BR>=
+<BR>+&nbsp;&nbsp;&nbsp; plb {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; co=
mpatible =3D "ibm,plb4";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address=
-cells =3D &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells=
 =3D &lt;1&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges;<BR>+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency =3D &lt;0&gt;; /* Filled i=
n by U-Boot */<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; SDRAM0: sdram=
 {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =
=3D "ibm,sdram-apm821xx";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; dcr-reg =3D &lt;0x010 0x002&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; MAL0: mcmal
 {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =
=3D "ibm,mcmal2";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; descriptor-memory =3D "ocm";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; dcr-reg =3D &lt;0x180 0x062&gt;;<BR>+&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; num-tx-chans =3D &lt;1&gt;;<BR>+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; num-rx-chans =3D &lt;1&=
gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-=
cells =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; #size-cells =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;UIC2&gt;;<BR>+&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;&nbsp;&nbs=
p;&nbsp; /*TXEOB*/ 0x6 0x4<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*RXEOB*/ 0x7
 0x4<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; /*SERR*/&nbsp; 0x3 0x4<BR>+&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 /*TXDE*/&nbsp; 0x4 0x4<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /*RXDE*/&nbsp; 0x5 0x4<BR>+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; POB0: opb {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; compatible =3D "ibm,opb";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; #address-cells =3D &lt;1&gt;;<BR>+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<BR>+&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges =3D &lt;0xb00000=
00 0x00000004 0xb0000000 0x50000000&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; clock-frequency =3D &lt;0&gt;; /* Filled in by
 U-Boot */<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; EBC0: ebc {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; compatible =3D "ibm,ebc";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dcr-reg =3D &lt;0x012 0x0=
02&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; #address-cells =3D &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;1&gt;;<=
BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */<BR>+&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* range=
s property is supplied by U-Boot */<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ranges =3D &lt; 0x00000003 0x00000=
000 0xe0000000 0x8000000&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;0x6 0x4&gt;;<BR>+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 interrupt-parent =3D &lt;&amp;UIC1&gt;;<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; nor_flash@0,0 {<BR>+&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; compatible =3D "amd,s29gl512n", "cfi-flash";<BR>+&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; bank-width =3D &lt;2&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x0=
0000000 0x00000000 0x00400000&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #address-cells =
=3D &lt;1&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D
 &lt;1&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; partition@0 {<BR>+&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; label =3D "kernel";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; reg =3D &lt;0x00000000 0x00180000&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>=
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; partition@180000 {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; label =3D "env";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D=
 &lt;0x00180000 0x00020000&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; partition@1a0000 {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; lab=
el =3D "u-boot";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0x0=
01a0000 0x00060000&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<BR>+<BR>+&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; UART0: serial@ef600300 {<BR>+&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_=
type =3D "serial";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "ns16550";<BR>+&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =
=3D &lt;0xef600300 0x00000008&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; virtual-reg =3D &lt;0xef600300&gt;;=
<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; clock-frequency =3D &lt;0&gt;; /* Filled in by U-Boot */<BR>+&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; current=
-speed =3D &lt;0&gt;; /* Filled in by U-Boot */<BR>+&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &=
lt;&amp;UIC1&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;0x1 0x4&gt;;<BR>+&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; IIC0: i2c@ef600700 {<BR>+&nbsp;&nbsp;&nb=
sp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "i=
bm,iic";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; reg =3D &lt;0xef600700 0x00000014&gt;;<BR>+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =
=3D &lt;&amp;UIC0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;0x2 0x4&gt;;<BR>+&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; IIC1: i2c@ef600800 {<BR>+&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatibl=
e =3D "ibm,iic";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; reg =3D &lt;0xef600800 0x00000014&gt;;<BR>+&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt=
-parent =3D &lt;&amp;UIC0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupts =3D &lt;0x3 0x4&gt;;<BR>+=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; RGMII0: emac-rgmii@ef601=
500 {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; compatible =3D "ibm,rgmii";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &lt;0xef601500 0x000000=
08&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; has-mdio;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; TAH0: emac-tah@ef601350 {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; compatible =3D "ibm,tah";<BR>+&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; reg =3D &l=
t;0xef601350 0x00000030&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; EMAC0: ethernet@ef600c00 {<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; device_type =3D "network";<BR=
>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; compatible =3D "ibm,emac4sync";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; interrupt-parent =3D &lt;&amp;EMAC0=
&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; interrupts =3D &lt;0x0 0x1&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #interrupt-cells =3D &lt;1&=
gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; #address-cells =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; #size-cells =3D &lt;0&gt;;<BR>=
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
;
 interrupt-map =3D &lt;/*Status*/ 0x0 &amp;UIC2 0x10 0x4<BR>+&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;/*Wake*/&nbsp;&nbsp;&nbsp;0x1 &amp;UIC2=
 0x14 0x4&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; reg =3D &lt;0xef600c00 0x000000c4&gt;;<BR>+&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; local-mac-a=
ddress =3D [000000000000]; /* Filled in by U-Boot */<BR>+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mal-device =3D &l=
t;&amp;MAL0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; mal-tx-channel =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; mal-rx-channel =3D=
 &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; cell-index =3D &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; max-frame-size =
=3D &lt;9000&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; rx-fifo-size =3D &lt;16384&gt;;<BR>+&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tx-fifo-size =
=3D &lt;2048&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; phy-mode =3D "rgmii";<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; phy-map =3D &lt;0x0000000=
0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; rgmii-device =3D &lt;&amp;RGMII0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rgmii-channel =3D &l=
t;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; tah-device =3D &lt;&amp;TAH0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tah-channel =3D
 &lt;0&gt;;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; has-inverted-stacr-oc;<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; has-new-stacr-staopc;<BR>+&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; };<BR>+&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; };<BR>+<BR>+&nbsp;&nbsp;&nbsp; };<BR>+};<BR>diff --g=
it a/arch/powerpc/configs/44x/bluestone_defconfig b/arch/powerpc/configs/44=
x/bluestone_defconfig<BR>new file mode 100644<BR>index 0000000..ac65b48<BR>=
--- /dev/null<BR>+++ b/arch/powerpc/configs/44x/bluestone_defconfig<BR>@@ -=
0,0 +1,68 @@<BR>+CONFIG_44x=3Dy<BR>+CONFIG_EXPERIMENTAL=3Dy<BR>+CONFIG_SYSV=
IPC=3Dy<BR>+CONFIG_POSIX_MQUEUE=3Dy<BR>+CONFIG_LOG_BUF_SHIFT=3D14<BR>+CONFI=
G_BLK_DEV_INITRD=3Dy<BR>+CONFIG_EMBEDDED=3Dy<BR>+# CONFIG_VM_EVENT_COUNTERS=
 is not set<BR>+# CONFIG_PCI_QUIRKS is not set<BR>+# CONFIG_COMPAT_BRK is n=
ot set<BR>+CONFIG_BLUESTONE=3Dy<BR>+# CONFIG_EBONY is not set<BR>+# CONFIG_=
KVM_GUEST
 is not
 set<BR>+CONFIG_NO_HZ=3Dy<BR>+CONFIG_HIGH_RES_TIMERS=3Dy<BR>+CONFIG_SPARSE_=
IRQ=3Dy<BR>+CONFIG_CMDLINE_BOOL=3Dy<BR>+CONFIG_CMDLINE=3D""<BR>+CONFIG_NET=
=3Dy<BR>+CONFIG_PACKET=3Dy<BR>+CONFIG_UNIX=3Dy<BR>+CONFIG_INET=3Dy<BR>+CONF=
IG_IP_PNP=3Dy<BR>+CONFIG_IP_PNP_DHCP=3Dy<BR>+CONFIG_IP_PNP_BOOTP=3Dy<BR>+CO=
NFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"<BR>+CONFIG_CONNECTOR=3Dy<BR>+CONF=
IG_MTD=3Dy<BR>+CONFIG_MTD_PARTITIONS=3Dy<BR>+CONFIG_MTD_CMDLINE_PARTS=3Dy<B=
R>+CONFIG_MTD_OF_PARTS=3Dy<BR>+CONFIG_MTD_CHAR=3Dy<BR>+CONFIG_MTD_BLOCK=3Dy=
<BR>+CONFIG_MTD_CFI=3Dy<BR>+CONFIG_MTD_CFI_AMDSTD=3Dy<BR>+CONFIG_MTD_PHYSMA=
P_OF=3Dy<BR>+CONFIG_PROC_DEVICETREE=3Dy<BR>+CONFIG_BLK_DEV_RAM=3Dy<BR>+CONF=
IG_BLK_DEV_RAM_SIZE=3D35000<BR>+CONFIG_NETDEVICES=3Dy<BR>+CONFIG_NET_ETHERN=
ET=3Dy<BR>+CONFIG_IBM_NEW_EMAC=3Dy<BR>+CONFIG_IBM_NEW_EMAC_RXB=3D256<BR>+CO=
NFIG_IBM_NEW_EMAC_TXB=3D256<BR>+CONFIG_SERIAL_8250=3Dy<BR>+CONFIG_SERIAL_82=
50_CONSOLE=3Dy<BR>+CONFIG_SERIAL_8250_NR_UARTS=3D2<BR>+CONFIG_SERIAL_8250_R=
UNTIME_UARTS=3D2<BR>+CONFIG_SERIAL_8250_EXTENDED=3Dy<BR>+CONFIG_S
ERIAL_8250_SHARE_IRQ=3Dy<BR>+CONFIG_SERIAL_OF_PLATFORM=3Dy<BR>+CONFIG_I2C=
=3Dy<BR>+CONFIG_I2C_CHARDEV=3Dy<BR>+CONFIG_I2C_IBM_IIC=3Dy<BR>+CONFIG_SENSO=
RS_AD7414=3Dy<BR>+# CONFIG_HID_SUPPORT is not set<BR>+# CONFIG_USB_SUPPORT =
is not set<BR>+CONFIG_RTC_CLASS=3Dy<BR>+CONFIG_RTC_DRV_M41T80=3Dy<BR>+CONFI=
G_EXT2_FS=3Dy<BR>+CONFIG_EXT3_FS=3Dy<BR>+CONFIG_PROC_KCORE=3Dy<BR>+CONFIG_T=
MPFS=3Dy<BR>+CONFIG_CRAMFS=3Dy<BR>+CONFIG_NFS_FS=3Dy<BR>+CONFIG_NFS_V3=3Dy<=
BR>+CONFIG_ROOT_NFS=3Dy<BR>+CONFIG_NLS=3Dy<BR>diff --git a/arch/powerpc/ker=
nel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_setup_44x.S<BR>index 7d606f8.=
.549f482 100644<BR>--- a/arch/powerpc/kernel/cpu_setup_44x.S<BR>+++ b/arch/=
powerpc/kernel/cpu_setup_44x.S<BR>@@ -35,6 +35,7 @@ _GLOBAL(__setup_cpu_440=
grx)<BR>_GLOBAL(__setup_cpu_460ex)<BR>_GLOBAL(__setup_cpu_460gt)<BR>_GLOBAL=
(__setup_cpu_460sx)<BR>+_GLOBAL(__setup_cpu_464)<BR>&nbsp;&nbsp;&nbsp; mflr=
&nbsp;&nbsp;&nbsp; r4<BR>&nbsp;&nbsp;&nbsp; bl&nbsp;&nbsp;&nbsp; __init_fpu=
_44x<BR>&nbsp;&nbsp;&nbsp;
 bl&nbsp;&nbsp;&nbsp; __fixup_440A_mcheck<BR>diff --git a/arch/powerpc/kern=
el/cputable.c b/arch/powerpc/kernel/cputable.c<BR>index 1f9123f..89e55b1 10=
0644<BR>--- a/arch/powerpc/kernel/cputable.c<BR>+++ b/arch/powerpc/kernel/c=
putable.c<BR>@@ -48,6 +48,7 @@ extern void __setup_cpu_440x5(unsigned long =
offset, struct cpu_spec* spec);<BR>extern void __setup_cpu_460ex(unsigned l=
ong offset, struct cpu_spec* spec);<BR>extern void __setup_cpu_460gt(unsign=
ed long offset, struct cpu_spec* spec);<BR>extern void __setup_cpu_460sx(un=
signed long offset, struct cpu_spec *spec);<BR>+extern void __setup_cpu_464=
(unsigned long offset, struct cpu_spec *spec);<BR>extern void __setup_cpu_6=
03(unsigned long offset, struct cpu_spec* spec);<BR>extern void __setup_cpu=
_604(unsigned long offset, struct cpu_spec* spec);<BR>extern void __setup_c=
pu_750(unsigned long offset, struct cpu_spec* spec);<BR>@@ -1805,6 +1806,20=
 @@ static struct cpu_spec __initdata cpu_specs[] =3D
 {<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .machine_check&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; =3D machine_check_440A,<BR>&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; .platform&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D "ppc440",<BR>=
&nbsp;&nbsp;&nbsp; },<BR>+&nbsp;&nbsp;&nbsp; { /* 464 in APM821xx */<BR>+&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .pvr_mask&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; =3D 0xffffff00,<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .pvr_valu=
e&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D 0x12C41C80,<BR>+&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; .cpu_name&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D "4=
64 in APM821xx",<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .cpu_features&nb=
sp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D CPU_FTRS_44X,<BR>+&nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; .cpu_user_features&nbsp;&nbsp;&nbsp; =3D COMMON_USER_BO=
OKE |<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; PPC_FEAT=
URE_HAS_FPU,<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 .mmu_features&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D MMU_FTR_TYPE_44x,<B=
R>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .icache_bsize&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; =3D 32,<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .dcache_=
bsize&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D 32,<BR>+&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; .cpu_setup&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D __set=
up_cpu_464,<BR>+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .machine_check&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D machine_check_440A,<BR>+&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; .platform&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D "p=
pc440",<BR>+&nbsp;&nbsp;&nbsp; },<BR>&nbsp;&nbsp;&nbsp; { /* 476 core */<BR=
>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .pvr_mask&nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; =3D 0xffff0000,<BR>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .pvr_va=
lue&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D 0x11a50000,<BR>diff --git a/ar=
ch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig<BR>in=
dex
 69d668c..0f979c5 100644<BR>--- a/arch/powerpc/platforms/44x/Kconfig<BR>+++=
 b/arch/powerpc/platforms/44x/Kconfig<BR>@@ -17,6 +17,16 @@ config BAMBOO<B=
R>&nbsp;&nbsp;&nbsp; help<BR>&nbsp;&nbsp;&nbsp; &nbsp; This option enables =
support for the IBM PPC440EP evaluation board.<BR><BR>+config BLUESTONE<BR>=
+&nbsp;&nbsp;&nbsp; bool "Bluestone"<BR>+&nbsp;&nbsp;&nbsp; depends on 44x<=
BR>+&nbsp;&nbsp;&nbsp; default n<BR>+&nbsp;&nbsp;&nbsp; select PPC44x_SIMPL=
E<BR>+&nbsp;&nbsp;&nbsp; select APM821xx<BR>+&nbsp;&nbsp;&nbsp; select IBM_=
NEW_EMAC_RGMII<BR>+&nbsp;&nbsp;&nbsp; help<BR>+&nbsp;&nbsp;&nbsp; &nbsp; Th=
is option enables support for the APM APM821xx Evaluation board.<BR>+<BR>co=
nfig EBONY<BR>&nbsp;&nbsp;&nbsp; bool "Ebony"<BR>&nbsp;&nbsp;&nbsp; depends=
 on 44x<BR>@@ -293,6 +303,12 @@ config 460SX<BR>&nbsp;&nbsp;&nbsp; select I=
BM_NEW_EMAC_ZMII<BR>&nbsp;&nbsp;&nbsp; select IBM_NEW_EMAC_TAH<BR><BR>+conf=
ig APM821xx<BR>+&nbsp;&nbsp;&nbsp; bool<BR>+&nbsp;&nbsp;&nbsp;
 select PPC_FPU<BR>+&nbsp;&nbsp;&nbsp; select IBM_NEW_EMAC_EMAC4<BR>+&nbsp;=
&nbsp;&nbsp; select IBM_NEW_EMAC_TAH<BR>+<BR># 44x errata/workaround config=
 symbols, selected by the CPU models above<BR>config IBM440EP_ERR42<BR>&nbs=
p;&nbsp;&nbsp; bool<BR>diff --git a/arch/powerpc/platforms/44x/ppc44x_simpl=
e.c b/arch/powerpc/platforms/44x/ppc44x_simple.c<BR>index 5f7a29d..7ddcba3 =
100644<BR>--- a/arch/powerpc/platforms/44x/ppc44x_simple.c<BR>+++ b/arch/po=
werpc/platforms/44x/ppc44x_simple.c<BR>@@ -52,6 +52,7 @@ machine_device_ini=
tcall(ppc44x_simple, ppc44x_device_probe);<BR>static char *board[] __initda=
ta =3D {<BR>&nbsp;&nbsp;&nbsp; "amcc,arches",<BR>&nbsp;&nbsp;&nbsp; "amcc,b=
amboo",<BR>+&nbsp;&nbsp;&nbsp; "amcc,bluestone",<BR>&nbsp;&nbsp;&nbsp; "amc=
c,canyonlands",<BR>&nbsp;&nbsp;&nbsp; "amcc,glacier",<BR>&nbsp;&nbsp;&nbsp;=
 "ibm,ebony",<BR>-- <BR>1.6.1.rc3<BR><BR><BR><BR><BR><BR><EM><STRONG><FONT =
face=3D"verdana, helvetica,
 sans-serif">leowang</FONT></STRONG></EM></DIV></td></tr></table><br>=0A=0A=
=0A=0A=0A=0A=0A      &nbsp;
--0-2139672385-1284172234=:16140--
