Date: Tue, 24 Oct 2000 15:55:54 +0300 (EET DST)
From: Topi Kanerva <tkanerva@ees2.oulu.fi>
To: "Mark A. Greer" <mgreer@mvista.com>
cc: Zhaobin Zhu <zzhu@emc.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: <kernel-image-name>
In-Reply-To: <39E7709B.D9A6AAA9@mvista.com>
Message-ID: <Pine.GSO.4.21.0010231622560.25586-100000@stekt8>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


More experimentation with 2.4.0-test2 sandpoint kernel...
Because I couldn't make nfs booting to work (always the same oops after
mounting root...) I decided to try to mount an initrd instead. So, I took
the debian rootdisk image
(.../disks-powerpc/current/powermac/ramdisk.image.gz) and copied that to
arch/ppc/boot and then re-made the kernel with make zImage.initrd and then
zsrec'd the  zvmlinux.initrd that the make process left lying around
there... Then upload the stuff over to DINK. However, on bootup I get this:

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
RAMDISK: Couldn't find valid RAM disk image starting at 0.
Freeing initrd memory: 4194301k freed

and afterwards the VFS issues a kernel panic since it cannot mount root fs
on 01:00 (/dev/ram)
...
now, should the ram disk work, or am I doing something fundamentally wrong
here? I've config'd the kernel to use both CONFIG_BLK_DEV_RAM and
CONFIG_BLK_DEV_INITRD so I suppose ramdisks should work. The kernel
bootloader even seems to see the piggybacked ramdisk:

DINK32/MPC7400@46u>>go 200000
loaded at:     00200000 00214E20
relocated to:  00800000 00814E20
board data at: 0080E314 00814D20
relocated to:  0080E314 00814D20
zimage at:     0020B000 002932FE
relocated to:  00815000 0089D2FE
initrd at:     002932FE 003FB2FE
relocated to:  0089D2FE 00A052FE
avail ram:     00400000 00800000

Linux/PPC load: root=/dev/ram


Any ideas what I'm doing wrong here? I've been up all day so when you're
really tired, there's something really stupid I'm forgetting right now...

I don't know why, but I seem to be the only one that cannot even make the
damn stupid sandpoint to boot at *all*. Maybe I should get a job cleaning
toilets instead...


-topi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
