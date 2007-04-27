Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D828EDDF1A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 14:32:08 +1000 (EST)
Date: Fri, 27 Apr 2007 14:32:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] Partialially revert a7edd0e676d51145ae634a2acf7a447e319200fa
Message-Id: <20070427143237.187ce7a6.sfr@canb.auug.org.au>
In-Reply-To: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Due to conflicts with the network drivers tree.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ehea/ehea_main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index d1a8134..0e4042b 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -2320,7 +2320,7 @@ static int ehea_setup_single_port(struct ehea_port *port,
 	struct net_device *dev = port->netdev;
 	struct ehea_adapter *adapter = port->adapter;
 	struct hcp_ehea_port_cb4 *cb4;
-	const u32 *dn_log_port_id;
+	u32 *dn_log_port_id;
 	int jumbo = 0;
 
 	sema_init(&port->port_lock, 1);
@@ -2336,7 +2336,7 @@ static int ehea_setup_single_port(struct ehea_port *port,
 	port->of_dev_node = dn;
 
 	/* Determine logical port id */
-	dn_log_port_id = get_property(dn, "ibm,hea-port-no", NULL);
+	dn_log_port_id = (u32*)get_property(dn, "ibm,hea-port-no", NULL);
 
 	if (!dn_log_port_id) {
 		ehea_error("bad device node: dn_log_port_id=%p",
@@ -2492,7 +2492,7 @@ static int __devinit ehea_probe(struct ibmebus_dev *dev,
 				const struct of_device_id *id)
 {
 	struct ehea_adapter *adapter;
-	const u64 *adapter_handle;
+	u64 *adapter_handle;
 	int ret;
 
 	adapter = kzalloc(sizeof(*adapter), GFP_KERNEL);
@@ -2502,7 +2502,7 @@ static int __devinit ehea_probe(struct ibmebus_dev *dev,
 		goto out;
 	}
 
-	adapter_handle = get_property(dev->ofdev.node, "ibm,hea-handle",
+	adapter_handle = (u64*)get_property(dev->ofdev.node, "ibm,hea-handle",
 					    NULL);
 	if (adapter_handle)
 		adapter->handle = *adapter_handle;
-- 
1.5.1.2
