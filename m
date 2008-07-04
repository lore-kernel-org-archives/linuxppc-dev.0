Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 0A757DDE02
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 03:00:45 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1339633wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 10:00:43 -0700 (PDT)
Date: Fri, 4 Jul 2008 11:00:41 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
Message-ID: <20080704170041.GD17062@secretlab.ca>
References: <486E515B.80508@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <486E515B.80508@matrix-vision.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 04, 2008 at 06:35:39PM +0200, Andre Schwarz wrote:
> The mvBlueCOUGAR-P is a MPC5200B based camera system with Intel Gigabit ethernet
> controller (using e1000). It's just another MPC5200_simple board.
> 
> Signed-off-by: Andre Schwarz <andre.schwarz@matrix-vision.de>
> ---
> 
> 
> Grant,
> 
> I don't know if there are any merge windows ...
> If the patch should be modified or re-submitted on a later time please let me know.

The merge window will be opening any day now.  If you address comments
quickly then I should be able to merge it into 2.6.27

>  arch/powerpc/boot/dts/mvbc-p.dts             |  206 +++++
>  arch/powerpc/configs/mvbc-p_defconfig        | 1158 ++++++++++++++++++++++++++
Rename this to arch/powerpc/config/52xx/mvbc_p_defconfig (use platform
specific defconfig dir and don't mix '-' and '_' in filenames).

> diff --git a/arch/powerpc/boot/dts/mvbc-p.dts b/arch/powerpc/boot/dts/mvbc-p.dts
> new file mode 100644
> index 0000000..90a2808
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mvbc-p.dts
> @@ -0,0 +1,206 @@
> +/*
> + * mvBlueCOUGAR-P device tree source
> + *
> + * Copyright (C) 2008 Matrix Vision GmbH
> + * Andre Schwarz <andre.schwarz@matrix-vision.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License as published by the
> + * Free Software Foundation; either version 2 of the License, or (at your
> + * option) any later version.
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +	model = "matrix-vision,mvbc-p";
> +	compatible = "matrix-vision,mvbc-p";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,5200@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <32>;
> +			i-cache-line-size = <32>;
> +			d-cache-size = <0x4000>;
> +			i-cache-size = <0x4000>;
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x00000000>;
> +	};
> +
> +	soc5200@f0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "fsl,mpc5200-immr";

Does this board use the original 5200, or the 5200B?  If it uses the
5200B, then you should specify both fsl,mpc5200b-immr and
fsl,mpc5200-immr.  Same goes for all other compatible properties in the
tree; see lite5200b.dts for an example.

I am toying with the option of eliminating the need for fsl,mpc5200b-*,
but until then the conservative and safest thing to do is to claim
compatibility with both.

> +	lpb {
> +		compatible = "fsl,lpb";

You should also claim compatibility with "simple-bus" here.

ie:  compatible = "fsl,lpb", "simple-bus";

> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0xff800000 0x00800000>;
> +		flash@0,0 {
> +			compatible = "cfi-flash";

For completeness, it is good practice for the first entry in the compatible
list to be the actual flash chip, followed by "cfi-flash"

> +			reg = <0 0 0x800000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			bank-width = <1>;
> +			device-width = <1>;
> +			nor_total@0x0 {
> +				reg = <0x0 0x800000>;
> +			};

I don't know if this is legal; to have overlapping flash sections (but
I'm not a cfi-flash binding expert).

> +			u-boot@0x0 {
> +				reg = <0x0 0x40000>;
> +			};
> +			u-boot_autoscript@0x40000 {
> +				reg = <0x40000 0x10000>;
> +			};
> +			u-boot_autoscript_red@0x50000 {
> +				reg = <0x50000 0x10000>;
> +			};
> +			fpga@0x60000 {
> +				reg = <0x60000 0x40000>;
> +			};
> +			user@0xa0000 {
> +				reg = <0xa00000 0x60000>;
> +			};
> +			rfs@0x100000 {
> +				reg = <0x100000 0x300000>;
> +			};
> +			kernel@0x400000 {
> +				reg = <0x400000 0x3c0000>;
> +			};
> +			dtb@0x7c0000 {
> +				reg = <0x7c0000 0x10000>;
> +			};
> +			dtb@0x7d0000 {
> +				reg = <0x7d0000 0x10000>;
> +			};
> +			ppcboot_env@0x7e0000 {
> +				reg = <0x7e0000 0x10000>;
> +			};
> +			ppcboot_env@0x7f0000 {
> +				reg = <0x7f0000 0x10000>;
> +			};

I think it would be better to just leave out the partition information
and modify U-Boot to fill them in (just like memory and clock speed are
left out).  Things like flash partitions are less like hardware
description and more like configuration data.

> +		};
> +	};
> +
> +	pci: pci@0xf0000d00 {
> +		#interrupt-cells = <1>;
> +		#size-cells = <2>;
> +		#address-cells = <3>;
> +		device_type = "pci";
> +		compatible = "fsl,mpc5200-pci";
> +		reg = <0xf0000d00 0x100>;
> +		interrupt-map-mask = <0xf800 0 0 7>;
> +		interrupt-map = <0x5800 0 0 1 &mpc5200_pic 1 2 3
> +			0x5000 0 0 1 &mpc5200_pic 1 3 3>;
> +		clock-frequency = <0>;
> +		interrupts = <2 8 0 2 9 0 2 10 0>;
> +		interrupt-parent = <&mpc5200_pic>;
> +		bus-range = <0 0>;
> +		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
> +			0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
> +			0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
> +	};
> +};
