Date: Sun, 10 Feb 2002 14:43:14 -0700
From: Val Henson <val@nmt.edu>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix heartbeat
Message-ID: <20020210144314.B6321@boardwalk>
References: <20020208184610.E28166@boardwalk> <15460.50887.161245.222054@argo.ozlabs.ibm.com> <20020209172353.A32151@boardwalk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020209172353.A32151@boardwalk>; from val@nmt.edu on Sat, Feb 09, 2002 at 05:23:53PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 09, 2002 at 05:23:53PM -0700, Val Henson wrote:
>
> On Sat, Feb 09, 2002 at 05:50:47PM +1100, Paul Mackerras wrote:
> > Val Henson writes:
> > >
> > > The heartbeat function will not execute properly on Gemini without
> > > this patch. (Check for cpu 0 removed from gemini_heartbeat.)
> >
> > CHRP needs the heartbeat function called on all cpus, IIRC.
> >
> > Clearly the heartbeat_count needs to be per-cpu or else pushed into
> > the heartbeat function.  How about we make it just
> >
> > 	if (ppc_md.heartbeat)
> > 		ppc_md.heartbeat();
> >
> > and let the heartbeat function do the if (!smp_processor_id()) and the
> > if (!heartbeat_count--) if it wants?
>
> Ah, I see, the heartbeat_count is now being decremented once per timer
> interrupt, instead of smp_nr_cpus times per timer interrupt.  Last
> time I checked, it was still possible for the heartbeat count to go
> negative.
>
> It's fine the way it is.  Sorry for the unnecessary patch.

Tsk, shouldn't read patches on the weekend... Here's the current code:

        if (ppc_md.heartbeat && !ppc_md.heartbeat_count--)
                ppc_md.heartbeat();

This decrements the count on every processor.  If cpu 0 turns off
interrupts interrupts for a while, we get two effects: heartbeat_count
is now decremented smp_nr_cpus - 1 times per timer interrupt, and if
your heartbeat function doesn't explicitly prevent it, your heartbeat
count could go negative.

An alternative that allows you to run the heartbeat function on
whatever cpus you like but decrements the heartbeat once per timer
interrupt is:

        if (ppc_md.heartbeat && !smp_processor_id()
	         ppc_md.heartbeat_count--)

        if (!ppc_md.heartbeat_count)
                ppc_md.heartbeat();

Howz that?

-VAL

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
