Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0141.outbound.protection.outlook.com [157.56.110.141])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BA3D1A0287
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 12:50:14 +1100 (AEDT)
Message-ID: <1416966592.15957.172.camel@freescale.com>
Subject: Re: [PATCH] [v2] power/fsl: add MDIO dt binding for FMan
From: Scott Wood <scottwood@freescale.com>
To: <shh.xie@gmail.com>
Date: Tue, 25 Nov 2014 19:49:52 -0600
In-Reply-To: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
References: <1415958800-9867-1-git-send-email-shh.xie@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Emilian.Medve@freescale.com,
 Igal.Liberman@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-11-14 at 17:53 +0800, shh.xie@gmail.com wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
> 
> This binding is for FMan MDIO, it covers FMan v2 & FMan v3.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> changes in V2:
> addressed comments from Scott in V1.
> 
>  .../devicetree/bindings/powerpc/fsl/fman.txt       | 69 ++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> index edeea16..1523a87 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> @@ -7,6 +7,7 @@ CONTENTS
>    - FMan MURAM Node
>    - FMan dTSEC/XGEC/mEMAC Node
>    - FMan IEEE 1588 Node
> +  - FMan MDIO Node
>    - Example
>  
>  =============================================================================
> @@ -357,6 +358,68 @@ ptp-timer@fe000 {
>  };
>  
>  =============================================================================
> +FMan MDIO Node
> +
> +DESCRIPTION
> +
> +The MDIO is a bus to which the PHY devices are connected.
> +
> +PROPERTIES
> +
> +- compatible
> +		Usage: required
> +		Value type: <stringlist>
> +		Definition: A standard property.
> +		Must include "fsl,fman-mdio" for 1 Gb/s MDIO from FMan v2.
> +		Must include "fsl,fman-xmdio" for 10 Gb/s MDIO from FMan v2.
> +		Must include "fsl,fman-memac-mdio" for 1/10 Gb/s MDIO from
> +		FMan v3.
> +
> +- reg
> +		Usage: required
> +		Value type: <prop-encoded-array>
> +		Definition: A standard property.
> +
> +- bus-frequency
> +		Usage: optional
> +		Value type: <u32>
> +		Definition: Specifies external MDIO bus clock speed which is
> +		different from MDIO standard 2.5MHz. Should be defined for SoCs
> +		on which the standard one cannot work.
> +
> +- interrupts
> +		Usage: optional
> +		Value type: <prop-encoded-array>
> +		Definition: Event interrupt of external MDIO controller.
> +		1 Gb/s MDIO and 10 Gb/s MDIO has one interrupt respectively.
> +
> +- fsl,fman-internal-mdio
> +		Usage: required for internal MDIO
> +		Value type: boolean
> +		Definition: Fman has internal MDIO for internal PCS(Physical
> +		Coding Sublayer) PHYs and external MDIO for external PHYs.
> +		The settings and programming routines for internal/external
> +		MDIO are different. Must be included for internal MDIO.
> +
> +EXAMPLE
> +
> +Example for FMan v2 external MDIO:
> +
> +mdio@f1000 {
> +	compatible = "fsl,fman-xmdio";
> +	reg = <0xf1000 0x1000>;
> +	bus-frequency = <20000>;
> +};

So the bus frequency is only 20 KHz?  Or is the unit supposed to be
something other than Hz?

-Scott
