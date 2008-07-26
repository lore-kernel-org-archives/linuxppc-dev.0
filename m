Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4EF90DDEFC
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 02:45:28 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] [PPC64] change powerpc Makefile to use the new tuning
	options
Date: Sat, 26 Jul 2008 18:44:34 +0200
References: <200807261833.55994.marvin24@gmx.de>
In-Reply-To: <200807261833.55994.marvin24@gmx.de>
MIME-Version: 1.0
Message-Id: <200807261844.34950.marvin24@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: olof@lixom.net, miltonm@bga.com, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch modifies the Makefile to use the new tuning options. Most of the 
work
is done in Kconfig now, so this looks a little bit more clearly (except the
broken altivec hack).

Subject: [PATCH 2/2] [PPC64] change powerpc Makefile to use the new tuning 
options

---
 arch/powerpc/Makefile |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9155c93..dc189e7 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -75,29 +75,15 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
 CHECKFLAGS	
+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
 
 ifeq ($(CONFIG_PPC64),y)
-GCC_BROKEN_VEC	:= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; 
fi)
-
-ifeq ($(CONFIG_POWER4_ONLY),y)
-ifeq ($(CONFIG_ALTIVEC),y)
-ifeq ($(GCC_BROKEN_VEC),y)
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=970)
-else
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
-endif
-else
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
-endif
-else
-	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
-endif
+KBUILD_CFLAGS += $(call cc-option,  -mcpu=$(CONFIG_OPT_CPU)  )
+KBUILD_CFLAGS += $(call cc-option, -mtune=$(CONFIG_TUNE_CPU) )
+ifeq ($(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; fi),y)
+    KBUILD_CFLAGS := $(subst mcpu=970,mcpu=power4,$(KBUILD_CFLAGS))
+endif    
 else
 LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
 endif
 
-ifeq ($(CONFIG_TUNE_CELL),y)
-	KBUILD_CFLAGS += $(call cc-option,-mtune=cell)
-endif
-
 # No AltiVec instruction when building kernel
 KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
 
-- 
1.5.6.2
