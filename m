Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61FB01A0E9B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:00:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc/lib: Makefile, consolidate obj-y sections
Date: Wed, 28 Jan 2015 15:00:13 +1100
Message-Id: <1422417614-25496-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/Makefile | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 5526156aae5f..31e1b34c0722 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -9,8 +9,9 @@ ccflags-$(CONFIG_PPC64)	:= $(NO_MINIMAL_TOC)
 CFLAGS_REMOVE_code-patching.o = -pg
 CFLAGS_REMOVE_feature-fixups.o = -pg
 
-obj-y			:= string.o alloc.o \
-			   crtsavres.o ppc_ksyms.o
+obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
+	 feature-fixups.o
+
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 
 obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
@@ -33,8 +34,6 @@ endif
 
 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 
-obj-y			+= code-patching.o
-obj-y			+= feature-fixups.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
-- 
2.1.0
