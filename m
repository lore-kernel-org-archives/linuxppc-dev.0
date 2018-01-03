Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBYXb0dggzDqmC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jan 2018 01:41:34 +1100 (AEDT)
To: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] ps3_gelic_net: Delete an error message for a failed memory
 allocation in gelic_descr_prepare_rx()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <9613bfbf-11cc-1e66-484a-84fcda022861@users.sourceforge.net>
Date: Wed, 3 Jan 2018 15:40:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 3 Jan 2018 14:50:59 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/toshiba/ps3_gelic_net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.c b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
index 88d74aef218a..644b875e324c 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.c
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.c
@@ -395,8 +395,6 @@ static int gelic_descr_prepare_rx(struct gelic_card *card,
 	descr->skb = dev_alloc_skb(bufsize + GELIC_NET_RXBUF_ALIGN - 1);
 	if (!descr->skb) {
 		descr->buf_addr = 0; /* tell DMAC don't touch memory */
-		dev_info(ctodev(card),
-			 "%s:allocate skb failed !!\n", __func__);
 		return -ENOMEM;
 	}
 	descr->buf_size = cpu_to_be32(bufsize);
-- 
2.15.1
