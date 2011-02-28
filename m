Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 97ABF1007ED
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Mar 2011 07:52:23 +1100 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] RapidIO: Modify configuration to support PCI-SRIO
	controller
Date: Mon, 28 Feb 2011 15:51:02 -0500
Message-Id: <1298926265-5381-3-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1298926265-5381-1-git-send-email-alexandre.bounine@idt.com>
References: <1298926265-5381-1-git-send-email-alexandre.bounine@idt.com>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Ingo Molnar <mingo@redhat.com>, Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

1. Add an option to include RapidIO support if the PCI is available.
2. Add FSL_RIO configuration option to enable controller selection.
3. Add RapidIO support option into x86 and MIPS architectures.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
---
 arch/mips/Kconfig            |   10 ++++++++++
 arch/powerpc/Kconfig         |   10 +++++++++-
 arch/powerpc/sysdev/Makefile |    2 +-
 arch/x86/Kconfig             |   10 ++++++++++
 drivers/net/rionet.c         |    4 ++--
 drivers/rapidio/rio-sysfs.c  |    1 +
 6 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f5ecc05..c451163 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2336,6 +2336,16 @@ source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
 
+config RAPIDIO
+	bool "RapidIO support"
+	depends on PCI
+	default n
+	help
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
+source "drivers/rapidio/Kconfig"
+
 endmenu
 
 menu "Executable file formats"
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7d69e9b..9a7628a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -767,11 +767,19 @@ config HAS_RAPIDIO
 
 config RAPIDIO
 	bool "RapidIO support"
-	depends on HAS_RAPIDIO
+	depends on HAS_RAPIDIO || PCI
 	help
 	  If you say Y here, the kernel will include drivers and
 	  infrastructure code to support RapidIO interconnect devices.
 
+config FSL_RIO
+	bool "Freescale Embedded SRIO Controller support"
+	depends on RAPIDIO && HAS_RAPIDIO
+	default "n"
+	---help---
+	  Include support for RapidIO controller on Freescale embedded
+	  processors (MPC8548, MPC8641, etc).
+
 source "drivers/rapidio/Kconfig"
 
 endmenu
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 9c29734..1e0c933 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
 obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
 obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
-obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
+obj-$(CONFIG_FSL_RIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 obj-$(CONFIG_PPC_BESTCOMM)	+= bestcomm/
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d5ed94d..11c1dc5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2104,6 +2104,16 @@ source "drivers/pcmcia/Kconfig"
 
 source "drivers/pci/hotplug/Kconfig"
 
+config RAPIDIO
+	bool "RapidIO support"
+	depends on PCI
+	default n
+	help
+	  If you say Y here, the kernel will include drivers and
+	  infrastructure code to support RapidIO interconnect devices.
+
+source "drivers/rapidio/Kconfig"
+
 endmenu
 
 
diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index 44150f2..678e577 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -382,7 +382,7 @@ static void rionet_remove(struct rio_dev *rdev)
 	struct rionet_peer *peer, *tmp;
 
 	free_pages((unsigned long)rionet_active, rdev->net->hport->sys_size ?
-					__ilog2(sizeof(void *)) + 4 : 0);
+					__fls(sizeof(void *)) + 4 : 0);
 	unregister_netdev(ndev);
 	free_netdev(ndev);
 
@@ -450,7 +450,7 @@ static int rionet_setup_netdev(struct rio_mport *mport)
 	}
 
 	rionet_active = (struct rio_dev **)__get_free_pages(GFP_KERNEL,
-			mport->sys_size ? __ilog2(sizeof(void *)) + 4 : 0);
+			mport->sys_size ? __fls(sizeof(void *)) + 4 : 0);
 	if (!rionet_active) {
 		rc = -ENOMEM;
 		goto out;
diff --git a/drivers/rapidio/rio-sysfs.c b/drivers/rapidio/rio-sysfs.c
index 76b4185..e3ebfec 100644
--- a/drivers/rapidio/rio-sysfs.c
+++ b/drivers/rapidio/rio-sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/rio.h>
 #include <linux/rio_drv.h>
 #include <linux/stat.h>
+#include <linux/capability.h>
 
 #include "rio.h"
 
-- 
1.7.3.1
