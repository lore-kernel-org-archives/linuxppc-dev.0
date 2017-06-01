Return-Path: <rashmica.g@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdbdS47MxzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 15:34:52 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id w69so6541445pfk.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 22:34:52 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, anton@samba.org,
 npiggin@gmail.com, bsingharora@gmail.com, oohall@gmail.com,
 khandual@linux.vnet.ibm.com
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Subject: [PATCH v3 1/3] powerpc/powernv: Add config option for removal of
 memory
Date: Thu,  1 Jun 2017 15:34:38 +1000
Message-Id: <20170601053440.28976-1-rashmica.g@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the config option to enable the removal
of memory from the kernel mappings at runtime. This needs
to be enabled for the hardware trace macro to work.

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
v2 -> v3: Better description

 arch/powerpc/platforms/powernv/Kconfig  | 8 ++++++++
 arch/powerpc/platforms/powernv/Makefile | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/Kconfig b/arch/powerpc/platforms/powernv/Kconfig
index 6a6f4ef..92493d6 100644
--- a/arch/powerpc/platforms/powernv/Kconfig
+++ b/arch/powerpc/platforms/powernv/Kconfig
@@ -30,3 +30,11 @@ config OPAL_PRD
 	help
 	  This enables the opal-prd driver, a facility to run processor
 	  recovery diagnostics on OpenPower machines
+
+config PPC64_HARDWARE_TRACING
+	bool "Enable removal of RAM from kernel mappings for tracing"
+	help
+	  Enabling this option allows for the removal of memory (RAM)
+	  from the kernel mappings to be used for hardware tracing.
+	depends on MEMORY_HOTREMOVE
+	default n
diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index b5d98cb..8fb026d 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
 obj-$(CONFIG_TRACEPOINTS)	+= opal-tracepoints.o
 obj-$(CONFIG_OPAL_PRD)	+= opal-prd.o
+obj-$(CONFIG_PPC64_HARDWARE_TRACING)	+= memtrace.o
-- 
2.9.3
