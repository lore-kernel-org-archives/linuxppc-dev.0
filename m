Date: Thu, 14 Sep 2000 22:44:39 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Paul Mackerras <paulus@linuxcare.com.au>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ld bug?
In-Reply-To: <14785.38057.405663.414104@argo.linuxcare.com.au>
Message-ID: <Pine.A41.3.96LJ1.1b7.1000914221944.93706D-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Fri, 15 Sep 2000, Paul Mackerras wrote:

> Takashi Oe writes:
>
> > Well, I've just had a kernel hang at "Freeing unused kernel memory:..."
> > with linux-2.4.0-test8 + numerous patches, and I've traced the hang to
> > what apears (to me) to be a ld bug.
>
> Don't think so, see below...
>
> > The kernel hangs at the call to spin_unlock_irq() in schedule() of
> > kernel/sched.c.  For me (UP kernel), spin_unlock_irq() is defined to be
>
> That sounds to me like an unhandled interrupt, endlessly repeated.

To be more precise on the "hang", the cursor is blinking normally as if
something will happen shortly (but won't), and I can invoke xmon via NMI
just fine.  When I invoked xmon, LR is at right after spin_unlock_irq()
and PC is at "blr" of __no_use_sti(), so obviously my previous
interpretation was way wrong.  Sorry.

[...]
> > However, from "nm vmlinux | grep int_control", "int_control" is at
> >
> > c039c3e0 D int_control
>
> No, it's right, the thing is that the -15388 in the lwz instruction is
> sign-extended.  So the address it uses is 0xc03a0000 - 15388 (or put
> another way, 0xc03a0000 + 0xffffc3e4) which is in 0xc039c3e0.

Thanks!  That makes a lot of sense.  I'm really glad I don't have to
compile binutils myself.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
