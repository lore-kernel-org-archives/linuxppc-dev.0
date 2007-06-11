Return-Path: <gkenaley@echelon.com>
Received: from [205.229.50.10] (ntfw.echelon.com [205.229.50.10])
	by ozlabs.org (Postfix) with ESMTP id 3053BDDEC6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 05:59:55 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Linux 2.6.x, MTD drivers and NAND flashes
Date: Mon, 11 Jun 2007 12:59:53 -0700
Message-ID: <DDBD7B17DB2ECE48BCD94C593F7255B4046EA149@monk.echelon.echcorp.com>
In-reply-to: <466D7169.1000407@billgatliff.com>
References: <000001c7ac3c$15e7da80$5201a8c0@GEG2400>
	<466D7169.1000407@billgatliff.com>
From: "Gary Kenaley" <gkenaley@echelon.com>
To: "Bill Gatliff" <bgat@billgatliff.com>,
	"Laurent Lagrange" <lagrange@fr.oleane.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Laurent,

Can't you just use the flashcp copy command from the mtd-utils package?
-----------------------------------------------------------------------
flash_eraseall -j /dev/mtd0

mkfs.jffs2 -b -n --eraseblock=3D131072 --pagesize=3D2048 -p -r =
/test_root -v -o test_root.img

flashcp test_root.img /dev/mtd0


The other way is what Bill mentions:
------------------------------------
flash_eraseall -j /dev/mtd0
mount -t jffs2 /dev/mtdblock0 /tmp/mnt
tar -xzf test_root.tgz -C /tmp/mnt
umount /tmp/mnt

Gary

> > ________________________________________
> > From: linuxppc-embedded-bounces+gkenaley=3Dechelon.com@ozlabs.org > =
> > [mailto:linuxppc-embedded-bounces+gkenaley=3Dechelon.com@ozlabs.org] =
On Behalf > > Of Bill Gatliff
> > Sent: Monday, June 11, 2007 9:00 AM
> > To: Laurent Lagrange
> > Cc: linuxppc-embedded@ozlabs.org
> > Subject: Re: Linux 2.6.x, MTD drivers and NAND flashes
> >
> > Laurent Lagrange wrote:=20
> > Hello,
> >
> > I use a Linux 2.6.9 on a 85xx custom board with a NAND flash.=20
> >=A0
> > This flash has some bad blocks.
> > NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND =
128MiB > > 3,3V 8-bit)
> > Scanning device for bad blocks
> > Bad eraseblock 8 at 0x00100000
> > Bad eraseblock 430 at 0x035c0000
> >...
> > Creating 1 MTD partitions on "NAND 128MiB 3,3V 8-bit":
> > 0x00000000-0x08000000 : "flash partition 1".
> >=A0
> > I have selected in the kernel :
> > 1) the MTD character and block supports for NAND,
> > 2) the CRAMFS and JFFS2 supports for NAND.
> >=A0
> > I can erase the flash but receive IO errors for each bad blocks =
(that > > seems right).
> > I can mount an empty JFFS2 partition on the NAND and untar some > > =
directories and files in it.
> >=A0
> > I would like to generate some JFFS2 images and program them in the =
flash > > with a character=20
> > command like "cat img > /dev/mtd/0". If I dont encounter a bad =
block, it > > runs right=A0else the=20
> > command fails.=20
> >=A0
> > This is a little bit annoying. So my question is simple :=20
> > Is there a MTD character driver which can detect and ignore the bad =
> blocks > in a NAND flash=A0?=20
> >
> Wrong question.=A0 :)

> With NAND, working directly with the media is indeed a pain because of =
bad > blocks.=A0 What's done instead is to leave that to the =
filesystem.=A0 Pick a > NAND-aware one like YAFFS.
>
>
> b.g.
>
> --=20
> Bill Gatliff
> bgat@billgatliff.com
