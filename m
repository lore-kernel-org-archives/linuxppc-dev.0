Return-Path: <sshtylyov@mvista.com>
Received: from mail-bw0-f42.google.com (mail-bw0-f42.google.com
	[209.85.214.42]) by ozlabs.org (Postfix) with ESMTP id DE95BB6EFE
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 20:11:27 +1000 (EST)
Received: by bwz19 with SMTP id 19so304107bwz.15
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 03:11:25 -0700 (PDT)
Message-ID: <4C2B180F.9040701@ru.mvista.com>
Date: Wed, 30 Jun 2010 14:10:23 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Fushen Chen <fchen@apm.com>
Subject: Re: [PATCH 1/9] Add Synopsys DesignWare HS USB OTG Controller driver.
References: <12778468223309-git-send-email-fchen@apm.com>
In-Reply-To: <12778468223309-git-send-email-fchen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org,
	Mark Miesfeld <mmiesfeld@apm.com>, gregkh@suse.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

Fushen Chen wrote:

> The DWC OTG driver module provides the initialization and cleanup
> entry points for the DWC OTG USB driver.

> Signed-off-by: Fushen Chen <fchen@apm.com>
> Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
[...]
> diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
> index 083e68e..1a141b8 100644
> --- a/arch/powerpc/boot/dts/kilauea.dts
> +++ b/arch/powerpc/boot/dts/kilauea.dts
> @@ -394,5 +394,20 @@
>  				0x0 0x0 0x0 0x3 &UIC2 0xd 0x4 /* swizzled int C */
>  				0x0 0x0 0x0 0x4 &UIC2 0xe 0x4 /* swizzled int D */>;
>  		};
> +
> +		USBOTG0: usbotg@ef6c0000 {
> +			compatible = "amcc,dwc-otg";
> +			reg = <0xef6c0000 0x10000>;
> +			interrupt-parent = <&USBOTG0>;
> +			interrupts = <0x0 0x1 0x2>;
> +			#interrupt-cells = <0x1>;
> +			#address-cells = <0x0>;
> +			#size-cells = <0x0>;
> +			interrupt-map = <
> +				0x0 &UIC2 0x1e 0x4 /* USB-OTG */
> +				0x1 &UIC1 0x1a 0x8 /* HIGH-POWER */
> +				0x2 &UIC0 0xc 0x4  /* DMA */ >;
> +			interrupt-map-mask = <0xffffffff>;
> +		};
>  	};
>  };

    Please put this file in a separate patch and push thru the PowerPC tree.

WBR, Sergei
