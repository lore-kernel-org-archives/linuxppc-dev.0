Return-Path: <bobstover@hotmail.com>
Received: from blu0-omc3-s12.blu0.hotmail.com (blu0-omc3-s12.blu0.hotmail.com
 [65.55.116.87]) by ozlabs.org (Postfix) with ESMTP id EADA3B6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2011 12:40:09 +1100 (EST)
Message-ID: <BLU160-W31767F31C3CF83D2EED726A9C20@phx.gbl>
Content-Type: multipart/alternative;
 boundary="_b3c73276-44e2-4ef2-8842-730de20dc58e_"
From: Bob Stover <bobstover@hotmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: RE: Linuxppc-dev Digest, Vol 87, Issue 61
Date: Fri, 11 Nov 2011 19:34:55 -0600
In-Reply-To: <mailman.2441.1320941713.15294.linuxppc-dev@lists.ozlabs.org>
References: <mailman.2441.1320941713.15294.linuxppc-dev@lists.ozlabs.org>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_b3c73276-44e2-4ef2-8842-730de20dc58e_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


You have been great. Im in a pinch. I put linux on alot of computers. The c=
ustomers want ITunes. Do you have a package that will work on RPM or Debian=
.
Bob

> From: linuxppc-dev-request@lists.ozlabs.org
> Subject: Linuxppc-dev Digest=2C Vol 87=2C Issue 61
> To: linuxppc-dev@lists.ozlabs.org
> Date: Fri=2C 11 Nov 2011 03:15:13 +1100
>=20
> Send Linuxppc-dev mailing list submissions to
> 	linuxppc-dev@lists.ozlabs.org
>=20
> To subscribe or unsubscribe via the World Wide Web=2C visit
> 	https://lists.ozlabs.org/listinfo/linuxppc-dev
> or=2C via email=2C send a message with subject or body 'help' to
> 	linuxppc-dev-request@lists.ozlabs.org
>=20
> You can reach the person managing the list at
> 	linuxppc-dev-owner@lists.ozlabs.org
>=20
> When replying=2C please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-dev digest..."
>=20
>=20
> Today's Topics:
>=20
>    1. [RFC][PATCH 23/30] powerpc/85xx: Rework P4080DS device trees
>       (Kumar Gala)
>=20
>=20
> ----------------------------------------------------------------------
>=20
> Message: 1
> Date: Thu=2C 10 Nov 2011 10:14:06 -0600
> From: Kumar Gala <galak@kernel.crashing.org>
> To: linuxppc-dev@ozlabs.org
> Subject: [RFC][PATCH 23/30] powerpc/85xx: Rework P4080DS device trees
> Message-ID:
> 	<1320941653-29797-24-git-send-email-galak@kernel.crashing.org>
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |  342 ++++++++++++
>  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi  |  145 +++++
>  arch/powerpc/boot/dts/p4080ds.dts           |   14 +-
>  arch/powerpc/boot/dts/p4080si.dtsi          |  755 ---------------------=
------
>  4 files changed=2C 498 insertions(+)=2C 758 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
>  delete mode 100644 arch/powerpc/boot/dts/p4080si.dtsi
>=20
> diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/b=
oot/dts/fsl/p4080si-post.dtsi
> new file mode 100644
> index 0000000..1510991
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
> @@ -0=2C0 +1=2C342 @@
> +/*
> + * P4080/P4040 Silicon/SoC Device Tree Source (post include)
> + *
> + * Copyright 2011 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms=2C with or without
> + * modification=2C are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice=2C this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyrig=
ht
> + *       notice=2C this list of conditions and the following disclaimer =
in the
> + *       documentation and/or other materials provided with the distribu=
tion.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote pro=
ducts
> + *       derived from this software without specific prior written permi=
ssion.
> + *
> + *
> + * ALTERNATIVELY=2C this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation=2C either version 2 of that License or (at your option) an=
y
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND AN=
Y
> + * EXPRESS OR IMPLIED WARRANTIES=2C INCLUDING=2C BUT NOT LIMITED TO=2C T=
HE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
> + * DIRECT=2C INDIRECT=2C INCIDENTAL=2C SPECIAL=2C EXEMPLARY=2C OR CONSEQ=
UENTIAL DAMAGES
> + * (INCLUDING=2C BUT NOT LIMITED TO=2C PROCUREMENT OF SUBSTITUTE GOODS O=
R SERVICES=3B
> + * LOSS OF USE=2C DATA=2C OR PROFITS=3B OR BUSINESS INTERRUPTION) HOWEVE=
R CAUSED AND
> + * ON ANY THEORY OF LIABILITY=2C WHETHER IN CONTRACT=2C STRICT LIABILITY=
=2C OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
> + * SOFTWARE=2C EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +&lbc {
> +	compatible =3D "fsl=2Cp4080-elbc"=2C "fsl=2Celbc"=2C "simple-bus"=3B
> +	interrupts =3D <25 2 0 0>=3B
> +	#address-cells =3D <2>=3B
> +	#size-cells =3D <1>=3B
> +}=3B
> +
> +/* controller at 0x200000 */
> +&pci0 {
> +	compatible =3D "fsl=2Cp4080-pcie"=3B
> +	device_type =3D "pci"=3B
> +	#size-cells =3D <2>=3B
> +	#address-cells =3D <3>=3B
> +	bus-range =3D <0x0 0xff>=3B
> +	clock-frequency =3D <33333333>=3B
> +	interrupts =3D <16 2 1 15>=3B
> +	pcie@0 {
> +		reg =3D <0 0 0 0 0>=3B
> +		#interrupt-cells =3D <1>=3B
> +		#size-cells =3D <2>=3B
> +		#address-cells =3D <3>=3B
> +		device_type =3D "pci"=3B
> +		interrupts =3D <16 2 1 15>=3B
> +		interrupt-map-mask =3D <0xf800 0 0 7>=3B
> +		interrupt-map =3D <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 40 1 0 0
> +			0000 0 0 2 &mpic 1 1 0 0
> +			0000 0 0 3 &mpic 2 1 0 0
> +			0000 0 0 4 &mpic 3 1 0 0
> +			>=3B
> +	}=3B
> +}=3B
> +
> +/* controller at 0x201000 */
> +&pci1 {
> +	compatible =3D "fsl=2Cp4080-pcie"=3B
> +	device_type =3D "pci"=3B
> +	#size-cells =3D <2>=3B
> +	#address-cells =3D <3>=3B
> +	bus-range =3D <0 0xff>=3B
> +	clock-frequency =3D <33333333>=3B
> +	interrupts =3D <16 2 1 14>=3B
> +	pcie@0 {
> +		reg =3D <0 0 0 0 0>=3B
> +		#interrupt-cells =3D <1>=3B
> +		#size-cells =3D <2>=3B
> +		#address-cells =3D <3>=3B
> +		device_type =3D "pci"=3B
> +		interrupts =3D <16 2 1 14>=3B
> +		interrupt-map-mask =3D <0xf800 0 0 7>=3B
> +		interrupt-map =3D <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 41 1 0 0
> +			0000 0 0 2 &mpic 5 1 0 0
> +			0000 0 0 3 &mpic 6 1 0 0
> +			0000 0 0 4 &mpic 7 1 0 0
> +			>=3B
> +	}=3B
> +}=3B
> +
> +/* controller at 0x202000 */
> +&pci2 {
> +	compatible =3D "fsl=2Cp4080-pcie"=3B
> +	device_type =3D "pci"=3B
> +	#size-cells =3D <2>=3B
> +	#address-cells =3D <3>=3B
> +	bus-range =3D <0x0 0xff>=3B
> +	clock-frequency =3D <33333333>=3B
> +	interrupts =3D <16 2 1 13>=3B
> +	pcie@0 {
> +		reg =3D <0 0 0 0 0>=3B
> +		#interrupt-cells =3D <1>=3B
> +		#size-cells =3D <2>=3B
> +		#address-cells =3D <3>=3B
> +		device_type =3D "pci"=3B
> +		interrupts =3D <16 2 1 13>=3B
> +		interrupt-map-mask =3D <0xf800 0 0 7>=3B
> +		interrupt-map =3D <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 42 1 0 0
> +			0000 0 0 2 &mpic 9 1 0 0
> +			0000 0 0 3 &mpic 10 1 0 0
> +			0000 0 0 4 &mpic 11 1 0 0
> +			>=3B
> +	}=3B
> +}=3B
> +
> +&rio {
> +	#address-cells =3D <2>=3B
> +	#size-cells =3D <2>=3B
> +	compatible =3D "fsl=2Crapidio-delta"=3B
> +	interrupts =3D <
> +		16 2 1 11 /* err_irq */
> +		56 2 0 0  /* bell_outb_irq */
> +		57 2 0 0  /* bell_inb_irq */
> +		60 2 0 0  /* msg1_tx_irq */
> +		61 2 0 0  /* msg1_rx_irq */
> +		62 2 0 0  /* msg2_tx_irq */
> +		63 2 0 0>=3B /* msg2_rx_irq */
> +}=3B
> +
> +&dcsr {
> +	#address-cells =3D <1>=3B
> +	#size-cells =3D <1>=3B
> +	compatible =3D "fsl=2Cdcsr"=2C "simple-bus"=3B
> +
> +	dcsr-epu@0 {
> +		compatible =3D "fsl=2Cdcsr-epu"=3B
> +		interrupts =3D <52 2 0 0
> +			      84 2 0 0
> +			      85 2 0 0>=3B
> +		reg =3D <0x0 0x1000>=3B
> +	}=3B
> +	dcsr-npc {
> +		compatible =3D "fsl=2Cdcsr-npc"=3B
> +		reg =3D <0x1000 0x1000 0x1000000 0x8000>=3B
> +	}=3B
> +	dcsr-nxc@2000 {
> +		compatible =3D "fsl=2Cdcsr-nxc"=3B
> +		reg =3D <0x2000 0x1000>=3B
> +	}=3B
> +	dcsr-corenet {
> +		compatible =3D "fsl=2Cdcsr-corenet"=3B
> +		reg =3D <0x8000 0x1000 0xB0000 0x1000>=3B
> +	}=3B
> +	dcsr-dpaa@9000 {
> +		compatible =3D "fsl=2Cp4080-dcsr-dpaa"=2C "fsl=2Cdcsr-dpaa"=3B
> +		reg =3D <0x9000 0x1000>=3B
> +	}=3B
> +	dcsr-ocn@11000 {
> +		compatible =3D "fsl=2Cp4080-dcsr-ocn"=2C "fsl=2Cdcsr-ocn"=3B
> +		reg =3D <0x11000 0x1000>=3B
> +	}=3B
> +	dcsr-ddr@12000 {
> +		compatible =3D "fsl=2Cdcsr-ddr"=3B
> +		dev-handle =3D <&ddr1>=3B
> +		reg =3D <0x12000 0x1000>=3B
> +	}=3B
> +	dcsr-ddr@13000 {
> +		compatible =3D "fsl=2Cdcsr-ddr"=3B
> +		dev-handle =3D <&ddr2>=3B
> +		reg =3D <0x13000 0x1000>=3B
> +	}=3B
> +	dcsr-nal@18000 {
> +		compatible =3D "fsl=2Cp4080-dcsr-nal"=2C "fsl=2Cdcsr-nal"=3B
> +		reg =3D <0x18000 0x1000>=3B
> +	}=3B
> +	dcsr-rcpm@22000 {
> +		compatible =3D "fsl=2Cp4080-dcsr-rcpm"=2C "fsl=2Cdcsr-rcpm"=3B
> +		reg =3D <0x22000 0x1000>=3B
> +	}=3B
> +	dcsr-cpu-sb-proxy@40000 {
> +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-prox=
y"=3B
> +		cpu-handle =3D <&cpu0>=3B
> +		reg =3D <0x40000 0x1000>=3B
> +	}=3B
> +	dcsr-cpu-sb-proxy@41000 {
> +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-prox=
y"=3B
> +		cpu-handle =3D <&cpu1>=3B
> +		reg =3D <0x41000 0x1000>=3B
> +	}=3B
> +	dcsr-cpu-sb-proxy@42000 {
> +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-prox=
y"=3B
> +		cpu-handle =3D <&cpu2>=3B
> +		reg =3D <0x42000 0x1000>=3B
> +	}=3B
> +	dcsr-cpu-sb-proxy@43000 {
> +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-prox=
y"=3B
> +		cpu-handle =3D <&cpu3>=3B
> +		reg =3D <0x43000 0x1000>=3B
> +	}=3B
> +	dcsr-cpu-sb-proxy@44000 {
> +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-prox=
y"=3B
> +		cpu-handle =3D <&cpu4>=3B
> +		reg =3D <0x44000 0x1000>=3B
> +	}=3B
> +	dcsr-cpu-sb-proxy@45000 {
> +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-prox=
y"=3B
> +		cpu-handle =3D <&cpu5>=3B
> +		reg =3D <0x45000 0x1000>=3B
> +	}=3B
> +	dcsr-cpu-sb-proxy@46000 {
> +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-prox=
y"=3B
> +		cpu-handle =3D <&cpu6>=3B
> +		reg =3D <0x46000 0x1000>=3B
> +	}=3B
> +	dcsr-cpu-sb-proxy@47000 {
> +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-prox=
y"=3B
> +		cpu-handle =3D <&cpu7>=3B
> +		reg =3D <0x47000 0x1000>=3B
> +	}=3B
> +
> +}=3B
> +
> +&soc {
> +	#address-cells =3D <1>=3B
> +	#size-cells =3D <1>=3B
> +	device_type =3D "soc"=3B
> +	compatible =3D "simple-bus"=3B
> +
> +	soc-sram-error {
> +		compatible =3D "fsl=2Csoc-sram-error"=3B
> +		interrupts =3D <16 2 1 29>=3B
> +	}=3B
> +
> +	corenet-law@0 {
> +		compatible =3D "fsl=2Ccorenet-law"=3B
> +		reg =3D <0x0 0x1000>=3B
> +		fsl=2Cnum-laws =3D <32>=3B
> +	}=3B
> +
> +	ddr1: memory-controller@8000 {
> +		compatible =3D "fsl=2Cqoriq-memory-controller-v4.4"=2C "fsl=2Cqoriq-me=
mory-controller"=3B
> +		reg =3D <0x8000 0x1000>=3B
> +		interrupts =3D <16 2 1 23>=3B
> +	}=3B
> +
> +	ddr2: memory-controller@9000 {
> +		compatible =3D "fsl=2Cqoriq-memory-controller-v4.4"=2C"fsl=2Cqoriq-mem=
ory-controller"=3B
> +		reg =3D <0x9000 0x1000>=3B
> +		interrupts =3D <16 2 1 22>=3B
> +	}=3B
> +
> +	cpc: l3-cache-controller@10000 {
> +		compatible =3D "fsl=2Cp4080-l3-cache-controller"=2C "cache"=3B
> +		reg =3D <0x10000 0x1000
> +		       0x11000 0x1000>=3B
> +		interrupts =3D <16 2 1 27
> +			      16 2 1 26>=3B
> +	}=3B
> +
> +	corenet-cf@18000 {
> +		compatible =3D "fsl=2Ccorenet-cf"=3B
> +		reg =3D <0x18000 0x1000>=3B
> +		interrupts =3D <16 2 1 31>=3B
> +		fsl=2Cccf-num-csdids =3D <32>=3B
> +		fsl=2Cccf-num-snoopids =3D <32>=3B
> +	}=3B
> +
> +	iommu@20000 {
> +		compatible =3D "fsl=2Cpamu-v1.0"=2C "fsl=2Cpamu"=3B
> +		reg =3D <0x20000 0x5000>=3B
> +		interrupts =3D <
> +			24 2 0 0
> +			16 2 1 30>=3B
> +	}=3B
> +
> +/include/ "qoriq-mpic.dtsi"
> +
> +	guts: global-utilities@e0000 {
> +		compatible =3D "fsl=2Cqoriq-device-config-1.0"=3B
> +		reg =3D <0xe0000 0xe00>=3B
> +		fsl=2Chas-rstcr=3B
> +		#sleep-cells =3D <1>=3B
> +		fsl=2Cliodn-bits =3D <12>=3B
> +	}=3B
> +
> +	pins: global-utilities@e0e00 {
> +		compatible =3D "fsl=2Cqoriq-pin-control-1.0"=3B
> +		reg =3D <0xe0e00 0x200>=3B
> +		#sleep-cells =3D <2>=3B
> +	}=3B
> +
> +	clockgen: global-utilities@e1000 {
> +		compatible =3D "fsl=2Cp4080-clockgen"=2C "fsl=2Cqoriq-clockgen-1.0"=3B
> +		reg =3D <0xe1000 0x1000>=3B
> +		clock-frequency =3D <0>=3B
> +	}=3B
> +
> +	rcpm: global-utilities@e2000 {
> +		compatible =3D "fsl=2Cqoriq-rcpm-1.0"=3B
> +		reg =3D <0xe2000 0x1000>=3B
> +		#sleep-cells =3D <1>=3B
> +	}=3B
> +
> +	sfp: sfp@e8000 {
> +		compatible =3D "fsl=2Cp4080-sfp"=2C "fsl=2Cqoriq-sfp-1.0"=3B
> +		reg	   =3D <0xe8000 0x1000>=3B
> +	}=3B
> +
> +	serdes: serdes@ea000 {
> +		compatible =3D "fsl=2Cp4080-serdes"=3B
> +		reg	   =3D <0xea000 0x1000>=3B
> +	}=3B
> +
> +/include/ "qoriq-dma-0.dtsi"
> +/include/ "qoriq-dma-1.dtsi"
> +/include/ "qoriq-espi-0.dtsi"
> +	spi@110000 {
> +		fsl=2Cespi-num-chipselects =3D <4>=3B
> +	}=3B
> +
> +/include/ "qoriq-esdhc-0.dtsi"
> +	sdhc@114000 {
> +		voltage-ranges =3D <3300 3300>=3B
> +		sdhci=2Cauto-cmd12=3B
> +	}=3B
> +
> +/include/ "qoriq-i2c-0.dtsi"
> +/include/ "qoriq-i2c-1.dtsi"
> +/include/ "qoriq-duart-0.dtsi"
> +/include/ "qoriq-duart-1.dtsi"
> +/include/ "qoriq-gpio-0.dtsi"
> +/include/ "qoriq-usb2-mph-0.dtsi"
> +/include/ "qoriq-usb2-dr-0.dtsi"
> +/include/ "qoriq-sec4.0-0.dtsi"
> +}=3B
> diff --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi b/arch/powerpc/bo=
ot/dts/fsl/p4080si-pre.dtsi
> new file mode 100644
> index 0000000..b353ac9
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi
> @@ -0=2C0 +1=2C145 @@
> +/*
> + * P4080/P4040 Silicon/SoC Device Tree Source (pre include)
> + *
> + * Copyright 2011 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms=2C with or without
> + * modification=2C are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above copyright
> + *       notice=2C this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyrig=
ht
> + *       notice=2C this list of conditions and the following disclaimer =
in the
> + *       documentation and/or other materials provided with the distribu=
tion.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote pro=
ducts
> + *       derived from this software without specific prior written permi=
ssion.
> + *
> + *
> + * ALTERNATIVELY=2C this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation=2C either version 2 of that License or (at your option) an=
y
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND AN=
Y
> + * EXPRESS OR IMPLIED WARRANTIES=2C INCLUDING=2C BUT NOT LIMITED TO=2C T=
HE IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
> + * DIRECT=2C INDIRECT=2C INCIDENTAL=2C SPECIAL=2C EXEMPLARY=2C OR CONSEQ=
UENTIAL DAMAGES
> + * (INCLUDING=2C BUT NOT LIMITED TO=2C PROCUREMENT OF SUBSTITUTE GOODS O=
R SERVICES=3B
> + * LOSS OF USE=2C DATA=2C OR PROFITS=3B OR BUSINESS INTERRUPTION) HOWEVE=
R CAUSED AND
> + * ON ANY THEORY OF LIABILITY=2C WHETHER IN CONTRACT=2C STRICT LIABILITY=
=2C OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
> + * SOFTWARE=2C EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/dts-v1/=3B
> +/ {
> +	compatible =3D "fsl=2CP4080"=3B
> +	#address-cells =3D <2>=3B
> +	#size-cells =3D <2>=3B
> +	interrupt-parent =3D <&mpic>=3B
> +
> +	aliases {
> +		ccsr =3D &soc=3B
> +		dcsr =3D &dcsr=3B
> +
> +		serial0 =3D &serial0=3B
> +		serial1 =3D &serial1=3B
> +		serial2 =3D &serial2=3B
> +		serial3 =3D &serial3=3B
> +		pci0 =3D &pci0=3B
> +		pci1 =3D &pci1=3B
> +		pci2 =3D &pci2=3B
> +		usb0 =3D &usb0=3B
> +		usb1 =3D &usb1=3B
> +		dma0 =3D &dma0=3B
> +		dma1 =3D &dma1=3B
> +		sdhc =3D &sdhc=3B
> +		msi0 =3D &msi0=3B
> +		msi1 =3D &msi1=3B
> +		msi2 =3D &msi2=3B
> +
> +		crypto =3D &crypto=3B
> +		sec_jr0 =3D &sec_jr0=3B
> +		sec_jr1 =3D &sec_jr1=3B
> +		sec_jr2 =3D &sec_jr2=3B
> +		sec_jr3 =3D &sec_jr3=3B
> +		rtic_a =3D &rtic_a=3B
> +		rtic_b =3D &rtic_b=3B
> +		rtic_c =3D &rtic_c=3B
> +		rtic_d =3D &rtic_d=3B
> +		sec_mon =3D &sec_mon=3B
> +
> +		rio0 =3D &rapidio0=3B
> +	}=3B
> +
> +	cpus {
> +		#address-cells =3D <1>=3B
> +		#size-cells =3D <0>=3B
> +
> +		cpu0: PowerPC=2Ce500mc@0 {
> +			device_type =3D "cpu"=3B
> +			reg =3D <0>=3B
> +			next-level-cache =3D <&L2_0>=3B
> +			L2_0: l2-cache {
> +				next-level-cache =3D <&cpc>=3B
> +			}=3B
> +		}=3B
> +		cpu1: PowerPC=2Ce500mc@1 {
> +			device_type =3D "cpu"=3B
> +			reg =3D <1>=3B
> +			next-level-cache =3D <&L2_1>=3B
> +			L2_1: l2-cache {
> +				next-level-cache =3D <&cpc>=3B
> +			}=3B
> +		}=3B
> +		cpu2: PowerPC=2Ce500mc@2 {
> +			device_type =3D "cpu"=3B
> +			reg =3D <2>=3B
> +			next-level-cache =3D <&L2_2>=3B
> +			L2_2: l2-cache {
> +				next-level-cache =3D <&cpc>=3B
> +			}=3B
> +		}=3B
> +		cpu3: PowerPC=2Ce500mc@3 {
> +			device_type =3D "cpu"=3B
> +			reg =3D <3>=3B
> +			next-level-cache =3D <&L2_3>=3B
> +			L2_3: l2-cache {
> +				next-level-cache =3D <&cpc>=3B
> +			}=3B
> +		}=3B
> +		cpu4: PowerPC=2Ce500mc@4 {
> +			device_type =3D "cpu"=3B
> +			reg =3D <4>=3B
> +			next-level-cache =3D <&L2_4>=3B
> +			L2_4: l2-cache {
> +				next-level-cache =3D <&cpc>=3B
> +			}=3B
> +		}=3B
> +		cpu5: PowerPC=2Ce500mc@5 {
> +			device_type =3D "cpu"=3B
> +			reg =3D <5>=3B
> +			next-level-cache =3D <&L2_5>=3B
> +			L2_5: l2-cache {
> +				next-level-cache =3D <&cpc>=3B
> +			}=3B
> +		}=3B
> +		cpu6: PowerPC=2Ce500mc@6 {
> +			device_type =3D "cpu"=3B
> +			reg =3D <6>=3B
> +			next-level-cache =3D <&L2_6>=3B
> +			L2_6: l2-cache {
> +				next-level-cache =3D <&cpc>=3B
> +			}=3B
> +		}=3B
> +		cpu7: PowerPC=2Ce500mc@7 {
> +			device_type =3D "cpu"=3B
> +			reg =3D <7>=3B
> +			next-level-cache =3D <&L2_7>=3B
> +			L2_7: l2-cache {
> +				next-level-cache =3D <&cpc>=3B
> +			}=3B
> +		}=3B
> +	}=3B
> +}=3B
> diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4=
080ds.dts
> index c7916dc..8ea1ae9 100644
> --- a/arch/powerpc/boot/dts/p4080ds.dts
> +++ b/arch/powerpc/boot/dts/p4080ds.dts
> @@ -32=2C7 +32=2C7 @@
>   * SOFTWARE=2C EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>   */
> =20
> -/include/ "p4080si.dtsi"
> +/include/ "fsl/p4080si-pre.dtsi"
> =20
>  / {
>  	model =3D "fsl=2CP4080DS"=3B
> @@ -50=2C6 +50=2C9 @@
>  	}=3B
> =20
>  	soc: soc@ffe000000 {
> +		ranges =3D <0x00000000 0xf 0xfe000000 0x1000000>=3B
> +		reg =3D <0xf 0xfe000000 0 0x00001000>=3B
> +
>  		spi@110000 {
>  			flash@0 {
>  				#address-cells =3D <1>=3B
> @@ -105=2C12 +108=2C12 @@
>  		}=3B
>  	}=3B
> =20
> -	rapidio0: rapidio@ffe0c0000 {
> +	rio: rapidio0: rapidio@ffe0c0000 {
>  		reg =3D <0xf 0xfe0c0000 0 0x20000>=3B
>  		ranges =3D <0 0 0xc 0x20000000 0 0x01000000>=3B
>  	}=3B
> =20
> -	localbus@ffe124000 {
> +	lbc: localbus@ffe124000 {
>  		reg =3D <0xf 0xfe124000 0 0x1000>=3B
>  		ranges =3D <0 0 0xf 0xe8000000 0x08000000
>  			  3 0 0xf 0xffdf0000 0x00008000>=3B
> @@ -132=2C6 +135=2C7 @@
>  		reg =3D <0xf 0xfe200000 0 0x1000>=3B
>  		ranges =3D <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
>  			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>=3B
> +		fsl=2Cmsi =3D <&msi0>=3B
>  		pcie@0 {
>  			ranges =3D <0x02000000 0 0xe0000000
>  				  0x02000000 0 0xe0000000
> @@ -147=2C6 +151=2C7 @@
>  		reg =3D <0xf 0xfe201000 0 0x1000>=3B
>  		ranges =3D <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
>  			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>=3B
> +		fsl=2Cmsi =3D <&msi1>=3B
>  		pcie@0 {
>  			ranges =3D <0x02000000 0 0xe0000000
>  				  0x02000000 0 0xe0000000
> @@ -162=2C6 +167=2C7 @@
>  		reg =3D <0xf 0xfe202000 0 0x1000>=3B
>  		ranges =3D <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
>  			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>=3B
> +		fsl=2Cmsi =3D <&msi2>=3B
>  		pcie@0 {
>  			ranges =3D <0x02000000 0 0xe0000000
>  				  0x02000000 0 0xe0000000
> @@ -174=2C3 +180=2C5 @@
>  	}=3B
> =20
>  }=3B
> +
> +/include/ "fsl/p4080si-post.dtsi"
> diff --git a/arch/powerpc/boot/dts/p4080si.dtsi b/arch/powerpc/boot/dts/p=
4080si.dtsi
> deleted file mode 100644
> index f20c01a..0000000
> --- a/arch/powerpc/boot/dts/p4080si.dtsi
> +++ /dev/null
> @@ -1=2C755 +0=2C0 @@
> -/*
> - * P4080 Silicon Device Tree Source
> - *
> - * Copyright 2009-2011 Freescale Semiconductor Inc.
> - *
> - * Redistribution and use in source and binary forms=2C with or without
> - * modification=2C are permitted provided that the following conditions =
are met:
> - *     * Redistributions of source code must retain the above copyright
> - *       notice=2C this list of conditions and the following disclaimer.
> - *     * Redistributions in binary form must reproduce the above copyrig=
ht
> - *       notice=2C this list of conditions and the following disclaimer =
in the
> - *       documentation and/or other materials provided with the distribu=
tion.
> - *     * Neither the name of Freescale Semiconductor nor the
> - *       names of its contributors may be used to endorse or promote pro=
ducts
> - *       derived from this software without specific prior written permi=
ssion.
> - *
> - *
> - * ALTERNATIVELY=2C this software may be distributed under the terms of =
the
> - * GNU General Public License ("GPL") as published by the Free Software
> - * Foundation=2C either version 2 of that License or (at your option) an=
y
> - * later version.
> - *
> - * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND AN=
Y
> - * EXPRESS OR IMPLIED WARRANTIES=2C INCLUDING=2C BUT NOT LIMITED TO=2C T=
HE IMPLIED
> - * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE AR=
E
> - * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR A=
NY
> - * DIRECT=2C INDIRECT=2C INCIDENTAL=2C SPECIAL=2C EXEMPLARY=2C OR CONSEQ=
UENTIAL DAMAGES
> - * (INCLUDING=2C BUT NOT LIMITED TO=2C PROCUREMENT OF SUBSTITUTE GOODS O=
R SERVICES=3B
> - * LOSS OF USE=2C DATA=2C OR PROFITS=3B OR BUSINESS INTERRUPTION) HOWEVE=
R CAUSED AND
> - * ON ANY THEORY OF LIABILITY=2C WHETHER IN CONTRACT=2C STRICT LIABILITY=
=2C OR TORT
> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE=
 OF THIS
> - * SOFTWARE=2C EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - */
> -
> -/dts-v1/=3B
> -
> -/ {
> -	compatible =3D "fsl=2CP4080"=3B
> -	#address-cells =3D <2>=3B
> -	#size-cells =3D <2>=3B
> -	interrupt-parent =3D <&mpic>=3B
> -
> -	aliases {
> -		ccsr =3D &soc=3B
> -		dcsr =3D &dcsr=3B
> -
> -		serial0 =3D &serial0=3B
> -		serial1 =3D &serial1=3B
> -		serial2 =3D &serial2=3B
> -		serial3 =3D &serial3=3B
> -		pci0 =3D &pci0=3B
> -		pci1 =3D &pci1=3B
> -		pci2 =3D &pci2=3B
> -		usb0 =3D &usb0=3B
> -		usb1 =3D &usb1=3B
> -		dma0 =3D &dma0=3B
> -		dma1 =3D &dma1=3B
> -		sdhc =3D &sdhc=3B
> -		msi0 =3D &msi0=3B
> -		msi1 =3D &msi1=3B
> -		msi2 =3D &msi2=3B
> -
> -		crypto =3D &crypto=3B
> -		sec_jr0 =3D &sec_jr0=3B
> -		sec_jr1 =3D &sec_jr1=3B
> -		sec_jr2 =3D &sec_jr2=3B
> -		sec_jr3 =3D &sec_jr3=3B
> -		rtic_a =3D &rtic_a=3B
> -		rtic_b =3D &rtic_b=3B
> -		rtic_c =3D &rtic_c=3B
> -		rtic_d =3D &rtic_d=3B
> -		sec_mon =3D &sec_mon=3B
> -
> -		rio0 =3D &rapidio0=3B
> -	}=3B
> -
> -	cpus {
> -		#address-cells =3D <1>=3B
> -		#size-cells =3D <0>=3B
> -
> -		cpu0: PowerPC=2Ce500mc@0 {
> -			device_type =3D "cpu"=3B
> -			reg =3D <0>=3B
> -			next-level-cache =3D <&L2_0>=3B
> -			L2_0: l2-cache {
> -				next-level-cache =3D <&cpc>=3B
> -			}=3B
> -		}=3B
> -		cpu1: PowerPC=2Ce500mc@1 {
> -			device_type =3D "cpu"=3B
> -			reg =3D <1>=3B
> -			next-level-cache =3D <&L2_1>=3B
> -			L2_1: l2-cache {
> -				next-level-cache =3D <&cpc>=3B
> -			}=3B
> -		}=3B
> -		cpu2: PowerPC=2Ce500mc@2 {
> -			device_type =3D "cpu"=3B
> -			reg =3D <2>=3B
> -			next-level-cache =3D <&L2_2>=3B
> -			L2_2: l2-cache {
> -				next-level-cache =3D <&cpc>=3B
> -			}=3B
> -		}=3B
> -		cpu3: PowerPC=2Ce500mc@3 {
> -			device_type =3D "cpu"=3B
> -			reg =3D <3>=3B
> -			next-level-cache =3D <&L2_3>=3B
> -			L2_3: l2-cache {
> -				next-level-cache =3D <&cpc>=3B
> -			}=3B
> -		}=3B
> -		cpu4: PowerPC=2Ce500mc@4 {
> -			device_type =3D "cpu"=3B
> -			reg =3D <4>=3B
> -			next-level-cache =3D <&L2_4>=3B
> -			L2_4: l2-cache {
> -				next-level-cache =3D <&cpc>=3B
> -			}=3B
> -		}=3B
> -		cpu5: PowerPC=2Ce500mc@5 {
> -			device_type =3D "cpu"=3B
> -			reg =3D <5>=3B
> -			next-level-cache =3D <&L2_5>=3B
> -			L2_5: l2-cache {
> -				next-level-cache =3D <&cpc>=3B
> -			}=3B
> -		}=3B
> -		cpu6: PowerPC=2Ce500mc@6 {
> -			device_type =3D "cpu"=3B
> -			reg =3D <6>=3B
> -			next-level-cache =3D <&L2_6>=3B
> -			L2_6: l2-cache {
> -				next-level-cache =3D <&cpc>=3B
> -			}=3B
> -		}=3B
> -		cpu7: PowerPC=2Ce500mc@7 {
> -			device_type =3D "cpu"=3B
> -			reg =3D <7>=3B
> -			next-level-cache =3D <&L2_7>=3B
> -			L2_7: l2-cache {
> -				next-level-cache =3D <&cpc>=3B
> -			}=3B
> -		}=3B
> -	}=3B
> -
> -	dcsr: dcsr@f00000000 {
> -		#address-cells =3D <1>=3B
> -		#size-cells =3D <1>=3B
> -		compatible =3D "fsl=2Cdcsr"=2C "simple-bus"=3B
> -
> -		dcsr-epu@0 {
> -			compatible =3D "fsl=2Cdcsr-epu"=3B
> -			interrupts =3D <52 2 0 0
> -				      84 2 0 0
> -				      85 2 0 0>=3B
> -			interrupt-parent =3D <&mpic>=3B
> -			reg =3D <0x0 0x1000>=3B
> -		}=3B
> -		dcsr-npc {
> -			compatible =3D "fsl=2Cdcsr-npc"=3B
> -			reg =3D <0x1000 0x1000 0x1000000 0x8000>=3B
> -		}=3B
> -		dcsr-nxc@2000 {
> -			compatible =3D "fsl=2Cdcsr-nxc"=3B
> -			reg =3D <0x2000 0x1000>=3B
> -		}=3B
> -		dcsr-corenet {
> -			compatible =3D "fsl=2Cdcsr-corenet"=3B
> -			reg =3D <0x8000 0x1000 0xB0000 0x1000>=3B
> -		}=3B
> -		dcsr-dpaa@9000 {
> -			compatible =3D "fsl=2Cp4080-dcsr-dpaa"=2C "fsl=2Cdcsr-dpaa"=3B
> -			reg =3D <0x9000 0x1000>=3B
> -		}=3B
> -		dcsr-ocn@11000 {
> -			compatible =3D "fsl=2Cp4080-dcsr-ocn"=2C "fsl=2Cdcsr-ocn"=3B
> -			reg =3D <0x11000 0x1000>=3B
> -		}=3B
> -		dcsr-ddr@12000 {
> -			compatible =3D "fsl=2Cdcsr-ddr"=3B
> -			dev-handle =3D <&ddr1>=3B
> -			reg =3D <0x12000 0x1000>=3B
> -		}=3B
> -		dcsr-ddr@13000 {
> -			compatible =3D "fsl=2Cdcsr-ddr"=3B
> -			dev-handle =3D <&ddr2>=3B
> -			reg =3D <0x13000 0x1000>=3B
> -		}=3B
> -		dcsr-nal@18000 {
> -			compatible =3D "fsl=2Cp4080-dcsr-nal"=2C "fsl=2Cdcsr-nal"=3B
> -			reg =3D <0x18000 0x1000>=3B
> -		}=3B
> -		dcsr-rcpm@22000 {
> -			compatible =3D "fsl=2Cp4080-dcsr-rcpm"=2C "fsl=2Cdcsr-rcpm"=3B
> -			reg =3D <0x22000 0x1000>=3B
> -		}=3B
> -		dcsr-cpu-sb-proxy@40000 {
> -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-pro=
xy"=3B
> -			cpu-handle =3D <&cpu0>=3B
> -			reg =3D <0x40000 0x1000>=3B
> -		}=3B
> -		dcsr-cpu-sb-proxy@41000 {
> -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-pro=
xy"=3B
> -			cpu-handle =3D <&cpu1>=3B
> -			reg =3D <0x41000 0x1000>=3B
> -		}=3B
> -		dcsr-cpu-sb-proxy@42000 {
> -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-pro=
xy"=3B
> -			cpu-handle =3D <&cpu2>=3B
> -			reg =3D <0x42000 0x1000>=3B
> -		}=3B
> -		dcsr-cpu-sb-proxy@43000 {
> -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-pro=
xy"=3B
> -			cpu-handle =3D <&cpu3>=3B
> -			reg =3D <0x43000 0x1000>=3B
> -		}=3B
> -		dcsr-cpu-sb-proxy@44000 {
> -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-pro=
xy"=3B
> -			cpu-handle =3D <&cpu4>=3B
> -			reg =3D <0x44000 0x1000>=3B
> -		}=3B
> -		dcsr-cpu-sb-proxy@45000 {
> -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-pro=
xy"=3B
> -			cpu-handle =3D <&cpu5>=3B
> -			reg =3D <0x45000 0x1000>=3B
> -		}=3B
> -		dcsr-cpu-sb-proxy@46000 {
> -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-pro=
xy"=3B
> -			cpu-handle =3D <&cpu6>=3B
> -			reg =3D <0x46000 0x1000>=3B
> -		}=3B
> -		dcsr-cpu-sb-proxy@47000 {
> -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-pro=
xy"=3B
> -			cpu-handle =3D <&cpu7>=3B
> -			reg =3D <0x47000 0x1000>=3B
> -		}=3B
> -	}=3B
> -
> -	soc: soc@ffe000000 {
> -		#address-cells =3D <1>=3B
> -		#size-cells =3D <1>=3B
> -		device_type =3D "soc"=3B
> -		compatible =3D "simple-bus"=3B
> -		ranges =3D <0x00000000 0xf 0xfe000000 0x1000000>=3B
> -		reg =3D <0xf 0xfe000000 0 0x00001000>=3B
> -
> -		soc-sram-error {
> -			compatible =3D "fsl=2Csoc-sram-error"=3B
> -			interrupts =3D <16 2 1 29>=3B
> -		}=3B
> -
> -		corenet-law@0 {
> -			compatible =3D "fsl=2Ccorenet-law"=3B
> -			reg =3D <0x0 0x1000>=3B
> -			fsl=2Cnum-laws =3D <32>=3B
> -		}=3B
> -
> -		ddr1: memory-controller@8000 {
> -			compatible =3D "fsl=2Cqoriq-memory-controller-v4.4"=2C "fsl=2Cqoriq-m=
emory-controller"=3B
> -			reg =3D <0x8000 0x1000>=3B
> -			interrupts =3D <16 2 1 23>=3B
> -		}=3B
> -
> -		ddr2: memory-controller@9000 {
> -			compatible =3D "fsl=2Cqoriq-memory-controller-v4.4"=2C"fsl=2Cqoriq-me=
mory-controller"=3B
> -			reg =3D <0x9000 0x1000>=3B
> -			interrupts =3D <16 2 1 22>=3B
> -		}=3B
> -
> -		cpc: l3-cache-controller@10000 {
> -			compatible =3D "fsl=2Cp4080-l3-cache-controller"=2C "cache"=3B
> -			reg =3D <0x10000 0x1000
> -			       0x11000 0x1000>=3B
> -			interrupts =3D <16 2 1 27
> -				      16 2 1 26>=3B
> -		}=3B
> -
> -		corenet-cf@18000 {
> -			compatible =3D "fsl=2Ccorenet-cf"=3B
> -			reg =3D <0x18000 0x1000>=3B
> -			interrupts =3D <16 2 1 31>=3B
> -			fsl=2Cccf-num-csdids =3D <32>=3B
> -			fsl=2Cccf-num-snoopids =3D <32>=3B
> -		}=3B
> -
> -		iommu@20000 {
> -			compatible =3D "fsl=2Cpamu-v1.0"=2C "fsl=2Cpamu"=3B
> -			reg =3D <0x20000 0x5000>=3B
> -			interrupts =3D <
> -				24 2 0 0
> -				16 2 1 30>=3B
> -		}=3B
> -
> -		mpic: pic@40000 {
> -			clock-frequency =3D <0>=3B
> -			interrupt-controller=3B
> -			#address-cells =3D <0>=3B
> -			#interrupt-cells =3D <4>=3B
> -			reg =3D <0x40000 0x40000>=3B
> -			compatible =3D "fsl=2Cmpic"=2C "chrp=2Copen-pic"=3B
> -			device_type =3D "open-pic"=3B
> -		}=3B
> -
> -		msi0: msi@41600 {
> -			compatible =3D "fsl=2Cmpic-msi"=3B
> -			reg =3D <0x41600 0x200>=3B
> -			msi-available-ranges =3D <0 0x100>=3B
> -			interrupts =3D <
> -				0xe0 0 0 0
> -				0xe1 0 0 0
> -				0xe2 0 0 0
> -				0xe3 0 0 0
> -				0xe4 0 0 0
> -				0xe5 0 0 0
> -				0xe6 0 0 0
> -				0xe7 0 0 0>=3B
> -		}=3B
> -
> -		msi1: msi@41800 {
> -			compatible =3D "fsl=2Cmpic-msi"=3B
> -			reg =3D <0x41800 0x200>=3B
> -			msi-available-ranges =3D <0 0x100>=3B
> -			interrupts =3D <
> -				0xe8 0 0 0
> -				0xe9 0 0 0
> -				0xea 0 0 0
> -				0xeb 0 0 0
> -				0xec 0 0 0
> -				0xed 0 0 0
> -				0xee 0 0 0
> -				0xef 0 0 0>=3B
> -		}=3B
> -
> -		msi2: msi@41a00 {
> -			compatible =3D "fsl=2Cmpic-msi"=3B
> -			reg =3D <0x41a00 0x200>=3B
> -			msi-available-ranges =3D <0 0x100>=3B
> -			interrupts =3D <
> -				0xf0 0 0 0
> -				0xf1 0 0 0
> -				0xf2 0 0 0
> -				0xf3 0 0 0
> -				0xf4 0 0 0
> -				0xf5 0 0 0
> -				0xf6 0 0 0
> -				0xf7 0 0 0>=3B
> -		}=3B
> -
> -		guts: global-utilities@e0000 {
> -			compatible =3D "fsl=2Cqoriq-device-config-1.0"=3B
> -			reg =3D <0xe0000 0xe00>=3B
> -			fsl=2Chas-rstcr=3B
> -			#sleep-cells =3D <1>=3B
> -			fsl=2Cliodn-bits =3D <12>=3B
> -		}=3B
> -
> -		pins: global-utilities@e0e00 {
> -			compatible =3D "fsl=2Cqoriq-pin-control-1.0"=3B
> -			reg =3D <0xe0e00 0x200>=3B
> -			#sleep-cells =3D <2>=3B
> -		}=3B
> -
> -		clockgen: global-utilities@e1000 {
> -			compatible =3D "fsl=2Cp4080-clockgen"=2C "fsl=2Cqoriq-clockgen-1.0"=
=3B
> -			reg =3D <0xe1000 0x1000>=3B
> -			clock-frequency =3D <0>=3B
> -		}=3B
> -
> -		rcpm: global-utilities@e2000 {
> -			compatible =3D "fsl=2Cqoriq-rcpm-1.0"=3B
> -			reg =3D <0xe2000 0x1000>=3B
> -			#sleep-cells =3D <1>=3B
> -		}=3B
> -
> -		sfp: sfp@e8000 {
> -			compatible =3D "fsl=2Cp4080-sfp"=2C "fsl=2Cqoriq-sfp-1.0"=3B
> -			reg	   =3D <0xe8000 0x1000>=3B
> -		}=3B
> -
> -		serdes: serdes@ea000 {
> -			compatible =3D "fsl=2Cp4080-serdes"=3B
> -			reg	   =3D <0xea000 0x1000>=3B
> -		}=3B
> -
> -		dma0: dma@100300 {
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <1>=3B
> -			compatible =3D "fsl=2Cp4080-dma"=2C "fsl=2Celoplus-dma"=3B
> -			reg =3D <0x100300 0x4>=3B
> -			ranges =3D <0x0 0x100100 0x200>=3B
> -			cell-index =3D <0>=3B
> -			dma-channel@0 {
> -				compatible =3D "fsl=2Cp4080-dma-channel"=2C
> -						"fsl=2Celoplus-dma-channel"=3B
> -				reg =3D <0x0 0x80>=3B
> -				cell-index =3D <0>=3B
> -				interrupts =3D <28 2 0 0>=3B
> -			}=3B
> -			dma-channel@80 {
> -				compatible =3D "fsl=2Cp4080-dma-channel"=2C
> -						"fsl=2Celoplus-dma-channel"=3B
> -				reg =3D <0x80 0x80>=3B
> -				cell-index =3D <1>=3B
> -				interrupts =3D <29 2 0 0>=3B
> -			}=3B
> -			dma-channel@100 {
> -				compatible =3D "fsl=2Cp4080-dma-channel"=2C
> -						"fsl=2Celoplus-dma-channel"=3B
> -				reg =3D <0x100 0x80>=3B
> -				cell-index =3D <2>=3B
> -				interrupts =3D <30 2 0 0>=3B
> -			}=3B
> -			dma-channel@180 {
> -				compatible =3D "fsl=2Cp4080-dma-channel"=2C
> -						"fsl=2Celoplus-dma-channel"=3B
> -				reg =3D <0x180 0x80>=3B
> -				cell-index =3D <3>=3B
> -				interrupts =3D <31 2 0 0>=3B
> -			}=3B
> -		}=3B
> -
> -		dma1: dma@101300 {
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <1>=3B
> -			compatible =3D "fsl=2Cp4080-dma"=2C "fsl=2Celoplus-dma"=3B
> -			reg =3D <0x101300 0x4>=3B
> -			ranges =3D <0x0 0x101100 0x200>=3B
> -			cell-index =3D <1>=3B
> -			dma-channel@0 {
> -				compatible =3D "fsl=2Cp4080-dma-channel"=2C
> -						"fsl=2Celoplus-dma-channel"=3B
> -				reg =3D <0x0 0x80>=3B
> -				cell-index =3D <0>=3B
> -				interrupts =3D <32 2 0 0>=3B
> -			}=3B
> -			dma-channel@80 {
> -				compatible =3D "fsl=2Cp4080-dma-channel"=2C
> -						"fsl=2Celoplus-dma-channel"=3B
> -				reg =3D <0x80 0x80>=3B
> -				cell-index =3D <1>=3B
> -				interrupts =3D <33 2 0 0>=3B
> -			}=3B
> -			dma-channel@100 {
> -				compatible =3D "fsl=2Cp4080-dma-channel"=2C
> -						"fsl=2Celoplus-dma-channel"=3B
> -				reg =3D <0x100 0x80>=3B
> -				cell-index =3D <2>=3B
> -				interrupts =3D <34 2 0 0>=3B
> -			}=3B
> -			dma-channel@180 {
> -				compatible =3D "fsl=2Cp4080-dma-channel"=2C
> -						"fsl=2Celoplus-dma-channel"=3B
> -				reg =3D <0x180 0x80>=3B
> -				cell-index =3D <3>=3B
> -				interrupts =3D <35 2 0 0>=3B
> -			}=3B
> -		}=3B
> -
> -		spi@110000 {
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <0>=3B
> -			compatible =3D "fsl=2Cp4080-espi"=2C "fsl=2Cmpc8536-espi"=3B
> -			reg =3D <0x110000 0x1000>=3B
> -			interrupts =3D <53 0x2 0 0>=3B
> -			fsl=2Cespi-num-chipselects =3D <4>=3B
> -		}=3B
> -
> -		sdhc: sdhc@114000 {
> -			compatible =3D "fsl=2Cp4080-esdhc"=2C "fsl=2Cesdhc"=3B
> -			reg =3D <0x114000 0x1000>=3B
> -			interrupts =3D <48 2 0 0>=3B
> -			voltage-ranges =3D <3300 3300>=3B
> -			sdhci=2Cauto-cmd12=3B
> -			clock-frequency =3D <0>=3B
> -		}=3B
> -
> -		i2c@118000 {
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <0>=3B
> -			cell-index =3D <0>=3B
> -			compatible =3D "fsl-i2c"=3B
> -			reg =3D <0x118000 0x100>=3B
> -			interrupts =3D <38 2 0 0>=3B
> -			dfsrr=3B
> -		}=3B
> -
> -		i2c@118100 {
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <0>=3B
> -			cell-index =3D <1>=3B
> -			compatible =3D "fsl-i2c"=3B
> -			reg =3D <0x118100 0x100>=3B
> -			interrupts =3D <38 2 0 0>=3B
> -			dfsrr=3B
> -		}=3B
> -
> -		i2c@119000 {
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <0>=3B
> -			cell-index =3D <2>=3B
> -			compatible =3D "fsl-i2c"=3B
> -			reg =3D <0x119000 0x100>=3B
> -			interrupts =3D <39 2 0 0>=3B
> -			dfsrr=3B
> -		}=3B
> -
> -		i2c@119100 {
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <0>=3B
> -			cell-index =3D <3>=3B
> -			compatible =3D "fsl-i2c"=3B
> -			reg =3D <0x119100 0x100>=3B
> -			interrupts =3D <39 2 0 0>=3B
> -			dfsrr=3B
> -		}=3B
> -
> -		serial0: serial@11c500 {
> -			cell-index =3D <0>=3B
> -			device_type =3D "serial"=3B
> -			compatible =3D "ns16550"=3B
> -			reg =3D <0x11c500 0x100>=3B
> -			clock-frequency =3D <0>=3B
> -			interrupts =3D <36 2 0 0>=3B
> -		}=3B
> -
> -		serial1: serial@11c600 {
> -			cell-index =3D <1>=3B
> -			device_type =3D "serial"=3B
> -			compatible =3D "ns16550"=3B
> -			reg =3D <0x11c600 0x100>=3B
> -			clock-frequency =3D <0>=3B
> -			interrupts =3D <36 2 0 0>=3B
> -		}=3B
> -
> -		serial2: serial@11d500 {
> -			cell-index =3D <2>=3B
> -			device_type =3D "serial"=3B
> -			compatible =3D "ns16550"=3B
> -			reg =3D <0x11d500 0x100>=3B
> -			clock-frequency =3D <0>=3B
> -			interrupts =3D <37 2 0 0>=3B
> -		}=3B
> -
> -		serial3: serial@11d600 {
> -			cell-index =3D <3>=3B
> -			device_type =3D "serial"=3B
> -			compatible =3D "ns16550"=3B
> -			reg =3D <0x11d600 0x100>=3B
> -			clock-frequency =3D <0>=3B
> -			interrupts =3D <37 2 0 0>=3B
> -		}=3B
> -
> -		gpio0: gpio@130000 {
> -			compatible =3D "fsl=2Cp4080-gpio"=2C "fsl=2Cqoriq-gpio"=3B
> -			reg =3D <0x130000 0x1000>=3B
> -			interrupts =3D <55 2 0 0>=3B
> -			#gpio-cells =3D <2>=3B
> -			gpio-controller=3B
> -		}=3B
> -
> -		usb0: usb@210000 {
> -			compatible =3D "fsl=2Cp4080-usb2-mph"=2C
> -					"fsl=2Cmpc85xx-usb2-mph"=2C "fsl-usb2-mph"=3B
> -			reg =3D <0x210000 0x1000>=3B
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <0>=3B
> -			interrupts =3D <44 0x2 0 0>=3B
> -		}=3B
> -
> -		usb1: usb@211000 {
> -			compatible =3D "fsl=2Cp4080-usb2-dr"=2C
> -					"fsl=2Cmpc85xx-usb2-dr"=2C "fsl-usb2-dr"=3B
> -			reg =3D <0x211000 0x1000>=3B
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <0>=3B
> -			interrupts =3D <45 0x2 0 0>=3B
> -		}=3B
> -
> -		crypto: crypto@300000 {
> -			compatible =3D "fsl=2Csec-v4.0"=3B
> -			#address-cells =3D <1>=3B
> -			#size-cells =3D <1>=3B
> -			reg =3D <0x300000 0x10000>=3B
> -			ranges =3D <0 0x300000 0x10000>=3B
> -			interrupt-parent =3D <&mpic>=3B
> -			interrupts =3D <92 2 0 0>=3B
> -
> -			sec_jr0: jr@1000 {
> -				compatible =3D "fsl=2Csec-v4.0-job-ring"=3B
> -				reg =3D <0x1000 0x1000>=3B
> -				interrupt-parent =3D <&mpic>=3B
> -				interrupts =3D <88 2 0 0>=3B
> -			}=3B
> -
> -			sec_jr1: jr@2000 {
> -				compatible =3D "fsl=2Csec-v4.0-job-ring"=3B
> -				reg =3D <0x2000 0x1000>=3B
> -				interrupt-parent =3D <&mpic>=3B
> -				interrupts =3D <89 2 0 0>=3B
> -			}=3B
> -
> -			sec_jr2: jr@3000 {
> -				compatible =3D "fsl=2Csec-v4.0-job-ring"=3B
> -				reg =3D <0x3000 0x1000>=3B
> -				interrupt-parent =3D <&mpic>=3B
> -				interrupts =3D <90 2 0 0>=3B
> -			}=3B
> -
> -			sec_jr3: jr@4000 {
> -				compatible =3D "fsl=2Csec-v4.0-job-ring"=3B
> -				reg =3D <0x4000 0x1000>=3B
> -				interrupt-parent =3D <&mpic>=3B
> -				interrupts =3D <91 2 0 0>=3B
> -			}=3B
> -
> -			rtic@6000 {
> -				compatible =3D "fsl=2Csec-v4.0-rtic"=3B
> -				#address-cells =3D <1>=3B
> -				#size-cells =3D <1>=3B
> -				reg =3D <0x6000 0x100>=3B
> -				ranges =3D <0x0 0x6100 0xe00>=3B
> -
> -				rtic_a: rtic-a@0 {
> -					compatible =3D "fsl=2Csec-v4.0-rtic-memory"=3B
> -					reg =3D <0x00 0x20 0x100 0x80>=3B
> -				}=3B
> -
> -				rtic_b: rtic-b@20 {
> -					compatible =3D "fsl=2Csec-v4.0-rtic-memory"=3B
> -					reg =3D <0x20 0x20 0x200 0x80>=3B
> -				}=3B
> -
> -				rtic_c: rtic-c@40 {
> -					compatible =3D "fsl=2Csec-v4.0-rtic-memory"=3B
> -					reg =3D <0x40 0x20 0x300 0x80>=3B
> -				}=3B
> -
> -				rtic_d: rtic-d@60 {
> -					compatible =3D "fsl=2Csec-v4.0-rtic-memory"=3B
> -					reg =3D <0x60 0x20 0x500 0x80>=3B
> -				}=3B
> -			}=3B
> -		}=3B
> -
> -		sec_mon: sec_mon@314000 {
> -			compatible =3D "fsl=2Csec-v4.0-mon"=3B
> -			reg =3D <0x314000 0x1000>=3B
> -			interrupt-parent =3D <&mpic>=3B
> -			interrupts =3D <93 2 0 0>=3B
> -		}=3B
> -	}=3B
> -
> -	rapidio0: rapidio@ffe0c0000 {
> -		#address-cells =3D <2>=3B
> -		#size-cells =3D <2>=3B
> -		compatible =3D "fsl=2Crapidio-delta"=3B
> -		interrupts =3D <
> -			16 2 1 11 /* err_irq */
> -			56 2 0 0  /* bell_outb_irq */
> -			57 2 0 0  /* bell_inb_irq */
> -			60 2 0 0  /* msg1_tx_irq */
> -			61 2 0 0  /* msg1_rx_irq */
> -			62 2 0 0  /* msg2_tx_irq */
> -			63 2 0 0>=3B /* msg2_rx_irq */
> -	}=3B
> -
> -	localbus@ffe124000 {
> -		compatible =3D "fsl=2Cp4080-elbc"=2C "fsl=2Celbc"=2C "simple-bus"=3B
> -		interrupts =3D <25 2 0 0>=3B
> -		#address-cells =3D <2>=3B
> -		#size-cells =3D <1>=3B
> -	}=3B
> -
> -	pci0: pcie@ffe200000 {
> -		compatible =3D "fsl=2Cp4080-pcie"=3B
> -		device_type =3D "pci"=3B
> -		#size-cells =3D <2>=3B
> -		#address-cells =3D <3>=3B
> -		bus-range =3D <0x0 0xff>=3B
> -		clock-frequency =3D <0x1fca055>=3B
> -		fsl=2Cmsi =3D <&msi0>=3B
> -		interrupts =3D <16 2 1 15>=3B
> -		pcie@0 {
> -			reg =3D <0 0 0 0 0>=3B
> -			#interrupt-cells =3D <1>=3B
> -			#size-cells =3D <2>=3B
> -			#address-cells =3D <3>=3B
> -			device_type =3D "pci"=3B
> -			interrupts =3D <16 2 1 15>=3B
> -			interrupt-map-mask =3D <0xf800 0 0 7>=3B
> -			interrupt-map =3D <
> -				/* IDSEL 0x0 */
> -				0000 0 0 1 &mpic 40 1 0 0
> -				0000 0 0 2 &mpic 1 1 0 0
> -				0000 0 0 3 &mpic 2 1 0 0
> -				0000 0 0 4 &mpic 3 1 0 0
> -				>=3B
> -		}=3B
> -	}=3B
> -
> -	pci1: pcie@ffe201000 {
> -		compatible =3D "fsl=2Cp4080-pcie"=3B
> -		device_type =3D "pci"=3B
> -		#size-cells =3D <2>=3B
> -		#address-cells =3D <3>=3B
> -		bus-range =3D <0 0xff>=3B
> -		clock-frequency =3D <0x1fca055>=3B
> -		fsl=2Cmsi =3D <&msi1>=3B
> -		interrupts =3D <16 2 1 14>=3B
> -		pcie@0 {
> -			reg =3D <0 0 0 0 0>=3B
> -			#interrupt-cells =3D <1>=3B
> -			#size-cells =3D <2>=3B
> -			#address-cells =3D <3>=3B
> -			device_type =3D "pci"=3B
> -			interrupts =3D <16 2 1 14>=3B
> -			interrupt-map-mask =3D <0xf800 0 0 7>=3B
> -			interrupt-map =3D <
> -				/* IDSEL 0x0 */
> -				0000 0 0 1 &mpic 41 1 0 0
> -				0000 0 0 2 &mpic 5 1 0 0
> -				0000 0 0 3 &mpic 6 1 0 0
> -				0000 0 0 4 &mpic 7 1 0 0
> -				>=3B
> -		}=3B
> -	}=3B
> -
> -	pci2: pcie@ffe202000 {
> -		compatible =3D "fsl=2Cp4080-pcie"=3B
> -		device_type =3D "pci"=3B
> -		#size-cells =3D <2>=3B
> -		#address-cells =3D <3>=3B
> -		bus-range =3D <0x0 0xff>=3B
> -		clock-frequency =3D <0x1fca055>=3B
> -		fsl=2Cmsi =3D <&msi2>=3B
> -		interrupts =3D <16 2 1 13>=3B
> -		pcie@0 {
> -			reg =3D <0 0 0 0 0>=3B
> -			#interrupt-cells =3D <1>=3B
> -			#size-cells =3D <2>=3B
> -			#address-cells =3D <3>=3B
> -			device_type =3D "pci"=3B
> -			interrupts =3D <16 2 1 13>=3B
> -			interrupt-map-mask =3D <0xf800 0 0 7>=3B
> -			interrupt-map =3D <
> -				/* IDSEL 0x0 */
> -				0000 0 0 1 &mpic 42 1 0 0
> -				0000 0 0 2 &mpic 9 1 0 0
> -				0000 0 0 3 &mpic 10 1 0 0
> -				0000 0 0 4 &mpic 11 1 0 0
> -				>=3B
> -		}=3B
> -	}=3B
> -}=3B
> --=20
> 1.7.3.4
>=20
>=20
>=20
> ------------------------------
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>=20
> End of Linuxppc-dev Digest=2C Vol 87=2C Issue 61
> ********************************************
 		 	   		  =

--_b3c73276-44e2-4ef2-8842-730de20dc58e_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style><!--
.hmmessage P
{
margin:0px=3B
padding:0px
}
body.hmmessage
{
font-size: 10pt=3B
font-family:Tahoma
}
--></style>
</head>
<body class=3D'hmmessage'><div dir=3D'ltr'>
You have been great. Im in a pinch. I put linux on alot of computers. The c=
ustomers want ITunes. Do you have a package that will work on RPM or Debian=
.<br>Bob<br><br><div>&gt=3B From: linuxppc-dev-request@lists.ozlabs.org<br>=
&gt=3B Subject: Linuxppc-dev Digest=2C Vol 87=2C Issue 61<br>&gt=3B To: lin=
uxppc-dev@lists.ozlabs.org<br>&gt=3B Date: Fri=2C 11 Nov 2011 03:15:13 +110=
0<br>&gt=3B <br>&gt=3B Send Linuxppc-dev mailing list submissions to<br>&gt=
=3B 	linuxppc-dev@lists.ozlabs.org<br>&gt=3B <br>&gt=3B To subscribe or uns=
ubscribe via the World Wide Web=2C visit<br>&gt=3B 	https://lists.ozlabs.or=
g/listinfo/linuxppc-dev<br>&gt=3B or=2C via email=2C send a message with su=
bject or body 'help' to<br>&gt=3B 	linuxppc-dev-request@lists.ozlabs.org<br=
>&gt=3B <br>&gt=3B You can reach the person managing the list at<br>&gt=3B =
	linuxppc-dev-owner@lists.ozlabs.org<br>&gt=3B <br>&gt=3B When replying=2C =
please edit your Subject line so it is more specific<br>&gt=3B than "Re: Co=
ntents of Linuxppc-dev digest..."<br>&gt=3B <br>&gt=3B <br>&gt=3B Today's T=
opics:<br>&gt=3B <br>&gt=3B    1. [RFC][PATCH 23/30] powerpc/85xx: Rework P=
4080DS device trees<br>&gt=3B       (Kumar Gala)<br>&gt=3B <br>&gt=3B <br>&=
gt=3B ---------------------------------------------------------------------=
-<br>&gt=3B <br>&gt=3B Message: 1<br>&gt=3B Date: Thu=2C 10 Nov 2011 10:14:=
06 -0600<br>&gt=3B From: Kumar Gala &lt=3Bgalak@kernel.crashing.org&gt=3B<b=
r>&gt=3B To: linuxppc-dev@ozlabs.org<br>&gt=3B Subject: [RFC][PATCH 23/30] =
powerpc/85xx: Rework P4080DS device trees<br>&gt=3B Message-ID:<br>&gt=3B 	=
&lt=3B1320941653-29797-24-git-send-email-galak@kernel.crashing.org&gt=3B<br=
>&gt=3B <br>&gt=3B Signed-off-by: Kumar Gala &lt=3Bgalak@kernel.crashing.or=
g&gt=3B<br>&gt=3B ---<br>&gt=3B  arch/powerpc/boot/dts/fsl/p4080si-post.dts=
i |  342 ++++++++++++<br>&gt=3B  arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi=
  |  145 +++++<br>&gt=3B  arch/powerpc/boot/dts/p4080ds.dts           |   1=
4 +-<br>&gt=3B  arch/powerpc/boot/dts/p4080si.dtsi          |  755 --------=
-------------------<br>&gt=3B  4 files changed=2C 498 insertions(+)=2C 758 =
deletions(-)<br>&gt=3B  create mode 100644 arch/powerpc/boot/dts/fsl/p4080s=
i-post.dtsi<br>&gt=3B  create mode 100644 arch/powerpc/boot/dts/fsl/p4080si=
-pre.dtsi<br>&gt=3B  delete mode 100644 arch/powerpc/boot/dts/p4080si.dtsi<=
br>&gt=3B <br>&gt=3B diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dt=
si b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi<br>&gt=3B new file mode 10=
0644<br>&gt=3B index 0000000..1510991<br>&gt=3B --- /dev/null<br>&gt=3B +++=
 b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi<br>&gt=3B @@ -0=2C0 +1=2C342=
 @@<br>&gt=3B +/*<br>&gt=3B + * P4080/P4040 Silicon/SoC Device Tree Source =
(post include)<br>&gt=3B + *<br>&gt=3B + * Copyright 2011 Freescale Semicon=
ductor Inc.<br>&gt=3B + *<br>&gt=3B + * Redistribution and use in source an=
d binary forms=2C with or without<br>&gt=3B + * modification=2C are permitt=
ed provided that the following conditions are met:<br>&gt=3B + *     * Redi=
stributions of source code must retain the above copyright<br>&gt=3B + *   =
    notice=2C this list of conditions and the following disclaimer.<br>&gt=
=3B + *     * Redistributions in binary form must reproduce the above copyr=
ight<br>&gt=3B + *       notice=2C this list of conditions and the followin=
g disclaimer in the<br>&gt=3B + *       documentation and/or other material=
s provided with the distribution.<br>&gt=3B + *     * Neither the name of F=
reescale Semiconductor nor the<br>&gt=3B + *       names of its contributor=
s may be used to endorse or promote products<br>&gt=3B + *       derived fr=
om this software without specific prior written permission.<br>&gt=3B + *<b=
r>&gt=3B + *<br>&gt=3B + * ALTERNATIVELY=2C this software may be distribute=
d under the terms of the<br>&gt=3B + * GNU General Public License ("GPL") a=
s published by the Free Software<br>&gt=3B + * Foundation=2C either version=
 2 of that License or (at your option) any<br>&gt=3B + * later version.<br>=
&gt=3B + *<br>&gt=3B + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconduct=
or ``AS IS'' AND ANY<br>&gt=3B + * EXPRESS OR IMPLIED WARRANTIES=2C INCLUDI=
NG=2C BUT NOT LIMITED TO=2C THE IMPLIED<br>&gt=3B + * WARRANTIES OF MERCHAN=
TABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE<br>&gt=3B + * DISCLAIMED.=
 IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY<br>&gt=3B + * =
DIRECT=2C INDIRECT=2C INCIDENTAL=2C SPECIAL=2C EXEMPLARY=2C OR CONSEQUENTIA=
L DAMAGES<br>&gt=3B + * (INCLUDING=2C BUT NOT LIMITED TO=2C PROCUREMENT OF =
SUBSTITUTE GOODS OR SERVICES=3B<br>&gt=3B + * LOSS OF USE=2C DATA=2C OR PRO=
FITS=3B OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND<br>&gt=3B + * ON ANY T=
HEORY OF LIABILITY=2C WHETHER IN CONTRACT=2C STRICT LIABILITY=2C OR TORT<br=
>&gt=3B + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF T=
HE USE OF THIS<br>&gt=3B + * SOFTWARE=2C EVEN IF ADVISED OF THE POSSIBILITY=
 OF SUCH DAMAGE.<br>&gt=3B + */<br>&gt=3B +<br>&gt=3B +&amp=3Blbc {<br>&gt=
=3B +	compatible =3D "fsl=2Cp4080-elbc"=2C "fsl=2Celbc"=2C "simple-bus"=3B<=
br>&gt=3B +	interrupts =3D &lt=3B25 2 0 0&gt=3B=3B<br>&gt=3B +	#address-cel=
ls =3D &lt=3B2&gt=3B=3B<br>&gt=3B +	#size-cells =3D &lt=3B1&gt=3B=3B<br>&gt=
=3B +}=3B<br>&gt=3B +<br>&gt=3B +/* controller at 0x200000 */<br>&gt=3B +&a=
mp=3Bpci0 {<br>&gt=3B +	compatible =3D "fsl=2Cp4080-pcie"=3B<br>&gt=3B +	de=
vice_type =3D "pci"=3B<br>&gt=3B +	#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=
=3B +	#address-cells =3D &lt=3B3&gt=3B=3B<br>&gt=3B +	bus-range =3D &lt=3B0=
x0 0xff&gt=3B=3B<br>&gt=3B +	clock-frequency =3D &lt=3B33333333&gt=3B=3B<br=
>&gt=3B +	interrupts =3D &lt=3B16 2 1 15&gt=3B=3B<br>&gt=3B +	pcie@0 {<br>&=
gt=3B +		reg =3D &lt=3B0 0 0 0 0&gt=3B=3B<br>&gt=3B +		#interrupt-cells =3D=
 &lt=3B1&gt=3B=3B<br>&gt=3B +		#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B +=
		#address-cells =3D &lt=3B3&gt=3B=3B<br>&gt=3B +		device_type =3D "pci"=3B=
<br>&gt=3B +		interrupts =3D &lt=3B16 2 1 15&gt=3B=3B<br>&gt=3B +		interrup=
t-map-mask =3D &lt=3B0xf800 0 0 7&gt=3B=3B<br>&gt=3B +		interrupt-map =3D &=
lt=3B<br>&gt=3B +			/* IDSEL 0x0 */<br>&gt=3B +			0000 0 0 1 &amp=3Bmpic 40=
 1 0 0<br>&gt=3B +			0000 0 0 2 &amp=3Bmpic 1 1 0 0<br>&gt=3B +			0000 0 0 =
3 &amp=3Bmpic 2 1 0 0<br>&gt=3B +			0000 0 0 4 &amp=3Bmpic 3 1 0 0<br>&gt=
=3B +			&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +}=3B<br>&gt=3B +<br>&gt=3B +/=
* controller at 0x201000 */<br>&gt=3B +&amp=3Bpci1 {<br>&gt=3B +	compatible=
 =3D "fsl=2Cp4080-pcie"=3B<br>&gt=3B +	device_type =3D "pci"=3B<br>&gt=3B +=
	#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B +	#address-cells =3D &lt=3B3&gt=
=3B=3B<br>&gt=3B +	bus-range =3D &lt=3B0 0xff&gt=3B=3B<br>&gt=3B +	clock-fr=
equency =3D &lt=3B33333333&gt=3B=3B<br>&gt=3B +	interrupts =3D &lt=3B16 2 1=
 14&gt=3B=3B<br>&gt=3B +	pcie@0 {<br>&gt=3B +		reg =3D &lt=3B0 0 0 0 0&gt=
=3B=3B<br>&gt=3B +		#interrupt-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B +		#siz=
e-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B +		#address-cells =3D &lt=3B3&gt=3B=
=3B<br>&gt=3B +		device_type =3D "pci"=3B<br>&gt=3B +		interrupts =3D &lt=
=3B16 2 1 14&gt=3B=3B<br>&gt=3B +		interrupt-map-mask =3D &lt=3B0xf800 0 0 =
7&gt=3B=3B<br>&gt=3B +		interrupt-map =3D &lt=3B<br>&gt=3B +			/* IDSEL 0x0=
 */<br>&gt=3B +			0000 0 0 1 &amp=3Bmpic 41 1 0 0<br>&gt=3B +			0000 0 0 2 =
&amp=3Bmpic 5 1 0 0<br>&gt=3B +			0000 0 0 3 &amp=3Bmpic 6 1 0 0<br>&gt=3B =
+			0000 0 0 4 &amp=3Bmpic 7 1 0 0<br>&gt=3B +			&gt=3B=3B<br>&gt=3B +	}=3B=
<br>&gt=3B +}=3B<br>&gt=3B +<br>&gt=3B +/* controller at 0x202000 */<br>&gt=
=3B +&amp=3Bpci2 {<br>&gt=3B +	compatible =3D "fsl=2Cp4080-pcie"=3B<br>&gt=
=3B +	device_type =3D "pci"=3B<br>&gt=3B +	#size-cells =3D &lt=3B2&gt=3B=3B=
<br>&gt=3B +	#address-cells =3D &lt=3B3&gt=3B=3B<br>&gt=3B +	bus-range =3D =
&lt=3B0x0 0xff&gt=3B=3B<br>&gt=3B +	clock-frequency =3D &lt=3B33333333&gt=
=3B=3B<br>&gt=3B +	interrupts =3D &lt=3B16 2 1 13&gt=3B=3B<br>&gt=3B +	pcie=
@0 {<br>&gt=3B +		reg =3D &lt=3B0 0 0 0 0&gt=3B=3B<br>&gt=3B +		#interrupt-=
cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B +		#size-cells =3D &lt=3B2&gt=3B=3B<br=
>&gt=3B +		#address-cells =3D &lt=3B3&gt=3B=3B<br>&gt=3B +		device_type =3D=
 "pci"=3B<br>&gt=3B +		interrupts =3D &lt=3B16 2 1 13&gt=3B=3B<br>&gt=3B +	=
	interrupt-map-mask =3D &lt=3B0xf800 0 0 7&gt=3B=3B<br>&gt=3B +		interrupt-=
map =3D &lt=3B<br>&gt=3B +			/* IDSEL 0x0 */<br>&gt=3B +			0000 0 0 1 &amp=
=3Bmpic 42 1 0 0<br>&gt=3B +			0000 0 0 2 &amp=3Bmpic 9 1 0 0<br>&gt=3B +		=
	0000 0 0 3 &amp=3Bmpic 10 1 0 0<br>&gt=3B +			0000 0 0 4 &amp=3Bmpic 11 1 =
0 0<br>&gt=3B +			&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +}=3B<br>&gt=3B +<br=
>&gt=3B +&amp=3Brio {<br>&gt=3B +	#address-cells =3D &lt=3B2&gt=3B=3B<br>&g=
t=3B +	#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B +	compatible =3D "fsl=2Cr=
apidio-delta"=3B<br>&gt=3B +	interrupts =3D &lt=3B<br>&gt=3B +		16 2 1 11 /=
* err_irq */<br>&gt=3B +		56 2 0 0  /* bell_outb_irq */<br>&gt=3B +		57 2 0=
 0  /* bell_inb_irq */<br>&gt=3B +		60 2 0 0  /* msg1_tx_irq */<br>&gt=3B +=
		61 2 0 0  /* msg1_rx_irq */<br>&gt=3B +		62 2 0 0  /* msg2_tx_irq */<br>&=
gt=3B +		63 2 0 0&gt=3B=3B /* msg2_rx_irq */<br>&gt=3B +}=3B<br>&gt=3B +<br=
>&gt=3B +&amp=3Bdcsr {<br>&gt=3B +	#address-cells =3D &lt=3B1&gt=3B=3B<br>&=
gt=3B +	#size-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B +	compatible =3D "fsl=2C=
dcsr"=2C "simple-bus"=3B<br>&gt=3B +<br>&gt=3B +	dcsr-epu@0 {<br>&gt=3B +		=
compatible =3D "fsl=2Cdcsr-epu"=3B<br>&gt=3B +		interrupts =3D &lt=3B52 2 0=
 0<br>&gt=3B +			      84 2 0 0<br>&gt=3B +			      85 2 0 0&gt=3B=3B<br>&g=
t=3B +		reg =3D &lt=3B0x0 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +	dcsr=
-npc {<br>&gt=3B +		compatible =3D "fsl=2Cdcsr-npc"=3B<br>&gt=3B +		reg =3D=
 &lt=3B0x1000 0x1000 0x1000000 0x8000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +=
	dcsr-nxc@2000 {<br>&gt=3B +		compatible =3D "fsl=2Cdcsr-nxc"=3B<br>&gt=3B =
+		reg =3D &lt=3B0x2000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-c=
orenet {<br>&gt=3B +		compatible =3D "fsl=2Cdcsr-corenet"=3B<br>&gt=3B +		r=
eg =3D &lt=3B0x8000 0x1000 0xB0000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=
=3B +	dcsr-dpaa@9000 {<br>&gt=3B +		compatible =3D "fsl=2Cp4080-dcsr-dpaa"=
=2C "fsl=2Cdcsr-dpaa"=3B<br>&gt=3B +		reg =3D &lt=3B0x9000 0x1000&gt=3B=3B<=
br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-ocn@11000 {<br>&gt=3B +		compatible =3D "=
fsl=2Cp4080-dcsr-ocn"=2C "fsl=2Cdcsr-ocn"=3B<br>&gt=3B +		reg =3D &lt=3B0x1=
1000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-ddr@12000 {<br>&gt=
=3B +		compatible =3D "fsl=2Cdcsr-ddr"=3B<br>&gt=3B +		dev-handle =3D &lt=
=3B&amp=3Bddr1&gt=3B=3B<br>&gt=3B +		reg =3D &lt=3B0x12000 0x1000&gt=3B=3B<=
br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-ddr@13000 {<br>&gt=3B +		compatible =3D "=
fsl=2Cdcsr-ddr"=3B<br>&gt=3B +		dev-handle =3D &lt=3B&amp=3Bddr2&gt=3B=3B<b=
r>&gt=3B +		reg =3D &lt=3B0x13000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=
=3B +	dcsr-nal@18000 {<br>&gt=3B +		compatible =3D "fsl=2Cp4080-dcsr-nal"=
=2C "fsl=2Cdcsr-nal"=3B<br>&gt=3B +		reg =3D &lt=3B0x18000 0x1000&gt=3B=3B<=
br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-rcpm@22000 {<br>&gt=3B +		compatible =3D =
"fsl=2Cp4080-dcsr-rcpm"=2C "fsl=2Cdcsr-rcpm"=3B<br>&gt=3B +		reg =3D &lt=3B=
0x22000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-cpu-sb-proxy@4000=
0 {<br>&gt=3B +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr=
-cpu-sb-proxy"=3B<br>&gt=3B +		cpu-handle =3D &lt=3B&amp=3Bcpu0&gt=3B=3B<br=
>&gt=3B +		reg =3D &lt=3B0x40000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B=
 +	dcsr-cpu-sb-proxy@41000 {<br>&gt=3B +		compatible =3D "fsl=2Cdcsr-e500mc=
-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B +		cpu-handle =3D &lt=
=3B&amp=3Bcpu1&gt=3B=3B<br>&gt=3B +		reg =3D &lt=3B0x41000 0x1000&gt=3B=3B<=
br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-cpu-sb-proxy@42000 {<br>&gt=3B +		compati=
ble =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=
=3B +		cpu-handle =3D &lt=3B&amp=3Bcpu2&gt=3B=3B<br>&gt=3B +		reg =3D &lt=
=3B0x42000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-cpu-sb-proxy@4=
3000 {<br>&gt=3B +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cd=
csr-cpu-sb-proxy"=3B<br>&gt=3B +		cpu-handle =3D &lt=3B&amp=3Bcpu3&gt=3B=3B=
<br>&gt=3B +		reg =3D &lt=3B0x43000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=
=3B +	dcsr-cpu-sb-proxy@44000 {<br>&gt=3B +		compatible =3D "fsl=2Cdcsr-e50=
0mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B +		cpu-handle =3D &=
lt=3B&amp=3Bcpu4&gt=3B=3B<br>&gt=3B +		reg =3D &lt=3B0x44000 0x1000&gt=3B=
=3B<br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-cpu-sb-proxy@45000 {<br>&gt=3B +		com=
patible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br=
>&gt=3B +		cpu-handle =3D &lt=3B&amp=3Bcpu5&gt=3B=3B<br>&gt=3B +		reg =3D &=
lt=3B0x45000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +	dcsr-cpu-sb-proxy=
@46000 {<br>&gt=3B +		compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=
=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B +		cpu-handle =3D &lt=3B&amp=3Bcpu6&gt=
=3B=3B<br>&gt=3B +		reg =3D &lt=3B0x46000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<=
br>&gt=3B +	dcsr-cpu-sb-proxy@47000 {<br>&gt=3B +		compatible =3D "fsl=2Cdc=
sr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B +		cpu-handle=
 =3D &lt=3B&amp=3Bcpu7&gt=3B=3B<br>&gt=3B +		reg =3D &lt=3B0x47000 0x1000&g=
t=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +}=3B<br>&gt=3B +<br>&gt=3B =
+&amp=3Bsoc {<br>&gt=3B +	#address-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B +	#=
size-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B +	device_type =3D "soc"=3B<br>&gt=
=3B +	compatible =3D "simple-bus"=3B<br>&gt=3B +<br>&gt=3B +	soc-sram-error=
 {<br>&gt=3B +		compatible =3D "fsl=2Csoc-sram-error"=3B<br>&gt=3B +		inter=
rupts =3D &lt=3B16 2 1 29&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +=
	corenet-law@0 {<br>&gt=3B +		compatible =3D "fsl=2Ccorenet-law"=3B<br>&gt=
=3B +		reg =3D &lt=3B0x0 0x1000&gt=3B=3B<br>&gt=3B +		fsl=2Cnum-laws =3D &l=
t=3B32&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +	ddr1: memory-contr=
oller@8000 {<br>&gt=3B +		compatible =3D "fsl=2Cqoriq-memory-controller-v4.=
4"=2C "fsl=2Cqoriq-memory-controller"=3B<br>&gt=3B +		reg =3D &lt=3B0x8000 =
0x1000&gt=3B=3B<br>&gt=3B +		interrupts =3D &lt=3B16 2 1 23&gt=3B=3B<br>&gt=
=3B +	}=3B<br>&gt=3B +<br>&gt=3B +	ddr2: memory-controller@9000 {<br>&gt=3B=
 +		compatible =3D "fsl=2Cqoriq-memory-controller-v4.4"=2C"fsl=2Cqoriq-memo=
ry-controller"=3B<br>&gt=3B +		reg =3D &lt=3B0x9000 0x1000&gt=3B=3B<br>&gt=
=3B +		interrupts =3D &lt=3B16 2 1 22&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +=
<br>&gt=3B +	cpc: l3-cache-controller@10000 {<br>&gt=3B +		compatible =3D "=
fsl=2Cp4080-l3-cache-controller"=2C "cache"=3B<br>&gt=3B +		reg =3D &lt=3B0=
x10000 0x1000<br>&gt=3B +		       0x11000 0x1000&gt=3B=3B<br>&gt=3B +		inte=
rrupts =3D &lt=3B16 2 1 27<br>&gt=3B +			      16 2 1 26&gt=3B=3B<br>&gt=3B=
 +	}=3B<br>&gt=3B +<br>&gt=3B +	corenet-cf@18000 {<br>&gt=3B +		compatible =
=3D "fsl=2Ccorenet-cf"=3B<br>&gt=3B +		reg =3D &lt=3B0x18000 0x1000&gt=3B=
=3B<br>&gt=3B +		interrupts =3D &lt=3B16 2 1 31&gt=3B=3B<br>&gt=3B +		fsl=
=2Cccf-num-csdids =3D &lt=3B32&gt=3B=3B<br>&gt=3B +		fsl=2Cccf-num-snoopids=
 =3D &lt=3B32&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +	iommu@20000=
 {<br>&gt=3B +		compatible =3D "fsl=2Cpamu-v1.0"=2C "fsl=2Cpamu"=3B<br>&gt=
=3B +		reg =3D &lt=3B0x20000 0x5000&gt=3B=3B<br>&gt=3B +		interrupts =3D &l=
t=3B<br>&gt=3B +			24 2 0 0<br>&gt=3B +			16 2 1 30&gt=3B=3B<br>&gt=3B +	}=
=3B<br>&gt=3B +<br>&gt=3B +/include/ "qoriq-mpic.dtsi"<br>&gt=3B +<br>&gt=
=3B +	guts: global-utilities@e0000 {<br>&gt=3B +		compatible =3D "fsl=2Cqor=
iq-device-config-1.0"=3B<br>&gt=3B +		reg =3D &lt=3B0xe0000 0xe00&gt=3B=3B<=
br>&gt=3B +		fsl=2Chas-rstcr=3B<br>&gt=3B +		#sleep-cells =3D &lt=3B1&gt=3B=
=3B<br>&gt=3B +		fsl=2Cliodn-bits =3D &lt=3B12&gt=3B=3B<br>&gt=3B +	}=3B<br=
>&gt=3B +<br>&gt=3B +	pins: global-utilities@e0e00 {<br>&gt=3B +		compatibl=
e =3D "fsl=2Cqoriq-pin-control-1.0"=3B<br>&gt=3B +		reg =3D &lt=3B0xe0e00 0=
x200&gt=3B=3B<br>&gt=3B +		#sleep-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B +	}=
=3B<br>&gt=3B +<br>&gt=3B +	clockgen: global-utilities@e1000 {<br>&gt=3B +	=
	compatible =3D "fsl=2Cp4080-clockgen"=2C "fsl=2Cqoriq-clockgen-1.0"=3B<br>=
&gt=3B +		reg =3D &lt=3B0xe1000 0x1000&gt=3B=3B<br>&gt=3B +		clock-frequenc=
y =3D &lt=3B0&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +	rcpm: globa=
l-utilities@e2000 {<br>&gt=3B +		compatible =3D "fsl=2Cqoriq-rcpm-1.0"=3B<b=
r>&gt=3B +		reg =3D &lt=3B0xe2000 0x1000&gt=3B=3B<br>&gt=3B +		#sleep-cells=
 =3D &lt=3B1&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +	sfp: sfp@e80=
00 {<br>&gt=3B +		compatible =3D "fsl=2Cp4080-sfp"=2C "fsl=2Cqoriq-sfp-1.0"=
=3B<br>&gt=3B +		reg	   =3D &lt=3B0xe8000 0x1000&gt=3B=3B<br>&gt=3B +	}=3B<=
br>&gt=3B +<br>&gt=3B +	serdes: serdes@ea000 {<br>&gt=3B +		compatible =3D =
"fsl=2Cp4080-serdes"=3B<br>&gt=3B +		reg	   =3D &lt=3B0xea000 0x1000&gt=3B=
=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +/include/ "qoriq-dma-0.dtsi"<br=
>&gt=3B +/include/ "qoriq-dma-1.dtsi"<br>&gt=3B +/include/ "qoriq-espi-0.dt=
si"<br>&gt=3B +	spi@110000 {<br>&gt=3B +		fsl=2Cespi-num-chipselects =3D &l=
t=3B4&gt=3B=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +/include/ "qoriq-esd=
hc-0.dtsi"<br>&gt=3B +	sdhc@114000 {<br>&gt=3B +		voltage-ranges =3D &lt=3B=
3300 3300&gt=3B=3B<br>&gt=3B +		sdhci=2Cauto-cmd12=3B<br>&gt=3B +	}=3B<br>&=
gt=3B +<br>&gt=3B +/include/ "qoriq-i2c-0.dtsi"<br>&gt=3B +/include/ "qoriq=
-i2c-1.dtsi"<br>&gt=3B +/include/ "qoriq-duart-0.dtsi"<br>&gt=3B +/include/=
 "qoriq-duart-1.dtsi"<br>&gt=3B +/include/ "qoriq-gpio-0.dtsi"<br>&gt=3B +/=
include/ "qoriq-usb2-mph-0.dtsi"<br>&gt=3B +/include/ "qoriq-usb2-dr-0.dtsi=
"<br>&gt=3B +/include/ "qoriq-sec4.0-0.dtsi"<br>&gt=3B +}=3B<br>&gt=3B diff=
 --git a/arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi b/arch/powerpc/boot/dts=
/fsl/p4080si-pre.dtsi<br>&gt=3B new file mode 100644<br>&gt=3B index 000000=
0..b353ac9<br>&gt=3B --- /dev/null<br>&gt=3B +++ b/arch/powerpc/boot/dts/fs=
l/p4080si-pre.dtsi<br>&gt=3B @@ -0=2C0 +1=2C145 @@<br>&gt=3B +/*<br>&gt=3B =
+ * P4080/P4040 Silicon/SoC Device Tree Source (pre include)<br>&gt=3B + *<=
br>&gt=3B + * Copyright 2011 Freescale Semiconductor Inc.<br>&gt=3B + *<br>=
&gt=3B + * Redistribution and use in source and binary forms=2C with or wit=
hout<br>&gt=3B + * modification=2C are permitted provided that the followin=
g conditions are met:<br>&gt=3B + *     * Redistributions of source code mu=
st retain the above copyright<br>&gt=3B + *       notice=2C this list of co=
nditions and the following disclaimer.<br>&gt=3B + *     * Redistributions =
in binary form must reproduce the above copyright<br>&gt=3B + *       notic=
e=2C this list of conditions and the following disclaimer in the<br>&gt=3B =
+ *       documentation and/or other materials provided with the distributi=
on.<br>&gt=3B + *     * Neither the name of Freescale Semiconductor nor the=
<br>&gt=3B + *       names of its contributors may be used to endorse or pr=
omote products<br>&gt=3B + *       derived from this software without speci=
fic prior written permission.<br>&gt=3B + *<br>&gt=3B + *<br>&gt=3B + * ALT=
ERNATIVELY=2C this software may be distributed under the terms of the<br>&g=
t=3B + * GNU General Public License ("GPL") as published by the Free Softwa=
re<br>&gt=3B + * Foundation=2C either version 2 of that License or (at your=
 option) any<br>&gt=3B + * later version.<br>&gt=3B + *<br>&gt=3B + * THIS =
SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY<br>&gt=3B=
 + * EXPRESS OR IMPLIED WARRANTIES=2C INCLUDING=2C BUT NOT LIMITED TO=2C TH=
E IMPLIED<br>&gt=3B + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PAR=
TICULAR PURPOSE ARE<br>&gt=3B + * DISCLAIMED. IN NO EVENT SHALL Freescale S=
emiconductor BE LIABLE FOR ANY<br>&gt=3B + * DIRECT=2C INDIRECT=2C INCIDENT=
AL=2C SPECIAL=2C EXEMPLARY=2C OR CONSEQUENTIAL DAMAGES<br>&gt=3B + * (INCLU=
DING=2C BUT NOT LIMITED TO=2C PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES=
=3B<br>&gt=3B + * LOSS OF USE=2C DATA=2C OR PROFITS=3B OR BUSINESS INTERRUP=
TION) HOWEVER CAUSED AND<br>&gt=3B + * ON ANY THEORY OF LIABILITY=2C WHETHE=
R IN CONTRACT=2C STRICT LIABILITY=2C OR TORT<br>&gt=3B + * (INCLUDING NEGLI=
GENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS<br>&gt=3B + *=
 SOFTWARE=2C EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.<br>&gt=3B +=
 */<br>&gt=3B +<br>&gt=3B +/dts-v1/=3B<br>&gt=3B +/ {<br>&gt=3B +	compatibl=
e =3D "fsl=2CP4080"=3B<br>&gt=3B +	#address-cells =3D &lt=3B2&gt=3B=3B<br>&=
gt=3B +	#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B +	interrupt-parent =3D &=
lt=3B&amp=3Bmpic&gt=3B=3B<br>&gt=3B +<br>&gt=3B +	aliases {<br>&gt=3B +		cc=
sr =3D &amp=3Bsoc=3B<br>&gt=3B +		dcsr =3D &amp=3Bdcsr=3B<br>&gt=3B +<br>&g=
t=3B +		serial0 =3D &amp=3Bserial0=3B<br>&gt=3B +		serial1 =3D &amp=3Bseria=
l1=3B<br>&gt=3B +		serial2 =3D &amp=3Bserial2=3B<br>&gt=3B +		serial3 =3D &=
amp=3Bserial3=3B<br>&gt=3B +		pci0 =3D &amp=3Bpci0=3B<br>&gt=3B +		pci1 =3D=
 &amp=3Bpci1=3B<br>&gt=3B +		pci2 =3D &amp=3Bpci2=3B<br>&gt=3B +		usb0 =3D =
&amp=3Busb0=3B<br>&gt=3B +		usb1 =3D &amp=3Busb1=3B<br>&gt=3B +		dma0 =3D &=
amp=3Bdma0=3B<br>&gt=3B +		dma1 =3D &amp=3Bdma1=3B<br>&gt=3B +		sdhc =3D &a=
mp=3Bsdhc=3B<br>&gt=3B +		msi0 =3D &amp=3Bmsi0=3B<br>&gt=3B +		msi1 =3D &am=
p=3Bmsi1=3B<br>&gt=3B +		msi2 =3D &amp=3Bmsi2=3B<br>&gt=3B +<br>&gt=3B +		c=
rypto =3D &amp=3Bcrypto=3B<br>&gt=3B +		sec_jr0 =3D &amp=3Bsec_jr0=3B<br>&g=
t=3B +		sec_jr1 =3D &amp=3Bsec_jr1=3B<br>&gt=3B +		sec_jr2 =3D &amp=3Bsec_j=
r2=3B<br>&gt=3B +		sec_jr3 =3D &amp=3Bsec_jr3=3B<br>&gt=3B +		rtic_a =3D &a=
mp=3Brtic_a=3B<br>&gt=3B +		rtic_b =3D &amp=3Brtic_b=3B<br>&gt=3B +		rtic_c=
 =3D &amp=3Brtic_c=3B<br>&gt=3B +		rtic_d =3D &amp=3Brtic_d=3B<br>&gt=3B +	=
	sec_mon =3D &amp=3Bsec_mon=3B<br>&gt=3B +<br>&gt=3B +		rio0 =3D &amp=3Brap=
idio0=3B<br>&gt=3B +	}=3B<br>&gt=3B +<br>&gt=3B +	cpus {<br>&gt=3B +		#addr=
ess-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B +		#size-cells =3D &lt=3B0&gt=3B=
=3B<br>&gt=3B +<br>&gt=3B +		cpu0: PowerPC=2Ce500mc@0 {<br>&gt=3B +			devic=
e_type =3D "cpu"=3B<br>&gt=3B +			reg =3D &lt=3B0&gt=3B=3B<br>&gt=3B +			ne=
xt-level-cache =3D &lt=3B&amp=3BL2_0&gt=3B=3B<br>&gt=3B +			L2_0: l2-cache =
{<br>&gt=3B +				next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B +=
			}=3B<br>&gt=3B +		}=3B<br>&gt=3B +		cpu1: PowerPC=2Ce500mc@1 {<br>&gt=3B=
 +			device_type =3D "cpu"=3B<br>&gt=3B +			reg =3D &lt=3B1&gt=3B=3B<br>&gt=
=3B +			next-level-cache =3D &lt=3B&amp=3BL2_1&gt=3B=3B<br>&gt=3B +			L2_1:=
 l2-cache {<br>&gt=3B +				next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<b=
r>&gt=3B +			}=3B<br>&gt=3B +		}=3B<br>&gt=3B +		cpu2: PowerPC=2Ce500mc@2 {=
<br>&gt=3B +			device_type =3D "cpu"=3B<br>&gt=3B +			reg =3D &lt=3B2&gt=3B=
=3B<br>&gt=3B +			next-level-cache =3D &lt=3B&amp=3BL2_2&gt=3B=3B<br>&gt=3B=
 +			L2_2: l2-cache {<br>&gt=3B +				next-level-cache =3D &lt=3B&amp=3Bcpc&=
gt=3B=3B<br>&gt=3B +			}=3B<br>&gt=3B +		}=3B<br>&gt=3B +		cpu3: PowerPC=2C=
e500mc@3 {<br>&gt=3B +			device_type =3D "cpu"=3B<br>&gt=3B +			reg =3D &lt=
=3B3&gt=3B=3B<br>&gt=3B +			next-level-cache =3D &lt=3B&amp=3BL2_3&gt=3B=3B=
<br>&gt=3B +			L2_3: l2-cache {<br>&gt=3B +				next-level-cache =3D &lt=3B&=
amp=3Bcpc&gt=3B=3B<br>&gt=3B +			}=3B<br>&gt=3B +		}=3B<br>&gt=3B +		cpu4: =
PowerPC=2Ce500mc@4 {<br>&gt=3B +			device_type =3D "cpu"=3B<br>&gt=3B +			r=
eg =3D &lt=3B4&gt=3B=3B<br>&gt=3B +			next-level-cache =3D &lt=3B&amp=3BL2_=
4&gt=3B=3B<br>&gt=3B +			L2_4: l2-cache {<br>&gt=3B +				next-level-cache =
=3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B +			}=3B<br>&gt=3B +		}=3B<br>&gt=
=3B +		cpu5: PowerPC=2Ce500mc@5 {<br>&gt=3B +			device_type =3D "cpu"=3B<br=
>&gt=3B +			reg =3D &lt=3B5&gt=3B=3B<br>&gt=3B +			next-level-cache =3D &lt=
=3B&amp=3BL2_5&gt=3B=3B<br>&gt=3B +			L2_5: l2-cache {<br>&gt=3B +				next-=
level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B +			}=3B<br>&gt=3B +		}=
=3B<br>&gt=3B +		cpu6: PowerPC=2Ce500mc@6 {<br>&gt=3B +			device_type =3D "=
cpu"=3B<br>&gt=3B +			reg =3D &lt=3B6&gt=3B=3B<br>&gt=3B +			next-level-cac=
he =3D &lt=3B&amp=3BL2_6&gt=3B=3B<br>&gt=3B +			L2_6: l2-cache {<br>&gt=3B =
+				next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B +			}=3B<br>&=
gt=3B +		}=3B<br>&gt=3B +		cpu7: PowerPC=2Ce500mc@7 {<br>&gt=3B +			device_=
type =3D "cpu"=3B<br>&gt=3B +			reg =3D &lt=3B7&gt=3B=3B<br>&gt=3B +			next=
-level-cache =3D &lt=3B&amp=3BL2_7&gt=3B=3B<br>&gt=3B +			L2_7: l2-cache {<=
br>&gt=3B +				next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B +		=
	}=3B<br>&gt=3B +		}=3B<br>&gt=3B +	}=3B<br>&gt=3B +}=3B<br>&gt=3B diff --g=
it a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts<=
br>&gt=3B index c7916dc..8ea1ae9 100644<br>&gt=3B --- a/arch/powerpc/boot/d=
ts/p4080ds.dts<br>&gt=3B +++ b/arch/powerpc/boot/dts/p4080ds.dts<br>&gt=3B =
@@ -32=2C7 +32=2C7 @@<br>&gt=3B   * SOFTWARE=2C EVEN IF ADVISED OF THE POSS=
IBILITY OF SUCH DAMAGE.<br>&gt=3B   */<br>&gt=3B  <br>&gt=3B -/include/ "p4=
080si.dtsi"<br>&gt=3B +/include/ "fsl/p4080si-pre.dtsi"<br>&gt=3B  <br>&gt=
=3B  / {<br>&gt=3B  	model =3D "fsl=2CP4080DS"=3B<br>&gt=3B @@ -50=2C6 +50=
=2C9 @@<br>&gt=3B  	}=3B<br>&gt=3B  <br>&gt=3B  	soc: soc@ffe000000 {<br>&g=
t=3B +		ranges =3D &lt=3B0x00000000 0xf 0xfe000000 0x1000000&gt=3B=3B<br>&g=
t=3B +		reg =3D &lt=3B0xf 0xfe000000 0 0x00001000&gt=3B=3B<br>&gt=3B +<br>&=
gt=3B  		spi@110000 {<br>&gt=3B  			flash@0 {<br>&gt=3B  				#address-cells=
 =3D &lt=3B1&gt=3B=3B<br>&gt=3B @@ -105=2C12 +108=2C12 @@<br>&gt=3B  		}=3B=
<br>&gt=3B  	}=3B<br>&gt=3B  <br>&gt=3B -	rapidio0: rapidio@ffe0c0000 {<br>=
&gt=3B +	rio: rapidio0: rapidio@ffe0c0000 {<br>&gt=3B  		reg =3D &lt=3B0xf =
0xfe0c0000 0 0x20000&gt=3B=3B<br>&gt=3B  		ranges =3D &lt=3B0 0 0xc 0x20000=
000 0 0x01000000&gt=3B=3B<br>&gt=3B  	}=3B<br>&gt=3B  <br>&gt=3B -	localbus=
@ffe124000 {<br>&gt=3B +	lbc: localbus@ffe124000 {<br>&gt=3B  		reg =3D &lt=
=3B0xf 0xfe124000 0 0x1000&gt=3B=3B<br>&gt=3B  		ranges =3D &lt=3B0 0 0xf 0=
xe8000000 0x08000000<br>&gt=3B  			  3 0 0xf 0xffdf0000 0x00008000&gt=3B=3B=
<br>&gt=3B @@ -132=2C6 +135=2C7 @@<br>&gt=3B  		reg =3D &lt=3B0xf 0xfe20000=
0 0 0x1000&gt=3B=3B<br>&gt=3B  		ranges =3D &lt=3B0x02000000 0 0xe0000000 0=
xc 0x00000000 0x0 0x20000000<br>&gt=3B  			  0x01000000 0 0x00000000 0xf 0x=
f8000000 0x0 0x00010000&gt=3B=3B<br>&gt=3B +		fsl=2Cmsi =3D &lt=3B&amp=3Bms=
i0&gt=3B=3B<br>&gt=3B  		pcie@0 {<br>&gt=3B  			ranges =3D &lt=3B0x02000000=
 0 0xe0000000<br>&gt=3B  				  0x02000000 0 0xe0000000<br>&gt=3B @@ -147=2C=
6 +151=2C7 @@<br>&gt=3B  		reg =3D &lt=3B0xf 0xfe201000 0 0x1000&gt=3B=3B<b=
r>&gt=3B  		ranges =3D &lt=3B0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0=
x20000000<br>&gt=3B  			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00=
010000&gt=3B=3B<br>&gt=3B +		fsl=2Cmsi =3D &lt=3B&amp=3Bmsi1&gt=3B=3B<br>&g=
t=3B  		pcie@0 {<br>&gt=3B  			ranges =3D &lt=3B0x02000000 0 0xe0000000<br>=
&gt=3B  				  0x02000000 0 0xe0000000<br>&gt=3B @@ -162=2C6 +167=2C7 @@<br>=
&gt=3B  		reg =3D &lt=3B0xf 0xfe202000 0 0x1000&gt=3B=3B<br>&gt=3B  		range=
s =3D &lt=3B0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000<br>&gt=3B  =
			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000&gt=3B=3B<br>&gt=3B=
 +		fsl=2Cmsi =3D &lt=3B&amp=3Bmsi2&gt=3B=3B<br>&gt=3B  		pcie@0 {<br>&gt=
=3B  			ranges =3D &lt=3B0x02000000 0 0xe0000000<br>&gt=3B  				  0x0200000=
0 0 0xe0000000<br>&gt=3B @@ -174=2C3 +180=2C5 @@<br>&gt=3B  	}=3B<br>&gt=3B=
  <br>&gt=3B  }=3B<br>&gt=3B +<br>&gt=3B +/include/ "fsl/p4080si-post.dtsi"=
<br>&gt=3B diff --git a/arch/powerpc/boot/dts/p4080si.dtsi b/arch/powerpc/b=
oot/dts/p4080si.dtsi<br>&gt=3B deleted file mode 100644<br>&gt=3B index f20=
c01a..0000000<br>&gt=3B --- a/arch/powerpc/boot/dts/p4080si.dtsi<br>&gt=3B =
+++ /dev/null<br>&gt=3B @@ -1=2C755 +0=2C0 @@<br>&gt=3B -/*<br>&gt=3B - * P=
4080 Silicon Device Tree Source<br>&gt=3B - *<br>&gt=3B - * Copyright 2009-=
2011 Freescale Semiconductor Inc.<br>&gt=3B - *<br>&gt=3B - * Redistributio=
n and use in source and binary forms=2C with or without<br>&gt=3B - * modif=
ication=2C are permitted provided that the following conditions are met:<br=
>&gt=3B - *     * Redistributions of source code must retain the above copy=
right<br>&gt=3B - *       notice=2C this list of conditions and the followi=
ng disclaimer.<br>&gt=3B - *     * Redistributions in binary form must repr=
oduce the above copyright<br>&gt=3B - *       notice=2C this list of condit=
ions and the following disclaimer in the<br>&gt=3B - *       documentation =
and/or other materials provided with the distribution.<br>&gt=3B - *     * =
Neither the name of Freescale Semiconductor nor the<br>&gt=3B - *       nam=
es of its contributors may be used to endorse or promote products<br>&gt=3B=
 - *       derived from this software without specific prior written permis=
sion.<br>&gt=3B - *<br>&gt=3B - *<br>&gt=3B - * ALTERNATIVELY=2C this softw=
are may be distributed under the terms of the<br>&gt=3B - * GNU General Pub=
lic License ("GPL") as published by the Free Software<br>&gt=3B - * Foundat=
ion=2C either version 2 of that License or (at your option) any<br>&gt=3B -=
 * later version.<br>&gt=3B - *<br>&gt=3B - * THIS SOFTWARE IS PROVIDED BY =
Freescale Semiconductor ``AS IS'' AND ANY<br>&gt=3B - * EXPRESS OR IMPLIED =
WARRANTIES=2C INCLUDING=2C BUT NOT LIMITED TO=2C THE IMPLIED<br>&gt=3B - * =
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE<br>&=
gt=3B - * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE F=
OR ANY<br>&gt=3B - * DIRECT=2C INDIRECT=2C INCIDENTAL=2C SPECIAL=2C EXEMPLA=
RY=2C OR CONSEQUENTIAL DAMAGES<br>&gt=3B - * (INCLUDING=2C BUT NOT LIMITED =
TO=2C PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES=3B<br>&gt=3B - * LOSS OF =
USE=2C DATA=2C OR PROFITS=3B OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND<b=
r>&gt=3B - * ON ANY THEORY OF LIABILITY=2C WHETHER IN CONTRACT=2C STRICT LI=
ABILITY=2C OR TORT<br>&gt=3B - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISIN=
G IN ANY WAY OUT OF THE USE OF THIS<br>&gt=3B - * SOFTWARE=2C EVEN IF ADVIS=
ED OF THE POSSIBILITY OF SUCH DAMAGE.<br>&gt=3B - */<br>&gt=3B -<br>&gt=3B =
-/dts-v1/=3B<br>&gt=3B -<br>&gt=3B -/ {<br>&gt=3B -	compatible =3D "fsl=2CP=
4080"=3B<br>&gt=3B -	#address-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -	#size-=
cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -	interrupt-parent =3D &lt=3B&amp=3Bmp=
ic&gt=3B=3B<br>&gt=3B -<br>&gt=3B -	aliases {<br>&gt=3B -		ccsr =3D &amp=3B=
soc=3B<br>&gt=3B -		dcsr =3D &amp=3Bdcsr=3B<br>&gt=3B -<br>&gt=3B -		serial=
0 =3D &amp=3Bserial0=3B<br>&gt=3B -		serial1 =3D &amp=3Bserial1=3B<br>&gt=
=3B -		serial2 =3D &amp=3Bserial2=3B<br>&gt=3B -		serial3 =3D &amp=3Bserial=
3=3B<br>&gt=3B -		pci0 =3D &amp=3Bpci0=3B<br>&gt=3B -		pci1 =3D &amp=3Bpci1=
=3B<br>&gt=3B -		pci2 =3D &amp=3Bpci2=3B<br>&gt=3B -		usb0 =3D &amp=3Busb0=
=3B<br>&gt=3B -		usb1 =3D &amp=3Busb1=3B<br>&gt=3B -		dma0 =3D &amp=3Bdma0=
=3B<br>&gt=3B -		dma1 =3D &amp=3Bdma1=3B<br>&gt=3B -		sdhc =3D &amp=3Bsdhc=
=3B<br>&gt=3B -		msi0 =3D &amp=3Bmsi0=3B<br>&gt=3B -		msi1 =3D &amp=3Bmsi1=
=3B<br>&gt=3B -		msi2 =3D &amp=3Bmsi2=3B<br>&gt=3B -<br>&gt=3B -		crypto =
=3D &amp=3Bcrypto=3B<br>&gt=3B -		sec_jr0 =3D &amp=3Bsec_jr0=3B<br>&gt=3B -=
		sec_jr1 =3D &amp=3Bsec_jr1=3B<br>&gt=3B -		sec_jr2 =3D &amp=3Bsec_jr2=3B<=
br>&gt=3B -		sec_jr3 =3D &amp=3Bsec_jr3=3B<br>&gt=3B -		rtic_a =3D &amp=3Br=
tic_a=3B<br>&gt=3B -		rtic_b =3D &amp=3Brtic_b=3B<br>&gt=3B -		rtic_c =3D &=
amp=3Brtic_c=3B<br>&gt=3B -		rtic_d =3D &amp=3Brtic_d=3B<br>&gt=3B -		sec_m=
on =3D &amp=3Bsec_mon=3B<br>&gt=3B -<br>&gt=3B -		rio0 =3D &amp=3Brapidio0=
=3B<br>&gt=3B -	}=3B<br>&gt=3B -<br>&gt=3B -	cpus {<br>&gt=3B -		#address-c=
ells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -		#size-cells =3D &lt=3B0&gt=3B=3B<br>=
&gt=3B -<br>&gt=3B -		cpu0: PowerPC=2Ce500mc@0 {<br>&gt=3B -			device_type =
=3D "cpu"=3B<br>&gt=3B -			reg =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			next-leve=
l-cache =3D &lt=3B&amp=3BL2_0&gt=3B=3B<br>&gt=3B -			L2_0: l2-cache {<br>&g=
t=3B -				next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B -			}=3B=
<br>&gt=3B -		}=3B<br>&gt=3B -		cpu1: PowerPC=2Ce500mc@1 {<br>&gt=3B -			de=
vice_type =3D "cpu"=3B<br>&gt=3B -			reg =3D &lt=3B1&gt=3B=3B<br>&gt=3B -		=
	next-level-cache =3D &lt=3B&amp=3BL2_1&gt=3B=3B<br>&gt=3B -			L2_1: l2-cac=
he {<br>&gt=3B -				next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=
=3B -			}=3B<br>&gt=3B -		}=3B<br>&gt=3B -		cpu2: PowerPC=2Ce500mc@2 {<br>&=
gt=3B -			device_type =3D "cpu"=3B<br>&gt=3B -			reg =3D &lt=3B2&gt=3B=3B<b=
r>&gt=3B -			next-level-cache =3D &lt=3B&amp=3BL2_2&gt=3B=3B<br>&gt=3B -			=
L2_2: l2-cache {<br>&gt=3B -				next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=
=3B<br>&gt=3B -			}=3B<br>&gt=3B -		}=3B<br>&gt=3B -		cpu3: PowerPC=2Ce500m=
c@3 {<br>&gt=3B -			device_type =3D "cpu"=3B<br>&gt=3B -			reg =3D &lt=3B3&=
gt=3B=3B<br>&gt=3B -			next-level-cache =3D &lt=3B&amp=3BL2_3&gt=3B=3B<br>&=
gt=3B -			L2_3: l2-cache {<br>&gt=3B -				next-level-cache =3D &lt=3B&amp=
=3Bcpc&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=3B -		}=3B<br>&gt=3B -		cpu4: Pow=
erPC=2Ce500mc@4 {<br>&gt=3B -			device_type =3D "cpu"=3B<br>&gt=3B -			reg =
=3D &lt=3B4&gt=3B=3B<br>&gt=3B -			next-level-cache =3D &lt=3B&amp=3BL2_4&g=
t=3B=3B<br>&gt=3B -			L2_4: l2-cache {<br>&gt=3B -				next-level-cache =3D =
&lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=3B -		}=3B<br>&gt=3B -	=
	cpu5: PowerPC=2Ce500mc@5 {<br>&gt=3B -			device_type =3D "cpu"=3B<br>&gt=
=3B -			reg =3D &lt=3B5&gt=3B=3B<br>&gt=3B -			next-level-cache =3D &lt=3B&=
amp=3BL2_5&gt=3B=3B<br>&gt=3B -			L2_5: l2-cache {<br>&gt=3B -				next-leve=
l-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=3B -		}=3B<=
br>&gt=3B -		cpu6: PowerPC=2Ce500mc@6 {<br>&gt=3B -			device_type =3D "cpu"=
=3B<br>&gt=3B -			reg =3D &lt=3B6&gt=3B=3B<br>&gt=3B -			next-level-cache =
=3D &lt=3B&amp=3BL2_6&gt=3B=3B<br>&gt=3B -			L2_6: l2-cache {<br>&gt=3B -		=
		next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=
=3B -		}=3B<br>&gt=3B -		cpu7: PowerPC=2Ce500mc@7 {<br>&gt=3B -			device_ty=
pe =3D "cpu"=3B<br>&gt=3B -			reg =3D &lt=3B7&gt=3B=3B<br>&gt=3B -			next-l=
evel-cache =3D &lt=3B&amp=3BL2_7&gt=3B=3B<br>&gt=3B -			L2_7: l2-cache {<br=
>&gt=3B -				next-level-cache =3D &lt=3B&amp=3Bcpc&gt=3B=3B<br>&gt=3B -			}=
=3B<br>&gt=3B -		}=3B<br>&gt=3B -	}=3B<br>&gt=3B -<br>&gt=3B -	dcsr: dcsr@f=
00000000 {<br>&gt=3B -		#address-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -		#s=
ize-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -		compatible =3D "fsl=2Cdcsr"=2C =
"simple-bus"=3B<br>&gt=3B -<br>&gt=3B -		dcsr-epu@0 {<br>&gt=3B -			compati=
ble =3D "fsl=2Cdcsr-epu"=3B<br>&gt=3B -			interrupts =3D &lt=3B52 2 0 0<br>=
&gt=3B -				      84 2 0 0<br>&gt=3B -				      85 2 0 0&gt=3B=3B<br>&gt=3B=
 -			interrupt-parent =3D &lt=3B&amp=3Bmpic&gt=3B=3B<br>&gt=3B -			reg =3D =
&lt=3B0x0 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-npc {<br>&gt=
=3B -			compatible =3D "fsl=2Cdcsr-npc"=3B<br>&gt=3B -			reg =3D &lt=3B0x10=
00 0x1000 0x1000000 0x8000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-nxc=
@2000 {<br>&gt=3B -			compatible =3D "fsl=2Cdcsr-nxc"=3B<br>&gt=3B -			reg =
=3D &lt=3B0x2000 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-corene=
t {<br>&gt=3B -			compatible =3D "fsl=2Cdcsr-corenet"=3B<br>&gt=3B -			reg =
=3D &lt=3B0x8000 0x1000 0xB0000 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B=
 -		dcsr-dpaa@9000 {<br>&gt=3B -			compatible =3D "fsl=2Cp4080-dcsr-dpaa"=
=2C "fsl=2Cdcsr-dpaa"=3B<br>&gt=3B -			reg =3D &lt=3B0x9000 0x1000&gt=3B=3B=
<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-ocn@11000 {<br>&gt=3B -			compatible =
=3D "fsl=2Cp4080-dcsr-ocn"=2C "fsl=2Cdcsr-ocn"=3B<br>&gt=3B -			reg =3D &lt=
=3B0x11000 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-ddr@12000 {<=
br>&gt=3B -			compatible =3D "fsl=2Cdcsr-ddr"=3B<br>&gt=3B -			dev-handle =
=3D &lt=3B&amp=3Bddr1&gt=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x12000 0x1000&g=
t=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-ddr@13000 {<br>&gt=3B -			compa=
tible =3D "fsl=2Cdcsr-ddr"=3B<br>&gt=3B -			dev-handle =3D &lt=3B&amp=3Bddr=
2&gt=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x13000 0x1000&gt=3B=3B<br>&gt=3B -	=
	}=3B<br>&gt=3B -		dcsr-nal@18000 {<br>&gt=3B -			compatible =3D "fsl=2Cp40=
80-dcsr-nal"=2C "fsl=2Cdcsr-nal"=3B<br>&gt=3B -			reg =3D &lt=3B0x18000 0x1=
000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-rcpm@22000 {<br>&gt=3B -		=
	compatible =3D "fsl=2Cp4080-dcsr-rcpm"=2C "fsl=2Cdcsr-rcpm"=3B<br>&gt=3B -=
			reg =3D &lt=3B0x22000 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcs=
r-cpu-sb-proxy@40000 {<br>&gt=3B -			compatible =3D "fsl=2Cdcsr-e500mc-sb-p=
roxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B -			cpu-handle =3D &lt=3B&a=
mp=3Bcpu0&gt=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x40000 0x1000&gt=3B=3B<br>&=
gt=3B -		}=3B<br>&gt=3B -		dcsr-cpu-sb-proxy@41000 {<br>&gt=3B -			compatib=
le =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=
=3B -			cpu-handle =3D &lt=3B&amp=3Bcpu1&gt=3B=3B<br>&gt=3B -			reg =3D &lt=
=3B0x41000 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-cpu-sb-proxy=
@42000 {<br>&gt=3B -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=
=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B -			cpu-handle =3D &lt=3B&amp=3Bcpu2&gt=
=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x42000 0x1000&gt=3B=3B<br>&gt=3B -		}=
=3B<br>&gt=3B -		dcsr-cpu-sb-proxy@43000 {<br>&gt=3B -			compatible =3D "fs=
l=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B -			cpu=
-handle =3D &lt=3B&amp=3Bcpu3&gt=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x43000 =
0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-cpu-sb-proxy@44000 {<br=
>&gt=3B -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-=
sb-proxy"=3B<br>&gt=3B -			cpu-handle =3D &lt=3B&amp=3Bcpu4&gt=3B=3B<br>&gt=
=3B -			reg =3D &lt=3B0x44000 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -=
		dcsr-cpu-sb-proxy@45000 {<br>&gt=3B -			compatible =3D "fsl=2Cdcsr-e500mc=
-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B -			cpu-handle =3D &lt=
=3B&amp=3Bcpu5&gt=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x45000 0x1000&gt=3B=3B=
<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-cpu-sb-proxy@46000 {<br>&gt=3B -			com=
patible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "fsl=2Cdcsr-cpu-sb-proxy"=3B<br=
>&gt=3B -			cpu-handle =3D &lt=3B&amp=3Bcpu6&gt=3B=3B<br>&gt=3B -			reg =3D=
 &lt=3B0x46000 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -		dcsr-cpu-sb-p=
roxy@47000 {<br>&gt=3B -			compatible =3D "fsl=2Cdcsr-e500mc-sb-proxy"=2C "=
fsl=2Cdcsr-cpu-sb-proxy"=3B<br>&gt=3B -			cpu-handle =3D &lt=3B&amp=3Bcpu7&=
gt=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x47000 0x1000&gt=3B=3B<br>&gt=3B -		}=
=3B<br>&gt=3B -	}=3B<br>&gt=3B -<br>&gt=3B -	soc: soc@ffe000000 {<br>&gt=3B=
 -		#address-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -		#size-cells =3D &lt=3B=
1&gt=3B=3B<br>&gt=3B -		device_type =3D "soc"=3B<br>&gt=3B -		compatible =
=3D "simple-bus"=3B<br>&gt=3B -		ranges =3D &lt=3B0x00000000 0xf 0xfe000000=
 0x1000000&gt=3B=3B<br>&gt=3B -		reg =3D &lt=3B0xf 0xfe000000 0 0x00001000&=
gt=3B=3B<br>&gt=3B -<br>&gt=3B -		soc-sram-error {<br>&gt=3B -			compatible=
 =3D "fsl=2Csoc-sram-error"=3B<br>&gt=3B -			interrupts =3D &lt=3B16 2 1 29=
&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		corenet-law@0 {<br>&gt=
=3B -			compatible =3D "fsl=2Ccorenet-law"=3B<br>&gt=3B -			reg =3D &lt=3B0=
x0 0x1000&gt=3B=3B<br>&gt=3B -			fsl=2Cnum-laws =3D &lt=3B32&gt=3B=3B<br>&g=
t=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		ddr1: memory-controller@8000 {<br>&gt=
=3B -			compatible =3D "fsl=2Cqoriq-memory-controller-v4.4"=2C "fsl=2Cqoriq=
-memory-controller"=3B<br>&gt=3B -			reg =3D &lt=3B0x8000 0x1000&gt=3B=3B<b=
r>&gt=3B -			interrupts =3D &lt=3B16 2 1 23&gt=3B=3B<br>&gt=3B -		}=3B<br>&=
gt=3B -<br>&gt=3B -		ddr2: memory-controller@9000 {<br>&gt=3B -			compatibl=
e =3D "fsl=2Cqoriq-memory-controller-v4.4"=2C"fsl=2Cqoriq-memory-controller=
"=3B<br>&gt=3B -			reg =3D &lt=3B0x9000 0x1000&gt=3B=3B<br>&gt=3B -			inter=
rupts =3D &lt=3B16 2 1 22&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B =
-		cpc: l3-cache-controller@10000 {<br>&gt=3B -			compatible =3D "fsl=2Cp40=
80-l3-cache-controller"=2C "cache"=3B<br>&gt=3B -			reg =3D &lt=3B0x10000 0=
x1000<br>&gt=3B -			       0x11000 0x1000&gt=3B=3B<br>&gt=3B -			interrupts=
 =3D &lt=3B16 2 1 27<br>&gt=3B -				      16 2 1 26&gt=3B=3B<br>&gt=3B -		}=
=3B<br>&gt=3B -<br>&gt=3B -		corenet-cf@18000 {<br>&gt=3B -			compatible =
=3D "fsl=2Ccorenet-cf"=3B<br>&gt=3B -			reg =3D &lt=3B0x18000 0x1000&gt=3B=
=3B<br>&gt=3B -			interrupts =3D &lt=3B16 2 1 31&gt=3B=3B<br>&gt=3B -			fsl=
=2Cccf-num-csdids =3D &lt=3B32&gt=3B=3B<br>&gt=3B -			fsl=2Cccf-num-snoopid=
s =3D &lt=3B32&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		iommu@20=
000 {<br>&gt=3B -			compatible =3D "fsl=2Cpamu-v1.0"=2C "fsl=2Cpamu"=3B<br>=
&gt=3B -			reg =3D &lt=3B0x20000 0x5000&gt=3B=3B<br>&gt=3B -			interrupts =
=3D &lt=3B<br>&gt=3B -				24 2 0 0<br>&gt=3B -				16 2 1 30&gt=3B=3B<br>&gt=
=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		mpic: pic@40000 {<br>&gt=3B -			clock-=
frequency =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			interrupt-controller=3B<br>&gt=
=3B -			#address-cells =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			#interrupt-cells =
=3D &lt=3B4&gt=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x40000 0x40000&gt=3B=3B<b=
r>&gt=3B -			compatible =3D "fsl=2Cmpic"=2C "chrp=2Copen-pic"=3B<br>&gt=3B =
-			device_type =3D "open-pic"=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -=
		msi0: msi@41600 {<br>&gt=3B -			compatible =3D "fsl=2Cmpic-msi"=3B<br>&gt=
=3B -			reg =3D &lt=3B0x41600 0x200&gt=3B=3B<br>&gt=3B -			msi-available-ra=
nges =3D &lt=3B0 0x100&gt=3B=3B<br>&gt=3B -			interrupts =3D &lt=3B<br>&gt=
=3B -				0xe0 0 0 0<br>&gt=3B -				0xe1 0 0 0<br>&gt=3B -				0xe2 0 0 0<br>=
&gt=3B -				0xe3 0 0 0<br>&gt=3B -				0xe4 0 0 0<br>&gt=3B -				0xe5 0 0 0<=
br>&gt=3B -				0xe6 0 0 0<br>&gt=3B -				0xe7 0 0 0&gt=3B=3B<br>&gt=3B -		}=
=3B<br>&gt=3B -<br>&gt=3B -		msi1: msi@41800 {<br>&gt=3B -			compatible =3D=
 "fsl=2Cmpic-msi"=3B<br>&gt=3B -			reg =3D &lt=3B0x41800 0x200&gt=3B=3B<br>=
&gt=3B -			msi-available-ranges =3D &lt=3B0 0x100&gt=3B=3B<br>&gt=3B -			in=
terrupts =3D &lt=3B<br>&gt=3B -				0xe8 0 0 0<br>&gt=3B -				0xe9 0 0 0<br>=
&gt=3B -				0xea 0 0 0<br>&gt=3B -				0xeb 0 0 0<br>&gt=3B -				0xec 0 0 0<=
br>&gt=3B -				0xed 0 0 0<br>&gt=3B -				0xee 0 0 0<br>&gt=3B -				0xef 0 0=
 0&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		msi2: msi@41a00 {<br=
>&gt=3B -			compatible =3D "fsl=2Cmpic-msi"=3B<br>&gt=3B -			reg =3D &lt=3B=
0x41a00 0x200&gt=3B=3B<br>&gt=3B -			msi-available-ranges =3D &lt=3B0 0x100=
&gt=3B=3B<br>&gt=3B -			interrupts =3D &lt=3B<br>&gt=3B -				0xf0 0 0 0<br>=
&gt=3B -				0xf1 0 0 0<br>&gt=3B -				0xf2 0 0 0<br>&gt=3B -				0xf3 0 0 0<=
br>&gt=3B -				0xf4 0 0 0<br>&gt=3B -				0xf5 0 0 0<br>&gt=3B -				0xf6 0 0=
 0<br>&gt=3B -				0xf7 0 0 0&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=
=3B -		guts: global-utilities@e0000 {<br>&gt=3B -			compatible =3D "fsl=2Cq=
oriq-device-config-1.0"=3B<br>&gt=3B -			reg =3D &lt=3B0xe0000 0xe00&gt=3B=
=3B<br>&gt=3B -			fsl=2Chas-rstcr=3B<br>&gt=3B -			#sleep-cells =3D &lt=3B1=
&gt=3B=3B<br>&gt=3B -			fsl=2Cliodn-bits =3D &lt=3B12&gt=3B=3B<br>&gt=3B -	=
	}=3B<br>&gt=3B -<br>&gt=3B -		pins: global-utilities@e0e00 {<br>&gt=3B -		=
	compatible =3D "fsl=2Cqoriq-pin-control-1.0"=3B<br>&gt=3B -			reg =3D &lt=
=3B0xe0e00 0x200&gt=3B=3B<br>&gt=3B -			#sleep-cells =3D &lt=3B2&gt=3B=3B<b=
r>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		clockgen: global-utilities@e1000 =
{<br>&gt=3B -			compatible =3D "fsl=2Cp4080-clockgen"=2C "fsl=2Cqoriq-clock=
gen-1.0"=3B<br>&gt=3B -			reg =3D &lt=3B0xe1000 0x1000&gt=3B=3B<br>&gt=3B -=
			clock-frequency =3D &lt=3B0&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&g=
t=3B -		rcpm: global-utilities@e2000 {<br>&gt=3B -			compatible =3D "fsl=2C=
qoriq-rcpm-1.0"=3B<br>&gt=3B -			reg =3D &lt=3B0xe2000 0x1000&gt=3B=3B<br>&=
gt=3B -			#sleep-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<b=
r>&gt=3B -		sfp: sfp@e8000 {<br>&gt=3B -			compatible =3D "fsl=2Cp4080-sfp"=
=2C "fsl=2Cqoriq-sfp-1.0"=3B<br>&gt=3B -			reg	   =3D &lt=3B0xe8000 0x1000&=
gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		serdes: serdes@ea000 {<=
br>&gt=3B -			compatible =3D "fsl=2Cp4080-serdes"=3B<br>&gt=3B -			reg	   =
=3D &lt=3B0xea000 0x1000&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -=
		dma0: dma@100300 {<br>&gt=3B -			#address-cells =3D &lt=3B1&gt=3B=3B<br>&=
gt=3B -			#size-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			compatible =3D "fs=
l=2Cp4080-dma"=2C "fsl=2Celoplus-dma"=3B<br>&gt=3B -			reg =3D &lt=3B0x1003=
00 0x4&gt=3B=3B<br>&gt=3B -			ranges =3D &lt=3B0x0 0x100100 0x200&gt=3B=3B<=
br>&gt=3B -			cell-index =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			dma-channel@0 {=
<br>&gt=3B -				compatible =3D "fsl=2Cp4080-dma-channel"=2C<br>&gt=3B -				=
		"fsl=2Celoplus-dma-channel"=3B<br>&gt=3B -				reg =3D &lt=3B0x0 0x80&gt=
=3B=3B<br>&gt=3B -				cell-index =3D &lt=3B0&gt=3B=3B<br>&gt=3B -				interr=
upts =3D &lt=3B28 2 0 0&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=3B -			dma-chann=
el@80 {<br>&gt=3B -				compatible =3D "fsl=2Cp4080-dma-channel"=2C<br>&gt=
=3B -						"fsl=2Celoplus-dma-channel"=3B<br>&gt=3B -				reg =3D &lt=3B0x80=
 0x80&gt=3B=3B<br>&gt=3B -				cell-index =3D &lt=3B1&gt=3B=3B<br>&gt=3B -		=
		interrupts =3D &lt=3B29 2 0 0&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=3B -			d=
ma-channel@100 {<br>&gt=3B -				compatible =3D "fsl=2Cp4080-dma-channel"=2C=
<br>&gt=3B -						"fsl=2Celoplus-dma-channel"=3B<br>&gt=3B -				reg =3D &lt=
=3B0x100 0x80&gt=3B=3B<br>&gt=3B -				cell-index =3D &lt=3B2&gt=3B=3B<br>&g=
t=3B -				interrupts =3D &lt=3B30 2 0 0&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=
=3B -			dma-channel@180 {<br>&gt=3B -				compatible =3D "fsl=2Cp4080-dma-ch=
annel"=2C<br>&gt=3B -						"fsl=2Celoplus-dma-channel"=3B<br>&gt=3B -				re=
g =3D &lt=3B0x180 0x80&gt=3B=3B<br>&gt=3B -				cell-index =3D &lt=3B3&gt=3B=
=3B<br>&gt=3B -				interrupts =3D &lt=3B31 2 0 0&gt=3B=3B<br>&gt=3B -			}=
=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		dma1: dma@101300 {<br>&gt=3B=
 -			#address-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			#size-cells =3D &lt=
=3B1&gt=3B=3B<br>&gt=3B -			compatible =3D "fsl=2Cp4080-dma"=2C "fsl=2Celop=
lus-dma"=3B<br>&gt=3B -			reg =3D &lt=3B0x101300 0x4&gt=3B=3B<br>&gt=3B -		=
	ranges =3D &lt=3B0x0 0x101100 0x200&gt=3B=3B<br>&gt=3B -			cell-index =3D =
&lt=3B1&gt=3B=3B<br>&gt=3B -			dma-channel@0 {<br>&gt=3B -				compatible =
=3D "fsl=2Cp4080-dma-channel"=2C<br>&gt=3B -						"fsl=2Celoplus-dma-channe=
l"=3B<br>&gt=3B -				reg =3D &lt=3B0x0 0x80&gt=3B=3B<br>&gt=3B -				cell-in=
dex =3D &lt=3B0&gt=3B=3B<br>&gt=3B -				interrupts =3D &lt=3B32 2 0 0&gt=3B=
=3B<br>&gt=3B -			}=3B<br>&gt=3B -			dma-channel@80 {<br>&gt=3B -				compat=
ible =3D "fsl=2Cp4080-dma-channel"=2C<br>&gt=3B -						"fsl=2Celoplus-dma-c=
hannel"=3B<br>&gt=3B -				reg =3D &lt=3B0x80 0x80&gt=3B=3B<br>&gt=3B -				c=
ell-index =3D &lt=3B1&gt=3B=3B<br>&gt=3B -				interrupts =3D &lt=3B33 2 0 0=
&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=3B -			dma-channel@100 {<br>&gt=3B -			=
	compatible =3D "fsl=2Cp4080-dma-channel"=2C<br>&gt=3B -						"fsl=2Celoplu=
s-dma-channel"=3B<br>&gt=3B -				reg =3D &lt=3B0x100 0x80&gt=3B=3B<br>&gt=
=3B -				cell-index =3D &lt=3B2&gt=3B=3B<br>&gt=3B -				interrupts =3D &lt=
=3B34 2 0 0&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=3B -			dma-channel@180 {<br>=
&gt=3B -				compatible =3D "fsl=2Cp4080-dma-channel"=2C<br>&gt=3B -						"f=
sl=2Celoplus-dma-channel"=3B<br>&gt=3B -				reg =3D &lt=3B0x180 0x80&gt=3B=
=3B<br>&gt=3B -				cell-index =3D &lt=3B3&gt=3B=3B<br>&gt=3B -				interrupt=
s =3D &lt=3B35 2 0 0&gt=3B=3B<br>&gt=3B -			}=3B<br>&gt=3B -		}=3B<br>&gt=
=3B -<br>&gt=3B -		spi@110000 {<br>&gt=3B -			#address-cells =3D &lt=3B1&gt=
=3B=3B<br>&gt=3B -			#size-cells =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			compati=
ble =3D "fsl=2Cp4080-espi"=2C "fsl=2Cmpc8536-espi"=3B<br>&gt=3B -			reg =3D=
 &lt=3B0x110000 0x1000&gt=3B=3B<br>&gt=3B -			interrupts =3D &lt=3B53 0x2 0=
 0&gt=3B=3B<br>&gt=3B -			fsl=2Cespi-num-chipselects =3D &lt=3B4&gt=3B=3B<b=
r>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		sdhc: sdhc@114000 {<br>&gt=3B -		=
	compatible =3D "fsl=2Cp4080-esdhc"=2C "fsl=2Cesdhc"=3B<br>&gt=3B -			reg =
=3D &lt=3B0x114000 0x1000&gt=3B=3B<br>&gt=3B -			interrupts =3D &lt=3B48 2 =
0 0&gt=3B=3B<br>&gt=3B -			voltage-ranges =3D &lt=3B3300 3300&gt=3B=3B<br>&=
gt=3B -			sdhci=2Cauto-cmd12=3B<br>&gt=3B -			clock-frequency =3D &lt=3B0&g=
t=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		i2c@118000 {<br>&gt=3B -=
			#address-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			#size-cells =3D &lt=3B=
0&gt=3B=3B<br>&gt=3B -			cell-index =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			comp=
atible =3D "fsl-i2c"=3B<br>&gt=3B -			reg =3D &lt=3B0x118000 0x100&gt=3B=3B=
<br>&gt=3B -			interrupts =3D &lt=3B38 2 0 0&gt=3B=3B<br>&gt=3B -			dfsrr=
=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		i2c@118100 {<br>&gt=3B -			#=
address-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			#size-cells =3D &lt=3B0&gt=
=3B=3B<br>&gt=3B -			cell-index =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			compatib=
le =3D "fsl-i2c"=3B<br>&gt=3B -			reg =3D &lt=3B0x118100 0x100&gt=3B=3B<br>=
&gt=3B -			interrupts =3D &lt=3B38 2 0 0&gt=3B=3B<br>&gt=3B -			dfsrr=3B<br=
>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		i2c@119000 {<br>&gt=3B -			#addres=
s-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			#size-cells =3D &lt=3B0&gt=3B=3B=
<br>&gt=3B -			cell-index =3D &lt=3B2&gt=3B=3B<br>&gt=3B -			compatible =3D=
 "fsl-i2c"=3B<br>&gt=3B -			reg =3D &lt=3B0x119000 0x100&gt=3B=3B<br>&gt=3B=
 -			interrupts =3D &lt=3B39 2 0 0&gt=3B=3B<br>&gt=3B -			dfsrr=3B<br>&gt=
=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		i2c@119100 {<br>&gt=3B -			#address-ce=
lls =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			#size-cells =3D &lt=3B0&gt=3B=3B<br>=
&gt=3B -			cell-index =3D &lt=3B3&gt=3B=3B<br>&gt=3B -			compatible =3D "fs=
l-i2c"=3B<br>&gt=3B -			reg =3D &lt=3B0x119100 0x100&gt=3B=3B<br>&gt=3B -		=
	interrupts =3D &lt=3B39 2 0 0&gt=3B=3B<br>&gt=3B -			dfsrr=3B<br>&gt=3B -	=
	}=3B<br>&gt=3B -<br>&gt=3B -		serial0: serial@11c500 {<br>&gt=3B -			cell-=
index =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			device_type =3D "serial"=3B<br>&gt=
=3B -			compatible =3D "ns16550"=3B<br>&gt=3B -			reg =3D &lt=3B0x11c500 0x=
100&gt=3B=3B<br>&gt=3B -			clock-frequency =3D &lt=3B0&gt=3B=3B<br>&gt=3B -=
			interrupts =3D &lt=3B36 2 0 0&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>=
&gt=3B -		serial1: serial@11c600 {<br>&gt=3B -			cell-index =3D &lt=3B1&gt=
=3B=3B<br>&gt=3B -			device_type =3D "serial"=3B<br>&gt=3B -			compatible =
=3D "ns16550"=3B<br>&gt=3B -			reg =3D &lt=3B0x11c600 0x100&gt=3B=3B<br>&gt=
=3B -			clock-frequency =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			interrupts =3D &=
lt=3B36 2 0 0&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		serial2: =
serial@11d500 {<br>&gt=3B -			cell-index =3D &lt=3B2&gt=3B=3B<br>&gt=3B -		=
	device_type =3D "serial"=3B<br>&gt=3B -			compatible =3D "ns16550"=3B<br>&=
gt=3B -			reg =3D &lt=3B0x11d500 0x100&gt=3B=3B<br>&gt=3B -			clock-frequen=
cy =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			interrupts =3D &lt=3B37 2 0 0&gt=3B=
=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		serial3: serial@11d600 {<br>=
&gt=3B -			cell-index =3D &lt=3B3&gt=3B=3B<br>&gt=3B -			device_type =3D "s=
erial"=3B<br>&gt=3B -			compatible =3D "ns16550"=3B<br>&gt=3B -			reg =3D &=
lt=3B0x11d600 0x100&gt=3B=3B<br>&gt=3B -			clock-frequency =3D &lt=3B0&gt=
=3B=3B<br>&gt=3B -			interrupts =3D &lt=3B37 2 0 0&gt=3B=3B<br>&gt=3B -		}=
=3B<br>&gt=3B -<br>&gt=3B -		gpio0: gpio@130000 {<br>&gt=3B -			compatible =
=3D "fsl=2Cp4080-gpio"=2C "fsl=2Cqoriq-gpio"=3B<br>&gt=3B -			reg =3D &lt=
=3B0x130000 0x1000&gt=3B=3B<br>&gt=3B -			interrupts =3D &lt=3B55 2 0 0&gt=
=3B=3B<br>&gt=3B -			#gpio-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -			gpio-co=
ntroller=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		usb0: usb@210000 {<b=
r>&gt=3B -			compatible =3D "fsl=2Cp4080-usb2-mph"=2C<br>&gt=3B -					"fsl=
=2Cmpc85xx-usb2-mph"=2C "fsl-usb2-mph"=3B<br>&gt=3B -			reg =3D &lt=3B0x210=
000 0x1000&gt=3B=3B<br>&gt=3B -			#address-cells =3D &lt=3B1&gt=3B=3B<br>&g=
t=3B -			#size-cells =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			interrupts =3D &lt=
=3B44 0x2 0 0&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		usb1: usb=
@211000 {<br>&gt=3B -			compatible =3D "fsl=2Cp4080-usb2-dr"=2C<br>&gt=3B -=
					"fsl=2Cmpc85xx-usb2-dr"=2C "fsl-usb2-dr"=3B<br>&gt=3B -			reg =3D &lt=
=3B0x211000 0x1000&gt=3B=3B<br>&gt=3B -			#address-cells =3D &lt=3B1&gt=3B=
=3B<br>&gt=3B -			#size-cells =3D &lt=3B0&gt=3B=3B<br>&gt=3B -			interrupts=
 =3D &lt=3B45 0x2 0 0&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		c=
rypto: crypto@300000 {<br>&gt=3B -			compatible =3D "fsl=2Csec-v4.0"=3B<br>=
&gt=3B -			#address-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			#size-cells =
=3D &lt=3B1&gt=3B=3B<br>&gt=3B -			reg =3D &lt=3B0x300000 0x10000&gt=3B=3B<=
br>&gt=3B -			ranges =3D &lt=3B0 0x300000 0x10000&gt=3B=3B<br>&gt=3B -			in=
terrupt-parent =3D &lt=3B&amp=3Bmpic&gt=3B=3B<br>&gt=3B -			interrupts =3D =
&lt=3B92 2 0 0&gt=3B=3B<br>&gt=3B -<br>&gt=3B -			sec_jr0: jr@1000 {<br>&gt=
=3B -				compatible =3D "fsl=2Csec-v4.0-job-ring"=3B<br>&gt=3B -				reg =3D=
 &lt=3B0x1000 0x1000&gt=3B=3B<br>&gt=3B -				interrupt-parent =3D &lt=3B&am=
p=3Bmpic&gt=3B=3B<br>&gt=3B -				interrupts =3D &lt=3B88 2 0 0&gt=3B=3B<br>=
&gt=3B -			}=3B<br>&gt=3B -<br>&gt=3B -			sec_jr1: jr@2000 {<br>&gt=3B -			=
	compatible =3D "fsl=2Csec-v4.0-job-ring"=3B<br>&gt=3B -				reg =3D &lt=3B0=
x2000 0x1000&gt=3B=3B<br>&gt=3B -				interrupt-parent =3D &lt=3B&amp=3Bmpic=
&gt=3B=3B<br>&gt=3B -				interrupts =3D &lt=3B89 2 0 0&gt=3B=3B<br>&gt=3B -=
			}=3B<br>&gt=3B -<br>&gt=3B -			sec_jr2: jr@3000 {<br>&gt=3B -				compati=
ble =3D "fsl=2Csec-v4.0-job-ring"=3B<br>&gt=3B -				reg =3D &lt=3B0x3000 0x=
1000&gt=3B=3B<br>&gt=3B -				interrupt-parent =3D &lt=3B&amp=3Bmpic&gt=3B=
=3B<br>&gt=3B -				interrupts =3D &lt=3B90 2 0 0&gt=3B=3B<br>&gt=3B -			}=
=3B<br>&gt=3B -<br>&gt=3B -			sec_jr3: jr@4000 {<br>&gt=3B -				compatible =
=3D "fsl=2Csec-v4.0-job-ring"=3B<br>&gt=3B -				reg =3D &lt=3B0x4000 0x1000=
&gt=3B=3B<br>&gt=3B -				interrupt-parent =3D &lt=3B&amp=3Bmpic&gt=3B=3B<br=
>&gt=3B -				interrupts =3D &lt=3B91 2 0 0&gt=3B=3B<br>&gt=3B -			}=3B<br>&=
gt=3B -<br>&gt=3B -			rtic@6000 {<br>&gt=3B -				compatible =3D "fsl=2Csec-=
v4.0-rtic"=3B<br>&gt=3B -				#address-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B =
-				#size-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -				reg =3D &lt=3B0x6000 0=
x100&gt=3B=3B<br>&gt=3B -				ranges =3D &lt=3B0x0 0x6100 0xe00&gt=3B=3B<br>=
&gt=3B -<br>&gt=3B -				rtic_a: rtic-a@0 {<br>&gt=3B -					compatible =3D "=
fsl=2Csec-v4.0-rtic-memory"=3B<br>&gt=3B -					reg =3D &lt=3B0x00 0x20 0x10=
0 0x80&gt=3B=3B<br>&gt=3B -				}=3B<br>&gt=3B -<br>&gt=3B -				rtic_b: rtic=
-b@20 {<br>&gt=3B -					compatible =3D "fsl=2Csec-v4.0-rtic-memory"=3B<br>&=
gt=3B -					reg =3D &lt=3B0x20 0x20 0x200 0x80&gt=3B=3B<br>&gt=3B -				}=3B=
<br>&gt=3B -<br>&gt=3B -				rtic_c: rtic-c@40 {<br>&gt=3B -					compatible =
=3D "fsl=2Csec-v4.0-rtic-memory"=3B<br>&gt=3B -					reg =3D &lt=3B0x40 0x20=
 0x300 0x80&gt=3B=3B<br>&gt=3B -				}=3B<br>&gt=3B -<br>&gt=3B -				rtic_d:=
 rtic-d@60 {<br>&gt=3B -					compatible =3D "fsl=2Csec-v4.0-rtic-memory"=3B=
<br>&gt=3B -					reg =3D &lt=3B0x60 0x20 0x500 0x80&gt=3B=3B<br>&gt=3B -			=
	}=3B<br>&gt=3B -			}=3B<br>&gt=3B -		}=3B<br>&gt=3B -<br>&gt=3B -		sec_mon=
: sec_mon@314000 {<br>&gt=3B -			compatible =3D "fsl=2Csec-v4.0-mon"=3B<br>=
&gt=3B -			reg =3D &lt=3B0x314000 0x1000&gt=3B=3B<br>&gt=3B -			interrupt-p=
arent =3D &lt=3B&amp=3Bmpic&gt=3B=3B<br>&gt=3B -			interrupts =3D &lt=3B93 =
2 0 0&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -	}=3B<br>&gt=3B -<br>&gt=3B -	r=
apidio0: rapidio@ffe0c0000 {<br>&gt=3B -		#address-cells =3D &lt=3B2&gt=3B=
=3B<br>&gt=3B -		#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -		compatible =
=3D "fsl=2Crapidio-delta"=3B<br>&gt=3B -		interrupts =3D &lt=3B<br>&gt=3B -=
			16 2 1 11 /* err_irq */<br>&gt=3B -			56 2 0 0  /* bell_outb_irq */<br>&=
gt=3B -			57 2 0 0  /* bell_inb_irq */<br>&gt=3B -			60 2 0 0  /* msg1_tx_i=
rq */<br>&gt=3B -			61 2 0 0  /* msg1_rx_irq */<br>&gt=3B -			62 2 0 0  /* =
msg2_tx_irq */<br>&gt=3B -			63 2 0 0&gt=3B=3B /* msg2_rx_irq */<br>&gt=3B =
-	}=3B<br>&gt=3B -<br>&gt=3B -	localbus@ffe124000 {<br>&gt=3B -		compatible=
 =3D "fsl=2Cp4080-elbc"=2C "fsl=2Celbc"=2C "simple-bus"=3B<br>&gt=3B -		int=
errupts =3D &lt=3B25 2 0 0&gt=3B=3B<br>&gt=3B -		#address-cells =3D &lt=3B2=
&gt=3B=3B<br>&gt=3B -		#size-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -	}=3B<br=
>&gt=3B -<br>&gt=3B -	pci0: pcie@ffe200000 {<br>&gt=3B -		compatible =3D "f=
sl=2Cp4080-pcie"=3B<br>&gt=3B -		device_type =3D "pci"=3B<br>&gt=3B -		#siz=
e-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -		#address-cells =3D &lt=3B3&gt=3B=
=3B<br>&gt=3B -		bus-range =3D &lt=3B0x0 0xff&gt=3B=3B<br>&gt=3B -		clock-f=
requency =3D &lt=3B0x1fca055&gt=3B=3B<br>&gt=3B -		fsl=2Cmsi =3D &lt=3B&amp=
=3Bmsi0&gt=3B=3B<br>&gt=3B -		interrupts =3D &lt=3B16 2 1 15&gt=3B=3B<br>&g=
t=3B -		pcie@0 {<br>&gt=3B -			reg =3D &lt=3B0 0 0 0 0&gt=3B=3B<br>&gt=3B -=
			#interrupt-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			#size-cells =3D &lt=
=3B2&gt=3B=3B<br>&gt=3B -			#address-cells =3D &lt=3B3&gt=3B=3B<br>&gt=3B -=
			device_type =3D "pci"=3B<br>&gt=3B -			interrupts =3D &lt=3B16 2 1 15&gt=
=3B=3B<br>&gt=3B -			interrupt-map-mask =3D &lt=3B0xf800 0 0 7&gt=3B=3B<br>=
&gt=3B -			interrupt-map =3D &lt=3B<br>&gt=3B -				/* IDSEL 0x0 */<br>&gt=
=3B -				0000 0 0 1 &amp=3Bmpic 40 1 0 0<br>&gt=3B -				0000 0 0 2 &amp=3Bm=
pic 1 1 0 0<br>&gt=3B -				0000 0 0 3 &amp=3Bmpic 2 1 0 0<br>&gt=3B -				00=
00 0 0 4 &amp=3Bmpic 3 1 0 0<br>&gt=3B -				&gt=3B=3B<br>&gt=3B -		}=3B<br>=
&gt=3B -	}=3B<br>&gt=3B -<br>&gt=3B -	pci1: pcie@ffe201000 {<br>&gt=3B -		c=
ompatible =3D "fsl=2Cp4080-pcie"=3B<br>&gt=3B -		device_type =3D "pci"=3B<b=
r>&gt=3B -		#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -		#address-cells =
=3D &lt=3B3&gt=3B=3B<br>&gt=3B -		bus-range =3D &lt=3B0 0xff&gt=3B=3B<br>&g=
t=3B -		clock-frequency =3D &lt=3B0x1fca055&gt=3B=3B<br>&gt=3B -		fsl=2Cmsi=
 =3D &lt=3B&amp=3Bmsi1&gt=3B=3B<br>&gt=3B -		interrupts =3D &lt=3B16 2 1 14=
&gt=3B=3B<br>&gt=3B -		pcie@0 {<br>&gt=3B -			reg =3D &lt=3B0 0 0 0 0&gt=3B=
=3B<br>&gt=3B -			#interrupt-cells =3D &lt=3B1&gt=3B=3B<br>&gt=3B -			#size=
-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -			#address-cells =3D &lt=3B3&gt=3B=
=3B<br>&gt=3B -			device_type =3D "pci"=3B<br>&gt=3B -			interrupts =3D &lt=
=3B16 2 1 14&gt=3B=3B<br>&gt=3B -			interrupt-map-mask =3D &lt=3B0xf800 0 0=
 7&gt=3B=3B<br>&gt=3B -			interrupt-map =3D &lt=3B<br>&gt=3B -				/* IDSEL =
0x0 */<br>&gt=3B -				0000 0 0 1 &amp=3Bmpic 41 1 0 0<br>&gt=3B -				0000 0=
 0 2 &amp=3Bmpic 5 1 0 0<br>&gt=3B -				0000 0 0 3 &amp=3Bmpic 6 1 0 0<br>&=
gt=3B -				0000 0 0 4 &amp=3Bmpic 7 1 0 0<br>&gt=3B -				&gt=3B=3B<br>&gt=
=3B -		}=3B<br>&gt=3B -	}=3B<br>&gt=3B -<br>&gt=3B -	pci2: pcie@ffe202000 {=
<br>&gt=3B -		compatible =3D "fsl=2Cp4080-pcie"=3B<br>&gt=3B -		device_type=
 =3D "pci"=3B<br>&gt=3B -		#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -		#a=
ddress-cells =3D &lt=3B3&gt=3B=3B<br>&gt=3B -		bus-range =3D &lt=3B0x0 0xff=
&gt=3B=3B<br>&gt=3B -		clock-frequency =3D &lt=3B0x1fca055&gt=3B=3B<br>&gt=
=3B -		fsl=2Cmsi =3D &lt=3B&amp=3Bmsi2&gt=3B=3B<br>&gt=3B -		interrupts =3D=
 &lt=3B16 2 1 13&gt=3B=3B<br>&gt=3B -		pcie@0 {<br>&gt=3B -			reg =3D &lt=
=3B0 0 0 0 0&gt=3B=3B<br>&gt=3B -			#interrupt-cells =3D &lt=3B1&gt=3B=3B<b=
r>&gt=3B -			#size-cells =3D &lt=3B2&gt=3B=3B<br>&gt=3B -			#address-cells =
=3D &lt=3B3&gt=3B=3B<br>&gt=3B -			device_type =3D "pci"=3B<br>&gt=3B -			i=
nterrupts =3D &lt=3B16 2 1 13&gt=3B=3B<br>&gt=3B -			interrupt-map-mask =3D=
 &lt=3B0xf800 0 0 7&gt=3B=3B<br>&gt=3B -			interrupt-map =3D &lt=3B<br>&gt=
=3B -				/* IDSEL 0x0 */<br>&gt=3B -				0000 0 0 1 &amp=3Bmpic 42 1 0 0<br>=
&gt=3B -				0000 0 0 2 &amp=3Bmpic 9 1 0 0<br>&gt=3B -				0000 0 0 3 &amp=
=3Bmpic 10 1 0 0<br>&gt=3B -				0000 0 0 4 &amp=3Bmpic 11 1 0 0<br>&gt=3B -=
				&gt=3B=3B<br>&gt=3B -		}=3B<br>&gt=3B -	}=3B<br>&gt=3B -}=3B<br>&gt=3B =
-- <br>&gt=3B 1.7.3.4<br>&gt=3B <br>&gt=3B <br>&gt=3B <br>&gt=3B ----------=
--------------------<br>&gt=3B <br>&gt=3B _________________________________=
______________<br>&gt=3B Linuxppc-dev mailing list<br>&gt=3B Linuxppc-dev@l=
ists.ozlabs.org<br>&gt=3B https://lists.ozlabs.org/listinfo/linuxppc-dev<br=
>&gt=3B <br>&gt=3B End of Linuxppc-dev Digest=2C Vol 87=2C Issue 61<br>&gt=
=3B ********************************************<br></div> 		 	   		  </div=
></body>
</html>=

--_b3c73276-44e2-4ef2-8842-730de20dc58e_--
