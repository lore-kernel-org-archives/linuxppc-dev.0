Date: Thu, 12 Jun 2003 23:44:00 -0600 (MDT)
From: Terry Greeniaus <tgree@phys.ualberta.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: pismo upgraded to 750fx not detected correctly
In-Reply-To: <200306130459.XAA18908@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.10306122335280.3129-100000@pneuma.phys.ualberta.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 12 Jun 2003, Chris Studholme wrote:

> I have a Powerbook G3 (Pismo) 400MHz that I've been running Linux on for
> almost 3 years now.  It has been working great, but to ensure that it
> continues to serve me well, I purchased the Powerlogix BlueChip G3 900MHz
> upgrade <http://www.powerlogix.com/products2/bcg3pismo/index.html>.  The
> machine still runs Linux ok, but I have a few problems.
>
> First off, the new processor is an IBM 750FX, but it is recognized as a
> 740/750.
>
>   $ cat /proc/cpuinfo
>   cpu             : 740/750
>   temperature     : 20 C (uncalibrated)
>   clock           : 550MHz
>   revision        : 2.2 (pvr 0008 0202)
>   bogomips        : 1795.68
>   machine         : PowerBook3,1
>   motherboard     : PowerBook3,1 MacRISC2 MacRISC Power Macintosh
>   detected as     : 70 (PowerBook Pismo)
>   pmac flags      : 00000007
>   L2 cache        : 1024K unified
>   memory          : 256MB
>   pmac-generation : NewWorld
>
> I believe pvr should be 7000 0202.  Also, the clock speed is 900MHz, not
> 550MHz.  I have verified, using some numerical cpu bound programs I have,
> that this machine is running at least twice as fast as it did before the
> upgrade.  Also, note that the bogomips value seems to imply the machine is
> actually running at 900MHz.  Finally, the L2 cache is now only 512K, but
> included on the processor die running at 900MHz.

[mega-snip]

The PowerLogix 900 MHz bluechips are 750FX CPUs, however they have been
strapped so that the PVR reports itself as 0x0008nnnn instead of
0x7000nnnn, so that Apple's OpenFirmware can better support them (in
particular, to automatically enable the L2 cache).  The correct way (on
these boards, anyhow) to determine if this is a 750FX is by writing to
the HID1 register and seeing if it changed.  I have a code snippet to do
this if anyone wants it, although it isn't LinuxPPC-specific.  This is
backwards-compatible with normal 750 CPUs, they don't take an exception
if you try to write to the HID1 register.

As for why it is showing up as 1MB L2 cache, I'm not sure except that
the firmware writes to the 750FX L2CR as though it were a 1MB 750 L2
cache, and then Linux may be reading that value back later on.  It's
harmless since those other bits in the 750FX L2CR don't do anything, but
it might be confusing the kernel.

As for why your test program didn't ramp up/down in speed as you changed
the PLL ratio, I don't know, but I didn't look over it very carefully.
These CPUs definitely support it, so you were probably doing something
incorrectly, or maybe the code wasn't allowing it because it thinks it
is a 750 and not a 750FX CPU.

TG


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
