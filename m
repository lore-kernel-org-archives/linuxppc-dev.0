Date: Mon, 13 Sep 1999 19:22:31 +0200
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au,
        eek@escape.ca
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: New booter
Message-Id: <19990913192231.002595@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've uploaded preliminary work for a new booter, it's available at:

http://calvaweb.calvacom.fr/bh40/test.html and is called "miBoot".

It's a fake MacOS System file that should allow booting on real-ROMs Macs
(pre-new world) without a complete MacOS installed. For the moment, I
mostly tested it with a floppy containing:

 - The fake "System" file,
 - A fake (empty) "Finder" file (with the correct type and creator)
 - A compressed kernel. Currently, the kernel MUST be the normal
"vmlinux" file compressed with a "gzip -vf9 vmlinux" and named
vmlinux.gz. Of course, this may change in the future.

Also, the disk must be "blessed". It must have the correct boot blocks to
be recognized as a bootable disk. A DiskCopy disk image is included in
the archive which should have all the appropriate stuffs. The bootblocks
can be put manualy (block 0 and 1 of the HFS file system) from the "boot"
resource ID 1 in the system.

The current version contains all BootX code (some parts slightly
rewritten, some bugs fixed). It works up to the point where the kernel
tries to boot. The prom.c messages are correctly displayed, the address
(0) seems to be correct, the MSR value too, I made a quick check of the
device tree and it looks ok too, but the kernel hangs. (I tried adding
xmon to the command line, but it won't go that far).

You can get a lot of messages from the booter by pressing the option
(alt) key when it's loaded (just keep it pressed until the happy map is
replaced by... you'll see).

I won't have time to do much more work on this until next week-end, so
feel free to hack, find out why the kernel doesn't boot, etc....

Also, I temporarily removed the NuBus code. I'll put it back in when I
have something more "polished". Most of the code of the boot 2 and 3
resources should work on 68k. Some _StripAddress may be needed on old
ROMs, and a couple of traps may need to be checked for existence before
using them. Also, on those old machines, we may have to hack a bit more
with the MacOS low memory stuffs and heap/stack sizes.

Once finished, this booter should allow to make bootable linux CDs for
all supported macs. The NewWorld mac will need the addition of a
boot-info file and the secondary loader.
It should also allow bootable floppies. For hard disks, it should work
(booting from a small HFS partition like MacOS X) but we sill need a
working disk driver on the hard disk. I have some work in progress for
one, I'll go back at fixing it when miBoot is ok.

Have fun !

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
