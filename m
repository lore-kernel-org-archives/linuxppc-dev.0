Return-Path: <swarren@wwwdotorg.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org
 [IPv6:2001:470:1f0f:bd7::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9C43F2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:40:51 +1000 (EST)
Message-ID: <521541EE.4010303@wwwdotorg.org>
Date: Wed, 21 Aug 2013 16:40:46 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v7 2/3] DMA: Freescale: Add new 8-channel DMA engine device
 tree nodes
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-3-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1375094944-3343-3-git-send-email-hongbo.zhang@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com,
 linux-kernel@vger.kernel.org, djbw@fb.com, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/29/2013 04:49 AM, hongbo.zhang@freescale.com wrote:
> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch adds
> the device tree nodes for them.

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt

> +** Freescale Elo3 DMA Controller
> +   This is EloPlus controller with 8 channels, used in Freescale Txxx and Bxxx
> +   series chips, such as t1040, t4240, b4860.
> +
> +Required properties:
> +
> +- compatible        : must include "fsl,elo3-dma"

This should probably list all the SoC-specific compatible values too.

> +- ranges            : describes the mapping between the address space of the
> +                      DMA channels and the address space of the DMA controller

Oh, so looking at the example, this is simply about being able to write
the reg value in the child nodes more easily without having to write out
the full based address of the controller in each child node.

I don't think the binding document should require this; all the binding
document should care about is that the child nodes have a valid reg
value. Whether that reg value is <0x100100 0x80> without a ranges in the
top-level DMA nor or whether that reg value is <0x0 0x80> with a ranges
value in the top-level DMA node isn't something that the binding should
specify. Either way will work equally without affecting a driver for the
DMA controller; the parsing of reg with/without a ranges property is
more of a core part of DT than anything to do with this binding.

> +- DMA channel nodes:
> +        - compatible        : must include "fsl,eloplus-dma-channel"

Why do the channel nodes even need a compatible value? Presumably the
driver for the top-level DMA node will scan these dma-channel nodes to
extract the information it needs and will simply assume that all these
nodes are DMA channel nodes rather than something else? I suppose this
doesn't hurt, it just seems unnecessary unless you foresee other child
nodes types existing in the future and hence a need to differentiate
different types of nodes.

> +        - reg               : <registers mapping for channel>
> +        - interrupts        : <interrupt mapping for DMA channel IRQ>

s/interrupts/specifier/

> +Example:
> +dma@100300 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;

Those weren't mentioned in the required properties list above. Perhaps
they're considered such a core part of DT functionality that it's not
necessary, yet some other binding documents do include these properties
in the list of required properties.
