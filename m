Return-Path: <bhelgaas@google.com>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com
 [IPv6:2607:f8b0:4003:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AC181A091D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 07:50:02 +1000 (AEST)
Received: by oihb142 with SMTP id b142so40743896oih.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jun 2015 14:50:00 -0700 (PDT)
Subject: [PATCH 5/7] PCI: Remove unnecessary #includes of <asm/pci.h>
To: linux-pci@vger.kernel.org
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-alpha@vger.kernel.org
Date: Thu, 04 Jun 2015 16:49:57 -0500
Message-ID: <20150604214957.2399.66129.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150604214614.2399.5142.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In include/linux/pci.h, we already #include <asm/pci.h>, so we don't need
to include <asm/pci.h> directly.

Remove the unnecessary includes.  All the files here already include
<linux/pci.h>.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: linux-alpha@vger.kernel.org
CC: linux-mips@linux-mips.org
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-sh@vger.kernel.org
CC: x86@kernel.org
---
 arch/alpha/kernel/core_irongate.c |    1 -
 arch/alpha/kernel/sys_eiger.c     |    1 -
 arch/alpha/kernel/sys_nautilus.c  |    1 -
 arch/mips/pci/fixup-cobalt.c      |    1 -
 arch/mips/pci/ops-mace.c          |    1 -
 arch/mips/pci/pci-lantiq.c        |    1 -
 arch/powerpc/kernel/prom.c        |    1 -
 arch/powerpc/kernel/prom_init.c   |    1 -
 arch/sh/drivers/pci/ops-sh5.c     |    1 -
 arch/sh/drivers/pci/pci-sh5.c     |    1 -
 arch/x86/kernel/x86_init.c        |    1 -
 11 files changed, 11 deletions(-)

diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 00096df..83d0a35 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -22,7 +22,6 @@
 #include <linux/bootmem.h>
 
 #include <asm/ptrace.h>
-#include <asm/pci.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
diff --git a/arch/alpha/kernel/sys_eiger.c b/arch/alpha/kernel/sys_eiger.c
index 79d69d7..15f4208 100644
--- a/arch/alpha/kernel/sys_eiger.c
+++ b/arch/alpha/kernel/sys_eiger.c
@@ -22,7 +22,6 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
-#include <asm/pci.h>
 #include <asm/pgtable.h>
 #include <asm/core_tsunami.h>
 #include <asm/hwrpb.h>
diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 700686d..2cfaa0e 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -39,7 +39,6 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
-#include <asm/pci.h>
 #include <asm/pgtable.h>
 #include <asm/core_irongate.h>
 #include <asm/hwrpb.h>
diff --git a/arch/mips/pci/fixup-cobalt.c b/arch/mips/pci/fixup-cobalt.c
index a138e8e..b3ab593 100644
--- a/arch/mips/pci/fixup-cobalt.c
+++ b/arch/mips/pci/fixup-cobalt.c
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <asm/pci.h>
 #include <asm/io.h>
 #include <asm/gt64120.h>
 
diff --git a/arch/mips/pci/ops-mace.c b/arch/mips/pci/ops-mace.c
index 6b5821f..951d807 100644
--- a/arch/mips/pci/ops-mace.c
+++ b/arch/mips/pci/ops-mace.c
@@ -8,7 +8,6 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/types.h>
-#include <asm/pci.h>
 #include <asm/ip32/mace.h>
 
 #if 0
diff --git a/arch/mips/pci/pci-lantiq.c b/arch/mips/pci/pci-lantiq.c
index 8b117e6..c5347d9 100644
--- a/arch/mips/pci/pci-lantiq.c
+++ b/arch/mips/pci/pci-lantiq.c
@@ -20,7 +20,6 @@
 #include <linux/of_irq.h>
 #include <linux/of_pci.h>
 
-#include <asm/pci.h>
 #include <asm/gpio.h>
 #include <asm/addrspace.h>
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 308c5e1..00fdea2 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -46,7 +46,6 @@
 #include <asm/mmu.h>
 #include <asm/paca.h>
 #include <asm/pgtable.h>
-#include <asm/pci.h>
 #include <asm/iommu.h>
 #include <asm/btext.h>
 #include <asm/sections.h>
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index fd1fe4c..fcca807 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -37,7 +37,6 @@
 #include <asm/smp.h>
 #include <asm/mmu.h>
 #include <asm/pgtable.h>
-#include <asm/pci.h>
 #include <asm/iommu.h>
 #include <asm/btext.h>
 #include <asm/sections.h>
diff --git a/arch/sh/drivers/pci/ops-sh5.c b/arch/sh/drivers/pci/ops-sh5.c
index 4ce95a0..4536194 100644
--- a/arch/sh/drivers/pci/ops-sh5.c
+++ b/arch/sh/drivers/pci/ops-sh5.c
@@ -18,7 +18,6 @@
 #include <linux/delay.h>
 #include <linux/types.h>
 #include <linux/irq.h>
-#include <asm/pci.h>
 #include <asm/io.h>
 #include "pci-sh5.h"
 
diff --git a/arch/sh/drivers/pci/pci-sh5.c b/arch/sh/drivers/pci/pci-sh5.c
index 16c1e72..8229114 100644
--- a/arch/sh/drivers/pci/pci-sh5.c
+++ b/arch/sh/drivers/pci/pci-sh5.c
@@ -20,7 +20,6 @@
 #include <linux/types.h>
 #include <linux/irq.h>
 #include <cpu/irq.h>
-#include <asm/pci.h>
 #include <asm/io.h>
 #include "pci-sh5.h"
 
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 234b072..eed5625 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -11,7 +11,6 @@
 #include <asm/bios_ebda.h>
 #include <asm/paravirt.h>
 #include <asm/pci_x86.h>
-#include <asm/pci.h>
 #include <asm/mpspec.h>
 #include <asm/setup.h>
 #include <asm/apic.h>
