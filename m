Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83508.mail.sp1.yahoo.com (web83508.mail.sp1.yahoo.com
	[216.252.120.164]) by ozlabs.org (Postfix) with SMTP id 2C578DE082
	for <linuxppc-dev@ozlabs.org>; Fri, 30 May 2008 08:21:44 +1000 (EST)
Date: Thu, 29 May 2008 15:21:43 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: JFFS2 problem, still
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <778673.50038.qm@web83508.mail.sp1.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, so I feel as though now I have a little more
insight to this problem.  Here's a brief rundown.  I
am using u-boot to boot the latest linux kernel from a
large page NAND device (trivial) with the rootfs also
on the same NAND device.  In my dts the fs is defined
as being located at 0x400000 (within the device) and
is 0x1c00000 in size.  The image for the fs that I
burn into the device is 0x240000 in size.

During the boot of linux, after the jffs2 rootfs is
mounted it appears that linux attempts to put the
magic number 0x1985xxxx into the beginning of each
block following the end of the file system through the
end of the device, as if to format the NAND flash for
future use by the jffs2 fs.

Am I correct so far?

Here's the error that I'm seeing.  Instead of writing
this data into the NAND blocks, it's being written
into the spare region of the flash, designated for
ECC, bad block marker, and so on.  This is causing a
large problem as now my blocks are being marked as
bad.

So my second question is, where is the code that
performs this "formatting" of the NAND device
immediately after mounting of the rootfs?

Ron Madrid
