Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 5EFD7B6F04
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 05:39:54 +1100 (EST)
Date: Wed, 6 Jan 2010 10:39:51 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 6/8] fsldma: simplify IRQ probing and handling
Message-ID: <20100106183951.GC26426@ovro.caltech.edu>
References: <1262326246-936-1-git-send-email-iws@ovro.caltech.edu>
	<1262326246-936-7-git-send-email-iws@ovro.caltech.edu>
	<20100106180226.GA27146@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100106180226.GA27146@loki.buserror.net>
Cc: herbert@gondor.apana.org.au, B04825@freescale.com, linuxppc-dev@ozlabs.org,
	Vishnu@freescale.com, Dipen.Dudhat@freescale.com,
	dan.j.williams@intel.com, Maneesh.Gupta@freescale.com, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 06, 2010 at 12:02:26PM -0600, Scott Wood wrote:
> On Thu, Dec 31, 2009 at 10:10:44PM -0800, Ira W. Snyder wrote:
> > The IRQ probing is needlessly complex. All off the 83xx device trees in
> > arch/powerpc/boot/dts/ specify 5 interrupts per DMA controller: one for the
> > controller, and one for each channel. These interrupts are all attached to
> > the same IRQ line.
> 
> The reason for this was to accommodate different types of drivers.  A driver
> may want to only care about one channel (e.g. if that channel is used for
> something specific such as audio), in which case it can just look at the
> channel node.
> 
> A driver that handles multiple channels, OTOH, may want to only register one
> interrupt handler that processes all channels, possibly using the summary
> register, on chips that do not have a different interrupt per channel.  Such
> drivers would register the controller interrupt if there is one -- and if
> so, it would ignore the channel interrupts.
> 

Ok. The original driver didn't do this, FYI. It would register all 5
interrupts: 1 controller + 4 channels. It is easy enough to have it
completely ignore per-channel interrupts if there is a controller
interrupt.

I don't think this would break any existing hardware. The 83xx all
shares one IRQ line, and the 85xx/86xx only have per-channel interrupts,
right? (I'm not an 85xx/86xx guy, I've only got 83xx experience). This
is what the device trees suggest, anyway.

> > This causes an interesting situation if two channels interrupt at the same
> > time. The controller's handler will handle the first channel, and the
> > channel handler will handle the remaining channels.
> 
> The driver should not be registering handlers for both the controller
> interrupt and the channel interrupt.
> 
> It looks like the other problem is that the controller interrupt handler
> is assuming only one bit will be set in the summary register.  It should
> call the channel handler for each bit that is set.
> 

Ok. I thought about doing this, but my changed approach seemed easier.

On the 83xx, we should only need to call the per-channel handler once
for each group of 8 bits. The original code used ffs(), which seems a
little wrong. Why call the handler twice if both EOSI and EOCDI are set
for a channel? Should I use a loop + mask, or is there some other neat
trick I can use?

> > The same can be accomplished on 83xx by removing the controller's interrupt
> > property from the device tree. Testing has not shown any problems with this
> > configuration. 
> 
> Yes, it will work, but the overhead is a little higher than if you only had
> the one handler and used the summary register.
> 

Ok. All of the in-tree 83xx device trees have 5 interrupts listed. With
the changes described above, we'll only call request_irq() once in that
case, and use the per-controller interrupt.

I'll leave the documentation alone, with the exception of marking the
per-controller interrupt optional.

Ira

> > All in-tree device trees already have an interrupt property
> > specified for each channel.
> > 
> > Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> > ---
> >  Documentation/powerpc/dts-bindings/fsl/dma.txt |   17 +++++---
> >  drivers/dma/fsldma.c                           |   49 +++++++-----------------
> >  2 files changed, 25 insertions(+), 41 deletions(-)
> > 
> > diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/Documentation/powerpc/dts-bindings/fsl/dma.txt
> > index 0732cdd..d5d2d3d 100644
> > --- a/Documentation/powerpc/dts-bindings/fsl/dma.txt
> > +++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
> > @@ -12,6 +12,9 @@ Required properties:
> >  - ranges		: Should be defined as specified in 1) to describe the
> >  		  DMA controller channels.
> >  - cell-index        : controller index.  0 for controller @ 0x8100
> > +
> > +Optional properties:
> > +
> >  - interrupts        : <interrupt mapping for DMA IRQ>
> >  - interrupt-parent  : optional, if needed for interrupt mapping
> >  
> > @@ -23,11 +26,7 @@ Required properties:
> >  			 "fsl,elo-dma-channel". However, see note below.
> >          - reg               : <registers mapping for channel>
> >          - cell-index        : dma channel index starts at 0.
> > -
> > -Optional properties:
> >          - interrupts        : <interrupt mapping for DMA channel IRQ>
> > -			  (on 83xx this is expected to be identical to
> > -			   the interrupts property of the parent node)
> 
> It should indeed be the controller interrupt that is optional, but why
> remove the comment about 83xx?  That's the only time you'll have a
> controller interrupt at all.
> 
> >          - interrupt-parent  : optional, if needed for interrupt mapping
> >  
> >  Example:
> > @@ -37,28 +36,34 @@ Example:
> >  		compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
> >  		reg = <0x82a8 4>;
> >  		ranges = <0 0x8100 0x1a4>;
> > -		interrupt-parent = <&ipic>;
> > -		interrupts = <71 8>;
> >  		cell-index = <0>;
> >  		dma-channel@0 {
> >  			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> >  			cell-index = <0>;
> >  			reg = <0 0x80>;
> > +			interrupt-parent = <&ipic>;
> > +			interrupts = <71 8>;
> >  		};
> >  		dma-channel@80 {
> >  			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> >  			cell-index = <1>;
> >  			reg = <0x80 0x80>;
> > +			interrupt-parent = <&ipic>;
> > +			interrupts = <71 8>;
> >  		};
> >  		dma-channel@100 {
> >  			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> >  			cell-index = <2>;
> >  			reg = <0x100 0x80>;
> > +			interrupt-parent = <&ipic>;
> > +			interrupts = <71 8>;
> >  		};
> >  		dma-channel@180 {
> >  			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> >  			cell-index = <3>;
> >  			reg = <0x180 0x80>;
> > +			interrupt-parent = <&ipic>;
> > +			interrupts = <71 8>;
> 
> I'd rather the example provide both controller and channel interrupts.
> 
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
