Message-ID: <3E5CDF99.3080708@koffie.nl>
Date: Wed, 26 Feb 2003 16:39:05 +0100
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Possible bug in flush_dcache_all on 440GP
References: <5.1.0.14.2.20030225185928.00ac3198@mail.zultys.com>
In-Reply-To: <5.1.0.14.2.20030225185928.00ac3198@mail.zultys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin wrote:

> I believe there is a bug in flush_dcache_all implementation for not cache
> coherent processors.
>
> This function uses simple algorithm to force dcache flush by reading
> "enough" data to completely reload the cache:

[snip]

So you're saying it doesn't use an LRU replacement algorithm
but a FIFO one?

> 1) Use twice as much memory than the cache size. This solution is not very
> efficient,
>    but it doesn't add _any_ special requirements to the memory we use to
> reload the
>    cache with.

That doesn't work correctly, either, in that case.  You have to
read the same memory region twice, not read a twice as big region
once.


Segher


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
