Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3A739DE07C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 11:51:34 +1000 (EST)
Subject: Re: Apparent kernel bug with GDB on ppc405
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Jacobowitz <drow@false.org>
In-Reply-To: <20071024224130.GA30819@caradoc.them.org>
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org> <20071024215421.GF19691@waste.org>
	<fa686aa40710241527j1a316760lf36d512eb625810f@mail.gmail.com>
	<20071024223250.GI19691@waste.org>
	<20071024224130.GA30819@caradoc.them.org>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 11:51:22 +1000
Message-Id: <1193363482.7018.41.camel@pasglop>
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


On Wed, 2007-10-24 at 18:41 -0400, Daniel Jacobowitz wrote:
> On Wed, Oct 24, 2007 at 05:32:50PM -0500, Matt Mackall wrote:
> > Not completely implausible, but a) why isn't this seen on basically
> > every machine with software TLB? b) why does -local- GDB, which is
> > presumably doing much less work than gdbserver + network stack, not fail?
> 
> You said it yourself.  Local gdb does more work -> blows through more
> TLB entries.
> 
> I can't answer you about the other half, but I'm pretty sure TLB
> invalidation is already supposed to be happening... somewhere.

Yes. do_wp_page() -> ptep_clear_flush() -> flush_tlb_page()

Ben.
