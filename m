From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>,
        <debian-powerpc@lists.debian.org>
Subject: Re: apmd and other archs
Date: Fri, 24 Nov 2000 18:31:05 +0100
Message-Id: <19341019110249.29808@192.168.1.2>
In-Reply-To: <Pine.HPX.4.10.10011241719070.14737-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10011241719070.14737-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Ok, I don't see very much the point of saving fractions of watt on a
>desktop but...

It can be more than fraction of watts when you put it all together, especially
in deep sleep. And multiply that by the number of machines out there...

Also, the Cube is sensitive to heat problems, having some power
management (and CPU temp control, but that's another issue) helps.

>Returning errors to user mode looks like a bad idea, it should be
>absolutely transparent to applications.

Well, that depends. I prefer blocking them, definitely, but that may not
always be possible.
Some things can just not be handled this way. We cannot, for example,
afford to schedule (or even printk) after the video driver have put the
chip to sleep. That's why we have these ordering rules x86 lacks, so that
we can sleep this driver very late in the sleep process, and wake it up
first. In the case of SMP boxes, we would have needed to put the other
CPUs to sleep before that point.

>I'm lost. Can't power management be done by the idle task ? There is one
>per CPU but it can't handle signala AFAIR. After all power management
>seems better handled by a task which never does I/O and whose only purpose
>is to sleep...

That could be done this way too. Are there any guarantees that the idle
task will run at all, however, if a process is using all the available
CPU time ? If we need all processors to stop scheduling userland code and
wait in a sleep loop (not doze nor nap in this case), we need to have a
way to let the idle task know that we need it to enter this special sleep
stage ASAP. It will have to flush all caches properly and go to sleep. On
some boxes, the CPU(s) will be shut down and revived via ROM hooks.

>What do you call a sleep loop ?

An infinite loop where the CPU goes to sleep mode. It exists via an
external reset or CPU shut down.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
