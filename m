Message-ID: <76C7EB7C8500594F9001B118E7E778F48F4D6B@mdsms3.inside.mdsroc.com>
From: "Ruhland, Paul" <PRuhland@microwavedata.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cramfs mpc8xx 2.4.18
Date: Fri, 13 Feb 2004 14:42:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just want to add:

The code in that patch was adapted for the 2.4.23 kernel from the
'linux-2.4' srctree on the denx site (see 'linux-2.4/drivers/block/rd.c').

-----Original Message-----
From: Ruhland, Paul [mailto:PRuhland@microwavedata.com]
Sent: Friday, February 13, 2004 2:31 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cramfs mpc8xx 2.4.18


Without more information I can't really tell what is wrong.  Did you create
an mtd partition map for your flash (need this to use the mtdblock devices)?

I used to mount cramfs images from flash, but ran into problems every so
often with the cramfs root not decompressing correctly while reprogramming
other sectors.  So I switched to mounting the cramfs image as a ramdisk.
You just build the cramfs image as usual but mount is as a ramdisk when
booting the kernel (I use u-boot so I used mkimage to prep it for that
also).

I've attached a patch against linuxppc_2_4_devel (2.4.23) which adds this
capability, if your interested.  It simply changes the ramdisk blocksize to
match cramfs blocksize if its mounting a cramfs root image.


-----Original Message-----
From: Lokesh Kumar [mailto:kumar.lokesh@wrx-us.com]
Sent: Friday, February 13, 2004 1:33 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: cramfs mpc8xx 2.4.18



Hi Gurus,

I have a custom board running 2.4.18 with initrd. Now, I want to make cramfs
as root filesystem. When I built cramfs support in the kernel and gave it
root=/dev/mtdblock1 (where my cramfs in correct endian order is stored on
flash) rootfstype=cramfs, the kernel hangs. MTD support is built in the
kernel. If I build cramfs as module, then boot my kernel with initrd (ext2)
and then mount it (on say /mnt), I can read cramfs correctly.

I also looked at rd.c file in drivers/block and noticed that this is does
not have cramfs initrd support. Do I need this? What am I doing wrong?
Please help

Lokesh Kumar


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
