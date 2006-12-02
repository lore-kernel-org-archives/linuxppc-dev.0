Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EA53067BE5
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 21:36:00 +1100 (EST)
Subject: Re: Worst case performance of up()
From: Adrian Cox <adrian@humboldt.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1164661336.11001.9.camel@localhost.localdomain>
References: <1164385262.11292.76.camel@localhost.localdomain>
	<1164401124.5653.86.camel@localhost.localdomain>
	<1164661336.11001.9.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 10:35:54 +0000
Message-Id: <1165055754.4380.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-11-27 at 21:02 +0000, Adrian Cox wrote:
> On Sat, 2006-11-25 at 07:45 +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2006-11-24 at 16:21 +0000, Adrian Cox wrote:
> > > Does anybody have any ideas what could make up() take so long in this
> > > circumstance? I'd expect cache transfers to make the operation about 100
> > > times slower, but this looks like repeated cache ping-pong between the
> > > two CPUs.
> > 
> > Is it hung in up() (toplevel) or __up (low level) ?
> 
> Not yet proven.

By using a scope, I have further data: the system is hung in this line
of resched_task() in kernel/sched.c:
	set_tsk_thread_flag(p, TIF_NEED_RESCHED);

During this time, there is a great deal of ARTRY activity on the bus.
The sequence ends when the other CPU takes a timer tick.

I'll need to track down what the other CPU is doing at this point, but
my current hypothesis is that it's somewhere in schedule().

> > Have you tried some oprofile runs to catch the exact instruction where
> > the cycles appear to be wasted ?

Oprofile turned out to break the error condition, by increasing the
interrupt rate on each CPU.  In the end a combination of lockmeter and
an oscilloscope did the trick.


-- 
Adrian Cox <adrian@humboldt.co.uk>
