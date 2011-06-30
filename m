Return-Path: <anton@samba.org>
Date: Fri, 1 Jul 2011 09:55:27 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Use -mtraceback=no
Message-ID: <20110701095527.50631fa3@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


gcc 4.7 will be more strict about parsing the -mtraceback option:

 gcc: error: unrecognized argument in option '-mtraceback=none'
 gcc: note: valid arguments to '-mtraceback=' are: full no part

gcc used to do a 2 char compare so both "no" and "none" would
match. Switch to using -mtraceback=no should work everywhere.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/Makefile
===================================================================
--- linux-powerpc.orig/arch/powerpc/Makefile	2011-07-01 09:40:57.902255472 +1000
+++ linux-powerpc/arch/powerpc/Makefile	2011-07-01 09:41:13.512533634 +1000
@@ -67,7 +67,7 @@ LDFLAGS_vmlinux-yy := -Bstatic
 LDFLAGS_vmlinux-$(CONFIG_PPC64)$(CONFIG_RELOCATABLE) := -pie
 LDFLAGS_vmlinux	:= $(LDFLAGS_vmlinux-yy)
 
-CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
+CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=no -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
 KBUILD_CPPFLAGS	+= -Iarch/$(ARCH)
 KBUILD_AFLAGS	+= -Iarch/$(ARCH)
