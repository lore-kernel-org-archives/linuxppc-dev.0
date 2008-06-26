Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id DAB8BDE2C9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 21:20:53 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 26 Jun 2008 12:32:15 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <48636161.6080603@netspace.net.au>
Message-ID: <20080626103215.170810@gmx.net>
MIME-Version: 1.0
References: <48636161.6080603@netspace.net.au>
Subject: Re: [PATCH/RFC] powerpc: prevent memory corruption due to cache
	invalidation of unaligned DMA buffer
To: Andrew Lewis <andrew-lewis@netspace.net.au>, linuxppc-dev@ozlabs.org
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Thu, 26 Jun 2008 17:29:05 +0800
> Von: Andrew Lewis <andrew-lewis@netspace.net.au>
> An: linuxppc-dev@ozlabs.org
> CC: \'Andrew Lewis\' <andrew-lewis@netspace.net.au>, paulus@samba.org
> Betreff: [PATCH/RFC] powerpc: prevent memory corruption due to cache	invalidation of unaligned DMA buffer

> On PowerPC processors with non-coherent cache architectures the DMA
> subsystem calls invalidate_dcache_range() before performing a DMA read
> operation.  If the address and length of the DMA buffer are not aligned
> to a cache-line boundary this can result in memory outside of the DMA
> buffer being invalidated in the cache.  If this memory has an
> uncommitted store then the data will be lost and a subsequent read of
> that address will result in an old value being returned from main memory.
> 
> Only when the DMA buffer starts on a cache-line boundary and is an exact
> mutiple of the cache-line size can invalidate_dcache_range() be called,
> otherwise flush_dcache_range() must be called.  flush_dcache_range()
> will first flush uncommitted writes, and then invalidate the cache.
I have a similar problem, but with a network driver (which uses cacheable
skbuffers as DMA memory). The SLUB allocator should return cache line
aligned memory, but that doesn't prevent data corruption. I fixed it by
setting NET_SKB_PAD (default 16)  to L1_CACHE_BYTES (32 on my 7455
non coherent DMA system).
It looks like your patch could solve my problem without changing
NET_SKB_PAD. I'll have to try that out.

regards,

Gerhard
-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
