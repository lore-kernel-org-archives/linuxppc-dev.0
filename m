Message-ID: <3F53B03A.6090500@acm.org>
Date: Mon, 01 Sep 2003 15:46:50 -0500
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Change to allow signal handlers to set SE and BE bits.
References: <3F4FB0F3.9090906@acm.org> <16207.61398.896235.148724@nanango.paulus.ozlabs.org>
In-Reply-To: <16207.61398.896235.148724@nanango.paulus.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

>Corey Minyard writes:
>
>
>
>>I have a debugger that runs in an application that requires access to
>>the SE and BE bits.  The following patch adds that capability to
>>2.4.21-ben1.  I have tested this, and gdb still seems to correctly step
>>out of signal handlers, and it seems to work for 4xx.  Does this look ok?
>>
>>
>
>Can you explain a bit more about why the process needs to be able to
>single-step itself rather than having another process single-step it
>using ptrace?
>
Sure.  This is part of an in-application soft real-time
debugger/patcher.  The idea is that the debugger/patcher is actually
linked to the application.  ptrace is really to slow and has too much
overhead to use on a running soft real-time application.  So instead,
the debugger uses signal to do tracepoints.  A small bytecode script
runs (actually the same bytecode machine that GDB understands) that
collects information and then the application continues.  The need to
single-step actually comes from the fact that you have inserted a trace
instruction in the code, and thus the instruction that was there must be
run somehow.  Relative branch instructions are simulated by software,
other instructions are placed into a thread-local memory and single-stepped.

The patching part also needs single-stepping.  The patcher does function
replacement, meaning that it puts a jump to a new function from the old
function (to allow bugs to be fixed and new features to be added).  It
needs to be able to tell if a function is executing in the section of
memory being patched, and single-step it through that section.

Someday, in my spare time, I plan to add a function trace capability to
this, to allow you to watch the flow of execution through a piece of
code (thus the need for the BE bit).

>
>It looks like you're using the old trick of sending yourself a signal
>and then modifying the register values stored on the stack.  That
>seems like a bit of a kludge to me.  If there is some reason why you
>would always naturally be in a signal handler anyway at the point
>where you want to single-step, then maybe it is less of a kludge.
>Does your in-process debugger run entirely inside signal handlers?
>(And if it does, how do you cope with the fact that there are lots of
>C library functions you can't use inside signal handlers, including
>printf?)
>
Well, not exactly that trick.  The signal handling code for the traps is
the place where this is done.  You are already in a signal handler for
the trap, so the natural way to single-step is this way.  The signal
handlers have to be carefully written to not do any C library
functions.  The only thing they can do is dump data into a shared memory
buffer.

>
>Also... would this have any impact on how you expect setcontext() to
>behave?  Passing the 3rd argument of a "real-time" signal handler to
>setcontext is supposed to have the same effect as returning from the
>handler.
>
Hmm, I haven't thought of that.  In fact, I haven't ever used that
function.  Is this a more efficient way of returning from a signal
without going though the kernel, or does it still go through the
kernel?  If it doesn't go through the kernel, you obviously can't set
the MSR bits, but that's not a big concern since this is a specialized
function.  If it does go through the kernel, then it should work the same.

BTW, i386 allows the TF bit to be set in signal handlers, and I expect
that some applications use it to do debugging.

-Corey


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
