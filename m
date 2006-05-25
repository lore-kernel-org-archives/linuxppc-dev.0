Return-Path: <Phil.Nitschke@avalon.com.au>
Subject: Re: pmppc7448/mv64x60 DMA from PCI to memory
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060524205216.GB11130@mag.az.mvista.com>
References: <1148395804.21475.53.camel@toby.int.avalon.com.au>
	<20060523235449.GB1536@mag.az.mvista.com>
	<1148437434.4876.64.camel@lamorak.int.avalon.com.au>
	<20060524205216.GB11130@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 09:51:24 +0930
Message-Id: <1148516484.4876.90.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Cc: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2006-05-24 at 13:52 -0700, Mark A. Greer wrote:
> On Wed, May 24, 2006 at 11:53:54AM +0930, Phil Nitschke wrote:
> > On Tue, 2006-05-23 at 16:54 -0700, Mark A. Greer wrote:
> > 
> > > You say that you don't see any PCI traffic.  Does that mean you
> > > have a PCI analyzer and that you are sure that its set up correctly?
> > 
> > I don't have a PCI analyzer, however the JTAG used to program the PCI
> > device has been configured to display 4 K samples of PCI bus signals
> > (about 20 microsecs?) around the time of an interrupt which results in
> > the DMA being requested.  Since my last post, I have managed to see some
> > traffic, but the PCI STOP# line is asserted, so I'm not seeing any data
> > being read.  I'll investigate further...

It turns out that the PCI device firmware was not responding correctly
to MRL and MRM (memory read multiple) PCI commands, but was working for
MR... Fixed now, and DMA from PCI is working.  Just looking at byte
order today.

> > OK.  I also note there are several cases where this is used in
> > mv64x60.c:
> > 
> >         for (i=0; i<3; i++)
> > 
> > Why is 3 used in these loops, and not some other constant like
> > MV64360_xxxxx_WINDOWS (which are usually 4, not 3)?
> 
> Different things.  The "i<3;" are when looping through windows that are 
> related to a struct pci_controller's mem_resource.

OK.

> > > > Do I need to add
> > > >         tests to my source and destination regions, to determine if they
> > > >         cross one of the 512 MB regions, and hence will require a
> > > >         different CSx line (and thus the DMA will need to be broken into
> > > >         two transactions), or does kernel already take care to ensure
> > > >         allocated regions will not cross these boundaries?
> > > 
> > > No.  You need to do what's appropriate for the hardware that you are
> > > essentially writing a driver for.  YOU are supposed to know what the
> > > limitations of your hardware are.  
> > 
> > OK, I know how my hardware is configured, but when trying to write a
> > generic driver, perhaps I need to have the mv64x60.c code remember the
> > CSx barriers, e.g. in the mv64x60_chip_info, so the IDMA engine can
> > access it.  Do you think this would be possible/beneficial?
> 
> No.  Just set up and enable an IDMA window to access all of pci mem space
> and be done with it.

No, this is different.  The patch I posted does map all the PCI mem
space as you've suggested.  The problem I'm trying to avoid is if the
IDMA engine tries to transfer data from this PCI mem region into a
buffer that crosses one of the DRAM address windows (and hence uses
different CSn lines).  Then the transfer needs to be broken into two
separate DMAs.  But if this information is not stored in the chip info,
how is the DMA driver to know where the memory boundaries are (except by
reading the already programmed windows and deducing these boundaries)?

> I didn't go through this in great detail but it looks like you have
> the right idea (IMHO).  Although, I don't know why you didn't just
> use windows 4-7 for the idma->pci mappings and leave the idma->mem code
> alone.

Two reasons (however flaky).  The lower 4 windows have an upper 32-bit
address register, so it is better to leave these for users (lucky
bastards!) that have more than 4 GB address space.  Secondly, the IDMA
supports the address override feature (which I was trying to use in
desperation when nothing was working for me), wherein the transaction
target interface, attributes and upper 32-bit address are taken from
BAR1, BAR2 or BAR3.  So I thought it would be better to leave these
alone.

-- 
Phil
