Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 066BB1A0E68
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 03:27:39 +1100 (AEDT)
Date: Wed, 30 Dec 2015 10:27:33 -0600
From: Rob Herring <robh@kernel.org>
To: igal.liberman@freescale.com
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 scottwood@freescale.com, madalin.bucur@freescale.com,
 shaohui.xie@freescale.com
Subject: Re: [v2] powerpc/fsl: Update fman dt binding with pcs-phy and tbi-phy
Message-ID: <20151230162733.GA2518@rob-hp-laptop>
References: <1450921331-25309-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450921331-25309-1-git-send-email-igal.liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 24, 2015 at 03:42:11AM +0200, igal.liberman@freescale.com wrote:
> From: Igal Liberman <igal.liberman@freescale.com>
> 
> The FMan contains internal PHY devices used for SGMII connections
> to external PHYs. When these PHYs are in use a reference is needed
> for both the external PHY and the internal one. For the external
> PHY phy-handle provides the reference. For the internal PHY a new
> handle is required.
> In dTSEC, the internal PHY is a TBI (Ten Bit Interface) PHY,
> the handle used will be tbi-handle.
> In mEMAC, the internal PHY is a PCS (Physical Coding Sublayer) PHY,
> the handle used will be pcsphy-handle.

This is fairly commom for 10G eth I think. Can't you use the common PHY 
binding here in the case without internal MDIO bus? Just because you use 
it that doesn't mean you have to use the generic phy subsystem in the 
kernel. 

Perhaps phy-handle should be deprecated in favor of doing something like 
this if you need a phandle to both:

phys = <&internal-phy>, <&external-phy>;

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> index 1fc5328..55c2c03 100644
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

What does the tbi0 node contain? It should be present in the example.

Rob
