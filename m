Return-Path: <jesse.barnes@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by ozlabs.org (Postfix) with ESMTP id 46849DDD07
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 05:05:50 +1000 (EST)
From: Jesse Barnes <jesse.barnes@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: wmb vs mmiowb
Date: Wed, 22 Aug 2007 12:02:11 -0700
References: <20070822045714.GD26374@wotan.suse.de>
	<alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0708221049560.30176@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708221202.12403.jesse.barnes@intel.com>
Cc: Nick Piggin <npiggin@suse.de>, linux-ia64@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday, August 22, 2007 11:07 am Linus Torvalds wrote:
> > It really seems like it is some completely different concept from a
> > barrier. And it shows, on the platform where it really matters
> > (sn2), where the thing actually spins.
>
> I agree that it probably isn't a "write barrier" per se. Think of it
> as a "tie two subsystems together" thing.

Right, maybe it's not the best name, but as long as you separate your 
memory access types, you can think of it as a real write barrier, just 
for mmio accesses (well uncached access really).

> (And it doesn't just matter on sn2. It also matters on powerpc64,
> although I think they just set a flag and do the *real* sync in the
> spin_unlock() path).

Yeah, they keep threatening to use this instead, but I'm not sure how 
easy it would be.  Also they may have more devices/drivers to worry 
about than sn2, so maybe changing over would mean too much driver 
debugging (well auditing really since it's not that hard to know where 
to put them).  Irix actually had an io_unlock() routine that did this 
implicitly, but iirc that was shot down for Linux...

Jesse
