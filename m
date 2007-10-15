Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 95FCFDE728
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 01:42:01 +1000 (EST)
Message-ID: <47138A54.8030307@ru.mvista.com>
Date: Mon, 15 Oct 2007 19:42:12 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] [RFC][POWERPC] MPC8568E-MDS: create localbus node
References: <20071015153525.GA28761@localhost.localdomain>
In-Reply-To: <20071015153525.GA28761@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> This patch creates localbus node, moves bcsr into it, and adds
> localbus to the probe path.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
> index 5439437..296adc3 100644
> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
> @@ -42,9 +42,17 @@
>  		reg = <00000000 10000000>;
>  	};
>  
> -	bcsr@f8000000 {
> -		device_type = "board-control";
> -		reg = <f8000000 8000>;
> +	localbus@f0000000 {
> +		compatible = "fsl,mpc8568mds-localbus";

    Is the entity described as "localbus" indeed so *board* specific?

> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		reg = <f0000000 10000000>;
> +		ranges = <0 0 f8000000 0008000>;

    Isn't that range a part of "reg"?

> +
> +		bcsr@0,0 {
> +			device_type = "board-control";
> +			reg = <0 0 8000>;
> +		};
>  	};
>  
>  	soc8568@e0000000 {

WBR, Sergei
