Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9843367B15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 18:50:42 +1000 (EST)
Date: Thu, 21 Apr 2005 01:50:37 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Marco Schramel <Schramel.Linux@go.bartec.de>
Message-ID: <20050421085037.GB8189@gate.ebshome.net>
References: <200504211117.25584.Schramel.Linux@go.bartec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200504211117.25584.Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: mtd mount problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Apr 21, 2005 at 11:17:25AM +0200, Marco Schramel wrote:
> Hi all,
> 
> in our system (MPC8270, 2.4.25) i can't mount the mtd devices (two AM29LV256MH)
> 
> I created a map based on tqm8260.c. I can use the "eraseall" command and i can write the mtdx devices.
> But if i try to mount the mtd devices (jffs or jffs2) then it fails.
> Output:
> The eraseall command
> /dev # eraseall /dev/mtd1
> MTD_open
> MTD_ioctl
> MTD_write
> Erased 8192 Kibyte @ 0 -- 100% complete.
> MTD_close
> 
> try to write
> /dev # date > /dev/mtd1
> MTD_open
> MTD_ioctl
> MTD_write
> MTD_close
> 
> ok, now try onesmore
> /dev # date > /dev/mtd1
> MTD_open
> MTD_ioctl
> MTD_write
> MTD do_write_buffer(): software timeout
> MTD_close
> /dev #
> 
> It all seems to be fine, but...
> 
> dev # mount -t jffs2 /dev/mtdblock1 /mnt/Flash1
> mount: Mounting /dev/mtdblock1 on /mnt/Flash1 failed: No such device
> 
> I checked out the Majors of my ramdisk, they are ok.

ramdisk? why?

Check that you have CONFIG_MTD_BLOCK enabled in your .config. 

Also, check that you have /dev/mtdblock1 node in /dev directory on the 
target.

-- 
Eugene
