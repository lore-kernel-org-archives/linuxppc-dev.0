Return-Path: <ossthema@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [194.196.100.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F8ED1007D2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 01:35:41 +1000 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id o5FFZajk005760
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 15:35:36 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id o5FFZasP1351742
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:35:36 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id o5FFZZqM010605
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:35:36 +0100
From: "Jan-Bernd Themann" <ossthema@de.ibm.com>
Subject: [PATCH 1/2] ehea: fix delayed packet processing
Date: Tue, 15 Jun 2010 17:35:16 +0200
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201006151735.17258.ossthema@de.ibm.com>
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, tklein@linux.ibm.com,
	Andre Detsch <adetsch@br.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the eHEA poll function an rmb() is required. Without that some packets
on the receive queue are not seen and thus delayed until the next interrupt
is handled for the same receive queue.

Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>

---
Patch created against 2.6.35-rc3

 drivers/net/ehea/ehea_main.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index f547894..fd890fa 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -867,6 +867,7 @@ static int ehea_poll(struct napi_struct *napi, int budget)
 		ehea_reset_cq_ep(pr->send_cq);
 		ehea_reset_cq_n1(pr->recv_cq);
 		ehea_reset_cq_n1(pr->send_cq);
+		rmb();
 		cqe = ehea_poll_rq1(pr->qp, &wqe_index);
 		cqe_skb = ehea_poll_cq(pr->send_cq);
 
-- 
1.7.0
