From: ghannon@cspi.com
To: "li" <slowforce@21cn.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256D64.00487C65.00@pine.cspi.com>
Date: Tue, 15 Jul 2003 09:31:04 -0400
Subject: Re: program update
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Li,
     I think you mean to say that you would like to keep the application in
flash,
in some sort of filesystem where it can be replaced easily.  If that is the
case, see the
MTD maps, and the JFFS2 filesystem.   If you create a partition map and
leave
room in flash for a partition to hold your application, then you format the
flash partition
once (or not at all?)  and create the filesystem on it.  From then on you
can set up a
mount point and just copy the new updated program to that area, and run it
like any
command.    It also automatically compresses data as you copy it in, which
is nice.

     Having a ramdisk to contain your application means you would be using
up more ram which might be needed to run the program, and the program would
be gone
when power is cycled.    I don't think that's what you want is it?

     If you are building your kernel from the linuxppc_2_4_devel tree, see
drivers/mtd/maps/
arctic-mtd.c.   This is a good example of an easy partitioning scheme that
leaves room
for kernel, romfs and a flash filesystem.

     See also the JFFS HOWTO for more details.  I'm not sure how up-to-date
this is.
 http://ftp.linux.org.uk/pub/people/dwmw2/mtd/cvs/mtd/mtd-jffs-HOWTO.txt

Good Luck,
Gary






"li" <slowforce@21cn.com> on 07/13/2003 11:53:29 PM

To:   linuxppc-embedded@lists.linuxppc.org
cc:    (bcc: Gary Hannon/CSP)
Subject:  program update





Hello all,
In our system(based on MPC850 and ppc linux), i need to update the
application program frequently. ppcboot, kernel image and
filesystem(ramdisk) are all programmed into Flash memory. i want to make
another ramdisk  for application program, but how?
Any resourece about it?
Thanks in advance!
Best Regards!
Li


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
