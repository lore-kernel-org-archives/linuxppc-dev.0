Date: Tue, 18 Sep 2001 10:29:01 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Errata 67/77 / walnut bugs (was: Re: Erratum 51 bugfix?)
Message-ID: <20010918102901.A1183@zax>
References: <20010917152316.O3851@zax> <3BA62583.55E48A97@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA62583.55E48A97@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 17, 2001 at 12:32:03PM -0400, Dan Malek wrote:
>
> David Gibson wrote:
> >
> > According to the ppc405gp errata, the workaround for erratum 51 is
> > incorrect.
>
> Got it, thanks.  I actually went to read the 4xx errata this time instead
> of just blindly accepting the patch as I did last time.  There are some
> other nasty things we should consider fixing.  The worst is #67, and now
> they have told us about #77 so we can fix up the ATOMIC_SYNC_FIX....

> Of all the errata, #77 is the only one we have seen with Linux.  I guess
> you could force #51 to occur, but whether you call ITLBmiss or DTLBmiss
> probably doesn't matter because they end up at the same place.  We are
> somewhat lucky with #67 because I don't think we have mapping situations
> where this can occur.  Although, some days I read it and think otherwise.....

Yes, #67 is very nasty, and although it doesn't occur under normal
circumstances, I'm pretty sure it can be triggered by an unprivileged
process.  Userland doesn't generally have the page at 0x0 mapped, but
it can be mapped in with mmap(...MAP_FIXED...) (I checked).  Place
some code at 0x500 or 0x1100 and user programs can execute an
arbitrary instruction or two in privileged mode.  Nasty.

The sanest fix I can think of is to simply ban MAP_FIXED at address
0x0 on 4xx.

I suspect #77 is the cause of the problems I'm seeing on the walnut
now - it mostly works, but every so often a process will freeze up
immune to signals.  Then, anything that looks too hard at it (ps, cat
/proc/##/cmdline) will also freeze up.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
