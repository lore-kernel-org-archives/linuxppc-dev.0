Date: Fri, 24 Nov 2000 20:27:32 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: apmd and other archs
In-Reply-To: <19341019110249.29808@192.168.1.2>
Message-ID: <Pine.HPX.4.10.10011241958140.14737-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Nov 2000, Benjamin Herrenschmidt wrote:

> >Ok, I don't see very much the point of saving fractions of watt on a
> >desktop but...
>
> It can be more than fraction of watts when you put it all together, especially
> in deep sleep. And multiply that by the number of machines out there...

Don't worry. Intel and M$ contribute much more to global warming :-)

> Also, the Cube is sensitive to heat problems, having some power
> management (and CPU temp control, but that's another issue) helps.

Ok, style over substance. Remind me to never buy a cube...

>
> >Returning errors to user mode looks like a bad idea, it should be
> >absolutely transparent to applications.
>
> Well, that depends. I prefer blocking them, definitely, but that may not
> always be possible.
> Some things can just not be handled this way. We cannot, for example,
> afford to schedule (or even printk) after the video driver have put the
> chip to sleep. That's why we have these ordering rules x86 lacks, so that
> we can sleep this driver very late in the sleep process, and wake it up
> first. In the case of SMP boxes, we would have needed to put the other
> CPUs to sleep before that point.
>
> >I'm lost. Can't power management be done by the idle task ? There is one
> >per CPU but it can't handle signala AFAIR. After all power management
> >seems better handled by a task which never does I/O and whose only purpose
> >is to sleep...
>
> That could be done this way too. Are there any guarantees that the idle
> task will run at all, however, if a process is using all the available
> CPU time ? If we need all processors to stop scheduling userland code and
> wait in a sleep loop (not doze nor nap in this case), we need to have a
> way to let the idle task know that we need it to enter this special sleep
> stage ASAP. It will have to flush all caches properly and go to sleep. On
> some boxes, the CPU(s) will be shut down and revived via ROM hooks.

I believe the idle task blocks all signals, but once in the idle task you
can check for pending signals (signal_pending(current)) which would be a
way to communicate with it. It might be necessary to raise the priority of
the idle task when you send it a signal (and set need_resched to schedule
asap). The idle task would lower its own priority later when exiting from
sleep. This might be a way to provide a known clean context for power
management (and there is one idle task per processor as I said earlier).
The scheduler should not need any change. Of course raising the priority
of the idle task may seem strange, but when you risk overheating, it's
urgent to become idle...

BTW: I don't want to ever enter sleep state on my machines, a stopped
timebase would be a catastrophe when you need accurate timestamps. Nap and
doze are still ok, currently only the first level is entered. I'm not even
sure it's worth going to the second level on machines which have a
continuous stream of interrupts at >100Hz, flushing and reloading the
cache at this rate is probably not a power saving measure when the active
part of the memory fits in the L2 cache.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
