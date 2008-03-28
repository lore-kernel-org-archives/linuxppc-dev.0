Return-Path: <stephenn@xilinx.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2EE31DDFA5
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 03:26:19 +1100 (EST)
Received: from outbound1-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound1-sin-R.bigfish.com (Postfix) with ESMTP id 7814E1CA9D1D
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:17 +0000 (UTC)
Received: from mail149-sin-R.bigfish.com (unknown [10.3.252.3])
	by outbound1-sin.bigfish.com (Postfix) with ESMTP id 4B408145805A
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:17 +0000 (UTC)
Received: from mail149-sin (localhost.localdomain [127.0.0.1])
	by mail149-sin-R.bigfish.com (Postfix) with ESMTP id 3C7893C05DC
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:17 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail149-sin.bigfish.com (Postfix) with ESMTP id C0EB8D9806F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:16 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <stephenn@xilinx.com>) id 1JfHPE-000099-1l
	for linuxppc-dev@ozlabs.org; Fri, 28 Mar 2008 09:26:16 -0700
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] [RFC][PPC] Use DCR for arch ppc,
	and enable MMIO and NATIVE for virtex.
Date: Fri, 28 Mar 2008 09:23:49 -0700
In-Reply-To: <1206721429-18276-4-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1206401313-1625-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1206721429-18276-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1206721429-18276-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1206721429-18276-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1206721429-18276-4-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080328162616.C0EB8D9806F@mail149-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Generally speaking, I'm not sure about the validity of this patch.  In
particular:

1) I'm not sure what architecture code relies on including
dcr support through ibm4xx.h.

2) I'm not sure how temporary the ifdef in
arch/powerpc/sysdev/Makefile really is.  Is it still needed or not?

However, this appears to work at least for the Virtex systems I've
tried.  In any event, I don't expect this to actually be sent to
mainline, since it's ARCH=ppc related, at least not in this form.

Unfortunately, the framebuffer driver won't work under ARCH=ppc
without this patch.
---
 arch/powerpc/sysdev/Makefile   |    2 --
 arch/ppc/Kconfig               |    6 +++++-
 arch/ppc/platforms/4xx/Kconfig |    2 ++
 include/asm-ppc/ibm4xx.h       |    1 -
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 15f3e85..c85525b 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -35,10 +35,8 @@ endif
 endif
 
 # Temporary hack until we have migrated to asm-powerpc
-ifeq ($(ARCH),powerpc)
 obj-$(CONFIG_CPM)		+= cpm_common.o
 obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
 obj-$(CONFIG_8xx)		+= mpc8xx_pic.o cpm1.o
 obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
-endif
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index abc877f..81d6748 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -116,9 +116,13 @@ config PPC_DCR_NATIVE
 	bool
 	default n
 
+config PPC_DCR_MMIO
+	bool
+	default n
+
 config PPC_DCR
 	bool
-	depends on PPC_DCR_NATIVE
+	depends on PPC_DCR_NATIVE || PPC_DCR_MMIO
 	default y
 
 config PTE_64BIT
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 76551b6..0430fc2 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -228,6 +228,8 @@ config XILINX_VIRTEX_4_FX
 
 config XILINX_VIRTEX
 	bool
+	select PPC_DCR_NATIVE
+	select PPC_DCR_MMIO
 
 config STB03xxx
 	bool
diff --git a/include/asm-ppc/ibm4xx.h b/include/asm-ppc/ibm4xx.h
index ed6891a..053a86b 100644
--- a/include/asm-ppc/ibm4xx.h
+++ b/include/asm-ppc/ibm4xx.h
@@ -15,7 +15,6 @@
 #define __ASM_IBM4XX_H__
 
 #include <asm/types.h>
-#include <asm/dcr.h>
 
 #ifdef CONFIG_40x
 
-- 
1.5.3.4-dirty
