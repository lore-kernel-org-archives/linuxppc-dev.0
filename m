Return-Path: <mgreer@mvista.com>
Date: Wed, 24 May 2006 13:52:16 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Subject: Re: pmppc7448/mv64x60 DMA from PCI to memory
Message-ID: <20060524205216.GB11130@mag.az.mvista.com>
References: <1148395804.21475.53.camel@toby.int.avalon.com.au>
	<20060523235449.GB1536@mag.az.mvista.com>
	<1148437434.4876.64.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148437434.4876.64.camel@lamorak.int.avalon.com.au>
Cc: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, May 24, 2006 at 11:53:54AM +0930, Phil Nitschke wrote:
> On Tue, 2006-05-23 at 16:54 -0700, Mark A. Greer wrote:
> 
> > You say that you don't see any PCI traffic.  Does that mean you
> > have a PCI analyzer and that you are sure that its set up correctly?
> 
> I don't have a PCI analyzer, however the JTAG used to program the PCI
> device has been configured to display 4 K samples of PCI bus signals
> (about 20 microsecs?) around the time of an interrupt which results in
> the DMA being requested.  Since my last post, I have managed to see some
> traffic, but the PCI STOP# line is asserted, so I'm not seeing any data
> being read.  I'll investigate further...

OK

> > If so, then you have something botched in your IDMA->PCI window setup
> 
> Quite possibly.  The patch below shows how I've set this window up.  It
> is not intended as a 'final' piece of code, so please forgive the magic
> numbers.  Could you review this for me?

Sure.

> > or in the pgming of the DMA itself (e.g., in your descriptor(s)).
> 
> Well the memory to memory DMA is working OK.  I just didn't know what
> the correct procedure was for determining the bus address of the FIFO.
> For example, this mapping returns a dma handle which does not work:
> 
>     fifo_dma_handle = pci_map_single(dev, my_card.bar1+fifo_address[0],
>                                      FIFO_SIZE, PCI_DMA_FROMDEVICE);
>
> Whereas without DMA I would just use this:
>     ioread32_rep(my_card.bar1 + fifo_address[0], buf, 6);
> 
> Was I misguided in trying to use pci_map_single in this way?

Yes.  Use pci_map_single() to map an already allocated, physically
contiguous memory buffer not pci memory.  Try pci_iomap() instead.

You should read Documentation/DMA-API.txt & DMA-mapping.txt thoroughly
then look at the many pci drivers that already exist as examples.

> > Also, set the SrcHold bit [3] of the channel control reg (low).
> > If its really a FIFO, you are--or will be once you get your windows
> > and descriptors set up correctly--reading the FIFO once then
> > incrementing past it.
> 
> I can either address it as a FIFO, or as a memory range.  I can read
> from any address in the range and it returns the "next FIFO value".
> Anyway, I've tried both src address hold settings...

OK

> > > For this scenario, can anyone tell me:
> > >         * Should I be using the same src address as that reported via
> > >         the 'lspci' command - this _is_ the PCI bus address, isn't it?
> > 
> > "man lspci" (read up on the '-b' option)
> 
> I cannot see any difference with the '-b' flag.  Maybe that is the way
> of things on my architecture?

That probably means that your pci io & mem space are mapped at the same
addrs in pci io & mem space and phys cpu space.  If that's not the case,
something may be wrong.

> > >         * Looking through mv64x60.c in the 2.6.16 kernel, I note that 4
> > >         of the 8 possible IDMA address windows are configured (for each
> > >         of the 512 MB DRAM on our processor card).
> > 
> > No they aren't.  They're configured (or not) according to the setup info
> > that you pass in.
> 
> OK.  I also note there are several cases where this is used in
> mv64x60.c:
> 
>         for (i=0; i<3; i++)
> 
> Why is 3 used in these loops, and not some other constant like
> MV64360_xxxxx_WINDOWS (which are usually 4, not 3)?

Different things.  The "i<3;" are when looping through windows that are 
related to a struct pci_controller's mem_resource.  From the definition
of pci_controller:

	struct resource mem_resources[3];

> > > Do I need to add
> > >         tests to my source and destination regions, to determine if they
> > >         cross one of the 512 MB regions, and hence will require a
> > >         different CSx line (and thus the DMA will need to be broken into
> > >         two transactions), or does kernel already take care to ensure
> > >         allocated regions will not cross these boundaries?
> > 
> > No.  You need to do what's appropriate for the hardware that you are
> > essentially writing a driver for.  YOU are supposed to know what the
> > limitations of your hardware are.  
> 
> OK, I know how my hardware is configured, but when trying to write a
> generic driver, perhaps I need to have the mv64x60.c code remember the
> CSx barriers, e.g. in the mv64x60_chip_info, so the IDMA engine can
> access it.  Do you think this would be possible/beneficial?

No.  Just set up and enable an IDMA window to access all of pci mem space
and be done with it.

