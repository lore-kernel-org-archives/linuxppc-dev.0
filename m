Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0145.outbound.protection.outlook.com [207.46.163.145])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B13132C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Mar 2014 05:36:58 +1100 (EST)
Message-ID: <1394649402.13761.149.camel@snotra.buserror.net>
Subject: Re: [PATCH] T1040RDB: add qe node for T1040RDB dts
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Date: Wed, 12 Mar 2014 13:36:42 -0500
In-Reply-To: <1394612762-36308-1-git-send-email-B45475@freescale.com>
References: <1394612762-36308-1-git-send-email-B45475@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 16:26 +0800, Zhao Qiang wrote:
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
>  arch/powerpc/boot/dts/t1040rdb.dts | 43 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/t1040rdb.dts b/arch/powerpc/boot/dts/t1040rdb.dts
> index e2eee18..6ff0412 100644
> --- a/arch/powerpc/boot/dts/t1040rdb.dts
> +++ b/arch/powerpc/boot/dts/t1040rdb.dts
> @@ -268,6 +268,49 @@
>  			fsl,fman-mac = <&enet4>;
>  		};
>  	};
> +
> +	qe: qe@ffe139999 {
> +		ranges = <0x0 0xf 0xfe140000 0x40000>;
> +		reg = <0xf 0xfe140000 0 0x480>;

reg does not match unit address

Missing compatible

> +		si1: si@700 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "fsl,qe-si";
> +			reg = <0x700 0x80>;
> +		};

Missing binding

> +
> +		siram1: siram@1000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,qe-siram";
> +			reg = <0x1000 0x800>;
> +		};

Missing binding

> +
> +		tdma: ucc@2000 {
> +			compatible = "fsl,ucc-tdm";
> +			rx-clock-name = "clk3";
> +			tx-clock-name = "clk4";
> +			fsl,rx-sync-clock = "rsync_pin";
> +			fsl,tx-sync-clock = "tsync_pin";
> +			fsl,tx-timeslot = <0xfffffffe>;
> +			fsl,rx-timeslot = <0xfffffffe>;
> +			fsl,tdm-framer-type = "e1";
> +			fsl,tdm-mode = "normal";
> +			fsl,tdm-id = <0>;
> +			fsl,siram-entry-id = <0>;
> +		};

Missing binding

> +		serial: ucc@2200 {
> +			device_type = "serial";
> +			compatible = "ucc_uart";
> +			port-number = <1>;
> +			rx-clock-name = "brg2";
> +			tx-clock-name = "brg2";
> +		};

Missing binding

-Scott
