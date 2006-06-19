Return-Path: <arnd@arndb.de>
Message-Id: <20060619183406.773427000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:34 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 19/20] spufs: fail spu_create with invalid flags
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At this time, all flags are invalid. Since we are
planning to actually add valid flags in the future,
we better check if any were passed by the user.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/inode.c
@@ -304,6 +304,10 @@ long spufs_create_thread(struct nameidat
 	    nd->dentry != nd->dentry->d_sb->s_root)
 		goto out;
 
+	/* all flags are reserved */
+	if (flags)
+		goto out;
+
 	dentry = lookup_create(nd, 1);
 	ret = PTR_ERR(dentry);
 	if (IS_ERR(dentry))

--
