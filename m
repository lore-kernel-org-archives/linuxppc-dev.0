Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3294A679FC
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 10:03:14 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Wire up *at syscalls
References: <jeu08ippb9.fsf@sykes.suse.de> <200604250131.22154.arnd@arndb.de>
Date: Tue, 25 Apr 2006 02:03:08 +0200
In-Reply-To: <200604250131.22154.arnd@arndb.de> (Arnd Bergmann's message of
	"Tue, 25 Apr 2006 01:31:21 +0200")
Message-ID: <jelktuplmr.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann <arnd@arndb.de> writes:

> Simply removing the #ifdef looks wrong. AFAICT, powerpc and ia64 are the
> only ones that want both sys_newfstatat and sys_fstatat64, maybe you
> can simply do 
>
> #if !defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_NEWSTATFSAT)

Updated patch below.

Andreas.

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 arch/powerpc/kernel/systbl.S                |   13 +++++++++++++
 arch/powerpc/platforms/cell/spu_callbacks.c |   13 +++++++++++++
 fs/stat.c                                   |    2 +-
 include/asm-powerpc/unistd.h                |   20 +++++++++++++++++++-
 4 files changed, 46 insertions(+), 2 deletions(-)

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
+++ linux-2.6.17-rc2-git5/include/asm-powerpc/unistd.h	2006-04-25 01:35:38.000000000 +0200
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
@@ -457,6 +474,7 @@ type name(type1 arg1, type2 arg2, type3 
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
+#define __ARCH_WANT_SYS_NEWFSTATAT
 #endif
 
 /*
Index: linux-2.6.17-rc2-git5/arch/powerpc/platforms/cell/spu_callbacks.c
===================================================================
--- linux-2.6.17-rc2-git5.orig/arch/powerpc/platforms/cell/spu_callbacks.c	2006-04-24 16:24:47.000000000 +0200
+++ linux-2.6.17-rc2-git5/arch/powerpc/platforms/cell/spu_callbacks.c	2006-04-24 23:51:16.000000000 +0200
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
+++ linux-2.6.17-rc2-git5/fs/stat.c	2006-04-25 01:37:06.000000000 +0200
@@ -261,7 +261,7 @@ asmlinkage long sys_newlstat(char __user
 	return error;
 }
 
-#ifndef __ARCH_WANT_STAT64
+#if !defined(__ARCH_WANT_STAT64) || defined(__ARCH_WANT_SYS_NEWFSTATAT)
 asmlinkage long sys_newfstatat(int dfd, char __user *filename,
 				struct stat __user *statbuf, int flag)
 {

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
