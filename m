Message-Id: <200003160147.RAA04377@soda.csua.Berkeley.edu>
To: "Peter M. Jansson" <petej@clickvision.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: SIGALRM can't be delivered after longjmp from handler?
In-Reply-To: Your message of "Wed, 15 Mar 2000 13:41:29 EST."
             <38CFD959.52E9F85@clickvision.com>
Date: Wed, 15 Mar 2000 17:47:22 -0800
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



For other signals like SEGV and BUS and INTR, I had to re-enable the
signal by calling signal() after longjmp as specified in the signal(2)
manpage for Linux:

"Unlike on BSD systems, signals under Linux are reset to their default
behavior when raised.  However, if you include <bsd/signal.h> instead
of <signal.h> then signal is redefined as __bsd_signal and signal has
the BSD semantics.  Both versions of signal are library routines built
on top of sigaction(2)."

I changed your example program to restore the signal handler routine
once the signal is raised and it worked as you described. I did not
try using <bsd/signal.h>. You may wish to try that. I prefer just
restoring the signal handler, since this avoid #ifdefs for different
platorms.

----ranga <ranga@soda.berkeley.edu>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
