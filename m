Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 10/18] powerpc/kernel: Remove uses of abs_to_virt() and
 virt_to_abs()
Date: Thu, 26 Jul 2012 17:19:56 +1000
Message-Id: <1343287204-7700-10-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These days they are just __va() and __pa() respectively.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/dma.c        |    3 +--
 arch/powerpc/kernel/rtas_flash.c |    7 +++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index b1ec983..554d1c0 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -12,7 +12,6 @@
 #include <linux/memblock.h>
 #include <linux/export.h>
 #include <asm/bug.h>
-#include <asm/abs_addr.h>
 #include <asm/machdep.h>
 
 /*
@@ -48,7 +47,7 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	ret = page_address(page);
 	memset(ret, 0, size);
-	*dma_handle = virt_to_abs(ret) + get_dma_offset(dev);
+	*dma_handle = __pa(ret) + get_dma_offset(dev);
 
 	return ret;
 #endif
diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 4174b4b..ee62632 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -21,7 +21,6 @@
 #include <asm/delay.h>
 #include <asm/uaccess.h>
 #include <asm/rtas.h>
-#include <asm/abs_addr.h>
 
 #define MODULE_VERS "1.0"
 #define MODULE_NAME "rtas_flash"
@@ -582,7 +581,7 @@ static void rtas_flash_firmware(int reboot_type)
 	flist = (struct flash_block_list *)&rtas_data_buf[0];
 	flist->num_blocks = 0;
 	flist->next = rtas_firmware_flash_list;
-	rtas_block_list = virt_to_abs(flist);
+	rtas_block_list = __pa(flist);
 	if (rtas_block_list >= 4UL*1024*1024*1024) {
 		printk(KERN_ALERT "FLASH: kernel bug...flash list header addr above 4GB\n");
 		spin_unlock(&rtas_data_buf_lock);
@@ -596,13 +595,13 @@ static void rtas_flash_firmware(int reboot_type)
 	for (f = flist; f; f = next) {
 		/* Translate data addrs to absolute */
 		for (i = 0; i < f->num_blocks; i++) {
-			f->blocks[i].data = (char *)virt_to_abs(f->blocks[i].data);
+			f->blocks[i].data = (char *)__pa(f->blocks[i].data);
 			image_size += f->blocks[i].length;
 		}
 		next = f->next;
 		/* Don't translate NULL pointer for last entry */
 		if (f->next)
-			f->next = (struct flash_block_list *)virt_to_abs(f->next);
+			f->next = (struct flash_block_list *)__pa(f->next);
 		else
 			f->next = NULL;
 		/* make num_blocks into the version/length field */
-- 
1.7.9.5
