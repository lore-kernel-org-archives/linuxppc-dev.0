Return-Path: <Rupesh.Kumar@Lntemsys.com>
Received: from mail87.messagelabs.com (mail87.messagelabs.com [216.82.250.19])
	by bilbo.ozlabs.org (Postfix) with SMTP id 87FB9B7B8A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 15:14:10 +1000 (EST)
In-Reply-To: <20090831234713.GA6767@oksana.dev.rtsoft.ru>
To: avorontsov@ru.mvista.com
Subject: Re: ECC & Magic bitmask errors with JFFS2 file system on 6.23 kernel
	for powerpc
MIME-Version: 1.0
Message-ID: <OFF993BB3F.8ABEAA6D-ON65257624.0019895E-65257624.001C85AC@lntemsys.com>
From: Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
Date: Tue, 1 Sep 2009 10:53:23 +0530
Content-Type: text/plain; charset="US-ASCII"
Cc: louise <louise@Sun.COM>, Ravinder Kumar <Ravinder.Kumar@Sun.COM>,
	linuxppc-dev@lists.ozlabs.org, Louise.Yeung@Sun.COM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Louise,

Earlier we were using kernel 2.6.20(released with LTIB for REVA board of 
MPC8313E) and we were not seeing this problem in that kernel. Since, We 
had time constraint for our project, best thing we did was ported 2.6.20 
kernel on rev 2.1 silicon of MPC8313E. This is working fine.

However, We did try to dig this problem further and found that the problem 
occurs because of the ECC alignment mismatch in read & write on NAND 
flash.
You can look into following points :- 
        1) NAND initialization :-  Page size mentioned correctly in BR/OR 
register Settings.
        2) rfs is made with correct erase size.
        3) ECC placement used in u-boot & Kernel nand driver is same.
        4) Try using different ECC alignments and see if it makes some 
difference.


Regards 
Rupesh 





Anton Vorontsov <avorontsov@ru.mvista.com> 
09/01/2009 05:17 AM
Please respond to
avorontsov@ru.mvista.com


To
Louise.Yeung@Sun.COM
cc
linuxppc-dev@lists.ozlabs.org, louise <louise@Sun.COM>, Ravinder Kumar 
<Ravinder.Kumar@Sun.COM>, Rupesh Kumar <Rupesh.Kumar@Lntemsys.com>
Subject
Re: ECC & Magic bitmask errors with JFFS2 file system on 6.23 kernel for 
powerpc






On Mon, Aug 31, 2009 at 01:39:10PM -0700, Louise.Yeung@Sun.COM wrote:
> *Hi Rupesh,
> 
> We are using a Freescale processor similar to yours with NAND flash
> supporting 2KB page size .

What kernel version and NAND driver you use? I don't think that old
BSP kernels include fsl_elbc_nand driver, which is a much improved
version of the fsl_fcm driver.

So you might want to swith to a newer kernel or back-port the
fsl_elbc_nand driver[1] and a few fixes to your kernel.

[1] 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/mtd/nand/fsl_elbc_nand.c


-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
