In-Reply-To: <199909170032.KAA13065@tango.anu.edu.au>
Date: Fri, 17 Sep 1999 17:06:50 +0200
To: linuxppc-dev@lists.linuxppc.org
CC: Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: New booter (about quik)
Message-Id: <19990917170650.032280@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 17, 1999, Paul Mackerras <paulus@cs.anu.edu.au> wrote:

>So in principle it would be possible to put the quik first-stage
>bootstrap on an HFS partition.  You would just have it as a contiguous
>HFS file somewhere and set the partition table entry to point to it.

We could also simply make a bootstrap partition, like Darwin's
SecondaryLoader (not the same as MacOS X Server's one). 
The interesting this is that the partition map itself is usually quite
large (about 32k), and can be shrinked to make room for such a partition
(I did this some years ago for a security application on MacOS).

I did find more details about the way bootable CDs are done. Basically,
they contains a hacked partition map (that can be read with both a 2k
bloc size and a 512k block size, using "shadow" partitions) and they
contain a driver like any SCSI or ATA disk. There's also a special Apple
patch which checks for the "C" key and changes the default boot device
(in a weird way) when pressed. There is enough rooms in those special CD
maps to store one or two more partitions, allowing us to have an ext2 or
ISO partition after the HFS one. It's not as good as a fully ISO CD but
would probably allow to work around OF limitations.

So for bootable CDs, we have two solutions. In all cases, I beleive we
need an HFS partition for OF 3. Then we can either:

 - Have an miBoot-like fake System for older OFs and/or NuBus macs. This
requires having the special Apple driver on the CD, the CD must be burned
with Adaptec Toast on MacOS. This technique can also be used for floppies
(without any driver) and for hard disks (need a MacOS driver on the
disk). This could be a fist step since miBoot is almost working.

 - Have a fake driver on this CD which contains miBoot code. It could be
triggered either automatically (when booting with the CD in the driver)
or via a key combo. We can even imagine a simple user interface, there
are bits of QuickDraw that can be used during driver loading (they are in
ROM) and we can always tap the frame buffer directly. The keyboard state
can be read either via the Event Manager (partially working at this point
in boot) or by reading the MacOS KeyMap image in low memory.

Both techniques should also work for 68k macs that support booting from a
CD (I think the first one is the IIvx). 

The only issue with the second solution is that the MacOS SCSI Manager
and ATA Manager are the ROM versions and they do contain bugs. Usually,
drivers embed a special patch partition containing various Apple patches
used for fixing those, but the patches must be licenced (probably a no
fee licence, but it's a licence and so can be annoying).
We may be able to boot anyway without those patches by using exxclusively
synchronous polled SCSI calls and/or simple PIO0 ATA calls.

Finally, for hard disks, we may be able to put a booter in a "chained
driver" partition. This is a special driver which will itself load
another driver. It's mainly used to install the apple patches. This way,
we could chain a driver before the real macos hard disk driver (if the
user wants MacOS of course). We can develop a full featured MacOS driver,
I do have some sources to start from, but the problem of licencing the
apple patches will still be there. Note that developing a driver would be
useful for mac-on-linux.

I don't know if I'll have time to do much useful work this week end, we
have AppleExpo here in France and I have a couple of personal things to
do. If someone wants to look at the current miBoot code and find out why
the kernel hangs, you have time ;-) Also, my powerbook is giving signs of
fatigue (the LCD is dying).

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
