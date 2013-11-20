Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com", Issuer "Thawte SGC CA - G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B8F02C0090
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Nov 2013 19:36:00 +1100 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <scottwood@freescale.com>
Subject: [RFC][PATCH] powerpc/CoreNet64: compile with CONFIG_E{5,
 6}500_CPU well
Date: Wed, 20 Nov 2013 16:35:51 +0800
Message-ID: <1384936551-8494-1-git-send-email-tiejun.chen@windriver.com>
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

CONFIG_ALTIVEC is always enabled for CoreNet64. And if we
select CONFIG_E{5,6}500_CPU this may introduce -mcpu=e500mc64
into $CFLAGS. But Altivec and Spe options not allowed with
e500mc64, so :

  CC      arch/powerpc/lib/xor_vmx.o
arch/powerpc/lib/xor_vmx.c:1:0: error: AltiVec not supported in this target
make[1]: *** [arch/powerpc/lib/xor_vmx.o] Error 1
make: *** [arch/powerpc/lib] Error 2

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/lib/Makefile |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 95a20e1..641a77d 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -40,5 +40,8 @@ obj-y			+= code-patching.o
 obj-y			+= feature-fixups.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
+# Altivec and Spe options not allowed with e500mc64 in GCC.
+ifeq ($(call cc-option-yn,-mcpu=e500mc64),n)
 obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
 CFLAGS_xor_vmx.o += -maltivec -mabi=altivec
+endif
-- 
1.7.9.5
