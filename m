Return-Path: <walt.wimer@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id D5D2067A70
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Mar 2005 02:01:26 +1000 (EST)
From: "Walter L. Wimer III" <walt.wimer@timesys.com>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <42441B13.7080703@ru.mvista.com>
References: <1111705036.15834.29.camel@excalibur.timesys.com>
	<42441B13.7080703@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 11:01:24 -0500
Message-Id: <1112112084.26645.27.camel@excalibur.timesys.com>
Mime-Version: 1.0
Subject: Re: PCI support under 2.6.11.4 on MPC8272ADS ???
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Thanks to all who offered suggestions regarding PCI on the MPC8272ADS.
I too suspected that the PCI bus frequency may have been the problem,
and even spent some time looking at the clock configuration in the
Freescale documentation before I posted my message.  The documentation
seemed very confusing, so I decided to pursue a few different avenues in
parallel, including posting to the list.

Since Andrei and Vitaly further implicated the bus frequency, I went
back and took a closer look at it.  After much staring at the
documentation, dumping registers, trying a 66MHz-capable card, etc. I
can report that this was indeed the problem.  A 66MHz-capable Promise
IDE controller card does seem to work.

I'd like to change the bus speed to <= 33MHz, but this still looks non-
trivial.  If I understand things properly, it looks like my best bet is
to modify the Hard Reset Configuration Word in flash to set the
PCI_MODCK bit to "low range" (25 to 50 MHz, instead of 50 to 66 MHz).

Can anyone confirm my understanding?


Thanks again!

Walt



On Fri, 2005-03-25 at 17:07 +0300, Vitaly Bordug wrote:
> Hi Walt,
> 
> Well, the incorrect VendorID almost clearly points to the incompatible
> PCI bus frequency - try to set it to 33Mhz. 
> AFAIR, I saw my network card as video adapter in the lspci output. 
> 
> The 2.4 stuff was tested rather thoroughly. The current 2.6.11 support
> is examined with HPT370 and PDC20268 PCI IDE.
> 
> You may also try my latest patch to the stock linux 2.5. 
> 
> Wimer, Walt wrote: 
> > Using Vitaly's 2.4-based patch below as a starting point, I've been
> > adding PCI support to 2.6.11.4 for the MPC8272ADS board.
> > 
> > The good news is that I think I have PCI interrupts pretty well sorted
> > out, and I see *something* half-way reasonable from "lspci".
> > 
> > The bad news is that neither of the ethernet cards that I'm trying will
> > actually work, and I see some very weird behavior with PCI configuration
> > space:
> > 
> >   Card 1:  Some Realtek RTL8139D-based card
> >   Card 2:  NETGEAR FA311 (National Semi DP83815 chip)
> > 
> > With either card installed alone, both U-Boot and my kernel identify the
> > cards correctly in PCI configuration space.
> > 
> > With *both* cards installed, both U-Boot and my kernel see the Realtek-
> > based card correctly, but the NETGEAR card has a corrupted Vendor ID
> > (e.g. 0x1000 or 0x1003 instead of the correct 0x100b).  This happens
> > regardless of which PCI slots I use for the cards (I've tried virtually
> > every combination).  This smells of a power problem or something to me.
> > 
> > And again, even with either card alone, the drivers have serious
> > problems talking to the cards.  I get various error messages from
> > the drivers and I see badly mangled packets on the wire.  It's also
> > not uncommon for the whole system to freeze...
> > 
> > Has anyone else seen similar behavior?
> > 
> > Has anyone had success with PCI on this board (under any kernel
> > version)?
> > 
> > 
> > Any ideas / data points are appreciated.
> > 
> > 
> > Thanks!!!
> > 
> > Walt Wimer
> > 
> > 
> > 
> >   
> > > This patch adds PCI bridge support for MPC8272 and PQ2FADS to the
> > > current linuxppc-2.4 tree. Actually it has been tested with 8272, but
> > > PQ2 _should_ also work, though it will complain that host bridge ID is
> > > unrecognized.
> > > 
> > > Signed-off-by: Vitaly Bordug <vbordug at ru.mvista.com>
> > > 
> > > --
> > > Sincerely, Vitaly
> > > 
> > > -------------- next part --------------
> > > A non-text attachment was scrubbed...
> > > Name: pq2-pci.patch
> > > Type: text/x-patch
> > > Size: 20111 bytes
> > > Desc: not available
> > > Url : http://ozlabs.org/pipermail/linuxppc-embedded/attachments/20050218/12060ce8/pq2-pci.bin
> > >     
> > 
> > 
> >   
> 
> -- 
> Sincerely, 
> Vitaly
