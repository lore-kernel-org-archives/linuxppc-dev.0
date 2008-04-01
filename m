Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <be85035fa2cb015a8020e63b40c6d5375aaff866.1207031915.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Make #include <sysdev/foo.h> work for 64-bit powerpc
Date: Tue,  1 Apr 2008 17:39:11 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We currently have inconsistent settings between 32 & 64-bit which means
32-bit code can #include <sysdev/foo.h> but 64-bit code can't.

So make the (C|A|CPP)FLAGS settings to allow this common. Doing so makes
the CPPFLAGS-y and AFLAGS-y variables unnecessary, so just fold them into
KBUILD_CPPFLAGS and KBUILD_AFLAGS respectively.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Makefile |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)


This is 26 material.

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1c6ce35..aa9829a 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -71,13 +71,11 @@ endif
 
 LDFLAGS_vmlinux	:= -Bstatic
 
-CPPFLAGS-$(CONFIG_PPC32) := -Iarch/$(ARCH)
-AFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
-CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
-KBUILD_CPPFLAGS	+= $(CPPFLAGS-y)
-KBUILD_AFLAGS	+= $(AFLAGS-y)
-KBUILD_CFLAGS	+= -msoft-float -pipe $(CFLAGS-y)
+CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
+KBUILD_CPPFLAGS	+= -Iarch/$(ARCH)
+KBUILD_AFLAGS	+= -Iarch/$(ARCH)
+KBUILD_CFLAGS	+= -msoft-float -pipe -Iarch/$(ARCH) $(CFLAGS-y)
 CPP		= $(CC) -E $(KBUILD_CFLAGS)
 
 CHECKFLAGS	+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
-- 
1.5.2.rc1.1884.g59b20
