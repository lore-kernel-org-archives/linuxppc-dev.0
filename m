Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 58700DE066
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 20:53:12 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 02/12] [POWERPC] Provide access to arch/powerpc include path
	on ppc64
Date: Thu, 10 Apr 2008 05:48:41 -0500
Message-Id: <1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
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
index dd80825..e2ec4a9 100644
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
