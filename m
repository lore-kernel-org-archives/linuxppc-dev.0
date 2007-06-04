Return-Path: <jk@ozlabs.org>
To: <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 04 Jun 2007 21:26:51 +0800
Subject: [PATCH 2/6] spufs: hook up spufs_release_mem
Message-Id: <1180963611.793578.736691614466.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>

Currently spufs_mem_release and the mem file doesn't have any release
method hooked up leading to leaks everytime is used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 45614c7..89a5011 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -217,6 +217,7 @@ unsigned long spufs_get_unmapped_area(struct file *file, unsigned long addr,
 
 static const struct file_operations spufs_mem_fops = {
 	.open	 		= spufs_mem_open,
+	.release 		= spufs_mem_release,
 	.read   		= spufs_mem_read,
 	.write   		= spufs_mem_write,
 	.llseek  		= generic_file_llseek,
-- 
1.5.0.rc4.g85b1
