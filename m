Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 31212B7010
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Oct 2011 22:06:48 +1100 (EST)
Date: Thu, 6 Oct 2011 13:06:45 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 0/4] powerpc: Mark various interrupts IRQF_NO_THREAD
Message-ID: <20111006110645.GA18554@iram.es>
References: <20111005122122.553832402@linutronix.de>
	<20111005132949.GA25028@iram.es>
	<alpine.LFD.2.02.1110051722140.18778@ionos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.02.1110051722140.18778@ionos>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 05, 2011 at 05:31:48PM +0200, Thomas Gleixner wrote:
> On Wed, 5 Oct 2011, Gabriel Paubert wrote:
> 
> > On Wed, Oct 05, 2011 at 12:30:49PM -0000, Thomas Gleixner wrote:
> > > The following series marks the obvious interrupts IRQF_NO_THREAD to
> > > prevent forced interrupt threading - no guarantee of completeness :)
> > > 
> > > The last patch enables the forced threading mechanism in the core
> > > code, which in turn enables the "irqthreaded" commandline option.
> > 
> > Is there any description of what "interrupt threading" means?
> 
> That means that the interrupt handler is running in a thread. The
> interrupt itself merily wakes the thread. That's a debugging option in
> mainline - it comes handy when interrupt handlers crash as the system
> just kills the thread, but stays otherwise alive. If the same
> situation happens in the normal hard interrupt context, then it takes
> them machine down completely.
> 
> Aside of that it's a prerequisite to support PREEMPT_RT on your
> arch/machine.
> 
> > I'm only looking for a pointer to a web page, a mailing list thread
> 
> https://lwn.net/Articles/429690/

Thanks.

> 
> > (I am no more subscribed to lkml, too many things to do, so maybe
> > it has been discussed but it comes out of the blue on linuxppc-dev), 
> > or a well commented git commit?
> > 
> > >From followups, I see that cascaded interrupt controller should
> > not be threaded. I suspect that the private VME bridge driver
> > (Universe chip) I maintain here will need it: clients request
> > a given VME interrupt (level/vector) and specify an interrupt
> > handler which is called by the handler for the PCI interrupt.
> 
> Can't tell as I don't know how your code looks like. If your
> subinterrupts are registered with the core interrupt system and the
> drivers install their handlers via request_irq(), then yes. If you
> just have your own registration and handling stuff (which you
> shouldn't) then you might be better off to let the dispatch interrupt
> handler be threaded so that all the demuxed ones run in that same
> thread.


Well, for now I have my own registration, because when I originally wrote
the code (over a decade ago), there was no simple way to add potentially
~1800 additional interrupt sources (and the size of the interrupt descriptor
array on a machine with 16MB of RAM was not negligible, it became several
percent of the, minimalistic, kernel). 

This might be feasible now, but I still have boards with the first release 
of the bridge, which has very nasty interrupt related bugs (sometimes it 
incorrectly reports the level, only the vector is correct).

	Regards,	
	Gabriel
