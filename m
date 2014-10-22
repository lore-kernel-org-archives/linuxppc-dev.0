Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 01F761A014C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 18:05:50 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, davem@davemloft.net
Subject: [PATCH] net: fs_enet: set back promiscuity mode after restart
Message-Id: <20141022070547.83AAB1A5E63@localhost.localdomain>
Date: Wed, 22 Oct 2014 09:05:47 +0200 (CEST)
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Germain Montoies <germain.montoies@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After interface restart (eg: after link disconnection/reconnection), the bridge
function doesn't work anymore. This is due to the promiscuous mode being cleared
by the restart.

The mac-fcc already includes code to set the promiscuous mode back during the restart.
This patch adds the same handling to mac-fec and mac-scc.

Tested with bridge function on MPC885 with FEC.

Reported-by: Germain Montoies <germain.montoies@c-s.fr>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

---
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 3 +++
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index 3d4e08b..b34214e 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -341,6 +341,9 @@ static void restart(struct net_device *dev)
 		FC(fecp, x_cntrl, FEC_TCNTRL_FDEN);	/* FD disable */
 	}
 
+	/* Restore multicast and promiscuous settings */
+	set_multicast_list(dev);
+
 	/*
 	 * Enable interrupts we wish to service.
 	 */
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index f30411f..7a184e8 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -355,6 +355,9 @@ static void restart(struct net_device *dev)
 	if (fep->phydev->duplex)
 		S16(sccp, scc_psmr, SCC_PSMR_LPB | SCC_PSMR_FDE);
 
+	/* Restore multicast and promiscuous settings */
+	set_multicast_list(dev);
+
 	S32(sccp, scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
 }
 
-- 
2.1.0
