Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE010.bigfish.com (tx2ehsobe005.messaging.microsoft.com
	[65.55.88.15]) by ozlabs.org (Postfix) with ESMTP id 77B19B6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Sep 2010 06:44:09 +1000 (EST)
Received: from mail115-tx2 (localhost.localdomain [127.0.0.1])	by
	mail115-tx2-R.bigfish.com (Postfix) with ESMTP id 4D3411B183A7	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2010 20:28:51 +0000 (UTC)
Received: from TX2EHSMHS036.bigfish.com (unknown [10.9.14.248])	by
	mail115-tx2.bigfish.com (Postfix) with ESMTP id EA4D412A0046	for
	<linuxppc-dev@lists.ozlabs.org>; Tue,  7 Sep 2010 20:28:50 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o87KSbWc012094	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 7 Sep 2010 13:28:37 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o87KgX8t029787	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 7 Sep 2010 15:42:34 -0500 (CDT)
Date: Tue, 7 Sep 2010 15:28:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] mpc8308_p1m: support for MPC8308 P1M board
Message-ID: <20100907152834.1f038f49@schlenkerla.am.freescale.net>
In-Reply-To: <1283854143-2299-1-git-send-email-yanok@emcraft.com>
References: <1283854143-2299-1-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 7 Sep 2010 12:09:03 +0200
Ilya Yanok <yanok@emcraft.com> wrote:

> +	compatible = "mpc8308_p1m";

This needs a vendor prefix.

> +		i2c0@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
> +			compatible = "fsl-i2c";
> +			reg = <0x3000 0x100>;
> +			interrupts = <14 0x8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +			fram@50 {
> +				compatible = "ramtron,24c64";
> +				reg = <0x50>;
> +			};
> +		};
> +
> +		i2c1@3100 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
> +			compatible = "fsl-i2c";
> +			reg = <0x3100 0x100>;
> +			interrupts = <15 0x8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +			pwm@28 {
> +				compatible = "maxim,ds1050";
> +				reg = <0x28>;
> +			};
> +			sensor0@48 {
> +				compatible = "maxim,max6625";
> +				reg = <0x48>;
> +			};
> +			sensor1@49 {
> +				compatible = "maxim,max6625";
> +				reg = <0x49>;
> +			};
> +			sensor2@4b {
> +				compatible = "maxim,max6625";
> +				reg = <0x4b>;
> +			};
> +		};

Why "i2c0@3000" and "i2c1@3100" rather than "i2c@3000" and "i2c@3100"?
Likewise for the sensor nodes.

Drop cell-index; it's not part of the fsl i2c binding (plus, they
probably shouldn't both be zero...).

> +		enet0: ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0x24000 0x1000>;
> +
> +			cell-index = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x24000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <32 0x8 33 0x8 34 0x8>;
> +			interrupt-parent = <&ipic>;
> +			phy-handle = < &phy1 >;
> +			fsl,magic-packet;

8308 does not have magic packet.

> +		gpio@c00 {
> +			#gpio-cells = <2>;
> +			device_type = "gpio";
> +			compatible = "fsl,mpc8308-gpio", "fsl,mpc8349-gpio";
> +			reg = <0xc00 0x18>;
> +			interrupts = <74 0x8>;
> +			interrupt-parent = <&ipic>;
> +			gpio-controller;
> +		};

Drop device_type.

> +	pci0: pcie@e0009000 {
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		#interrupt-cells = <1>;
> +		device_type = "pci";
> +		compatible = "fsl,mpc8308-pcie", "fsl,mpc8314-pcie";
> +		reg = <0xe0009000 0x00001000
> +			0xb0000000 0x01000000>;
> +		ranges = <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
> +		          0x01000000 0 0x00000000 0xb1000000 0 0x00800000>;
> +		bus-range = <0 0>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <0 0 0 1 &ipic 1 8
> +				 0 0 0 2 &ipic 1 8
> +				 0 0 0 3 &ipic 1 8
> +				 0 0 0 4 &ipic 1 8>;

Should interrupt-map-mask be <0 0 0 7>?  Or possibly <0 0 0 0> with
just one map entry?

-Scott
