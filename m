Date: Tue, 1 Oct 2002 18:25:51 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tim Moloney <moloney@mrsl.com>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Location for Linux kernel module support files
In-Reply-To: <3D99B224.8050107@mrsl.com>
Message-ID: <Pine.GSO.4.21.0210011824051.21899-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 1 Oct 2002, Tim Moloney wrote:
> David Gibson wrote:
> > On Mon, Sep 30, 2002 at 11:46:22AM -0400, Tim Moloney wrote:
> >>I have written a device driver (module) that needs a configuration
> >>file.  Where is the standard place to put such files?
> >
> > There isn't.  Device drivers, being part of the kernel, should not be
> > reading random files from the user's file system.  If the driver needs
> > configuration, the normal method is for userland scripts (either
> > startup or hotplug) to issue commands to poke the configuration into
> > the driver at runtime.
> >
> >>I originally put it in the same directory as the .o file but
> >>'depmod -a' complains that it's not an ELF file.
>
> The file the device driver needs is an FPGA program file that
> - is data that I don't want compiled into the driver wasting space
> - will initially be specified when the driver is loaded via rc script
> - that can be reloaded by a program to customize it for a particular
>    application
>
> I know that this isn't a a typical situation and I have only seen one
> other device driver like this.  It is a 1553 driver that creates a
> /usr/lib/<module_name> directory for its configuration file.  Is there
> a better location?

So your kernel driver should create a /proc entry where the rc script can
write the FPGA program file to after insmod.

If the FPGA program file is to be reloaded by the application, it can just
write the new data to the same /proc entry.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
