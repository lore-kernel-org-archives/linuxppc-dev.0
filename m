Return-Path: <mita@fixstars.com>
Date: Tue, 10 Apr 2007 20:15:08 +0900
From: Akinobu Mita <mita@fixstars.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 3/3] cell: prevent alignment interrupt on local store
Message-ID: <20070410111508.GA2969@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

An Alignment interrupt occurs when the instruction is lmw, stmw, lswi, lswx,
stswi, or stswx, and the operand is in local store.

GCC generated such instructions to handle memcpy() instead of kernel
defined memcpy() without -mno-string option.

Signed-off-by: Akinobu Mita <mita@fixstars.com>

Index: 2.6-git-ps3/arch/powerpc/platforms/cell/spufs/Makefile
===================================================================
--- 2.6-git-ps3.orig/arch/powerpc/platforms/cell/spufs/Makefile
+++ 2.6-git-ps3/arch/powerpc/platforms/cell/spufs/Makefile
@@ -4,6 +4,11 @@ obj-$(CONFIG_SPU_FS) += spufs.o
 spufs-y += inode.o file.o context.o syscalls.o coredump.o
 spufs-y += sched.o backing_ops.o hw_ops.o run.o gang.o
 
+# An Alignment interrupt occurs when the instruction is lmw, stmw, lswi, lswx,
+# stswi, or stswx, and the operand is in local store.
+CFLAGS_run.o := -mno-string
+CFLAGS_file.o := -mno-string
+
 # Rules to build switch.o with the help of SPU tool chain
 SPU_CROSS	:= spu-
 SPU_CC		:= $(SPU_CROSS)gcc
