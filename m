Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 33B1ADE087
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 03:33:27 +1000 (EST)
Message-ID: <4713A474.1000301@ru.mvista.com>
Date: Mon, 15 Oct 2007 21:33:40 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH v2 2/2] [POWERPC] MPC8568E-MDS: add support for flash
References: <20071015155730.GA30008@localhost.localdomain>
	<20071015161631.GB30512@localhost.localdomain>
In-Reply-To: <20071015161631.GB30512@localhost.localdomain>
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

> MPC8568E-MDS have 1 32MB Spansion x16 CFI flash chip. Let's use it.

> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

> diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
> index 8e15dba..1198363 100644
> --- a/arch/powerpc/boot/dts/mpc8568mds.dts
> +++ b/arch/powerpc/boot/dts/mpc8568mds.dts
> @@ -47,12 +47,45 @@
>  		#address-cells = <2>;
>  		#size-cells = <1>;
>  		reg = <e0005000 d8>;
> -		ranges = <1 0 f8000000 0008000>;
> +		ranges = <1 0 f8000000 0008000
> +			  0 0 fe000000 2000000>;
>  
>  		bcsr@1,0 {
>  			device_type = "board-control";
>  			reg = <1 0 8000>;
>  		};
> +
> +		flash@0,0 {
> +			compatible = "Spansion,S29GL256N11TFIV2O", "cfi-flash";
> +			reg = <0 0 2000000>;
> +			probe-type = "CFI";

    I don't get it -- has physmap_of.c rewrite been already committed?
If yes, you don't need probe_type; if no, your "compatible" won't work...
Well, I see that the driver rewrite has been committed (when I wasn't looking 
8-)...

> +			bank-width = <2>;
> +			device-width = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			hrcw@0 {
> +				label = "hrcw";
> +				reg = <0 20001>;

    What?! Odd sized partition? Don't try to follow both the old and new 
partition device tree specs -- you'll only get yourself into trouble with 
this.  The size-cell doesn't bear r/o flag in the new paritions spec.

> +				read-only;
> +			};
> +
> +			kernel@20000 {
> +				label = "kernel";
> +				reg = <20000 200000>;
> +			};
> +
> +			rootfs@220000 {
> +				label = "rootfs";
> +				reg = <220000 1d60000>;
> +			};
> +
> +			uboot@1f80000 {
> +				label = "u-boot";
> +				reg = <1f80000 80000>;
> +				read-only;

    Well, this is not even consistent... :-)

> +			};
> +		};
>  	};

WBR, Sergei
