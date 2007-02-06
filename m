Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46123DDE37
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 10:33:06 +1100 (EST)
Subject: Re: [PATCH 0/11] Patches for Toshiba Cell reference set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1170804615.2620.257.camel@localhost.localdomain>
References: <1170633321.2620.56.camel@localhost.localdomain>
	<200702061301.l16D1lxf009347@toshiba.co.jp>
	<17864.60804.657656.535779@cargo.ozlabs.ibm.com>
	<1170804615.2620.257.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 10:33:00 +1100
Message-Id: <1170804780.2620.260.camel@localhost.localdomain>
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

On Wed, 2007-02-07 at 10:30 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2007-02-07 at 08:05 +1100, Paul Mackerras wrote:
> > Ishizaki Kou writes:
> > 
> > > We found that following phenomenon:
> > >  - An application calls "munmap"
> > >  - do_munmap flushes TLB (so HTAB is invalidated)
> > >  - when exiting spin_unlock(), DEC exception occurs. (!)
> > >  - One of DEC handler causes data storage interrupt
> > 
> > Interesting.  Did you find out exactly what was causing the DSI in the
> > decrementer interrupt handling?  It sounds like that is the real bug.
> 
> Not necessarily... DEC -> module -> vmalloc'ed or ioremap'ed access for
> example would trigger a DSI.
> 
> The Hash routines expect irqs off when called.

Argh ! Actually no ! They expect irqs off in insert and updatepp, not in
invalidate. You'll notice that iSeries invalidate does a
local_irq_disable.

Ishiazaki-san: The proper fix is to do that too for Celleb. That is,
continue using a normal spinlock and add a local_irq_save/restore in
your invalidate callback (and only that one).

I wonder if we should "clean" that up and move that to the caller
though, and thus have a more consisent interface to the hash code.

Ben.
