MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16207.61398.896235.148724@nanango.paulus.ozlabs.org>
Date: Sat, 30 Aug 2003 10:29:10 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Corey Minyard <minyard@acm.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Change to allow signal handlers to set SE and BE bits.
In-Reply-To: <3F4FB0F3.9090906@acm.org>
References: <3F4FB0F3.9090906@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Corey Minyard writes:

> I have a debugger that runs in an application that requires access to
> the SE and BE bits.  The following patch adds that capability to
> 2.4.21-ben1.  I have tested this, and gdb still seems to correctly step
> out of signal handlers, and it seems to work for 4xx.  Does this look ok?

Can you explain a bit more about why the process needs to be able to
single-step itself rather than having another process single-step it
using ptrace?

It looks like you're using the old trick of sending yourself a signal
and then modifying the register values stored on the stack.  That
seems like a bit of a kludge to me.  If there is some reason why you
would always naturally be in a signal handler anyway at the point
where you want to single-step, then maybe it is less of a kludge.
Does your in-process debugger run entirely inside signal handlers?
(And if it does, how do you cope with the fact that there are lots of
C library functions you can't use inside signal handlers, including
printf?)

Also... would this have any impact on how you expect setcontext() to
behave?  Passing the 3rd argument of a "real-time" signal handler to
setcontext is supposed to have the same effect as returning from the
handler.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
