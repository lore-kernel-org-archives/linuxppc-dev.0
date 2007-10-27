Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9ECB8DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Oct 2007 11:40:58 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9R1eXZA028902
	for <linuxppc-embedded@ozlabs.org>; Fri, 26 Oct 2007 21:40:33 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9R1eWx4140168
	for <linuxppc-embedded@ozlabs.org>; Fri, 26 Oct 2007 21:40:32 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9R1eWKF029263
	for <linuxppc-embedded@ozlabs.org>; Fri, 26 Oct 2007 21:40:32 -0400
Subject: Re: Apparent kernel bug with GDB on ppc405
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
In-Reply-To: <1193448983.18243.16.camel@pasglop>
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org> <20071024215421.GF19691@waste.org>
	<fa686aa40710241527j1a316760lf36d512eb625810f@mail.gmail.com>
	<20071024223250.GI19691@waste.org>
	<20071024224130.GA30819@caradoc.them.org>
	<1193363482.7018.41.camel@pasglop>
	<20071026154126.28082129@weaponx.rchland.ibm.com>
	<1193448983.18243.16.camel@pasglop>
Content-Type: text/plain
Date: Fri, 26 Oct 2007 20:27:36 -0500
Message-Id: <1193448456.25515.63.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: gdb@sourceware.org, Matt Mackall <mpm@selenic.com>,
	linuxppc-embedded@ozlabs.org, Daniel Jacobowitz <drow@false.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, 2007-10-27 at 11:36 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2007-10-26 at 15:41 -0500, Josh Boyer wrote:
> > On Fri, 26 Oct 2007 11:51:22 +1000
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > 
> > > On Wed, 2007-10-24 at 18:41 -0400, Daniel Jacobowitz wrote:
> > > > On Wed, Oct 24, 2007 at 05:32:50PM -0500, Matt Mackall wrote:
> > > > > Not completely implausible, but a) why isn't this seen on basically
> > > > > every machine with software TLB? b) why does -local- GDB, which is
> > > > > presumably doing much less work than gdbserver + network stack, not fail?
> > > > 
> > > > You said it yourself.  Local gdb does more work -> blows through more
> > > > TLB entries.
> > > > 
> > > > I can't answer you about the other half, but I'm pretty sure TLB
> > > > invalidation is already supposed to be happening... somewhere.
> > > 
> > > Yes. do_wp_page() -> ptep_clear_flush() -> flush_tlb_page()
> > 
> > Aren't there cases in do_wp_page that don't call ptep_clear_flush?
> > Seems anonymous pages, and possibly shared writeable pages skip that
> > step if reuse is true.
> 
> Nah, if that was broken, everybody would be in bad shape. I think I know
> what's up, see my other email.

Yeah, I figured that out after I sent this anyway.  In those cases it
should likely get flushed from ptep_set_access_flags.

josh
