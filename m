Return-Path: <haokexin@gmail.com>
Received: from mail-yh0-x230.google.com (mail-yh0-x230.google.com
 [IPv6:2607:f8b0:4002:c01::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A96D1A01AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 23:10:01 +1100 (AEDT)
Received: by yhaf73 with SMTP id f73so4199445yha.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 04:09:59 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 11/11] powerpc: kill PPC_OF
Date: Thu, 26 Feb 2015 20:08:23 +0800
Message-Id: <1424952503-8247-12-git-send-email-haokexin@gmail.com>
In-Reply-To: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have set CONFIG_PPC_OF to always 'y' in commit 0a498d96a332
("powerpc: set CONFIG_PPC_OF=y always for ARCH=powerpc") nine years
ago. And the arch/ppc also has gone away for many years. The OF
functionality was also moved to a common place and be used by many
archs. So it does make no sense to keep such a option in the current
kernel. Just kill it.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

 arch/powerpc/Kconfig         | 3 ---
 arch/powerpc/Kconfig.debug   | 2 +-
 arch/powerpc/kernel/Makefile | 4 ++--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5084bdcc6046..1734f8a338eb 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -189,9 +189,6 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default PCI
 
-config PPC_OF
-	def_bool y
-
 config PPC_UDBG_16550
 	bool
 	default n
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index ec2e40f2cc11..bfd823abff93 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -117,7 +117,7 @@ config BDI_SWITCH
 
 config BOOTX_TEXT
 	bool "Support for early boot text console (BootX or OpenFirmware only)"
-	depends on PPC_OF && PPC_BOOK3S
+	depends on PPC_BOOK3S
 	help
 	  Say Y here to see progress messages from the boot firmware in text
 	  mode. Requires either BootX or Open Firmware.
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 502cf69b6c89..c1ebbdaac28f 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -33,7 +33,8 @@ obj-y				:= cputable.o ptrace.o syscalls.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o dma.o \
-				   misc_$(CONFIG_WORD_SIZE).o vdso32/
+				   misc_$(CONFIG_WORD_SIZE).o vdso32/ \
+				   of_platform.o prom_parse.o
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o nvram_64.o firmware.o
@@ -47,7 +48,6 @@ obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
 obj-$(CONFIG_PPC_P7_NAP)	+= idle_power7.o
-obj-$(CONFIG_PPC_OF)		+= of_platform.o prom_parse.o
 procfs-y			:= proc_powerpc.o
 obj-$(CONFIG_PROC_FS)		+= $(procfs-y)
 rtaspci-$(CONFIG_PPC64)-$(CONFIG_PCI)	:= rtas_pci.o
-- 
1.9.3
