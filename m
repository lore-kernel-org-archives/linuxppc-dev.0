Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vXSt1rpnzDrWY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 11:02:06 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/Makefiles: Fix clang/llvm build
Date: Tue, 21 Aug 2018 11:02:03 +1000
Message-Id: <20180821010203.23213-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Commit 15a3204d24a3 ("powerpc/64s: Set assembler machine type to POWER4")
passes -mpower4 to the assembler. We have more recent instructions in our
assembly files, but gas permits them. The clang/llvm integrated assembler
is more strict, and we get a build failure.

Fix this by calling the assembler with -mcpu=power8

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8397c7bd5880..4d9c01df0dec 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -238,7 +238,7 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
-cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
+cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower8
 cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
2.17.1
