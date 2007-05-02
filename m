Return-Path: <srinivasa@in.ibm.com>
Received: from ausmtp05.au.ibm.com (ausmtp05.au.ibm.com [202.81.18.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03948DDF72
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 18:14:00 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp05.au.ibm.com (8.13.8/8.13.8) with ESMTP id l428FlAw5398760
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 18:15:47 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l428HSX7132228
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 18:17:28 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l428Duwa029955
	for <linuxppc-dev@ozlabs.org>; Wed, 2 May 2007 18:13:57 +1000
From: Srinivasa Ds <srinivasa@in.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, themann@de.ibm.com, tklein@de.ibm.com
Subject: [PATCH] Build break on ppc64 for 2.6.21-rc7-mm2
Date: Wed, 2 May 2007 13:43:55 +0530
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705021343.55030.srinivasa@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

 When compiling 2.6.21-rc7-mm2, I encountered this error.
 =================================================
  CC [M]  drivers/net/e1000/e1000_ethtool.o
  CC [M]  drivers/net/e1000/e1000_main.o
  LD [M]  drivers/net/e1000/e1000.o
  LD      drivers/net/ehea/built-in.o
  CC [M]  drivers/net/ehea/ehea_main.o
drivers/net/ehea/ehea_main.c: In function ehea_hash_skb:
drivers/net/ehea/ehea_main.c:1806: error: struct sk_buff has no member named 
nh
drivers/net/ehea/ehea_main.c:1807: error: struct sk_buff has no member named 
nh
drivers/net/ehea/ehea_main.c:1807: error: struct sk_buff has no member named 
nh
drivers/net/ehea/ehea_main.c:1809: error: struct sk_buff has no member named 
nh
make[3]: *** [drivers/net/ehea/ehea_main.o] Error 1
make[2]: *** [drivers/net/ehea] Error 2
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2
=================================================

Since code is not compatible with struct sk_buff change, we have this error. 
Below patch should fix this problem. Please let me know your comments on 
this.

Signed-off-by: Srinivasa Ds <srinivasa@in.ibm.com>
---
 drivers/net/ehea/ehea_main.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.21-rc7/drivers/net/ehea/ehea_main.c
===================================================================
--- linux-2.6.21-rc7.orig/drivers/net/ehea/ehea_main.c
+++ linux-2.6.21-rc7/drivers/net/ehea/ehea_main.c
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
