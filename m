Mime-Version: 1.0
Message-Id: <v04210106b405d3d533a4@[192.168.0.1]>
In-Reply-To: <v0313030ab405d00a6b8a@[17.202.21.235]>
References: <v03130302b40589d1f8f6@[17.202.21.235]>
 <v04011701b404e6cd4493@[199.174.193.101]>
 <v04011701b404e6cd4493@[199.174.193.101]>
 <v03130302b40589d1f8f6@[17.202.21.235]>
 <v0313030ab405d00a6b8a@[17.202.21.235]>
Date: Wed, 15 Sep 1999 15:19:40 -0800
To: Peter Bierman <bierman@apple.com>, linuxppc-dev@lists.linuxppc.org
From: Ethan Benson <erbenson@alaska.net>
Subject: Re: New booter
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 15/9/99 Peter Bierman wrote:

>The bootblock on a Macintosh is specified as a structure in an HFS filesystem.

therein lies the problem....

>So I'm not sure what you mean then by the "bootblock of the disk".

on intel machines disks are typically use the very first 512 bytes on 
a disk as a bootblock and partition table, the bootblock portion of 
this is something like 446 bytes long, the BIOS when booting the 
machine has a boot device specified all it does it load that 446 
bytes into memory and execute it that code could be the NT loader the 
old DOS/win95 loader or it could be LILO, that code then can do 
whatever it need to do.  in lilos case it loads its second stage 
loader from the root filesystem and that takes care of loading the 
kernel, if you replace ext2fs with xfs all that needs updating is 
possibly the second stage LILO.  no specific partition or filesystem 
is needed and the BIOS does not care what filesystem you use.

>There's an Apple partition map, which contains a driver map, and other
>helpful info. But there's no executable code stored in the partition map.
>And the drivers on the disk are loaded by Classic Mac OS (not X).

in this case all that is needed is the bootblock on the root 
filesystem which ext2 and hfs both leave room for, a 1024 byte 
nothing at the very beginning of the partition, OF should simply have 
the boot device specified and it should look in the partition table 
for the bootable partition and load the first 1024 bytes of that 
partition into memory and execute it that code can then do whatever 
it needs to do.  this is exactly how quik works or rather worked on 
non newworld macs.  it did not require its own parition and did not 
require HFS.

>But the end result is that OpenFirmware on OldWorld machines is not
>flashable, and the OF on those machines will boot the Apple ROM on those
>machines when result to factory defaults. (Like zapping PRAM).

I agree that is a great deficency of OF.  it should have a interface 
like the PC bios does that does not require a forth programmer to 
configure.

>So unless you want the user to have a rescue CD around for when they zap
>PRAM, you need to have *something* on the disk that the Mac OS ROM thinks
>is bootable. That's what Ben H. is working on. You don't actually need a
>Mac OS System, you just need bits that are in the right place for the ROM
>to think they're a System enough to jump into your code.

this is where I take issue with the design of the macintosh boot 
process, it should not be looking for a file on a filesystem.  the 
nvram should only have teh boot device specified, not a specific OS 
dependant file, macos should have installed a bootblock on the disk 
that OF loaded that took care of finding and loading the MacOS rom 
image, this way you could replace macos with linux or OSX on the same 
disk and never touch OF.

>And part of that "looking like a Mac OS System" is residing on an HFS or
>HFS+ disk. Because (once again) when you zap PRAM, OF boots the ROM,
>period. It's too late for OF booting then.

see above

>
> >requiring a dedicated partition for the BOOTSTRAP is ridiculous.
> >and so is chaining oneself to a single filesystem (HFS)
>
>NewWorld machines have flashable firmware, and OF can then be updated to
>understand different filesystems.

filesystem code does not belong in the firmware.  its not needed 
either if the boot process is done like it is on intel machines, 
which works pretty darn well if you ask me.

>But I still have to support the ability to boot *before* OF gets updated.
>So for UFS systems on NewWorld machines, we have an HFS volume that
>contains all of the OF patches we need, and the booter to find and launch
>the kernel from the UFS volume.

fine maybe you need this on older machines, but the newer machines 
should fix this deficiency, and sport a filesystem INDEPENDANT boot 
process, this way linux and BSD folks don't have to go though such a 
large pain to get their OSes to boot.

>HFS systems on NewWorld machines will just boot directly from the root volume.

if the root volume is HFS, I don't want to use HFS, I like UFS just 
fine, and what if I add xfs or someother filesystem support to darwin 
how do it boot it now? I have to go back to this messy bootstrap 
partition junk.

can you see why relying on HFS or any specific filesystem is inconvenient???
>
>I haven't used quik, but I'm guessing it patches OF so that OF can read a
>booter somewhere? This would be similar to System Disk for OldWorld
>machines, which patches OF, and then points it at a loader partition which
>contains an expanded XCOFF binary (the same binary as the booter, just in a
>format that OldWorld OF can load and execute.)

it does not patch OF at all, here is what quik does:

installs a first stage loader that OF can execute in the first 1024 
bytes of the root filesystem, this code knows how to read the ext2fs 
to find the second stage load that knows how to load the kernel, all 
that needs to be done to OF is this:

setenv boot-device hd:
or if OF cannot seem to figure out what partition is bootable
setenv boot-device hd:7

the problem is something is goofy with the newworld OF where it 
either wont load the bootblock anymore or its just more picky about 
what kinds of scripts it will execute and does not like the quik 
first stage loader at the moment.  quik did work fine on many of the 
pre newworld macs, I think the beige g3s were among them.  (all OSX 
supports anyway)

if you cannot get around the partition hack on older machnes fine use 
it there, but for the newworld flashable macs and all future please 
make a filesystem agnostic boot process.  that is really all I am 
asking of apple.



Best Regards,
Ethan Benson
To obtain my PGP key: http://www.alaska.net/~erbenson/pgp/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
