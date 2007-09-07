Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1F8ADDF29
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 20:44:57 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l87AirTA010126
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 03:44:53 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l87AilIP017097
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 05:44:52 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 4/5] Add of-device and DMA bus support to MPC8641HPCN board.
Date: Fri,  7 Sep 2007 18:53:55 +0800
Message-Id: <11891624391962-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11891624391565-git-send-email-wei.zhang@freescale.com>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<11891624382764-git-send-email-wei.zhang@freescale.com>
	<11891624391565-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds of-device and DMA device bus support
to MPC8641HPCN board.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
---
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index e9eaa07..e141259 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -18,6 +18,7 @@
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
+#include <linux/of_platform.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -444,3 +445,19 @@ define_machine(mpc86xx_hpcn) {
 	.progress		= udbg_progress,
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 };
+
+static struct of_device_id mpc86xx_of_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "fsl,dma", },
+	{},
+};
+
+static __init int mpc86xx_of_device_init(void)
+{
+	if (!machine_is(mpc86xx_hpcn))
+		return 0;
+
+	return of_platform_bus_probe(NULL, mpc86xx_of_ids, NULL);
+}
+
+device_initcall(mpc86xx_of_device_init);
-- 
1.5.2
