Return-Path: <Phil.Nitschke@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 115BF679F1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 18:32:11 +1100 (EST)
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: linuxppc-embedded@ozlabs.org
Subject: scatter/gather DMA and cache coherency
Date: Thu, 16 Feb 2006 17:51:20 +1030
Message-ID: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I've been using a PCI device driver developed by a third party company.
It uses a scatter/gather DMA I/O to transfer data from the PCI device
into user memory.  When using a buffer size of about 1 MB, the driver
achieves a transfer bandwidth of about 60 MB/s, on a 66 MHz, 32-bit
bus.

The problem is, that sometimes the data is corrupt (usually on the first
transfer).  We've concluded that the problem is related to cache
coherency.  The Artesyn 2.6.10 reference kernel (branched from the
kernel at penguinppc.org) must be built with CONFIG_NOT_COHERENT_CACHE=y,
as Artesyn have never successfully verified operation with hardware
coherency enabled.
My understanding is that their Marvel system controller (MV64460)
supports cache snooping, but their Linux kernel support hasn't caught up
yet.

So if I understand my situation correctly, the device driver must use
software-enforced coherency to avoid data corruption.  Is this correct?

What currently happens is this:

The buffers are allocated with get_user_pages(...)

After each DMA transfer is complete, the driver invalidates the cache
using  __dma_sync_page(...)

Only on close() does the driver set the pages dirty, like this:

  /* Set each cache page dirty */
  for (ipage = 0; ipage < nr_pages; ipage++)
  {
    if (!PageReserved (pages[ipage]))
      SetPageDirty ( pages[ ipage ] );
  }

  /* Every mapped page must be released from the page cache */
  for (ipage = 0; ipage < nr_pages; ipage++)
    page_cache_release ( pages[ ipage ] );

According to my reading of "Linux Device Drivers, Third Edition" by
Jonathan Corbet, Alessandro Rubini, and Greg Kroah-Hartman,
SetPageDirty() should be called every time the pages are changed (not
just when the pages are released).  (OTOH, the text does not mention the
__dma_sync_page() routine at all.)

Could this be the cause of the corruption we're seeing?

If not, are there any other steps required to enforce "software"
coherency?

--
Phil
