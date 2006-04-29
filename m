Return-Path: <arnd@arndb.de>
Message-Id: <20060429233919.497974000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:13 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 01/13] cell: always build spu base into the kernel
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

The spu_base module is rather deeply intermixed with the
core kernel, so it makes sense to have that built-in.
This will let us extend the base in the future without
having to export more core symbols just for it.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

Index: linus-2.6/arch/powerpc/platforms/cell/Makefile
===================================================================
--- linus-2.6.orig/arch/powerpc/platforms/cell/Makefile	2006-04-29 22:47:56.000000000 +0200
+++ linus-2.6/arch/powerpc/platforms/cell/Makefile	2006-04-29 22:53:41.000000000 +0200
@@ -2,15 +2,13 @@
 obj-y			+= pervasive.o
 
 obj-$(CONFIG_SMP)	+= smp.o
-obj-$(CONFIG_SPU_FS)	+= spu-base.o spufs/
-
-spu-base-y		+= spu_base.o spu_priv1.o
 
 # needed only when building loadable spufs.ko
 spufs-modular-$(CONFIG_SPU_FS) += spu_syscalls.o
 obj-y			+= $(spufs-modular-m)
 
 # always needed in kernel
-spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o
+spufs-builtin-$(CONFIG_SPU_FS) += spu_callbacks.o spu_base.o spu_priv1.o
 obj-y			+= $(spufs-builtin-y) $(spufs-builtin-m)
 
+obj-$(CONFIG_SPU_FS)	+= spufs/

--
