Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C62712C0089
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 17:13:58 +1100 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 11 Jan 2014 23:13:55 -0700
Received: from b03cxnp07027.gho.boulder.ibm.com
 (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0B7D13E40026
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Jan 2014 23:13:54 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0C6Deuc5243272
 for <linuxppc-dev@ozlabs.org>; Sun, 12 Jan 2014 07:13:40 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0C6DrYL011486
 for <linuxppc-dev@ozlabs.org>; Sat, 11 Jan 2014 23:13:53 -0700
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] powerpc/eeh: Hotplug improvement
Date: Sun, 12 Jan 2014 14:13:45 +0800
Message-Id: <1389507226-32002-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1389507226-32002-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1389507226-32002-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When EEH error comes to one specific PCI device before its driver
is loaded, we will apply hotplug to recover the error. During the
plug time, the PCI device will be probed and its driver is loaded.
Then we wrongly calls to the error handlers if the driver supports
EEH explicitly.

The patch intends to fix by introducing flag EEH_DEV_NO_HANDLER and
set it before we remove the PCI device. In turn, we can avoid wrongly
calls the error handlers of the PCI device after its driver loaded.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h   |    3 ++-
 arch/powerpc/kernel/eeh.c        |   15 +++++++++++++++
 arch/powerpc/kernel/eeh_driver.c |   10 +++++++---
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index e37db7f..8e31dad 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -90,7 +90,8 @@ struct eeh_pe {
 #define EEH_DEV_IRQ_DISABLED	(1 << 3)	/* Interrupt disabled	*/
 #define EEH_DEV_DISCONNECTED	(1 << 4)	/* Removing from PE	*/
 
-#define EEH_DEV_SYSFS		(1 << 8)	/* Sysfs created        */
+#define EEH_DEV_NO_HANDLER	(1 << 8)	/* No error handler	*/
+#define EEH_DEV_SYSFS		(1 << 9)	/* Sysfs created	*/
 
 struct eeh_dev {
 	int mode;			/* EEH mode			*/
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 4bd687d..6a118db 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -921,6 +921,13 @@ void eeh_add_device_late(struct pci_dev *dev)
 		eeh_sysfs_remove_device(edev->pdev);
 		edev->mode &= ~EEH_DEV_SYSFS;
 
+		/*
+		 * We definitely should have the PCI device removed
+		 * though it wasn't correctly. So we needn't call
+		 * into error handler afterwards.
+		 */
+		edev->mode |= EEH_DEV_NO_HANDLER;
+
 		edev->pdev = NULL;
 		dev->dev.archdata.edev = NULL;
 	}
@@ -1023,6 +1030,14 @@ void eeh_remove_device(struct pci_dev *dev)
 	else
 		edev->mode |= EEH_DEV_DISCONNECTED;
 
+	/*
+	 * We're removing from the PCI subsystem, that means
+	 * the PCI device driver can't support EEH or not
+	 * well. So we rely on hotplug completely to do recovery
+	 * for the specific PCI device.
+	 */
+	edev->mode |= EEH_DEV_NO_HANDLER;
+
 	eeh_addr_cache_rmv_dev(dev);
 	eeh_sysfs_remove_device(dev);
 	edev->mode &= ~EEH_DEV_SYSFS;
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index c1e8bb9..fe102c3 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -217,7 +217,8 @@ static void *eeh_report_mmio_enabled(void *data, void *userdata)
 	if (!driver) return NULL;
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->mmio_enabled) {
+	    !driver->err_handler->mmio_enabled ||
+	    (edev->mode & EEH_DEV_NO_HANDLER)) {
 		eeh_pcid_put(dev);
 		return NULL;
 	}
@@ -258,7 +259,8 @@ static void *eeh_report_reset(void *data, void *userdata)
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->slot_reset) {
+	    !driver->err_handler->slot_reset ||
+	    (edev->mode & EEH_DEV_NO_HANDLER)) {
 		eeh_pcid_put(dev);
 		return NULL;
 	}
@@ -297,7 +299,9 @@ static void *eeh_report_resume(void *data, void *userdata)
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->resume) {
+	    !driver->err_handler->resume ||
+	    (edev->mode & EEH_DEV_NO_HANDLER)) {
+		edev->mode &= ~EEH_DEV_NO_HANDLER;
 		eeh_pcid_put(dev);
 		return NULL;
 	}
-- 
1.7.10.4
