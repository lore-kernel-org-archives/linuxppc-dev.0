Return-Path: <jk@ozlabs.org>
To: <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 04 Jun 2007 21:26:51 +0800
Subject: [PATCH 1/6] spufs: refuse loading the module when not running on cell
Message-Id: <1180963611.745771.662168275092.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd.bergmann@de.ibm.com>

As noticed by David Woodhouse, it's currently possible to mount
spufs on any machine, which means that it actually will get
mounted by fedora.
This refuses to load the module on platforms that have no
support for SPUs.

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---

 arch/powerpc/platforms/cell/spufs/inode.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
@@ -600,6 +600,10 @@ spufs_create_root(struct super_block *sb
 	struct inode *inode;
 	int ret;
 
+	ret = -ENODEV;
+	if (!spu_management_ops)
+		goto out;
+
 	ret = -ENOMEM;
 	inode = spufs_new_inode(sb, S_IFDIR | 0775);
 	if (!inode)
