Date: Fri, 24 Nov 2000 17:26:27 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: apmd and other archs
In-Reply-To: <19341019090504.27268@192.168.1.2>
Message-ID: <Pine.HPX.4.10.10011241719070.14737-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Nov 2000, Benjamin Herrenschmidt wrote:

> Yup. Almost all Apple recent machines can do power management in various
> ways. Some can deep sleep (not only portables), all can switch off power
> to some PCI devices & ASICs, some support turning off the CPU...

Ok, I don't see very much the point of saving fractions of watt on a
desktop but...

> >BTW: I dislike any idea of playing with the scheduler.
>
> Me too. The problem is that the IDE layer will always schedule if you do
> something more complex that setting a few registers. scheduling in the
> middle of putting things to sleep is bad, except is drivers that have
> already been put to sleep can cope with it by just blocking userland IOs
> or returning errors.

Returning errors to user mode looks like a bad idea, it should be
absolutely transparent to applications.

> For other CPUs, I beleive we can go with a cross-CPU function call, the
> called function putting the other CPU in a spin-loop. My problem with
> that is that it happens all at interrupt time, which may not be the best
> place to put the CPU to sleep. Maybe I can manage to schedule a bottom
> half or soemthing like that.

I'm lost. Can't power management be done by the idle task ? There is one
per CPU but it can't handle signala AFAIR. After all power management
seems better handled by a task which never does I/O and whose only purpose
is to sleep...

> Apple's code is smarter in that sense that they can apparently easily
> turn CPUs on/off (putting them in sleep loops when they are off), causing
> all processes to migrate to the still running CPU. However, AFAIK, their
> current Darwin kernel cannot sleep on SMP machines properly neither yet.

What do you call a sleep loop ?

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
