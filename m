Message-ID: <384EF3D1.DFC1D281@jlc.net>
Date: Wed, 08 Dec 1999 19:12:01 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Grant Erickson <grant@lcse.umn.edu>
CC: linuxppc-embedded@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: PPC Cache Flush and Invalidate Routines
References: <Pine.SGI.4.10.9912081623090.145056-100000@brule.borg.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Grant Erickson wrote:
> 
> In trying to accomodate the 4xx-based code into the Linux kernel, I've
> encountered an issue which relates to the cache flushing and invalidation
> routines in misc.S.

> Thoughts, opinions?


We could simply create a configuration #define for the cache line size
that is assigned in the 'make config' scripts when the processor type
is chosen.

A further, and more challenging, problem arises in the library
relocation functions.  When writing instructions to memory, the data
caches have to be pushed, instruction caches invalidated, and the
functions assume a 32 byte cache line.  This doesn't work well on the
16 byte line processors.  We discussed this a long time ago without
resolution.  The old C libraries on the ppc.kernel.org server that I
built for the 8xx have this corrected.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
