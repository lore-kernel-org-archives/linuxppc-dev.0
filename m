Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B9571A09C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 05:27:11 +1100 (AEDT)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v3] powerpc/mpc85xx: Add FMan platform support
Date: Wed, 18 Feb 2015 16:04:45 +0200
Message-ID: <1424268285-8491-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>,
 Emilian.Medve@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

Get the FMan devices/sub-nodes (MAC, MDIO, etc.) auto-probed

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 arch/powerpc/platforms/85xx/common.c          |    1 +
 arch/powerpc/platforms/85xx/corenet_generic.c |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 4a9ad87..7bfb9b1 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -40,6 +40,7 @@ static const struct of_device_id mpc85xx_common_ids[] __initconst = {
 	{ .compatible = "fsl,qoriq-pcie-v2.4", },
 	{ .compatible = "fsl,qoriq-pcie-v2.3", },
 	{ .compatible = "fsl,qoriq-pcie-v2.2", },
+	{ .compatible = "fsl,fman", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 63bef30..9824d2c 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -117,6 +117,9 @@ static const struct of_device_id of_device_ids[] = {
 	{
 		.compatible	= "fsl,qe",
 	},
+	{
+		.compatible    = "fsl,fman",
+	},
 	/* The following two are for the Freescale hypervisor */
 	{
 		.name		= "hypervisor",
-- 
1.7.9.5
