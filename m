Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDA27DDEFF
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 11:55:54 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1G0tlbg019897
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:55:47 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1G0tiBE060164
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:55:44 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1G0thsc029694
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 19:55:44 -0500
Date: Thu, 15 Feb 2007 18:55:43 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 10/12] spidernet: transmit race
Message-ID: <20070216005543.GJ8192@austin.ibm.com>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45D3EAA7.80805@garzik.org>
	<1171525923.20192.243.camel@localhost.localdomain>
	<200702151141.49708.jens@de.ibm.com>
	<20070215171414.GU923@austin.ibm.com>
	<1171572392.5644.15.camel@localhost.localdomain>
	<20070216001857.GC923@austin.ibm.com>
	<20070216004325.GA8192@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070216004325.GA8192@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org
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
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

----
 drivers/net/spider_net.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Index: linux-2.6.20-git4/drivers/net/spider_net.c
===================================================================
--- linux-2.6.20-git4.orig/drivers/net/spider_net.c	2007-02-15 17:58:54.000000000 -0600
+++ linux-2.6.20-git4/drivers/net/spider_net.c	2007-02-15 18:00:49.000000000 -0600
@@ -803,8 +803,12 @@ spider_net_release_tx_chain(struct spide
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
 
