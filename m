Date: Wed, 19 Sep 2001 12:19:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
Message-ID: <20010919121954.D13693@zax>
References: <20010917152316.O3851@zax> <3BA62583.55E48A97@mvista.com> <20010918102901.A1183@zax> <3BA7980B.EEBF1F5D@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA7980B.EEBF1F5D@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Sep 18, 2001 at 02:52:59PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
>
> > I suspect #77 is the cause of the problems I'm seeing on the walnut
> > now - it mostly works, but every so often a process will freeze up
> > immune to signals.
>
> Hmmm...We did tons of debugging on this one and pointed it out to
> IBM a while back.  The ATOMIC_SYNC_FIX configuration option was the
> solution to cure it.  As you can tell, it tries to address the
> pipeline issues surrounding the stwcx.  I kind of hope it is the
> problem, and a better silicon bug fix will solve it.

Ah, yes, I discovered ATOMIC_SYNC_FIX after I sent that, and have now
turned it on.  That should certainly fix the atomic ops, however there
are quite a number of other places where the kernel uses stwcx., which
ATOMIX_SYNC_FIX doesn't fix - notably arch/ppc/kernel/bitops.c and
include/asm-ppc/bitops.h.  As well as activating ATOMIX_SYNC_FIX I
tried inserting a sync before every other stwcx. that I could find,
and I haven't managed to get a process to lock up yet.

Is there a reason we don't need the sync (or dcbt) everywhere, or
should I send you the patch (once I've cleaned it up).

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
