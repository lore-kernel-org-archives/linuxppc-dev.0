Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Dec 2007 16:14:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071217051403.GB3477@localhost.localdomain>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071215162331.GA24999@localhost.localdomain>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 15, 2007 at 07:23:31PM +0300, Anton Vorontsov wrote:
> On Tue, Dec 11, 2007 at 12:42:18PM -0600, Kumar Gala wrote:
[snip]
> +	soc8360@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		ranges = <0 0xe0000000 0x00100000>;
> +		reg = <0xe0000000 0x00000200>;
> +		/* filled by u-boot */
> +		bus-frequency = <0>;
> +
> +		wdt@200 {
> +			device_type = "watchdog";

Drop this device_type.

> +			compatible = "mpc83xx_wdt";
> +			reg = <0x200 0x100>;
> +		};
> +
> +		i2c@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "i2c";

And this one.

[snip]
> +		crypto@30000 {
> +			device_type = "crypto";
> +			model = "SEC2";
> +			compatible = "talitos";

This device_type/compatible/model stuff is also crap, although I
suspect it needs to be fixed in the driver, as gianfar (finally) was.

[snip]
> +		ipic: pic@700 {
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +			reg = <0x700 0x100>;
> +			device_type = "ipic";

And drop this device_type.

[snip]
> +	qe@e0100000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "qe";

And this one.

This node needs a "compatible" too.

> +		model = "QE";
> +		ranges = <0 0xe0100000 0x00100000>;
> +		reg = <0xe0100000 0x480>;
> +		/* filled by u-boot */
> +		brg-frequency = <0>;
> +		bus-frequency = <0>;

This should probably be clock-frequency, not bus-frequency.  After
all, it's a bus node, what other sort of frequency would it be.

> +		muram@10000 {
> +			device_type = "muram";

And this device_type needs to go, too.

> +			ranges = <0 0x00010000 0x0000c000>;
> +
> +			data-only@0 {
> +				reg = <0 0xc000>;
> +			};
> +		};
> +
> +		spi@4c0 {
> +			device_type = "spi";

And this one.

[snip]

> +		usb@6c0 {
> +			device_type = "usb";

And this one.

> +			compatible = "qe_udc";
> +			reg = <0x6c0 0x40 0x8b00 0x100>;
> +			interrupts = <11>;
> +			interrupt-parent = <&qeic>;
> +			mode = "slave";
> +		};

[snip]
> +		mdio@2120 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2120 0x18>;
> +			device_type = "mdio";

And this one.

> +			compatible = "ucc_geth_phy";
> +
> +			phy1: ethernet-phy@1 {
> +				reg = <1>;
> +				device_type = "ethernet-phy";
> +			};

These phy nodes have basically no information in them.  PHY nodes are
optional - only include them if they actually have something useful to
say (which would mean at least a compatible property).

[snip]
> +		qeic: qeic@80 {
> +			#address-cells = <0>;
> +			#interrupt-cells = <1>;
> +			interrupt-controller;
> +			device_type = "qeic";

Drop this device_type, too.

And this node, too, needs a "compatible" property.  Oh, and the node
name should be "interrupt-controller@80" by the generic names
convention.

> +			reg = <0x80 0x80>;
> +			big-endian;
> +			interrupts = <32 8 33 8>;
> +			interrupt-parent = <&ipic>;
> +		};
> +	};
> +};

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
