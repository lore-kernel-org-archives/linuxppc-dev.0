Return-Path: <rlrevell@joe-job.com>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by ozlabs.org (Postfix) with SMTP id 9F69A67BAC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Aug 2006 07:26:20 +1000 (EST)
Subject: RE: MTD Flash Howto ?
From: Lee Revell <rlrevell@joe-job.com>
To: "Ned W. Rhodes" <ned@softwaresystemsgroup.com>
In-Reply-To: <001a01c6b7d1$17dd6130$6201eed0@ssgpoweredge>
References: <001a01c6b7d1$17dd6130$6201eed0@ssgpoweredge>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 17:26:34 -0400
Message-Id: <1155331594.32351.39.camel@mindpipe>
Mime-Version: 1.0
Cc: Leonid <Leonid@a-k-a.net>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-04 at 10:20 -0400, Ned W. Rhodes wrote:
> The book Building Embedded Linux Systems has a good section on the use of
> flash file systems.
> 
> When you boot, you will see something like this, depending on the type of
> flash driver you have. Make sure you have defined your mtd map in
> kernel/drivers/mtd/map.
> 
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> JFS: nTxBlock = 965, nTxLock = 7720
> 

Is JFFS2 required to mount MTD devices?

Everything seems to be set up correctly here:

S29GL512N MirrorBit Flash: probing 16-bit flash bus
S29GL512N MirrorBit Flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
S29GL512N MirrorBit Flash: CFI does not contain boot bank location.
Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
Creating 2 MTD partitions on "S29GL512N MirrorBit Flash":
0x00000000-0x02a00000 : "Raw Area"
ftl_cs: FTL header not found.
0x02a00000-0x02b80000 : "User FS"
ftl_cs: FTL header not found.
blkmtd: version $Revision: 1.24 $
blkmtd: error: missing `device' name

cat /proc/mtd:

dev:    size   erasesize  name
mtd0: 02a00000 00020000 "Raw Area"
mtd1: 00180000 00020000 "User FS"

cat /proc/partitions:

major minor  #blocks  name

  31     0      43008 mtdblock0
  31     1       1536 mtdblock1

~ # ls -al /dev/mtdblock[01]
brw-r--r--    1 root     0         31,   0 Aug 11 14:27 /dev/mtdblock0
brw-r--r--    1 root     0         31,   1 Aug 11 14:27 /dev/mtdblock1

As you can see the major and minor numbers are correct, but I cannot
mount the MTD partitions:

~ # mount -t minix /dev/mtdblock1 foo
mount: Mounting /dev/mtdblock1 on /foo failed: No such device

What am I doing wrong?

Lee
