Return-Path: <nathan.french@onrampwireless.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1CC8DB70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 22 Aug 2009 06:48:20 +1000 (EST)
Received: from relay.ihostexchange.net (relay.ihostexchange.net [66.46.182.55])
	by ozlabs.org (Postfix) with ESMTP id B6A9BDDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Aug 2009 06:48:18 +1000 (EST)
Subject: Having trouble using mtdparts kernel command line to repartition flash
From: Nathan French <nathan.french@onrampwireless.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 21 Aug 2009 13:48:03 -0700
Message-ID: <1250887683.20417.7499.camel@localhost.localdomain>
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've got a kilauea (PPC405EX) board that we've decided needs more room
in one of the flash partitions.  So I took the existing command line
(which came from the dev kit):

Kernel command line: ramdisk_size=65536 root=/dev/ram rw
mtdparts=fc000000.nor_flash:2M(linux),20M(ramdisk),4M(jffs2),38272k(user),256k(env),384k(uboot) ip=10.2.3.28:10.1.0.65:10.0.0.1::kilauea:eth0:off panic=1 console=ttyS0,115200

And modified it like below (4M -> 8M, 38272k->34176k).  We're not
currently using the user partition, so I just borrowed 4MB from it.

Kernel command line: ramdisk_size=65536 root=/dev/ram rw
mtdparts=fc000000.nor_flash:2M(linux),20M(ramdisk),8M(jffs2),34176k(user),256k(env),384k(uboot) ip=10.2.3.28:10.1.0.65:10.0.0.1::kilauea:eth0:off panic=1 console=ttyS0,115200
        
And I get the below error.  I noticed that the device tree (FDT/DTB)
lists some partitions as well that don't exactly match up with the
original parameters, so I ignored that part of the FDT.  Is this ok?
Does Linux ignore the partition information from the FDT when U-Boot
passes partition arguments?

Oh and... well why is the ram0 device complaining when I modify the
flash partitioning?  I'm not expecting the 20M ramdisk portion to be
affected.  Also I noticed that the device tree (DTS/DTB) does not
reflect the original partition scheme.  Does it need to or is the device
tree ignored when using the mtdparts partitioning?  I tried modifying it
to match but didn't seem to make a difference.

Am I missing something here?

RAMDISK: Compressed image found at block 0
RAMDISK: incomplete write (24576 != 32768) 35815424
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 136k init
attempt to access beyond end of device
ram0: rw=0, want=98312, limit=70000
EXT2-fs error (device ram0): ext2_get_inode: unable to read inode block
- inode=12289, block=49155
Warning: unable to open an initial console.
attempt to access beyond end of device
ram0: rw=0, want=98312, limit=70000
EXT2-fs error (device ram0): ext2_get_inode: unable to read inode block
- inode=12289, block=49155
attempt to access beyond end of device
ram0: rw=0, want=98312, limit=70000
EXT2-fs error (device ram0): ext2_get_inode: unable to read inode block
- inode=12289, block=49155
attempt to access beyond end of device
ram0: rw=0, want=98312, limit=70000
...

Thanks,

Nathan French
