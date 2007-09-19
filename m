Return-Path: <ossthema@de.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C48D5DDEA0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 01:40:48 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l8JFeiKB181638
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 15:40:44 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id l8JFeh9m3117224
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 16:40:43 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l8JFebji005664
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 16:40:37 +0100
From: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: [PATCH net-2.6.24] eHEA: poll function update for new NAPI scheme
Date: Wed, 19 Sep 2007 17:40:30 +0200
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200709191740.30640.ossthema@de.ibm.com>
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

Update of ehea_poll function to work with new NAPI scheme.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---
Hi David,

this patch is built upon the patches provided by Mel Gorman
(2.6.23-rc6-mm1: Build failure on ppc64 drivers/net/ehea/ehea_main.c)
and Roland Dreier 
([PATCH net-2.6.24] Fix refcounting problem with netif_rx_reschedule())


 drivers/net/ehea/ehea_main.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index c5fc0b1..1bb39a7 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -609,6 +609,7 @@ static struct ehea_cqe *ehea_proc_cqes(struct ehea_port_res *pr, int my_quota)
 }
 
 #define EHEA_NAPI_POLL_NUM_BEFORE_IRQ 16
+#define EHEA_POLL_MAX_CQES 65535
 
 static int ehea_poll(struct napi_struct *napi, int budget)
 {
@@ -616,15 +617,18 @@ static int ehea_poll(struct napi_struct *napi, int budget)
 	struct net_device *dev = pr->port->netdev;
 	struct ehea_cqe *cqe;
 	struct ehea_cqe *cqe_skb = NULL;
-	int force_irq, wqe_index, rx;
-
-	cqe = ehea_poll_rq1(pr->qp, &wqe_index);
-	cqe_skb = ehea_poll_cq(pr->send_cq);
+	int force_irq, wqe_index;
+	int rx = 0;
 
 	force_irq = (pr->poll_counter > EHEA_NAPI_POLL_NUM_BEFORE_IRQ);
+	cqe_skb = ehea_proc_cqes(pr, EHEA_POLL_MAX_CQES);
+
+	if (!force_irq)
+		rx += ehea_proc_rwqes(dev, pr, budget - rx);
 
-	if ((!cqe && !cqe_skb) || force_irq) {
+	while ((rx != budget) || force_irq) {
 		pr->poll_counter = 0;
+		force_irq = 0;
 		netif_rx_complete(dev, napi);
 		ehea_reset_cq_ep(pr->recv_cq);
 		ehea_reset_cq_ep(pr->send_cq);
@@ -634,19 +638,16 @@ static int ehea_poll(struct napi_struct *napi, int budget)
 		cqe_skb = ehea_poll_cq(pr->send_cq);
 
 		if (!cqe && !cqe_skb)
-			return 0;
+			return rx;
 
 		if (!netif_rx_reschedule(dev, napi))
-			return 0;
-	}
+			return rx;
 
-	rx = ehea_proc_rwqes(dev, pr, budget);
-	cqe = ehea_poll_rq1(pr->qp, &wqe_index);
-	cqe_skb = ehea_proc_cqes(pr, 300);
-
-	if (cqe || cqe_skb)
-		pr->poll_counter++;
+		cqe_skb = ehea_proc_cqes(pr, EHEA_POLL_MAX_CQES);
+		rx += ehea_proc_rwqes(dev, pr, budget - rx);
+	}
 
+	pr->poll_counter++;
 	return rx;
 }
 
-- 
1.5.2
