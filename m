Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 13:47:53 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/5] Warp Base Platform - dts
Message-ID: <20080110024753.GC17816@localhost.localdomain>
References: <47852C41.8000506@pikatech.com> <47852CB3.3000208@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47852CB3.3000208@pikatech.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 03:21:07PM -0500, Sean MacLennan wrote:
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> ---
> --- /dev/null	2005-11-20 22:22:37.000000000 -0500
> +++ arch/powerpc/boot/dts/warp.dts	2008-01-08 12:04:10.000000000 -0500

[snip]
> +	plb {
> +		compatible = "ibm,plb-440ep", "ibm,plb-440gp", "ibm,plb4";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges;
> +		clock-frequency = <0>; /* Filled in by zImage */
> +
> +		SDRAM0: sdram {
> +			compatible = "ibm,sdram-440ep", "ibm,sdram-405gp";
> +			dcr-reg = <010 2>;
> +		};
> +
> +		DMA0: dma {
> +			compatible = "ibm,dma-440ep", "ibm,dma-440gp";
> +			dcr-reg = <100 027>;
> +		};
> +
> +		FPGA0: fpga {

Surely this must be off the EBC, not directly of the PLB...?

> +			compatible = "pika,fpga";
> +	   		reg = <0 80000000 2200>;
> +			interrupts = <18 8>;
> +			interrupt-parent = <&UIC0>;
> +		};

[snip]
> +			IIC0: i2c@ef600700 {
> +				device_type = "i2c";

Drop this device_type.

> +				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
> +				reg = <ef600700 14>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <2 4>;
> +			};
> +
> +			ZMII0: emac-zmii@ef600d00 {
> +				device_type = "zmii-interface";

And this one.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
