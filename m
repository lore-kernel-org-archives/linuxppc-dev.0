Return-Path: <osstklei@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4EC1DDE39
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 22:54:03 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0MBrpBj016852
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 11:53:52 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0MBrpiS2662448
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 12:53:51 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0MBro0U020501
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jan 2007 12:53:51 +0100
From: Thomas Klein <osstklei@de.ibm.com>
Subject: [PATCH 2.6.20-rc5 4/7] ehea: New method to determine number of
	available ports
Date: Mon, 22 Jan 2007 12:53:50 +0100
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701221253.50709.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Stefan Roscher <roscher@de.ibm.com>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <ossrosch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Count OFDT nodes to determine the number of available ports
instead of using the possibly outdated value from the hypervisor

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


 drivers/net/ehea/ehea_main.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)


diff -Nurp -X dontdiff linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.20-rc5/drivers/net/ehea/ehea_main.c	2007-01-19 14:12:31.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2007-01-19 14:15:53.000000000 +0100
@@ -2269,6 +2269,8 @@ static void ehea_tx_watchdog(struct net_
 int ehea_sense_adapter_attr(struct ehea_adapter *adapter)
 {
 	struct hcp_query_ehea *cb;
+	struct device_node *lhea_dn = NULL;
+	struct device_node *eth_dn = NULL;
 	u64 hret;
 	int ret;
 
@@ -2285,7 +2287,18 @@ int ehea_sense_adapter_attr(struct ehea_
 		goto out_herr;
 	}
 
-	adapter->num_ports = cb->num_ports;
+	/* Determine the number of available logical ports
+	 * by counting the child nodes of the lhea OFDT entry
+	 */
+	adapter->num_ports = 0;
+	lhea_dn = of_find_node_by_name(lhea_dn, "lhea");
+	do {
+		eth_dn = of_get_next_child(lhea_dn, eth_dn);
+		if (eth_dn)
+			adapter->num_ports++;
+	} while ( eth_dn );
+	of_node_put(lhea_dn);
+
 	adapter->max_mc_mac = cb->max_mc_mac - 1;
 	ret = 0;
 
