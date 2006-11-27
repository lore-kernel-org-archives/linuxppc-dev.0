Return-Path: <arnd@arndb.de>
Message-Id: <20061127182429.315282000@arndb.de>
References: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:18:52 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 1/9] spufs: return an error in spu_create is isolated create
	isnt supported
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jeremy Kerr <jk@ozlabs.org>
This changes the spu_create system call to return an error (-ENODEV) if
and isolated spu context is requested on hardware that doesn't support
isolated mode.

Tested on systemsim with and without isolation support

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -323,6 +323,10 @@ static int spufs_create_context(struct i
 	    == SPU_CREATE_ISOLATE)
 		goto out_unlock;
 
+	ret = -ENODEV;
+	if ((flags & SPU_CREATE_ISOLATE) && !isolated_loader)
+		goto out_unlock;
+
 	ret = spufs_mkdir(inode, dentry, flags, mode & S_IRWXUGO);
 	if (ret)
 		goto out_unlock;

--
