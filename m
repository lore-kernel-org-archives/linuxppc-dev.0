Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 20AE61400CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:50 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 9 May 2014 17:49:49 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 639383578054
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 May 2014 17:49:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s497SPuk64225298
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:28:25 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s497nita012608
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 May 2014 17:49:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 01/10] drivers/vfio: Introduce CONFIG_VFIO_EEH
Date: Fri,  9 May 2014 17:49:33 +1000
Message-Id: <1399621782-23281-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1399621782-23281-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, alex.williamson@redhat.com, qiudayu@linux.vnet.ibm.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
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
