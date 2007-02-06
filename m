Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8703CDDE45
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 03:21:05 +1100 (EST)
In-Reply-To: <45C844CA.8070102@freescale.com>
References: <45C844CA.8070102@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <90D7EDC8-9E73-4006-8B0E-01D455C18BEC@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] DTS updates for 8349emds USB peripheral support
Date: Tue, 6 Feb 2007 10:20:07 -0600
To: Li Yang <leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 3:05 AM, Li Yang wrote:

> Add new dr_mode property to USB node, and update default
> dts for 8439emds.
>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> Documentation/powerpc/booting-without-of.txt |    3 +++
> arch/powerpc/boot/dts/mpc8349emds.dts        |    6 ++++++
> 2 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 3399427..962034a 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1334,6 +1334,8 @@ platforms are moved over to use the flattened- 
> device-tree model.
>       fsl-usb2-mph compatible controllers.  Either this property or
>       "port0" (or both) must be defined for "fsl-usb2-mph"  
> compatible       controllers.
> +    - dr_mode : indicates the working mode of DR module. Can be  
> "host",
> +      "peripheral" or "otg".

Add details about what it means if dr_mode is not set for 'fsl-usb2- 
dr'.  Also some details about dr_mode being invalid/ignored for 'fsl- 
usb2-mph'

>    Recommended properties :
>     - interrupts : <a b> where a is the interrupt number and b is a
> @@ -1367,6 +1369,7 @@ platforms are moved over to use the flattened- 
> device-tree model.
> 		#size-cells = <0>;
> 		interrupt-parent = <700>;
> 		interrupts = <26 1>;
> +		dr_mode = "otg";
> 		phy = "ulpi";
> 	};
> diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/ 
> boot/dts/mpc8349emds.dts
> index efceb34..dc121b3 100644
> --- a/arch/powerpc/boot/dts/mpc8349emds.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emds.dts
> @@ -39,6 +39,11 @@
> 		reg = <00000000 10000000>;	// 256MB at 0
> 	};
> +	bcsr@e2400000 {
> +		device_type = "board-control";
> +		reg = <e2400000 8000>;
> +	};
> +
> 	soc8349@e0000000 {
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> @@ -103,6 +108,7 @@
> 			#size-cells = <0>;
> 			interrupt-parent = <700>;
> 			interrupts = <26 2>;
> +			dr_mode = "otg";
> 			phy_type = "ulpi";
> 		};
