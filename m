Date: Tue, 17 Oct 2000 18:38:08 -0700
From: Kevin Buettner <kev@primenet.com>
Message-Id: <1001018013808.ZM29271@localhost.localdomain>
In-Reply-To: Paul Mackerras <paulus@linuxcare.com.au>
        "Re: Allowing signal handlers to modify SE and BE" (Oct 18, 11:01am)
References: <m2lmvoqimb.fsf@c469597-a.grlnd1.tx.home.com>
	<14828.59472.822072.622235@argo.linuxcare.com.au>
To: paulus@linuxcare.com.au, minyard@acm.org
Subject: Re: Allowing signal handlers to modify SE and BE
Cc: <linuxppc-dev@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Oct 18, 11:01am, Paul Mackerras wrote:

> Corey Minyard writes:
>
> > I noticed the following in signal.c:
> >
> > /*
> >  * These are the flags in the MSR that the user is allowed to change
> >  * by modifying the saved value of the MSR on the stack.  SE and BE
> >  * should not be in this list since gdb may want to change these.  I.e,
> >  * you should be able to step out of a signal handler to see what
> >  * instruction executes next after the signal handler completes.
> >  * Alternately, if you stepped into a signal handler, you should be
> >  * able to continue 'til the next breakpoint from within the signal
> >  * handler, even if the handler returns.
> >  */
> > #define MSR_USERCHANGE	(MSR_FE0 | MSR_FE1)
>
> This came from Kevin Buettner in July 1997 when he was hacking on gdb
> to get it working properly under ppc/linux.  I don't know if Kevin is
> still around or who the current maintainer of gdb on ppc/linux is.  We
> can change this definition if you can get an ack from someone who
> knows that it won't break gdb.

I'm still around and I'm also the linux/ppc gdb maintainer.

I have not been paying close attention to changes in the kernel, so I
do not know for certain that adding MSR_SE (and MSR_BE) to the list of
bits that are restored from the signal frame would break gdb.

I suspect that it would, however.  Here's the scenario:  You're
debugging a program with gdb and you are stopped at the end of a
signal handler.  You then use si (as many times as necessary) to step
out of the signal handler and into the sigtramp code on the stack.  As
Corey mentioned in a previous message, gdb uses ptrace() to set the SE
bit to cause a single step to occur.  Eventually, you'll hit the ``sc''
instruction and this'll take you into one of sys_sigreturn() or
sys_rt_sigreturn().

When we get into sys_sigreturn() or sys_rt_sigreturn() in this
scenario, we want to make sure that SE stays set when we start
executing the user process again.  If we don't, gdb will not stop as
it should.  It seems to me that if we add MSR_SE to MSR_USERCHANGE,
we'll be taking the SE value off the user stack which will effectively
ignore the value set by ptrace().

I've just consulted my mail archives, and at the time that I sent Paul
the patch which removed MSR_SE and MSR_BE from MSR_USERCHANGE, I noted
that this patch fixed a gdb testsuite failure.  Here's what I said:

	* The SE and BE flags of the MSR are _not_ restored from the
	  signal frame.  This is so that gdb can step out of a signal
	  handler.  (See comment in the patch for more details.)  This
	  eliminated one of the unexpected failures in running the gdb
	  test suite.

If you really want to be able to allow these bits to be changed by
a signal handler, I suppose you could look at the value of

    current->ptrace & PT_PTRACED

and use this to conditionally allow them to be changed in the signal
return path.  (I.e, you'd permit them to be changed if the process in
question is not being ptrace'd.)  You'd even still be able to debug such
programs, but you'd experience a slight loss of functionality since
the program that you're debugging would control whether or not you're
single stepping in certain instances.

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
