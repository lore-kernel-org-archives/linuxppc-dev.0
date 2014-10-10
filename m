Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0144.outbound.protection.outlook.com [157.56.111.144])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ED2A1A0AB1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Oct 2014 05:08:46 +1100 (EST)
Message-ID: <1412964511.13320.606.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/3] ls1021a-twr/qe: add qe node to ls1-twr
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Fri, 10 Oct 2014 13:08:31 -0500
In-Reply-To: <1412923798-9757-1-git-send-email-B45475@freescale.com>
References: <1412923798-9757-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, R63061@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-10-10 at 14:49 +0800, Zhao Qiang wrote:
> add qe node to ls1021atwr fdt.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  arch/arm/boot/dts/ls1021a-twr.dts | 24 +++++++++++++++
>  arch/arm/boot/dts/ls1021a.dtsi    | 64 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/ls1021a-twr.dts b/arch/arm/boot/dts/ls1021a-twr.dts
> index a52be7b..415387f 100755
> --- a/arch/arm/boot/dts/ls1021a-twr.dts
> +++ b/arch/arm/boot/dts/ls1021a-twr.dts
> @@ -164,6 +164,30 @@
>  	};
>  };
>  
> +&uqe {
> +	tdma: ucc@2000 {
> +		compatible = "fsl,ucc-tdm";

Binding?

> +		rx-clock-name = "clk8";
> +		tx-clock-name = "clk9";
> +		fsl,rx-sync-clock = "rsync_pin";
> +		fsl,tx-sync-clock = "tsync_pin";
> +		fsl,tx-timeslot = <0xfffffffe>;
> +		fsl,rx-timeslot = <0xfffffffe>;
> +		fsl,tdm-framer-type = "e1";
> +		fsl,tdm-mode = "normal";
> +		fsl,tdm-id = <0>;
> +		fsl,siram-entry-id = <0>;
> +	};
> +
> +	serial: ucc@2200 {
> +		device_type = "serial";
> +		compatible = "ucc_uart";
> +		port-number = <1>;
> +		rx-clock-name = "brg2";
> +		tx-clock-name = "brg2";
> +	};

Binding for ucc_uart?  Why device_type?

> +};
> +
>  &pwm6 {
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index 80747dc..3f2ab89 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -314,6 +314,70 @@
>  			status = "disabled";
>  		};
>  
> +		uqe: uqe@2400000 {

How does "uqe" differ from "qe"?

-Scott
