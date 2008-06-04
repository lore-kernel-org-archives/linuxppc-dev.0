Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp105.mail.mud.yahoo.com (smtp105.mail.mud.yahoo.com
	[209.191.85.215]) by ozlabs.org (Postfix) with SMTP id EEB96DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 12:32:43 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Trent Piepho <tpiepho@freescale.com>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 4 Jun 2008 12:25:49 +1000
References: <1211852026.3286.36.camel@pasglop>
	<20080603213310.GC3549@parisc-linux.org>
	<Pine.LNX.4.64.0806031439520.3242@t2.domain.actdsltmp>
In-Reply-To: <Pine.LNX.4.64.0806031439520.3242@t2.domain.actdsltmp>
MIME-Version: 1.0
Message-Id: <200806041225.50058.nickpiggin@yahoo.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
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

On Wednesday 04 June 2008 07:44, Trent Piepho wrote:
> On Tue, 3 Jun 2008, Matthew Wilcox wrote:

> > I don't understand why you keep talking about DMA.  Are you talking
> > about ordering between readX() and DMA?  PCI proides those guarantees.
>
> I guess you haven't been reading the whole thread.  The reason it started
> was because gcc can re-order powerpc (and everyone else's too) IO accesses
> vs accesses to cachable memory (but not spin-locks), which ends up only
> being a problem with coherent DMA.

I don't think it is only a problem with coherent DMA.

CPU0                         CPU1
mutex_lock(mutex);
writel(something, DATA_REG);
writel(GO, CTRL_REG);
started = 1;
mutex_unlock(mutex);
                             mutex_lock(mutex);
                             if (started)
                               /* oops, this can reach device before GO */
                               writel(STOP, CTRL_REG);
                               
