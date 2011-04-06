Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 00E6E100906
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 07:28:03 +1000 (EST)
Date: Wed, 6 Apr 2011 14:28:00 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Chuck Ketcham <chuckk2333@yahoo.com>
Subject: Re: Using dmaengine on Freescale P2020 RDB
Message-ID: <20110406212800.GD7312@ovro.caltech.edu>
References: <20110406201029.GC7312@ovro.caltech.edu>
	<523835.3776.qm@web36403.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <523835.3776.qm@web36403.mail.mud.yahoo.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2011 at 01:29:05PM -0700, Chuck Ketcham wrote:
> Ira,
> 
> Thanks for the reference to the CARMA drivers.  I will have to take a look at that.
> 
> In my case, CONFIG_NET_DMA is not enabled.  However, I did notice the following entry in my p2020rdb.dts file that may have something to do with dma channels being allocated -- can anyone interpret this?:
> 
>                 dma@21300 {
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         compatible = "fsl,eloplus-dma";
>                         reg = <0x21300 0x4>;
>                         ranges = <0x0 0x21100 0x200>;
>                         cell-index = <0>;
>                         dma-channel@0 {
>                                 compatible = "fsl,eloplus-dma-channel";
>                                 reg = <0x0 0x80>;
>                                 cell-index = <0>;
>                                 interrupt-parent = <&mpic>;
>                                 interrupts = <20 2>;
>                         };
>                         dma-channel@80 {
>                                 compatible = "fsl,eloplus-dma-channel";
>                                 reg = <0x80 0x80>;
>                                 cell-index = <1>;
>                                 interrupt-parent = <&mpic>;
>                                 interrupts = <21 2>;
>                         };
>                         dma-channel@100 {
>                                 compatible = "fsl,eloplus-dma-channel";
>                                 reg = <0x100 0x80>;
>                                 cell-index = <2>;
>                                 interrupt-parent = <&mpic>;
>                                 interrupts = <22 2>;
>                         };
>                         dma-channel@180 {
>                                 compatible = "fsl,eloplus-dma-channel";
>                                 reg = <0x180 0x80>;
>                                 cell-index = <3>;
>                                 interrupt-parent = <&mpic>;
>                                 interrupts = <23 2>;
>                         };
>                 };
> 
> 

Your DTS file looks fine. It is what I would expect to see. The channels
are not allocated by anything here.

Turning on CONFIG_DMADEVICES_DEBUG may give you some insight into how
the dmaengine core is allocating the channels. I don't have any better
advice. I'm afraid you'll have to figure out who is requesting all of
the channels on your own.

Ira

> --- On Wed, 4/6/11, Ira W. Snyder <iws@ovro.caltech.edu> wrote:
> 
> > From: Ira W. Snyder <iws@ovro.caltech.edu>
> > Subject: Re: Using dmaengine on Freescale P2020 RDB
> > To: "Chuck Ketcham" <chuckk2333@yahoo.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Date: Wednesday, April 6, 2011, 1:10 PM
> > On Wed, Apr 06, 2011 at 12:40:58PM
> > -0700, Chuck Ketcham wrote:
> > > All,
> > > 
> > > I have a Freescale P2020 Reference Design Board. 
> > I am investigating the possibility of using the dmaengine
> > capability in the 2.6.32.13 kernel to transfer data from
> > memory out onto the PCIe bus.  As a first step, I
> > thought I would try the DMA test client (dmatest.ko) to make
> > sure the dmaengine was functioning.  I know this
> > doesn't transfer anything over PCIe but only transfers from
> > one memory buffer to another, but I figured I need to get
> > this working first.  Anyway I built dmatest.ko and ran
> > it (with insmod), and discovered it didn't do
> > anything.  I added some printk's to the kernel to
> > investigate what was going on and I found that all attempts
> > to find a channel within dma_request_channel were
> > unsuccessful.  Three of the channels were not used
> > because they were already publicly allocated.  One
> > channel was not used because it didn't have DMA_MEMCPY
> > capability.
> > > 
> > > Here are my questions then:
> > > 1. Is the dmaengine the appropriate method to use for
> > transferring data from memory out onto the PCIe bus?
> > > 2. If dmaengine is correct, what can I do to free up a
> > channel for my own use?
> > > 
> > 
> > I use the Freescale DMA engine to transfer lots of data out
> > to PCI, on
> > an 8349EA chip. The P2020 DMA engine uses the same driver.
> > 
> > I hunch you have enabled CONFIG_NET_DMA, which will claim
> > the channels.
> > You should disable it to use the devices for other uses.
> > 
> > If you want an example of using the DMA engine to transfer
> > from DDR
> > memory to the PowerPC local bus, search the mailing list
> > archives for
> > "CARMA Board Drivers" (RFCv7 was the latest posting).
> > Transferring from
> > DDR to PCI works exactly the same way.
> > 
> > Hope it helps,
> > Ira
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
> 
