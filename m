MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Fwd: Memory layout question]
Date: Tue, 18 May 2004 10:25:05 -0500
Message-ID: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
From: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <okorpil@fh-landshut.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> I'm currently trying out the VMIC Tundra Universe II driver, a
> PCI-VME bus bridge quite common in embedded devices (from VMIC and
> Motorola). VMIC manufactures mostly x86 boards, but I try to use
> the driver on a MVME5500 with 7455 Motorola PPC.
> There seems to be a memory problem involved, as follows:

-- snip --

> Actually the addresses returned by allocate_resource seem to come from
> system memory, because ioremap_nocache logs a debug statement
> that is only triggered if the remapping is below the high_memory
bound.
> (And there already seems to be a virtual address associated with it -
> physical 0x40000000 is RAM 0xc<whatever> - kernel space, I guess)
>
> But the address returned is 0x40000000 !! Isn't that the 2nd
> GB of address space? My board only has 512 MB of storage, and is only
> upgradable to 1GB, so shouldn't an address starting at 0x40000000
> physically never be a memory address and never be below the
> high_memory bound?

Can you post a copy of /proc/iomem, and /proc/vme/master, and any
relevant portions of the output from dmesg if available?

> Can I even dereference an I/O memory pointer on the PowerPC?
> (It can be done on x86) I know, I know, I _should_ use readb and
> friends, but can it be done? Or _must_ I strictly use the macros
> because it won't work the other way round?

That's the way I do it on x86. I haven't tried PPC.

BTW, please copy me directly on replies to this thread. I am not
subscribed to this list.

Daniel L. Heater
Software Development, Embedded Systems
GE Fanuc Automation Americas, Inc.
VMIC, Inc.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
