Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 086CBB70D8
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2011 01:15:42 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: Flushing data cache on PPC405 in Linux
Date: Thu, 24 Feb 2011 07:15:28 -0700
In-Reply-To: <B5790C8E-AC59-4588-B4C5-A636A4EC1F98@digitaldans.com>
References: <ef11a825-8824-460f-91c0-82cb8029ed81@VA3EHSMHS029.ehs.local>
	<B5790C8E-AC59-4588-B4C5-A636A4EC1F98@digitaldans.com>
From: John Linn <John.Linn@xilinx.com>
To: Dan Malek <ppc6dev@digitaldans.com>
Message-ID: <59dfbee6-41a9-4da3-8ce4-db5857b82060@VA3EHSMHS036.ehs.local>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Dan Malek [mailto:ppc6dev@digitaldans.com]
> Sent: Wednesday, February 23, 2011 8:39 PM
> To: John Linn
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: Flushing data cache on PPC405 in Linux
> =

> =

> Hi John.
> =

> On Feb 23, 2011, at 5:04 PM, John Linn wrote:
> =

> > Any thoughts?
> =

> I can come up with two methods, but before I describe them
> ensure you consider the actual implementation of your 405 core.
> My comments are based on the "standard" ppc405 processor,
> but since you can configure the embedded cores to your liking,
> the cache size may be different that the 16K bytes on the old
> processor.
> =

> Method one.  Just 'memset()' 16K of data that will replace all cache
> lines and push out modified lines.  This 16K must be physically
> contiguous, so allocate in your favorite way, with with the cache
> coherent DMA functions, bootmem, reserved, whatever.  Just
> ensure that this 16K is also cached, as I've implemented
> dma_cache_coherent into uncached VM space in the past :-)

Awesome Dan, that seems reasonable to me and much easier than I was
thinking :)

I was obviously making it harder than it had to be as usual. Seems like
I can just kmalloc the memory then memset it. =


Appreciate the help and suggestions.

-- John

> =

> Method two.  Use 'dcread' to read the cache tags.  If the line is
> modified, form an EA that will match that line and 'dcbf' the line.
> This is a little more tricky because the tags are physical addresses,
> so you would need to do this with the MMU disabled to ensure
> the physical EA you generated also hits the cache.  The upside
> is you only perform the actual required flush operations, and you
> didn't blow the cache away requiring a refill latency.
> =

> Have fun!
> =

> 	-- Dan
> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
