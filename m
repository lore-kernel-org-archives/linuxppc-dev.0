Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25E7067C05
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 07:25:58 +1100 (EST)
Subject: Re: Worst case performance of up()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
In-Reply-To: <1165239794.17906.14.camel@localhost.localdomain>
References: <1164385262.11292.76.camel@localhost.localdomain>
	<1164401124.5653.86.camel@localhost.localdomain>
	<1164661336.11001.9.camel@localhost.localdomain>
	<1165055754.4380.15.camel@localhost.localdomain>
	<1165058151.22108.31.camel@localhost.localdomain>
	<1165060484.4380.18.camel@localhost.localdomain>
	<1165092773.22108.47.camel@localhost.localdomain>
	<1165239794.17906.14.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 07:25:46 +1100
Message-Id: <1165263946.29784.13.camel@localhost.localdomain>
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

On Mon, 2006-12-04 at 13:43 +0000, Adrian Cox wrote:
> On Sun, 2006-12-03 at 07:52 +1100, Benjamin Herrenschmidt wrote:
> > On Sat, 2006-12-02 at 11:54 +0000, Adrian Cox wrote:
> > > On Sat, 2006-12-02 at 22:15 +1100, Benjamin Herrenschmidt wrote:
> > > > I think we are hitting a livelock due to both CPUs trying to perform an
> > > > atomic operation on the same cache line (or same variable even).
> > > 
> > > I agree.
> 
> I now have this one identified and fixed. The cure is actually simple:
> on 32-bit SMP machines, rather than setting powersave_nap to 0, set
> ppc_md.power_save to NULL.
> 
> CPU A is attempting to reschedule the idle thread on CPU B:
> set_tsk_thread_flag(p, TIF_NEED_RESCHED);
> 
> CPU B is in the idle loop, but does not support nap. The result is that
> ppc6xx_idle() returns immediately, and CPU B runs in a tight loop:
> while(...) {
> 	set_thread_flag(TIF_POLLING_NRFLAG);
> 	...
> 	clear_thread_flag(TIF_POLLING_NRFLAG);
> }
> 
> If ppc_md.power_save is NULL, then the idle loop does not touch the flag
> word of the idle thread, and everything works.

Good to know, there might be other cases of performance issues due to
touching that flag in a loop...

Ben.
