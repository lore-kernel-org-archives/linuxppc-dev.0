Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45B3667B6C
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 10:56:26 +1000 (EST)
Subject: Re: Discontiguous Memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jbahr <jbahr@set-software-services.com>
In-Reply-To: <6332580.post@talk.nabble.com>
References: <6332580.post@talk.nabble.com>
Content-Type: text/plain
Date: Sat, 16 Sep 2006 10:56:19 +1000
Message-Id: <1158368179.14473.203.camel@localhost.localdomain>
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

On Fri, 2006-09-15 at 13:22 -0700, jbahr wrote:
> We have a client building a PPC8548-based product who insists that we
> allocate DRAM real address space in two large chunks at 0-2GB and 4-6GB in
> the 36-bit address space.  It doesn't look like U-Boot's bd_info structure
> allows for that, and it doesn't look like the Linux init routines (which
> accesses the passed table) knows how to handle discontiguous memory either
> (as opposed to X86 Linux, which can accept an E820 table). 
> 
> It looks like Linux cleans out the TLB's pretty quickly, so it wouldn't know
> the VA-to-RA mapping.   
> 
> I've seen papers on some PPC Linuxes that handle large discontiguous real
> DRAM memory spaces, but it doesn't look like the Linux in ELDK does.  Is
> that correct? 
> 
> This is just the start of a headache between the architects and we poor
> implementers.  It's not clear to us that, even with ATMU support, how normal
> drivers are going to know how to create real addresses for buffers and such
> to use when programming DMA controllers or external PCI devices. 
> 
> Are this really a problem or is there kernel provision for the PPC for
> discontiguous real memory DRAM space?
> 
> Any comments would be VERY appreciated. 

There is no support for any of this in the current PowerPC 32 bits
kernel. It's possible to add it, though, but it's not alrady there.
There are two main issues:

 - One is to enable support for sparse memory maps and add the necessary
support to the low mm code. Not terribly hard (see how it's done for 64
bits)

 - A more annoying one is support for DMA since a lot of devices cannot
DMA above 32 bits. A lot of 'sane' platforms that provide more memory
than can be DMA'ed in 32 bits also provide an IOMMU that does page
translation of incoming DMAs. This isn't your case however, thus you
would have to implement some of the alternate solutions used on x86_64
(Intel 64 bits platforms also lack an iommu). This essentially consist
of defining a ZONE_DMA32 and possibly also using swiotlb to do bounce
buffering for drivers that don't deal with ZONE_DMA32 yet.

Ben.
