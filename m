Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2D0C1A081F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 15:03:49 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 21 May 2014 15:03:49 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B8A632CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 15:03:46 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4L4gKfI53477380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 14:42:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4L53jjB028094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 May 2014 15:03:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH v5 1/4] drivers/vfio: Introduce CONFIG_VFIO_PCI_EEH
Date: Wed, 21 May 2014 15:03:40 +1000
Message-Id: <1400648623-9127-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1400648623-9127-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1400648623-9127-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
