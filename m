Return-Path: <lucaskt@linux.vnet.ibm.com>
Received: from e24smtp03.br.ibm.com (e24smtp03.br.ibm.com [32.104.18.24])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp03.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 586032C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 16:25:18 +1100 (EST)
Received: from /spool/local
 by e24smtp03.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lucaskt@linux.vnet.ibm.com>;
 Wed, 20 Mar 2013 02:25:12 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 420923520055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 01:25:06 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2K5OHZr31129614
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 02:24:17 -0300
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2K5P49I029743
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 02:25:05 -0300
From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCHv2 2/3] drm: removed drm_pcie_get_speed_cap_mask function
Date: Wed, 20 Mar 2013 02:24:38 -0300
Message-Id: <1363757079-23550-3-git-send-email-lucaskt@linux.vnet.ibm.com>
In-Reply-To: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: David Airlie <airlied@linux.ie>, Brian King <brking@linux.vnet.ibm.com>,
 Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Deucher <alexander.deucher@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function was moved to the pci subsystem where it fits better, as
this is much more of a generic pci task, than a drm specific one. All
references to the function (all in the radeon driver) are updated.

This is the second step in moving function drm_pcie_get_speed_cap_mask
from the drm subsystem to the pci one.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
 drivers/gpu/drm/drm_pci.c          |   38 ------------------------------------
 drivers/gpu/drm/radeon/evergreen.c |    5 ++-
 drivers/gpu/drm/radeon/r600.c      |    5 ++-
 drivers/gpu/drm/radeon/rv770.c     |    5 ++-
 include/drm/drmP.h                 |    6 -----
 5 files changed, 9 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index bd719e9..ba70844 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -439,44 +439,6 @@ int drm_pci_init(struct drm_driver *driver, struct pci_driver *pdriver)
 	return 0;
 }
 
-int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *mask)
-{
-	struct pci_dev *root;
-	u32 lnkcap, lnkcap2;
-
-	*mask = 0;
-	if (!dev->pdev)
-		return -EINVAL;
-
-	root = dev->pdev->bus->self;
-
-	/* we've been informed via and serverworks don't make the cut */
-	if (root->vendor == PCI_VENDOR_ID_VIA ||
-	    root->vendor == PCI_VENDOR_ID_SERVERWORKS)
-		return -EINVAL;
-
-	pcie_capability_read_dword(root, PCI_EXP_LNKCAP, &lnkcap);
-	pcie_capability_read_dword(root, PCI_EXP_LNKCAP2, &lnkcap2);
-
-	if (lnkcap2) {	/* PCIe r3.0-compliant */
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_2_5GB)
-			*mask |= DRM_PCIE_SPEED_25;
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_5_0GB)
-			*mask |= DRM_PCIE_SPEED_50;
-		if (lnkcap2 & PCI_EXP_LNKCAP2_SLS_8_0GB)
-			*mask |= DRM_PCIE_SPEED_80;
-	} else {	/* pre-r3.0 */
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_2_5GB)
-			*mask |= DRM_PCIE_SPEED_25;
-		if (lnkcap & PCI_EXP_LNKCAP_SLS_5_0GB)
-			*mask |= (DRM_PCIE_SPEED_25 | DRM_PCIE_SPEED_50);
-	}
-
-	DRM_INFO("probing gen 2 caps for device %x:%x = %x/%x\n", root->vendor, root->device, lnkcap, lnkcap2);
-	return 0;
-}
-EXPORT_SYMBOL(drm_pcie_get_speed_cap_mask);
-
 #else
 
 int drm_pci_init(struct drm_driver *driver, struct pci_driver *pdriver)
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 305a657..6ba204d 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <drm/drmP.h>
 #include "radeon.h"
 #include "radeon_asic.h"
@@ -3871,11 +3872,11 @@ void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
 	if (ASIC_IS_X2(rdev))
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
+	ret = pcie_get_speed_cap_mask(rdev->ddev->pdev, &mask);
 	if (ret != 0)
 		return;
 
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if (!(mask & PCIE_SPEED_50))
 		return;
 
 	speed_cntl = RREG32_PCIE_P(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 0740db3..89a7387 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -30,6 +30,7 @@
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <drm/drmP.h>
 #include <drm/radeon_drm.h>
 #include "radeon.h"
@@ -4371,11 +4372,11 @@ static void r600_pcie_gen2_enable(struct radeon_device *rdev)
 	if (rdev->family <= CHIP_R600)
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
+	ret = pcie_get_speed_cap_mask(rdev->ddev->pdev, &mask);
 	if (ret != 0)
 		return;
 
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if (!(mask & PCIE_SPEED_50))
 		return;
 
 	speed_cntl = RREG32_PCIE_P(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index d63fe1d..81c7f1c 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -28,6 +28,7 @@
 #include <linux/firmware.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <drm/drmP.h>
 #include "radeon.h"
 #include "radeon_asic.h"
@@ -1254,11 +1255,11 @@ static void rv770_pcie_gen2_enable(struct radeon_device *rdev)
 	if (ASIC_IS_X2(rdev))
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
+	ret = pcie_get_speed_cap_mask(rdev->ddev->pdev, &mask);
 	if (ret != 0)
 		return;
 
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if (!(mask & PCIE_SPEED_50))
 		return;
 
 	DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index 2d94d74..39b2872 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -1788,12 +1788,6 @@ extern int drm_get_pci_dev(struct pci_dev *pdev,
 			   const struct pci_device_id *ent,
 			   struct drm_driver *driver);
 
-#define DRM_PCIE_SPEED_25 1
-#define DRM_PCIE_SPEED_50 2
-#define DRM_PCIE_SPEED_80 4
-
-extern int drm_pcie_get_speed_cap_mask(struct drm_device *dev, u32 *speed_mask);
-
 /* platform section */
 extern int drm_platform_init(struct drm_driver *driver, struct platform_device *platform_device);
 extern void drm_platform_exit(struct drm_driver *driver, struct platform_device *platform_device);
-- 
1.7.4.4
