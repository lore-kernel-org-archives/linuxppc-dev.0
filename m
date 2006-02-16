Return-Path: <greg.buhler@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 330D5679EA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 05:23:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: scatter/gather DMA and cache coherency
Date: Thu, 16 Feb 2006 10:23:20 -0800
Message-ID: <68997D3094017740BB875EB2A425A6EA02E46197@VCAEXCH01.hq.corp.viasat.com>
From: "Buhler, Greg" <greg.buhler@viasat.com>
To: <Phil.Nitschke@avalon.com.au>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Phil,
If the third party DMA driver is not proprietary send it over and I'd be
happy to take a look at it for you. I have been working with an
(unfortunately proprietary) scatter/gather DMA driver which uses all 4
of the DMA channels on a PPC405gp and have had to fix several cache
coherency problems to get SGDMA working properly.

I have this driver working properly on a branch of linux-2.4.21, and am
currently porting it to linux-2.6.15.4.

Make sure to post any findings you have to the list.

______________________
Greg Buhler
760.476.2699

-----Original Message-----
From: linuxppc-embedded-bounces+greg.buhler=3Dviasat.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+greg.buhler=3Dviasat.com@ozlabs.org] =
On
Behalf Of Phil Nitschke
Sent: Wednesday, February 15, 2006 11:21 PM
To: linuxppc-embedded@ozlabs.org
Subject: scatter/gather DMA and cache coherency

Hi,

I've been using a PCI device driver developed by a third party company.
It uses a scatter/gather DMA I/O to transfer data from the PCI device
into user memory.  When using a buffer size of about 1 MB, the driver
achieves a transfer bandwidth of about 60 MB/s, on a 66 MHz, 32-bit
bus.

The problem is, that sometimes the data is corrupt (usually on the first
transfer).  We've concluded that the problem is related to cache
coherency.  The Artesyn 2.6.10 reference kernel (branched from the
kernel at penguinppc.org) must be built with
CONFIG_NOT_COHERENT_CACHE=3Dy,
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
  for (ipage =3D 0; ipage < nr_pages; ipage++)
  {
    if (!PageReserved (pages[ipage]))
      SetPageDirty ( pages[ ipage ] );
  }

  /* Every mapped page must be released from the page cache */
  for (ipage =3D 0; ipage < nr_pages; ipage++)
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
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
