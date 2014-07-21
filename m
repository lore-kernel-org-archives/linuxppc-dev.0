Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 04C571A01E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 08:46:08 +1000 (EST)
Message-ID: <1405982754.29414.33.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 5/7] powerpc/corenet: Add MDIO bus muxing support to
 the board device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Shruti Kanetkar <Shruti@Freescale.com>
Date: Mon, 21 Jul 2014 17:45:54 -0500
In-Reply-To: <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <1405541831-1277-5-git-send-email-Shruti@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-07-16 at 15:17 -0500, Shruti Kanetkar wrote:
> Based on prior work by Andy Fleming <afleming@gmail.com>
> 
> Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
> ---

What changed from v2?

> +			mdio@fc000 {
> +				phy_sgmii_1e: ethernet-phy@1e {
> +						status = "disabled";
> +						reg = <0x1e>;
> +				};

Whitespace

> +				phy_sgmii_1f: ethernet-phy@1f {
> +					status = "disabled";
> +					reg = <0x1f>;
> +				};
> +			};
> +
> +			mdio@fd000 {
> +				/* For 10g interfaces */
> +				phy_xaui_slot1: xaui-phy@slot1 {
> +					status = "disabled";
> +					compatible = "ethernet-phy-ieee802.3-c45";
> +					reg = <0x7>; /* default switch setting on slot1 of AMC2PEX */
> +				};

Why xaui-phy and not ethernet-phy?

As for the device_type discussion from v1, there is a generic binding
that says device_type "should" be ethernet-phy.  BTW, that binding
(net/phy.txt) could use some cleaning up -- it still has references to
things like linux,phandle.

> diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
> index 8b47edc..6188583 100644
> --- a/arch/powerpc/boot/dts/b4qds.dtsi
> +++ b/arch/powerpc/boot/dts/b4qds.dtsi
> @@ -39,6 +39,13 @@
>  	#size-cells = <2>;
>  	interrupt-parent = <&mpic>;
>  
> +	aliases {
> +		phy_sgmii_10 = &phy_sgmii_10;
> +		phy_sgmii_11 = &phy_sgmii_11;
> +		phy_sgmii_1c = &phy_sgmii_1c;
> +		phy_sgmii_1d = &phy_sgmii_1d;
> +	};

Is the encoding of these alias strings considered ABI (for either the
OS's use or U-Boot's)?  If so, please document it.  If not, how do you
see this being used?  What does the hex number mean from the user's
perspective?

> +			mdio0: mdio@fc000 {
> +			};

Why is the empty node needed?

-Scott
