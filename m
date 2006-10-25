Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AAE5E67C35
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 22:01:23 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id k9PC1DVA128512
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 12:01:13 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k9PC3mGF2109558
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 13:03:48 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k9PC1Cal027545
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 13:01:13 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH 2.6.19-rc3 1/2] ehea: kzalloc GFP_ATOMIC fix
Date: Wed, 25 Oct 2006 13:11:42 +0200
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200610251311.43009.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes kzalloc parameters (GFP_ATOMIC instead of GFP_KERNEL)

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index eb7d44d..4538c99 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -586,8 +586,8 @@ int ehea_sense_port_attr(struct ehea_por
 	u64 hret;
 	struct hcp_ehea_port_cb0 *cb0;
 
-	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
-	if (!cb0) {
+	cb0 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);   /* May be called via */
+	if (!cb0) {                                  /* ehea_neq_tasklet() */
 		ehea_error("no mem for cb0");
 		ret = -ENOMEM;
 		goto out;
@@ -765,8 +765,7 @@ static void ehea_parse_eqe(struct ehea_a
 
 		if (EHEA_BMASK_GET(NEQE_PORT_UP, eqe)) {
 			if (!netif_carrier_ok(port->netdev)) {
-				ret = ehea_sense_port_attr(
-					port);
+				ret = ehea_sense_port_attr(port);
 				if (ret) {
 					ehea_error("failed resensing port "
 						   "attributes");
@@ -1502,7 +1501,7 @@ static void ehea_promiscuous(struct net_
 	if ((enable && port->promisc) || (!enable && !port->promisc))
 		return;
 
-	cb7 = kzalloc(H_CB_ALIGNMENT, GFP_KERNEL);
+	cb7 = kzalloc(H_CB_ALIGNMENT, GFP_ATOMIC);
 	if (!cb7) {
 		ehea_error("no mem for cb7");
 		goto out;
@@ -1606,7 +1605,7 @@ static void ehea_add_multicast_entry(str
 	struct ehea_mc_list *ehea_mcl_entry;
 	u64 hret;
 
-	ehea_mcl_entry = kzalloc(sizeof(*ehea_mcl_entry), GFP_KERNEL);
+	ehea_mcl_entry = kzalloc(sizeof(*ehea_mcl_entry), GFP_ATOMIC);
 	if (!ehea_mcl_entry) {
 		ehea_error("no mem for mcl_entry");
 		return;
