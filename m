Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2D8D6B7180
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 11:33:56 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1E228DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 11:33:56 +1000 (EST)
Date: Thu, 11 Jun 2009 11:32:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH v2 -next] powerpc/85xx: Add support for X-ES MPC85xx boards
Message-ID: <20090611013201.GA31850@yookeroo.seuss>
References: <1244673039-1089-1-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244673039-1089-1-git-send-email-ncase@xes-inc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2009 at 05:30:39PM -0500, Nate Case wrote:
> Add support for X-ES single-board computers based on the Freescale
> MPC85xx processors.  Changes include:

[snip]
> diff --git a/arch/powerpc/boot/dts/xcalibur1501.dts b/arch/powerpc/boot/dts/xcalibur1501.dts
> new file mode 100644
> index 0000000..497af7a
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/xcalibur1501.dts
> @@ -0,0 +1,759 @@
> +/*
> + * Copyright (C) 2008 Extreme Engineering Solutions, Inc.
> + * Based on MPC8572DS device tree from Freescale Semiconductor, Inc.
> + *
> + * XCalibur1501 6U CompactPCI single-board computer based on MPC8572E
> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/dts-v1/;
> +/ {
> +	model = "xes,xcalibur1501";
> +	compatible = "xes,xcalibur1501", "xes,MPC8572";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	form-factor = "6U cPCI";
> +	boot-bank = <0x0>;	/* 0: Primary flash, 1: Secondary flash */

These last two aren't standard properties, so should probably be
"xes,form-factor" and "xes,boot-bank".

[snip]
> +	pmcslots {

What does this structure model?  Without any reg properties it's kind
of hard to see what you could do with it.

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmcslot@0 {

Since you have an unit address, you must also have a reg property to
match, so reg = <0> in this case.

> +			cell-index = <0>;

Don't use cell-index here, it's redundant with the reg value that you
should have.

> +			/*
> +			 * boolean properties (true if defined):
> +			 *     monarch;
> +			 *     module-present;
> +			 */
> +		};
> +
> +		pmcslot@1 {
> +			cell-index = <1>;
> +			/*
> +			 * boolean properties (true if defined):
> +			 *     monarch;
> +			 *     module-present;
> +			 */
> +		};
> +	};
> +
> +	xmcslots {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		xmcslot@0 {
> +			cell-index = <0>;

Same comments here.

> +			/*
> +			 * boolean properties (true if defined):
> +			 *     module-present;
> +			 */
> +		};
> +
> +		xmcslot@1 {
> +			cell-index = <1>;
> +			/*
> +			 * boolean properties (true if defined):
> +			 *     module-present;
> +			 */
> +		};
> +	};
> +
> +	cpci {
> +		/*
> +		 * boolean properties (true if defined):
> +		 *     system-controller;
> +		 */
> +		system-controller;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,8572@0 {
> +			device_type = "cpu";
> +			reg = <0x0>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <0x8000>;		// L1, 32K
> +			i-cache-size = <0x8000>;		// L1, 32K
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			next-level-cache = <&L2>;
> +		};
> +
> +		PowerPC,8572@1 {
> +			device_type = "cpu";
> +			reg = <0x1>;
> +			d-cache-line-size = <32>;	// 32 bytes
> +			i-cache-line-size = <32>;	// 32 bytes
> +			d-cache-size = <0x8000>;		// L1, 32K
> +			i-cache-size = <0x8000>;		// L1, 32K
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			next-level-cache = <&L2>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";

I assume this node's reg property is supposed to be filled in by the
bootloader.  Best to have an explanatory comment, and/or a template
reg property here.

[snip]
> +	soc8572@ef000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "simple-bus";

This compatible value needs a more specific entry for the specific SoC
type.

[snip]
> +		/* eTSEC 1 front panel 0 */
> +		enet0: ethernet@24000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cell-index = <0>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x24000 0x1000>;
> +			ranges = <0x0 0x24000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <29 2 30 2 34 2>;
> +			interrupt-parent = <&mpic>;
> +			tbi-handle = <&tbi0>;
> +			phy-handle = <&phy0>;
> +			phy-connection-type = "sgmii";
> +
> +			mdio@520 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,gianfar-mdio";
> +				reg = <0x520 0x20>;
> +
> +				phy0: ethernet-phy@1 {
> +					interrupt-parent = <&mpic>;
> +					interrupts = <4 1>;
> +					reg = <0x1>;
> +					device_type = "ethernet-phy";

Drop this device_type.

> +				};
> +				phy1: ethernet-phy@2 {
> +					interrupt-parent = <&mpic>;
> +					interrupts = <4 1>;
> +					reg = <0x2>;
> +					device_type = "ethernet-phy";
> +				};
> +				phy2: ethernet-phy@3 {
> +					interrupt-parent = <&mpic>;
> +					interrupts = <5 1>;
> +					reg = <0x3>;
> +					device_type = "ethernet-phy";
> +				};
> +				phy3: ethernet-phy@4 {
> +					interrupt-parent = <&mpic>;
> +					interrupts = <5 1>;
> +					reg = <0x4>;
> +					device_type = "ethernet-phy";
> +				};
> +				tbi0: tbi-phy@11 {
> +					reg = <0x11>;
> +					device_type = "tbi-phy";
> +				};
> +			};
> +		};
> +
> +		/* eTSEC 2 front panel 1 */
> +		enet1: ethernet@25000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cell-index = <1>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x25000 0x1000>;
> +			ranges = <0x0 0x25000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <35 2 36 2 40 2>;
> +			interrupt-parent = <&mpic>;
> +			tbi-handle = <&tbi1>;
> +			phy-handle = <&phy1>;
> +			phy-connection-type = "sgmii";
> +
> +			mdio@520 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,gianfar-tbi";
> +				reg = <0x520 0x20>;
> +
> +				tbi1: tbi-phy@11 {
> +					reg = <0x11>;
> +					device_type = "tbi-phy";
> +				};
> +			};
> +		};
> +
> +		/* eTSEC 3 PICMG2.16 backplane port 0 */
> +		enet2: ethernet@26000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			cell-index = <2>;
> +			device_type = "network";
> +			model = "eTSEC";
> +			compatible = "gianfar";
> +			reg = <0x26000 0x1000>;
> +			ranges = <0x0 0x26000 0x1000>;
> +			local-mac-address = [ 00 00 00 00 00 00 ];
> +			interrupts = <31 2 32 2 33 2>;
> +			interrupt-parent = <&mpic>;
> +			tbi-handle = <&tbi2>;
> +			phy-handle = <&phy2>;
> +			phy-connection-type = "sgmii";
> +
> +			mdio@520 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "fsl,gianfar-tbi";
> +				reg = <0x520 0x20>;
> +
> +				tbi2: tbi-phy@11 {
> +					reg = <0x11>;
> +					device_type = "tbi-phy";

And this one, too.  Although this node should probably have a
compatible property instead.

[snip]
> +		tlu@2f000 {
> +			device_type = "tlu";

Drop this device_type also.

> diff --git a/arch/powerpc/boot/dts/xpedite5200.dts b/arch/powerpc/boot/dts/xpedite5200.dts
> new file mode 100644
> index 0000000..15a5883
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/xpedite5200.dts

Analagous comments for the other device trees.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
