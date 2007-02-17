Return-Path: <dgibson@ozlabs.org>
Date: Sun, 18 Feb 2007 10:40:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [POWERPC] 86xx: Cleaned up platform dts files
Message-ID: <20070217234040.GA29434@localhost.localdomain>
References: <Pine.LNX.4.64.0702171631150.11585@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0702171631150.11585@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 17, 2007 at 04:32:18PM -0600, Kumar Gala wrote:
> * Removed explicit linux,phandle usage. Use references and labels now
> * Removed interrupts property from openpic node
> * Removed interrupt-parent property from openpic node that pointed to itself

Excellent!  Except... I'm wondering if it might be a good idea to
establish a convention of using caps for node labels - makes them a
bit easier to distinguish visually.

> ---
> 
> Please review, I'm pretty sure the changes to the openpic node should be
> ok, but wanted to run them by you.
> 
> - k
> 
> commit affa4df34f80104d5740c225b57639d1d72a7ed0
> tree d03d27107b5a49f247103853eff9865037786b1b
> parent ff7298ea16bc15ffbba49c36724714e033a5fc10
> author Kumar Gala <galak@kernel.crashing.org> Sat, 17 Feb 2007 16:09:56 -0600
> committer Kumar Gala <galak@kernel.crashing.org> Sat, 17 Feb 2007 16:09:56 -0600
> 
>  arch/powerpc/boot/dts/mpc8641_hpcn.dts |  193 ++++++++++++++------------------
>  1 files changed, 85 insertions(+), 108 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> index 8c75e4e..8a4995a 100644
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -66,7 +66,7 @@
>  			compatible = "fsl-i2c";
>  			reg = <3000 100>;
>  			interrupts = <2b 2>;
> -			interrupt-parent = <40000>;
> +			interrupt-parent = <&mpic>;
>  			dfsrr;
>  		};
> 
> @@ -75,7 +75,7 @@
>  			compatible = "fsl-i2c";
>  			reg = <3100 100>;
>  			interrupts = <2b 2>;
> -			interrupt-parent = <40000>;
> +			interrupt-parent = <&mpic>;
>  			dfsrr;
>  		};
> 
> @@ -85,31 +85,26 @@
>  			device_type = "mdio";
>  			compatible = "gianfar";
>  			reg = <24520 20>;
> -			linux,phandle = <24520>;
> -			ethernet-phy@0 {
> -				linux,phandle = <2452000>;
> -				interrupt-parent = <40000>;
> +			phy0: ethernet-phy@0 {
> +				interrupt-parent = <&mpic>;
>  				interrupts = <4a 1>;
>  				reg = <0>;
>  				device_type = "ethernet-phy";
>  			};
> -			ethernet-phy@1 {
> -				linux,phandle = <2452001>;
> -				interrupt-parent = <40000>;
> +			phy1: ethernet-phy@1 {
> +				interrupt-parent = <&mpic>;
>  				interrupts = <4a 1>;
>  				reg = <1>;
>  				device_type = "ethernet-phy";
>  			};
> -			ethernet-phy@2 {
> -				linux,phandle = <2452002>;
> -				interrupt-parent = <40000>;
> +			phy2: ethernet-phy@2 {
> +				interrupt-parent = <&mpic>;
>  				interrupts = <4a 1>;
>  				reg = <2>;
>  				device_type = "ethernet-phy";
>  			};
> -			ethernet-phy@3 {
> -				linux,phandle = <2452003>;
> -				interrupt-parent = <40000>;
> +			phy3: ethernet-phy@3 {
> +				interrupt-parent = <&mpic>;
>  				interrupts = <4a 1>;
>  				reg = <3>;
>  				device_type = "ethernet-phy";
> @@ -125,8 +120,8 @@
>  			reg = <24000 1000>;
>  			mac-address = [ 00 E0 0C 00 73 00 ];
>  			interrupts = <1d 2 1e 2 22 2>;
> -			interrupt-parent = <40000>;
> -			phy-handle = <2452000>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy0>;
>  		};
> 
>  		ethernet@25000 {
> @@ -138,8 +133,8 @@
>  			reg = <25000 1000>;
>  			mac-address = [ 00 E0 0C 00 73 01 ];
>  			interrupts = <23 2 24 2 28 2>;
> -			interrupt-parent = <40000>;
> -			phy-handle = <2452001>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy1>;
>  		};
> 
>  		ethernet@26000 {
> @@ -151,8 +146,8 @@
>  			reg = <26000 1000>;
>  			mac-address = [ 00 E0 0C 00 02 FD ];
>  			interrupts = <1F 2 20 2 21 2>;
> -			interrupt-parent = <40000>;
> -			phy-handle = <2452002>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy2>;
>  		};
> 
>  		ethernet@27000 {
> @@ -164,8 +159,8 @@
>  			reg = <27000 1000>;
>  			mac-address = [ 00 E0 0C 00 03 FD ];
>  			interrupts = <25 2 26 2 27 2>;
> -			interrupt-parent = <40000>;
> -			phy-handle = <2452003>;
> +			interrupt-parent = <&mpic>;
> +			phy-handle = <&phy3>;
>  		};
>  		serial@4500 {
>  			device_type = "serial";
> @@ -173,7 +168,7 @@
>  			reg = <4500 100>;
>  			clock-frequency = <0>;
>  			interrupts = <2a 2>;
> -			interrupt-parent = <40000>;
> +			interrupt-parent = <&mpic>;
>  		};
> 
>  		serial@4600 {
> @@ -182,7 +177,7 @@
>  			reg = <4600 100>;
>  			clock-frequency = <0>;
>  			interrupts = <1c 2>;
> -			interrupt-parent = <40000>;
> +			interrupt-parent = <&mpic>;
>  		};
> 
>  		pci@8000 {
> @@ -196,103 +191,102 @@
>  			ranges = <02000000 0 80000000 80000000 0 20000000
>  				  01000000 0 00000000 e2000000 0 00100000>;
>  			clock-frequency = <1fca055>;
> -			interrupt-parent = <40000>;
> +			interrupt-parent = <&mpic>;
>  			interrupts = <18 2>;
>  			interrupt-map-mask = <f800 0 0 7>;
>  			interrupt-map = <
>  				/* IDSEL 0x11 */
> -				8800 0 0 1 4d0 3 2
> -				8800 0 0 2 4d0 4 2
> -				8800 0 0 3 4d0 5 2
> -				8800 0 0 4 4d0 6 2
> +				8800 0 0 1 &i8259 3 2
> +				8800 0 0 2 &i8259 4 2
> +				8800 0 0 3 &i8259 5 2
> +				8800 0 0 4 &i8259 6 2
> 
>  				/* IDSEL 0x12 */
> -				9000 0 0 1 4d0 4 2
> -				9000 0 0 2 4d0 5 2
> -				9000 0 0 3 4d0 6 2
> -				9000 0 0 4 4d0 3 2
> +				9000 0 0 1 &i8259 4 2
> +				9000 0 0 2 &i8259 5 2
> +				9000 0 0 3 &i8259 6 2
> +				9000 0 0 4 &i8259 3 2
> 
>  				/* IDSEL 0x13 */
> -				9800 0 0 1 4d0 0 0
> -				9800 0 0 2 4d0 0 0
> -				9800 0 0 3 4d0 0 0
> -				9800 0 0 4 4d0 0 0
> +				9800 0 0 1 &i8259 0 0
> +				9800 0 0 2 &i8259 0 0
> +				9800 0 0 3 &i8259 0 0
> +				9800 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x14 */
> -				a000 0 0 1 4d0 0 0
> -				a000 0 0 2 4d0 0 0
> -				a000 0 0 3 4d0 0 0
> -				a000 0 0 4 4d0 0 0
> +				a000 0 0 1 &i8259 0 0
> +				a000 0 0 2 &i8259 0 0
> +				a000 0 0 3 &i8259 0 0
> +				a000 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x15 */
> -				a800 0 0 1 4d0 0 0
> -				a800 0 0 2 4d0 0 0
> -				a800 0 0 3 4d0 0 0
> -				a800 0 0 4 4d0 0 0
> +				a800 0 0 1 &i8259 0 0
> +				a800 0 0 2 &i8259 0 0
> +				a800 0 0 3 &i8259 0 0
> +				a800 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x16 */
> -				b000 0 0 1 4d0 0 0
> -				b000 0 0 2 4d0 0 0
> -				b000 0 0 3 4d0 0 0
> -				b000 0 0 4 4d0 0 0
> +				b000 0 0 1 &i8259 0 0
> +				b000 0 0 2 &i8259 0 0
> +				b000 0 0 3 &i8259 0 0
> +				b000 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x17 */
> -				b800 0 0 1 4d0 0 0
> -				b800 0 0 2 4d0 0 0
> -				b800 0 0 3 4d0 0 0
> -				b800 0 0 4 4d0 0 0
> +				b800 0 0 1 &i8259 0 0
> +				b800 0 0 2 &i8259 0 0
> +				b800 0 0 3 &i8259 0 0
> +				b800 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x18 */
> -				c000 0 0 1 4d0 0 0
> -				c000 0 0 2 4d0 0 0
> -				c000 0 0 3 4d0 0 0
> -				c000 0 0 4 4d0 0 0
> +				c000 0 0 1 &i8259 0 0
> +				c000 0 0 2 &i8259 0 0
> +				c000 0 0 3 &i8259 0 0
> +				c000 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x19 */
> -				c800 0 0 1 4d0 0 0
> -				c800 0 0 2 4d0 0 0
> -				c800 0 0 3 4d0 0 0
> -				c800 0 0 4 4d0 0 0
> +				c800 0 0 1 &i8259 0 0
> +				c800 0 0 2 &i8259 0 0
> +				c800 0 0 3 &i8259 0 0
> +				c800 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x1a */
> -				d000 0 0 1 4d0 6 2
> -				d000 0 0 2 4d0 3 2
> -				d000 0 0 3 4d0 4 2
> -				d000 0 0 4 4d0 5 2
> +				d000 0 0 1 &i8259 6 2
> +				d000 0 0 2 &i8259 3 2
> +				d000 0 0 3 &i8259 4 2
> +				d000 0 0 4 &i8259 5 2
> 
> 
>  				/* IDSEL 0x1b */
> -				d800 0 0 1 4d0 5 2
> -				d800 0 0 2 4d0 0 0
> -				d800 0 0 3 4d0 0 0
> -				d800 0 0 4 4d0 0 0
> +				d800 0 0 1 &i8259 5 2
> +				d800 0 0 2 &i8259 0 0
> +				d800 0 0 3 &i8259 0 0
> +				d800 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x1c */
> -				e000 0 0 1 4d0 9 2
> -				e000 0 0 2 4d0 a 2
> -				e000 0 0 3 4d0 c 2
> -				e000 0 0 4 4d0 7 2
> +				e000 0 0 1 &i8259 9 2
> +				e000 0 0 2 &i8259 a 2
> +				e000 0 0 3 &i8259 c 2
> +				e000 0 0 4 &i8259 7 2
> 
>  				/* IDSEL 0x1d */
> -				e800 0 0 1 4d0 9 2
> -				e800 0 0 2 4d0 a 2
> -				e800 0 0 3 4d0 b 2
> -				e800 0 0 4 4d0 0 0
> +				e800 0 0 1 &i8259 9 2
> +				e800 0 0 2 &i8259 a 2
> +				e800 0 0 3 &i8259 b 2
> +				e800 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x1e */
> -				f000 0 0 1 4d0 c 2
> -				f000 0 0 2 4d0 0 0
> -				f000 0 0 3 4d0 0 0
> -				f000 0 0 4 4d0 0 0
> +				f000 0 0 1 &i8259 c 2
> +				f000 0 0 2 &i8259 0 0
> +				f000 0 0 3 &i8259 0 0
> +				f000 0 0 4 &i8259 0 0
> 
>  				/* IDSEL 0x1f */
> -				f800 0 0 1 4d0 6 2
> -				f800 0 0 2 4d0 0 0
> -				f800 0 0 3 4d0 0 0
> -				f800 0 0 4 4d0 0 0
> +				f800 0 0 1 &i8259 6 2
> +				f800 0 0 2 &i8259 0 0
> +				f800 0 0 3 &i8259 0 0
> +				f800 0 0 4 &i8259 0 0
>  				>;
> -			i8259@4d0 {
> -				linux,phandle = <4d0>;
> +			i8259: i8259@4d0 {
>  				clock-frequency = <0>;
>  				interrupt-controller;
>  				device_type = "interrupt-controller";
> @@ -302,12 +296,11 @@
>  				compatible = "chrp,iic";
>                  	        big-endian;
>  				interrupts = <49 2>;
> -				interrupt-parent = <40000>;
> +				interrupt-parent = <&mpic>;
>  			};
> 
>  		};
> -		pic@40000 {
> -			linux,phandle = <40000>;
> +		mpic: pic@40000 {
>  			clock-frequency = <0>;
>  			interrupt-controller;
>  			#address-cells = <0>;
> @@ -316,23 +309,7 @@
>  			built-in;
>  			compatible = "chrp,open-pic";
>  			device_type = "open-pic";
> -                        big-endian;
> -			interrupts = <
> -				10 2 11 2 12 2 13 2
> -				14 2 15 2 16 2 17 2
> -				18 2 19 2 1a 2 1b 2
> -				1c 2 1d 2 1e 2 1f 2
> -				20 2 21 2 22 2 23 2
> -				24 2 25 2 26 2 27 2
> -				28 2 29 2 2a 2 2b 2
> -				2c 2 2d 2 2e 2 2f 2
> -				30 2 31 2 32 2 33 2
> -				34 2 35 2 36 2 37 2
> -				38 2 39 2 2a 2 3b 2
> -				3c 2 3d 2 3e 2 3f 2
> -				48 1 49 2 4a 1
> -				>;
> -			interrupt-parent = <40000>;
> +			big-endian;
>  		};
>  	};
>  };
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
