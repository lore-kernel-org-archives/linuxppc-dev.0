Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E640B1A0860
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:24 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 20 May 2014 18:30:23 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2EF502CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:20 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K8U4xJ7405854
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:04 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K8UJW4012090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 18:30:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 1/4] drivers/vfio: Introduce CONFIG_VFIO_PCI_EEH
Date: Tue, 20 May 2014 18:30:09 +1000
Message-Id: <1400574612-19411-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400574612-19411-1-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch introduces CONFIG_VFIO_PCI_EEH for more IOCTL commands
on VFIO PCI device support EEH funtionality for PCI devices that
are passed through from host to guest.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/vfio/pci/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index c41b01e..dd0e0f0 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -1,6 +1,7 @@
 config VFIO_PCI
 	tristate "VFIO support for PCI devices"
 	depends on VFIO && PCI && EVENTFD
+	select VFIO_PCI_EEH if PPC_POWERNV
 	help
 	  Support for the PCI VFIO bus driver.  This is required to make
 	  use of PCI drivers using the VFIO framework.
@@ -16,3 +17,8 @@ config VFIO_PCI_VGA
 	  BIOS and generic video drivers.
 
 	  If you don't know what to do here, say N.
+
+config VFIO_PCI_EEH
+	tristate
+	depends on EEH && VFIO_IOMMU_SPAPR_TCE
+	default n
-- 
1.8.3.2
