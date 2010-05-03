Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EDED9B7D12
	for <linuxppc-dev@ozlabs.org>; Tue,  4 May 2010 07:54:40 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: kumar.gala@freescale.com, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com,
	lrg@slimlogic.co.uk
Subject: [PATCH 1/2] powerpc/8610: add probing for individual DMA channels,
	not just DMA controllers
Date: Mon,  3 May 2010 16:54:15 -0500
Message-Id: <1272923655-31807-1-git-send-email-timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A future version of the MPC8610 HPCD's ASoC DMA driver will probe on individual
DMA channel nodes, so the DMA controller nodes' compatible string must be listed
in mpc8610_ids[] for the probe to work.

Also remove the "gianfar" compatible from mpc8610_ids[], since there is no
gianfar (or any other networking device) on the 8610.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Kumar, the ASoC mainters are willing to pick up this patch, but they want an
ACK from you first.  Or, you could pick it up, since by itself it's harmless.

 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 5abe137..018cc67 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -83,7 +83,8 @@ static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "fsl,mpc8610-immr", },
 	{ .compatible = "fsl,mpc8610-guts", },
 	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
+	/* So that the DMA channel nodes can be probed individually: */
+	{ .compatible = "fsl,eloplus-dma", },
 	{}
 };
 
-- 
1.6.5
