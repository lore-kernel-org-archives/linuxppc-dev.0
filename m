Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 042921A0006
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jul 2014 03:48:51 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 25 Jul 2014 11:48:47 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id EE5BF3E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 11:48:44 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6PHlLEi066034
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 19:47:29 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6PHmBJ1000583
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jul 2014 11:48:12 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fixing endianness of flash_block_list in rtas_flash
Date: Fri, 25 Jul 2014 12:47:42 -0500
Message-Id: <1406310462-23005-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function rtas_flash_firmware passes the address of a data structure,
flash_block_list, when making the update-flash-64-and-reboot rtas call.
While the endianness of the address is handled correctly, the endianness
of the data is not.  This patch ensures that the data in flash_block_list
is big endian when passed to rtas on little endian hosts.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtas_flash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 658e89d..db2b482 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -611,17 +611,19 @@ static void rtas_flash_firmware(int reboot_type)
 	for (f = flist; f; f = next) {
 		/* Translate data addrs to absolute */
 		for (i = 0; i < f->num_blocks; i++) {
-			f->blocks[i].data = (char *)__pa(f->blocks[i].data);
+			f->blocks[i].data = (char *)cpu_to_be64(__pa(f->blocks[i].data));
 			image_size += f->blocks[i].length;
+			f->blocks[i].length = cpu_to_be64(f->blocks[i].length);
 		}
 		next = f->next;
 		/* Don't translate NULL pointer for last entry */
 		if (f->next)
-			f->next = (struct flash_block_list *)__pa(f->next);
+			f->next = (struct flash_block_list *)cpu_to_be64(__pa(f->next));
 		else
 			f->next = NULL;
 		/* make num_blocks into the version/length field */
 		f->num_blocks = (FLASH_BLOCK_LIST_VERSION << 56) | ((f->num_blocks+1)*16);
+		f->num_blocks = cpu_to_be64(f->num_blocks);
 	}
 
 	printk(KERN_ALERT "FLASH: flash image is %ld bytes\n", image_size);
-- 
1.9.3
