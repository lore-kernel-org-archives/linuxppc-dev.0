Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.9])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 794272C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 01:32:11 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH RFC v5 4/5] dma: mpc512x: register for device tree channel
 lookup
Date: Mon, 18 Nov 2013 15:31:54 +0100
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
 <1383290374-17484-5-git-send-email-a13xp0p0v88@gmail.com>
 <20131118120957.GH30853@e106331-lin.cambridge.arm.com>
In-Reply-To: <20131118120957.GH30853@e106331-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201311181531.54818.arnd@arndb.de>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>,
 Gerhard Sittig <gsi@denx.de>, Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 18 November 2013, Mark Rutland wrote:
> > +++ b/Documentation/devicetree/bindings/dma/mpc512x-dma.txt
> > @@ -0,0 +1,55 @@
> > +* Freescale MPC512x DMA Controller
> > +
> > +The DMA controller in the Freescale MPC512x SoC can move blocks of
> > +memory contents between memory and peripherals or memory to memory.
> > +
> > +Refer to the "Generic DMA Controller and DMA request bindings" description
> > +in the dma.txt file for a more detailled discussion of the binding.  The
> > +MPC512x DMA engine binding follows the common scheme, but doesn't provide
> > +support for the optional channels and requests counters (those values are
> > +derived from the detected hardware features) and has a fixed client
> > +specifier length of 1 integer cell (the value is the DMA channel, since
> > +the DMA controller uses a fixed assignment of request lines per channel).
> 
> The fact that #dma-cells must be <1> isn't a difference from the
> standard binding, and needs not be described here. The meaning of the
> value should be in your description of #dma-cells below.

I think the value it has to be in there, and I have in the past asked other
people to add this. Note that in the generic binding, it says that it must
be "at least 1". You can have controllers that require a larger number, or
that can use 1 or 2 alternatively, depending on how the device is wired
up, e.g. when a dma controller has two master ports you would need a
second cell to specify the port number, but only if more than one port
is actually connected to a slave.

> I'm not sure it's worth mentioning optional channels / request counters.
> If anything, it would be better to update dma.txt to move the "Optional
> properties" to something like "Suggested properties"...

These are less clearly defined. In the generic binding, it's mostly a matter
of "if you need to pass this information, use these properties". The individual
binding can then make them mandatory if needed.

	Arnd
