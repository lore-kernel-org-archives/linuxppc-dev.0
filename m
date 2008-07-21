Return-Path: <marvin24@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3B302DDE11
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 17:05:46 +1000 (EST)
From: Marvin <marvin24@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [5/5] include tuning options into Makefile
Date: Mon, 21 Jul 2008 09:00:58 +0200
References: <200807210857.08892.marvin24@gmx.de>
In-Reply-To: <200807210857.08892.marvin24@gmx.de>
MIME-Version: 1.0
Message-Id: <200807210900.58839.marvin24@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This patch finally adds mcpu/mtune options to the Makefile using the
previous introduced tuning mechanism.

Subject: [PATCH] include tuning options into Makefile

---
 arch/powerpc/Makefile |   41 +++++++++++++++++++++++------------------
 1 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9629c5e..09f81a7 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -75,30 +75,35 @@ CPP		= $(CC) -E $(KBUILD_CFLAGS)
 CHECKFLAGS	
+= -m$(CONFIG_WORD_SIZE) -D__powerpc__ -D__powerpc$(CONFIG_WORD_SIZE)__
 
 ifeq ($(CONFIG_PPC64),y)
-GCC_BROKEN_VEC	:= $(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; 
fi)
 
-ifeq ($(CONFIG_TUNE_POWER4),y)
-ifeq ($(CONFIG_OPT_EXCLUSIVE),y)
-ifeq ($(CONFIG_ALTIVEC),y)
-ifeq ($(GCC_BROKEN_VEC),y)
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=970)
+ifeq ($(shell if [ $(call cc-version) -lt 0400 ] ; then echo "y"; fi),y)
+    P4CPU := power4
 else
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
+    P4CPU := 970
 endif
-else
-	KBUILD_CFLAGS += $(call cc-option,-mcpu=power4)
-endif
-else
-	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
-endif
-	KBUILD_CFLAGS += $(call cc-option,-mtune=power4)
+
+# optimize for specific cpu
+ifeq ($(CONFIG_TUNE_RS64),y)
+    KBUILD_CFLAGS += $(call cc-option,-mcpu=rs64)
+else ifeq ($(CONFIG_TUNE_POWER3),y)
+    KBUILD_CFLAGS += $(call cc-option,-mcpu=power3)
+else ifeq ($(CONFIG_TUNE_POWER4),y)
+    KBUILD_CFLAGS += $(call cc-option,-mcpu=$(P4CPU))
+else ifeq ($(CONFIG_TUNE_CELL),y)
+    KBUILD_CFLAGS += $(call cc-option,-mcpu=cell,-mtune=cell)
+else ifeq ($(CONFIG_TUNE_POWER5),y)
+    KBUILD_CFLAGS += $(call cc-option,-mcpu=power5,-mtune=power5)
+else ifeq ($(CONFIG_TUNE_POWER6),y)
+    KBUILD_CFLAGS += $(call cc-option,-mcpu=power6,-mtune=power6)
 endif
-else
-LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
+
+ifneq ($(CONFIG_OPT_EXCLUSIVE),y)
+    KBUILD_CFLAGS := $(subst mcpu,mtune,$(KBUILD_CFLAGS))
 endif
 
-ifeq ($(CONFIG_TUNE_CELL),y)
-	KBUILD_CFLAGS += $(call cc-option,-mtune=cell)
+else
+# !PPC64
+    LDFLAGS_MODULE	+= arch/powerpc/lib/crtsavres.o
 endif
 
 # No AltiVec instruction when building kernel
-- 
1.5.6.2
