Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D9D50DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 14:18:53 +1100 (EST)
Date: Wed, 31 Dec 2008 14:18:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] net/ehea: bitops work on unsigned longs
Message-Id: <20081231141853.c6d123c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Klein <tklein@de.ibm.com>, Thomas, Christoph, netdev@vger.kernel.org,
	Jan-Bernd Themann <themann@de.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These changes will avoid several warnings when we change u64 to unsigned
long long.

Also, ehea_driver_flags is only used in ehca_main.c

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ehea/ehea.h      |    3 +--
 drivers/net/ehea/ehea_main.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ehea/ehea.h b/drivers/net/ehea/ehea.h
index 9930d5f..6271b94 100644
--- a/drivers/net/ehea/ehea.h
+++ b/drivers/net/ehea/ehea.h
@@ -478,7 +478,7 @@ struct ehea_port {
 	int num_add_tx_qps;
 	int num_mcs;
 	int resets;
-	u64 flags;
+	unsigned long flags;
 	u64 mac_addr;
 	u32 logical_port_id;
 	u32 port_speed;
@@ -510,7 +510,6 @@ void ehea_set_ethtool_ops(struct net_device *netdev);
 int ehea_sense_port_attr(struct ehea_port *port);
 int ehea_set_portspeed(struct ehea_port *port, u32 port_speed);
 
-extern u64 ehea_driver_flags;
 extern struct work_struct ehea_rereg_mr_task;
 
 #endif	/* __EHEA_H__ */
diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index a2f1905..e3131ea 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -99,7 +99,7 @@ MODULE_PARM_DESC(use_lro, " Large Receive Offload, 1: enable, 0: disable, "
 
 static int port_name_cnt;
 static LIST_HEAD(adapter_list);
-u64 ehea_driver_flags;
+static unsigned long ehea_driver_flags;
 struct work_struct ehea_rereg_mr_task;
 static DEFINE_MUTEX(dlpar_mem_lock);
 struct ehea_fw_handle_array ehea_fw_handles;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
