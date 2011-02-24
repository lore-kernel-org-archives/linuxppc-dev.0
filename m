Return-Path: <ppc6dev@digitaldans.com>
Received: from wsl00026.west-datacenter.net (wsl00026.west-datacenter.net
	[69.36.176.27])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E68AB6F0D
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Feb 2011 14:57:03 +1100 (EST)
Message-Id: <B5790C8E-AC59-4588-B4C5-A636A4EC1F98@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
To: John Linn <John.Linn@xilinx.com>
In-Reply-To: <ef11a825-8824-460f-91c0-82cb8029ed81@VA3EHSMHS029.ehs.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: Flushing data cache on PPC405 in Linux
Date: Wed, 23 Feb 2011 19:38:38 -0800
References: <ef11a825-8824-460f-91c0-82cb8029ed81@VA3EHSMHS029.ehs.local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi John.

On Feb 23, 2011, at 5:04 PM, John Linn wrote:

> Any thoughts?

I can come up with two methods, but before I describe them
ensure you consider the actual implementation of your 405 core.
My comments are based on the "standard" ppc405 processor,
but since you can configure the embedded cores to your liking,
the cache size may be different that the 16K bytes on the old
processor.

Method one.  Just 'memset()' 16K of data that will replace all cache
lines and push out modified lines.  This 16K must be physically
contiguous, so allocate in your favorite way, with with the cache
coherent DMA functions, bootmem, reserved, whatever.  Just
ensure that this 16K is also cached, as I've implemented
dma_cache_coherent into uncached VM space in the past :-)

Method two.  Use 'dcread' to read the cache tags.  If the line is
modified, form an EA that will match that line and 'dcbf' the line.
This is a little more tricky because the tags are physical addresses,
so you would need to do this with the MMU disabled to ensure
the physical EA you generated also hits the cache.  The upside
is you only perform the actual required flush operations, and you
didn't blow the cache away requiring a refill latency.

Have fun!

	-- Dan
