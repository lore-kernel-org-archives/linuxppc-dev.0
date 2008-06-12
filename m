Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18513.4925.711881.794221@cargo.ozlabs.ibm.com>
Date: Thu, 12 Jun 2008 22:14:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: MMIO and gcc re-ordering issue
In-Reply-To: <200806111535.24523.nickpiggin@yahoo.com.au>
References: <1211852026.3286.36.camel@pasglop>
	<200806111500.30789.nickpiggin@yahoo.com.au>
	<18511.24317.31038.926337@cargo.ozlabs.ibm.com>
	<200806111535.24523.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
	Trent Piepho <tpiepho@freescale.com>, linuxppc-dev@ozlabs.org,
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

Nick Piggin writes:

>                 /* turn off LED */
>                 val64 = readq(&bar0->adapter_control);
>                 val64 = val64 &(~ADAPTER_LED_ON);
>                 writeq(val64, &bar0->adapter_control);
>                 s2io_link(nic, LINK_DOWN);
>         }
>         clear_bit(__S2IO_STATE_LINK_TASK, &(nic->state));
> 
> Now I can't say definitively that this is going to be wrong on
> powerpc, because I don't know the code well enough. But I'd be
> 90% sure that the unlock is not supposed to be visible to
> other CPUs before the writeqs are queued to the card. On x86 it
> wouldn't be.

Interestingly, there is also a store to cacheable memory
(nic->device_enabled_once), but no smp_wmb or equivalent before the
clear_bit.  So there are other potential problems here besides the I/O
related ones.

Anyway, I have done some tests on a dual G5 here with putting a sync
on both sides of the store in writel etc. (i.e. making readl/writel
strongly ordered w.r.t. everything else), and as you predicted, there
wasn't a noticeable performance degradation, at least not on the
couple of things I tried.  So I am now inclined to accept your
suggestion that we should do that.  I should probably do some similar
checks on POWER6 and a few other machines first, though.

Paul.
