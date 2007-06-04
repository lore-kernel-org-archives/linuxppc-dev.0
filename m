Return-Path: <jk@ozlabs.org>
To: <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 04 Jun 2007 21:26:51 +0800
Subject: [PATCH 4/6] spufs: free mm if spufs_fill_dir() failed
Message-Id: <1180963611.892923.503364236578.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>

In case spufs_fill_dir() fails only put_spu_context()
gets called for cleanup and the acquired mm_struct never gets freed.

Signed-off-by: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---

 arch/powerpc/platforms/cell/spufs/inode.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
@@ -274,6 +274,7 @@ spufs_mkdir(struct inode *dir, struct de
 	goto out;
 
 out_free_ctx:
+	spu_forget(ctx);
 	put_spu_context(ctx);
 out_iput:
 	iput(inode);
