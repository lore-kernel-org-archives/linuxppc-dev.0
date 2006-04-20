Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 1579D67A04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 04:57:48 +1000 (EST)
Date: Thu, 20 Apr 2006 20:57:46 +0200 (MEST)
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
To: linuxppc-dev@ozlabs.org,debian-powerpc@lists.debian.org
MIME-Version: 1.0
Subject: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <28892.1145559466@www088.gmx.net>
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I try to implement not coherent cache/DMA support for G3/G4 processors, by
reserving some physical memory for DMA operations. The memory used for
consistent allocations (removed from the top of the physical memory below
896MB) is excluded from the BAT mapping and the pages are marked as
reserved. This seems to work just fine, although I still have to mark the
pages as cache inhibited.

Whilst working on this workaround for the AmigaOne and reading some articles
about the Linux kernel page tables and memory management, I came to the
conclusion that there may be some problems with this approach for not
coherent DMA: 

1. The AmigaOne is similar to the PREP platform, i.e. DMA can only be
performed in the first 16MB for ISA devices (there's only a VIA southbridge,
no other SuperI/O IC with 32bit capable DMA controller). I guess the first
16MB cannot be reserved for not coherent DMA operation, because this memory
area is occupied by kernel data? (not to talk about the performance loss, if
the kernel data area would be excluded from the BAT mapping).

2. I'm not sure how to allocate memory for DMA operation. I think
alloc_pages() will not do the job for me, as the page tables for not
coherent DMA are reserved (SetPageReserved()) and removed from the available
lowmem. Also memory fragmentation may be a problem, if a lot DMA operations
with different buffer sizes are performed. Therefore a system could quickly
run out of memory for not coherent DMA operation, right?
Is there a way to minimize fragmentation?

3. How are DMA buffers used outside the kernel? Do user programs get a
pointer to the DMA buffer (in theory) from the device driver or is the data
copied to another buffer allocated by an user program?

Thanks!

Regards,

Gerhard

-- 
--
-- AmigaOne Linux kernel project:
-- http://amigaone-linux.sourceforge.net
--

Analog-/ISDN-Nutzer sparen mit GMX SmartSurfer bis zu 70%!
Kostenlos downloaden: http://www.gmx.net/de/go/smartsurfer
