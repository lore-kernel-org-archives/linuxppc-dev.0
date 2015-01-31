Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com
 [IPv6:2607:f8b0:4002:c07::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBAB81A114D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:49:04 +1100 (AEDT)
Received: by mail-yk0-f169.google.com with SMTP id 200so19066120ykr.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:49:02 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/15] powerpc: kill PPC_OF
Date: Sat, 31 Jan 2015 21:47:45 +0800
Message-Id: <1422712065-9403-16-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>
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
 arch/powerpc/Kconfig         | 3 ---
 arch/powerpc/Kconfig.debug   | 2 +-
 arch/powerpc/kernel/Makefile | 4 ++--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 22b0940494bb..c102668b4225 100644
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
