Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 91DD31A0A16
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 19:55:34 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v4 15/16] cxl: Add driver to Kbuild and Makefiles
Date: Wed,  8 Oct 2014 19:55:04 +1100
Message-Id: <1412758505-23495-16-git-send-email-mikey@neuling.org>
In-Reply-To: <1412758505-23495-1-git-send-email-mikey@neuling.org>
References: <1412758505-23495-1-git-send-email-mikey@neuling.org>
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
 drivers/misc/cxl/Kconfig  | 17 +++++++++++++++++
 drivers/misc/cxl/Makefile |  2 ++
 2 files changed, 19 insertions(+)

diff --git a/drivers/misc/cxl/Kconfig b/drivers/misc/cxl/Kconfig
index 5cdd319..a990b39 100644
--- a/drivers/misc/cxl/Kconfig
+++ b/drivers/misc/cxl/Kconfig
@@ -6,3 +6,20 @@ config CXL_BASE
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
+	  Select this option to enable driver support for IBM Coherent
+	  Accelerators (CXL).  CXL is otherwise known as Coherent Accelerator
+	  Processor Interface (CAPI).  CAPI allows accelerators in FPGAs to be
+	  coherently attached to a CPU via an MMU.  This driver enables
+	  userspace programs to access these accelerators via /dev/cxl/afuM.N
+	  devices.
+
+	  CAPI adapters are found in POWER8 based systems.
+
+	  If unsure, say N.
diff --git a/drivers/misc/cxl/Makefile b/drivers/misc/cxl/Makefile
index e30ad0a..165e98f 100644
--- a/drivers/misc/cxl/Makefile
+++ b/drivers/misc/cxl/Makefile
@@ -1 +1,3 @@
+cxl-y				+= main.o file.o irq.o fault.o native.o context.o sysfs.o debugfs.o pci.o
+obj-$(CONFIG_CXL)		+= cxl.o
 obj-$(CONFIG_CXL_BASE)		+= base.o
-- 
1.9.1
