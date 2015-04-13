Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E9B151A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 15:40:25 +1000 (AEST)
Resent-Message-ID: <20150413054025.GF20172@voom.fritz.box>
From: David Gibson <david@gibson.dropbear.id.au>
To: anton@au.ibm.com,
	benh@kernel.crashing.org,
	michael@ellerman.id.au
Subject: [PATCH] ibmveth: Fix off-by-one error in ibmveth_change_mtu()
Date: Mon, 13 Apr 2015 15:39:46 +1000
Message-Id: <1428903586-21442-1-git-send-email-david@gibson.dropbear.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

AFAIK the PAPR document which defines the virtual device interface used by
the ibmveth driver doesn't specify a specific maximum MTU.  So, in the
ibmveth driver, the maximum allowed MTU is determined by the maximum
allocated buffer size of 64k (corresponding to one page in the common case)
minus the per-buffer overhead IBMVETH_BUFF_OH (which has value 22 for 14
bytes of ethernet header, plus 8 bytes for an opaque handle).

This suggests a maximum allowable MTU of 65514 bytes, but in fact the
driver only permits a maximum MTU of 65513.  This is because there is a <
instead of an <= in ibmveth_change_mtu(), which only permits an MTU which
is strictly smaller than the buffer size, rather than allowing the buffer
to be completely filled.

This patch fixes the buglet.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 drivers/net/ethernet/ibm/ibmveth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index cd7675a..3aa280a 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1257,7 +1257,7 @@ static int ibmveth_change_mtu(struct net_device *dev, int new_mtu)
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		adapter->rx_buff_pool[i].active = 1;
 
-		if (new_mtu_oh < adapter->rx_buff_pool[i].buff_size) {
+		if (new_mtu_oh <= adapter->rx_buff_pool[i].buff_size) {
 			dev->mtu = new_mtu;
 			vio_cmo_set_dev_desired(viodev,
 						ibmveth_get_desired_dma
-- 
2.1.0
