Return-Path: <anton@ozlabs.org>
Date: Sat, 12 Jun 2010 23:46:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Milton Miller <miltonm@us.ibm.com>
Subject: Re: [PATCH] powerpc: rtas_flash cannot be a module
Message-ID: <20100612134628.GP28295@kryten>
References: <20100609060110.GM28295@kryten>
 <20100610-reply@mdm.bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100610-reply@mdm.bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 
Hi,

> So we should use that rtas_data_buf with its lock ...
> 
> Oh look, the driver already uses that buffer for the call to verify_flash
> 
> untested patch to follow

Thanks, it built and tested OK with the following patch. Will send a
complete patch with these changes in a minute.

Anton

--- build/arch/powerpc/kernel/rtas_flash.c~	2010-06-12 09:06:43.000000000 -0400
+++ build/arch/powerpc/kernel/rtas_flash.c	2010-06-12 09:08:30.000000000 -0400
@@ -613,9 +613,9 @@
 	 * the kernel data segment.
 	 */
 	spin_lock(&rtas_data_buf_lock);
-	flist = (struct rtas_flash_list *)&rtas_data_buf[0];
-	flist.num_blocks = 0;
-	flist.next = rtas_firmware_flash_list;
+	flist = (struct flash_block_list *)&rtas_data_buf[0];
+	flist->num_blocks = 0;
+	flist->next = rtas_firmware_flash_list;
 	rtas_block_list = virt_to_abs(flist);
 	if (rtas_block_list >= 4UL*1024*1024*1024) {
 		printk(KERN_ALERT "FLASH: kernel bug...flash list header addr above 4GB\n");
