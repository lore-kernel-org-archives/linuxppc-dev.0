From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Date: Thu, 31 Aug 2000 13:39:09 +0200
Message-Id: <20000831113909.32087@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10008311107320.15978-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10008311107320.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I strongly disagree. What I would like to see is the same kernel running
>on all machines, without exception (well all 6xx/7xx/74xx and Power[34]
>in 32 bit mode, obvioulsy 8xx and company are too different).
>
>The only reasonable way to do this that I see is to have a self linking
>kernel, the initial boot code would simply uncompress a partially linked
>kernel and perform the final link step before passing control to it.

Heh, that's interesting since that's close to an idea I had of having the
bootloader pre-load some modules and have the kernel automatically link
them, so all the platform dependent stuffs could be in modules.

The only problem is that some HW probe code must be present in the
bootloader itself to decide which modules to load (well, this could be in
the bootloader config file, but then, we need a way to load all of them
for boot CDs).

>And yes there are problems, like the fact that System.map will not be
>constant, perhaps not even across reboots (imagine that you add modules
>in the same image and the module becomes automagically linked in the
>kernel image if the appropriate hardware happens to be plugged-in).
>
>However this is solvable, and perhaps even better: keep a System.map
>around inside the kernel and write it to /boot/System.map early in the
>boot scripts and free the kernel memory at this time (a read-once self
>destructing /proc entry for example). This even guarantees that System.map
>is consistent with your kernel, which I see as a big plus.

There's already some code for the kernel to get passed a System.map by
the bootloader. It's currently only used by xmon (AFAIK). With the
dynamic linking stuff, the bootloader could pass the "base" kernel
system.map, and would extend it with modules that gets linked in.

>Ok, I have a lot of other ideas (espcially about memory management, which
>is currently braindead for desktops PPC) but that will be for other posts.
>
>There actually are times where I think that the only viable solution is:
>	rm -rf arch/ppc/*
>	restart on a sane basis

heh..

Something else Cort and I have in mind for 2.5 is to also remove a huge
part of what we currently have in prom.c and head.S and move all that to
bootloaders. The idea is that the kernel would always be entered with MMU
cleaned and off, and all the firmware dependant things like the OF
device-tree would be passed by the bootloader instead of beeing retreived
from OF by the kernel.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
