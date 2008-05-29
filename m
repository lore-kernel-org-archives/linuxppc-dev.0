Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83511.mail.sp1.yahoo.com (web83511.mail.sp1.yahoo.com
	[216.252.120.167]) by ozlabs.org (Postfix) with SMTP id 12EA3DDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 29 May 2008 10:32:51 +1000 (EST)
Date: Wed, 28 May 2008 17:32:49 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: JFFS2 FS not writeable
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <483DA7AB.4090009@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <282240.86566.qm@web83511.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So I found something that looks suspicious to me. 
This may not be a fsl_elbc_nand.c problem, but a more
general problem.

Shortly after mounting the root filesystem, which is a
jffs2 on a large page NAND device (my board is based
on the MPC8313) the kernel appears to read the device
starting just past the point defined by the 0x1985 . .
. markers in the jffs2 filesystem, through the end of
the device as defined by the dtb.  More specifically
in my device, the file system is approximately
0x200000 and resides at 0x400000 with the end of the
device being 0x2000000.  As it does this it is then
writing the oob data into these blocks (0x600000 -
0x1fe0000).   The value that it was writing into the
first 4 bytes of the oob are 0xff198520.  This was
problematic as the 0x20 was being placed into the
large page NAND device bad block location (0x0). 
Given that there is a 0xff at the msb of the oob data,
could this possibly be a byte swapping issue?  I don't
see though how this could be a problem in the large
page NAND but not the small page NAND.  I verified
this by writing 0xffffffff in to the first 4 bytes of
the oob data to ensure that 0xff was written into the
bad block location.

In the function fsl_elbc_write_buf:
(*(unsigned int *)buf) = 0xffffffff;

I know that this isn't a fix, but I don't know where
this problem comes from and also I don't know the
exact flow of the NAND device processes.

I would be more than happy to investigate further and
provide a patch if someone could point me in the right
direction.

Let me know if I'm off base here, but I think this is
where my problem is.

Ron Madrid
