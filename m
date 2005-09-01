Return-Path: <shawnxjin@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id 16972680F7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Sep 2005 03:38:57 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 36so418136wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 01 Sep 2005 10:38:56 -0700 (PDT)
Message-ID: <c3d0340b050901103871860dac@mail.gmail.com>
Date: Thu, 1 Sep 2005 10:38:56 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: "Adrian B. Weissman" <aweissma_ppc@yahoo.com>
In-Reply-To: <20050901054650.11322.qmail@web35208.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20050901054650.11322.qmail@web35208.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A question regarding ramdisks
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(1,0)
>  <0>Rebooting in 180 seconds..

If you're sure that you enable INITRD and EXT2 support in the kernel
and the problem still exist, check if initrd_start and initrd_end are
set correctly in platform_init().

In 2.6.x, parse_bootinfo() doesn't recognize u-boot's bd_t. One quick
and dirty solution is to set initrd_start and initrd_end to r4 and r5
respectively in platform_init().

=09/* set initrd parameters */
#ifdef CONFIG_BLK_DEV_INITRD
=09if (r4) {
=09  =09initrd_start =3D r4 + KERNELBASE;
=09=09initrd_end =3D r5 + KERNELBASE;
=09}
#endif /* CONFIG_BLK_DEV_INITRD */

Regards,
-Shawn.
