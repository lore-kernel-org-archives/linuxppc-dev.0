Date: Thu, 31 Aug 2000 13:53:27 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
In-Reply-To: <20000831113909.32087@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10008311339060.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 31 Aug 2000, Benjamin Herrenschmidt wrote:

> Heh, that's interesting since that's close to an idea I had of having the
> bootloader pre-load some modules and have the kernel automatically link
> them, so all the platform dependent stuffs could be in modules.

Ok, I see that we agree...

> The only problem is that some HW probe code must be present in the
> bootloader itself to decide which modules to load (well, this could be in
> the bootloader config file, but then, we need a way to load all of them
> for boot CDs).

For PCI devices it's not that complex (if you have a list of device
identifiers supported by the module in a header of the module, you can
decide whether you have to link the corresponding module or not).

For desktops and large embedded system (16Mb RAM or more), I just don't
care about the size of the initial image (bootloader+kernel). Anything
which is potentially useful during boot can be included, as long as it is
thrown away before the kernel (whose memory footprint has to be minimized
on the other hand) gets control.

> There's already some code for the kernel to get passed a System.map by
> the bootloader. It's currently only used by xmon (AFAIK). With the
> dynamic linking stuff, the bootloader could pass the "base" kernel
> system.map, and would extend it with modules that gets linked in.

Ok...

> Something else Cort and I have in mind for 2.5 is to also remove a huge
> part of what we currently have in prom.c and head.S and move all that to
> bootloaders. The idea is that the kernel would always be entered with MMU
> cleaned and off, and all the firmware dependant things like the OF
> device-tree would be passed by the bootloader instead of beeing retreived
> from OF by the kernel.

Well, I had a preliminary version of prepboot which read the device tree
instead of residual data, but I gave up and never finished when I realized
that my OF was buggy to the point that the device @1f was actually @0 and
a few others of the same category (real-mode? could not be reliably read
for example when booting from a prepboot partition).

I think the code is still on my ftp directory; the only differences
between a zImage.elf and a zImage.ppcboot were the name of the linker
script and of the output file in the final link command. The rest was
identical, byte per byte, with exactly the same files linked together.

	Gabriel


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
