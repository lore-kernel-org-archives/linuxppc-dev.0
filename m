Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 06DC167A5E
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 04:26:09 +1000 (EST)
Message-ID: <44E75801.1030606@ru.mvista.com>
Date: Sat, 19 Aug 2006 22:27:13 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Add 85xx DTS files to powerpc
References: <Pine.LNX.4.61.0608181803160.2878@ld0175-tx32.am.freescale.net>
In-Reply-To: <Pine.LNX.4.61.0608181803160.2878@ld0175-tx32.am.freescale.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Andy Fleming wrote:
> Added the mpc85xx family of dts files to the powerpc tree
> ---
>  arch/powerpc/boot/dts/mpc8540ads.dts |  257 ++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8541cds.dts |  244 +++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8548cds.dts |  287 ++++++++++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/mpc8555cds.dts |  244 +++++++++++++++++++++++++++++
>  4 files changed, 1032 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
> new file mode 100644
> index 0000000..93d2c2d
> --- /dev/null
> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts

[...]

> +			ethernet-phy@2 {
> +				linux,phandle = <2452002>;
> +				interrupt-parent = <40000>;
> +				interrupts = <37 1>;
> +				reg = <2>;
> +				device_type = "ethernet-phy";
> +			};

    Well, there's PHYs #2 and #3 on the board, #2 is probably not tied to
anything though.

> +		ethernet@26000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			device_type = "network";
> +			model = "TSEC";
> +			compatible = "gianfar";
> +			reg = <26000 1000>;
> +			address = [ 00 E0 0C 00 73 02 ];
> +			local-mac-address = [ 00 E0 0C 00 73 02 ];
> +			interrupts = <19 2>;
> +			interrupt-parent = <40000>;
> +			phy-handle = <2452002>;
> +		};

    Shouldn't it be "FEC" instead? The third controller is actually Fast
Ethernet and fsl_soc.c differs TSEC and FEC WRT the interrupts (FEC has only
one). So, this entry looks incorrect...

> +		pic@40000 {
> +			linux,phandle = <40000>;
> +			clock-frequency = <0>;
> +			interrupt-controller;
> +			#address-cells = <0>;
> +			#interrupt-cells = <2>;
> +			reg = <40000 40000>;
> +			built-in;
> +			compatible = "chrp,open-pic";
> +			device_type = "open-pic";
> +                        big-endian;

    Spaces instead of tabs in this line...

> +		};
> +	};
> +};

WBR, Sergei