> Thanks again,
> 
> -- 
> Phil
> 
> Here is the patch to configure IDMA to PCI window(s):
> 
> --- linux-2.6.16/arch/ppc/syslib/mv64x60.c      2006-03-20
> 16:23:29.000000000 +1030
> +++ linux-2.6.16-patched/arch/ppc/syslib/mv64x60.c      2006-05-23
> 16:33:52.000000000 +0930
> @@ -535,6 +581,7 @@
>                 mv64x60_config_pci_params(bh->hose_a, &si->pci_0);
> 
>                 mv64x60_config_cpu2pci_windows(bh, &si->pci_0, 0);
> +                mv64x60_config_idma2pci_windows(bh, &si->pci_0, 0);
>                 mv64x60_config_pci2mem_windows(bh, bh->hose_a,
> &si->pci_0, 0,
>                         mem_windows);
>                 bh->ci->set_pci2regs_window(bh, bh->hose_a, 0,
> @@ -548,6 +595,7 @@
>                 mv64x60_config_pci_params(bh->hose_b, &si->pci_1);
> 
>                 mv64x60_config_cpu2pci_windows(bh, &si->pci_1, 1);
> +                mv64x60_config_idma2pci_windows(bh, &si->pci_1, 1);
>                 mv64x60_config_pci2mem_windows(bh, bh->hose_b,
> &si->pci_1, 1,
>                         mem_windows);
>                 bh->ci->set_pci2regs_window(bh, bh->hose_b, 1,
> @@ -1136,6 +1188,42 @@
>                         bh->ci->disable_window_32bit(bh, win_tab[bus][i
> +1]);
>  }
> 
> +static u32 idma_tab_xtra[MV64x60_CPU2MEM_WINDOWS] __initdata = {
> +        MV64x60_IDMA2MEM_0_WIN, MV64x60_IDMA2MEM_1_WIN,
> +        MV64x60_IDMA2MEM_2_WIN, MV64x60_IDMA2MEM_3_WIN,
> +};
> +
> +void __init
> +mv64x60_config_idma2pci_windows(struct mv64x60_handle *bh,
> +        struct mv64x60_pci_info *pi, u32 bus)
> +{
> +        u32     attributes, unit_id;
> +        int     i;
> +
> +       /* Target Unit IDs: PCI0 = 3, PCI1 = 4. */
> +       unit_id = bus ? 0x4 : 0x3;
> +       /* 0x1d == No swap data, PCI-X NS attribute asserted, PCI memory
> +        * space, PCIx_REQ64n asserted according to requested data size.
> */
> +       attributes = (0x1d << 8) | unit_id;
> +
> +        for (i=0; i<3; i++)
> +                if (pi->pci_mem[i].size > 0) {
> +                        mv64x60_set_32bit_window(bh, idma_tab_xtra[i],
> +                                pi->pci_mem[i].cpu_base,
> pi->pci_mem[i].size,
> +                                attributes);
> +                        bh->ci->enable_window_32bit(bh,
> idma_tab_xtra[i]);
> +                        /* Give idma r/w access to PCI memory region */
> +                        mv64x60_set_bits(bh,
> MV64360_IDMA2MEM_ACC_PROT_0,
> +                                (0x3 << (i << 1)));
> +                        mv64x60_set_bits(bh,
> MV64360_IDMA2MEM_ACC_PROT_1,
> +                                (0x3 << (i << 1)));
> +                        mv64x60_set_bits(bh,
> MV64360_IDMA2MEM_ACC_PROT_2,
> +                                (0x3 << (i << 1)));
> +                        mv64x60_set_bits(bh,
> MV64360_IDMA2MEM_ACC_PROT_3,
> +                                (0x3 << (i << 1)));
> +                }
> +}
> +
>  /*
> 
> *****************************************************************************
>   *
> @@ -2220,8 +2311,8 @@
>  };
> 
>  static u32 idma_tab[MV64x60_CPU2MEM_WINDOWS] __initdata = {
> -       MV64x60_IDMA2MEM_0_WIN, MV64x60_IDMA2MEM_1_WIN,
> -       MV64x60_IDMA2MEM_2_WIN, MV64x60_IDMA2MEM_3_WIN,
> +        MV64x60_IDMA2MEM_4_WIN, MV64x60_IDMA2MEM_5_WIN,
> +        MV64x60_IDMA2MEM_6_WIN, MV64x60_IDMA2MEM_7_WIN,
>  };
> 
>  static u32 dram_selects[MV64x60_CPU2MEM_WINDOWS] __initdata =
> @@ -2285,13 +2376,13 @@
> 
>                         /* Give idma r/w access to memory region */
>                         mv64x60_set_bits(bh,
> MV64360_IDMA2MEM_ACC_PROT_0,
> -                               (0x3 << (i << 1)));
> +                                (0x3 << ((i+4) << 1)));
>                         mv64x60_set_bits(bh,
> MV64360_IDMA2MEM_ACC_PROT_1,
> -                               (0x3 << (i << 1)));
> +                                (0x3 << ((i+4) << 1)));
>                         mv64x60_set_bits(bh,
> MV64360_IDMA2MEM_ACC_PROT_2,
> -                               (0x3 << (i << 1)));
> +                                (0x3 << ((i+4) << 1)));
>                         mv64x60_set_bits(bh,
> MV64360_IDMA2MEM_ACC_PROT_3,
> -                               (0x3 << (i << 1)));
> +                                (0x3 << ((i+4) << 1)));
>                 }
>  }

I didn't go through this in great detail but it looks like you have
the right idea (IMHO).  Although, I don't know why you didn't just
use windows 4-7 for the idma->pci mappings and leave the idma->mem code
alone.

Mark
