To: Nelson Abramson <pogtal@erols.com>
Cc: rboder@grn.georet.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 configuration
References: <393D6256.89D44EA6@grn.georet.net> <393D7854.8CF53542@erols.com>
From: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Date: 13 Jun 2000 14:36:42 +0200
In-Reply-To: Nelson Abramson's message of Tue, 06 Jun 2000 18:16:52 -0400
Message-ID: <8xg0qhbvvp.fsf@s61.informatik.uni-bremen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Nelson Abramson <pogtal@erols.com> writes:

>
> Ryan Boder wrote:
>
> > Does anyone have a .config to configure a kernel that is stable on the
> > G4 sawtooth? I have the current stable source but every kernel I compile
> > freezes and corrupts my root file system. If anyone has one will you
> > please mail it to me?
>
> The .config that comes with Paul's tree (via rsync) should compile and run
> your sawtooth just fine.  It worked for me...
>
I have similar troubles to find a config that even only compiles. I got the
latest (well, a few days ago) 2.3 Kernel sources via bitkeeper. There seems
to be no default config file there.

During 'make xconfig', most of the options are sensibly set. My only changes
were to drop a bit of unneeded functionality, like certain exotic file
systems, or support for hardware that is not present in my sawtooth G4.
Afterwards, 'make dep' doesn't complain, but make zImage eventually fails
for the file "ide-dma.c", with the compiler complaining that the structure
"hwif" has no member "pci_dev". Apparently, part of the configuration thinks
that IDE doesn't sit on PCI, but the driver relies on the presence of a
PCI device.

In older kernels, there used to be a config option "Generic PC IDE support"
or somesuch, which was actually the core of all IDE functionality. This
option didn't exist in the 2.3 tree, so I cannot accidentally have turned off
basic IDE support (as is possible with 2.2, and is the favourite beginner's
error on non-PC systems).

So if anyone has a working config for a sawtooth G4, I'd be happy if I could
obtain a copy.

  Holger

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
