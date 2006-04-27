Return-Path: <schihei@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0474667A06
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 20:45:23 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.6/8.13.6) with ESMTP id k3RAjJAb100618
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 10:45:19 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k3RAk4cJ053910
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 11:46:04 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11/8.13.3) with ESMTP id
	k3RAjIpN012284
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 11:45:18 +0100
Message-ID: <4450B384.4020601@de.ibm.com>
Date: Thu, 27 Apr 2006 14:05:24 +0200
From: Heiko J Schick <schihei@de.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Marcus Eder <MEDER@de.ibm.com>,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, schickhj@de.ibm.com
Subject: [PATCH 01/16] ehca: integration in Linux kernel	build system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>


  Kconfig  |    6 ++++++
  Makefile |   29 +++++++++++++++++++++++++++++
  2 files changed, 35 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Kconfig	2006-01-04 16:29:05.000000000 +0100
@@ -0,0 +1,6 @@
+config INFINIBAND_EHCA
+       tristate "eHCA support"
+       depends on IBMEBUS && INFINIBAND
+       ---help---
+       This is a low level device driver for the IBM
+       GX based Host channel adapters (HCAs)
\ No newline at end of file
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Makefile	2006-03-06 12:26:36.000000000 +0100
@@ -0,0 +1,29 @@
+#  Authors: Heiko J Schick <schickhj@de.ibm.com>
+#           Christoph Raisch <raisch@de.ibm.com>
+#
+#  Copyright (c) 2005 IBM Corporation
+#
+#  All rights reserved.
+#
+#  This source code is distributed under a dual license of GPL v2.0 and OpenIB BSD.
+
+obj-$(CONFIG_INFINIBAND_EHCA) += hcad_mod.o
+
+hcad_mod-objs = ehca_main.o   \
+		ehca_hca.o    \
+		ehca_mcast.o  \
+		ehca_pd.o     \
+		ehca_av.o     \
+		ehca_eq.o     \
+		ehca_cq.o     \
+		ehca_qp.o     \
+		ehca_sqp.o    \
+		ehca_mrmw.o   \
+		ehca_reqs.o   \
+		ehca_irq.o    \
+		ehca_uverbs.o \
+		hcp_if.o      \
+		hcp_phyp.o    \
+		ipz_pt_fn.o
+
+CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL
