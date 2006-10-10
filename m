Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0601D67D23
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 07:15:32 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9ALFUkC007922
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 17:15:30 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9ALFTqD518254
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:15:29 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9ALFTPt031286
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 15:15:29 -0600
Date: Tue, 10 Oct 2006 16:15:29 -0500
To: akpm@osdl.org
Subject: [PATCH 16/21]: powerpc/cell spidernet
Message-ID: <20061010211528.GM4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove a dummy register read that is not needed.
This reduces CPU usage notably during transmit.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James K Lewis <jklewis@us.ibm.com>

----
 drivers/net/spider_net.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 13:20:08.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 13:21:41.000000000 -0500
@@ -759,8 +759,6 @@ spider_net_release_tx_chain(struct spide
 	unsigned long flags;
 	int status;
 
-	spider_net_read_reg(card, SPIDER_NET_GDTDMACCNTR);
-
 	while (chain->tail != chain->head) {
 		spin_lock_irqsave(&chain->lock, flags);
 		descr = chain->tail;
