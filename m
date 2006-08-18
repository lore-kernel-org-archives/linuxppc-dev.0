Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F116F679FD
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 14:02:31 +1000 (EST)
Subject: Re: booting with BootX corrupts memory
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Niels Kristian Bech Jensen <nkbj@mail.tele.dk>
In-Reply-To: <1155096025.3813.6.camel@plutonium.opasia.dk>
References: <1155096025.3813.6.camel@plutonium.opasia.dk>
Content-Type: text/plain
Date: Fri, 18 Aug 2006 14:02:12 +1000
Message-Id: <1155873732.5803.16.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-09 at 06:00 +0200, Niels Kristian Bech Jensen wrote:
>  On Tue, Aug  1, Olaf Hering wrote:
> 
> > Booting an old Mac with BootX corrupts memory, the kernel seldom gets
> > into init. Even the built-in initramfs archive gets corrupted. So far I
> > havent figured out where the corruption starts. The only data point so
> > far is that a passed initrd gets overwritten with stuff that looks like
> > part of the device-tree after the call to free_area_init_node() from
> > paging_init(). Perhaps the virtual/real address mapping isnt handled
> > correctly.
> 
> > This is broken since at least 2.6.15, 2.6.14 dies very early, 2.6.13 was
> > still ok.
> 
> > Symptoms differ, depending on used .config and wether an initrd is passed.
> 
> I think I've been hit by this bug on my beige G3 running Ubuntu Edgy.
> 
> When booting with initrd the boot process stops before any kernel output (CONFIG_BOOTX_TEXT is not enabled).
> Booting without initrd works fine - at least until it cannot find the root filesystem driver. ;-)

Does this patch helps ?

Index: linux-work/arch/powerpc/platforms/powermac/bootx_init.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/bootx_init.c	2006-08-17 16:16:03.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/bootx_init.c	2006-08-18 14:01:36.000000000 +1000
@@ -411,8 +411,15 @@
 	DBG("End of boot params: %x\n", mem_end);
 	rsvmap[0] = mem_start;
 	rsvmap[1] = mem_end;
-	rsvmap[2] = 0;
-	rsvmap[3] = 0;
+	if (bootx_info->ramDisk) {
+		rsvmap[2] = ((unsigned long)bootx_info) + bootx_info->ramDisk;
+		rsvmap[3] = rsvmap[2] + bootx_info->ramDiskSize;
+		rsvmap[4] = 0;
+		rsvmap[5] = 0;
+	} else {
+		rsvmap[2] = 0;
+		rsvmap[3] = 0;
+	}
 
 	return (unsigned long)hdr;
 }
@@ -543,12 +550,12 @@
 	 */
 	if (bi->version < 5) {
 		space = bi->deviceTreeOffset + bi->deviceTreeSize;
-		if (bi->ramDisk)
+		if (bi->ramDisk >= space)
 			space = bi->ramDisk + bi->ramDiskSize;
 	} else
 		space = bi->totalParamsSize;
 
-	bootx_printf("Total space used by parameters & ramdisk: %x \n", space);
+	bootx_printf("Total space used by parameters & ramdisk: 0x%x \n", space);
 
 	/* New BootX will have flushed all TLBs and enters kernel with
 	 * MMU switched OFF, so this should not be useful anymore.
