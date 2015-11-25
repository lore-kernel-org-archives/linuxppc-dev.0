Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00E471A0351
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 10:46:06 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Avoid -maltivec when using clang integrated assembler
Date: Thu, 26 Nov 2015 10:45:49 +1100
Message-Id: <1448495149-25024-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check the assembler supports -maltivec by wrapping it with
call as-option.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 96efd82..76a315d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -206,7 +206,7 @@ KBUILD_CFLAGS		+= -mno-sched-epilog
 endif
 
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
-cpu-as-$(CONFIG_ALTIVEC)	+= -Wa,-maltivec
+cpu-as-$(CONFIG_ALTIVEC)	+= $(call as-option,-Wa$(comma)-maltivec)
 cpu-as-$(CONFIG_E200)		+= -Wa,-me200
 
 KBUILD_AFLAGS += $(cpu-as-y)
-- 
2.5.0
