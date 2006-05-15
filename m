Return-Path: <schihei@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3EDC681B7
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 03:43:07 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.6/8.13.6) with ESMTP id k4FHh2Y3076296
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 17:43:02 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k4FHiSvT137766
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 19:44:28 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	k4FHh1TY026504
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 19:43:02 +0200
Message-ID: <4468BDBF.6060703@de.ibm.com>
Date: Mon, 15 May 2006 19:43:27 +0200
From: Heiko J Schick <schihei@de.ibm.com>
MIME-Version: 1.0
To: openib-general@openib.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>,
	schihei@de.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 16/16] ehca: integration in Linux kernel build system
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


  drivers/infiniband/hw/ehca/Kconfig  |    6 ++++++
  drivers/infiniband/hw/ehca/Makefile |   16 ++++++++++++++++
  2 files changed, 22 insertions(+)



--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Kconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Kconfig	2006-04-28 13:32:08.000000000 +0200
@@ -0,0 +1,6 @@
+config INFINIBAND_EHCA
+       tristate "eHCA support"
+       depends on IBMEBUS && INFINIBAND
+       ---help---
+       This is a low level device driver for the IBM
+       GX based Host channel adapters (HCAs)
--- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/Makefile	2006-04-28 13:31:25.000000000 +0200
@@ -0,0 +1,16 @@
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
+hcad_mod-objs = ehca_main.o ehca_hca.o ehca_mcast.o ehca_pd.o ehca_av.o ehca_eq.o \
+		ehca_cq.o ehca_qp.o ehca_sqp.o ehca_mrmw.o ehca_reqs.o ehca_irq.o \
+		ehca_uverbs.o hcp_if.o hcp_phyp.o ipz_pt_fn.o
+
+CFLAGS += -DEHCA_USE_HCALL -DEHCA_USE_HCALL_KERNEL
