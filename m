Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 229AC1A0A23
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 20:35:51 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v2 16/17] cxl: Add driver to Kbuild and Makefiles
Date: Tue, 30 Sep 2014 20:35:05 +1000
Message-Id: <1412073306-13812-17-git-send-email-mikey@neuling.org>
In-Reply-To: <1412073306-13812-1-git-send-email-mikey@neuling.org>
References: <1412073306-13812-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/Kconfig  | 18 ++++++++++++++++++
 drivers/misc/cxl/Makefile |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index 5cdd319..967b5c8 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -6,3 +6,21 @@ config CXL_BASE
 	bool
 	default n
 	select PPC_COPRO_BASE
+
+config CXL
+	tristate "Support for IBM Coherent Accelerators (CXL)"
+	depends on PPC_POWERNV && PCI_MSI
+	select CXL_BASE
+	default m
+	help
+	  Select this option to enable userspace driver support for IBM
+	  Coherent Accelerators (CXL).  CXL is otherwise known as Coherent
+	  Accelerator Processor Interface (CAPI).
+
+config CXL_PCI
+	tristate "Support for CXL devices via PCI"
+	depends on CXL && PPC_POWERNV
+	default y
+	help
+	  Select this option to support CXL devices detected via PCI, e.g.
+	  when running under powernv/OPAL.
diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index e30ad0a..96f292b 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1 +1,4 @@
+cxl-y				+= main.o file.o irq.o fault.o native.o context.o sysfs.o debugfs.o
+obj-$(CONFIG_CXL)		+= cxl.o
+obj-$(CONFIG_CXL_PCI)		+= cxl-pci.o
 obj-$(CONFIG_CXL_BASE)		+= base.o
-- 
1.9.1
