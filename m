Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D67DB6F10
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Aug 2010 01:16:00 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: gregkh@suse.de
Subject: [PATCH 2/3] powerpc: implement arch_setup_pdev_archdata
Date: Thu,  5 Aug 2010 10:15:46 -0500
Message-Id: <1281021347-1278-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1281021347-1278-2-git-send-email-galak@kernel.crashing.org>
References: <1281021347-1278-1-git-send-email-galak@kernel.crashing.org>
	<1281021347-1278-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a long standing issues with platform devices not have a valid
dma_mask pointer.  This hasn't been an issue to date as no platform
device has tried to set its dma_mask value to a non-default value.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/platform_device.h |   16 +++++++++++++++-
 1 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/platform_device.h b/arch/powerpc/include/asm/platform_device.h
index 01452c3..a379500 100644
--- a/arch/powerpc/include/asm/platform_device.h
+++ b/arch/powerpc/include/asm/platform_device.h
@@ -1 +1,15 @@
-#include <asm-generic/platform_device.h>
+#ifndef __ASM_PLATFORM_DEVICE_H_
+#define __ASM_PLATFORM_DEVICE_H_
+
+#include <linux/platform_device.h>
+
+#define ARCH_HAS_PDEV_ARCHDATA_SETUP
+
+static inline void arch_setup_pdev_archdata(struct platform_device *pdev)
+{
+	pdev->dev.dma_mask = &pdev->archdata.dma_mask;
+
+	return;
+}
+
+#endif /* __ASM_GENERIC_PLATFORM_DEVICE_H_ */
-- 
1.6.0.6
