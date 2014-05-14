Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D438D14008B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:10 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 14 May 2014 14:12:08 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 81E503578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:05 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4E3ocbB40960148
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 13:50:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4E4C4HE022802
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 May 2014 14:12:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 1/8] drivers/vfio: Introduce CONFIG_VFIO_EEH
Date: Wed, 14 May 2014 14:11:55 +1000
Message-Id: <1400040722-29608-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400040722-29608-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, agraf@suse.de, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch introduces CONFIG_VFIO_EEH for more IOCTL commands on
tce_iommu_driver_ops to support EEH funtionality for PCI devices
that are passed through from host to guest.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/vfio/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
index af7b204..4f3293b 100644
--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -8,11 +8,17 @@ config VFIO_IOMMU_SPAPR_TCE
 	depends on VFIO && SPAPR_TCE_IOMMU
 	default n
 
+config VFIO_EEH
+	tristate
+	depends on EEH && VFIO_IOMMU_SPAPR_TCE
+	default n
+
 menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
 	select VFIO_IOMMU_TYPE1 if X86
 	select VFIO_IOMMU_SPAPR_TCE if (PPC_POWERNV || PPC_PSERIES)
+	select VFIO_EEH if PPC_POWERNV
 	select ANON_INODES
 	help
 	  VFIO provides a framework for secure userspace device drivers.
-- 
1.8.3.2
