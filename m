Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 14C12679FF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 19:03:05 +1100 (EST)
Date: Thu, 16 Feb 2006 00:03:03 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Phil Nitschke <Phil.Nitschke@avalon.com.au>
Subject: Re: scatter/gather DMA and cache coherency
Message-ID: <20060216080303.GD23150@gate.ebshome.net>
References: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 16, 2006 at 05:51:20PM +1030, Phil Nitschke wrote:
> Hi,
> 
> I've been using a PCI device driver developed by a third party company.
> It uses a scatter/gather DMA I/O to transfer data from the PCI device
> into user memory.  When using a buffer size of about 1 MB, the driver
> achieves a transfer bandwidth of about 60 MB/s, on a 66 MHz, 32-bit
> bus.
> 
> The problem is, that sometimes the data is corrupt (usually on the first
> transfer).  We've concluded that the problem is related to cache
> coherency.  The Artesyn 2.6.10 reference kernel (branched from the
> kernel at penguinppc.org) must be built with CONFIG_NOT_COHERENT_CACHE=y,
> as Artesyn have never successfully verified operation with hardware
> coherency enabled.
> My understanding is that their Marvel system controller (MV64460)
> supports cache snooping, but their Linux kernel support hasn't caught up
> yet.
> 
> So if I understand my situation correctly, the device driver must use
> software-enforced coherency to avoid data corruption.  Is this correct?
> 
> What currently happens is this:
> 
> The buffers are allocated with get_user_pages(...)
> 
> After each DMA transfer is complete, the driver invalidates the cache
> using  __dma_sync_page(...)

No, buffers must be invalidated _before_ DMA transfer, not after. 
Also, don't use internal PPC functions like __dma_sync_page. Please, 
read Documentation/DMA-API.txt for official API.

-- 
Eugene
