Date: Wed, 13 Jan 1999 12:55:27 -0600 (CST)
From: "David A. Gatwood" <marsmail@globegate.utm.edu>
To: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
cc: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <19990113104026.C1056@dirkpitt.solsoft.fr>
Message-ID: <Pine.LNX.3.96.990113124607.9183B-100000@globegate.utm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Jan 1999, Hubert Figuiere wrote:

> I'm investigating the possibilities to support 5200/6200 (and its
> little brother 5300/6300) just because this machine is:
> 
> a) not supported by either MkLinux or LinuxPPC
> b) I have one (in fact my fiancee has it).
> 
> There are several custom chips inside (like on any other Mac).
> First the big problem is that 6200 is a PowerPC inside a 68040
> machine. It uses a "CAPELLA" custom chip as a bus translation
> unit. This may be a problem since I don't think it is used in any
> supported PowerMac.

I don't think the Capella support will be too big a hassle, as I'm under
the impression that such hardware should be mostly software-transparent.
I could be completely wrong, though, as it might need some configuration
with regards to the memory management code or something.  Hopefully not.


> Video: It is a "Valkyrie" Chip using a DRAM frame buffer. If I
> remember, Valkyrie is available in several PowerMacs and is
> already supported.

Yes, and I added some code to at least get closer to suppporting the
Valkyrie on x200/x300 machines already.  That shouldn't be a problem, I
don't think.


> Memory Controller: it is a "F108" as in the LC 630 (ses Linux 68k
> port) that also handles IDE, SCSI and SCC serial ports. SCSI in
> this chip is a NCR 53C96. SCC is like the 8530 SCC (that we find
> in several Macs too).

The memory controller _may_ require some tweaks, but I doubt it, since
booting the machine gets a lot farther than I'd expect if the memory
mapping stuff didn't work.  :-)


> ADB: "CUDA" chip similar to several 68k Mac. Accessed thru the
> "PrimeTime II". It is the 68HC05 and also handles PRAM, RTC,
> power supply control.

As long as we can get the base of the cuda portion of the chip, that's
easy enough.


> Sound: a "DFAC II" chip.

There probably wouldn't be sound support initially, but that's not exactly
a super-high priority compared to booting.  ;-)


> Other: "PRIMETIME II" chip manages SWIM II, VIA1, VIA2, sound

Are you sure it's not a SWIM III?  Because if it's a II, we may have to
add some stuff to the floppy support eventually.  We can probably swipe
code from NetBSD-mac68k, though.  It'll be a pain in the rear, but
workable.  Just a few swimii_blah functions or whatever....

Right now, the big problem is the interrupt controller.  The moment we
enable it, the monitor shuts off (according to several reports).  That's
on the 5x00's, of course, since I don't suppose you can turn off the
monitor in software on the 6x00's.  :-)  Anyway, there are some critical
addresses missing.  If I don't hear any details, I'll try to hack some in
MacsBug....


Later,
David

David A. Gatwood                         Visit globegate's internet
dgatwood@globegate.utm.edu                  talker, Deep Space 36
http://globegate.utm.edu                telnet globegate.utm.edu:9624

-----BEGIN GEEK CODE BLOCK-----
Version 3.1
GCS/CC/FA/H/L/MC/M/MU/PA/TW d-@ s:>- a-- C++ ++>$ UBLAS*++ ++>$
P+?>$ L++ +>$ !E--- W++ +>$ N++(++ +)>++ +$ !o? K-? !w--- !O
M++>$ !V-- PS+>$ !PE- Y+>$ PGP+>$ t++ +>$ 5+>++ ++$ !X- !R tv+>$
b++>$ !DI !D- G++(++ +)>$ e>++ ++ h--! r--- !y-
------END GEEK CODE BLOCK------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
