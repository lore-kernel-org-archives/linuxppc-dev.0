From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>,
        <debian-powerpc@lists.debian.org>
Subject: Re: apmd and other archs
Date: Fri, 24 Nov 2000 16:33:20 +0100
Message-Id: <19341019090504.27268@192.168.1.2>
In-Reply-To: <Pine.HPX.4.10.10011241524030.14737-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10011241524030.14737-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Could the recently added keventd thread be used for this? I don't like the
>idea of adding kernel threads just for one thing. One kernel thread for
>all relatively slow operations which may need a process context is
>reasonable however.

I'll investigate.

>No, I thought the deep sleep modes were only for laptops which are not SMP
>unless I missed some recent Apple announcement ;-). Do SMP G4 truly
>require complex power management ?

Yup. Almost all Apple recent machines can do power management in various
ways. Some can deep sleep (not only portables), all can switch off power
to some PCI devices & ASICs, some support turning off the CPU...

>BTW: I dislike any idea of playing with the scheduler.

Me too. The problem is that the IDE layer will always schedule if you do
something more complex that setting a few registers. scheduling in the
middle of putting things to sleep is bad, except is drivers that have
already been put to sleep can cope with it by just blocking userland IOs
or returning errors.

For other CPUs, I beleive we can go with a cross-CPU function call, the
called function putting the other CPU in a spin-loop. My problem with
that is that it happens all at interrupt time, which may not be the best
place to put the CPU to sleep. Maybe I can manage to schedule a bottom
half or soemthing like that.

Apple's code is smarter in that sense that they can apparently easily
turn CPUs on/off (putting them in sleep loops when they are off), causing
all processes to migrate to the still running CPU. However, AFAIK, their
current Darwin kernel cannot sleep on SMP machines properly neither yet.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
