Date: Mon, 13 Sep 1999 15:10:56 -0700 (MST)
From: Matt Porter <mporter@mcg.mot.com>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: A question about zImage when booting from HD
In-Reply-To: <37DD46B2.BFED562@fi.infn.it>
Message-ID: <Pine.LNX.4.10.9909131442250.25054-100000@liberty.chnd1.az.home.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 13 Sep 1999, Simone Piccardi wrote:

> I'm using /dev/sda3 to boot, but I tried anyway to zero it to see if
> something change, but without success. I give a dd if=/dev/zero
> of=/dev/sda3 count=100 and then I copied again zImage in the partition,
> but the result was the same of before. 
> 
> Before erasing all my system I would like to be sure that if I use
> /dev/sda1 it will work. My board is a MVME2432 with a MPC101 PCI
> mezzanine card.

I've had problems in the past with some Powerstack systems not being able
to boot a PReP image from anything other than /dev/sda1....since then I've
been recommending everybody just install the image to sda1 and root from
sda2.

I tried to recreate you problem because I didn't think it existed on our
newer PowerPlus systems.  I slapped a PMC101 in a MVME2431 in the rack and
installed Debian/PowerPC to it with sda1->swap, sda2->root, and
sda3->prepboot with no problems.  It made the system automatically
bootable from sda3 and a "pboot 10 40" (disk on SCSI ID 4) booted up.

Can you post a dump of your partition table on the disk plus the first 1k
of the image?  I have seen the error before somewhere but I think that was
on a byte swapped IDE system the PPCBUG couldn't read...SCSI doesn't have
that problem..bad bad IDE.
 
--
Matt Porter                                   Motorola Computer Group
mporter@mcg.mot.com                           CIBU Linux Support

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
