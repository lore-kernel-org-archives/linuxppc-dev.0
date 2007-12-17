Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 14:59:12 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 2/3] mpc82xx: Embedded Planet EP8248E support
Message-ID: <20071217035912.GB3262@localhost.localdomain>
References: <20071212225429.GB19027@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071212225429.GB19027@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 04:54:29PM -0600, Scott Wood wrote:
> This board is also resold by Freescale under the names
> "QUICCStart MPC8248 Evaluation System" and "CWH-PPC-8248N-VE".

[snip]
> +	localbus {

Should be localbus@f0010100.

> +		compatible = "fsl,ep8248e-localbus",
> +		             "fsl,mpc8248-localbus",
> +		             "fsl,pq2-localbus";
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		reg = <f0010100 40>;
> +
> +		ranges = <0 0 fc000000 04000000
> +		          1 0 fa000000 00008000>;
> +
> +		flash@0,3800000 {
> +			compatible = "cfi-flash";
> +			reg = <0 3800000 800000>;
> +			bank-width = <4>;
> +			device-width = <2>;
> +		};
> +
> +		bcsr@1,0 {
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			reg = <1 0 10>;
> +			compatible = "fsl,ep8248e-bcsr";
> +			ranges;
> +
> +			mdio {

As I think I said about another tree, this mdio-under-bcsr arrangement
is pretty strange.  What's going on here.


> +				device_type = "mdio";
> +				compatible = "fsl,ep8248e-mdio-bitbang";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <1 8 1>;
> +
> +				PHY0: ethernet-phy@0 {
> +					interrupt-parent = <&PIC>;
> +					reg = <0>;
> +					device_type = "ethernet-phy";
> +				};
> +
> +				PHY1: ethernet-phy@1 {
> +					interrupt-parent = <&PIC>;
> +					reg = <1>;
> +					device_type = "ethernet-phy";
> +				};
> +			};
> +		};
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0 0>;
> +	};
> +
> +	soc@f0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";

Ditch the device_type.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
