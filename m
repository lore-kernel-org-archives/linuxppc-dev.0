Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>
Subject: [PATCH RFC 2/8] dma: mpc512x: fix start condition in execute()
Date: Fri, 12 Jul 2013 17:26:15 +0200
Message-Id: <1373642781-32631-3-git-send-email-gsi@denx.de>
In-Reply-To: <1373642781-32631-1-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

adjust the conditions how submitted DMA jobs get started: memory transfers
need to get initiated by an explicit software request, all transfers which
involve peripherals need to reference the external requester line

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/dma/mpc512x_dma.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index f90b717..df10a48 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -272,10 +272,12 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
 		mdma->tcd[cid].e_sg = 1;
 
 	switch (cid) {
-	case 26:
+	default:
+		/* peripherals involved, use external request */
 		out_8(&mdma->regs->dmaserq, cid);
 		break;
 	case 32:
+		/* memory transfer, software provided start signal */
 		out_8(&mdma->regs->dmassrt, cid);
 		break;
 	}
-- 
1.7.10.4
