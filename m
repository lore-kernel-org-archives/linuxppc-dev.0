Date: Fri, 24 Nov 2000 15:29:07 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Avery Pennarun <apenwarr@worldvisions.ca>,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: apmd and other archs
In-Reply-To: <19341019071225.5885@192.168.1.2>
Message-ID: <Pine.HPX.4.10.10011241524030.14737-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Nov 2000, Benjamin Herrenschmidt wrote:

> We can "fix" that by either having the PMU driver on core99 continuously
> send those infos via /dev/pmu without explicit request. It may also be
> interesting to replace this by a kernel thread. That would allow more
> flexibility in communicating with userland (things like signaling
> processes that asked for it to be notified of a sleep request, etc...).

Could the recently added keventd thread be used for this? I don't like the
idea of adding kernel threads just for one thing. One kernel thread for
all relatively slow operations which may need a process context is
reasonable however.

> One other issue we have with sleep is that we need to prevent the kernel
> to do a bunch of thigns while going to sleep. scheduling from within the
> sleep ioctl is dangerous, but will happen occasionally, especially when
> sleeping & waking up the IDE layer.
>
> I beleive it should be possible to hack the scheduler so that only our
> sleep thread gets scheduled at all (disabling scheduling on the main CPU
> and freezing other CPUs in sleep loops) during the sleep & wakeup process.
>
> Any better ideas ?

No, I thought the deep sleep modes were only for laptops which are not SMP
unless I missed some recent Apple announcement ;-). Do SMP G4 truly
require complex power management ?

BTW: I dislike any idea of playing with the scheduler.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
