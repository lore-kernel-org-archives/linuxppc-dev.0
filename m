Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgKBh4SRyzDq65
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 07:49:48 +1000 (AEST)
Message-ID: <1459979380.32510.75.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Valentin Longchamp <valentin.longchamp@keymile.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 06 Apr 2016 16:49:40 -0500
In-Reply-To: <1459949825-10533-1-git-send-email-valentin.longchamp@keymile.com>
References: <1459949825-10533-1-git-send-email-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc: define the fman node for the kmcoge4 DTS
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-06 at 15:37 +0200, Valentin Longchamp wrote:
> Now that the FMAN mac driver has been merged the fman node is relevant.
> 
> The kmcoge4 board implements 3 ethernet interfaces, 1 with a RGMII phy
> and 2 with fixed 1 Giga SGMII links.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> ---
>  arch/powerpc/boot/dts/fsl/kmcoge4.dts | 39
> +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
> b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
> index 6858ec9..1cec66d 100644
> --- a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
> +++ b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
> @@ -106,6 +106,45 @@
>  		sata@221000 {
>  			status = "disabled";
>  		};
> +
> +		fman0: fman@400000 {
> +			enet0: ethernet@e0000 {
> +				phy-connection-type = "sgmii";
> +				local-mac-address = [00 11 22 33 44 55];
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};
> +			mdio0: mdio@e1120 {
> +				front_phy: ethernet-phy@11 {
> +					reg = <0x11>;
> +				};
> +			};
> +
> +			enet1: ethernet@e2000 {
> +				phy-connection-type = "sgmii";
> +				local-mac-address = [00 11 22 33 44 56];
> +				fixed-link {
> +					speed = <1000>;
> +					full-duplex;
> +				};
> +			};

No hardcoded MAC addresses.

-Scott
