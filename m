Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id AE63267A6D
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Apr 2006 08:23:57 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 21 Apr 2006 00:07:08 +0200
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Subject: Re: Not coherent cache DMA for G3/G4 CPUs: clarification needed
Message-ID: <20060420220707.GA17593@iram.es>
References: <28892.1145559466@www088.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <28892.1145559466@www088.gmx.net>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 20, 2006 at 08:57:46PM +0200, Gerhard Pircher wrote:
> Hi,
> 
> I try to implement not coherent cache/DMA support for G3/G4 processors, by
> reserving some physical memory for DMA operations. The memory used for
> consistent allocations (removed from the top of the physical memory below
> 896MB) is excluded from the BAT mapping and the pages are marked as
> reserved. This seems to work just fine, although I still have to mark the
> pages as cache inhibited.
> 
> Whilst working on this workaround for the AmigaOne and reading some articles
> about the Linux kernel page tables and memory management, I came to the
> conclusion that there may be some problems with this approach for not
> coherent DMA: 
> 
> 1. The AmigaOne is similar to the PREP platform, i.e. DMA can only be
> performed in the first 16MB for ISA devices (there's only a VIA southbridge,
> no other SuperI/O IC with 32bit capable DMA controller). 

More details please what are the exact capabilities of the south and
host bridges? 

I've never needed (and therefore) used floppy on my PreP boards (Motorola
MVME2[467]xx series), but they have a south bridge (WinBond) that has 32
bit DMA capability. This was specified in the PreP spec. 

This may also depend on the host bridge since RAM appears at 2GB on
default PreP machines, which is an area that you can't access with
normal ISA DMA anyway. On the MVME machines, you could map PCI addresses
0-16 MB anywhere in RAM by reprogramming the host bridge.

However I actually reprogram the chipset to look like CHRP, i.e., 
1:1 mapping of RAM to PCI. This caused problems a long time
ago since sometimes DMA went to VGA video memory instead of RAM.
This was when kernels were not bloated enough to at least occupy
768kB of RAM, nowadays there is strictly no risk.

> 3. How are DMA buffers used outside the kernel? Do user programs get a
> pointer to the DMA buffer (in theory) from the device driver or is the data
> copied to another buffer allocated by an user program?

If your memory is uncacheable, you are better off copying it to
cacheable memory. At least you are sure that you only access it 
once (trying to copy with FP registers to halve the number of
accesses might be a big win, but you need to be careful).

	Regards,
	Gabriel
