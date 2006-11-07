Return-Path: <johnrose@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E5E8A67DCD
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 10:53:26 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA7NrNdc022586
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2006 18:53:23 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kA7NrEsp336598
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2006 16:53:14 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kA7NrEH7003462
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2006 16:53:14 -0700
Subject: [PATCH] powerpc: force 4k update_flash block and list sizes
From: John Rose <johnrose@austin.ibm.com>
To: External List <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1162943615.13499.15.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Tue, 07 Nov 2006 17:53:35 -0600
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The enablement of 64k pages on POWER platforms exposed a quirk in the RTAS
mechanism for updating firmware.  RTAS assumes 4k for flash block and list
sizes, and use of any other sizes results in a failure.

This patch changes the rtas_flash module to force the use of 4k memory block
and list sizes when preparing and sending a firmware image to RTAS.  It also
changes rtas_flash to use a slab cache to ensure 4k alignment of flash block
data.  Such alignment is a documented requirement.

Signed-off-by: John Rose <johnrose@austin.ibm.com>

___

Intended for inclusion for 2.6.20, if appropriate.  Thanks!

John

---

 uf_4k-johnrose/arch/powerpc/kernel/rtas_flash.c |   52 +++++++++++++++++++-----
 1 files changed, 42 insertions(+), 10 deletions(-)

diff -puN arch/powerpc/kernel/rtas_flash.c~uf_4k_alt2 arch/powerpc/kernel/rtas_flash.c
--- uf_4k/arch/powerpc/kernel/rtas_flash.c~uf_4k_alt2	2006-11-06 16:59:27.000000000 -0600
+++ uf_4k-johnrose/arch/powerpc/kernel/rtas_flash.c	2006-11-06 17:02:31.000000000 -0600
@@ -72,6 +72,10 @@
 #define VALIDATE_BUF_SIZE 4096    
 #define RTAS_MSG_MAXLEN   64
 
+/* Quirk - RTAS requires 4k list length and block size */
+#define RTAS_BLKLIST_LENGTH 4096
+#define RTAS_BLK_SIZE 4096
+
 struct flash_block {
 	char *data;
 	unsigned long length;
@@ -83,7 +87,7 @@ struct flash_block {
  * into a version/length and translate the pointers
  * to absolute.
  */
-#define FLASH_BLOCKS_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct flash_block))
+#define FLASH_BLOCKS_PER_NODE ((RTAS_BLKLIST_LENGTH - 16) / sizeof(struct flash_block))
 struct flash_block_list {
 	unsigned long num_blocks;
 	struct flash_block_list *next;
@@ -96,6 +100,9 @@ struct flash_block_list_header { /* just
 
 static struct flash_block_list_header rtas_firmware_flash_list = {0, NULL};
 
+/* Use slab cache to guarantee 4k alignment */
+static kmem_cache_t *flash_block_cache = NULL;
+
 #define FLASH_BLOCK_LIST_VERSION (1UL)
 
 /* Local copy of the flash block list.
@@ -153,7 +160,7 @@ static int flash_list_valid(struct flash
 				return FLASH_IMG_NULL_DATA;
 			}
 			block_size = f->blocks[i].length;
-			if (block_size <= 0 || block_size > PAGE_SIZE) {
+			if (block_size <= 0 || block_size > RTAS_BLK_SIZE) {
 				return FLASH_IMG_BAD_LEN;
 			}
 			image_size += block_size;
@@ -177,9 +184,9 @@ static void free_flash_list(struct flash
 
 	while (f) {
 		for (i = 0; i < f->num_blocks; i++)
-			free_page((unsigned long)(f->blocks[i].data));
+			kmem_cache_free(flash_block_cache, f->blocks[i].data);
 		next = f->next;
-		free_page((unsigned long)f);
+		kmem_cache_free(flash_block_cache, f);
 		f = next;
 	}
 }
@@ -278,6 +285,12 @@ static ssize_t rtas_flash_read(struct fi
 	return msglen;
 }
 
+/* constructor for flash_block_cache */
+void rtas_block_ctor(void *ptr, kmem_cache_t *cache, unsigned long flags)
+{
+	memset(ptr, 0, RTAS_BLK_SIZE);
+}
+
 /* We could be much more efficient here.  But to keep this function
  * simple we allocate a page to the block list no matter how small the
  * count is.  If the system is low on memory it will be just as well
@@ -302,7 +315,7 @@ static ssize_t rtas_flash_write(struct f
 	 * proc file
 	 */
 	if (uf->flist == NULL) {
-		uf->flist = (struct flash_block_list *) get_zeroed_page(GFP_KERNEL);
+		uf->flist = kmem_cache_alloc(flash_block_cache, GFP_KERNEL);
 		if (!uf->flist)
 			return -ENOMEM;
 	}
@@ -313,21 +326,21 @@ static ssize_t rtas_flash_write(struct f
 	next_free = fl->num_blocks;
 	if (next_free == FLASH_BLOCKS_PER_NODE) {
 		/* Need to allocate another block_list */
-		fl->next = (struct flash_block_list *)get_zeroed_page(GFP_KERNEL);
+		fl->next = kmem_cache_alloc(flash_block_cache, GFP_KERNEL);
 		if (!fl->next)
 			return -ENOMEM;
 		fl = fl->next;
 		next_free = 0;
 	}
 
-	if (count > PAGE_SIZE)
-		count = PAGE_SIZE;
-	p = (char *)get_zeroed_page(GFP_KERNEL);
+	if (count > RTAS_BLK_SIZE)
+		count = RTAS_BLK_SIZE;
+	p = kmem_cache_alloc(flash_block_cache, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 	
 	if(copy_from_user(p, buffer, count)) {
-		free_page((unsigned long)p);
+		kmem_cache_free(flash_block_cache, p);
 		return -EFAULT;
 	}
 	fl->blocks[next_free].data = p;
@@ -791,6 +804,16 @@ int __init rtas_flash_init(void)
 		goto cleanup;
 
 	rtas_flash_term_hook = rtas_flash_firmware;
+
+	flash_block_cache = kmem_cache_create("rtas_flash_cache",
+				RTAS_BLK_SIZE, RTAS_BLK_SIZE, 0,
+				rtas_block_ctor, NULL);
+	if (!flash_block_cache) {
+		printk(KERN_ERR "%s: failed to create block cache\n",
+				__FUNCTION__);
+		rc = -ENOMEM;
+		goto cleanup;
+	}
 	return 0;
 
 cleanup:
@@ -804,7 +827,16 @@ cleanup:
 
 void __exit rtas_flash_cleanup(void)
 {
+	int rc;
+
 	rtas_flash_term_hook = NULL;
+
+	if (flash_block_cache) {
+		rc = kmem_cache_destroy(flash_block_cache);
+		if (rc)
+			printk(KERN_WARNING "%s: cache memory leak\n",
+					__FUNCTION__);
+	}
 	remove_flash_pde(firmware_flash_pde);
 	remove_flash_pde(firmware_update_pde);
 	remove_flash_pde(validate_pde);

_
