Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19FCD1A0B6E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:38:49 +1100 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 378941400AB
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 16:38:47 +1100 (EST)
Message-ID: <1412656686.30859.121.camel@pasglop>
Subject: [PATCH v3 3/7] gpu/radeon: Set flag to indicate broken 64-bit MSI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Deucher <alexdeucher@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 07 Oct 2014 15:38:06 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Anton Blanchard <anton@au1.ibm.com>,
 Yijing Wang <wangyijing@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 Brian King <brking@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some radeon ASICs don't support all 64 address bits of MSIs despite
advertising support for 64-bit MSIs in their configuration space.

This breaks on systems such as IBM POWER7/8, where 64-bit MSIs can
be assigned with some of the high address bits set.

This makes use of the newly introduced "no_64bit_msi" flag in structure
pci_dev to allow the MSI allocation code to fallback to 32-bit MSIs
on those adapters.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
CC: <stable@vger.kernel.org>
---

Adding Alex's review tag. Patch to the driver is identical to the
reviewed one, I dropped the arch/powerpc hunk rewrote the subject
and cset comment.
---
 drivers/gpu/drm/radeon/radeon_irq_kms.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/radeon/radeon_irq_kms.c
index 16807af..c74f12d 100644
--- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
@@ -202,6 +202,16 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
 	if (rdev->flags & RADEON_IS_AGP)
 		return false;
 
+	/*
+	 * Older chips have a HW limitation, they can only generate 40 bits
+	 * of address for "64-bit" MSIs which breaks on some platforms, notably
+	 * IBM POWER servers, so we limit them
+	 */
+	if (rdev->family < CHIP_BONAIRE) {
+		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
+		rdev->pdev->no_64bit_msi = 1;
+	}
+
 	/* force MSI on */
 	if (radeon_msi == 1)
 		return true;
