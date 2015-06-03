Return-Path: <robherring2@gmail.com>
Received: from mail-qc0-x22c.google.com (mail-qc0-x22c.google.com
 [IPv6:2607:f8b0:400d:c01::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CD1E01A005A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 15:11:05 +1000 (AEST)
Received: by qcmi9 with SMTP id i9so68926419qcm.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2015 22:11:03 -0700 (PDT)
Sender: Rob Herring <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] of: clean-up unnecessary libfdt include paths
Date: Wed,  3 Jun 2015 00:10:25 -0500
Message-Id: <1433308225-13874-1-git-send-email-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the latest dtc import include fixups, it is no longer necessary to
add explicit include paths to use libfdt. Remove these across the
kernel.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/mips/cavium-octeon/Makefile      | 3 ---
 arch/mips/mti-sead3/Makefile          | 2 --
 arch/powerpc/kernel/Makefile          | 1 -
 drivers/firmware/efi/libstub/Makefile | 2 --
 drivers/of/Makefile                   | 3 ---
 5 files changed, 11 deletions(-)

diff --git a/arch/mips/cavium-octeon/Makefile b/arch/mips/cavium-octeon/Makefile
index 69a8a8d..2a59265 100644
--- a/arch/mips/cavium-octeon/Makefile
+++ b/arch/mips/cavium-octeon/Makefile
@@ -9,9 +9,6 @@
 # Copyright (C) 2005-2009 Cavium Networks
 #
 
-CFLAGS_octeon-platform.o = -I$(src)/../../../scripts/dtc/libfdt
-CFLAGS_setup.o = -I$(src)/../../../scripts/dtc/libfdt
-
 obj-y := cpu.o setup.o octeon-platform.o octeon-irq.o csrc-octeon.o
 obj-y += dma-octeon.o
 obj-y += octeon-memcpy.o
diff --git a/arch/mips/mti-sead3/Makefile b/arch/mips/mti-sead3/Makefile
index ecd71db..2e52cbd 100644
--- a/arch/mips/mti-sead3/Makefile
+++ b/arch/mips/mti-sead3/Makefile
@@ -15,5 +15,3 @@ obj-y				:= sead3-lcd.o sead3-display.o sead3-init.o \
 obj-y				+= leds-sead3.o
 
 obj-$(CONFIG_EARLY_PRINTK)	+= sead3-console.o
-
-CFLAGS_sead3-setup.o = -I$(src)/../../../scripts/dtc/libfdt
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index c1ebbda..c16e836 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-CFLAGS_prom.o		= -I$(src)/../../../scripts/dtc/libfdt
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 280bc0a..816dbe9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -24,8 +24,6 @@ KASAN_SANITIZE			:= n
 lib-y				:= efi-stub-helper.o
 lib-$(CONFIG_EFI_ARMSTUB)	+= arm-stub.o fdt.o
 
-CFLAGS_fdt.o			+= -I$(srctree)/scripts/dtc/libfdt/
-
 #
 # arm64 puts the stub in the kernel proper, which will unnecessarily retain all
 # code indefinitely unless it is annotated as __init/__initdata/__initconst etc.
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index fcacb18..156c072 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -16,6 +16,3 @@ obj-$(CONFIG_OF_RESOLVE)  += resolver.o
 obj-$(CONFIG_OF_OVERLAY) += overlay.o
 
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
-
-CFLAGS_fdt.o = -I$(src)/../../scripts/dtc/libfdt
-CFLAGS_fdt_address.o = -I$(src)/../../scripts/dtc/libfdt
-- 
2.1.0
