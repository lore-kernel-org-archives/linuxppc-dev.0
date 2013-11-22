Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com", Issuer "Thawte SGC CA - G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D9052C00B9
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 13:49:07 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <scottwood@freescale.com>
Subject: [PATCH] powerpc/CoreNet64: compile with CONFIG_E{5,6}500_CPU well
Date: Fri, 22 Nov 2013 10:49:00 +0800
Message-ID: <1385088540-9675-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If CONFIG_ALTIVEC is enabled for CoreNet64, and if we also
select CONFIG_E{5,6}500_CPU this may introduce -mcpu=e500mc64
into $CFLAGS. But Altivec option not allowed with e500mc64,
then some compiling errors occur like this:

      CC      arch/powerpc/lib/xor_vmx.o
    arch/powerpc/lib/xor_vmx.c:1:0: error: AltiVec not supported in this target
    make[1]: *** [arch/powerpc/lib/xor_vmx.o] Error 1
    make: *** [arch/powerpc/lib] Error 2

So we should restrict e500mc64 in altivec scenario.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/Makefile |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 607acf5..fd5f6b5 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -127,7 +127,12 @@ CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
 CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
 CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
 
+# Altivec option not allowed with e500mc64 in GCC.
+ifeq ($(CONFIG_ALTIVEC),y)
+E5500_CPU := -mcpu=powerpc64
+else
 E5500_CPU := $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
+endif
 CFLAGS-$(CONFIG_E5500_CPU) += $(E5500_CPU)
 CFLAGS-$(CONFIG_E6500_CPU) += $(call cc-option,-mcpu=e6500,$(E5500_CPU))
 
-- 
1.7.9.5
