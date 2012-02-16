Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 5EACCB6F99
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2012 06:46:57 +1100 (EST)
Date: Thu, 16 Feb 2012 11:46:55 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Timur Tabi <b04825@freescale.com>
Subject: Re: [PATCH 1/1] fsldma: ignore end of segments interrupt
Message-ID: <20120216194655.GD9262@ovro.caltech.edu>
References: <1327611520-18256-1-git-send-email-iws@ovro.caltech.edu>
 <CAOZdJXVccE0GqZU2PvAz3RTh+X9ZYZr-9YufxS+mYWJkhSOGEQ@mail.gmail.com>
 <20120216190040.GA9262@ovro.caltech.edu>
 <4F3D5A28.4010905@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F3D5A28.4010905@freescale.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2012 at 01:34:00PM -0600, Timur Tabi wrote:
> Ira W. Snyder wrote:
> > This leads me to believe that this occurs mostly (but not always)
> > concurrent with the end-of-chain interrupt.
> 
> Have you tested this on an 85xx platform?
> 

No. I don't have the ability to connect my P2020 up to an FPGA to
recreate the DMA workload that causes this on my 8349EA. I can run the
dmatest module, if you'd like.

> I noticed something odd.  You're modifying fsldma_chan_irq(), which is for
> DMA controllers that have per-channel IRQs.  83xx devices don't have
> per-channel IRQs -- all channels on one controller have the same IRQ.
> Looking at the device tree, I see that the IRQs are listed in the channel
> nodes *and* in the controller node.  I don't see how we ever use the
> per-controller ISR.
> 

fsldma_ctrl_irq() (the per-controller irq handler) just calls through to
fsldma_chan_irq() (the per-channel irq handler).

> I wonder if the shared IRQ is the part of the cause of the interrupts
> you're seeing.
> 

My device tree is slightly modified to remove the per-controller
interrupts and interrupt-parent properties. Each individual channel has
identical interrupts and interrupt-parent properties specified.

Someone here suggested that I do that, several years ago. It has been
too long, and I do not remember who. I can reverse it, and use the
per-controller IRQ instead.

> > 
> > In the last month, the "unhandled sr" error has occurred on 92 out of
> > 120 boards in production use. The statistics are included below. On some
> > boards, it is much more frequent than on others. All boards have roughly
> > the same workload.
> > 
> > Another interesting tidbit from my logs: this only occurs on DMA channel
> > 2 (the are numbered starting at 0, it is the 3rd channel). Here is an
> > example log message:
> 
> What happens if you never register that channel?  That is, remove this
> node from the device tree:
> 
> dma-channel@100 {
> 	compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
> 	reg = <0x100 0x80>;
> 	cell-index = <2>;
> 	interrupt-parent = <&ipic>;
> 	interrupts = <71 8>;
> };
> 

I can try that. I hunch the problem will move, as the carma-fpga driver
(see drivers/misc/carma/carma-fpga.c) will claim the 4th channel
instead.

Ira
