Return-Path: <Rupesh.Kumar@Lntemsys.com>
Received: from mail130.messagelabs.com (mail130.messagelabs.com
	[216.82.250.163])
	by bilbo.ozlabs.org (Postfix) with SMTP id 3287EB7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 00:54:12 +1000 (EST)
To: linuxppc-dev@lists.ozlabs.org
Subject: ECC & Magic bitmask errors with JFFS2 file system on 6.23 kernel for
	powerpc
MIME-Version: 1.0
Message-ID: <OF4DA6695F.B8912DE2-ON652575F5.004F0DE0-652575F5.00519736@lntemsys.com>
From: Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
Date: Thu, 16 Jul 2009 20:33:11 +0530
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

We are using Linux kernel 2.6.23 from freescale LTIB 
(MPC8313E_RDB_K26_20081226-LTIB.iso) on our custom board. 
JFFS2 is used as RFS and  nand write.jffs2 utility in the u-boot is used 
to burn the image on to the nand flash. 

When we boot for the first time everything seems to be OK. On subsequent 
reboots we are seeing following error messages reported by kernel on 
bootup. 
In addition we also see Magic bitmask errors being reported. 

///////////////////////////
mtd->read(0x400 bytes from 0x1b00000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x01b001d0: 
0xfffe instead
mtd->read(0x400 bytes from 0x2500000) returned ECC error
mtd->read(0x400 bytes from 0x27c0000) returned ECC error
mtd->read(0x400 bytes from 0x2c20000) returned ECC error
mtd->read(0x400 bytes from 0x2cc0000) returned ECC error
mtd->read(0x400 bytes from 0x2d00000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d00074: 
0xfffe instead
Empty flash at 0x02d00078 ends at 0x02d003e4
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d003e4: 
0xffef instead
Empty flash at 0x02d003e8 ends at 0x02d00780
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x02d00780: 
0xfffb instead
mtd->read(0x400 bytes from 0x3320000) returned ECC error
jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03320190: 
0xffff instead
Empty flash at 0x03320194 ends at 0x0332047c
////////////////////////////

We verified erase size passed as an argument for creating jffs2 file 
system (initial googling on the issue).
After contacting freescale we came to know that, it is a known issue and 
they dont have planned to work on this in near future. :(
Please give your valuable suggestions so that we can fix this problem and 
make our board running properly.

Thanks
Rupesh
