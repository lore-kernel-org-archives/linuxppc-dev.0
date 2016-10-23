Return-Path: <afleming@gmail.com>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com
 [IPv6:2607:f8b0:4002:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2GMg5rh6zDvNT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 10:48:47 +1100 (AEDT)
Received: by mail-yw0-x241.google.com with SMTP id u124so6186084ywg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 16:48:47 -0700 (PDT)
From: Andy Fleming <afleming@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	scottwood@freescale.com
Cc: aperez@alexperez.com
Subject: [PATCH 3/3] corenet: Switch to of_platform_default_populate
Date: Sun, 23 Oct 2016 18:48:39 -0500
Message-Id: <1477266519-25173-3-git-send-email-afleming@gmail.com>
In-Reply-To: <1477266519-25173-1-git-send-email-afleming@gmail.com>
References: <1477266519-25173-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Many of the embedded powerpc boards use an array of device names
to register the devices from the device tree. Instead, we can use
of_platform_default_populate(), which will iterate through all the root nodes and register them.

Signed-off-by: Andy Fleming <afleming@gmail.com>
---
This is necessary to enable the gpio power/reset pins on the Cyrus board.

I have confirmed that the PCI devices are registered and that the power/reset
drivers are registered (and functional). I also tested USB, and saw the
onboard MMC card report in, so some of the SoC devices are definitely there.

If this doesn't break the other corenet boards, I'd be happy to make the
same change for the other powerpc boards.

 arch/powerpc/platforms/85xx/corenet_generic.c | 49 +--------------------------
 1 file changed, 1 insertion(+), 48 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 1179115..6347f20 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -83,56 +83,9 @@ void __init corenet_gen_setup_arch(void)
 	mpc85xx_qe_init();
 }
 
-static const struct of_device_id of_device_ids[] = {
-	{
-		.compatible	= "simple-bus"
-	},
-	{
-		.compatible	= "mdio-mux-gpio"
-	},
-	{
-		.compatible	= "fsl,fpga-ngpixis"
-	},
-	{
-		.compatible	= "fsl,fpga-qixis"
-	},
-	{
-		.compatible	= "fsl,srio",
-	},
-	{
-		.compatible	= "fsl,p4080-pcie",
-	},
-	{
-		.compatible	= "fsl,qoriq-pcie-v2.2",
-	},
-	{
-		.compatible	= "fsl,qoriq-pcie-v2.3",
-	},
-	{
-		.compatible	= "fsl,qoriq-pcie-v2.4",
-	},
-	{
-		.compatible	= "fsl,qoriq-pcie-v3.0",
-	},
-	{
-		.compatible	= "fsl,qe",
-	},
-	{
-		.compatible    = "fsl,fman",
-	},
-	/* The following two are for the Freescale hypervisor */
-	{
-		.name		= "hypervisor",
-	},
-	{
-		.name		= "handles",
-	},
-	{}
-};
-
 int __init corenet_gen_publish_devices(void)
 {
-	return of_platform_bus_probe(NULL, of_device_ids, NULL);
+	return of_platform_default_populate(NULL, NULL, NULL);
 }
 
 static const char * const boards[] __initconst = {
-- 
1.9.1
