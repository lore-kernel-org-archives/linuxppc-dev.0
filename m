Return-Path: <roel.kluin@gmail.com>
Message-ID: <49AD7A06.2090401@gmail.com>
Date: Tue, 03 Mar 2009 19:42:14 +0100
From: Roel Kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: jk@ozlabs.org
Subject: [PATCH] powerpc/spufs: negative size in spufs_{regs/fpcr}_write
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When stored in size_t size, the test 'size <= 0' does no longer work.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 0da7f2b..05dba47 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -569,7 +569,7 @@ spufs_regs_write(struct file *file, const char __user *buffer,
 	int ret;
 
 	size = min_t(ssize_t, sizeof lscsa->gprs - *pos, size);
-	if (size <= 0)
+	if ((ssize_t)size <= 0)
 		return -EFBIG;
 	*pos += size;
 
@@ -624,7 +624,7 @@ spufs_fpcr_write(struct file *file, const char __user * buffer,
 	int ret;
 
 	size = min_t(ssize_t, sizeof(lscsa->fpcr) - *pos, size);
-	if (size <= 0)
+	if ((ssize_t)size <= 0)
 		return -EFBIG;
 
 	ret = spu_acquire_saved(ctx);
