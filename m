Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 04/25] spufs: make isolated loader properly aligned
Message-Id: <1189751574.100332.185899581702.4.gpush@pokey>
In-Reply-To: <1189751574.98527.127994196313.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 16:32:54 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastian Siewior <cbe-oss-dev@ml.breakpoint.cc>

According to the comment in spufs_init_isolated_loader(), the isolated
loader should be aligned on a 16 byte boundary.
ARCH_{KMALLOC,SLAB}_MINALIGN is not defined so only 8 byte alignment is
guaranteed.

This patch enforces alignment via __get_free_pages.

Signed-off-by: Sebastian Siewior <sebastian@breakpoint.cc>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/inode.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index b3d0dd1..e210a4b 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -43,6 +43,7 @@
 
 static struct kmem_cache *spufs_inode_cache;
 char *isolated_loader;
+static int isolated_loader_size;
 
 static struct inode *
 spufs_alloc_inode(struct super_block *sb)
@@ -667,7 +668,8 @@ spufs_parse_options(char *options, struct inode *root)
 
 static void spufs_exit_isolated_loader(void)
 {
-	kfree(isolated_loader);
+	free_pages((unsigned long) isolated_loader,
+			get_order(isolated_loader_size));
 }
 
 static void
@@ -685,11 +687,12 @@ spufs_init_isolated_loader(void)
 	if (!loader)
 		return;
 
-	/* kmalloc should align on a 16 byte boundary..* */
-	isolated_loader = kmalloc(size, GFP_KERNEL);
+	/* the loader must be align on a 16 byte boundary */
+	isolated_loader = (char *)__get_free_pages(GFP_KERNEL, get_order(size));
 	if (!isolated_loader)
 		return;
 
+	isolated_loader_size = size;
 	memcpy(isolated_loader, loader, size);
 	printk(KERN_INFO "spufs: SPU isolation mode enabled\n");
 }
