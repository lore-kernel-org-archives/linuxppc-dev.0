Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 13:18:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 4/7] Device tree for MPC5121 ADS
Message-ID: <20080110021856.GB17816@localhost.localdomain>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1199808093-15929-5-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 09:01:30AM -0700, John Rigby wrote:
> Bare minimum tree containing only
> what is currently supported.

[snip]
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,5121@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <20>;	// 32 bytes
> +			i-cache-line-size = <20>;	// 32 bytes
> +			d-cache-size = <8000>;		// L1, 32K
> +			i-cache-size = <8000>;		// L1, 32K
> +			ref-frequency = <3ef1480>;	// 66MHz ref clock
> +			timebase-frequency = <2f34f60>; // 49.5MHz (396MHz/8) makes time tick correctly
> +			bus-frequency = <bcd3d80>;	// 198MHz csb bus
> +			clock-frequency = <179a7b00>;	// 396MHz ppc core ??
> +			32-bit;

The "32-bit" property was only ever added by mistake.  Drop it.

[snip]
> +	cpld@82000000 {
> +		device_type = "board-control";

No device_type here.  But you should have a "compatible" property.

[snip]
> +	soc5121@80000000 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		#interrupt-cells = <2>;
> +		device_type = "soc";
> +		ranges = <0 80000000 400000>;
> +		reg = <80000000 400000>;
> +		ref-frequency = <3ef1480>;	// 66MHz ref

What the hell is ref-frequency?  Unfortunately, you have to work with
existing broken practice for SoC nodes here, but the principle clock
frequency for any device should always be encoded in a property called
"clock-frequency".

[snip]
> +		ipic: pic@c00 {

Should be "interrupt-controller@c00"

> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <c00 100>;
> +			built-in;
> +			device_type = "ipic";

Drop this device_type.  Should have a compatible value instead.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
