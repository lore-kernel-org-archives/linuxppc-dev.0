Message-ID: <398EA0CE.5439F930@pop.agri.ch>
Date: Mon, 07 Aug 2000 13:43:12 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI resource collisions (2.4.0-test1-ac5+)
References: <20000806133523.D2891@opus.bloom.county>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
>
> I've recently been playing with 2.4.0 on my machine (Yikes! G4, all PCI slots
> full) and I've run into a problem with the new PCI resource checks.  First,

My box: 7200 with pci slots full too.

here my lspci -v on a patched 2.4.0-test6 (linux-pmac-devel from Paul):

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
	Flags: bus master, medium devsel, latency 32

00:0d.0 Ethernet controller: 3Com Corporation 3c590 10BaseT [Vortex]
	Flags: bus master, medium devsel, latency 32, IRQ 23
	I/O ports at 0400 [disabled]

00:0e.0 SCSI storage controller: Adaptec AIC-7881U
	Flags: bus master, medium devsel, latency 32, IRQ 24
	I/O ports at 1000
	Memory at 80800000 (32-bit, non-prefetchable)

00:0f.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10)
	Subsystem: Unknown device 1045:c861
	Flags: bus master, medium devsel, latency 32, IRQ 25
	Memory at 80801000 (32-bit, non-prefetchable)

00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
	Flags: bus master, medium devsel, latency 32
	Memory at f3000000 (32-bit, non-prefetchable)

Without any pci-hack I get the following msg on boot:

PCI: Device 00:0e.0 not available because of resource collisions.

The same as on your box, the AIC-7881U.


> Which causes the aic7xxx.c driver to say there's a PCI resource collision, and
> not use the card (which works fine in 2.2.x and 2.4.0-testX with the check
> removed).  Has anyone else seen errors like this on 2.4.0-testX (the test1-acX
> series added in a good deal of these checks..)

In my case it's even worse, the boot hd's (and all others) are hanging
on the 2940UW.

The 'solution' I have, is the patch sent a few minutes ago to
linuxppc-dev. (status pm7200)

So far my experiences.

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
