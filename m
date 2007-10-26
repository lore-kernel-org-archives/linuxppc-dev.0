Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 119F6DDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 27 Oct 2007 06:41:32 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9QKfT3w013215
	for <linuxppc-embedded@ozlabs.org>; Fri, 26 Oct 2007 16:41:29 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9QKfSTa062784
	for <linuxppc-embedded@ozlabs.org>; Fri, 26 Oct 2007 14:41:28 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9QKfRbP011290
	for <linuxppc-embedded@ozlabs.org>; Fri, 26 Oct 2007 14:41:28 -0600
Date: Fri, 26 Oct 2007 15:41:26 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: Apparent kernel bug with GDB on ppc405
Message-ID: <20071026154126.28082129@weaponx.rchland.ibm.com>
In-Reply-To: <1193363482.7018.41.camel@pasglop>
References: <20071024194640.GB19691@waste.org>
	<fa686aa40710241328x77435cc1lf09cac730b0ce5ac@mail.gmail.com>
	<20071024204215.GC19691@waste.org>
	<20071024215421.GF19691@waste.org>
	<fa686aa40710241527j1a316760lf36d512eb625810f@mail.gmail.com>
	<20071024223250.GI19691@waste.org>
	<20071024224130.GA30819@caradoc.them.org>
	<1193363482.7018.41.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 26 Oct 2007 11:51:22 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Wed, 2007-10-24 at 18:41 -0400, Daniel Jacobowitz wrote:
> > On Wed, Oct 24, 2007 at 05:32:50PM -0500, Matt Mackall wrote:
> > > Not completely implausible, but a) why isn't this seen on basically
> > > every machine with software TLB? b) why does -local- GDB, which is
> > > presumably doing much less work than gdbserver + network stack, not fail?
> > 
> > You said it yourself.  Local gdb does more work -> blows through more
> > TLB entries.
> > 
> > I can't answer you about the other half, but I'm pretty sure TLB
> > invalidation is already supposed to be happening... somewhere.
> 
> Yes. do_wp_page() -> ptep_clear_flush() -> flush_tlb_page()

Aren't there cases in do_wp_page that don't call ptep_clear_flush?
Seems anonymous pages, and possibly shared writeable pages skip that
step if reuse is true.

josh
