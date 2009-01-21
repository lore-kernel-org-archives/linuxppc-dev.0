Return-Path: <tklein@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78A8FDDED3
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 01:52:53 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id n0LEqkZY174112
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 14:52:46 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with
	ESMTP id n0LEqksP4173834
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 15:52:46 +0100
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n0LEqjnc029812
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 15:52:46 +0100
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 3/3] ehea: Improve driver behaviour in low mem conditions
From: Thomas Klein <tklein@de.ibm.com>
Date: Wed, 21 Jan 2009 15:49:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901211549.41352.tklein@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>, Hannes Hering <hering2@de.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Jan-Bernd Themann <ossthema@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reworked receive queue fill policies to make the driver more tolerant
in low memory conditions.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>

---
diff -Nurp -X dontdiff linux-2.6.29-rc2/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.29-rc2/drivers/net/ehea/ehea_main.c	2009-01-20 17:03:17.000000000 +0100
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2009-01-20 17:03:57.000000000 +0100
@@ -370,8 +370,6 @@ static void ehea_refill_rq1(struct ehea_
 							      EHEA_L_PKT_SIZE);
 			if (!skb_arr_rq1[index]) {
 				pr->rq1_skba.os_skbs = fill_wqes - i;
-				ehea_error("%s: no mem for skb/%d wqes filled",
-					   dev->name, i);
 				break;
 			}
 		}
@@ -387,26 +385,19 @@ static void ehea_refill_rq1(struct ehea_
 	ehea_update_rq1a(pr->qp, adder);
 }
 
-static int ehea_init_fill_rq1(struct ehea_port_res *pr, int nr_rq1a)
+static void ehea_init_fill_rq1(struct ehea_port_res *pr, int nr_rq1a)
 {
-	int ret = 0;
 	struct sk_buff **skb_arr_rq1 = pr->rq1_skba.arr;
 	struct net_device *dev = pr->port->netdev;
 	int i;
 
 	for (i = 0; i < pr->rq1_skba.len; i++) {
 		skb_arr_rq1[i] = netdev_alloc_skb(dev, EHEA_L_PKT_SIZE);
-		if (!skb_arr_rq1[i]) {
-			ehea_error("%s: no mem for skb/%d wqes filled",
-				   dev->name, i);
-			ret = -ENOMEM;
-			goto out;
-		}
+		if (!skb_arr_rq1[i])
+			break;
 	}
 	/* Ring doorbell */
 	ehea_update_rq1a(pr->qp, nr_rq1a);
-out:
-	return ret;
 }
 
 static int ehea_refill_rq_def(struct ehea_port_res *pr,
@@ -435,10 +426,12 @@ static int ehea_refill_rq_def(struct ehe
 		u64 tmp_addr;
 		struct sk_buff *skb = netdev_alloc_skb(dev, packet_size);
 		if (!skb) {
-			ehea_error("%s: no mem for skb/%d wqes filled",
-				   pr->port->netdev->name, i);
 			q_skba->os_skbs = fill_wqes - i;
-			ret = -ENOMEM;
+			if (q_skba->os_skbs == q_skba->len - 2) {
+				ehea_info("%s: rq%i ran dry - no mem for skb",
+					  pr->port->netdev->name, rq_nr);
+				ret = -ENOMEM;
+			}
 			break;
 		}
 		skb_reserve(skb, NET_IP_ALIGN);
@@ -1201,11 +1194,11 @@ static int ehea_fill_port_res(struct ehe
 	int ret;
 	struct ehea_qp_init_attr *init_attr = &pr->qp->init_attr;
 
-	ret = ehea_init_fill_rq1(pr, init_attr->act_nr_rwqes_rq1
-				     - init_attr->act_nr_rwqes_rq2
-				     - init_attr->act_nr_rwqes_rq3 - 1);
+	ehea_init_fill_rq1(pr, init_attr->act_nr_rwqes_rq1
+			       - init_attr->act_nr_rwqes_rq2
+			       - init_attr->act_nr_rwqes_rq3 - 1);
 
-	ret |= ehea_refill_rq2(pr, init_attr->act_nr_rwqes_rq2 - 1);
+	ret = ehea_refill_rq2(pr, init_attr->act_nr_rwqes_rq2 - 1);
 
 	ret |= ehea_refill_rq3(pr, init_attr->act_nr_rwqes_rq3 - 1);
 
