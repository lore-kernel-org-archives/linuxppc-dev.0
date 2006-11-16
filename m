Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6480067B77
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 22:32:16 +1100 (EST)
Subject: Re: [PATCH 11/16] PATA driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
In-Reply-To: <200611160939.kAG9dqre027595@toshiba.co.jp>
References: <200611160939.kAG9dqre027595@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 22:32:03 +1100
Message-Id: <1163676724.5940.378.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> We use a drivers/ide driver because its design is more suitable for
> SCC IDE controller than libata driver. But we will try to implement
> the libata driver as needed. This work needs to override many 
> callbacks of ata_port_operations by modifying generic helpers.

Yup, that's basically the same problem I have with mpc52xx... all of the
port reset & error handling code in libata does direct IO access and
thus if you need special IO accessors, you need to re-implement the
whole thing, which isn't very nice.

I have ideas on how we can fix libata but I haven't had time to talk to
Jeff much about it yet.

> We use the PRD transfer end read function on SCC IDE controller
> to handle this issue.
> This function guarantees that issue of DMA End interrupt and
> setting the interrupt bit of status register are done after 
> the outstanding write data to memory was pushed. Pushing is 
> implemented by the dummy read of IDE controller, which reads 
> the same path as the path of the write data. 
> Therefore this function is same as the flush of outstanding DMAs.
> To use this function, we specify the PRD table address(dmatable_dma) 
> in PRD Transfer End Read Base Address Register(dma_base + 0x018) as
> the path. Of course it also requires to set a strong order in 
> the IOIF space.

I haven't seem the dummy read in your code.. where is it ?

> > - Regarding PCI and PCIe on SCC, I didn't see any code in your PCI
> >support code for handling that issue. Is it fixed ? If not, then I
> >suppose you'll have problem with most PCI device/drivers on the field as
> >they do rely on such ordering to be provided. There was also an issue
> >with prefetch on PCI, for which I currently disable the prefetch in the
> >workarounds for the cell blade. I don't know if you handle that at all
> >neither.
> 
> We've noticed the problem you mentioned, and been developing the support
> for dummy read(please refer to previous comments for IDE) and etc. to solve
> the problem, but we haven't finished yet.  We also currently  disable the
> prefetch by initial setup of SCC.  We are trying now so that we can post
> the fixed driver code in next patch.

Ok. Can you confirm that the prefetch disable is the same was what I'm
doing for Spider ? (see my patch about IO workarounds posted last week).

The patch I posted handles both the dummy read and the prefetch disable.
I've added a mecanism to hook on all MMIO accesses to make that
possible. You may want to do something very similar.

Cheers,
Ben.
