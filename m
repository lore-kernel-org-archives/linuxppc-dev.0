Return-Path: <klebers@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E86D2C01B4
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 08:44:10 +1000 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <klebers@linux.vnet.ibm.com>;
 Fri, 3 May 2013 19:44:06 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id B01041DC006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 18:44:03 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43MfDUu704548
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 19:41:13 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43Mi2Jv007347
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 19:44:03 -0300
From: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Airlie <airlied@linux.ie>,
 Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCHv5 2/2] radeon: use max_bus_speed to activate gen2 speeds
Date: Fri,  3 May 2013 19:43:13 -0300
Message-Id: <1367620993-27037-3-git-send-email-klebers@linux.vnet.ibm.com>
In-Reply-To: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
References: <1367620993-27037-1-git-send-email-klebers@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

radeon currently uses a drm function to get the speed capabilities for
the bus, drm_pcie_get_speed_cap_mask. However, this is a non-standard
method of performing this detection and this patch changes it to use
the max_bus_speed attribute.

From: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Signed-off-by: Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>
---
 drivers/gpu/drm/radeon/evergreen.c |   10 +++-------
 drivers/gpu/drm/radeon/r600.c      |    9 ++-------
 drivers/gpu/drm/radeon/rv770.c     |    9 ++-------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 105bafb..3966696 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -4992,8 +4992,7 @@ void evergreen_fini(struct radeon_device *rdev)
 
 void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
 {
-	u32 link_width_cntl, speed_cntl, mask;
-	int ret;
+	u32 link_width_cntl, speed_cntl;
 
 	if (radeon_pcie_gen2 == 0)
 		return;
@@ -5008,11 +5007,8 @@ void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
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
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 1a08008..b45e648 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -4631,8 +4631,6 @@ static void r600_pcie_gen2_enable(struct radeon_device *rdev)
 {
 	u32 link_width_cntl, lanes, speed_cntl, training_cntl, tmp;
 	u16 link_cntl2;
-	u32 mask;
-	int ret;
 
 	if (radeon_pcie_gen2 == 0)
 		return;
@@ -4651,11 +4649,8 @@ static void r600_pcie_gen2_enable(struct radeon_device *rdev)
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
 
 	speed_cntl = RREG32_PCIE_PORT(PCIE_LC_SPEED_CNTL);
diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
index 83f612a..a6af4aa 100644
--- a/drivers/gpu/drm/radeon/rv770.c
+++ b/drivers/gpu/drm/radeon/rv770.c
@@ -2113,8 +2113,6 @@ static void rv770_pcie_gen2_enable(struct radeon_device *rdev)
 {
 	u32 link_width_cntl, lanes, speed_cntl, tmp;
 	u16 link_cntl2;
-	u32 mask;
-	int ret;
 
 	if (radeon_pcie_gen2 == 0)
 		return;
@@ -2129,11 +2127,8 @@ static void rv770_pcie_gen2_enable(struct radeon_device *rdev)
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
1.7.1
