Return-Path: <Phil.Nitschke@avalon.com.au>
Received: from ash25e.internode.on.net (ash25e.internode.on.net
	[203.16.214.182]) by ozlabs.org (Postfix) with ESMTP id 1526C67B21
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 00:50:05 +1000 (EST)
Subject: pmppc7448/mv64x60 DMA from PCI to memory
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 24 May 2006 00:20:04 +0930
Message-Id: <1148395804.21475.53.camel@toby.int.avalon.com.au>
Mime-Version: 1.0
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

Hi,

I'm working on a project using this processor:
http://www.artesyncp.com/products/PmPPC7448.html
on a custom VME carrier, as shown below.  We're wanting to suck
large amounts of data from a PCI device which _cannot_ perform
bus-mastered DMA (it is a PCI Target only).

The Marvell Chip used by the PmPPC7448 is this one:
  http://www.marvell.com/products/communication/Discovery%20MV64460%
20FINAL.pdf

I've written a collection of simple routines to program the Marvell IDMA
controller, for example:
    mv64x6x_init_dma_channel();
    mv64x6x_set_dma_mode();
    mv64x6x_set_src_addr();
    mv64x6x_set_dst_addr();
    mv64x6x_set_dma_count();
    mv64x6x_enable_dma();
or rather more simply:
    mv64x6x_memcpy_dma(dst_handle, src_handle, size);

This works OK for copying from a memory to memory, where the buffers are
allocated using:
    src = dma_alloc_noncoherent(NULL, BUF_SZ, &src_handle, GFP_KERNEL);
The src_handle is passed directly to mv64x6x_set_src_addr();

But when the src address is the FIFO on the PCI bus, I don't know how to
get the IDMA controller to play nicely.  The FIFO sits in the middle of
the PCI device's I/O mem range 0x9fe00000 - 0x9fffffff.  I've programmed
and enabled a 5th address window in the IDMA controller which
encompasses the 0x200000 bytes of the PCI memory range, and I'm not
seeing any address violation or address miss errors.  The PCI->memory
DMA "completes" without any traffic every touching the PCI bus, so
obviously I need to do something else/differently.

For this scenario, can anyone tell me:
        * Should I be using the same src address as that reported via
        the 'lspci' command - this _is_ the PCI bus address, isn't it?
        
        * Do I have to do anything special to tell the IDMA controller
        to source data from the PCI bus and shift it into memory?
        
        * Looking through mv64x60.c in the 2.6.16 kernel, I note that 4
        of the 8 possible IDMA address windows are configured (for each
        of the 512 MB DRAM on our processor card).  Do I need to add
        tests to my source and destination regions, to determine if they
        cross one of the 512 MB regions, and hence will require a
        different CSx line (and thus the DMA will need to be broken into
        two transactions), or does kernel already take care to ensure
        allocated regions will not cross these boundaries?
        
TIA for any help that anyone can offer.

-- 
Phil

       +--------------------------------------------------+
       |            Custom VME64x Carrier Card            |
       |  +-------------------+    +-------------------+  |
       |  | Artesyn PmPPC7448 |    | Altera FPGA       |  |
       |  |                   |    |                   |  |
       |  |+-----------------+|    |+-----------------+|  |
       |  ||Marvell MV64460  ||    || Altera PCI I/F  ||  |
       |  ||(NOT coherent    ||    ||(non-prefetchable)|  |
       |  || cache)  (+IDMA) ||    ||       FIFO      ||  |
       |  |+--------#--------+|    |+---------#-------+|  |
       |  +---------#---------+    +----------#--------+  |
       |            #         PCI Bus         #           |
       |   ###########################################    |
       +--------------------------------------------------+

p.s. Since my driver was developed using documentation obtained from
Marvell under a very restrictive NDA, I cannot release it as open source
just yet.  Marvell's Vice President and General Counsel is currently
reviewing the matter, and I expect to hear from them in the next couple
weeks.
