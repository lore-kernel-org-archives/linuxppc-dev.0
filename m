From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Avery
 Pennarun <apenwarr@worldvisions.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>, <debian-powerpc@lists.debian.org>
Subject: Re: apmd and other archs
Date: Fri, 24 Nov 2000 14:40:41 +0100
Message-Id: <19341019071225.5885@192.168.1.2>
In-Reply-To: 
 <Pine.LNX.4.10.10011230936470.22746-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10011230936470.22746-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Not APM support exactly... simply support for the same interface.
Just like
>> powermacs have totally different sound systems and still use /dev/dsp.
>> /proc/apm and /dev/apm_bios are so simple that it should be easy to
convince
>> any power management system to provide those API's.
>
>The info logged to /proc/apm is currently logged to /etc/power/apm. I have
>no idea what /dev/apm does aside from providing that log info, and I have
>no clue what /dev/apm_bios does, either. There should be no major problems
>duplicating the pmu logging code in the kernel, and interfacing that with
>some apm glue code, assuming the apm interface is reasonably architecture
>independent. I just don't see a good reason to change from pmud to apmd,
>if that's what you're suggesting.

At least one reason: the current pmud does continuous polling of the PMU
via /dev/pmu. On newer (core99) machines, the PMU itself will send
messages to the CPU when any environement info change (battery status,
lid closed, ...). We currently don't use this feature and so end up
communicating with the PMU more than we would really need.

We can "fix" that by either having the PMU driver on core99 continuously
send those infos via /dev/pmu without explicit request. It may also be
interesting to replace this by a kernel thread. That would allow more
flexibility in communicating with userland (things like signaling
processes that asked for it to be notified of a sleep request, etc...).

One other issue we have with sleep is that we need to prevent the kernel
to do a bunch of thigns while going to sleep. scheduling from within the
sleep ioctl is dangerous, but will happen occasionally, especially when
sleeping & waking up the IDE layer.

I beleive it should be possible to hack the scheduler so that only our
sleep thread gets scheduled at all (disabling scheduling on the main CPU
and freezing other CPUs in sleep loops) during the sleep & wakeup process.

Any better ideas ?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
