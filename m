Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id DABFEDDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 23:43:23 +1100 (EST)
Message-ID: <47B19543.70808@coritel.it>
Date: Tue, 12 Feb 2008 13:46:59 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: jay_chen <jay_chen@alphanetworks.com>
Subject: Re: populate_rootfs fail
References: <OF66FDCEB1.DBBF4F1E-ON482573ED.0030E325@alphanetworks.com>
In-Reply-To: <OF66FDCEB1.DBBF4F1E-ON482573ED.0030E325@alphanetworks.com>
Content-Type: text/plain; charset=us-ascii
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

jay_chen ha scritto:
> Hello all:
> 
> I am using mpc8548, kernel 2.6.14.5, and uboot as boot loader.
> When I upgrade ram from 512MB to 2G, my kernel can't boot anymore.
> (I pass mem=2048M to kernel in uboot now)
> 
> It always dies in exec sys_write( ) in populate_rootfs( ).
> I did more tests about this and I found that sys_write( ) could write only
> about 4MB in 2G ram case.
> (My initrd is about 19MB, initrd_start  : 0xCE7C7000, initrd_end  :
> 0xCFAAF289, initrd_end - initrd_start  : 0x012E8289 ==> about 19MB)
> Could anybody give me some hints?
> Is this issue related to the location of  "/initrd.image"? Could I control
> it?
> Is there any size limit in ppc arch about ramdisk/initrd?
> 
> Thanks for help.
> 
>                   Jay...
> 
> void __init populate_rootfs(void)
> {
> 	char *err;
>                ...
> #ifdef CONFIG_BLK_DEV_INITRD
> 	if (initrd_start) {
>                                  ...
> 		printk("it isn't (%s); looks like an initrd\n", err);
> 		fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 700);
> 		if (fd >= 0) {
> 			sys_write(fd, (char *)initrd_start,
> 					initrd_end - initrd_start);
> 			sys_close(fd);
> 			free_initrd();
> 		}
> 	}
> #endif
> }
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
I think can be a problem with the u-boot initrd_high option. Have you
been enabled the highmem support to use 2G of ram, right? You can try to
set this option to 0x30000000.

Marco
