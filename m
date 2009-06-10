Return-Path: <prasad@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6EF11B70B9
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 10 Jun 2009 16:50:14 +1000 (EST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 440C0DDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 16:50:14 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5AGn2wS001040
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 02:49:02 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5A6oCqC315866
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 16:50:12 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5A6oCN9000307
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jun 2009 16:50:12 +1000
Date: Wed, 10 Jun 2009 12:20:02 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [Patch 3/6] Modify ptrace code to use Hardware Breakpoint
	interfaces
Message-ID: <20090610065002.GB6912@in.ibm.com>
References: <20090603162741.197115376@prasadkr_t60p.in.ibm.com>
	<20090603163524.GD5197@in.ibm.com>
	<20090605051345.GK2054@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090605051345.GK2054@yookeroo.seuss>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 05, 2009 at 03:13:45PM +1000, David Gibson wrote:
> On Wed, Jun 03, 2009 at 10:05:24PM +0530, K.Prasad wrote:
> > Modify the ptrace code to use the hardware breakpoint interfaces for user-space.
> > 
> > Signed-off-by: K.Prasad <prasad@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/ptrace.c |   47 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> > 
> > Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
> > ===================================================================
> > --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/ptrace.c
> > +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/ptrace.c
> > @@ -37,6 +37,7 @@
> >  #include <asm/page.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/system.h>
> > +#include <asm/hw_breakpoint.h>
> >  
> >  /*
> >   * does not yet catch signals sent when the child dies.
> > @@ -735,9 +736,26 @@ void user_disable_single_step(struct tas
> >  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
> >  }
> >  
> > +void ptrace_triggered(struct hw_breakpoint *bp, struct pt_regs *regs)
> > +{
> > +	/*
> > +	 * Unregister the breakpoint request here since ptrace has defined a
> > +	 * one-shot behaviour for breakpoint exceptions in PPC64.
> > +	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> > +	 * We don't have to do anything here
> > +	 */
> > +	unregister_user_hw_breakpoint(current, bp);
> > +	kfree(bp);
> 
> Couldn't you also clear the saved dabr info here, to avoid having to
> special case this in the actual breakpoint handler.
> 

The saved dabr_data is created as a static variable and I didn't want to
modify its value across files.

> Also, I think you should be delivering the signal here - for gdb
> compatibility I think we'll need to match the old behaviour which has
> the TRAP delivered before executing the breakpointed instruction.
> 

We could do it either way. Return a NOTIFY_DONE from
hw_breakpoint_handler() and allow the do_dabr()
code to deliver the signal, or deliver a signal here and return a
NOTIFY_STOP in the exception handler. I chose the former as it doesn't
duplicate the code.

> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Thanks,
K.Prasad
