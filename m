Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH] fix __init/__exit annotations for spufs
Date: Mon, 27 Mar 2006 21:27:40 +0200
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
In-Reply-To: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603272127.40590.arnd.bergmann@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spufs_init and spufs_exit should be marked correctly so
they can be removed when not needed.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linus-2.6/arch/powerpc/platforms/cell/spufs/inode.c
@@ -442,7 +442,7 @@ static struct file_system_type spufs_typ
 	.kill_sb = kill_litter_super,
 };
 
-static int spufs_init(void)
+static int __init spufs_init(void)
 {
 	int ret;
 	ret = -ENOMEM;
@@ -472,7 +472,7 @@ out:
 }
 module_init(spufs_init);
 
-static void spufs_exit(void)
+static void __exit spufs_exit(void)
 {
 	spu_sched_exit();
 	unregister_spu_syscalls(&spufs_calls);
