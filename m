Date: Mon, 7 Jun 2004 20:04:44 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: newest "bk pull" of 8xx tree still builds a kernel that hangs
In-Reply-To: <20040607200811.GD12823@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.58.0406071950460.3449@localhost.localdomain>
References: <Pine.LNX.4.58.0406071152260.14264@localhost.localdomain>
 <20040607200811.GD12823@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 Jun 2004, Tom Rini wrote:

>
> On Mon, Jun 07, 2004 at 11:55:33AM -0400, Robert P. J. Day wrote:
>
> >
> >   having just got back from vacation, i may have missed some of the latest
> > developments.  i just did a "bk pull" from the linuxppc-2.5 tree, rebuilt
> > the kernel for my 8xx board and, just like before i left, the kernel hung
> > almost immediately upon booting:
> >
> > Linux/PPC load: console=ttyS0,9600 rw root=/dev/ram0 init=/sbin/minit
> > Uncompressing Linux...done.
> > Now booting the kernel
> > (hang)
> >
> > should i be expecting this?  once upon a time, of course, i got all the
> > way to user space before the hang.  have there been some recent patches to
> > cause this latest behaviour?  i haven't messed with the config file in
> > quite some time.  should i?
>
> What probably happened is that you don't have a UART driver selected.
> I've had my best luck with CONFIG_SERIAL_CPM, so you might want to try
> that.

i selected that, but still no luck -- kernel still hangs almost
immediately -- but there may be other issues here.

i'm working with a custom board that, despite the initial contents of the
file arch/ppc/8xx_io/uart.c, supports both ethernet on SCC3 and console on
SMC1.  for our 2.4 kernel, i have the MPC8xx options (among others):

  [*] SMC1/SCC3/I2C/SPI Microcode Patch
  [*] CPM SCC Ethernet
  (SCC3) SCC used for Etherhet
  [*] Use SMC1 for UART

so you can definitely see that we've been hacking the kernel source for
our 2.4 build on this board.  i was *hoping* to get a minimal 2.6 config
to boot just to prove that it could be done, before starting to make any
necessary mods from there.  now i'm wondering if that's even possible.

since i'd rather not start mucking with the source code just yet (it being
in a state of flux), i think what i want to try is to get an absolutely
minimal config to see if it boots.  so, one would think, i could turn off
stuff like JFFS2 support, tmpfs, even networking, just to see if i can get
any further.

if anyone wants to suggest the bare minimum config that should build a
bootable kernel, i'd be interested.  but i'm starting to get this
unpleasant sensation that i really might need to hack uart.c as we did
with the 2.4 kernel just for our board.

rday


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
