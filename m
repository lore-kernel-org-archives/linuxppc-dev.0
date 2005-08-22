Return-Path: <steve@icarus.com>
Received: from icarus.com (icarus.icarus.com [64.105.89.2])
	by ozlabs.org (Postfix) with ESMTP id 2A4DA6801D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Aug 2005 03:47:32 +1000 (EST)
Message-ID: <430A0FB2.4040500@icarus.com>
Date: Mon, 22 Aug 2005 10:47:30 -0700
From: Stephen Williams <steve@icarus.com>
MIME-Version: 1.0
To: Stephen Williams <steve@icarus.com>
References: <4309E2AC.9080404@icarus.com>	<20d4aca8d8032c5762deb047185d2c6e@embeddededge.com>
	<430A0AB9.20000@icarus.com>
In-Reply-To: <430A0AB9.20000@icarus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mmap nocache on PPC, 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Stephen Williams wrote:
> Dan Malek wrote:

> | Even if this did what you thought it should, I'm not sure you
> | would be happy with the results.  The challenge is ensuring
> | anyone that touches these physical pages also does so
> | uncached.  Depending upon the processor, this isn't something
> | that is trivial to change in the kernel, since we always map
> | all of memory as efficiently as possible with a cached mapping.
> | The caching of memory has many desirable performance
> | side effects, making the trade off the manage coherency in
> | software if needed an overall system gain.
> 
> The processor is touching this memory only very briefly to put
> image headers around the data, and even at that it would need
> to be immediately flushed again so that it can be DMAed off the
> system.
> 
> My problem is that I need a lot of memory that is mostly accessed
> by high performance devices that make lots of data, and only
> very occasionally accessed by the processor for minor fixups.
> Caching is very much getting in my way here in this specialized
> case, I think.

I would like to add that it is not exactly the cache that is
getting in my way, but *cache invalidation*. For the tests I'm
running the destination buffer is 16Meg. The PPC405GPr 266MHz
is taking 10ms to invalidate the cache for all that memory and
another 6ms to "map" it and get physical addresses for DMA, but
I need it to be turned around in more like 1ms.

Of the 16ms to turn the buffer around, I've eliminated 10ms
simply by treating the memory of the buffer as uncached. I'm
hoping to work on the remaining 6ms by premapping where I can.


-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."
