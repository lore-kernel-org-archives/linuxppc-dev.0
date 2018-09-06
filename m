Return-Path: <joel.stan@gmail.com>
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com
 [209.85.214.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425Wq45fv3zF3CK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2018 17:07:28 +1000 (AEST)
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so4521373pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Sep 2018 00:07:27 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/Makefiles: Fix clang/llvm build
Date: Thu,  6 Sep 2018 17:07:10 +1000
Message-Id: <20180906070710.29944-1-joel@jms.id.au>
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

Fix this by calling the assembler with -mcpu=power8 if as supports it,
else fall back to power4.

Suggested-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 11a1acba164a..a70639482053 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -238,7 +238,7 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
-cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= -Wa,-mpower4
+cpu-as-$(CONFIG_PPC_BOOK3S_64)	+= $(call as-option,-Wa$(comma)-mpower8,-Wa$(comma)-mpower4)
 cpu-as-$(CONFIG_PPC_E500MC)	+= $(call as-option,-Wa$(comma)-me500mc)
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
2.17.1
