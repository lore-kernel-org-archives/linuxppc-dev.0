Return-Path: <jay_chen@alphanetworks.com>
From: "jay_chen" <jay_chen@alphanetworks.com>
To: <linuxppc-embedded-bounces+jay_chen=alphanetworks.com@ozlabs.org>
Subject: RE: [Spam Mail] Re: populate_rootfs fail (This message should be
	blocked: bkdh372119)
Date: Wed, 13 Feb 2008 09:52:23 +0800
MIME-Version: 1.0
In-Reply-To: <47B19543.70808@coritel.it>
Message-ID: <OFC284291F.7B41E3CD-ON482573EE.000A4F2E@alphanetworks.com>
Content-Type: text/plain;
	charset="us-ascii"
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

 -----Original Message-----
From: linuxppc-embedded-bounces+jay_chen=alphanetworks.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+jay_chen=alphanetworks.com@ozlabs.org] 
Sent: Tuesday, February 12, 2008 8:47 PM
To: jay_chen
Cc: linuxppc-embedded@ozlabs.org
Subject: [Spam Mail] Re: populate_rootfs fail (This message should be
blocked: bkdh372119)

jay_chen ha scritto:
> Hello all:
> 
> I am using mpc8548, kernel 2.6.14.5, and uboot as boot loader.
> When I upgrade ram from 512MB to 2G, my kernel can't boot anymore.
> (I pass mem=2048M to kernel in uboot now)
> 
> It always dies in exec sys_write( ) in populate_rootfs( ).
> I did more tests about this and I found that sys_write( ) could write 
> only about 4MB in 2G ram case.
> (My initrd is about 19MB, initrd_start  : 0xCE7C7000, initrd_end  :
> 0xCFAAF289, initrd_end - initrd_start  : 0x012E8289 ==> about 19MB) 
> Could anybody give me some hints?
> Is this issue related to the location of  "/initrd.image"? Could I 
> control it?
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
I think can be a problem with the u-boot initrd_high option. Have you been
enabled the highmem support to use 2G of ram, right? You can try to set this
option to 0x30000000.

Marco
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded

0x30000000 doesn't work in my system, but 0x08000000 does.
I am not quiet understand the function of initrd_high and how to set it.
Since it may helps, I will try to figure out the whole story.
Thanks for your help.

                    Jay...
