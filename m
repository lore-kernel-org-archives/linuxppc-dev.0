Return-Path: <hannes.hering@linux.vnet.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3BCCEDDE20
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 02:02:40 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.14.3/8.13.8) with ESMTP id n44G2WbQ495392
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 16:02:32 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.2) with
	ESMTP id n44G2WoL2707476
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 17:02:32 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n44G2Vjs031535
	for <linuxppc-dev@ozlabs.org>; Mon, 4 May 2009 17:02:32 +0100
From: Hannes Hering <hannes.hering@linux.vnet.ibm.com>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 2.6.30-rc5] ehea: fix invalid pointer access
Date: Mon, 4 May 2009 18:02:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200905041802.30527.hannes.hering@linux.vnet.ibm.com>
Cc: themann@de.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, ossrosch@linux.vnet.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, osstklei@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes an invalid pointer access in case the receive queue holds no
pointer to the next skb when the queue is empty.

Signed-off-by: Hannes Hering <hering2@de.ibm.com>
Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
---

diff -Nurp -X dontdiff linux-2.6.30-rc4/drivers/net/ehea/ehea.h patched_kernel/drivers/net/ehea/ehea.h
--- linux-2.6.30-rc4/drivers/net/ehea/ehea.h	2009-05-04 09:54:42.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea.h	2009-05-04 10:40:11.000000000 +0200
@@ -40,7 +40,7 @@
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
-#define DRV_VERSION	"EHEA_0100"
+#define DRV_VERSION	"EHEA_0101"
 
 /* eHEA capability flags */
 #define DLPAR_PORT_ADD_REM 1
diff -Nurp -X dontdiff linux-2.6.30-rc4/drivers/net/ehea/ehea_main.c patched_kernel/drivers/net/ehea/ehea_main.c
--- linux-2.6.30-rc4/drivers/net/ehea/ehea_main.c	2009-05-04 09:54:42.000000000 +0200
+++ patched_kernel/drivers/net/ehea/ehea_main.c	2009-05-04 10:40:11.000000000 +0200
@@ -545,14 +545,17 @@ static inline struct sk_buff *get_skb_by
 	x &= (arr_len - 1);
 
 	pref = skb_array[x];
-	prefetchw(pref);
-	prefetchw(pref + EHEA_CACHE_LINE);
+	if (pref) {
+		prefetchw(pref);
+		prefetchw(pref + EHEA_CACHE_LINE);
+
+		pref = (skb_array[x]->data);
+		prefetch(pref);
+		prefetch(pref + EHEA_CACHE_LINE);
+		prefetch(pref + EHEA_CACHE_LINE * 2);
+		prefetch(pref + EHEA_CACHE_LINE * 3);
+	}
 
-	pref = (skb_array[x]->data);
-	prefetch(pref);
-	prefetch(pref + EHEA_CACHE_LINE);
-	prefetch(pref + EHEA_CACHE_LINE * 2);
-	prefetch(pref + EHEA_CACHE_LINE * 3);
 	skb = skb_array[skb_index];
 	skb_array[skb_index] = NULL;
 	return skb;
@@ -569,12 +572,14 @@ static inline struct sk_buff *get_skb_by
 	x &= (arr_len - 1);
 
 	pref = skb_array[x];
-	prefetchw(pref);
-	prefetchw(pref + EHEA_CACHE_LINE);
-
-	pref = (skb_array[x]->data);
-	prefetchw(pref);
-	prefetchw(pref + EHEA_CACHE_LINE);
+	if (pref) {
+		prefetchw(pref);
+		prefetchw(pref + EHEA_CACHE_LINE);
+
+		pref = (skb_array[x]->data);
+		prefetchw(pref);
+		prefetchw(pref + EHEA_CACHE_LINE);
+	}
 
 	skb = skb_array[wqe_index];
 	skb_array[wqe_index] = NULL;
