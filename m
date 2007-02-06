Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 906D2DDF05
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 22:30:47 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l16BUUJX007416
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 04:30:30 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l16BUIxp014599
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Feb 2007 05:30:23 -0600 (CST)
Message-ID: <45C86715.6090600@freescale.com>
Date: Tue, 06 Feb 2007 19:31:33 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: jeff@garzik.org
Subject: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to generic
	iopa
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Get rid of private immrbar_virt_to_phys() routine and
use generic iopa().

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/net/ucc_geth.c |   29 ++++++-----------------------
 1 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 7e4b23c..722a89f 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -3065,21 +3065,11 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
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
@@ -3331,15 +3321,8 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
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
