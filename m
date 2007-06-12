Return-Path: <wei.zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 06B64DE1EB
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 18:55:39 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: mporter@kernel.crashing.org
Subject: [PATCH 3/5] Add the platform device support with RapidIO to
	MPC8641HPCN platform.
Date: Tue, 12 Jun 2007 17:02:18 +0800
Message-Id: <11816389402216-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11816389401714-git-send-email-wei.zhang@freescale.com>
References: <11816389393593-git-send-email-wei.zhang@freescale.com>
	<1181638939310-git-send-email-wei.zhang@freescale.com>
	<11816389401714-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the platform device support with RapidIO to MPC8641HPCN platform.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 7034bca..f0ca5b3 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -28,6 +28,8 @@
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
 #include <asm/i8259.h>
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
 
 #include <asm/mpic.h>
 
@@ -467,3 +469,17 @@ define_machine(mpc86xx_hpcn) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+
+static struct of_device_id mpc86xx_of_ids[] = {
+	{ .type = "soc", },
+	{ .type = "rapidio", },
+	{},
+};
+
+static __init int mpc86xx_of_device_init(void)
+{
+	return of_platform_bus_probe(NULL, mpc86xx_of_ids, NULL);
+}
+
+device_initcall(mpc86xx_of_device_init);
-- 
1.5.1
