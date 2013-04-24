Return-Path: <lucaskt@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8FAD2C0181
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 08:55:39 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <lucaskt@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 19:55:36 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 984613520055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 18:55:33 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3OMqpee2539628
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:52:51 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3OMtWnv020181
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:55:33 -0300
From: lucaskt@linux.vnet.ibm.com
To: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "David Airlie <airlied@linux.ie> Michael Ellerman" <michael@ellerman.id.au>
Subject: [PATCHv4 2/2] radeon: use max_bus_speed to activate gen2 speeds
Date: Wed, 24 Apr 2013 19:54:50 -0300
Message-Id: <1366844090-5492-3-git-send-email-lucaskt@linux.vnet.ibm.com>
In-Reply-To: <1366844090-5492-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1366844090-5492-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Cc: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>

radeon currently uses a drm function to get the speed capabilities for
the bus, drm_pcie_get_speed_cap_mask. However, this is a non-standard 
method of performing this detection and this patch changes it to use 
the max_bus_speed attribute.

Signed-off-by: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
---
 drivers/gpu/drm/radeon/evergreen.c | 10 +++-------
 drivers/gpu/drm/radeon/r600.c      |  9 ++-------
 drivers/gpu/drm/radeon/rv770.c     |  9 ++-------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 305a657..ee45026 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -3855,8 +3855,7 @@ void evergreen_fini(struct radeon_device *rdev)
 
 void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
 {
-	u32 link_width_cntl, speed_cntl, mask;
-	int ret;
+	u32 link_width_cntl, speed_cntl;
 
 	if (radeon_pcie_gen2 == 0)
 		return;
@@ -3871,11 +3870,8 @@ void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
 	if (ASIC_IS_X2(rdev))
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
-	if (ret != 0)
-		return;
-
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if ((rdev->pdev->bus->max_bus_speed != PCIE_SPEED_5_0GT) &&
+		(rdev->pdev->bus->max_bus_speed != PCIE_SPEED_8_0GT))
 		return;
 
 	speed_cntl = RREG32_PCIE_P(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 0740db3..4d5ba32 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -4351,8 +4351,6 @@ static void r600_pcie_gen2_enable(struct radeon_device *rdev)
 {
 	u32 link_width_cntl, lanes, speed_cntl, training_cntl, tmp;
 	u16 link_cntl2;
-	u32 mask;
-	int ret;
 
 	if (radeon_pcie_gen2 == 0)
 		return;
@@ -4371,11 +4369,8 @@ static void r600_pcie_gen2_enable(struct radeon_device *rdev)
 	if (rdev->family <= CHIP_R600)
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
-	if (ret != 0)
-		return;
-
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if ((rdev->pdev->bus->max_bus_speed != PCIE_SPEED_5_0GT) &&
+		(rdev->pdev->bus->max_bus_speed != PCIE_SPEED_8_0GT))
 		return;
 
 	speed_cntl = RREG32_PCIE_P(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index d63fe1d..f4860f6 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -1238,8 +1238,6 @@ static void rv770_pcie_gen2_enable(struct radeon_device *rdev)
 {
 	u32 link_width_cntl, lanes, speed_cntl, tmp;
 	u16 link_cntl2;
-	u32 mask;
-	int ret;
 
 	if (radeon_pcie_gen2 == 0)
 		return;
@@ -1254,11 +1252,8 @@ static void rv770_pcie_gen2_enable(struct radeon_device *rdev)
 	if (ASIC_IS_X2(rdev))
 		return;
 
-	ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
-	if (ret != 0)
-		return;
-
-	if (!(mask & DRM_PCIE_SPEED_50))
+	if ((rdev->pdev->bus->max_bus_speed != PCIE_SPEED_5_0GT) &&
+		(rdev->pdev->bus->max_bus_speed != PCIE_SPEED_8_0GT))
 		return;
 
 	DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
-- 
1.8.1.4
