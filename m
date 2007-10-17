Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A736BDDE45
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 23:53:58 +1000 (EST)
In-Reply-To: <1192460210-26920-1-git-send-email-leoli@freescale.com>
References: <1192460210-26920-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3E4B0158-F1E9-49A7-A8AF-AB444C222E4A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4 9/9] add MPC837x MDS board default device tree
Date: Wed, 17 Oct 2007 08:54:31 -0500
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 15, 2007, at 9:56 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8377_mds.dts |  281 ++++++++++++++++++++++ 
> +++++++++
>  arch/powerpc/boot/dts/mpc8378_mds.dts |  263 ++++++++++++++++++++++ 
> +++++++
>  arch/powerpc/boot/dts/mpc8379_mds.dts |  299 ++++++++++++++++++++++ 
> +++++++++++
>  3 files changed, 843 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/mpc8377_mds.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8378_mds.dts
>  create mode 100644 arch/powerpc/boot/dts/mpc8379_mds.dts
>
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/ 
> boot/dts/mpc8377_mds.dts
> new file mode 100644
> index 0000000..d0bd326
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -0,0 +1,281 @@
> +/*
> + * MPC8377E MDS Device Tree Source
> + *
> + * Copyright 2007 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or  
> modify it
> + * under  the terms of  the GNU General  Public License as  
> published by the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at your
> + * option) any later version.
> + */
> +
> +/ {
> +	model = "fsl,mpc8377emds";
> +	compatible = "fsl,mpc8377emds","fsl,mpc837xmds";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,837x@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;
> +			i-cache-line-size = <20>;
> +			d-cache-size = <8000>;		// L1, 32K
> +			i-cache-size = <8000>;		// L1, 32K
> +			timebase-frequency = <0>;
> +			bus-frequency = <0>;
> +			clock-frequency = <0>;
> +			32-bit;

remove 32-bit.

> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 20000000>;	// 512MB at 0
> +	};
> +
> +	soc837x@e0000000 {

make this just 'soc@e0000000'

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 e0000000 00100000>;
> +		reg = <e0000000 00000200>;
> +		bus-frequency = <0>;
> +

> +
> +		i2c@3000 {
> +			compatible = "fsl-i2c";
> +			reg = <3000 100>;
> +			interrupts = <e 8>;
> +			interrupt-parent = < &ipic >;
> +			dfsrr;

add #address-cells & #size-cells to i2c and device_type = "i2c"  (Yes  
I know there is discussion about this however the code still expects  
it to be here for things to work properly).

> +		};
> +
> +		i2c@3100 {
> +			compatible = "fsl-i2c";
> +			reg = <3100 100>;
> +			interrupts = <f 8>;
> +			interrupt-parent = < &ipic >;
> +			dfsrr;

ditto.

> +		};
> +
> +
[snip]

> +		serial@4500 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4500 100>;
> +			clock-frequency = <0>;
> +			interrupts = <9 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		serial@4600 {
> +			device_type = "serial";
> +			compatible = "ns16550";
> +			reg = <4600 100>;
> +			clock-frequency = <0>;
> +			interrupts = <a 8>;
> +			interrupt-parent = < &ipic >;
> +		};
> +
> +		crypto@30000 {
> +			model = "SEC3";
> +			compatible = "talitos";
> +			reg = <30000 10000>;
> +			interrupts = <b 8>;
> +			interrupt-parent = < &ipic >;
> +			/* Rev. 3.0 geometry */
> +			num-channels = <4>;
> +			channel-fifo-len = <18>;
> +			exec-units-mask = <000009fe>;
> +			descriptor-types-mask = <03ab0ebf>;

is this all correct for sec on 837x?

> +		};
> +

[snip]

- k
