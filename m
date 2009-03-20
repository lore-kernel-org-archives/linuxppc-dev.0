Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2179CDDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 15:10:29 +1100 (EST)
Date: Fri, 20 Mar 2009 15:10:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
Message-ID: <20090320041022.GB30527@yookeroo.seuss>
References: <49C26434.30302@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49C26434.30302@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 19, 2009 at 04:26:44PM +0100, Wolfgang Grandegger wrote:
> This patch adds support for the "socrates" board based on the MPC8544.
> Supported are Ethernet, serial console, I2C, I2C-based RTC and
> temperature sensors, NOR and NAND flash, PCI, USB, CAN and Lime
> display controller.
> 
> The multiplexing of FPGA interrupts onto PowerPC interrupt lines is
> supported through our own fpga_pic interrupt controller driver.
> 
> For example the SJA1000 controller is level low sensitive connected to
> fpga_pic line 2 and is routed to the second (of three) irq lines to
> the CPU:

A few minor device tree nits.

> +	soc8544@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +
> +		ranges = <0x00000000 0xe0000000 0x00100000>;
> +		reg = <0xe0000000 0x00001000>;	// CCSRBAR 1M
> +		bus-frequency = <0>;		// Filled in by U-Boot
> +		compatible = "fsl,socrates-immr", "simple-bus";

This should probably refer to 8544 instead of socrates.  Unless you
really do have a board-specific version of the SoC...

[snip]
> +		mdio@24520 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,gianfar-mdio";
> +			reg = <0x24520 0x20>;
> +
> +			phy0: ethernet-phy@0 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <0 1>;
> +				reg = <0>;
> +				device_type = "ethernet-phy";

No device_type here.

> +			};
> +			phy1: ethernet-phy@1 {
> +				interrupt-parent = <&mpic>;
> +				interrupts = <0 1>;
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};
> +			tbi0: tbi-phy@11 {
> +				reg = <0x11>;
> +				device_type = "tbi-phy";

Or here.

[snip]
> +	localbus {
> +		compatible = "fsl,socrates-localbus",
> +		             "fsl,mpc85xx-localbus",
> +		             "fsl,pq3-localbus";

Is this bus controller part of the SoC?  If so, the first compatible
string probably shouldn't be there (as for the soc/immr node itself).

[snip[
> +		display@2,0 {
> +			compatible = "fujitsu,lime";

This compat string looks slightly worryingly non-specific.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
