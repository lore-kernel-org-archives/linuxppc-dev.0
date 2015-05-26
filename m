Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401011A190A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 10:23:46 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v2 19/21] cxl: Move include file cxl.h -> cxl-base.h
Date: Tue, 26 May 2015 10:20:16 +1000
Message-Id: <1432599618-26844-20-git-send-email-mikey@neuling.org>
In-Reply-To: <1432599618-26844-1-git-send-email-mikey@neuling.org>
References: <1432599618-26844-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the current include file from cxl.h -> cxl-base.h.  This current
include file is used only to pass information between the base driver that
needs to be built into the kernel and the cxl module.

This is to make way for a new include/misc/cxl.h which will
contain just the kernel API for other driver to use

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 MAINTAINERS                               | 2 +-
 arch/powerpc/include/asm/pnv-pci.h        | 2 +-
 arch/powerpc/mm/copro_fault.c             | 2 +-
 arch/powerpc/mm/hash_native_64.c          | 2 +-
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 drivers/misc/cxl/base.c                   | 2 +-
 drivers/misc/cxl/cxl.h                    | 2 +-
 drivers/misc/cxl/irq.c                    | 2 +-
 drivers/misc/cxl/main.c                   | 2 +-
 drivers/misc/cxl/native.c                 | 2 +-
 include/misc/{cxl.h => cxl-base.h}        | 4 ++--
 11 files changed, 12 insertions(+), 12 deletions(-)
 rename include/misc/{cxl.h => cxl-base.h} (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8e0afb..10f6001 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2956,7 +2956,7 @@ M:	Michael Neuling <mikey@neuling.org>
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Supported
 F:	drivers/misc/cxl/
-F:	include/misc/cxl.h
+F:	include/misc/cxl*
 F:	include/uapi/misc/cxl.h
 F:	Documentation/powerpc/cxl.txt
 F:	Documentation/powerpc/cxl.txt
diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
index f9b4982..6f77f71 100644
--- a/arch/powerpc/include/asm/pnv-pci.h
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -11,7 +11,7 @@
 #define _ASM_PNV_PCI_H
 
 #include <linux/pci.h>
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 
 int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode);
 int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 7a71d7f..6527882 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -26,7 +26,7 @@
 #include <asm/reg.h>
 #include <asm/copro.h>
 #include <asm/spu.h>
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 
 /*
  * This ought to be kept in sync with the powerpc specific do_page_fault
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 9c4880d..13befa35 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -29,7 +29,7 @@
 #include <asm/kexec.h>
 #include <asm/ppc-opcode.h>
 
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 
 #ifdef DEBUG_LOW
 #define DBG_LOW(fmt...) udbg_printf(fmt)
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2eaf6f7..d21ceba 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -39,7 +39,7 @@
 #include <asm/firmware.h>
 #include <asm/pnv-pci.h>
 
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 
 #include "powernv.h"
 #include "pci.h"
diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index 0654ad8..a9f0dd3 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -10,7 +10,7 @@
 #include <linux/module.h>
 #include <linux/rcupdate.h>
 #include <asm/errno.h>
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 #include "cxl.h"
 
 /* protected by rcu */
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index bbc7fd0..f3b071e 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -21,7 +21,7 @@
 #include <asm/cputable.h>
 #include <asm/mmu.h>
 #include <asm/reg.h>
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 
 #include <uapi/misc/cxl.h>
 
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 212790b..680cd26 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -14,7 +14,7 @@
 #include <linux/slab.h>
 #include <linux/pid.h>
 #include <asm/cputable.h>
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 
 #include "cxl.h"
 #include "trace.h"
diff --git a/drivers/misc/cxl/main.c b/drivers/misc/cxl/main.c
index de1b19a..403780e 100644
--- a/drivers/misc/cxl/main.c
+++ b/drivers/misc/cxl/main.c
@@ -20,7 +20,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <asm/cputable.h>
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 
 #include "cxl.h"
 #include "trace.h"
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index a4b40d7..10567f2 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -15,7 +15,7 @@
 #include <linux/mm.h>
 #include <linux/uaccess.h>
 #include <asm/synch.h>
-#include <misc/cxl.h>
+#include <misc/cxl-base.h>
 
 #include "cxl.h"
 #include "trace.h"
diff --git a/include/misc/cxl.h b/include/misc/cxl-base.h
similarity index 95%
rename from include/misc/cxl.h
rename to include/misc/cxl-base.h
index 975cc78..5ae9625 100644
--- a/include/misc/cxl.h
+++ b/include/misc/cxl-base.h
@@ -7,8 +7,8 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#ifndef _MISC_CXL_H
-#define _MISC_CXL_H
+#ifndef _MISC_CXL_BASE_H
+#define _MISC_CXL_BASE_H
 
 #ifdef CONFIG_CXL_BASE
 
-- 
2.1.0
