Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA18E1A0CA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 08:53:39 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 behanw@converseincode.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/6] powerpc: Only use -mabi=altivec if toolchain supports it
Date: Tue, 26 May 2015 08:53:26 +1000
Message-Id: <1432594410-31198-3-git-send-email-anton@samba.org>
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

The -mabi=altivec option is not recognised on LLVM, so use call cc-option
to check for support.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/lib/Makefile | 2 +-
 lib/raid6/Makefile        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 7902802..a47e142 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -33,6 +33,6 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
-CFLAGS_xor_vmx.o += -maltivec -mabi=altivec
+CFLAGS_xor_vmx.o += -maltivec $(call cc-option,-mabi=altivec)
 
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/lib/raid6/Makefile b/lib/raid6/Makefile
index c7dab06..3b10a48 100644
--- a/lib/raid6/Makefile
+++ b/lib/raid6/Makefile
@@ -15,7 +15,7 @@ quiet_cmd_unroll = UNROLL  $@
                    < $< > $@ || ( rm -f $@ && exit 1 )
 
 ifeq ($(CONFIG_ALTIVEC),y)
-altivec_flags := -maltivec -mabi=altivec
+altivec_flags := -maltivec $(call cc-option,-mabi=altivec)
 endif
 
 # The GCC option -ffreestanding is required in order to compile code containing
-- 
2.1.4
