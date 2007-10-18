Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C9336DE079
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:20:44 +1000 (EST)
In-Reply-To: <1192702580-6353-1-git-send-email-leoli@freescale.com>
References: <1192702580-6353-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9982D235-54B3-4733-8F67-4F75C7D1AFC3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v5 9/9] add MPC837x MDS board default device tree
Date: Thu, 18 Oct 2007 08:17:11 -0500
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

is it me or are you just posting the patches you're updating?  (this  
is the only v5 patch I saw in the series)

On Oct 18, 2007, at 5:16 AM, Li Yang wrote:

> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/ 
> boot/dts/mpc8377_mds.dts
> new file mode 100644
> index 0000000..8530de6
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
> @@ -0,0 +1,282 @@
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
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <00000000 20000000>;	// 512MB at 0
> +	};
> +
> +	soc837x@e0000000 {

soc@e0000000

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 e0000000 00100000>;
> +		reg = <e0000000 00000200>;
> +		bus-frequency = <0>;
> +
> +		wdt@200 {
> +			compatible = "mpc83xx_wdt";
> +			reg = <200 100>;
> +		};
> +
> +		i2c@3000 {

                         #address-cells = <1>;
                         #size-cells = <0>;

> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <3000 100>;
> +			interrupts = <e 8>;
> +			interrupt-parent = < &ipic >;
> +			dfsrr;
> +		};
> +
> +		i2c@3100 {

                         #address-cells = <1>;
                         #size-cells = <0>;

> +			device_type = "i2c";
> +			compatible = "fsl-i2c";
> +			reg = <3100 100>;
> +			interrupts = <f 8>;
> +			interrupt-parent = < &ipic >;
> +			dfsrr;
> +		};
> +
> +		spi@7000 {
> +			compatible = "mpc83xx_spi";
> +			reg = <7000 1000>;
> +			interrupts = <10 8>;
> +			interrupt-parent = < &ipic >;

mode = "cpu";

> +			mode = <0>;
> +		};
> +

- k
