Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 22E8067A39
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 23:46:51 +1000 (EST)
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 97916EFF7
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 15:46:42 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Wire up *at syscalls
References: <jeu08ippb9.fsf@sykes.suse.de>
Date: Thu, 27 Apr 2006 15:46:42 +0200
In-Reply-To: <jeu08ippb9.fsf@sykes.suse.de> (Andreas Schwab's message of "Tue,
	25 Apr 2006 00:43:38 +0200")
Message-ID: <je4q0fjflp.fsf@sykes.suse.de>
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

Updated for 2.6.17-rc2.

Andreas.

Wire up *at syscalls.

Signed-off-by: Andreas Schwab <schwab@suse.de>

---
 arch/powerpc/kernel/systbl.S                |   13 +++++++++++++
 arch/powerpc/platforms/cell/spu_callbacks.c |   13 +++++++++++++
 fs/stat.c                                   |    2 +-
 include/asm-powerpc/unistd.h                |   20 +++++++++++++++++++-
 4 files changed, 46 insertions(+), 2 deletions(-)

Index: linux-2.6.17-rc3/arch/powerpc/kernel/systbl.S
===================================================================
--- linux-2.6.17-rc3.orig/arch/powerpc/kernel/systbl.S	2006-04-27 11:11:28.000000000 +0200
+++ linux-2.6.17-rc3/arch/powerpc/kernel/systbl.S	2006-04-27 11:17:36.000000000 +0200
@@ -325,6 +325,19 @@ SYSCALL(unshare)
 SYSCALL(splice)
 SYSCALL(tee)
 SYSCALL(vmsplice)
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
Index: linux-2.6.17-rc3/include/asm-powerpc/unistd.h
===================================================================
--- linux-2.6.17-rc3.orig/include/asm-powerpc/unistd.h	2006-04-27 11:12:05.000000000 +0200
+++ linux-2.6.17-rc3/include/asm-powerpc/unistd.h	2006-04-27 11:18:21.000000000 +0200
@@ -304,8 +304,25 @@
 #define __NR_splice		283
 #define __NR_tee		284
 #define __NR_vmsplice		285
+#define __NR_openat		286
+#define __NR_mkdirat		287
+#define __NR_mknodat		288
+#define __NR_fchownat		289
+#define __NR_futimesat		290
+#ifdef __powerpc64__
+#define __NR_newfstatat		291
+#else
+#define __NR_fstatat64		291
+#endif
+#define __NR_unlinkat		292
+#define __NR_renameat		293
+#define __NR_linkat		294
+#define __NR_symlinkat		295
+#define __NR_readlinkat		296
+#define __NR_fchmodat		297
+#define __NR_faccessat		298
 
-#define __NR_syscalls		286
+#define __NR_syscalls		299
 
 #ifdef __KERNEL__
 #define __NR__exit __NR_exit
@@ -458,6 +475,7 @@ type name(type1 arg1, type2 arg2, type3 
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_COMPAT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_RT_SIGSUSPEND
+#define __ARCH_WANT_SYS_NEWFSTATAT
 #endif
 
 /*
Index: linux-2.6.17-rc3/arch/powerpc/platforms/cell/spu_callbacks.c
===================================================================
--- linux-2.6.17-rc3.orig/arch/powerpc/platforms/cell/spu_callbacks.c	2006-04-27 11:11:28.000000000 +0200
+++ linux-2.6.17-rc3/arch/powerpc/platforms/cell/spu_callbacks.c	2006-04-27 11:18:52.000000000 +0200
@@ -319,6 +319,19 @@ void *spu_syscall_table[] = {
 	[__NR_splice]			sys_splice,
 	[__NR_tee]			sys_tee,
 	[__NR_vmsplice]			sys_vmsplice,
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
Index: linux-2.6.17-rc3/fs/stat.c
===================================================================
--- linux-2.6.17-rc3.orig/fs/stat.c	2006-04-25 01:52:39.000000000 +0200
+++ linux-2.6.17-rc3/fs/stat.c	2006-04-27 11:17:13.000000000 +0200
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
