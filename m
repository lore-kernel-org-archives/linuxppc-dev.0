Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F5981A084F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 15:00:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/lib: Makefile,
 use obj64-y to consolidate 64-bit rules
Date: Wed, 28 Jan 2015 15:00:14 +1100
Message-Id: <1422417614-25496-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1422417614-25496-1-git-send-email-mpe@ellerman.id.au>
References: <1422417614-25496-1-git-send-email-mpe@ellerman.id.au>
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
 arch/powerpc/lib/Makefile | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 31e1b34c0722..7902802a19a5 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -14,27 +14,25 @@ obj-y += string.o alloc.o crtsavres.o ppc_ksyms.o code-patching.o \
 
 obj-$(CONFIG_PPC32)	+= div64.o copy_32.o
 
-obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
-			   usercopy_64.o mem_64.o hweight_64.o \
-			   copyuser_power7.o string_64.o copypage_power7.o \
-			   memcmp_64.o
+obj64-y	+= copypage_64.o copyuser_64.o usercopy_64.o mem_64.o hweight_64.o \
+	   copyuser_power7.o string_64.o copypage_power7.o memcpy_power7.o \
+	   memcpy_64.o memcmp_64.o
+
+obj64-$(CONFIG_SMP)	+= locks.o
+obj64-$(CONFIG_ALTIVEC)	+= vmx-helper.o
+
 ifeq ($(CONFIG_GENERIC_CSUM),)
 obj-y			+= checksum_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_PPC64)	+= checksum_wrappers_64.o
 endif
 
-obj-$(CONFIG_PPC64)		+= memcpy_power7.o memcpy_64.o 
-
 obj-$(CONFIG_PPC_EMULATE_SSTEP)	+= sstep.o ldstfp.o
 
-ifeq ($(CONFIG_PPC64),y)
-obj-$(CONFIG_SMP)	+= locks.o
-obj-$(CONFIG_ALTIVEC)	+= vmx-helper.o
-endif
-
 obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
 CFLAGS_xor_vmx.o += -maltivec -mabi=altivec
+
+obj-$(CONFIG_PPC64) += $(obj64-y)
-- 
2.1.0
