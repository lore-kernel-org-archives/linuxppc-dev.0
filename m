Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp111.mail.mud.yahoo.com (smtp111.mail.mud.yahoo.com
	[209.191.84.64]) by ozlabs.org (Postfix) with SMTP id 49E9ADDE25
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jun 2008 12:19:42 +1000 (EST)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MMIO and gcc re-ordering issue
Date: Wed, 4 Jun 2008 12:19:27 +1000
References: <1211852026.3286.36.camel@pasglop>
	<200806031416.18195.nickpiggin@yahoo.com.au>
	<alpine.LFD.1.10.0806030746190.3473@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0806030746190.3473@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806041219.28099.nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org, tpiepho@freescale.com,
	linuxppc-dev@ozlabs.org, scottwood@freescale.com,
	David Miller <davem@davemloft.net>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 June 2008 00:47, Linus Torvalds wrote:
> On Tue, 3 Jun 2008, Nick Piggin wrote:
> > Linus: on x86, memory operations to wc and wc+ memory are not ordered
> > with one another, or operations to other memory types (ie. load/load
> > and store/store reordering is allowed). Also, as you know, store/load
> > reordering is explicitly allowed as well, which covers all memory
> > types. So perhaps it is not quite true to say readl/writel is strongly
> > ordered by default even on x86. You would have to put in some
> > mfence instructions in them to make it so.
>
> Well, you have to ask for WC/WC+ anyway, so it's immaterial. A driver that
> does that needs to be aware of it. IOW, it's a non-issue, imnsho.

Ah, yes UC is strongly ordered WRT all others *except* WC/WC+.

But WC memory is not an x86 specific thing right, so do we need
some accessors for WC memory? Or can we just throw that in the
weakly ordered pile, and ensure mb/rmb/wmb does the right thing
for them.

And you want readl/writel to be strongly ordered like x86 on all
architectures, no exceptions? This will slow some things down,
but if we then also provide explicitly weakly ordered instructions
(and add io_mb/io_rmb/io_wmb) then at least it gives the framework
for drivers to be written to run on those architectures.

The other thing we could do is mandate only that readl/writel will
be ordered WRT one another, *and* with spinlocks, but otherwise not
with cacheable RAM...
