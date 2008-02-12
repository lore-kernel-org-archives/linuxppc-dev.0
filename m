Return-Path: <jay_chen@alphanetworks.com>
Received: from Sweeper2.alphanetworks.com (sweeper2.alphanetworks.com
	[210.202.42.140]) by ozlabs.org (Postfix) with ESMTP id D308CDDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Feb 2008 20:36:33 +1100 (EST)
From: "jay_chen" <jay_chen@alphanetworks.com>
To: <linuxppc-embedded-bounces+jay_chen=alphanetworks.com@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
Subject: RE: [Spam Mail] populate_rootfs fail (This message should be blocked:
	ctfkl59804)
Date: Tue, 12 Feb 2008 17:36:19 +0800
MIME-Version: 1.0
In-Reply-To: <OF66FDCEB1.DBBF4F1E-ON482573ED.0030E325@alphanetworks.com>
Message-ID: <OF6EB1538F.C102F4CD-ON482573ED.0034C80C@alphanetworks.com>
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

One more thing:
I had changed default ramdisk size to about 80MB in kernel config.
(CONFIG_BLK_DEV_RAM_SIZE) 

I am so curious about the size limit and location in ram of "/initrd.image".
Which c file/document should I read?

                                         Jay...

-----Original Message-----
From: linuxppc-embedded-bounces+jay_chen=alphanetworks.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+jay_chen=alphanetworks.com@ozlabs.org] 
Sent: Tuesday, February 12, 2008 4:54 PM
To: linuxppc-embedded@ozlabs.org
Subject: [Spam Mail] populate_rootfs fail (This message should be blocked:
ctfkl59804)

Hello all:

I am using mpc8548, kernel 2.6.14.5, and uboot as boot loader.
When I upgrade ram from 512MB to 2G, my kernel can't boot anymore.
(I pass mem=2048M to kernel in uboot now)

It always dies in exec sys_write( ) in populate_rootfs( ).
I did more tests about this and I found that sys_write( ) could write only
about 4MB in 2G ram case.
(My initrd is about 19MB, initrd_start  : 0xCE7C7000, initrd_end  :
0xCFAAF289, initrd_end - initrd_start  : 0x012E8289 ==> about 19MB) Could
anybody give me some hints?
Is this issue related to the location of  "/initrd.image"? Could I control
it?
Is there any size limit in ppc arch about ramdisk/initrd?

Thanks for help.

                  Jay...

void __init populate_rootfs(void)
{
	char *err;
               ...
#ifdef CONFIG_BLK_DEV_INITRD
	if (initrd_start) {
                                 ...
		printk("it isn't (%s); looks like an initrd\n", err);
		fd = sys_open("/initrd.image", O_WRONLY|O_CREAT, 700);
		if (fd >= 0) {
			sys_write(fd, (char *)initrd_start,
					initrd_end - initrd_start);
			sys_close(fd);
			free_initrd();
		}
	}
#endif
}

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
