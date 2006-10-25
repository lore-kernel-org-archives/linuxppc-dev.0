Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 2D7E567BB6
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 21:10:33 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k9PBAW3O022530
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 04:10:32 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9PBATxg010472
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 06:10:30 -0500 (CDT)
Message-ID: <453F4652.2070805@freescale.com>
Date: Wed, 25 Oct 2006 19:11:14 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: jgarzik@pobox.com
Subject: [PATCH] ucc_geth: change to use generic address mapping routine
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Private address mapping routine immrbar_virt_to_phys() is removed
from qe_lib. The patch changes ucc_geth driver to use generic routine
iopa().

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/net/ucc_geth.c |   29 ++++++-----------------------
 1 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index b378880..8eb1e94 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3062,21 +3062,11 @@ static int ucc_geth_startup(struct ucc_g
 		endOfRing =
 		    ugeth->p_tx_bd_ring[i] + (ug_info->bdRingLenTx[i] -
 					      1) * sizeof(struct qe_bd);
-		if (ugeth->ug_info->uf_info.bd_mem_part == MEM_PART_SYSTEM) {
-			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
-				 (u32) virt_to_phys(ugeth->p_tx_bd_ring[i]));
-			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
+		out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
+				iopa((unsigned long)ugeth->p_tx_bd_ring[i]));
+		out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
 				 last_bd_completed_address,
-				 (u32) virt_to_phys(endOfRing));
-		} else if (ugeth->ug_info->uf_info.bd_mem_part ==
-			   MEM_PART_MURAM) {
-			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
-				 (u32) immrbar_virt_to_phys(ugeth->
-							    p_tx_bd_ring[i]));
-			out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].
-				 last_bd_completed_address,
-				 (u32) immrbar_virt_to_phys(endOfRing));
-		}
+				iopa((unsigned long)endOfRing));
 	}
 
 	/* schedulerbasepointer */
@@ -3328,15 +3318,8 @@ static int ucc_geth_startup(struct ucc_g
 	/* Setup the table */
 	/* Assume BD rings are already established */
 	for (i = 0; i < ug_info->numQueuesRx; i++) {
-		if (ugeth->ug_info->uf_info.bd_mem_part == MEM_PART_SYSTEM) {
-			out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
-				 (u32) virt_to_phys(ugeth->p_rx_bd_ring[i]));
-		} else if (ugeth->ug_info->uf_info.bd_mem_part ==
-			   MEM_PART_MURAM) {
-			out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
-				 (u32) immrbar_virt_to_phys(ugeth->
-							    p_rx_bd_ring[i]));
-		}
+		out_be32(&ugeth->p_rx_bd_qs_tbl[i].externalbdbaseptr,
+			 iopa((unsigned long)ugeth->p_rx_bd_ring[i]));
 		/* rest of fields handled by QE */
 	}
