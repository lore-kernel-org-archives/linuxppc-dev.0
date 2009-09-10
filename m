Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 3C7CCB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 03:58:56 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 6E93EDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 03:58:54 +1000 (EST)
Date: Thu, 10 Sep 2009 21:58:52 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH v2 3/3] ucc_geth: Fix hangs after switching from full to
	half duplex
Message-ID: <20090910175852.GA18948@oksana.dev.rtsoft.ru>
References: <20090910020145.GC31083@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090910020145.GC31083@oksana.dev.rtsoft.ru>
Cc: netdev@vger.kernel.org, Andy Fleming <afleming@freescale.com>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC8360 QE UCC ethernet controllers hang when changing link duplex
under a load (a bit of NFS activity is enough).

  PHY: mdio@e0102120:00 - Link is Up - 1000/Full
  sh-3.00# ethtool -s eth0 speed 100 duplex half autoneg off
  PHY: mdio@e0102120:00 - Link is Down
  PHY: mdio@e0102120:00 - Link is Up - 100/Half
  NETDEV WATCHDOG: eth0 (ucc_geth): transmit queue 0 timed out
  ------------[ cut here ]------------
  Badness at c01fcbd0 [verbose debug info unavailable]
  NIP: c01fcbd0 LR: c01fcbd0 CTR: c0194e44
  ...

The cure is to disable the controller before changing speed/duplex
and enable it afterwards.

Since ugeth_graceful_stop_{tx,rx} now may be called from an atomic
context, switch the two functions from msleep() to mdelay().

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

v2: Switch ugeth_graceful_stop_{tx,rx} to mdelay. Noticed with
    CONFIG_DEBUG_SPINLOCK_SLEEP.

 drivers/net/ucc_geth.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 2a2c973..5a0803f 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -1432,7 +1432,7 @@ static int ugeth_graceful_stop_tx(struct ucc_geth_private *ugeth)
 
 	/* Wait for command to complete */
 	do {
-		msleep(10);
+		mdelay(10);
 		temp = in_be32(uccf->p_ucce);
 	} while (!(temp & UCC_GETH_UCCE_GRA) && --i);
 
@@ -1464,7 +1464,7 @@ static int ugeth_graceful_stop_rx(struct ucc_geth_private *ugeth)
 						ucc_num);
 		qe_issue_cmd(QE_GRACEFUL_STOP_RX, cecr_subblock,
 			     QE_CR_PROTOCOL_ETHERNET, 0);
-		msleep(10);
+		mdelay(10);
 		temp = in_8(&ugeth->p_rx_glbl_pram->rxgstpack);
 	} while (!(temp & GRACEFUL_STOP_ACKNOWLEDGE_RX) && --i);
 
@@ -1631,9 +1631,13 @@ static void adjust_link(struct net_device *dev)
 			ugeth->oldspeed = phydev->speed;
 		}
 
+		ugeth_disable(ugeth, COMM_DIR_RX_AND_TX);
+
 		out_be32(&ug_regs->maccfg2, tempval);
 		out_be32(&uf_regs->upsmr, upsmr);
 
+		ugeth_enable(ugeth, COMM_DIR_RX_AND_TX);
+
 		if (!ugeth->oldlink) {
 			new_state = 1;
 			ugeth->oldlink = 1;
-- 
1.6.3.3
