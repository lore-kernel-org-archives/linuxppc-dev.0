Date: Wed, 8 Dec 1999 20:33:15 -0500 (EST)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: linuxppc-workstation@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: IRQ problems on IBM 850
In-Reply-To: <384E9672.7632BAB9@amberdata.demon.co.uk>
Message-ID: <Pine.LNX.3.96L.991208201431.3883D-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 8 Dec 1999, David Monro wrote:
> 
> Gabriel Paubert wrote:
> > 
> > Using interrupt 13 is strange, to say the least. It was reserved for FPU
> > errors on x86 processors. In your case obviously the interrupts are
> > expected (since you have a timeout) but have stayed masked for some
> > reason. We have to find where this happens. Some code paths might have an
> > unbalanced enable/disable_irq but I suspect that it will be hard to find.
> 
> Umm. Possible data point which may help here - I cannot cause my machine
> to do anything silly unless I hit two interrupt sources at the same
> time. I can compile kernels on the IDE disk (irq 13) till the cows come
> home if I don't have the ethernet enabled and don't play with the mouse
> too much. If I enable the ethernet (irq 15 I think), or play with the
> mouse a lot (irq 12), sooner or later I die. My (very uneducated) guess
> is that it has something to do with getting two interrupts in a very
> short space of time. I guess I should try thrashing one of the lower 8
> interrupts (serial mouse I guess would do it) and see if that can cause
> problems, or whether it is restricted to the second controller.

The problem definately occurs when two interrupts come in simultaneously on
the cascaded controller. It shouldn't happen with one cascaded and one
non-cascaded interrupt, though I guess it couldn't hurt to verify...

I don't think anyone's gotten anywhere towards a fix though. I certainly
haven't had time to look into it, and neither has anyone else I've been in
contact with...

-Hollis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
