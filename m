Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3168C1A0E36
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 08:53:46 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 behanw@converseincode.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/6] powerpc: Don't use gcc specific options on clang
Date: Tue, 26 May 2015 08:53:29 +1000
Message-Id: <1432594410-31198-6-git-send-email-anton@samba.org>
In-Reply-To: <1432594410-31198-1-git-send-email-anton@samba.org>
References: <1432594410-31198-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a conditional around the code to select various gcc only options:
-mabi=elfv2 vs -mcall-aixdesc, and -mcmodel=medium vs -mminimal-toc.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 9cf7c7c..347c80f6 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -115,6 +115,7 @@ endif
 endif
 
 CFLAGS-$(CONFIG_PPC64)	:= $(call cc-option,-mtraceback=no)
+ifneq ($(COMPILER),clang)
 ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2,-mcall-aixdesc)
 AFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mabi=elfv2)
@@ -122,6 +123,7 @@ else
 CFLAGS-$(CONFIG_PPC64)	+= -mcall-aixdesc
 endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,-mminimal-toc)
+endif
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
 CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 
-- 
2.1.4
