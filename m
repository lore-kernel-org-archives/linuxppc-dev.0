Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 912D168802
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2005 11:05:48 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <21714.1133476127@www44.gmx.net>
References: <1133403468.5248.28.camel@gaston> <21714.1133476127@www44.gmx.net>
Content-Type: text/plain
Date: Fri, 02 Dec 2005 10:58:55 +1100
Message-Id: <1133481536.6100.32.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc@lists.debian.org
Subject: Re: AmigaOne 2.6.x Linux kernel port
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> As far as I can understand you refer to the non cocherent DMA memory
> allocation functions in arch/ppc/kernel/dma-mapping.c, right? Regarding the
> BAT mapping: can you give me an example for this or a link to a reference
> implementation?, because I'm afraid I can only image for now, what you're
> trying to explane me (as I said, I'm a kernel newbie, but I'll try to do
> what I can). :-)

(I'm moving this to the linuxppc-dev list)

Well, you need consistent alloc functions to really provide you with
non-cached memory. Fushing is not enough. Flushing is fine for dma_map
etc..., not for consistent alloc.

So in theory, you should be able to re-use the existing consistent
allocation functions, except that the current implementation has
"issues":

The main problem I see with the implementation is that it just allocates
pages out of the normal kernel allocator and maps them in the
"consistent" virtual range without ever unmapping them from the kernel
linear mapping. That means that those pages end up being mapped twice:
cacheable and non-cacheable, which is absolutely wrong and will explode
in colorful ways on a number of CPUs. The pages should at least be
unmapped from the kernel linear (& cacheable) mapping.

I understand this is probably done to keep the TLB miss handler for the
kernel mapping as fast as possible. Unfortunately, it's also incorrect
if your processor is capable of any kind of prefetching accross a 4k
boundary.

Then, remains the BAT mapping problem. In order to improve performances,
the kernel uses BATs to map the main memory (to know more about BATs,
look at the proccessor docs). That means that unmapping the memory from
the linear mapping will not work if that memory happens to be covered by
a BAT (there aren't even page tables entries for those pages anyway).
Thus, in order to be able to reliably unmap things from the linear
mapping (or individually change page attributes) you need to disable BAT
mapping of memory, either completely, or by preallocating (and thus
actually reserving) memory outside of the BAT mapping for use in the
consistent allocator.

However, the exception handling of the kernel is designed with the
assumption that it will not take hash faults in some critical locations,
and this assumption is correct thanks to ... the BAT mapping. You are
lucky though that recent kernels have been fixed to be able to recover
from such faults provided the instructions are still BAT mapped, so you
can probably hack the initialisation of the memory on ppc to not use
data BATs but only instruction BATs and still create the page tables for
the entire memory. That will allow you to implement proper unmapping of
pages in the consistent allocator. However, it will also impact your
overall performances ...

Ben.
