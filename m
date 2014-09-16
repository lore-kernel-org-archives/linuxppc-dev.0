Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6A121A00F4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 10:47:49 +1000 (EST)
Date: Tue, 16 Sep 2014 10:47:49 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 torvalds@linux-foundation.org
Subject: [PATCH 1/2] powerpc: Add POWER8 CPU selection
Message-ID: <20140916104749.35b84da8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows the user to build a kernel targeted at POWER8
(ie gcc -mcpu=power8).

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/Makefile
===================================================================
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -135,6 +135,7 @@ CFLAGS-$(CONFIG_POWER4_CPU) += $(call cc
 CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
 CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
 CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)
+CFLAGS-$(CONFIG_POWER8_CPU) += $(call cc-option,-mcpu=power8)
 
 # Altivec option not allowed with e500mc64 in GCC.
 ifeq ($(CONFIG_ALTIVEC),y)
Index: b/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -117,6 +117,10 @@ config POWER7_CPU
 	bool "POWER7"
 	depends on PPC_BOOK3S_64
 
+config POWER8_CPU
+	bool "POWER8"
+	depends on PPC_BOOK3S_64
+
 config E5500_CPU
 	bool "Freescale e5500"
 	depends on E500
