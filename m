Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id C08BFDDDE9
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 03:54:28 +1100 (EST)
Date: Fri, 22 Feb 2008 19:54:25 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] sata_fsl: fix build with ATA_VERBOSE_DEBUG
Message-ID: <20080222165425.GA27460@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes build and few warnings when ATA_VERBOSE_DEBUG
is defined:

  CC      drivers/ata/sata_fsl.o
drivers/ata/sata_fsl.c: In function ‘sata_fsl_fill_sg’:
drivers/ata/sata_fsl.c:338: warning: format ‘%x’ expects type ‘unsigned int’, but argument 3 has type ‘void *’
drivers/ata/sata_fsl.c:338: warning: format ‘%x’ expects type ‘unsigned int’, but argument 4 has type ‘struct prde *’
drivers/ata/sata_fsl.c: In function ‘sata_fsl_qc_issue’:
drivers/ata/sata_fsl.c:459: error: ‘csr_base’ undeclared (first use in this function)
drivers/ata/sata_fsl.c:459: error: (Each undeclared identifier is reported only once
drivers/ata/sata_fsl.c:459: error: for each function it appears in.)
drivers/ata/sata_fsl.c: In function ‘sata_fsl_freeze’:
drivers/ata/sata_fsl.c:525: error: ‘csr_base’ undeclared (first use in this function)
make[2]: *** [drivers/ata/sata_fsl.o] Error 1

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/ata/sata_fsl.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 9ac36df..93789bf 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -335,7 +335,7 @@ static unsigned int sata_fsl_fill_sg(struct ata_queued_cmd *qc, void *cmd_desc,
 	dma_addr_t indirect_ext_segment_paddr;
 	unsigned int si;
 
-	VPRINTK("SATA FSL : cd = 0x%x, prd = 0x%x\n", cmd_desc, prd);
+	VPRINTK("SATA FSL : cd = 0x%p, prd = 0x%p\n", cmd_desc, prd);
 
 	indirect_ext_segment_paddr = cmd_desc_paddr +
 	    SATA_FSL_CMD_DESC_OFFSET_TO_PRDT + SATA_FSL_MAX_PRD_DIRECT * 16;
@@ -459,7 +459,8 @@ static unsigned int sata_fsl_qc_issue(struct ata_queued_cmd *qc)
 	VPRINTK("CE=0x%x, DE=0x%x, CC=0x%x, CmdStat = 0x%x\n",
 		ioread32(CE + hcr_base),
 		ioread32(DE + hcr_base),
-		ioread32(CC + hcr_base), ioread32(COMMANDSTAT + csr_base));
+		ioread32(CC + hcr_base),
+		ioread32(COMMANDSTAT + host_priv->csr_base));
 
 	return 0;
 }
@@ -522,7 +523,8 @@ static void sata_fsl_freeze(struct ata_port *ap)
 		ioread32(CQ + hcr_base),
 		ioread32(CA + hcr_base),
 		ioread32(CE + hcr_base), ioread32(DE + hcr_base));
-	VPRINTK("CmdStat = 0x%x\n", ioread32(csr_base + COMMANDSTAT));
+	VPRINTK("CmdStat = 0x%x\n",
+		ioread32(host_priv->csr_base + COMMANDSTAT));
 
 	/* disable interrupts on the controller/port */
 	temp = ioread32(hcr_base + HCONTROL);
-- 
1.5.2.2
