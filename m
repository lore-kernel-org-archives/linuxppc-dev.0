Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 27AE0B71CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 11:03:47 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 58ACBDDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 11:03:46 +1000 (EST)
Date: Thu, 25 Jun 2009 05:02:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH v2 2/2] gianfar: Fix half-duplex operation for non-MII/RMII
	interfaces
Message-ID: <20090625010238.GB28590@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Andy Fleming <afleming@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It appears that gianfar driver has the same problem with RGMII
half-duplex mode as ucc_geth.

NFS boot using 10/half link takes about 10 minutes to complete:

  eth0: Gianfar Ethernet Controller Version 1.2, 00:11:22:33:44:55
  eth0: Running with NAPI enabled
  eth0: 256/256 RX/TX BD ring size
  [...]
  Sending DHCP requests .
  PHY: mdio@e0024520:02 - Link is Up - 10/Half
  ., OK
  [...]
  Looking up port of RPC 100003/2 on 10.0.0.2
  Looking up port of RPC 100005/1 on 10.0.0.2
  VFS: Mounted root (nfs filesystem) readonly on device 0:11.
  Freeing unused kernel memory: 188k init
  nfs: server 10.0.0.2 not responding, still trying
  nfs: server 10.0.0.2 OK
  nfs: server 10.0.0.2 not responding, still trying
  nfs: server 10.0.0.2 not responding, still trying
  nfs: server 10.0.0.2 not responding, still trying
  [... few minutes of OK/not responding flood ...]

And just as with ucc_geth, statistic shows errors:

  # ethtool -S eth0 | grep -v ": 0"
  NIC statistics:
       rx-dropped-by-kernel: 2
       tx-rx-64-frames: 49
       tx-rx-65-127-frames: 1270
       tx-rx-128-255-frames: 9992
       tx-rx-256-511-frames: 75
       tx-rx-512-1023-frames: 142
       tx-rx-1024-1518-frames: 8828
       rx-bytes: 13299414
       rx-packets: 13122
       rx-jabber-frames: 9
       tx-byte-counter: 1284847
       tx-packets: 8115
       tx-broadcast-packets: 3
       tx-deferral-packets: 43
       tx-single-collision-packets: 15
       tx-multiple-collision-packets: 301
       tx-late-collision-packets: 872
       tx-total-collision: 999
       tx-undersize-frames: 6

The symptoms were observed on MPC8379E-RDB boards (eTSEC). Although
I didn't find where documentation forbids clearing Full Duplex bit
for non-MII/RMII modes, it's pretty distinct that the bit should be
set for RGMII.

It's no wonder though, QE Ethernet and TSEC are pretty similar.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 drivers/net/gianfar.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index 8741bb0..503b455 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -1984,13 +1984,18 @@ static void adjust_link(struct net_device *dev)
 	if (phydev->link) {
 		u32 tempval = gfar_read(&regs->maccfg2);
 		u32 ecntrl = gfar_read(&regs->ecntrl);
+		phy_interface_t phyi = phydev->interface;
 
 		/* Now we make sure that we can be in full duplex mode.
 		 * If not, we operate in half-duplex mode. */
 		if (phydev->duplex != priv->oldduplex) {
 			new_state = 1;
-			if (!(phydev->duplex))
-				tempval &= ~(MACCFG2_FULL_DUPLEX);
+			if (!phydev->duplex &&
+					(phyi == PHY_INTERFACE_MODE_MII ||
+					 phyi == PHY_INTERFACE_MODE_RMII ||
+					 (phyi == PHY_INTERFACE_MODE_GMII &&
+					  phydev->speed < 1000)))
+				tempval &= ~MACCFG2_FULL_DUPLEX;
 			else
 				tempval |= MACCFG2_FULL_DUPLEX;
 
-- 
1.6.3.1
