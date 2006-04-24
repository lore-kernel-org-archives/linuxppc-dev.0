Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4557A679FD
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 08:43:43 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 645611D8F7
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 00:43:39 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Wire up *at syscalls
Date: Tue, 25 Apr 2006 00:43:38 +0200
Message-ID: <jeu08ippb9.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch has been tested on ppc64 (using glibc's testsuite, both 32bit
and 64bit), and compile-tested for ppc32 (I have currently no ppc32 system
available, but I expect no problems).

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 arch/powerpc/kernel/systbl.S                |   13 +++++++++++++
 arch/powerpc/platforms/cell/spu_callbacks.c |   13 +++++++++++++
 fs/stat.c                                   |    2 --
 include/asm-powerpc/unistd.h                |   19 ++++++++++++++++++-
 4 files changed, 44 insertions(+), 3 deletions(-)

Index: linux-2.6.17-rc2-git5/arch/powerpc/kernel/systbl.S
===================================================================
--- linux-2.6.17-rc2-git5.orig/arch/powerpc/kernel/systbl.S	2006-04-24 16:24:47.000000000 +0200
+++ linux-2.6.17-rc2-git5/arch/powerpc/kernel/systbl.S	2006-04-24 19:53:50.000000000 +0200
@@ -324,6 +324,19 @@ COMPAT_SYS(ppoll)
 SYSCALL(unshare)
 SYSCALL(splice)
 SYSCALL(tee)
+COMPAT_SYS(openat)
+SYSCALL(mkdirat)
+SYSCALL(mknodat)
+SYSCALL(fchownat)
+COMPAT_SYS(futimesat)
+SYSX(sys_newfstatat, sys_fstatat64, sys_fstatat64)
+SYSCALL(unlinkat)
+SYSCALL(renameat)
+SYSCALL(linkat)
+SYSCALL(symlinkat)
+SYSCALL(readlinkat)
+SYSCALL(fchmodat)
+SYSCALL(faccessat)
 
 /*
  * please add new calls to arch/powerpc/platforms/cell/spu_callbacks.c
Index: linux-2.6.17-rc2-git5/include/asm-powerpc/unistd.h
===================================================================
--- linux-2.6.17-rc2-git5.orig/include/asm-powerpc/unistd.h	2006-04-24 16:24:15.000000000 +0200
+++ linux-2.6.17-rc2-git5/include/asm-powerpc/unistd.h	2006-04-24 18:06:53.000000000 +0200
@@ -303,8 +303,25 @@
 #define __NR_unshare		282
 #define __NR_splice		283
 #define __NR_tee		284
+#define __NR_openat		285
+#define __NR_mkdirat		286
+#define __NR_mknodat		287
+#define __NR_fchownat		288
+#define __NR_futimesat		289
+#ifdef __powerpc64__
+#define __NR_newfstatat		290
+#else
+#define __NR_fstatat64		290
+#endif
+#define __NR_unlinkat		291
+#define __NR_renameat		292
+#define __NR_linkat		293
+#define __NR_symlinkat		294
+#define __NR_readlinkat		295
+#define __NR_fchmodat		296
+#define __NR_faccessat		297
 
-#define __NR_syscalls		285
+#define __NR_syscalls		298
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
Index: linux-2.6.17-rc2-git5/arch/powerpc/platforms/cell/spu_callbacks.c
===================================================================
--- linux-2.6.17-rc2-git5.orig/arch/powerpc/platforms/cell/spu_callbacks.c	2006-04-24 16:24:47.000000000 +0200
+++ linux-2.6.17-rc2-git5/arch/powerpc/platforms/cell/spu_callbacks.c	2006-04-24 18:07:59.000000000 +0200
@@ -318,6 +318,19 @@ void *spu_syscall_table[] = {
 	[__NR_unshare]			sys_unshare,
 	[__NR_splice]			sys_splice,
 	[__NR_tee]			sys_tee,
+	[__NR_openat]			sys_openat,
+	[__NR_mkdirat]			sys_mkdirat,
+	[__NR_mknodat]			sys_mknodat,
+	[__NR_fchownat]			sys_fchownat,
+	[__NR_futimesat]		sys_futimesat,
+	[__NR_newfstatat]		sys_newfstatat,
+	[__NR_unlinkat]			sys_unlinkat,
+	[__NR_renameat]			sys_renameat,
+	[__NR_linkat]			sys_linkat,
+	[__NR_symlinkat]		sys_symlinkat,
+	[__NR_readlinkat]		sys_readlinkat,
+	[__NR_fchmodat]			sys_fchmodat,
+	[__NR_faccessat]		sys_faccessat,
 };
 
 long spu_sys_callback(struct spu_syscall_block *s)
Index: linux-2.6.17-rc2-git5/fs/stat.c
===================================================================
--- linux-2.6.17-rc2-git5.orig/fs/stat.c	2006-04-24 18:05:23.000000000 +0200
+++ linux-2.6.17-rc2-git5/fs/stat.c	2006-04-24 18:05:44.000000000 +0200
@@ -261,7 +261,6 @@ asmlinkage long sys_newlstat(char __user
 	return error;
 }
 
-#ifndef __ARCH_WANT_STAT64
 asmlinkage long sys_newfstatat(int dfd, char __user *filename,
 				struct stat __user *statbuf, int flag)
 {
@@ -282,7 +281,6 @@ asmlinkage long sys_newfstatat(int dfd, 
 out:
 	return error;
 }
-#endif
 
 asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf)
 {

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
