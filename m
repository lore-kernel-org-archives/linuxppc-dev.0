Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D33D0DE174
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 20:36:31 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m2L9aQKK008329
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 04:36:27 -0500
Date: Fri, 21 Mar 2008 04:32:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Provide access to arch/powerpc include path on ppc64
Message-ID: <Pine.LNX.4.64.0803210431310.8073@blarg.am.freescale.net>
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

There does not appear to be any reason that we shouldn't just have
-Iarch/$(ARCH) on both ppc32 and ppc64 builds.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Makefile |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index ab5cfe8..43ee815 100644
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
1.5.4.1
