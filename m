Message-Id: <v0313030ab405d00a6b8a@[17.202.21.235]>
In-Reply-To: <v04210101b405cc106028@[192.168.0.1]>
References: <v03130302b40589d1f8f6@[17.202.21.235]>
 <v04011701b404e6cd4493@[199.174.193.101]>
 <v04011701b404e6cd4493@[199.174.193.101]>
 <v03130302b40589d1f8f6@[17.202.21.235]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 15 Sep 1999 15:48:25 -0700
To: Ethan Benson <erbenson@alaska.net>
From: Peter Bierman <bierman@apple.com>
Subject: Re: New booter
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>Since I'm the one that came up with the "disgusting kludge", do you have
>>any ideas to share on how to make it better?
>
>yes I have already mentioned it, do it like intel machines do, the
>BIOS (OF) loads code from the bootblock of the disk or root partition
>(marked bootable in the partition table), simple and filesystem
>independent.

The bootblock on a Macintosh is specified as a structure in an HFS filesystem.

So I'm not sure what you mean then by the "bootblock of the disk".

There's an Apple partition map, which contains a driver map, and other
helpful info. But there's no executable code stored in the partition map.
And the drivers on the disk are loaded by Classic Mac OS (not X).

But the end result is that OpenFirmware on OldWorld machines is not
flashable, and the OF on those machines will boot the Apple ROM on those
machines when result to factory defaults. (Like zapping PRAM).

So unless you want the user to have a rescue CD around for when they zap
PRAM, you need to have *something* on the disk that the Mac OS ROM thinks
is bootable. That's what Ben H. is working on. You don't actually need a
Mac OS System, you just need bits that are in the right place for the ROM
to think they're a System enough to jump into your code.

And part of that "looking like a Mac OS System" is residing on an HFS or
HFS+ disk. Because (once again) when you zap PRAM, OF boots the ROM,
period. It's too late for OF booting then.


>requiring a dedicated partition for the BOOTSTRAP is ridiculous.
>and so is chaining oneself to a single filesystem (HFS)

NewWorld machines have flashable firmware, and OF can then be updated to
understand different filesystems.

But I still have to support the ability to boot *before* OF gets updated.
So for UFS systems on NewWorld machines, we have an HFS volume that
contains all of the OF patches we need, and the booter to find and launch
the kernel from the UFS volume.

HFS systems on NewWorld machines will just boot directly from the root volume.


>the bootblock method works on most OF machines since there are plenty
>of people using quik to do it, its the newworld machines that are
>either different or broken, however they have a flashable ROM so
>apple can fix this oversight.

I haven't used quik, but I'm guessing it patches OF so that OF can read a
booter somewhere? This would be similar to System Disk for OldWorld
machines, which patches OF, and then points it at a loader partition which
contains an expanded XCOFF binary (the same binary as the booter, just in a
format that OldWorld OF can load and execute.)

-pmb

--
"UNIX shells in Mac OS X should be unneeded but functional...
                        and have the same installed base as MPW."


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
