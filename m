Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A516DDE46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 11:51:07 +1000 (EST)
Subject: Re: Apparent kernel bug with GDB on ppc405
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40710241540y498b0c92le63920862d6b9315@mail.gmail.com>
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org> <20071024215421.GF19691@waste.org>
	<fa686aa40710241527j1a316760lf36d512eb625810f@mail.gmail.com>
	<20071024223250.GI19691@waste.org>
	<fa686aa40710241539r792380dam62ea820a48dab62e@mail.gmail.com>
	<fa686aa40710241540y498b0c92le63920862d6b9315@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 11:50:53 +1000
Message-Id: <1193363453.7018.38.camel@pasglop>
Mime-Version: 1.0
Cc: gdb@sourceware.org, linuxppc-embedded@ozlabs.org,
	Matt Mackall <mpm@selenic.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Wed, 2007-10-24 at 16:40 -0600, Grant Likely wrote:
> On 10/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > Not completely implausible, but a) why isn't this seen on basically
> > > every machine with software TLB? b) why does -local- GDB, which is
> > > presumably doing much less work than gdbserver + network stack, not fail?
> >
> > a) I don't know.... very odd.
> >
> > b) gdb is big.  It probably touches far more pages (via library calls)
> > than gdbserver.  The network stack is also big, but it's probably more
> > localized too.
> >
> > Niceing down the host also makes sense because if the PC is being slow
> > then the target may go off and run other things while between setting
> > the breakpoint and getting the 'go' command.
> >
> > Can you grab a snapshot of the TLB before and after setting the breakpoint?
> 
> Or; probably more relevant, before and after the page copy?

COW does ptep_clear_flush before setting the new TLB which does a
flush_tlb_page() so that should work.

Ben.
