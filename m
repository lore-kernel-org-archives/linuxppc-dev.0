Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CAA1DDE1D
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 11:23:33 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	m811NVIF007593
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Mon, 1 Sep 2008 03:23:31 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m811NUih007591
	for linuxppc-dev@ozlabs.org; Mon, 1 Sep 2008 03:23:30 +0200
Date: Mon, 1 Sep 2008 03:23:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: use sys_pause for 32bit pause entry point
Message-ID: <20080901012330.GA7544@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

sys32_pause is a useless copy of the generic sys_pause.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/include/asm/systbl.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/systbl.h	2008-08-22 12:47:08.000000000 -0300
+++ linux-2.6/arch/powerpc/include/asm/systbl.h	2008-08-22 12:47:35.000000000 -0300
@@ -32,7 +32,7 @@ COMPAT_SYS_SPU(stime)
 COMPAT_SYS(ptrace)
 SYSCALL_SPU(alarm)
 OLDSYS(fstat)
-COMPAT_SYS(pause)
+SYSCALL(pause)
 COMPAT_SYS(utime)
 SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
Index: linux-2.6/arch/powerpc/kernel/sys_ppc32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/sys_ppc32.c	2008-08-22 12:47:41.000000000 -0300
+++ linux-2.6/arch/powerpc/kernel/sys_ppc32.c	2008-08-22 12:47:51.000000000 -0300
@@ -107,14 +107,6 @@ asmlinkage long compat_sys_sysfs(u32 opt
 	return sys_sysfs((int)option, arg1, arg2);
 }
 
-asmlinkage long compat_sys_pause(void)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule();
-	
-	return -ERESTARTNOHAND;
-}
-
 static inline long get_ts32(struct timespec *o, struct compat_timeval __user *i)
 {
 	long usec;
