Return-Path: <rolandd@cisco.com>
Received: from sj-iport-2.cisco.com (sj-iport-2-in.cisco.com [171.71.176.71])
	by ozlabs.org (Postfix) with ESMTP id 26C0467C4F
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 06:21:21 +1000 (EST)
Subject: [PATCH 13/13] IB/ehca: makefiles/kconfig
In-Reply-To: <20068171311.P1OwgyzMAlKlrkeW@cisco.com>
Date: Thu, 17 Aug 2006 13:11:02 -0700
Message-Id: <20068171311.WDFBWw0F6z9B3Qes@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: openib-general@openib.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
From: Roland Dreier <rolandd@cisco.com>
Cc: RAISCH@de.ibm.com, HNGUYEN@de.ibm.com, MEDER@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 drivers/infiniband/Kconfig          |    1 +
 drivers/infiniband/Makefile         |    1 +
 drivers/infiniband/hw/ehca/Kconfig  |   12 ++++++++++++
 drivers/infiniband/hw/ehca/Makefile |   18 ++++++++++++++++++
 4 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 69a53d4..fd2d528 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -36,6 +36,7 @@ config INFINIBAND_ADDR_TRANS
 
 source "drivers/infiniband/hw/mthca/Kconfig"
 source "drivers/infiniband/hw/ipath/Kconfig"
+source "drivers/infiniband/hw/ehca/Kconfig"
 
 source "drivers/infiniband/ulp/ipoib/Kconfig"
 
diff --git a/drivers/infiniband/Makefile b/drivers/infiniband/Makefile
index c7ff58c..893bee0 100644
--- a/drivers/infiniband/Makefile
+++ b/drivers/infiniband/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_INFINIBAND)		+= core/
 obj-$(CONFIG_INFINIBAND_MTHCA)		+= hw/mthca/
 obj-$(CONFIG_IPATH_CORE)		+= hw/ipath/
+obj-$(CONFIG_INFINIBAND_EHCA)		+= hw/ehca/
 obj-$(CONFIG_INFINIBAND_IPOIB)		+= ulp/ipoib/
 obj-$(CONFIG_INFINIBAND_SRP)		+= ulp/srp/
 obj-$(CONFIG_INFINIBAND_ISER)		+= ulp/iser/
diff --git a/drivers/infiniband/hw/ehca/Kconfig b/drivers/infiniband/hw/ehca/Kconfig
new file mode 100644
index 0000000..12285d0
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/Kconfig
@@ -0,0 +1,12 @@
+config INFINIBAND_EHCA
+       tristate "eHCA support"
+       depends on IBMEBUS && INFINIBAND
+       ---help---
+       This is a low level device driver for the IBM GX based Host channel
+       adapters (HCAs).
+
+config INFINIBAND_EHCA_SCALING
+	bool "Scaling support (EXPERIMENTAL)"
+	depends on IBMEBUS && INFINIBAND_EHCA && HOTPLUG_CPU && EXPERIMENTAL
+	---help---
+	eHCA scaling support schedules the CQ callbacks to different CPUs.
diff --git a/drivers/infiniband/hw/ehca/Makefile b/drivers/infiniband/hw/ehca/Makefile
new file mode 100644
index 0000000..70032cf
--- /dev/null
+++ b/drivers/infiniband/hw/ehca/Makefile
@@ -0,0 +1,18 @@
+#  Authors: Heiko J Schick <schickhj@de.ibm.com>
+#           Christoph Raisch <raisch@de.ibm.com>
+#           Joachim Fenkes <fenkes@de.ibm.com>
+#
+#  Copyright (c) 2005 IBM Corporation
+#
+#  All rights reserved.
+#
+#  This source code is distributed under a dual license of GPL v2.0 and OpenIB BSD.
+
+obj-$(CONFIG_INFINIBAND_EHCA) += hcad_mod.o
+
+
+hcad_mod-objs  = ehca_main.o ehca_hca.o ehca_mcast.o ehca_pd.o ehca_av.o ehca_eq.o \
+		 ehca_cq.o ehca_qp.o ehca_sqp.o ehca_mrmw.o ehca_reqs.o ehca_irq.o \
+		 ehca_uverbs.o ipz_pt_fn.o hcp_if.o hcp_phyp.o
+
+CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL
-- 
1.4.1
