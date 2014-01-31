Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (torres.puc.rediris.es
 [IPv6:2001:720:418:ca00::9])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B8F512C0078
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 23:56:25 +1100 (EST)
Date: Fri, 31 Jan 2014 13:31:57 +0100
From: Gabriel Paubert <paubert@iram.es>
To: "Moese, Michael" <michael.moese@men.de>
Subject: Re: PCIe Access - achieve bursts without DMA
Message-ID: <20140131123157.GA6148@visitor2.iram.es>
References: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2DF74D4E746FF14C8697D5041AAE72D56A2B1420@MEN-EX2.intra.men.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 30, 2014 at 12:20:21PM +0000, Moese, Michael wrote:
> Hello PPC-developers,
> I'm currently trying to benchmark access speeds to our PCIe-connected IP-cores
> located inside our FPGA. On x86-based systems I was able to achieve bursts for
> both read and write access. On PPC32, using an e500v2, I had no success at all 
> so far. 
> I tried using ioremap_wc(), like I did on x86, for writing, and it only results in my
> writes just being single requests, one after another.

I believe that on PPC, write-combine is directly mapped to nocache. I can't remember
if there is a writethrough option for ioremap (but adding it would probably be
relaively easy).

> For reads, I noticed I could not ioremap_cache() on PPC, so I used simple ioremap()
> here. 

You might be able to use ioremap_cache and using direct cache control instruction
(dcbf/dcbi) to achieve your goals. This becomes similar to handling machines with 
no hardware cache coherency. You have to know the hardware cache line size to make
this work.

This said, it might be better to mark the memory as guarded and non-coherent 
(WIMG=0000), I don't know what ioremap_cache does for the MG bits and don't
have the time to look it up right now.

> I used several ways to read from the device, from simple readl(),memcpy_from_io(), 
> memcpy()  to cacheable_memcpy() - with no improvements.  Even when just issuing
> a batch of prefetch()-calls for all the memory to read did not result in read bursts.

If the device data you want to read is supposed to be cacheable (which means basically
that the data does not change unexpectedly under you, i.e., is not as volatile as
a typical device I/O register), you don't want to use readl() which adds some
synchronization to the read.

Prefetch only works on writeback memory, maybe writethrough, expecting it to work on
cache-inhibited memory is contradictory.

	Regards,
	Gabriel
