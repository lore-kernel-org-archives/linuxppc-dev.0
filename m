Date: Mon, 7 Jun 2004 20:56:05 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: newest "bk pull" of 8xx tree still builds a kernel that hangs
In-Reply-To: <20040608004537.GB14242@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.58.0406072049310.24833@localhost.localdomain>
References: <Pine.LNX.4.58.0406071152260.14264@localhost.localdomain>
 <20040607200811.GD12823@smtp.west.cox.net> <Pine.LNX.4.58.0406071950460.3449@localhost.localdomain>
 <20040608002527.GA14242@smtp.west.cox.net> <Pine.LNX.4.58.0406072026220.15060@localhost.localdomain>
 <20040608004537.GB14242@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 Jun 2004, Tom Rini wrote:

> Then don't forget a console=ttySX (or ttyCPMX) if you have CONFIG_VT
> set.  This early on, I'd turn off 8250 myself (and VT and INPUT).

you da man.  i de-selected the 8250 stuff, and VT, and my load line was
nothing more than:

Linux/PPC load: console=ttyS0,9600        [EP's PlanetCore loader]

(which would, of course, crash and burn as soon as it tried to find an
init-like program, but who cares?)

the results:

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.7-rc2 (rpjday@localhost.localdomain) (gcc version 3.2.2
200304
On node 0 totalpages: 8192
  DMA zone: 8192 pages, LIFO batch:2
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: console=ttyS0,9600
PID hash table entries: 256 (order 8: 2048 bytes)
Decrementer Frequency = 187500000/60
Memory: 29584k available (764k kernel code, 200k data, 52k init, 0k
highmem)
Calibrating delay loop... 46.72 BogoMIPS
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 1801k freed
Linux NoNET1.0 for Linux 2.6
devfs: 2004-01-31 Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $.


at which point it hung, but at least that's progress.  i suspect i'm
getting closer and closer to the point where i really do have to take
into account the custom nature of this board, but first, i'll see if i
can get any farther without descending into that kind of madness.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
