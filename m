Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C68D9DE06F
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jul 2007 04:57:14 +1000 (EST)
Message-ID: <468FE27F.4090105@ru.mvista.com>
Date: Sat, 07 Jul 2007 22:59:11 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH 2/5] Add legacy devices to mpc8641_hpcn.dts
References: <1179245829.8132.100.camel@rhino> <1179246470.8132.112.camel@rhino>
In-Reply-To: <1179246470.8132.112.camel@rhino>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wade Farnsworth wrote:
> This adds device nodes for the ISA devices on the MPC8641 HPCN to the
> dts.  Additionally, it moves the node for the i8259 to the isa bus,
> since the i8259 is actually on that bus.

> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

    Sorry for the belated comments... :-<

> Index: linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> ===================================================================
> --- linux-2.6-8641.orig/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ linux-2.6-8641/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -285,17 +285,45 @@
>  				f800 0 0 3 &i8259 0 0
>  				f800 0 0 4 &i8259 0 0
>  				>;
> -			i8259: i8259@4d0 {
> -				clock-frequency = <0>;
> -				interrupt-controller;
> -				device_type = "interrupt-controller";
> -				#address-cells = <0>;
> +
> +			isa@f0 {
> +				device_type = "isa";
>  				#interrupt-cells = <2>;
> -				built-in;
> -				compatible = "chrp,iic";
> -                	        big-endian;
> -				interrupts = <49 2>;
> -				interrupt-parent = <&mpic>;
> +				#size-cells = <1>;
> +				#address-cells = <2>;
> +				reg = <f000 0 0 0 0>;
> +				ranges = <1 0 01000000 0 0 00001000>;
> +				interrupt-parent = <4d0>;
> +
> +				8042@60 {
> +					device_type = "8042";
> +					reg = <1 60 1 1 64 1>;

    What does that leading 1 in the address signify?

> +					interrupts = <1 3 c 3>;
> +					interrupt-parent = <4d0>;
> +				};
> +
> +				rtc@70 {
> +					device_type = "rtc";
> +					reg = <1 70 2>;
> +				};
> +
> +				gpio@400 {
> +					device_type = "gpio";
> +					reg = <1 400 80>;
> +				};
> +
> +				i8259: i8259@4d0 {
> +					clock-frequency = <0>;

    I don't think it's at all applicable here.

> +					interrupt-controller;
> +					device_type = "interrupt-controller";
> +					#address-cells = <0>;
> +					#interrupt-cells = <2>;
> +					built-in;
> +					compatible = "chrp,iic";
> +                	        	big-endian;

    Really?

> +					interrupts = <49 2>;
> +					interrupt-parent = <&mpic>;
> +				};

    The "reg" property is missing here. And "reserved-interrupts" accordig to:

http://playground.sun.com/1275/bindings/devices/html/isa-pic-1_1d.html

    BTW, I've found the offisial 8042 binding is here:

http://playground.sun.com/1275/bindings/devices/html/8042.html

WBR, Sergei
