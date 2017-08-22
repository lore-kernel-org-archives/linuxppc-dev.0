Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xc3Kk1TD1zDr54
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 18:16:10 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y129so26801469pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Aug 2017 01:16:10 -0700 (PDT)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] net: ethernet: freescale: fs_enet: make mdiobb_ops const
Date: Tue, 22 Aug 2017 13:45:59 +0530
Message-Id: <1503389759-17545-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make this const as it is only stored in a const field of a
mdiobb_ctrl structure.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
index 1f015ed..c8e5d88 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mii-bitbang.c
@@ -100,7 +100,7 @@ static inline void mdc(struct mdiobb_ctrl *ctrl, int what)
 	in_be32(bitbang->dat);
 }
 
-static struct mdiobb_ops bb_ops = {
+static const struct mdiobb_ops bb_ops = {
 	.owner = THIS_MODULE,
 	.set_mdc = mdc,
 	.set_mdio_dir = mdio_dir,
-- 
1.9.1
