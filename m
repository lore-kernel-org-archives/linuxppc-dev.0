Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id 6C39267B61
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Feb 2006 09:36:51 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Tue, 14 Feb 2006 15:36:50 -0700
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: handle Book E debug exceptions on kernel stack
Message-ID: <20060214223649.GA2542@xyzzy.farnsworth.org>
References: <20060214190700.GB17822@xyzzy.farnsworth.org>
	<Pine.LNX.4.44.0602141556200.2609-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.44.0602141556200.2609-100000@gate.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Feb 14, 2006 at 03:57:58PM -0600, Kumar Gala wrote:
> Let me look at this a little, however, I'm amused by the 

Thanks.

> smp_processor_id() usage on 8548.  Its a single core SoC, so any reason 
> SMP is turned on in your kernel?

I haven't turned on SMP in my 8548 kernel.

The kgdb singlestep code calls smp_processor_id() even on UP.
It doesn't really need to call it on UP, but smp_processor_id()
still should work.  I would have preferred seeing #ifdef
CONFIG_SMP scattered throughout that code, but it's not my code.
Anyway, the smp_processor_id() calls happen to return the
correct value on UP, even on the critical exception stack,
since that stack area is initialized to 0.

The issue I actually hit is that for CONFIG_PREEMPT, the calls
to spin_lock() and spin_unlock() increment and decrement
current_thread_info()->preempt_count. This breaks things
when the preempt_count goes negative.

> Not, that your patch, isn't needed for a SMP Book-E, just wondering.

Yes, I'm looking forward to trying out a dual-core processor.

-Dale

> On Tue, 14 Feb 2006, Dale Farnsworth wrote:
> 
> > From: Dale Farnsworth <dale@farnsworth.org>
> > 
> > On PPC Book E processsors, we currently handle debug
> > exceptions on the critical exception stack (debug stack
> > for E200).  This causes problems with the kgdb single
> > step handler, which calls smp_processor_id() and spin_lock(),
> > which reference current_thread_info(), which only works when
> > we are on the kernel stack.
> > 
> > We address this by switching to the kernel stack early while
> > handling debug exceptions.  Note that the entry values of r10
> > and r11 are still saved on the critical exception (or debug) stack.
> > 
> > Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
