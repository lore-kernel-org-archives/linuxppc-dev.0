Date: Wed, 15 Mar 2000 20:50:17 -0500 (EST)
From: "Peter M. Jansson" <petej@clickvision.com>
To: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SIGALRM can't be delivered after longjmp from handler?
In-Reply-To: <200003160147.RAA04377@soda.csua.Berkeley.edu>
Message-ID: <Pine.LNX.4.10.10003152048550.9830-100000@penguin.office.clickvision.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm sorry to be dense, but could you send me your modified version of my
test program?

In an earlier run, I was calling signal inside the signal handler before
the longjmp, and it had no effect, so I removed the code to make the
example as simple as possible.  It's possible I did it wrong, but if you
could send me your changes, I'd be grateful.

Thanks,
    Pete.

On Wed, 15 Mar 2000, Sriranga Veeraraghavan wrote:

>
> For other signals like SEGV and BUS and INTR, I had to re-enable the
> signal by calling signal() after longjmp as specified in the signal(2)
> manpage for Linux:
>
> "Unlike on BSD systems, signals under Linux are reset to their default
> behavior when raised.  However, if you include <bsd/signal.h> instead
> of <signal.h> then signal is redefined as __bsd_signal and signal has
> the BSD semantics.  Both versions of signal are library routines built
> on top of sigaction(2)."
>
> I changed your example program to restore the signal handler routine
> once the signal is raised and it worked as you described. I did not
> try using <bsd/signal.h>. You may wish to try that. I prefer just
> restoring the signal handler, since this avoid #ifdefs for different
> platorms.
>
> ----ranga <ranga@soda.berkeley.edu>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
