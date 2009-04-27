Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id B7E8DDDDA5
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 05:34:18 +1000 (EST)
Message-ID: <49F608B7.9080409@ovro.caltech.edu>
Date: Mon, 27 Apr 2009 12:34:15 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] fsldma: use PCI Read Multiple command
References: <20090424183517.GB23140@ovro.caltech.edu>	<D7CCA83BB0796C49BC0BB53B6AB1208928CA1D@zch01exm21.fsl.freescale.net>
	<ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
In-Reply-To: <ed82fe3e0904270731g2d2519a7mc12e4152c716c0a9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Ira Snyder <iws@ovro.caltech.edu>, Liu Dave-R63238 <DaveLiu@freescale.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Dan Williams <dan.j.williams@intel.com>,
	Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

>> You are assuming the PCI memory space is prefetchable( no side effect)
>> for DMA. Is it possible that DMA is from non-prefetchable memory space?
> 
> This should be a safe assumption for this driver.  Remember, this
> driver just does offload memcpy, from one region to another.  So the
> PCI memory that you are reading from should be just a buffer of data,
> and there should be side-effect of reading it.
> 
> However, I would like to see a comment at the top of the file warning
> people that copying from PCI memory will result in prefetched reads.
> 

Here's a few results from DMA tests between two
MPC8349EA boards housed in a CPCI chassis.

1. DMA mode register (DMAMRn)
    PCI read command (PRC, bits 11:10)

    a) DMAMRn[PRC] = 00 = PCI Read

       The PCI read command is 6h on the PCI bus.
       For DMA lengths of less than 1 cache line (32-bytes)
       the DMA controller will generate a PCI 6h command.
       However, for lengths of 32-bytes and higher, the
       DMA controller actually generates a PCI Read Line (Eh)
       command.

       Freescale indicated that this 'change of PCI command code'
       functionality is an undocumented 'feature', there to
       improve performance for longer read lengths.

    b) DMAMRn[PRC] = 01 = PCI Read Line

       Generated the PCI command code for PCI read line (Eh),
       regardless of DMA length.

    c) DMAMRn[PRC] = 10 = PCI Read Multiple

       Generated the PCI command code for PCI Read Multiple (Ch),
       regardless of DMA length.

2. DMA from areas marked as non-prefetchable.

    We setup two test cases:

    a) Two boards in the same PCI segment with no intervening
       bridges.

    b) Two boards in separate PCI segments with intervening
       bridges (in this case, there was two bridges on SBS
       CPCI-to-CPI backplane bridging cards).

    The PCI window to the IMMR registers on the boards is marked
    as non-prefetchable. DMA from that area (reads) appeared on the
    PCI bus as single 32-bit read transactions, i.e., the target
    device effectively ignores the PCI read command, and the target
    returns read data as single reads, i.e., the target acts as
    as non-prefetchable memory.

    We tested with the PCI Read Multiple command, and no data
    was ever prefetched from the target. The bridges did not
    prefetch and discard data, eg. we tried 36-bytes, and there
    were 9 separate 4-byte transactions (we were using a 32-bit
    PCI host for this test). Hence, at least for this example
    target device, there are no side effects to using PCI
    read multiple on the bus master, to a target PCI memory
    region marked as non-prefetchable.

    So even though the bridges were seeing transactions that
    indicated read multiple, only single read cycles were
    seen to be used.

Would you like some sort of summary of this info for a commit
message?

Would you like us to check any other transaction/register combos?

Cheers,
Dave
