Return-Path: <arnd@arndb.de>
Message-Id: <20061024160406.923275000@arndb.de>
References: <20061024160140.452484000@arndb.de>
Date: Tue, 24 Oct 2006 18:01:42 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/3] spufs: fix another off-by-one bug in mbox_read
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

Next try, the previous one did not do what I expected.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -385,7 +385,7 @@ static ssize_t spufs_mbox_read(struct fi
 	udata = (void __user *)buf;
 
 	spu_acquire(ctx);
-	for (count = 0; count <= len; count += 4, udata++) {
+	for (count = 0; (count + 4) <= len; count += 4, udata++) {
 		int ret;
 		ret = ctx->ops->mbox_read(ctx, &mbox_data);
 		if (ret == 0)

--
