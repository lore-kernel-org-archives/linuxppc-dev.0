Return-Path: <dgibson@ozlabs.org>
Date: Wed, 16 Jan 2008 11:46:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/2] [POWERPC] 4xx: Add AMCC Haleakala (405EXr) dts
Message-ID: <20080116004642.GD4283@localhost.localdomain>
References: <1200380965-10245-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1200380965-10245-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 15, 2008 at 08:09:25AM +0100, Stefan Roese wrote:
> The patch adds the Haleakala dts. The Haleakala is a stripped down
> version of the Kilauea (405EX) with only one EMAC and only one PCIe
> interface.

[snip]
> +			IIC0: i2c@ef600400 {
> +				device_type = "i2c";

No device_type here.

> +				compatible = "ibm,iic-405exr", "ibm,iic";
> +				reg = <ef600400 14>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <2 4>;
> +			};
> +
> +			IIC1: i2c@ef600500 {
> +				device_type = "i2c";

Or here.

> +				compatible = "ibm,iic-405exr", "ibm,iic";
> +				reg = <ef600500 14>;
> +				interrupt-parent = <&UIC0>;
> +				interrupts = <7 4>;
> +			};
> +
> +
> +			RGMII0: emac-rgmii@ef600b00 {
> +				device_type = "rgmii-interface";

And especially not here.

> +				compatible = "ibm,rgmii-405exr", "ibm,rgmii";
> +				reg = <ef600b00 104>;
> +				has-mdio;
> +			};

[snip]
> +		PCIE0: pciex@0a0000000 {
> +			device_type = "pci";
> +			#interrupt-cells = <1>;
> +			#size-cells = <2>;
> +			#address-cells = <3>;
> +			compatible = "ibm,plb-pciex-405exr", "ibm,plb-pciex";
> +			primary;
> +			port = <0>; /* port number */
> +			reg = <a0000000 20000000	/* Config space access */
> +			       ef000000 00001000>;	/* Registers */
> +			dcr-reg = <040 020>;
> +			sdr-base = <400>;

Oh, for crying out loud.  They put dcrs on the bridge as well as MMIO
registers. *facepalm*

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
