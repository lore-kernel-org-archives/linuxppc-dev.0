Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77CF72C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 08:46:10 +1000 (EST)
Message-ID: <1377125156.5029.40.camel@snotra.buserror.net>
Subject: Re: [PATCH v7 1/3] DMA: Freescale: revise device tree binding document
From: Scott Wood <scottwood@freescale.com>
To: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 21 Aug 2013 17:45:56 -0500
In-Reply-To: <5215402E.70007@wwwdotorg.org>
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-2-git-send-email-hongbo.zhang@freescale.com>
 <5215402E.70007@wwwdotorg.org>
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

On Wed, 2013-08-21 at 16:33 -0600, Stephen Warren wrote:
> On 07/29/2013 04:49 AM, hongbo.zhang@freescale.com wrote:
> > From: Hongbo Zhang <hongbo.zhang@freescale.com>
> > 
> > This patch updates the discription of each type of DMA controller and its
> > channels, it is preparation for adding another new DMA controller binding, it
> > also fixes some defects of indent for text alignment at the same time.
> 
> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> 
> > -- compatible        : compatible list, contains 2 entries, first is
> > -		 "fsl,CHIP-dma", where CHIP is the processor
> > -		 (mpc8349, mpc8360, etc.) and the second is
> > -		 "fsl,elo-dma"
> > +- compatible        : must include "fsl,elo-dma"
> 
> Why remove the list of supported compatible values. Lately it seems that
> we're moving towards listing more/all the values rather than removing
> their documentation...

Previous versions had language that required fsl,CHIP-dma for 83xx (and
maybe 85xx?) but not the new chip.  I asked for it to be consistent.
The reason that 83xx still has fsl,CHIP-dma is not because of anything
special to 83xx, but that most other chips with this device have been
converted to dtsi and it's much more of a pain to specify the specific
SoC in that context.  The existing language does not match actual device
trees when it comes to 85xx.

Plus, the exact SoC name is of dubious value for integrated devices.  It
doesn't uniquely identify the hardware because different versions of the
SoC could have different versions of the subdevice.  As such, on our
chips we've been moving away from including a compatible that specifies
the exact SoC.  If it turns out we made a mistake in naming different
versions of the device, or if there are errata, the exact SoC can still
be determined at runtime using SVR.

> > -- ranges		: Should be defined as specified in 1) to describe the
> > -		  DMA controller channels.
> > +- ranges            : describes the mapping between the address space of the
> > +                      DMA channels and the address space of the DMA controller
> 
> What is "the address space of the DMA controller". Perhaps this should
> say "the CPU-visible address space" instead?

It's translating from the addresses used in the child nodes to a CCSR
offset.  It's really just a convenience for the readability and
macro-ability of the device tree that we do this translation at all,
versus having an empty ranges and using CCSR offsets in the children.

It's not about translating between the DMA controller's view and the
CPU's view or anything like that.

-Scott
