Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FC9F67B5F
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Dec 2006 00:43:31 +1100 (EST)
Subject: Re: Worst case performance of up()
From: Adrian Cox <adrian@humboldt.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1165092773.22108.47.camel@localhost.localdomain>
References: <1164385262.11292.76.camel@localhost.localdomain>
	<1164401124.5653.86.camel@localhost.localdomain>
	<1164661336.11001.9.camel@localhost.localdomain>
	<1165055754.4380.15.camel@localhost.localdomain>
	<1165058151.22108.31.camel@localhost.localdomain>
	<1165060484.4380.18.camel@localhost.localdomain>
	<1165092773.22108.47.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 13:43:14 +0000
Message-Id: <1165239794.17906.14.camel@localhost.localdomain>
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

On Sun, 2006-12-03 at 07:52 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2006-12-02 at 11:54 +0000, Adrian Cox wrote:
> > On Sat, 2006-12-02 at 22:15 +1100, Benjamin Herrenschmidt wrote:
> > > I think we are hitting a livelock due to both CPUs trying to perform an
> > > atomic operation on the same cache line (or same variable even).
> > 
> > I agree.

I now have this one identified and fixed. The cure is actually simple:
on 32-bit SMP machines, rather than setting powersave_nap to 0, set
ppc_md.power_save to NULL.

CPU A is attempting to reschedule the idle thread on CPU B:
set_tsk_thread_flag(p, TIF_NEED_RESCHED);

CPU B is in the idle loop, but does not support nap. The result is that
ppc6xx_idle() returns immediately, and CPU B runs in a tight loop:
while(...) {
	set_thread_flag(TIF_POLLING_NRFLAG);
	...
	clear_thread_flag(TIF_POLLING_NRFLAG);
}

If ppc_md.power_save is NULL, then the idle loop does not touch the flag
word of the idle thread, and everything works.

-- 
Adrian Cox <adrian@humboldt.co.uk>
