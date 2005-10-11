Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BF0CF6842D
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2005 05:01:40 +1000 (EST)
Date: Tue, 11 Oct 2005 21:01:33 +0200
From: Olaf Hering <olh@suse.de>
To: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <20051011190133.GA31348@suse.de>
References: <20050426211019.GA11579@suse.de> <426F9646.3000407@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <426F9646.3000407@namesys.com>
Cc: linuxppc-dev@ozlabs.org, reiserfs-dev@namesys.com,
	Jeff Mahoney <jeffm@suse.de>
Subject: [PATCH] make gcc -O1 in fs/reiserfs optional
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Wed, Apr 27, Hans Reiser wrote:

> Olaf Hering wrote:
> 
> >Jeff,
> >
> >you added this EXTRA_CFLAGS= during 2.4 development, I think the broken
> >compiler was gcc 3.2 on SLES8. Can we turn this -O1 into a .config
> >option?

> Sounds reasonable.

 only compile with -O1 if the (very old) compiler is broken
 We use reiserfs alot in SLES9 on ppc64, and it was never seen
 with gcc33.

Signed-off-by: Olaf Hering <olh@suse.de>

Index: linux-2.6.12-rc3-olh/fs/reiserfs/Makefile
===================================================================
--- linux-2.6.12-rc3-olh.orig/fs/reiserfs/Makefile
+++ linux-2.6.12-rc3-olh/fs/reiserfs/Makefile
@@ -21,13 +21,7 @@ ifeq ($(CONFIG_REISERFS_FS_POSIX_ACL),y)
 reiserfs-objs += xattr_acl.o
 endif
 
-# gcc -O2 (the kernel default)  is overaggressive on ppc32 when many inline
-# functions are used.  This causes the compiler to advance the stack
-# pointer out of the available stack space, corrupting kernel space,
-# and causing a panic. Since this behavior only affects ppc32, this ifeq
-# will work around it. If any other architecture displays this behavior,
-# add it here.
-ifeq ($(CONFIG_PPC32),y)
+ifeq ($(CONFIG_REISERFS_CC_REDUCE_OPTIMZE),y)
 EXTRA_CFLAGS := -O1
 endif
 
Index: linux-2.6.12-rc3-olh/fs/Kconfig
===================================================================
--- linux-2.6.12-rc3-olh.orig/fs/Kconfig
+++ linux-2.6.12-rc3-olh/fs/Kconfig
@@ -186,6 +186,18 @@ config REISERFS_FS
 	  If you like it, you can pay us to add new features to it that you
 	  need, buy a support contract, or pay us to port it to another OS.
 
+config REISERFS_CC_REDUCE_OPTIMZE
+	bool "Reduce CC optimization level to workaround compiler bugs"
+	depends on PPC32
+	default n
+	help
+	  gcc -O2 (the kernel default) is overaggressive on ppc32 when many inline
+	  functions are used.  This causes the compiler to advance the stack
+	  pointer out of the available stack space, corrupting kernel space,
+	  and causing a panic. Since this behavior only affects ppc32, this ifeq
+	  will work around it. If any other architecture displays this behavior,
+	  add it here.
+
 config REISERFS_CHECK
 	bool "Enable reiserfs debug mode"
 	depends on REISERFS_FS
-- 
short story of a lazy sysadmin:
 alias appserv=wotan
