Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DE47DDF96
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 08:47:45 +1000 (EST)
Subject: Re: lockdep badness
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080724193828.GF9594@localdomain>
References: <20080724192300.GE9594@localdomain>
	<20080724193828.GF9594@localdomain>
Content-Type: text/plain
Date: Fri, 25 Jul 2008 08:47:39 +1000
Message-Id: <1216939659.11188.61.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-07-24 at 14:38 -0500, Nathan Lynch wrote:
> Nathan Lynch wrote:
> > 
> > A couple of stack traces below, the first is from benh's tree, the
> > second is from 2.6.26.  The lockdep self-tests all pass at boot.
> 
> Sorry, should have pointed out the code that is warning more
> specifically.
> 
> 
> > RTAS daemon started
> > RTAS: event: 295, Type: Dump Notification Event, Severity: 2
> > ------------[ cut here ]------------
> > Badness at kernel/lockdep.c:2719
> 
> check_flags():
> 
>         if (irqs_disabled_flags(flags)) {
>                 if (DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)) {
>                         printk("possible reason: unannotated
>                 irqs-off.\n");
>                 }
>         } else {
> >>>             if (DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)) {
>                         printk("possible reason: unannotated
>                 irqs-on.\n");
>                 }
>         }

Yes, it looks like at some point the IRQ state gets out of sync, and I
haven't found out where yet. Having a repro case would help, what is the
setup of your machine ? I seems to be related to having an RTAS event at
boot.


> > ipr: IBM Power RAID SCSI Device Driver version: 2.4.1 (April 24, 2007)
> > ipr 0000:00:01.0: Found IOA with IRQ: 289
> > ipr 0000:00:01.0: Starting IOA initialization sequence.
> > ipr 0000:00:01.0: Adapter firmware version: 02200023
> > ipr 0000:00:01.0: IOA initialized.
> > ------------[ cut here ]------------
> > Badness at kernel/lockdep.c:2037
> 
> trace_hardirqs_on():
> 
>         if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
>                 return;
> >>>     if (DEBUG_LOCKS_WARN_ON(current->hardirq_context))
>                 return;

As I said before, I'm not 100% sure what that is, it smells like
something legal that Ingo made not so anymore but I need to double
check.

Cheers,
Ben.
