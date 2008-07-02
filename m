Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83508.mail.sp1.yahoo.com (web83508.mail.sp1.yahoo.com
	[216.252.120.164]) by ozlabs.org (Postfix) with SMTP id 42F2FDDF3B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 05:59:58 +1000 (EST)
Date: Wed, 2 Jul 2008 12:59:56 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: Re: Kernel marking NAND blocks bad
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <486BDB12.8070406@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <972393.72007.qm@web83508.mail.sp1.yahoo.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

During boot the kernel mounts the root file system and (I think) based on the size of the NAND in
the dts attempts to "format" the rest of the NAND fs partition.  At this point the blocks are
being marked as bad.  Therefore, when I reboot, the kernel thinks that there is no more usable
space in the file system due to all the "bad" blocks.  My dts is very similar to the 8313.

I think the problem is that for the Large Page FLASH, when checking for bad blocks bytes 0 and 1
in the oob are being checked.  However in fsl_elbc_nand.c the .oobfree begins at byte 1. 
Therefore if something is being written to byte 1 in the oob, and later is checked to see if the
block is bad, it will be seen as bad when it checks byte 0 and 1.  The changes below have worked
for me, but I don't know if these changes are "right", or if there is something else that should
be done instead.

/* Large Page FLASH with FMR[ECCM] = 0 */
static struct nand_ecclayout fsl_elbc_oob_lp_eccm0 = {
	.eccbytes = 12,
	.eccpos = {6, 7, 8, 22, 23, 24, 38, 39, 40, 54, 55, 56},
-	.oobfree = { {1, 5}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
+	.oobfree = { {2, 4}, {9, 13}, {25, 13}, {41, 13}, {57, 7} },
	.oobavail = 48,
};

/* Large Page FLASH with FMR[ECCM] = 1 */
static struct nand_ecclayout fsl_elbc_oob_lp_eccm1 = {
	.eccbytes = 12,
	.eccpos = {8, 9, 10, 24, 25, 26, 40, 41, 42, 56, 57, 58},
-	.oobfree = { {1, 7}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
+	.oobfree = { {2, 6}, {11, 13}, {27, 13}, {43, 13}, {59, 5} },
	.oobavail = 48,
};

Ron

--- Scott Wood <scottwood@freescale.com> wrote:

> Ron Madrid wrote:
> > I know I asked about this in the past, but I can't remember where it was left.  Did this get
> > resolved in some other repository that isn't the main linux-2.6 repository?  If it didn't I
> think
> > I might have a solution.  BTW I'm using 2.6.26-rc8
> 
> What was the issue?
> 
> -Scott
> 
