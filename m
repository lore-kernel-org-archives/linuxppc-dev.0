Return-Path: <judith@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0740367C00
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 04:05:05 +1000 (EST)
Date: Tue, 17 Oct 2006 11:04:47 -0700
From: Judith Lebzelter <judith@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 1/2] ramdisk: make powerpc allmodconfig build
Message-ID: <20061017180447.GC822@shell0.pdx.osdl.net>
References: <20061017094742.a61c4873.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061017094742.a61c4873.randy.dunlap@oracle.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, paulus <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Randy,

There is another section in that function which depends on 
'CONFIG_BLK_DEV_INITRD' being defined.  Although it does not throw an
error, it does depend on some of the variables set in this section,
but not 'rd_size'.  I think for consistancy it might be better to do 
somthing like this(below)?  Or else add the same ifdef down there...

Judith


Index: 2/linux/arch/powerpc/platforms/iseries/setup.c
===================================================================
--- 2.orig/linux/arch/powerpc/platforms/iseries/setup.c	2006-10-17 10:49:31.423551104 -0700
+++ 2/linux/arch/powerpc/platforms/iseries/setup.c	2006-10-17 10:52:22.682515784 -0700
@@ -305,8 +305,10 @@
 		initrd_end = initrd_start + naca.xRamDiskSize * HW_PAGE_SIZE;
 		initrd_below_start_ok = 1;	// ramdisk in kernel space
 		ROOT_DEV = Root_RAM0;
+#if defined(CONFIG_BLK_DEV_RAM)
 		if (((rd_size * 1024) / HW_PAGE_SIZE) < naca.xRamDiskSize)
 			rd_size = (naca.xRamDiskSize * HW_PAGE_SIZE) / 1024;
+#endif /* CONFIG_BLK_DEV_RAM */
 	} else
 #endif /* CONFIG_BLK_DEV_INITRD */
 	{
