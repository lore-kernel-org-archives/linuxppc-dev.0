Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DF752C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:57:24 +1000 (EST)
Message-ID: <1377125827.5029.50.camel@snotra.buserror.net>
Subject: Re: [PATCH v7 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
From: Scott Wood <scottwood@freescale.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 21 Aug 2013 17:57:07 -0500
In-Reply-To: <521541EE.4010303@wwwdotorg.org>
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-3-git-send-email-hongbo.zhang@freescale.com>
 <521541EE.4010303@wwwdotorg.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, hongbo.zhang@freescale.com,
 linux-kernel@vger.kernel.org, vinod.koul@intel.com, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-08-21 at 16:40 -0600, Stephen Warren wrote:
> On 07/29/2013 04:49 AM, hongbo.zhang@freescale.com wrote:
> > Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch adds
> > the device tree nodes for them.
> 
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> 
> > +** Freescale Elo3 DMA Controller
> > +   This is EloPlus controller with 8 channels, used in Freescale Txxx and Bxxx
> > +   series chips, such as t1040, t4240, b4860.
> > +
> > +Required properties:
> > +
> > +- compatible        : must include "fsl,elo3-dma"
> 
> This should probably list all the SoC-specific compatible values too.

We're not going to specify them in the device tree (see my comment on
patch 1/3), so we probably shouldn't lie about them in the binding like
eloplus currently does. :-)

> > +- ranges            : describes the mapping between the address space of the
> > +                      DMA channels and the address space of the DMA controller
> 
> Oh, so looking at the example, this is simply about being able to write
> the reg value in the child nodes more easily without having to write out
> the full based address of the controller in each child node.
> 
> I don't think the binding document should require this;

It doesn't.  It just requires that there be a mapping; it doesn't have
to be any particular mapping.

> all the binding document should care about is that the child nodes have a valid reg
> value. Whether that reg value is <0x100100 0x80> without a ranges in the
> top-level DMA

Without a ranges property there is no translation and the registers
would not be memory mappable.  Linux may treat the absence of ranges as
an identity mapping for compatibility with some broken OF trees, but
it's not standard.

> nor or whether that reg value is <0x0 0x80> with a ranges
> value in the top-level DMA node isn't something that the binding should
> specify. Either way will work equally without affecting a driver for the
> DMA controller; the parsing of reg with/without a ranges property is
> more of a core part of DT than anything to do with this binding.
> 
> > +- DMA channel nodes:
> > +        - compatible        : must include "fsl,eloplus-dma-channel"
> 
> Why do the channel nodes even need a compatible value? Presumably the
> driver for the top-level DMA node will scan these dma-channel nodes to
> extract the information it needs and will simply assume that all these
> nodes are DMA channel nodes rather than something else? I suppose this
> doesn't hurt, it just seems unnecessary unless you foresee other child
> nodes types existing in the future and hence a need to differentiate
> different types of nodes.

Other than "this is how the existing binding works and we're not going
to break compatibility", it allows the OS more flexibility to choose
whether to bind to controllers or directly to the channels.  Sometimes a
channel will be labelled with a different compatible if it has a fixed
purpose such as being connected to audio hardware (e.g. mpc8610_hpcd.dts
where some channels are "fsl,ssi-dma-channel").

The channels are mostly independent.  Only an interrupt is shared on
elo, and only an IOMMU device number on eloplus/elo3 -- plus a shared
status register that doesn't have to be used and doesn't make sense to
use without a shared interrupt.

> > +        - reg               : <registers mapping for channel>
> > +        - interrupts        : <interrupt mapping for DMA channel IRQ>
> 
> s/interrupts/specifier/
> 
> > +Example:
> > +dma@100300 {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> 
> Those weren't mentioned in the required properties list above.

It's inherent in the existence of child nodes with reg (unless you rely
on the default of 2/1, which is discouraged).  The binding should
mention it if it has particular requirements for the value of either
property, but I don't think we care here (much like we don't care what
sort of translation is used in ranges).

> Perhaps they're considered such a core part of DT functionality that it's not
> necessary, yet some other binding documents do include these properties
> in the list of required properties.

Some bindings even try to repeat the definition of standard properties
-- often incorrectly.  We should avoid that.

-Scott
