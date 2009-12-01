Return-Path: <benh@ozlabs.org>
To: <linux-ide@vger.kernel.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 01 Dec 2009 18:08:33 +1100
Subject: [PATCH 4/5] libata/sff: Use ops->bmdma_stop instead of
	ata_bmdma_stop()
Message-Id: <20091201070833.CC084B7BD9@ozlabs.org>
Cc: tj@kernel.org, linuxppc-dev@lists.ozlabs.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In libata-sff, ata_sff_post_internal_cmd() directly calls ata_bmdma_stop()
instead of ap->ops->bmdma_stop(). This can be a problem for controllers
that use their own bmdma_stop for which the generic sff one isn't suitable

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/ata/libata-sff.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-work.orig/drivers/ata/libata-sff.c	2009-12-01 17:48:27.000000000 +1100
+++ linux-work/drivers/ata/libata-sff.c	2009-12-01 17:48:48.000000000 +1100
@@ -2384,7 +2384,7 @@ void ata_sff_post_internal_cmd(struct at
 	ap->hsm_task_state = HSM_ST_IDLE;
 
 	if (ap->ioaddr.bmdma_addr)
-		ata_bmdma_stop(qc);
+		ap->ops->bmdma_stop(qc);
 
 	spin_unlock_irqrestore(ap->lock, flags);
 }
