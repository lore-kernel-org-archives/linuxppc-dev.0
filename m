Date: Wed, 14 Feb 2001 17:56:30 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Patrik Olesen <patrik@hemma.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Graphics in embedded systems?
In-Reply-To: <017701c09662$458a3220$da2211c2@gbg.bluelabs.se>
Message-ID: <Pine.HPX.4.10.10102141743240.22756-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 14 Feb 2001, Patrik Olesen wrote:

>
> What do I need to run graphics on a MBX860 card?
>
> Is it possible to use a standard VGA card connected to PCI and then run
> Xlib?

Blatant plug: one of the problems may be to initialize the board. I have
an x86 ROM BIOS emulator which does the job quite nicely on my S3 boards.
It's even embedded in a bootloader (prepboot) and rather small for an
emulator (approx 24k).

Once the board has been correctly setup, standard libs should work

> If so, what requirements has such a configuration regarding RAM, ROM and CPU...

You need a way to access ISA VGA addresses (0xa0000-0xbffff), and ISA I/O
addresses for VGA. Beware of conflicts, especially with S3, which uses a
bunch of I/O addresses of the form 0x2e8+n*0x400 (inherited from IBM's
8514 AFAICT). My solution is that the PCI devices are allocated I/O
addresses starting from 0x10000. The ROM only has to be virtually located
at 0xc0000 for it to work. I copy ROM to RAM to accelerate the emulator
and then play with memory management to build a PC low 1Mb memory map.

The ROM BIOS on my machine uses standard PC ports 0x42-43 and 0x61 for
timing purposes. I don't have any problem since these devices exist on
PreP machines, but if you don't have them, you'll have to emulate the
8253.

	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
