Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-01.nyroc.rr.com (ms-smtp-01.nyroc.rr.com [24.24.2.55])
	by ozlabs.org (Postfix) with ESMTP id D849967B26
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Apr 2006 12:17:59 +1000 (EST)
Date: Sun, 16 Apr 2006 22:17:50 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
In-Reply-To: <200604170407.26111.arnd@arndb.de>
Message-ID: <Pine.LNX.4.58.0604162211430.3718@gandalf.stny.rr.com>
References: <1145049535.1336.128.camel@localhost.localdomain>
	<200604161734.20256.arnd@arndb.de>
	<1145234750.27828.8.camel@localhost.localdomain>
	<200604170407.26111.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, Andi Kleen <ak@suse.de>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	benedict.gaster@superh.com, bjornw@axis.com, Ingo Molnar <mingo@elte.hu>,
	Nick Piggin <nickpiggin@yahoo.com.au>, grundler@parisc-linux.org,
	rusty@rustcorp.com.au, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 17 Apr 2006, Arnd Bergmann wrote:

> Am Monday 17 April 2006 02:45 schrieb Steven Rostedt:
> > > - does not work in real mode, so percpu data can't be used
> > > =C2=A0 inside exception handlers on some architectures.
> >
> > This is probably a big issue. =C2=A0I believe interrupt context in hrti=
mers
> > uses per_cpu variables.
>
> If it's just about hrtimers, it should be harmless, since they
> are run in softirq context. Even regular interrupt handlers are
> always called with paging enabled, otherwise you could not
> have them im modules.

Ah, you're right. You said exceptions, I'm thinking interrupts.  I was a
little confused why it wouldn't work.

>
> > > - memory consumption is rather high when PAGE_SIZE is large
> >
> > That's also something that I'm trying to solve. =C2=A0To use the least =
amount
> > of memory and still have the performance.
> >
> > Now, I've also thought about allocating per_cpu and when a module is
> > loaded, reallocate more memory and copy it again. =C2=A0Use something l=
ike
> > the kstopmachine to sync the system so that the CPUS don't update any
> > per_cpu variables while this is happening, so that things can't get out
> > of sync.
>
> I guess this breaks if someone holds a pointer to a per-cpu variable
> while a module gets loaded.
>

Argh, good point, I didn't think about that.  Hmm, this solution is
looking harder and harder.  Darn, I was really hoping this could be a
little better in space savings and robustness. It's starting to seem
clearer that Rusty's little hack, may be the best solution.

If that's the case, I can at least take comfort in knowing that the time I
spent on this is documented in LKML archives, and perhaps can keep others
from spending the time too.  That said, I haven't quite given up, and may
spend a couple more sleepless nights pondering this.

-- Steve
