Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0113.outbound.protection.outlook.com [157.56.111.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6CF61A0BFD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Dec 2015 08:43:16 +1100 (AEDT)
Message-ID: <1450820578.18314.94.camel@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: Update fman dt binding with pcs-phy and
 tbi-phy
From: Scott Wood <scottwood@freescale.com>
To: <igal.liberman@freescale.com>, <devicetree@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
CC: <madalin.bucur@freescale.com>, <shaohui.xie@freescale.com>
Date: Tue, 22 Dec 2015 15:42:58 -0600
In-Reply-To: <1450757888-14216-1-git-send-email-igal.liberman@freescale.com>
References: <1450757888-14216-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-12-22 at 06:18 +0200, igal.liberman@freescale.com wrote:
> From: Igal Liberman <igal.liberman@freescale.com>
> 
> Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/fman.txt       |   39
> ++++++++++++++++++++
>  1 file changed, 39 insertions(+)

Some description in the log would be nice, especially why it can't use phy
-handle

> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> index 1fc5328..7a6d7c3 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> @@ -315,6 +315,16 @@ PROPERTIES
>  		Value type: <phandle>
>  		Definition: A phandle for 1EEE1588 timer.
>  
> +- pcsphy-handle
> +		Usage required for "fsl,fman-memac" MACs
> +		Value type: <phandle>
> +		Definition: A phandle for pcsphy.
> +
> +- tbi-handle
> +		Usage required for "fsl,fman-dtsec" MACs
> +		Value type: <phandle>
> +		Definition: A phandle for tbiphy.
> +
>  EXAMPLE
>  
>  fman1_tx28: port@a8000 {
> @@ -340,6 +350,7 @@ ethernet@e0000 {
>  	reg = <0xe0000 0x1000>;
>  	fsl,fman-ports = <&fman1_rx8 &fman1_tx28>;
>  	ptp-timer = <&ptp-timer>;
> +	tbi-handle = <&tbi0>;
>  };
>  
>  ===========================================================================
> =
> @@ -415,6 +426,13 @@ PROPERTIES
>  		The settings and programming routines for internal/external
>  		MDIO are different. Must be included for internal MDIO.
>  
> +For internal PHY device on internal mdio bus, a PHY node should be created.
> +See the definition of the PHY node in booting-without-of.txt for an
> +example of how to define a PHY (Internal PHY has no interrupt line).
> +- For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY.
> +- For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is PCS
> PHY,
> +  PCS PHY addr must be '0'.
> +
>  EXAMPLE
>  
>  Example for FMan v2 external MDIO:
> @@ -425,12 +443,28 @@ mdio@f1000 {
>  	interrupts = <101 2 0 0>;
>  };
>  
> +Example for FMan v2 internal MDIO:
> +
> +mdio@e3120 {
> +	compatible = "fsl,fman-mdio";
> +	reg = <0xe3120 0xee0>;
> +	fsl,fman-internal-mdio;
> +
> +	tbi1: tbi-phy@8 {
> +		reg = <0x8>;
> +		device_type = "tbi-phy";
> +	};
> +};
> +
>  Example for FMan v3 internal MDIO:
>  
>  mdio@f1000 {
>  	compatible = "fsl,fman-memac-mdio";
>  	reg = <0xf1000 0x1000>;
>  	fsl,fman-internal-mdio;
> +
> +	pcsphy6: ethernet-phy@0 {
> +		reg = <0x0>;
>  };

missing }

-Scott
