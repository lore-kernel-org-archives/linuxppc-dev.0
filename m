Message-ID: <3AF99E78.D7F80BAF@sgi.com>
Date: Wed, 09 May 2001 14:46:00 -0500
From: Steven Hein <ssh@sgi.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: SUCCESS booting off cramfs initrd
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Last week I asked for help in my cramfs adventure, so now that
I've had some success, I thought I'd share how I got it
done.

My original goal was to boot from a cramfs filesystem residing
in flash.  As people explained to me, that would have required
me to have a small ext2 initrd filesystem to boot from
and them mount my cramfs filesystem as the root filesystem
(through the /dev/mtd device, accessed through the MTD drivers).
I went down this road, but found that the current MTD CFI flash
drivers didn't support big-endian configurations at all.
(Actually, I created a MTD map driver for my board that treated the
 flash space as ROM and I was able to access it).  But, I didn;t
really want to created two separate filesystems (the ext2 initrd,
and the cramfs root filesystem), so I didn't continue this approach.

It later occurred to me that, due to the way I update my image in
flash, the filesystem needed to live in RAM.  I still wanted to
use cramfs to save RAM (my ext2 filesystem was 4.5MB, too expensive
for a 16MB board).  But, this brought me back to trying to use
a cramfs initrd as my root filesystem.

So, here's what I did to accomplish this:
- started with linux-2.4.4 kernel plus linuxppc_2_4 diffs patch
- incorporated the cramfs patch from Transmeta's Midori Linux
  1.0.0-beta1 release  (they use a different packaging mechanism,
  so you'll need to get the whole Midori release and unpack/build
  it to get access to the patch).  I'm not sure if this step was
  necessary or not......but the patch makes significant improvements
  to the cramfs filesystem, so I wanted it  (someone else may be able
  to answer this better).
- modified drivers/block/rd.c to make several changes:
    1) detect the cramfs superblock (at offset 0 or offset 512
       in the first block of the filesystem)
    2) when a cramfs filesystem is detected, force the block
       size of the ramdisks to 4KB, which is cramfs's block size.
       (this step tripped me up for several days, as I didn't
        and still don't know much about block devices....but I did
        learn that the ramdisk that cramfs is on must use 4KB blocks!)
- modified David Blythe's originalendian-swap patch to mkcramfs to work
  over the top of Midori's cramfs patch.  Basically, this provided a
"-r"
  option to mkcramfs to reverse the endian-ness of the filesystem
  (my host is an i686 box and my target is a custom MPC860T board).

Basically, when i did all of the above, I was able to boot off
of a cramfs initrd, and continue to use it as my root filesystem.

I put all of the patches that I used to accomplish this out at:
(listed in the order in which they should be applied)

    http://www.geocities.com/heinss1/cramfs_midori.patch.txt
    http://www.geocities.com/heinss1/mkcramfs_endian.patch.txt
    http://www.geocities.com/heinss1/cramfs_initrd.patch.txt

for whoever may be interested.  Hope it helps someone else get off
the ground faster!

Steve



--
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Steve Hein (ssh@sgi.com)              Engineering Diagnostics/Software
Silicon Graphics, Inc.
1168 Industrial Blvd.                 Phone: (715) 726-8410
Chippewa Falls, WI 54729              Fax:   (715) 726-6715
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
