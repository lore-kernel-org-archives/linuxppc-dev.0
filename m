Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84DCCDDE32
	for <linuxppc-dev@ozlabs.org>; Sun, 19 Aug 2007 03:11:47 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l7IHBen3008962
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 12:11:41 -0500
Date: Sat, 18 Aug 2007 12:11:58 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3 v2][POWERPC] Stop include asm-ppc when building
	ARCH=powerpc for ppc32
In-Reply-To: <Pine.LNX.4.64.0708181207530.31362@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0708181210390.31362@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181206070.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181207530.31362@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We no longer have any dependancies on include/asm-ppc so we can get ride
of the makefile hacks to include it in the build process.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Actually remove all the bits related to include fixup, not just comment
them out :)

 arch/powerpc/Makefile |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6c1e36c..d6ab02e 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -63,8 +63,7 @@ endif

 LDFLAGS_vmlinux	:= -Bstatic

-# The -Iarch/$(ARCH)/include is temporary while we are merging
-CPPFLAGS-$(CONFIG_PPC32) := -Iarch/$(ARCH) -Iarch/$(ARCH)/include
+CPPFLAGS-$(CONFIG_PPC32) := -Iarch/$(ARCH)
 AFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
@@ -72,9 +71,6 @@ CPPFLAGS	+= $(CPPFLAGS-y)
 AFLAGS		+= $(AFLAGS-y)
 CFLAGS		+= -msoft-float -pipe $(CFLAGS-y)
 CPP		= $(CC) -E $(CFLAGS)
-# Temporary hack until we have migrated to asm-powerpc
-LINUXINCLUDE-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)/include
-LINUXINCLUDE    += $(LINUXINCLUDE-y)

 CHECKFLAGS	+= -m$(SZ) -D__powerpc__ -D__powerpc$(SZ)__

@@ -172,19 +168,8 @@ install:
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)

-archmrproper:
-	$(Q)rm -rf arch/$(ARCH)/include
-
 archprepare: checkbin

-ifeq ($(CONFIG_PPC32),y)
-# Temporary hack until we have migrated to asm-powerpc
-include/asm: arch/$(ARCH)/include/asm
-arch/$(ARCH)/include/asm: FORCE
-	$(Q)if [ ! -d arch/$(ARCH)/include ]; then mkdir -p arch/$(ARCH)/include; fi
-	$(Q)ln -fsn $(srctree)/include/asm-$(OLDARCH) arch/$(ARCH)/include/asm
-endif
-
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
 TOUT	:= .tmp_gas_check
-- 
1.5.2.2
