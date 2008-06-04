Return-Path: <tpiepho@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D3E0DDDF6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 16:39:59 +1000 (EST)
Date: Tue, 3 Jun 2008 23:39:06 -0700 (PDT)
From: Trent Piepho <tpiepho@freescale.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <200806041225.50058.nickpiggin@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0806032307580.3242@t2.domain.actdsltmp>
References: <1211852026.3286.36.camel@pasglop>
	<20080603213310.GC3549@parisc-linux.org>
	<Pine.LNX.4.64.0806031439520.3242@t2.domain.actdsltmp>
	<200806041225.50058.nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Jun 2008, Nick Piggin wrote:
> On Wednesday 04 June 2008 07:44, Trent Piepho wrote:
>> On Tue, 3 Jun 2008, Matthew Wilcox wrote:
>
>>> I don't understand why you keep talking about DMA.  Are you talking
>>> about ordering between readX() and DMA?  PCI proides those guarantees.
>>
>> I guess you haven't been reading the whole thread.  The reason it started
>> was because gcc can re-order powerpc (and everyone else's too) IO accesses
>> vs accesses to cachable memory (but not spin-locks), which ends up only
>> being a problem with coherent DMA.
>
> I don't think it is only a problem with coherent DMA.
>
> CPU0                         CPU1
> mutex_lock(mutex);
> writel(something, DATA_REG);
> writel(GO, CTRL_REG);
> started = 1;
 	(A)
> mutex_unlock(mutex);
>                             mutex_lock(mutex);
 	(B)
>                             if (started)
>                               /* oops, this can reach device before GO */
>                               writel(STOP, CTRL_REG);

The locks themselves should have (and do have) ordering operations to insure
gcc and/or the cpu can't move a store or load outside the locked region. 
Generally you need that to keep stores/loads to cacheable memory inside the
critical area, much less I/O operations.  Otherwise all you have to do is
replace writel(something, ...) with shared_data->something = ...  and there's
an obvious problem.  In your example, gcc currently can and will move the GO
operation to point A (if it can figure out that CTRL_REG and started aren't
aliased), but that's not a problem.  If it could move it to B that would be a
problem, but it can't.

Other than coherent DMA, I don't think there is any reason to care if I/O
accessors are strongly ordered wrt load/stores to cacheable memory.  locking
and streaming DMA sync operations already need to have ordering, so they don't
require all I/O to be ordered wrt all cacheable memory.
