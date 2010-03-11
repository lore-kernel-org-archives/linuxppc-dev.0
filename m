Return-Path: <dgibson@ozlabs.org>
Date: Thu, 11 Mar 2010 17:23:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: Freescale MPC5554 device tree (was: cross-compiling Linux for
	PowerPC e200 core?)
Message-ID: <20100311062331.GI11655@yookeroo>
References: <4B934CCA.8030608@freemail.hu>
	<fa686aa41003080934q5d5bebabl7d582d1264da4dcd@mail.gmail.com>
	<4B95458A.4000304@freemail.hu>
	<fa686aa41003081108v31e73660pa817863e5aa73653@mail.gmail.com>
	<4B95F298.5040000@freemail.hu>
	<fa686aa41003082335t5a5d642fi13c81e4b84f7b697@mail.gmail.com>
	<4B9889AC.4080309@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4B9889AC.4080309@freemail.hu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 11, 2010 at 07:11:56AM +0100, Németh Márton wrote:
[snip]
> +/dts-v1/;
> +
> +/ {
> +	model = "MPC5554";
> +	compatible = "fsl,MPC5554EVB";		// Freescale MPC5554 Evaluation Board
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		PowerPC,5554@0 {

Modern best practice is to have the cpu nodes named just "cpu@XXX",
and put the PowerPC,NNNN into the compatible property.

> +			device_type = "cpu";
> +			reg = <0>;
> +			d-cache-line-size = <32>;
> +			i-cache-line-size = <32>;
> +			d-cache-size = <0x8000>;	// L1, 32KiB
> +			i-cache-size = <0x8000>;	// L1, 32KiB
> +			timebase-frequency = <0>;	// from bootloader
> +			bus-frequency = <0>;		// from bootloader
> +			clock-frequency = <0>;		// from bootloader
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x40000000 0x10000>;	// 32KiB internal SRAM
> +	};
> +
> +	xbar@1ff04000 {		// System Bus Crossbar Switch (XBAR)
> +		compatible = "fsl,mpc5554-xbar";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		// The full memory range is covered by XBAR
> +//		ranges = <0 0x00000000 0x100000000>;

If you want all addresses to be translated by the bus you need an
empty ranges property, not *no* ranges property.  No ranges property
indicates that addresses cannot be directly translated across the
bridge, which is not, I think, what you intend.

> +		reg = <0xfff04000 0x4000>;

The unit address '@1ff04000' does not match your reg property 0xfff04000.

> +
> +		flash@00000000 {	// read-only FLASH

Unit addresses are not 0 padded, so this should be just 'flash@0'.

> +			compatible = "fsl,mpc5554-flash";
> +			reg = <0x00000000 0x200000>;	// 2MiB internal FLASH
> +		};
> +
> +		bridge@c0000000 {
> +			compatible = "fsl,mpc5554-pbridge-a";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0xc0000000 0x20000000>;
> +			reg = <0xc3f00000 0x4000>;

The unit address is based on 'reg' (if present) not ranges, so it
should be bridge@c3f00000.  Likewise for the other bridge below.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
