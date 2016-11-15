Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHwDk54DTzDvYF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 16:00:06 +1100 (AEDT)
Message-ID: <1479185995.21746.10.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Florian Larysch <fl@n621.de>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Mon, 14 Nov 2016 22:59:55 -0600
In-Reply-To: <20161114122805.11376-1-fl@n621.de>
References: <20161114122805.11376-1-fl@n621.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] T4240RBD: add device tree entry for W83793
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-11-14 at 13:28 +0100, Florian Larysch wrote:
> The T4240RDB contains a W83793 hardware monitoring chip. Add a device
> tree entry to make the driver attach to it, as the i2c-mpc bus driver
> dropped support for class-based instantiation of devices a long time
> ago.
> 
> Signed-off-by: Florian Larysch <fl@n621.de>
> ---
>  arch/powerpc/boot/dts/fsl/t4240rdb.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> index cc0a264..b35eea1 100644
> --- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> +++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
> @@ -142,6 +142,10 @@
>  				reg = <0x68>;
>  				interrupts = <0x1 0x1 0 0>;
>  			};
> +			hwmon@2f {
> +				compatible = "winbond,w83793";
> +				reg = <0x2f>;
> +			};
>  		};
>  
>  		sdhc@114000 {

Please (in a separate patch) add this to
Documentation/devicetree/bindings/i2c/trivial-devices.txt and CC\
devicetree@vger.kernel.org

Also, please keep the i2c nodes sorted by address.

-Scott
