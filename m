Message-ID: <20000316093540.5653.qmail@web216.mail.yahoo.com>
Date: Thu, 16 Mar 2000 01:35:40 -0800 (PST)
From: "D.J. Barrow" <barrow_dj@yahoo.com>
Subject: Re: SIGALRM can't be delivered after longjmp from handler?
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I reported this bug & other signal handling ones on
the mailing list over a year ago, I ported the signal
code to S/390 & found that tftp wasn't working & even
sent demo code of this problem to the mailing list
needless to say I was more or less ignored. There also
is a problem in the bloody moronic way the power pc's
signal handler queues multiple signals in the user
spaces stack in do_signal & when a longjmp is done out
of the signal handler all the queued signals are
trashed & dropped ( so much for reliable signal
handling ) & the old blocked states are also lost.

A partial cure for the blocked signals as you
correctly stated is to use siglongjmp & sigsetjmp
which will unblock the SIGALRM however this doesn't
get rid of the problem that if multiple signals are
put on the stack for delivery at the same time they
are lost if a siglongjmp is done out of the first one
to be delivered. The intel code should be copied is
still not great but a good deal better than the PPC
crap & only attempts to deliver one signal at a time &
thus circumventing this problem.


After quickly looking at the 2.3.48 source I believe
this problem is still there.
--- "David A. Gatwood"
<dgatwood@deepspace.mklinux.org> wrote:
>
> On Wed, 15 Mar 2000, Peter M. Jansson wrote:
>
> > Did that; no effect.
>
> Well, it did for me, but I had to change the
> location of the signal()
> line.  The installation of the signal handler has to
> occur before the
> sigsetjmp or else the longjmp() restores an empty
> set of handlers.
>
>
> 1.  Move the if (signal(...)) line to right after
> the printf("Cycle...")
> line
>
> 2.  Change setjmp(jmp_buf) to sigsetjmp(jmp_buf,1)
>
> 3.  Change longjmp to siglongjmp
>
> 4.  add a signal(...) line to the beginning of the
> signal handler
>
> The program then works as it did on *BSD.
>
>
> David
>
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
