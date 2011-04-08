Return-Path: <mirq@rere.qmqm.pl>
Received: from rere.qmqm.pl (rere.qmqm.pl [89.167.52.164])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "rere.qmqm.pl", Issuer "rere.qmqm.pl" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 53382B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 22:46:09 +1000 (EST)
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH] net: Remove invalid offloads
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: netdev@vger.kernel.org
Message-Id: <20110408123846.D947E13909@rere.qmqm.pl>
Date: Fri,  8 Apr 2011 14:38:46 +0200 (CEST)
Cc: linuxppc-dev@lists.ozlabs.org, Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove offload changing ethtool ops which drivers don't really support:

 - fs_enet
 - ucc_geth

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/net/fs_enet/fs_enet-main.c |    2 --
 drivers/net/ucc_geth_ethtool.c     |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 24cb953..a938894 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -956,8 +956,6 @@ static const struct ethtool_ops fs_ethtool_ops = {
 	.get_link = ethtool_op_get_link,
 	.get_msglevel = fs_get_msglevel,
 	.set_msglevel = fs_set_msglevel,
-	.set_tx_csum = ethtool_op_set_tx_csum,	/* local! */
-	.set_sg = ethtool_op_set_sg,
 	.get_regs = fs_get_regs,
 };
 
diff --git a/drivers/net/ucc_geth_ethtool.c b/drivers/net/ucc_geth_ethtool.c
index 6f92e48..537fbc0 100644
--- a/drivers/net/ucc_geth_ethtool.c
+++ b/drivers/net/ucc_geth_ethtool.c
@@ -410,7 +410,6 @@ static const struct ethtool_ops uec_ethtool_ops = {
 	.set_ringparam          = uec_set_ringparam,
 	.get_pauseparam         = uec_get_pauseparam,
 	.set_pauseparam         = uec_set_pauseparam,
-	.set_sg                 = ethtool_op_set_sg,
 	.get_sset_count		= uec_get_sset_count,
 	.get_strings            = uec_get_strings,
 	.get_ethtool_stats      = uec_get_ethtool_stats,
-- 
1.7.2.5
