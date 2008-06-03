Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9CF4DDFE6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 07:33:16 +1000 (EST)
Date: Tue, 3 Jun 2008 15:33:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: MMIO and gcc re-ordering issue
Message-ID: <20080603213310.GC3549@parisc-linux.org>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	<20080602072403.GA20222@flint.arm.linux.org.uk>
	<200806031416.18195.nickpiggin@yahoo.com.au>
	<Pine.LNX.4.64.0806031154050.3242@t2.domain.actdsltmp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0806031154050.3242@t2.domain.actdsltmp>
Cc: linux-arch@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 03, 2008 at 12:43:21PM -0700, Trent Piepho wrote:
> IOW, there are four ways one can defined endianness/swapping:
> 1) Little-endian
> 2) Big-endian
> 3) Native-endian aka non-byte-swapping
> 4) Foreign-endian aka byte-swapping
> 
> 1 and 2 are by far the most used.  Some code wants 3.  No one wants 4.  Yet
> our API is providing 3 & 4, the two which are the least useful.

You've fundamentally misunderstood.

readX/writeX and __readX/__writeX provide little-endian access.
__raw_readX provide native-endian.

If you want 2 or 4, define your own accessors.  Some architectures define
other accessors (eg gsc_readX on parisc is native (big) endian, and
works on physical addresses that haven't been ioremapped.  sbus_readX on
sparc64 also seems to be native (big) endian).

> Is it enough to provide only "all or none" for ordering strictness?  For
> instance on powerpc, one can get a speedup by dropping strict ordering for 
> IO
> vs cacheable memory, but still keeping ordering for IO vs IO and IO vs 
> locks. This is much easier to program for than no ordering at all.  In 
> fact, if one
> doesn't use coherent DMA, it's basically the same as fully strict ordering.

I don't understand why you keep talking about DMA.  Are you talking
about ordering between readX() and DMA?  PCI proides those guarantees.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
