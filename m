Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 742D11A0E67
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 05:34:42 +1100 (AEDT)
Date: Tue, 29 Dec 2015 12:34:36 -0600
From: Rob Herring <robh@kernel.org>
To: shh.xie@gmail.com
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 scottwood@freescale.com, igal.liberman@freescale.com,
 Shaohui Xie <Shaohui.Xie@freescale.com>
Subject: Re: [PATCH] powerpc: fsl: update fman dt binding for PCS PHY
Message-ID: <20151229183436.GB12450@rob-hp-laptop>
References: <1451274454-26091-1-git-send-email-shh.xie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1451274454-26091-1-git-send-email-shh.xie@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 28, 2015 at 11:47:34AM +0800, shh.xie@gmail.com wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
> 
> PCS PHY can support backplane (1000BASE-KX and 10GBASE-KR), this needs
> to change corresponding serdes lane settings, so a reference is needed
> for serdes lane. This patch describes properties needed for PCS PHY to
> support backplane.
> 
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> ---
> based on: http://patchwork.ozlabs.org/patch/560936/
> 
>  Documentation/devicetree/bindings/powerpc/fsl/fman.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> index 55c2c03..b38e727 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> @@ -432,6 +432,16 @@ example of how to define a PHY (Internal PHY has no interrupt line).
>  - For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY.
>  - For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is PCS PHY,
>    PCS PHY addr must be '0'.
> +  PCS PHY can support backplane (1000BASE-KX and 10GBASE-KR), this needs to
> +  change the corresponding serdes lane settings.
> +
> +  PCS PHY node properties required for backplane:
> +
> +  - compatible: must be "ethernet-phy-ieee802.3-c45".
> +  - phy-mode: string, operation mode of the PHY interface; must be "1000base-kx"
> +    for 1000BASE-KX, or "10gbase-kr" for 10GBASE-KR.

Seems like these should be in common ethernet phy binding.

> +  - lane-handle: phandle, specifies a reference to a node representing a Serdes.
> +  - lane-range: offset and length of the register set for the serdes lane.

These seem pretty FSL specific, so add vendor prefix.

Rob
