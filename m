Return-Path: <emmedve1@emmedve1-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 73B9DDDE3C
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 23:51:37 +1000 (EST)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: akpm@linux-foundation.org, jgarzik@pobox.com, leoli@Freescale.com,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] ucc_geth: Fix build break introduced by commit
	09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
Date: Mon, 15 Oct 2007 08:43:50 -0500
Message-Id: <1192455830-1028-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/net/ucc_geth.c: In function 'ucc_geth_rx':
drivers/net/ucc_geth.c:3483: error: 'dev' undeclared (first use in this function)
drivers/net/ucc_geth.c:3483: error: (Each undeclared identifier is reported only once
drivers/net/ucc_geth.c:3483: error: for each function it appears in.)
make[2]: *** [drivers/net/ucc_geth.o] Error 1

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

Here is a convenient link for the culprit patch: http://git.kernel.org/?p=linux/kernel/git/jgarzik/netdev-2.6.git;a=commit;h=09f75cd7bf13720738e6a196cc0107ce9a5bd5a0

netdev-2.6> scripts/checkpatch.pl 0001-POWERPC-ucc_geth-Fix-build-break-introduced-by-co.patch 
Your patch has no obvious style problems and is ready for submission.

 drivers/net/ucc_geth.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index d00e7d4..bec413b 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -63,7 +63,7 @@
 #define UGETH_MSG_DEFAULT	(NETIF_MSG_IFUP << 1 ) - 1
 
 void uec_set_ethtool_ops(struct net_device *netdev);
-	
+
 static DEFINE_SPINLOCK(ugeth_lock);
 
 static struct {
@@ -3454,9 +3454,12 @@ static int ucc_geth_rx(struct ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
 	u16 length, howmany = 0;
 	u32 bd_status;
 	u8 *bdBuffer;
+	struct net_device * dev;
 
 	ugeth_vdbg("%s: IN", __FUNCTION__);
 
+	dev = ugeth->dev;
+
 	/* collect received buffers */
 	bd = ugeth->rxBd[rxQ];
 
-- 
1.5.3.GIT
