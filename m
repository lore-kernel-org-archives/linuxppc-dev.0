Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53D9067C73
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 11:45:18 +1000 (EST)
Subject: [PATCH] powepc: Fix BootX booting with an initrd
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 11:45:12 +1000
Message-Id: <1156297512.8433.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The bootx_init.c trampoline didn't properly add the ramdisk to the
"reserve map" (list of reserved areas of memory), thus causing all sorts
of failures when using BootX with an initrd. Also fixes a possible
problem if the ramdisk is located before the device-tree passed by
BootX.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

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
