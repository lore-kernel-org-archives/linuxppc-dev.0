Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDC27DE029
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 13:11:53 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: jeff@garzik.org
Subject: [PATCH v3] sata_fsl: Fix compile warnings
Date: Wed, 13 May 2009 22:10:50 -0500
Message-Id: <1242270650-27945-1-git-send-email-galak@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We we build with dma_addr_t as a 64-bit quantity we get:

drivers/ata/sata_fsl.c: In function 'sata_fsl_fill_sg':
drivers/ata/sata_fsl.c:340: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'dma_addr_t'

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* v2: fixed extra 'x'
* v3: fixed whitespace issue

 drivers/ata/sata_fsl.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index c2e90e1..5edd654 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -332,13 +332,14 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 		dma_addr_t sg_addr = sg_dma_address(sg);
 		u32 sg_len = sg_dma_len(sg);
 
-		VPRINTK("SATA FSL : fill_sg, sg_addr = 0x%x, sg_len = %d\n",
-			sg_addr, sg_len);
+		VPRINTK("SATA FSL : fill_sg, sg_addr = 0x%llx, sg_len = %d\n",
+			(unsigned long long)sg_addr, sg_len);
 
 		/* warn if each s/g element is not dword aligned */
 		if (sg_addr & 0x03)
 			ata_port_printk(qc->ap, KERN_ERR,
-					"s/g addr unaligned : 0x%x\n", sg_addr);
+					"s/g addr unaligned : 0x%llx\n",
+					(unsigned long long)sg_addr);
 		if (sg_len & 0x03)
 			ata_port_printk(qc->ap, KERN_ERR,
 					"s/g len unaligned : 0x%x\n", sg_len);
-- 
1.6.0.6
