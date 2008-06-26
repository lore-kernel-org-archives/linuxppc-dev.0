Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 71B61DE58D
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 21:55:23 +1000 (EST)
Subject: Re: [PATCH/RFC] powerpc: prevent memory corruption due to cache
	invalidation of unaligned DMA buffer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Lewis <andrew-lewis@netspace.net.au>
In-Reply-To: <48636161.6080603@netspace.net.au>
References: <48636161.6080603@netspace.net.au>
Content-Type: text/plain
Date: Thu, 26 Jun 2008 20:55:48 +1000
Message-Id: <1214477748.8011.464.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-26 at 17:29 +0800, Andrew Lewis wrote:
> On PowerPC processors with non-coherent cache architectures the DMA
> subsystem calls invalidate_dcache_range() before performing a DMA read
> operation.  If the address and length of the DMA buffer are not aligned
> to a cache-line boundary this can result in memory outside of the DMA
> buffer being invalidated in the cache.  If this memory has an
> uncommitted store then the data will be lost and a subsequent read of
> that address will result in an old value being returned from main memory.

Thanks for providing a fix. The problem is old and in fact was discussed
a while ago, unfortunately, it looks like the SCSI folks didn't fix it
yet.

In theory, on non-cache coherent architecture, buffers that can be
DMA'ed should not share cache lines with other objects. This is violated
by the SCSI code due to recent changes to the way the sense buffer is
allocated. Various solutions were proposed, including a __dma_buffer
alignment directive, but back then, the wind blew more toward changing
the way the buffer is allocated in the SCSI stack.

Some people started working on that and I lost track. It looks like it
wasn't properly fixed :-(

I'll ack your patch for now as workaround, though it would be good to
have some kind of debug option to make it WARN_ON when the unaligned
case happen, to track them down and help fix them. I'll try to catch up
with the SCSI folks to see what's up on this side.

In the meantime:

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
