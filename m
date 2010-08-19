Return-Path: <timur@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id 81006B6EE9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Aug 2010 07:28:30 +1000 (EST)
Received: from mail5-va3 (localhost.localdomain [127.0.0.1])	by
	mail5-va3-R.bigfish.com (Postfix) with ESMTP id 2ACD339807F	for
	<linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 21:28:26 +0000 (UTC)
Received: from VA3EHSMHS012.bigfish.com (unknown [10.7.14.238])	by
	mail5-va3.bigfish.com (Postfix) with ESMTP id E571D11C005B	for
	<linuxppc-dev@ozlabs.org>; Thu, 19 Aug 2010 21:28:25 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o7JLSDAa018339	for <linuxppc-dev@ozlabs.org>;
	Thu, 19 Aug 2010 14:28:23 -0700 (MST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
Subject: [PATCH] powerpc/p1022: add probing for individual DMA channels,
	not just DMA controllers
Date: Thu, 19 Aug 2010 16:28:12 -0500
Message-ID: <1282253292-19420-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Like the MPC8610 HPCD, the P1022DS ASoC DMA driver probes on individual DMA
channel nodes, so the DMA controller nodes' compatible string must be listed in
p1022_ds_ids[] to work.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This is for -next.

I don't know why I forgot to include this change in the original P1022DS patch.

 arch/powerpc/platforms/85xx/p1022_ds.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index e1467c9..08446fc 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -112,6 +112,8 @@ static struct of_device_id __initdata p1022_ds_ids[] = {
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
 	{ .compatible = "gianfar", },
+	/* So that the DMA channel nodes can be probed individually: */
+	{ .compatible = "fsl,eloplus-dma", },
 	{},
 };
 
-- 
1.7.0.1
