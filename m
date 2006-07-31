Return-Path: <Phil.Nitschke@avalon.com.au>
Received: from ash25e.internode.on.net (ash25e.internode.on.net
	[203.16.214.182]) by ozlabs.org (Postfix) with ESMTP id 2E950679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 23:10:29 +1000 (EST)
Received: from toby.int.avalon.com.au (ppp208-249.lns1.adl2.internode.on.net
	[203.122.208.249])
	by ash25e.internode.on.net (8.13.6/8.13.5) with ESMTP id k6VDASoS002508
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Jul 2006 22:40:28 +0930 (CST)
	(envelope-from Phil.Nitschke@avalon.com.au)
Received: from toby.int.avalon.com.au (toby.int.avalon.com.au [127.0.0.1])
	by toby.int.avalon.com.au (8.13.6/8.13.6/Debian-1) with ESMTP id
	k6VDARw8014596
	for <linuxppc-embedded@ozlabs.org>; Mon, 31 Jul 2006 22:40:27 +0930
Received: (from phil@localhost)
	by toby.int.avalon.com.au (8.13.6/8.13.6/Submit) id k6VDARaw014593
	for linuxppc-embedded@ozlabs.org; Mon, 31 Jul 2006 22:40:27 +0930
Subject: DMA buffer synchronisation with ioremap()
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Mon, 31 Jul 2006 22:40:27 +0930
Message-Id: <1154351427.3203.59.camel@toby.int.avalon.com.au>
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

(I go no replies last week, so I'll try again, with less explanation...)

If I master a DMA from a PCI device into a main memory buffer allocated
with dma_alloc_noncoherent(), I need to synchronise the destination
buffer using dma_sync_single_range_for_xxx() before and after the DMA.

But if the buffer is a very large chunk of memory (reserved at boot
time) which has been ioremap()-ed into the virtual address space, do I
need to still synchronise that memory?

Thanks,

-- 
Phil
