Return-Path: <ned@softwaresystemsgroup.com>
Received: from server153.softwaresystemsgroup.com (softwaresystemsgroup.com
	[209.61.184.153])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7F3AC679FD
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Aug 2006 00:33:48 +1000 (EST)
From: "Ned W. Rhodes" <ned@softwaresystemsgroup.com>
To: "'David H. Lynch Jr.'" <dhlii@dlasys.net>
Subject: RE: MTD Flash Howto ?
Date: Fri, 4 Aug 2006 10:20:09 -0400
Message-ID: <001a01c6b7d1$17dd6130$6201eed0@ssgpoweredge>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <mailman.2056.1154699657.11183.linuxppc-embedded@ozlabs.org>
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

The book Building Embedded Linux Systems has a good section on the use of
flash file systems.

When you boot, you will see something like this, depending on the type of
flash driver you have. Make sure you have defined your mtd map in
kernel/drivers/mtd/map.

JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
JFS: nTxBlock = 965, nTxLock = 7720

Then if you have the MTD partitions correctly identified, the kernel will
show you something like:

CBG flash bank 0: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
Creating 2 MTD partitions on "CBG flash bank 0":
0x00000000-0x01800000 : "ffw1"
0x01800000-0x02000000 : "filesystem1"

Once booted you can look at /proc/mtd and you should see the partitions
something like:

[root@lbg ]# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 01800000 00020000 "ffw1"
mtd1: 00800000 00020000 "filesystem1"

Your mileage may vary depending on the type of flash you have and all the
configuration options, but that is basically how to tell that things are
mapped and ready for use.

Ned W. Rhodes
Software System Group
703.812.5072 x100
