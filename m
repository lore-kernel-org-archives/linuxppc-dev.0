Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtl8F4ffxzDrWB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 15:58:52 +1000 (AEST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: leoli@freescale.com, netdev@vger.kernel.org, christophe.leroy@c-s.fr
Cc: linuxppc-dev@lists.ozlabs.org,
 Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH v2] net/ethernet/freescale: fix warning for ucc_geth
Date: Fri, 15 Sep 2017 07:58:47 +0200
Message-Id: <20170915055847.29716-1-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

uf_info.regs is resource_size_t i.e. phys_addr_t that can be either u32
or u64 according to CONFIG_PHYS_ADDR_T_64BIT.

The printk format is thus adaptet to u64 and the regs value cast to u64
to take both u32 and u64 into account.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index f77ba9fa257b..a96b838cffce 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3857,8 +3857,9 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	}
 
 	if (netif_msg_probe(&debug))
-		pr_info("UCC%1d at 0x%8x (irq = %d)\n",
-			ug_info->uf_info.ucc_num + 1, ug_info->uf_info.regs,
+		pr_info("UCC%1d at 0x%8llx (irq = %d)\n",
+			ug_info->uf_info.ucc_num + 1,
+			(u64)ug_info->uf_info.regs,
 			ug_info->uf_info.irq);
 
 	/* Create an ethernet device instance */
-- 
2.13.5
