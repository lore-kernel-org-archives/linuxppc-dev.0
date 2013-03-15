Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5299C2C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2013 02:55:34 +1100 (EST)
Subject: Re: [PATCH 1/6] powerpc/fsl-booke: Add initial silicon device tree
 files for B4860QDS
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
Date: Fri, 15 Mar 2013 10:54:33 -0500
Message-Id: <CA43CC11-2BA1-4DF4-9646-DCEFA049FE93@kernel.crashing.org>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Cc: Zhao Chenhui <chenhui.zhao@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Tang Yuantian <Yuantian.Tang@freescale.com>,
 Andy Fleming <afleming@freescale.com>,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>,
 Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 15, 2013, at 2:55 AM, Shaveta Leekha wrote:

> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> ---
> arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  184 =
+++++++++++++++++++++++++++
> arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi  |   80 ++++++++++++
> 2 files changed, 264 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> create mode 100644 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi

Commit description should convey what hw isn't yet covered as well.

DPAA, DSPs, etc.

- k

>=20
> diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi =
b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> new file mode 100644
> index 0000000..2db68b2
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> @@ -0,0 +1,184 @@
> +/*
> + * B4860 Silicon/SoC Device Tree Source (post include)
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above =
copyright
> + *       notice, this list of conditions and the following =
disclaimer.
> + *     * Redistributions in binary form must reproduce the above =
copyright
> + *       notice, this list of conditions and the following disclaimer =
in the
> + *       documentation and/or other materials provided with the =
distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote =
products
> + *       derived from this software without specific prior written =
permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free =
Software
> + * Foundation, either version 2 of that License or (at your option) =
any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND =
ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE =
IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE =
ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE =
FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL =
DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR =
SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER =
CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +&ifc {
> +	#address-cells =3D <2>;
> +	#size-cells =3D <1>;
> +	compatible =3D "fsl,ifc", "simple-bus";
> +	interrupts =3D <25 2 0 0>;
> +};
> +
> +/* controller at 0x200000 */
> +&pci0 {
> +	compatible =3D "fsl,b4860-pcie", "fsl,qoriq-pcie-v2.4";
> +	device_type =3D "pci";
> +	#size-cells =3D <2>;
> +	#address-cells =3D <3>;
> +	bus-range =3D <0x0 0xff>;
> +	interrupts =3D <20 2 0 0>;
> +	pcie@0 {
> +		#interrupt-cells =3D <1>;
> +		#size-cells =3D <2>;
> +		#address-cells =3D <3>;
> +		device_type =3D "pci";
> +		interrupts =3D <20 2 0 0>;
> +		interrupt-map-mask =3D <0xf800 0 0 7>;
> +		interrupt-map =3D <
> +			/* IDSEL 0x0 */
> +			0000 0 0 1 &mpic 40 1 0 0
> +			0000 0 0 2 &mpic 1 1 0 0
> +			0000 0 0 3 &mpic 2 1 0 0
> +			0000 0 0 4 &mpic 3 1 0 0
> +			>;
> +	};
> +};
> +
> +&rio {
> +	compatible =3D "fsl,srio";
> +	interrupts =3D <16 2 1 11>;
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	ranges;
> +
> +	port1 {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		cell-index =3D <1>;
> +	};
> +
> +	port2 {
> +		#address-cells =3D <2>;
> +		#size-cells =3D <2>;
> +		cell-index =3D <2>;
> +	};
> +};
> +
> +&soc {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	device_type =3D "soc";
> +	compatible =3D "simple-bus";
> +
> +	soc-sram-error {
> +		compatible =3D "fsl,soc-sram-error";
> +		interrupts =3D <16 2 1 2>;
> +	};
> +
> +	corenet-law@0 {
> +		compatible =3D "fsl,corenet-law";
> +		reg =3D <0x0 0x1000>;
> +		fsl,num-laws =3D <32>;
> +	};
> +
> +	ddr1: memory-controller@8000 {
> +		compatible =3D "fsl,qoriq-memory-controller-v4.5", =
"fsl,qoriq-memory-controller";
> +		reg =3D <0x8000 0x1000>;
> +		interrupts =3D <16 2 1 8>;
> +	};
> +
> +	ddr2: memory-controller@9000 {
> +		compatible =3D =
"fsl,qoriq-memory-controller-v4.5","fsl,qoriq-memory-controller";
> +		reg =3D <0x9000 0x1000>;
> +		interrupts =3D <16 2 1 9>;
> +	};
> +
> +	cpc: l3-cache-controller@10000 {
> +		compatible =3D "fsl,p5020-l3-cache-controller", =
"fsl,p4080-l3-cache-controller", "cache";
> +		reg =3D <0x10000 0x1000
> +		       0x11000 0x1000>;
> +		interrupts =3D <16 2 1 4
> +			      16 2 1 5>;
> +	};
> +
> +	corenet-cf@18000 {
> +		compatible =3D "fsl,corenet-cf";
> +		reg =3D <0x18000 0x1000>;
> +		interrupts =3D <16 2 1 0>;
> +		fsl,ccf-num-csdids =3D <32>;
> +		fsl,ccf-num-snoopids =3D <32>;
> +	};
> +
> +	iommu@20000 {
> +		compatible =3D "fsl,pamu-v1.0", "fsl,pamu";
> +		reg =3D <0x20000 0x4000>;
> +		interrupts =3D <
> +			24 2 0 0
> +			16 2 1 1>;
> +	};
> +
> +/include/ "qoriq-mpic.dtsi"
> +
> +	guts: global-utilities@e0000 {
> +		compatible =3D "fsl,b4860-device-config";
> +		reg =3D <0xe0000 0xe00>;
> +		fsl,has-rstcr;
> +		fsl,liodn-bits =3D <12>;
> +	};
> +
> +	clockgen: global-utilities@e1000 {
> +		compatible =3D "fsl,b4860-clockgen", =
"fsl,qoriq-clockgen-2";
> +		reg =3D <0xe1000 0x1000>;
> +	};
> +
> +	rcpm: global-utilities@e2000 {
> +		compatible =3D "fsl,b4860-rcpm", "fsl,qoriq-rcpm-2";
> +		reg =3D <0xe2000 0x1000>;
> +	};
> +
> +/include/ "qoriq-dma-0.dtsi"
> +/include/ "qoriq-dma-1.dtsi"
> +
> +/include/ "qonverge-usb2-dr-0.dtsi"
> +	usb0: usb@210000 {
> +		compatible =3D "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
> +	};
> +
> +/include/ "qoriq-espi-0.dtsi"
> +	spi@110000 {
> +		fsl,espi-num-chipselects =3D <4>;
> +	};
> +
> +/include/ "qoriq-esdhc-0.dtsi"
> +	sdhc@114000 {
> +		sdhci,auto-cmd12;
> +	};
> +/include/ "qoriq-i2c-0.dtsi"
> +/include/ "qoriq-i2c-1.dtsi"
> +/include/ "qoriq-duart-0.dtsi"
> +/include/ "qoriq-duart-1.dtsi"
> +
> +	L2: l2-cache-controller@c20000 {
> +		next-level-cache =3D <&cpc>;
> +	};
> +};
> diff --git a/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi =
b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> new file mode 100644
> index 0000000..33bc600
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi
> @@ -0,0 +1,80 @@
> +/*
> + * B4860 Silicon/SoC Device Tree Source (pre include)
> + *
> + * Copyright 2012 Freescale Semiconductor Inc.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions =
are met:
> + *     * Redistributions of source code must retain the above =
copyright
> + *       notice, this list of conditions and the following =
disclaimer.
> + *     * Redistributions in binary form must reproduce the above =
copyright
> + *       notice, this list of conditions and the following disclaimer =
in the
> + *       documentation and/or other materials provided with the =
distribution.
> + *     * Neither the name of Freescale Semiconductor nor the
> + *       names of its contributors may be used to endorse or promote =
products
> + *       derived from this software without specific prior written =
permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of =
the
> + * GNU General Public License ("GPL") as published by the Free =
Software
> + * Foundation, either version 2 of that License or (at your option) =
any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND =
ANY
> + * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE =
IMPLIED
> + * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE =
ARE
> + * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE =
FOR ANY
> + * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL =
DAMAGES
> + * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR =
SERVICES;
> + * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER =
CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, =
OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE =
USE OF THIS
> + * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +/dts-v1/;
> +/ {
> +	compatible =3D "fsl,B4860";
> +	#address-cells =3D <2>;
> +	#size-cells =3D <2>;
> +	interrupt-parent =3D <&mpic>;
> +
> +	aliases {
> +		ccsr =3D &soc;
> +
> +		serial0 =3D &serial0;
> +		serial1 =3D &serial1;
> +		serial2 =3D &serial2;
> +		serial3 =3D &serial3;
> +		pci0 =3D &pci0;
> +		dma0 =3D &dma0;
> +		dma1 =3D &dma1;
> +		sdhc =3D &sdhc;
> +	};
> +
> +	cpus {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		PowerPC,e6500@0 {
> +			device_type =3D "cpu";
> +			reg =3D <0 1>;
> +			next-level-cache =3D <&L2>;
> +		};
> +		PowerPC,e6500@1 {
> +			device_type =3D "cpu";
> +			reg =3D <2 3>;
> +			next-level-cache =3D <&L2>;
> +		};
> +		PowerPC,e6500@2 {
> +			device_type =3D "cpu";
> +			reg =3D <4 5>;
> +			next-level-cache =3D <&L2>;
> +		};
> +		PowerPC,e6500@3 {
> +			device_type =3D "cpu";
> +			reg =3D <6 7>;
> +			next-level-cache =3D <&L2>;
> +		};
> +	};
> +};
> --=20
> 1.7.6.GIT
>=20
