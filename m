To: <linuxppc-dev@lists.linuxppc.org>
Subject: Allowing signal handlers to modify SE and BE
Reply-To: minyard@acm.org
From: Corey Minyard <minyard@acm.org>
Date: 16 Oct 2000 21:58:04 -0500
Message-ID: <m2lmvoqimb.fsf@c469597-a.grlnd1.tx.home.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I noticed the following in signal.c:

/*
 * These are the flags in the MSR that the user is allowed to change
 * by modifying the saved value of the MSR on the stack.  SE and BE
 * should not be in this list since gdb may want to change these.  I.e,
 * you should be able to step out of a signal handler to see what
 * instruction executes next after the signal handler completes.
 * Alternately, if you stepped into a signal handler, you should be
 * able to continue 'til the next breakpoint from within the signal
 * handler, even if the handler returns.
 */
#define MSR_USERCHANGE	(MSR_FE0 | MSR_FE1)


Is this really the case?  I noticed in the x86 version that setting
the equivalent of the SE bit is allowed, how does the x86 get away
with this while the PPC can't?  Also, gdb does not use the BE bit at
all (This is branch-trace enable, not breakpoint enable), so allowing
it would not hurt anything.  And gdb doesn't directly use the SE bit,
it uses it through ptrace, so it should be safe to allow the signal
handler to modify it since ptrace would override that.  If the signal
handler didn't modify the bits, it won't hurt anything.  If it
modifies these bits it will not be debugabble, sure, but there are
many ways to make your program not debuggable.

Why am I asking?  Because I'm working on two different programs that
need to be able to set these bits from a signal handler.  I would
rather have this as a standard part of the kernel than have to patch
it every release.

Thanks,

Corey

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
