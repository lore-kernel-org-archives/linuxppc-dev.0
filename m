Message-ID: <38CCE7A2.6027@cygnus.com>
Date: Mon, 13 Mar 2000 05:05:38 -0800
From: Michael Snyder <msnyder@cygnus.com>
Reply-To: msnyder@cygnus.com
MIME-Version: 1.0
To: Kevin Buettner <kev@primenet.com>
CC: jjs <Jerry.Sexton@insignia.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: gdb and multi-threaded applications.
References: <017c01bf8a91$0e74f460$571170c1@honda.isltd.insignia.com> <1000310213225.ZM27738@saguaro.lan>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin Buettner wrote:
>
> On Mar 10,  1:03pm, jjs wrote:
>
> > Sorry I have not been back to you sooner, I have been distracted by other
> > things. I tried getting a test application to exhibit the same behaviour
> > with no luck. However, I did notice that before the call to pthread_create
> > to start up the new thread we have the line:
> >
> >     pthread_sigmask(SIG_BLOCK, &fullSigMask, &sigMask);
> >
> > All the bits in fullSigMask are set, so this call blocks all signals to the
> > calling thread. Commenting this line out makes everything work under gdb,
> > the new thread gets created and doing 'info threads' after this gives me a
> > list of all the threads running in the process. This implies that gdb
> > requires a signal to be unblocked at the point the thread is created.

Your analysis is correct.  The linuxthreads library uses certain
signals to communicate and synchronize between threads.  GDB
listens in on these signals.  Most commonly they are SIGUSR32,
SIGUSR33 and SIGUSR34, but this is not always the case.  I would
think that blocking these signals might affect more than just
GDB debugging (ie. it might affect the program's behavior directly).

> > If
> > this is fact the case, which signal must we not block in order for correct
> > operation under gdb?
>
> SIGCHLD.
>
> (I think.)

SIGCHLD does come into play as well, although I have never
fully understood its role.  Try unblocking SIGCHLD, but also
be prepared to try unblocking the ones I mentioned above.

> Background for Michael: Jerry reported a problem in which gdb (on
> linux/ppc) hangs on a pthread_create().   Jerry has verified that
> the thread tests in the test suite work properly on his platform,
> so we know that gdb does work (some of the time) when creating
> new threads.  Jerry's application is proprietary and I've asked him
> to try to distill the problem into a small example that we can test.
>
> Note to Jerry: I'd still like a small example, preferably one that
> we could eventually put into the testsuite.
>
> Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
