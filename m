Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 37037B6F71
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 06:10:33 +1000 (EST)
Date: Wed, 6 Apr 2011 13:10:30 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Chuck Ketcham <chuckk2333@yahoo.com>
Subject: Re: Using dmaengine on Freescale P2020 RDB
Message-ID: <20110406201029.GC7312@ovro.caltech.edu>
References: <327152.93855.qm@web36406.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <327152.93855.qm@web36406.mail.mud.yahoo.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2011 at 12:40:58PM -0700, Chuck Ketcham wrote:
> All,
> 
> I have a Freescale P2020 Reference Design Board.  I am investigating the possibility of using the dmaengine capability in the 2.6.32.13 kernel to transfer data from memory out onto the PCIe bus.  As a first step, I thought I would try the DMA test client (dmatest.ko) to make sure the dmaengine was functioning.  I know this doesn't transfer anything over PCIe but only transfers from one memory buffer to another, but I figured I need to get this working first.  Anyway I built dmatest.ko and ran it (with insmod), and discovered it didn't do anything.  I added some printk's to the kernel to investigate what was going on and I found that all attempts to find a channel within dma_request_channel were unsuccessful.  Three of the channels were not used because they were already publicly allocated.  One channel was not used because it didn't have DMA_MEMCPY capability.
> 
> Here are my questions then:
> 1. Is the dmaengine the appropriate method to use for transferring data from memory out onto the PCIe bus?
> 2. If dmaengine is correct, what can I do to free up a channel for my own use?
> 

I use the Freescale DMA engine to transfer lots of data out to PCI, on
an 8349EA chip. The P2020 DMA engine uses the same driver.

I hunch you have enabled CONFIG_NET_DMA, which will claim the channels.
You should disable it to use the devices for other uses.

If you want an example of using the DMA engine to transfer from DDR
memory to the PowerPC local bus, search the mailing list archives for
"CARMA Board Drivers" (RFCv7 was the latest posting). Transferring from
DDR to PCI works exactly the same way.

Hope it helps,
Ira
