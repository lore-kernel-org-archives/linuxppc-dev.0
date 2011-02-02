Return-Path: <dgibson@ozlabs.org>
Date: Wed, 2 Feb 2011 13:43:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 6/6] powerpc/476: Create a dts files for two 476 AMP
	instances under ISS
Message-ID: <20110202024315.GB3032@yookeroo>
References: <1296586126-32765-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1296586126-32765-7-git-send-email-shaggy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296586126-32765-7-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 01, 2011 at 12:48:46PM -0600, Dave Kleikamp wrote:
> These are completely independent OS instances, each running on 2
> cores.

[snip]
> +/memreserve/ 0x01f00000 0x00100000;

A comment describing what this reserved section is for would be good.

> +/ {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	model = "ibm,iss-4xx";
> +	compatible = "ibm,iss-4xx", "ibm,47x-AMP";
> +	dcr-parent = <&{/cpus/cpu@0}>;
> +
> +	aliases {
> +		serial0 = &UART0;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			model = "PowerPC,4xx"; // real CPU changed in sim

If the comment is true, then it's probably simpler to just omit the
model property.  I'm pretty sure nothing will look at it.

> +			reg = <0>;
> +			clock-frequency = <100000000>; // 100Mhz :-)
> +			timebase-frequency = <100000000>;> +			i-cache-line-size = <32>;
> +			d-cache-line-size = <32>;
> +			i-cache-size = <32768>;
> +			d-cache-size = <32768>;
> +			dcr-controller;
> +			dcr-access-method = "native";
> +			status = "ok";

Should be "okay" rather than "ok".

[snip]
> +			UART0: serial@40000200 {
> +				device_type = "serial";
> +				compatible = "ns16550a";
> +				reg = <0x40000200 0x00000008>;
> +				virtual-reg = <0xe0000200>;
> +				clock-frequency = <11059200>;
> +				current-speed = <115200>;
> +				interrupt-parent = <&MPIC>;
> +				interrupts = <0x0 0x2>;
> +			};
> +		};
> +	};
> +
> +	nvrtc {
> +		compatible = "ds1743-nvram", "ds1743", "rtc-ds1743";
> +		reg = <0 0xEF703000 0x2000>;
> +	};
> +
> +	chosen {
> +		linux,stdout-path = "/plb/opb/serial@40000200";

You can use a string reference here:
	linux,stdout-path = &UART0;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
