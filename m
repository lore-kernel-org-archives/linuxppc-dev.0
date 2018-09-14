Return-Path: <joel.stan@gmail.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BMRQ3DjVzF3V3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 14:07:14 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id b30-v6so3578404pla.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 21:07:14 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@samba.org>, Anton Blanchard <anton@ozlabs.org>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 1/5] powerpc/Makefiles: Fix clang/llvm build
Date: Fri, 14 Sep 2018 13:36:45 +0930
Message-Id: <20180914040649.1794-2-joel@jms.id.au>
In-Reply-To: <20180914040649.1794-1-joel@jms.id.au>
References: <20180914040649.1794-1-joel@jms.id.au>
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
