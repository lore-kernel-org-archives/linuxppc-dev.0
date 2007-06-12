Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C7824DDDF8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 23:38:41 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hy6ZZ-000078-Lu
	for linuxppc-embedded@ozlabs.org; Tue, 12 Jun 2007 15:38:13 +0200
Received: from p5497d0b8.dip.t-dialin.net ([84.151.208.184])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Jun 2007 15:38:13 +0200
Received: from dzu by p5497d0b8.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 12 Jun 2007 15:38:13 +0200
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: Linux 2.6.x, MTD drivers and NAND flashes
Date: Tue, 12 Jun 2007 15:37:43 +0200
Message-ID: <m2k5u9xpi0.fsf@sowhat.denx.de>
References: <000001c7ac3c$15e7da80$5201a8c0@GEG2400>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Laurent,

> I use a Linux 2.6.9 on a 85xx custom board with a NAND flash.
>  
> This flash has some bad blocks.
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND 128MiB 3,3V
> 8-bit)
> Scanning device for bad blocks
> Bad eraseblock 8 at 0x00100000
> Bad eraseblock 430 at 0x035c0000
> ...
> Creating 1 MTD partitions on "NAND 128MiB 3,3V 8-bit":
> 0x00000000-0x08000000 : "flash partition 1".
>  
> I have selected in the kernel :
> 1) the MTD character and block supports for NAND,
> 2) the CRAMFS and JFFS2 supports for NAND.
>  
> I can erase the flash but receive IO errors for each bad blocks (that seems
> right).
> I can mount an empty JFFS2 partition on the NAND and untar some directories and
> files in it.
>  
> I would like to generate some JFFS2 images and program them in the flash with a
> character
> command like "cat img > /dev/mtd/0". If I dont encounter a bad block, it runs
> right else the
> command fails.
>  
> This is a little bit annoying. So my question is simple :
> Is there a MTD character driver which can detect and ignore the bad blocks in a
> NAND flash ? 

Actually there is the UBI[1] subsystem dedicated to this problem which
entered mainline late in April.  If you have that in your kernel, you
can feed your flash to UBI and get an bad-block aware mtd device out
of it.  This should allow your intended usage.  Of course you can have
JFFS2 sit on top of that.

Cheers
  Detlev

[1] http://www.linux-mtd.infradead.org/faq/ubi.html

-- 
I have always observed that the pretensions of all people are in
exact inverse ratio to their merits; this is one of the axioms of
morals.                            -- Joseph Lagrange
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
