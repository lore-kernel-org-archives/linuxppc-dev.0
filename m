Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2FADDDFA4
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:07:11 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l42E76HT239276
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 14:07:06 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l42E760q2711698
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 15:07:06 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l42E75I7023949
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 15:07:06 +0100
From: Thomas Klein <osstklei@de.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH] ehea: Fix skb header access
Date: Wed, 2 May 2007 16:07:05 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705021607.05338.osstklei@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>,
	Stefan Roscher <ossrosch@linux.vnet.ibm.com>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adapt to new skb header access functions.

Signed-off-by: Thomas Klein <tklein@de.ibm.com>
---


diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
index c7a5614..7211648 100644
--- a/drivers/net/ehea/ehea_main.c
+++ b/drivers/net/ehea/ehea_main.c
@@ -1803,10 +1803,10 @@ static inline int ehea_hash_skb(struct s
 	u32 tmp;
 
 	if ((skb->protocol == htons(ETH_P_IP)) &&
-	    (skb->nh.iph->protocol == IPPROTO_TCP)) {
-		tcp = (struct tcphdr*)(skb->nh.raw + (skb->nh.iph->ihl * 4));
+	    (ip_hdr(skb)->protocol == IPPROTO_TCP)) {
+		tcp = (struct tcphdr*)(skb_network_header(skb) + (ip_hdr(skb)->ihl * 4));
 		tmp = (tcp->source + (tcp->dest << 16)) % 31;
-		tmp += skb->nh.iph->daddr % 31;
+		tmp += ip_hdr(skb)->daddr % 31;
 		return tmp % num_qps;
 	}
 	else
