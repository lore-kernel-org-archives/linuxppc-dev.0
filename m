Message-ID: <3C20B5E2.4C3AA604@chinook.com>
Date: Wed, 19 Dec 2001 10:44:34 -0500
From: Peter Desnoyers <pdesnoyers@chinook.com>
MIME-Version: 1.0
To: Jeff Studer <jstuder@aquilagroup.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PCI QSPAN2 resource conflicts
References: <3C1F9452.AB979826@aquilagroup.com> <3C1F8DE8.9FA7CECE@chinook.com> <3C1FBADD.FF66E2A7@aquilagroup.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


An aside - when I was bringing up PCI on our system, I used a
tulip-based card (Staples has one from Linksys for $20) because the 3com
vortex driver had some issues with PPC or vice versa.  Or something like
that.  (I don't remember the details, and it could have been pilot
error)

Walking through your lspci output:

> # lspci -xxx
> 00:03.0 Class 0000: 16b2:5100
> 00: b2 16 00 51 00 00 00 00 00 02 00 00 00 40 00 00
> 10: 41 ff ff f5 81 ff ff f5 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 06 01 0a 0a

vendor = 0x16b2, device = 0x5100   - I assume it's your device
status = 0x0000  weird - I would expect at least 0x0200 (devsel=medium)
- 0s in the 0x0600 mask is devsel=fast
command = 0x0000 weirder - no bus master enable, no I/O access enable,
no memory access enable.  I.e. it does nothing except suck electricity
and emit heat.

base reg 0: f5ffff41 = i/o, addr=f5ffff40, size=64
base reg 1: f5ffff81 = i/o, addr=f5ffff80, size=128

I assume you've set the QSpan up correctly with (in your case) an I/O
target image of size 0x01000000 at 0xf5000000 and a memory target image
of the same size at 0xf4000000.

I'm not sure why lspci -vv is displaying the region size incorrectly as
65 and 129, unless you're supposed to know that .

Now on to the 3Com device:

> 00:04.0 Class 0200: 10b7:9055 (rev 30)
> 00: b7 10 55 90 07 00 10 02 30 00 00 02 00 00 00 00
> 10: 01 00 00 f4 80 ff ff f5 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 55 90
> 30: 00 00 00 00 dc 00 00 00 00 00 00 00 08 01 0a 0a

status = 0x0210 - devsel = medium
command = 0x0007 - master, i/o, memory all enabled

Base registers don't make sense compared to the previous chip:

br0 = f4000001, i/o at 0xf4000000, size 128 (weird - assigned from
bottom of range here, not top)
br1 = f5ffff80, memory at 0xf5ffff80 size 128

You can't have it both ways - 0xf5ffffxx is either I/O or memory, but
not both.  I'm getting a feeling that the values in the base registers
of your device are completely fictitious, and might not come from the
PCI enumeration code.  Or you're doing the PCI enumeration in a
bootloader and doing it wrong...

Note also that the memory space at f5ffff80 totally overlaps with the
first I/O region of your device, besides being the wrong type.  But the
conflict shouldn't matter, since your device is completely turned off,
and isn't going to do anything.  So you shouldn't be loading a driver
for your device, because it isn't there, and if you don't you won't get
any resource conflicts.

Looks like you've got a hardware issue in your device, compounded by the
fact that the PCI bus enumeration code is actually assigning addresses
to your device even though it's disabled.  (although it's probably not
the fault of that code, as I assume it's writing something to the
command register and it's just not sticking)

You're not loading an FPGA after the OS is up and then poking in these
values by hand, are you?

--
.....................................................................
 Peter Desnoyers            (781) 457-1165   pdesnoyers@chinook.com
 Chinook Communications     (617) 661-1979   pjd@fred.cambridge.ma.us
 100 Hayden Ave, Lexington MA 02421

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
