Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qTNpn404LzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 04:58:09 +1100 (AEDT)
Message-ID: <1458583080.19333.11.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Nora =?ISO-8859-1?Q?Bj=F6rklund?= <nora.bjorklund@enea.com>,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Date: Mon, 21 Mar 2016 12:58:00 -0500
In-Reply-To: <1458557331-59540-1-git-send-email-nora.bjorklund@enea.com>
References: <1458557331-59540-1-git-send-email-nora.bjorklund@enea.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc:dts:p2041rdb: enable gpio-expander
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-03-21 at 11:48 +0100, Nora Björklund wrote:
> Enable the gpio-expander pca9672 on p2041rdb. The expander
> has been present on the p2041rdb all along, however not in
> the device tree.
> 
> Signed-off-by: Nora Björklund <nora.bjorklund@enea.com>
> ---
>  arch/powerpc/boot/dts/fsl/p2041rdb.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/p2041rdb.dts
> b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
> index e9bd894..b1ee561 100644
> --- a/arch/powerpc/boot/dts/fsl/p2041rdb.dts
> +++ b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
> @@ -134,6 +134,13 @@
>  			};
>  		};
>  
> +		i2c@119100 {
> +			gpio@22 {
> +				compatible = "pcf8575";
> +				reg = <0x22>;
> +			};
> +		};

The compatible should be "nxp,pcf8575" and it needs the gpio-controller and
#gpio-cells properties.

Is there an interrupt line connected to it?

See Documentation/devicetree/bindings/gpio/gpio-pcf857x.txt

-Scott
