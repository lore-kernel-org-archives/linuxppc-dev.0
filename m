Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sVxPT4krTzDrpY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 22:30:37 +1000 (AEST)
Message-Id: <cover.1473422536.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 0/3] Optimisation of fs_enet ethernet driver
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Date: Fri,  9 Sep 2016 14:26:18 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This set optimises the freescale fs_enet ethernet driver:
1/ Merge of RX and TX NAPI functions in order to limit the amount of
interrupts
2/ Do not unmap DMA when packets len is below copybreak, otherwise there
is no benefit in copying the skb instead of allocating a new one
3/ Make copybreak value configurable as the optimised value is not the
same on all targets

Christophe Leroy (3):
  net: fs_enet: merge NAPI RX and NAPI TX
  net: fs_enet: don't unmap DMA when packet len is below copybreak
  net: fs_enet: make rx_copybreak value configurable

 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  | 344 +++++++++++----------
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |  16 +-
 drivers/net/ethernet/freescale/fs_enet/mac-fcc.c   |  57 +---
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c   |  57 +---
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c   |  57 +---
 5 files changed, 220 insertions(+), 311 deletions(-)

-- 
2.1.0
