Return-Path: <arnd@arndb.de>
Message-Id: <20060623185825.158050000@klappe.arndb.de>
References: <20060623185746.037897000@klappe.arndb.de>
Date: Fri, 23 Jun 2006 20:57:51 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [PATCH 5/5] spufs: fix spufs_mfc_flush prototype
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The prototype for the flush file operation now has another
argument in 2.6.18.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1150,7 +1150,7 @@ static unsigned int spufs_mfc_poll(struc
 	return mask;
 }
 
-static int spufs_mfc_flush(struct file *file)
+static int spufs_mfc_flush(struct file *file, fl_owner_t id)
 {
 	struct spu_context *ctx = file->private_data;
 	int ret;
@@ -1176,7 +1176,7 @@ out:
 static int spufs_mfc_fsync(struct file *file, struct dentry *dentry,
 			   int datasync)
 {
-	return spufs_mfc_flush(file);
+	return spufs_mfc_flush(file, 0);
 }
 
 static int spufs_mfc_fasync(int fd, struct file *file, int on)

--
