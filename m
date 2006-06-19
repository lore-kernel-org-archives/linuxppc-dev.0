Return-Path: <arnd@arndb.de>
Message-Id: <20060619183404.668482000@klappe.arndb.de>
References: <20060619183315.653672000@klappe.arndb.de>
Date: Mon, 19 Jun 2006 20:33:20 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 05/20] cell: always build spu base into the kernel
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

The spu_base module is rather deeply intermixed with the
core kernel, so it makes sense to have that built-in.
This will let us extend the base in the future without
having to export more core symbols just for it.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: powerpc.git/arch/powerpc/platforms/cell/Makefile
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/Makefile
+++ powerpc.git/arch/powerpc/platforms/cell/Makefile
@@ -3,15 +3,11 @@ obj-y			+= cbe_regs.o pervasive.o
 obj-$(CONFIG_CBE_RAS)	+= ras.o
 
 obj-$(CONFIG_SMP)	+= smp.o
-obj-$(CONFIG_SPU_FS)	+= spu-base.o spufs/
-
-spu-base-y		+= spu_base.o spu_priv1.o
 
 # needed only when building loadable spufs.ko
 spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
 obj-y			+= $(spufs-modular-m)
 
 # always needed in kernel
-spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o
+spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o spufs/
 obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
-
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/Makefile
@@ -1,5 +1,7 @@
+obj-y += switch.o
+
 obj-$(CONFIG_SPU_FS) += spufs.o
-spufs-y += inode.o file.o context.o switch.o syscalls.o
+spufs-y += inode.o file.o context.o syscalls.o
 spufs-y += sched.o backing_ops.o hw_ops.o run.o
 
 # Rules to build switch.o with the help of SPU tool chain
Index: powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spufs/switch.c
+++ powerpc.git/arch/powerpc/platforms/cell/spufs/switch.c
@@ -2074,6 +2074,7 @@ int spu_save(struct spu_state *prev, str
 	}
 	return rc;
 }
+EXPORT_SYMBOL_GPL(spu_save);
 
 /**
  * spu_restore - SPU context restore, with harvest and locking.
@@ -2103,6 +2104,7 @@ int spu_restore(struct spu_state *new, s
 	}
 	return rc;
 }
+EXPORT_SYMBOL_GPL(spu_restore);
 
 /**
  * spu_harvest - SPU harvest (reset) operation
@@ -2193,6 +2195,7 @@ void spu_init_csa(struct spu_state *csa)
 	init_priv1(csa);
 	init_priv2(csa);
 }
+EXPORT_SYMBOL_GPL(spu_init_csa);
 
 void spu_fini_csa(struct spu_state *csa)
 {
@@ -2203,3 +2206,4 @@ void spu_fini_csa(struct spu_state *csa)
 
 	vfree(csa->lscsa);
 }
+EXPORT_SYMBOL_GPL(spu_fini_csa);

--
