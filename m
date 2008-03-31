Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D86BDDF28
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:21:38 +1000 (EST)
Date: Mon, 31 Mar 2008 11:17:22 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] fsldma: Use compatiable binding as spec
Message-ID: <Pine.LNX.4.64.0803311115540.5470@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dan.j.williams@intel.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Documentation/powerpc/booting-without-of.txt specifies the
compatiables we should bind to for this driver (elo, eloplus).
Use these instead of the extremely specific 'mpc8540' and 'mpc8349'
compatiables.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Dan, if you don't have any issue with this I'll sent it via the powerpc
tree (since its not really about functionality).

- k

 drivers/dma/fsldma.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 7269230..df16368 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1021,11 +1021,11 @@ const u32 mpc8349_dma_ip_feature = FSL_DMA_IP_83XX | FSL_DMA_LITTLE_ENDIAN;

 static struct of_device_id of_fsl_dma_chan_ids[] = {
 	{
-		.compatible = "fsl,mpc8540-dma-channel",
+		.compatible = "fsl,eloplus-dma-channel",
 		.data = (void *)&mpc8540_dma_ip_feature,
 	},
 	{
-		.compatible = "fsl,mpc8349-dma-channel",
+		.compatible = "fsl,elo-dma-channel",
 		.data = (void *)&mpc8349_dma_ip_feature,
 	},
 	{}
@@ -1107,8 +1107,8 @@ err:
 }

 static struct of_device_id of_fsl_dma_ids[] = {
-	{ .compatible = "fsl,mpc8540-dma", },
-	{ .compatible = "fsl,mpc8349-dma", },
+	{ .compatible = "fsl,eloplus-dma", },
+	{ .compatible = "fsl,elo-dma", },
 	{}
 };

-- 
1.5.4.1
