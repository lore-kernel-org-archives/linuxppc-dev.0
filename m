Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF3C6DDDA1
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Jun 2009 13:08:54 +1000 (EST)
Date: Fri, 5 Jun 2009 13:08:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Byron Bradley <byron.bbradley@gmail.com>
Subject: Re: [PATCH] [POWERPC] 83xx: Add support for the Thecus N1200 NAS
	device
Message-ID: <20090605030850.GF2054@yookeroo.seuss>
References: <alpine.DEB.2.00.0906042152330.7053@gamma>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.0906042152330.7053@gamma>
Cc: linuxppc-dev@ozlabs.org, tim.ellis@mac.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 04, 2009 at 09:59:04PM +0100, Byron Bradley wrote:
> The Thecus N1200 is a NAS device with a single internal SATA disk and
> an eSATA port based on an MPC8347 SoC.

Comments on a number of fairly minor device tree nits below:

[snip]
> +	soc8349@e0000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		device_type = "soc";
> +		compatible = "simple-bus";

The compatible value should have something more specific
(e.g. "fsl,mpc8340-soc") before listing "simple-bus".

> +		ranges = <0x0 0xe0000000 0x00100000
> +			  0xfe000000 0xfe000000 0x0800000>;
> +		reg = <0xe0000000 0x00000200>;
> +		bus-frequency = <0>;			// from bootloader
> +
> +		physmap-flash@fe000000 {

Calling this just "flash" would be more normal.

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";

Ideally this should list the actual model of flash chip, before the
generic "cfi-flash".

> +			reg = <0xfe000000 0x0800000>;
> +			bank-width = <2>;
> +			device-width = <1>;
> +
> +			u-boot@0 {
> +				reg = <0x0 0x040000>;
> +				read-only;
> +			};
> +
> +			u-boot-config@40000 {
> +				reg = <0x040000 0x040000>;
> +				label = "u-boot config";
> +			};
> +
> +			user@080000 {
> +				reg = <0x080000 0x100000>;
> +			};
> +
> +			kernel@180000 {
> +				reg = <0x180000 0x1a0000>;
> +			};
> +
> +			ramdisk@320000 {
> +				reg = <0x320000 0x4e0000>;
> +			};
> +		};
> +
> +		wdt@200 {
> +			device_type = "watchdog";

No device_type here.

> +			compatible = "mpc83xx_wdt";
> +			reg = <0x200 0x100>;
> +		};
> +
> +		i2c@3000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cell-index = <0>;
> +			compatible = "fsl-i2c";
> +			reg = <0x3000 0x100>;
> +			interrupts = <14 0x8>;
> +			interrupt-parent = <&ipic>;
> +			dfsrr;
> +
> +			fanctrl@32 {

A less abbreviated name, like "fan-control" would be more usual here.

> +				device_type = "hwmon";

No device_type here either.

> +				compatible = "fintek,f75375";
> +				reg = <0x2e>;
> +			};
> +
> +			rtc@32 {
> +				device_type = "rtc";

Or here.

> +				compatible = "ricoh,rs5c372a";
> +				reg = <0x32>;
> +			};
> +
> +			boardctrl@32 {

Again "board-control" would be preferable.

> +				device_type = "misc";

Especially no device_type here.

[snip]
> +		ipic: pic@700 {
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <0x700 0x100>;
> +			device_type = "ipic";

This should have a compatible property.  It shouldn't really have
device_type, but I suspect that's a bug in the ipic binding, rather
than your tree per-se.

> +		};
> +
> +		gpio1: gpio-controller@c00 {
> +			#gpio-cells = <2>;
> +			compatible = "fsl,mpc8347-gpio", "fsl,mpc8349-gpio";

This actually is an 8349 board, yes?  Generally compatible should be
listed from most specific to least specific, so the 8349 entry should
go first.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
