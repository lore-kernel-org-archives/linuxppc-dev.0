Date: Sun, 26 Mar 2000 00:21:14 +0100
From: Martin Mares <mj@ucw.cz>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI bus numbering?
Message-ID: <20000326002114.F620@albireo.ucw.cz>
References: <200003242239.XAA00513@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200003242239.XAA00513@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

> 2. Is there an easy way (again, short of walking the list of buses) to
> get the next free bus number? Problem is: the newer Macs have a weired
> host bridge called UNI-North, which in fact has three separate PCI
> buses, but they are all labeled bus 0. In the PMac PCI ficup code, we
> may want to renumber that and make them three separate buses.

   There is no generic function for that, but you can easily use
pci_bus_exists() defined in drivers/pci/pci.c.

> 3. What addresses are IO-space resources supposed to contain? Bus
> physical? Kernel virtual? On x86 platforms, it doesn't matter, but all
> other platforms lack anything special about IO space, so they access it
> as normal memory-mapped IO (albeit in very small chunks ;-).

   I/O resources should contain exactly the addresses accepted
by inb() and friends. It's upon each port maintainer to decide what
type of addresses he likes for that.

> On PowerMacs, the IO space on a PCI bus is mapped by the host bridge to
> a regular memory region; so obviously there's an address translation
> involved. With multiple host bridges (or UNI-North, for that
> matter), there can be multiples of such translations. Hence, a simple
> offset applied in inb() and friends doesn't help. The bridge init code
> ioremap()s the IO space, and those are the addresses you want a driver
> to use to acces the IO ports. Therefore it makes sense to put those
> addresses into pci_dev's resources.

   Yes, the most natural thing you can do is to use kernel virtual addresses
for I/O resources in struct pci_dev. There should be no problems with
that, only maybe with userspace programs wanting to access the I/O
ports.

> Which means that the hotplug resource (re)allocation code needs to know
> about this, so it can convert the IO-port virtual address into physical,
> de-offset it and write it into the BAR's.

   Should not be a problem -- everything can be manipulated in PPC
specific code.

				Have a nice fortnight
--
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"All computers run at the same speed... with the power off."

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
