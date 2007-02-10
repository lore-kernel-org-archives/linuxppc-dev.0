Return-Path: <linas@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 09058DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 11:22:08 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1A0M5tT007721
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 19:22:05 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1A0M679157348
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 19:22:06 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1A0M5xm023898
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Feb 2007 19:22:05 -0500
Date: Fri, 9 Feb 2007 18:22:05 -0600
To: jgarzik@pobox.com
Subject: [PATCH 4/5]: spidernet: transmit race
Message-ID: <20070210002205.GD2396@austin.ibm.com>
References: <20070210000128.GJ5616@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070210000128.GJ5616@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, James K Lewis <jklewis@us.ibm.com>,
	Jens Osterkamp <Jens.Osterkamp@de.ibm.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Multiple threads performing a transmit can race into
the spidernet tx ring cleanup code. This puts the 
relevant check under a lock.

Signed-off-by: Linas Vepstas <lins@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

----
 drivers/net/spider_net.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.20-git4/drivers/net/spider_net.c
===================================================================
--- linux-2.6.20-git4.orig/drivers/net/spider_net.c	2007-02-09 17:30:13.000000000 -0600
+++ linux-2.6.20-git4/drivers/net/spider_net.c	2007-02-09 17:37:41.000000000 -0600
@@ -767,8 +767,12 @@ spider_net_release_tx_chain(struct spide
 	unsigned long flags;
 	int status;
 
-	while (chain->tail != chain->head) {
+	while (1) {
 		spin_lock_irqsave(&chain->lock, flags);
+		if (chain->tail == chain->head) {
+			spin_unlock_irqrestore(&chain->lock, flags);
+			return 0;
+		}
 		descr = chain->tail;
 		hwdescr = descr->hwdescr;
 
